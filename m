Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE548AB99
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 11:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349319AbiAKKlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 05:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349320AbiAKKlK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 05:41:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F3C061748
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 02:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 052AFB81A0C
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 10:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D8C36AE3;
        Tue, 11 Jan 2022 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641897666;
        bh=YBNlvtz/hsz0QFXydHoTdn6FzRUpbkfD7u6+C9vGXJU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VL7Zj4McOwvDAdKl7h7p+EDHOr3zSMBRvaCF6eOfnfKnyfOYyYmu9Ldxh0c1BPDE9
         cStPO7qMCiTL1mnrbGu1ahsxKgHNBTCdGeO53J54kmTkqOXsUV2I3qv+MR7PVk4/dz
         JY30L7T+8gvLSJfORCxXepFz7gWt9PkvlOLohFdwz77G80CbyPlBwzwvFhrn3yftXl
         otGD5cO0keyAQdkAcUeuoEfuVDIaxFwle8Jr5pBFXEftWJC9eqdDtA2xbAxjZINiJg
         R17yQIlfONpXLPCv8wdEYJd2A4cRm4o46S1g+6+6XQpaugrSgps+RrTwpK3Sk3zuGF
         i4k/aNPmyfhHg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        "Peter Chiu" <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH 3/5] mt76: mt7915: add support for MT7986
References: <351271a274dc236f027c58487df6b21c7dbf9fd0.1641886298.git.Bo.Jiao@mediatek.com>
        <ca23c9ff8592a6a5d55ce00c4ed991c5e8678a0a.1641886298.git.Bo.Jiao@mediatek.com>
Date:   Tue, 11 Jan 2022 12:41:02 +0200
In-Reply-To: <ca23c9ff8592a6a5d55ce00c4ed991c5e8678a0a.1641886298.git.Bo.Jiao@mediatek.com>
        (Bo Jiao's message of "Tue, 11 Jan 2022 15:51:06 +0800")
Message-ID: <87v8yqk11d.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bo Jiao <bo.jiao@mediatek.com> writes:

> From: Bo Jiao <Bo.Jiao@mediatek.com>
>
> This adds MT7986 SoC integrated multi-band 4x4 WiFi 6/6E.
> Detailed link: https://www.mediatek.com/products/mediatek-filogic-830
>
> Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>

[...]

> +static int mt7986_wmac_adie_patch_7975(struct mt7915_dev *dev, u8 adie)
> +{
> +	if (/* disable CAL LDO and fine tune RFDIG LDO */
> +	    mt76_wmac_spi_write(dev, adie, 0x348, 0x00000002) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x378, 0x00000002) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x3a8, 0x00000002) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x3d8, 0x00000002) ||
> +	    /* set CKA driving and filter */
> +	    mt76_wmac_spi_write(dev, adie, 0xa1c, 0x30000aaa) ||
> +	    /* set CKB LDO to 1.4V */
> +	    mt76_wmac_spi_write(dev, adie, 0xa84, 0x8470008a) ||
> +	    /* turn on SX0 LTBUF */
> +	    mt76_wmac_spi_write(dev, adie, 0x074, 0x00000002) ||
> +	    /* CK_BUF_SW_EN = 1 (all buf in manual mode.) */
> +	    mt76_wmac_spi_write(dev, adie, 0xaa4, 0x01001fc0) ||
> +	    /* BT mode/WF normal mode 00000005 */
> +	    mt76_wmac_spi_write(dev, adie, 0x070, 0x00000005) ||
> +	    /* BG thermal sensor offset update */
> +	    mt76_wmac_spi_write(dev, adie, 0x344, 0x00000088) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x374, 0x00000088) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x3a4, 0x00000088) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x3d4, 0x00000088) ||
> +	    /* set WCON VDD IPTAT to "0000" */
> +	    mt76_wmac_spi_write(dev, adie, 0xa80, 0x44d07000) ||
> +	    /* change back LTBUF SX3 drving to default value */
> +	    mt76_wmac_spi_write(dev, adie, 0xa88, 0x3900aaaa) ||
> +	    /* SM input cap off */
> +	    mt76_wmac_spi_write(dev, adie, 0x2c4, 0x00000000) ||
> +	    /* set CKB driving and filter */
> +	    mt76_wmac_spi_write(dev, adie, 0x2c8, 0x00000072))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}

This function is hard to read and just weird. In upstream we prefer
readibility over saving few lines of code. This style takes few lines
more but it's so much easier to read:

ret = foo()
if (ret)
   return ret;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
