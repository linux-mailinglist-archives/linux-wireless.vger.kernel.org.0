Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB02F5EAD
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 11:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbhANKY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 05:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbhANKY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 05:24:56 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED27C061573
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 02:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lbn6cYCk9/muYNK6QM9qsrM6esnGSsnu6m/z0AGuWLw=; b=LUS3TKKsfynbqt6gqpfWzogLg6
        /1F7pqWim0z+f04zNnWgrs3c5GCD4pAZ3J3ko3NkVkjr9s1EDXcfQ0mj4DT3Xs1yRCzy39pCJkRW0
        a5GsRtLoR++p0+6/JsB+AAzZqeW8uv+TMfa+VRnCvXFd6yqcixEc7cfG6C+smnHeuwbw=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kzznJ-00072a-6U; Thu, 14 Jan 2021 11:23:57 +0100
Subject: Re: [PATCH 3/4] mt76: mt7915: add support for continuous tx in
 testmode
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20210105113045.17815-1-shayne.chen@mediatek.com>
 <20210105113045.17815-3-shayne.chen@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <926cb2f7-e66f-6804-a0ff-5fbd62193c59@nbd.name>
Date:   Thu, 14 Jan 2021 11:23:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210105113045.17815-3-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-01-05 12:30, Shayne Chen wrote:
> Implement continuous tx state for MT7915 NIC testmode.
> 
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   3 +-
>  .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   1 +
>  .../wireless/mediatek/mt76/mt7915/testmode.c  | 160 ++++++++++++++++--
>  .../wireless/mediatek/mt76/mt7915/testmode.h  |  40 +++++
>  4 files changed, 192 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> index e5af42c70e12..68b170308c4a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> @@ -469,15 +475,144 @@ static void
>  mt7915_tm_set_rx_frames(struct mt7915_phy *phy, bool en)
>  {
>  	struct mt7915_dev *dev = phy->dev;
> -	if (en) {
> -		mutex_unlock(&dev->mt76.mutex);
> -		mt7915_set_channel(phy);
> -		mutex_lock(&dev->mt76.mutex);
> +	if (en)
> +		mt7915_tm_update_channel(phy);
> +
> +	mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, en);
This leaves dev as an unused variable. I'll fix it up locally.

- Felix
