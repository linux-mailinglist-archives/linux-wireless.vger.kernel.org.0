Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DED36C0A7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhD0ILt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 04:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhD0ILr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 04:11:47 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E92C061574
        for <linux-wireless@vger.kernel.org>; Tue, 27 Apr 2021 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=07RKmapJWTopIz2gVmzJzG36kGAwBXId0uiyJDLJlZA=; b=QKE+33mVv6Ype/XoL1Jfx2uShW
        a9pMlZl9eLxgXzOwVuCNBwGkznYSA5xN7xmlMd5uS7w5qcUyFvPmbacYwWc5znKHp9DvduMz9qHUk
        a2KOwH+x39ms+yA9LMxPTiNoh8T4fqgYQe732OM/6R1cMYsXPRSQIawxsJi0fBRm5mSg=;
Received: from p4ff13bc6.dip0.t-ipconnect.de ([79.241.59.198] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lbIo7-00077p-VZ; Tue, 27 Apr 2021 10:11:00 +0200
Subject: Re: [PATCH] mac80211: minstrel_ht: fix minstrel_aggr_check for encap
 offload
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <d5303cd9935a9a2f44b76070d191e753895da516.1619489753.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <6d94a83a-c807-13a5-a2aa-d5adb780ba80@nbd.name>
Date:   Tue, 27 Apr 2021 10:10:58 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d5303cd9935a9a2f44b76070d191e753895da516.1619489753.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-04-27 04:20, Ryder Lee wrote:
> Avoid checking ieee80211_hdr to support encap offload.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  net/mac80211/rc80211_minstrel_ht.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
> index ecad9b10984f..02a6648aba54 100644
> --- a/net/mac80211/rc80211_minstrel_ht.c
> +++ b/net/mac80211/rc80211_minstrel_ht.c
> @@ -1180,20 +1180,19 @@ minstrel_downgrade_rate(struct minstrel_ht_sta *mi, u16 *idx, bool primary)
>  static void
>  minstrel_aggr_check(struct ieee80211_sta *pubsta, struct sk_buff *skb)
>  {
> -	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
>  	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
>  	u16 tid;
>  
>  	if (skb_get_queue_mapping(skb) == IEEE80211_AC_VO)
>  		return;
>  
> -	if (unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
> +	if (unlikely(!pubsta->wme))
The ieee80211_is_data_qos check should still be performed for
non-offloaded packets to avoid triggering on management frames.

- Felix
