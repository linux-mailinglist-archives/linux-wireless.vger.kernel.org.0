Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D149744EF44
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 23:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhKLWd4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 17:33:56 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:37794 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232001AbhKLWdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 17:33:55 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.167])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 940DA2A006D;
        Fri, 12 Nov 2021 22:31:03 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B988F24008F;
        Fri, 12 Nov 2021 22:31:02 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id CC64913C2B0;
        Fri, 12 Nov 2021 14:30:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CC64913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1636756259;
        bh=jBbg+iMiSVZjUwiEZqkgQP0UDjrFJdBZbCEwAvNK2IA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lC43gbTb+JrOpE7tGidib/3kgLw7tMulZZCzbiFcZnsF79Ne3qwipkowaJ5gQ352n
         OxfUtTNMhdCjy1jUakHucwahI4eTdWAIGqCyv4HofdB4d/FVg2AimRUMRanzURfm4x
         f8T1R91gKRCpwU6nS4xp/JJL0cEDlkh0QriksBiQ=
Subject: Re: [PATCH v2 04/11] mt76: mt7915: add firmware support for mt7916
To:     Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <cover.1636105953.git.Bo.Jiao@mediatek.com>
 <694291893593fce99a3ba485fe691e49bd7cf4a7.1636105953.git.Bo.Jiao@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <78e7e6ba-6e70-872f-89e9-2d3d095b145f@candelatech.com>
Date:   Fri, 12 Nov 2021 14:30:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <694291893593fce99a3ba485fe691e49bd7cf4a7.1636105953.git.Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1636756264-Xc2U65JSvLt5
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/5/21 3:02 AM, Bo Jiao wrote:
> From: Bo Jiao <Bo.Jiao@mediatek.com>
> 
> Update firmware initialization for mt7916.
> This is an intermediate patch to add mt7916 support.
> 
> Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt7915/init.c  |  6 --
>   .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 78 +++++++++++++++----
>   .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
>   .../net/wireless/mediatek/mt76/mt7915/pci.c   |  3 +
>   .../net/wireless/mediatek/mt76/mt7915/regs.h  |  5 +-
>   5 files changed, 72 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index f455c12..a4e2d85 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -567,12 +567,6 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
>   
>   	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
>   
> -	/*
> -	 * force firmware operation mode into normal state,
> -	 * which should be set before firmware download stage.
> -	 */
> -	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
> -
>   	ret = mt7915_mcu_init(dev);
>   	if (ret) {
>   		/* Reset and try again */
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index ee9952d..43ddbc1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2713,16 +2713,20 @@ static int mt7915_mcu_start_patch(struct mt7915_dev *dev)
>   				 sizeof(req), true);
>   }
>   
> -static int mt7915_driver_own(struct mt7915_dev *dev)
> +static int mt7915_driver_own(struct mt7915_dev *dev, u8 band)
>   {
> -	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND0, MT_TOP_LPCR_HOST_DRV_OWN);
> -	if (!mt76_poll_msec(dev, MT_TOP_LPCR_HOST_BAND0,
> +	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND(band), MT_TOP_LPCR_HOST_DRV_OWN);
> +	if (!mt76_poll_msec(dev, MT_TOP_LPCR_HOST_BAND(band),
>   			    MT_TOP_LPCR_HOST_FW_OWN_STAT,

I think that MT_TOP_LPCR_HOST_FW_OWN_STAT is not defined in the upstream kernel...

Maybe a patch from owrt was not added to upstream yet?

Thanks,
Ben



-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

