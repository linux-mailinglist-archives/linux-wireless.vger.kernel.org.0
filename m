Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C0271A88
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 07:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIUFwb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 01:52:31 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46266 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbgIUFwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 01:52:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 123DA4F9B64;
        Mon, 21 Sep 2020 05:52:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9X4sIG438GQo; Mon, 21 Sep 2020 05:52:28 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 742434F9809;
        Mon, 21 Sep 2020 05:52:28 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 20 Sep 2020 22:52:27 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 13/22] cfg80211: handle Association Response from S1G
 STA
In-Reply-To: <5025b542741e18d0f329b5a1f5d110fd6a1eeae0.camel@sipsolutions.net>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
 <20200831205600.21058-14-thomas@adapt-ip.com>
 <5025b542741e18d0f329b5a1f5d110fd6a1eeae0.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <3c9d0c4d8a16d9777db112f72cf13cef@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 03:50, Johannes Berg wrote:
> On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
>> 
>> +	/* Detect whether this was an S1G Association Response and adjust IE
>> +	 * location accordingly.
>> +	 */
>> +	rcu_read_lock();
>> +	ies = rcu_dereference(bss->ies);
>> +	if (WARN_ON(!ies)) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +	s1g = cfg80211_find_ie(WLAN_EID_S1G_CAPABILITIES, ies->data, 
>> ies->len);
>> +	if (s1g) {
>> +		cr.resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
>> +		cr.resp_ie_len =
>> +			len - offsetof(struct ieee80211_mgmt,
>> +				       u.s1g_assoc_resp.variable);
>> +	}
>> +	rcu_read_unlock();
> 
> That ... is rather strange?
> 
> Why not check bss->channel->band?

Thanks! That saves a lot of work :)

-- 
thomas
