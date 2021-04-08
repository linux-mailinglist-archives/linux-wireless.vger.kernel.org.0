Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DE13582DB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhDHMGv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhDHMGu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 08:06:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA27DC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 05:06:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUTQk-008zVE-3t; Thu, 08 Apr 2021 14:06:38 +0200
Message-ID: <7f6f0a8c151746e8bb44ad50daf75259a0fac829.camel@sipsolutions.net>
Subject: Re: [PATCH v9 2/4] mac80211: add multiple bssid support to
 interface handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Date:   Thu, 08 Apr 2021 14:06:37 +0200
In-Reply-To: <20210310182604.8858-3-alokad@codeaurora.org> (sfid-20210310_192729_241525_2DF37B20)
References: <20210310182604.8858-1-alokad@codeaurora.org>
         <20210310182604.8858-3-alokad@codeaurora.org>
         (sfid-20210310_192729_241525_2DF37B20)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-03-10 at 10:26 -0800, Aloka Dixit wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add a new helper ieee80211_set_multiple_bssid_options() takes propagating
> the cfg80211 data down the stack.
> 
> The patch also makes sure that all members of the bss set will get closed
> when either of them is shutdown.

s/either/any/
> 
>  static int ieee80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
>  {
> +	struct ieee80211_sub_if_data *sdata;
> +
> +	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);

can be one line

> +	if (sdata && sdata->vif.type == NL80211_IFTYPE_AP) {
> +		if (sdata->vif.multiple_bssid.flags & IEEE80211_VIF_MBSS_TRANSMITTING) {
> +			struct ieee80211_sub_if_data *child;
> +
> +			rcu_read_lock();
> +			list_for_each_entry_rcu(child, &sdata->local->interfaces, list)
> +				if (child->vif.multiple_bssid.parent == &sdata->vif)
> +					dev_close(child->wdev.netdev);
> +			rcu_read_unlock();

You never tested this properly, this is wrong.

johannes

