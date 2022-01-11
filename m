Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8B48A93C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 09:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348859AbiAKIVV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 03:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348845AbiAKIVU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 03:21:20 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52282C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 00:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=74LppIN78kWsgtYa9gWatruyKUpD9I2goC0oUvXXRvA=; b=r7eusmroYUe3aNo4VJF4cwmt5Q
        HnZzRlBvCmVZI7RBnlXXgpz5F6Jz1tzM5oYA63oUwYlBLFaRPevntm4Jltlm+otpKTPy5PlJI/9lO
        AjuNorPk2ybGupFB7pwCpv48Hg7uoPoMlltHNHOPzRdI3/900wFSfUgFPEtlOEu+3GWk=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n7CP5-0000TK-MI; Tue, 11 Jan 2022 09:21:15 +0100
Message-ID: <87571e0b-bbd2-f0e7-51c6-8bb94350c152@nbd.name>
Date:   Tue, 11 Jan 2022 09:21:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 2/5] mt76: rework dma.c to adapt mt7986 changes
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <351271a274dc236f027c58487df6b21c7dbf9fd0.1641886298.git.Bo.Jiao@mediatek.com>
 <73fb8a688cfa53e030492f344f72ef64b4167a36.1641886298.git.Bo.Jiao@mediatek.com>
Content-Language: en-US
In-Reply-To: <73fb8a688cfa53e030492f344f72ef64b4167a36.1641886298.git.Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-01-11 08:51, Bo Jiao wrote:
> From: Bo Jiao <Bo.Jiao@mediatek.com>
> 
> Check ndesc of q_rx to avoid potential hole in iteration.
> This is an intermediate patch to add mt7986 support.
> 
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/dma.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
> index fd4c51b..83f045a 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -660,10 +660,12 @@ mt76_dma_init(struct mt76_dev *dev,
>   		 wiphy_name(dev->hw->wiphy));
>   	dev->napi_dev.threaded = 1;
>   
> -	mt76_for_each_q_rx(dev, i) {
> -		netif_napi_add(&dev->napi_dev, &dev->napi[i], poll, 64);
> -		mt76_dma_rx_fill(dev, &dev->q_rx[i]);
> -		napi_enable(&dev->napi[i]);
> +	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++) {
> +		if (dev->q_rx[i].ndesc) {
Please fix mt76_for_each_q_rx instead. You can simply define it to

for (i = 0; i < ARRAY_SIZE((dev)->q_rx); i++)		\
	if ((dev)->q_rx[i].ndesc)

Thanks,

- Felix

