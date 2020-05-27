Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381631E3876
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 07:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgE0Fsy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 01:48:54 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:20171 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbgE0Fsy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 01:48:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590558533; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=x7YKRKRN0GyoYk6+pEpbIhj63bYsvsCDIw8LZQ2DXlg=;
 b=sW45LpQYr743VIaV+pwXs2fDCffbR+4wcTxWdZ6pJvea47+1c5JB0G+oyB4b7HMQPR2b9GaB
 Tq6HW236ObZ8LRq6AKUyXkLmUhBkkdXvDtE9ohR+xP61ytzJuGzRJabPv2mfzWWAmeWwUpv7
 +jw8MAdVd4MPzLIcP7QBPDFsJ7k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ecdff2abf0e32d25403cdb5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 05:48:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69DF0C433C6; Wed, 27 May 2020 05:48:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F7E1C433C9;
        Wed, 27 May 2020 05:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F7E1C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2019-05-22
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <5dab331b-9dd9-ecf8-12c8-31b7eb7ca8c3@nbd.name>
References: <5dab331b-9dd9-ecf8-12c8-31b7eb7ca8c3@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200527054826.69DF0C433C6@smtp.codeaurora.org>
Date:   Wed, 27 May 2020 05:48:26 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my second pull request for 5.8.
> 
> - Felix
> 
> The following changes since commit 472f0a240250df443ffc4f39835e829916193ca1:
> 
>   mt76: mt7915: Fix build error (2020-05-22 15:39:40 +0300)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-05-22
> 
> for you to fetch changes up to 35f296f6ba77d903fe8f55ed2713cfc2cc0389eb:
> 
>   mt76: mt7915: fix possible NULL pointer dereference in mt7915_register_ext_phy (2020-05-22 14:44:32 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.8
> 
> * fixes for sparse warnings
> * DBDC fixes
> * mt7663 remain-on-channel support
> * mt7915 spatial reuse support
> * mt7915 radiotap fix
> * station wcid allocation fix
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       mt76: mt7915: fix a handful of spelling mistakes
> 
> Felix Fietkau (1):
>       mt76: fix per-driver wcid range checks after wcid array size bump
> 
> Lorenzo Bianconi (5):
>       mt76: mt7615: introduce remain_on_channel support
>       mt76: mt76x02: remove check in mt76x02_mcu_msg_send
>       mt76: mt7615: fix NULL pointer deref in mt7615_register_ext_phy
>       mt76: mt7615: switch to per-vif power_save support
>       mt76: mt7915: fix possible NULL pointer dereference in mt7915_register_ext_phy
> 
> Ryder Lee (5):
>       mt76: mt7915: add spatial reuse support
>       mt76: mt7915: fix some sparse warnings
>       mt76: mt7915: fix sparse warnings: incorrect type initializer
>       mt76: mt7915: fix decoded radiotap HE flags
>       mt76: mt7915: fix some sparse warnings
> 
> Sean Wang (1):
>       mt76: mt7615: fix hw_scan with ssid_type for specified SSID only
> 
>  drivers/net/wireless/mediatek/mt76/mt76.h           |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c     |   4 ++--
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c    |  22 ++++++++++++++-------
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c     |  14 +++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c    | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c     |  66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.h     |  25 ++++++++++++++++++++++--
>  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h  |  12 +++++++++---
>  drivers/net/wireless/mediatek/mt76/mt7615/usb.c     |   3 ++-
>  drivers/net/wireless/mediatek/mt76/mt76x02.h        |   3 ++-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c    |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c    |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_util.c   |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c |   6 +++---
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c    |   3 ++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c     |  55 +++++++++++++++++++++++++++------------------------
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c    |   9 +++++++--
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     |  38 +++++++++++++++++++++++++++++-------
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h     |   1 +
>  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h  |   2 ++
>  21 files changed, 285 insertions(+), 93 deletions(-)

Fixes line is wrong:

Fixes: e57b790 ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")

Should be:

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11565545/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

