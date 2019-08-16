Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769CA8F9E5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 06:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfHPE34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 00:29:56 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:56416 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfHPE34 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 00:29:56 -0400
X-Greylist: delayed 1314 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 00:29:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=i4IhJSjxLUQzhoiirqDCeKcDWv4elL/1nNicgosm/R4=;
        b=QV51n/RT0qU82HRQrckNDCPPp9lhVQ0S/ioKe7YfWNhYU3SB1Uoq3IgkNwG7//sPbc+/sXc76UTM1CuSiRW4i1y/McZROX0GZl9nivScBaQE/EsEMVJ1xGqTRQErIe8vImUGx6scojiFFJSsa8RBWr5yDTDlNyzbUTqmZ8m8WMk=;
Subject: Re: [PATCH 2/2] mac80211: add assoc-at support.
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20190809174656.20872-1-greearb@candelatech.com>
 <20190809174656.20872-2-greearb@candelatech.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <0fc19972-385e-084e-144d-d5bf41a21ca5@newmedia-net.de>
Date:   Fri, 16 Aug 2019 06:09:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809174656.20872-2-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f31:fa00:e41f:2151:796d:3095]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1hyTZk-000827-LN; Fri, 16 Aug 2019 06:10:52 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

is this feature neccessary? we already have the information of the assoc 
duration time. so its easy to calculate the assoc timestamp using the 
current time without any patch
do i miss something here?

Am 09.08.2019 um 19:46 schrieb greearb@candelatech.com:
> From: Ben Greear <greearb@candelatech.com>
>
> Report timestamp for when sta becomes associated.
>
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>   net/mac80211/sta_info.c | 3 +++
>   net/mac80211/sta_info.h | 2 ++
>   2 files changed, 5 insertions(+)
>
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index cd88c8872372..f0820f058b5f 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -1995,6 +1995,7 @@ int sta_info_move_state(struct sta_info *sta,
>   	case IEEE80211_STA_ASSOC:
>   		if (sta->sta_state == IEEE80211_STA_AUTH) {
>   			set_bit(WLAN_STA_ASSOC, &sta->_flags);
> +			sta->assoc_at_ms = ktime_to_ms(ktime_get_real());
>   			ieee80211_recalc_min_chandef(sta->sdata);
>   			if (!sta->sta.support_p2p_ps)
>   				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
> @@ -2224,6 +2225,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
>   			 BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
>   			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
>   			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
> +			 BIT_ULL(NL80211_STA_INFO_ASSOC_AT_MS) |
>   			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
>   
>   	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
> @@ -2232,6 +2234,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
>   	}
>   
>   	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
> +	sinfo->assoc_at_ms = sta->assoc_at_ms;
>   	sinfo->inactive_time =
>   		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta));
>   
> diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
> index bb02d5fac7ba..906b11acb0e8 100644
> --- a/net/mac80211/sta_info.h
> +++ b/net/mac80211/sta_info.h
> @@ -468,6 +468,7 @@ struct ieee80211_sta_rx_stats {
>    *	the station when it leaves powersave or polls for frames
>    * @driver_buffered_tids: bitmap of TIDs the driver has data buffered on
>    * @txq_buffered_tids: bitmap of TIDs that mac80211 has txq data buffered on
> + * @assoc_at_ms: time (in ms) of last association
>    * @last_connected: time (in seconds) when a station got connected
>    * @last_seq_ctrl: last received seq/frag number from this STA (per TID
>    *	plus one for non-QoS frames)
> @@ -565,6 +566,7 @@ struct sta_info {
>   	unsigned long driver_buffered_tids;
>   	unsigned long txq_buffered_tids;
>   
> +	unsigned long assoc_at_ms;
>   	long last_connected;
>   
>   	/* Updated from RX path only, no locking requirements */
