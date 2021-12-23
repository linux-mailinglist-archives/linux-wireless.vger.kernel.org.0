Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CD47E128
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 11:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347650AbhLWKND (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 05:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347649AbhLWKNC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 05:13:02 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C09C061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 02:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ruc8+BH/rRhQUbW0InbtepiuS0NDPfc+6sJRs3wHkIA=; b=h+PfwBuCnl9ztSGj3Jn80RkJ3q
        8Z9grzxSBeWmmfKz/7xeNWF2QbZwRF2me5Ic8aHHzU0UvXOcgULJXoPJSBNreQX9bQqMhKqUJl80G
        FWO4jxDssHGSRlIlT2qdEEiJ/eoAsgTZrCq0eJc/jjeV72qBgPvLN3VUpFTRjYmahrsA=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n0L5n-0007Ol-3q; Thu, 23 Dec 2021 11:12:59 +0100
Message-ID: <2b376af1-28e8-ea3e-ddb2-c300cc52a40f@nbd.name>
Date:   Thu, 23 Dec 2021 11:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] mt76: mt7915: fix warning: variable 'flags' set but not
 used
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20211223065843.94919-1-bo.jiao@mediatek.com>
Content-Language: en-US
In-Reply-To: <20211223065843.94919-1-bo.jiao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-12-23 07:58, Bo Jiao wrote:
> From: Bo Jiao <Bo.Jiao@mediatek.com>
> 
> fix warning: variable 'flags' set but not used
> 
> Fixes: 0aa6b534b5e1 ("mt76: mt7915: update rx rate reporting for mt7916")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> index ee4535a..f6d6321 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -469,7 +469,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
>   			__le32 *rxv)
>   {
>   	u32 v0, v2;
> -	u8 flags, stbc, gi, bw, dcm, mode, nss;
> +	u8 stbc, gi, bw, dcm, mode, nss;
>   	int i, idx;
>   	bool cck = false;
>   
> @@ -505,20 +505,12 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
>   		status->encoding = RX_ENC_HT;
>   		if (i > 31)
>   			return -EINVAL;
> -
> -		flags = RATE_INFO_FLAGS_MCS;
> -		if (gi)
> -			flags |= RATE_INFO_FLAGS_SHORT_GI;
>   		break;
>   	case MT_PHY_TYPE_VHT:
>   		status->nss = nss;
>   		status->encoding = RX_ENC_VHT;
>   		if (i > 9)
>   			return -EINVAL;
> -
> -		flags = RATE_INFO_FLAGS_VHT_MCS;
> -		if (gi)
> -			flags |= RATE_INFO_FLAGS_SHORT_GI;
>   		break;
>   	case MT_PHY_TYPE_HE_MU:
>   	case MT_PHY_TYPE_HE_SU:
The short GI value should still be reported. I'm folding this change 
into the commit:

--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -503,12 +503,16 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
   	case MT_PHY_TYPE_HT_GF:
   	case MT_PHY_TYPE_HT:
   		status->encoding = RX_ENC_HT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
   		if (i > 31)
   			return -EINVAL;
   		break;
   	case MT_PHY_TYPE_VHT:
   		status->nss = nss;
   		status->encoding = RX_ENC_VHT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
   		if (i > 9)
   			return -EINVAL;
   		break;


