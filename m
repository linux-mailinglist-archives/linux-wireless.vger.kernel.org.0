Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F95F4955F8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jan 2022 22:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377928AbiATVa2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jan 2022 16:30:28 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:59986 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377923AbiATVa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jan 2022 16:30:26 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.122])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EF5B52007F;
        Thu, 20 Jan 2022 21:30:23 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4047940076;
        Thu, 20 Jan 2022 21:30:23 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B6D6213C35B;
        Thu, 20 Jan 2022 13:29:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B6D6213C35B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1642714197;
        bh=wWAFAxJF0zSOqb6KEtOQDHZ7mZGvdgkvvMEky74Df98=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sRRbSEwIrDPlQfY3d8I95lcpEVwx34qv7gWNbi/5oJlo/ds8E7yDSFS2CAMZI64Aw
         l9iABZgNnsRHbZ8XEpSEDt0dUWqEat6gm24Q9eeoSfgAijTvADC1YbYiGG3lBdICL8
         WuHYPM2lTZAVBVZiF+MIMWTGIfDCH7YAgITGiXbk=
Subject: Re: [PATCH v4 05/12] mt76: mt7915: add firmware support for mt7916
To:     Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <cover.1639965732.git.Bo.Jiao@mediatek.com>
 <6b2d86cbbe6426a5ed0d91b8248b95ac3390885f.1639965732.git.Bo.Jiao@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <edd5b78c-5277-e192-b404-1b771e1a5242@candelatech.com>
Date:   Thu, 20 Jan 2022 13:29:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6b2d86cbbe6426a5ed0d91b8248b95ac3390885f.1639965732.git.Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1642714224-FtK0ZQ9pkwJ8
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/19/21 6:17 PM, Bo Jiao wrote:
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
> v3:
> - modify the function mt7915_wfsys_reset to support mt7916
> ---
>   .../net/wireless/mediatek/mt76/mt7915/init.c  | 75 ++++++++---------
>   .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 81 +++++++++++++++----
>   .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
>   .../net/wireless/mediatek/mt76/mt7915/pci.c   |  3 +
>   .../net/wireless/mediatek/mt76/mt7915/regs.h  |  6 +-
>   5 files changed, 115 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index 2da342d..edf0d7e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -511,41 +511,53 @@ static void mt7915_init_work(struct work_struct *work)
>   
>   static void mt7915_wfsys_reset(struct mt7915_dev *dev)
>   {
> -	u32 val = MT_TOP_PWR_KEY | MT_TOP_PWR_SW_PWR_ON | MT_TOP_PWR_PWR_ON;
> +	u32 val;
>   
>   #define MT_MCU_DUMMY_RANDOM	GENMASK(15, 0)
>   #define MT_MCU_DUMMY_DEFAULT	GENMASK(31, 16)
> +	if (is_mt7915(&dev->mt76)) {
> +		mt76_wr(dev, MT_MCU_WFDMA0_DUMMY_CR, MT_MCU_DUMMY_RANDOM);
> +
> +		/* change to software control */
> +		val |= MT_TOP_PWR_SW_RST;
> +		mt76_wr(dev, MT_TOP_PWR_CTRL, val);

val is not properly initialized in this path.  I also notice this is not the version of the patch
that was applied to nbd's tree.  The 'else nic is 7916' clause that this patch creates is also different
in nbd's tree vs this patch.

I'm not sure what is correct, I've been testing with the 'v3' series and have not gotten
7916 to work yet...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

