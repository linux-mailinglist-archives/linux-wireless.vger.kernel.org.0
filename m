Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2671BBBF4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 13:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD1LIB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 07:08:01 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21419 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgD1LIB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 07:08:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588072081; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=fl4Alxu4pKzzxjaUtTsHaIHRPRq5mkpRWAVTtpGhavE=; b=AWE+WvRfeqkscOEJpthwoX70k7POwyZCgE+biY+B+HlA7c0WrOOuW+x8WZs9S3VZQXkqTUzr
 DWeMDrAV1MlcqZZhJLbrO4uoD+dUkUjUmw8DMG3wt4EZ6p1i7HZsHb4GoCopOSI0RR3wRBhq
 Dkp5oT+Gd4Ykyo97kvAkfeYlpJo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea80e89.7fa9306e2308-smtp-out-n02;
 Tue, 28 Apr 2020 11:07:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 882E5C433BA; Tue, 28 Apr 2020 11:07:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A921EC433CB;
        Tue, 28 Apr 2020 11:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A921EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7663: add the possibility to load firmware v2
References: <db72b648024aba3243ee3b7deceb548c9bc2bdf1.1587911939.git.lorenzo@kernel.org>
Date:   Tue, 28 Apr 2020 14:07:49 +0300
In-Reply-To: <db72b648024aba3243ee3b7deceb548c9bc2bdf1.1587911939.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Sun, 26 Apr 2020 16:40:18 +0200")
Message-ID: <87ftcnj2be.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> mt7663 firmware v2 is used for embedded devices since it has more completed
> features in AP mode.
> Add the capability to specify in mt7615 Kconfig which firmware load first
> (v3 or v2) and fallback to the other one if the selected firmware fails
> to load
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/Kconfig | 13 +++++
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 50 ++++++++++++++++---
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 ++-
>  .../net/wireless/mediatek/mt76/mt7615/pci.c   |  2 +
>  .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +
>  5 files changed, 65 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
> index e25db1135eda..c04d6a182bf0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
> @@ -38,3 +38,16 @@ config MT7663U
>  	  This adds support for MT7663U 802.11ax 2x2:2 wireless devices.
>  
>  	  To compile this driver as a module, choose M here.
> +
> +config MT7615_OFFLOAD_FIRMWARE
> +	bool "Prefer client mode offload firmware (MT7663)"
> +	depends on MT7615E || MT7663U
> +	default y
> +	help
> +	  Load MT7663 client mode offload firmware (v3) as primary option
> +	  and fallback to MT7663 firmware v2 in case of failure.
> +	  If MT7615_OFFLOAD_FIRMWARE is not selected MT7663 firmware v2
> +	  will be used as primary option.
> +	  MT7663 client mode offload firmware supports low power features
> +	  (hw frequency scanning, scheduled frequency scanning, WoW,
> +	  802.11 power save) but is more limited in AP mode

Why does this need a compile time config? Wouldn't some kind of runtime
configuration be better?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
