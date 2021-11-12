Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3571B44E5BC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 12:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhKLLwR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 06:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhKLLwQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 06:52:16 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C45AC061766
        for <linux-wireless@vger.kernel.org>; Fri, 12 Nov 2021 03:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aPu9bJ2jZ0pubJHiaKKzG7VSJ4NPO4ZFlM3h75YeXAc=; b=NQ3fFLmgkhDFDeHxmxVW/DQ0NU
        68SgwFb3Y/YepfV0k85KYYpxGVX6YC2I5EqYtU6gnAdXG2o0DNTKCRMVKA2Lk5bW0UTLX/Kq3feSi
        /EAK8QWT3sVx49E0ssLRHhhSbJ82HjsCkSH1mADLkim5OtTY5EOZ7uGLcTdiFYLua7gg=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mlV3Z-0003R5-Hf; Fri, 12 Nov 2021 12:49:21 +0100
Message-ID: <36a7513b-2912-f46f-1a88-a07946ef703f@nbd.name>
Date:   Fri, 12 Nov 2021 12:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] mt76: testmode: add support to set MAC
Content-Language: en-US
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20211109040830.27536-1-shayne.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20211109040830.27536-1-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-11-09 05:08, Shayne Chen wrote:
> Add support to set SA/DA/BSSID in testmode.
> During mass production stage, some test scripts or test equipments need
> to set fixed addresses to detect or parse if a test is passed.
> Also, MAC setting is necessary for some tx/rx tests with rx filter,
> to make sure rx site only receives expected packets.
> 
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
>   drivers/net/wireless/mediatek/mt76/testmode.c | 36 +++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/testmode.h |  4 +++
>   3 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index e2da720..e7ced94 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -599,6 +599,8 @@ struct mt76_testmode_data {
>   	u8 tx_power[4];
>   	u8 tx_power_control;
>   
> +	u8 addr[3][ETH_ALEN];
> +
>   	u32 tx_pending;
>   	u32 tx_queued;
>   	u16 tx_queued_limit;
> diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
> index 66afc2b..74621b9 100644
> --- a/drivers/net/wireless/mediatek/mt76/testmode.c
> +++ b/drivers/net/wireless/mediatek/mt76/testmode.c
> @@ -126,9 +126,9 @@ int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len)
>   
>   	hdr = __skb_put_zero(head, head_len);
>   	hdr->frame_control = cpu_to_le16(fc);
> -	memcpy(hdr->addr1, phy->macaddr, sizeof(phy->macaddr));
> -	memcpy(hdr->addr2, phy->macaddr, sizeof(phy->macaddr));
> -	memcpy(hdr->addr3, phy->macaddr, sizeof(phy->macaddr));
> +	ether_addr_copy(hdr->addr1, td->addr[0]);
> +	ether_addr_copy(hdr->addr2, td->addr[1]);
> +	ether_addr_copy(hdr->addr3, td->addr[2]);
ether_addr_copy assumes that source and destination are u16 aligned. I'm 
not sure that's guaranteed for td->addr.
I think you either need to stick to memcpy or make the alignment of 
td->addr explicit.

- Felix
