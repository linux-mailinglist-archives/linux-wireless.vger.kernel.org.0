Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA097311
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfHUHL0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 03:11:26 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56412 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfHUHL0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 03:11:26 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0KmB-000439-Ng; Wed, 21 Aug 2019 09:11:23 +0200
Message-ID: <d861ba9e492cf516dc662d75cd9c24368fadf27a.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] nl80211: AP deauthentication flooding.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 09:11:22 +0200
In-Reply-To: <1566336839-11508-1-git-send-email-b.balakrishna@globaledgesoft.com>
References: <1566336839-11508-1-git-send-email-b.balakrishna@globaledgesoft.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-08-21 at 03:03 +0530, Balakrishna Bandi wrote:
> AP sends deauth per each data frame to STA which is not associated to
> AP. Non associated STA keeps on sending data frame and leads to deauth
> flooding.

Yeah. I've sort of vaguely known about this issue, but never got around
to it. Thanks.

> Fix to be sending at-most single deauth per second if AP receive data frame from
> non-associated STA.

Can you please add to the commit message why this should be done in the
kernel? I have a feeling that perhaps pushing out all those nl80211
events might also overwhelm hostapd etc. but it'd be good to state this
here.

> +/**
> + * This timer will check for expired node and it will delete that node.
> + * Timer will run for every 10 seconds till list is empty.
> + **/

This isn't kernel-doc so the ** should just be *.

> +void cfg80211_non_assoc_sta_timer_wk(struct work_struct *work)
> +{
> +	struct delayed_work *delayed_work = to_delayed_work(work);
> +	struct cfg80211_non_assoc_stas_info *uk_stas_info;

What should "uk" mean here? Doesn't seem very obvious to me?

> +	struct cfg80211_non_assoc_single_sta_info *sta, *tsta;
> +
> +	uk_stas_info = container_of(delayed_work,
> +			struct cfg80211_non_assoc_stas_info, sta_update_timer);
> +
> +	if (list_empty(&uk_stas_info->non_assoc_sta_list))
> +		return;
> +
> +	spin_lock(&uk_stas_info->sta_lock);

This quite likely needs to be spin_lock_bh() since you're in a worker
(process context) here, but the RX path may be in a tasklet.

> +	list_for_each_entry_safe(sta, tsta,
> +	 &uk_stas_info->non_assoc_sta_list, list) {
> +	/* Clearing the node if we didn't receive any packet within 4 seconds */
> +	    if (time_before(sta->last_rx_pkt +
> +	     (CFG80211_NON_ASSOC_MIN_CACHE_UPDATE * HZ), jiffies)) {
> +	        list_del(&sta->list);
> +	        kfree(sta);
> +	    }
> +	}

You have a lot of coding style issues in this patch, please run
checkpatch and address those.

> +static void cfg80211_non_assoc_sta_info_alloc(
> +	                struct cfg80211_registered_device *rdev)
> +{
> +	rdev->non_assoc_stas_info = kzalloc(
> +	    sizeof(struct cfg80211_non_assoc_stas_info), GFP_KERNEL);
> +	if (!rdev->non_assoc_stas_info)
> +		return;


I think you should just embed the struct instead of allocating it.

> +	struct cfg80211_non_assoc_stas_info *non_assoc_stas_info;

Here I mean, just make that the struct itself rather than a pointer,
there's no value in the extra allocation since it's always done anyway.

> +struct cfg80211_non_assoc_single_sta_info {
> +       u8 address[ETH_ALEN];
> +       u16 count;
> +       unsigned long last_rx_pkt;
> +       struct list_head list;
> +};

I don't think you need the count?

> +struct cfg80211_non_assoc_single_sta_info * cfg80211_find_non_assoc_sta_entry(
> +	struct cfg80211_non_assoc_stas_info *uk_stas_info, const u8 *addr)
> +{
> +	struct cfg80211_non_assoc_single_sta_info *sta, *find_sta = NULL;
> +
> +	spin_lock(&uk_stas_info->sta_lock);
> +	list_for_each_entry(sta, &uk_stas_info->non_assoc_sta_list, list) {
> +	    if (ether_addr_equal(addr, sta->address)) {

We really should use a hashtable here, this linear list walk is going to
be an attack vector itself. I'd say rhashtable is a good idea.

> +	/* If we didn't find the station, creating new node. Else, updating the time */

Also, we need to limit the # of entries in this list (which should be a
hashtable).

The interesting question is what we should do if we overflow our
hashtable limit (i.e. the max # of stations we're willing to have
there).

Arguably, this constitutes an attack scenario, and in that case we
should just start dropping things completely, i.e. not respond with
deauth even if we *don't* have an entry in the hashtable.


Btw, we have similar patterns elsewhere (e.g. RX of data frames in IBSS
where we'd like to send probe requests, not deauth), so we should
probably expose the struct, init functionality and some helpers in
cfg80211.h so we can use it elsewhere in a general fashion.


> +	if (sta) {
> +	/* Checking pkt is received within second. If we didn't update, sending deauth packet */
> +	    if (time_after(sta->last_rx_pkt + HZ, jiffies))
> +	        deauth = false;
> +	    else
> +	        sta->last_rx_pkt = jiffies;

Not sure I understand this - wouldn't we just always suppress the event
to userspace (btw, we don't actually send the deauth, so you should
adjust the comments here, we send the event to userspace) if we have an
entry, and expire the entry after ~1s? Why keep the entries alive for
longer than that?

Or maybe not - you keep the entries alive, but send the event up even if
the entry is alive, but didn't actually cause an event in the past
second, I guess?

Maybe that one second should also be a bit less? Yeah, we don't want to
flood, but keeping the station waiting for a second if it got
desynchronized feels a bit long?

> +	} else {
> +	    sta = kzalloc(sizeof
> +	     (struct cfg80211_non_assoc_single_sta_info), GFP_ATOMIC);
> +	    if (sta == NULL)
> +	        return true;

Also, you should put all those return paths go through a common place
and still call the tracing, not just in the case where we actually send
the event.

> +	    memcpy(sta->address, addr, ETH_ALEN);
> +	    spin_lock(&rdev->non_assoc_stas_info->sta_lock);
> +	    list_add(&sta->list,
> +	        &rdev->non_assoc_stas_info->non_assoc_sta_list);
> +	    spin_unlock(&rdev->non_assoc_stas_info->sta_lock);
> +	    sta->last_rx_pkt = jiffies;
> +	}
> +
> +	sta->count++;
> +
> +	if (run_timer)
> +	    schedule_delayed_work(
> +	        &rdev->non_assoc_stas_info->sta_update_timer,
> +	        CFG80211_NON_ASSOC_FILTER_TIMER_INT * HZ);

You don't really need the "run_timer" variable, you can just trigger the
timer at the beginning? In the unlikely event that you have an
allocation failure here, you'd run the time once too much, but that
seems acceptable to me, the allocation is very unlikely to fail.

johannes

