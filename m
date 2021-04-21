Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FAB3667FF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 11:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbhDUJ3F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 05:29:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31276 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237898AbhDUJ3D (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 05:29:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618997310; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=nwFwI6w2ease5wpnjXVtcDMdAZRj7uOaIjZkzDovz3A=;
 b=jijrUkAdN8VHP2rYw18vFIwERopV3xJ2b8cliEI0JI25E+hwQDwQN9EeHI6E6Nt6EZPw3+dX
 fP+fIMdaSZpJRTcUYBHLZHsTr3nkfveXWi62MtGlVA0mcTcSpyCwi5gZZdXbMYlCjSWEUpEx
 h9Hoce7crL1Xb5yjmgQwq7DKFc8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 607ff0282cc44d3aea6b54e3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Apr 2021 09:28:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8C39C433D3; Wed, 21 Apr 2021 09:28:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89661C433F1;
        Wed, 21 Apr 2021 09:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89661C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2021-04-17
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <2f595f22-8d0b-e19e-68ed-110d7a2af96c@nbd.name>
References: <2f595f22-8d0b-e19e-68ed-110d7a2af96c@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210421092808.B8C39C433D3@smtp.codeaurora.org>
Date:   Wed, 21 Apr 2021 09:28:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my next pull request for 5.13 with mostly bugfixes
> 
> - Felix
> 
> The following changes since commit 197b9c152badc4003b1e10837f4536cb66a50f3c:
> 
>   Merge tag 'iwlwifi-next-for-kalle-2021-04-12-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2021-04-17 11:38:01 +0300)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-04-17
> 
> for you to fetch changes up to 6d1139807236382f2722da43f3c2b89de51b55cd:
> 
>   mt76: mt7915: directly read per-rate tx power from registers (2021-04-17 11:27:53 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.13
> 
> * testmode improvements
> * bugfixes
> * device tree power limits support for 7615 and newer
> * hardware recovery fixes
> * mt7663 reset/init fixes
> * mt7915 flash pre-calibration support
> 
> ----------------------------------------------------------------
> Felix Fietkau (6):
>       mt76: flush tx status queue on DMA reset
>       mt76: add functions for parsing rate power limits from DT
>       mt76: mt7615: implement support for using DT rate power limits
>       mt76: mt7615: fix hardware error recovery for mt7663
>       mt76: mt7615: fix entering driver-own state on mt7663
>       mt76: mt7615: load ROM patch before checking patch semaphore status
> 
> Lorenzo Bianconi (7):
>       mt76: mt7921: add mt7921_dma_cleanup in mt7921_unregister_device
>       dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node
>       mt76: mt7615: do not use mt7615 single-sku values for mt7663
>       mt76: introduce single-sku support for mt7663/mt7921
>       mt76: mt7921: move hw configuration in mt7921_register_device
>       mt76: improve mcu error logging
>       mt76: mt7921: run mt7921_mcu_fw_log_2_host holding mt76 mutex
> 
> Ryder Lee (6):
>       mt76: mt7615: fix memleak when mt7615_unregister_device()
>       mt76: mt7915: fix memleak when mt7915_unregister_device()
>       mt76: mt7915: only free skbs after mt7915_dma_reset() when reset happens
>       mt76: mt7615: only free skbs after mt7615_dma_reset() when reset happens
>       mt76: mt7615: use ieee80211_free_txskb() in mt7615_tx_token_put()
>       mt76: mt7915: add support for applying pre-calibration data
> 
> Sean Wang (3):
>       mt76: mt7921: add dumping Tx power table
>       mt76: mt7921: add wifisys reset support in debugfs
>       mt76: mt7921: abort uncompleted scan by wifi reset
> 
> Shayne Chen (7):
>       mt76: testmode: add support to send larger packet
>       mt76: mt7915: rework mt7915_tm_set_tx_len()
>       mt76: mt7915: fix rate setting of tx descriptor in testmode
>       mt76: extend DT rate power limits to support 11ax devices
>       mt76: mt7915: add support for DT rate power limits
>       mt76: mt7915: rework the flow of txpower setting
>       mt76: mt7915: directly read per-rate tx power from registers
> 
>  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml | 107 +++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/eeprom.c                       | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/net/wireless/mediatek/mt76/mt76.h                         |  17 ++++++-
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |   2 +
>  drivers/net/wireless/mediatek/mt76/mt7603/mcu.c                   |   5 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/dma.c                   |  17 +++++--
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |  15 +++++-
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |   8 ++-
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |   4 ++
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   | 112 ++++++++++++++++++++++++++++++++++-------
>  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                  |  23 ++++++---
>  drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c              |   9 +++-
>  drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c               |  15 ++++--
>  drivers/net/wireless/mediatek/mt76/mt7615/regs.h                  |  11 ++++
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              | 133 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |  24 +++++++++
>  drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c                  |   5 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   2 +
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |  78 +++++++++++++++++------------
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                | 163 ++++++++++++++++++-----------------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                |  51 +++++++------------
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |  82 +++++++++++++++++-------------
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |  33 ++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   8 ++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |   2 +
>  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |  14 +++---
>  drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |  25 ---------
>  drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |   5 ++
>  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |  22 ++------
>  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               | 109 ++++++++++++++++++++++++++++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |  23 ++++-----
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   |  10 ++++
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |   4 ++
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |  25 ++++++++-
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |  17 +++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  32 +++++++++++-
>  drivers/net/wireless/mediatek/mt76/testmode.c                     | 159 ++++++++++++++++++++++++++++++++++++++++++++++------------
>  drivers/net/wireless/mediatek/mt76/testmode.h                     |   2 +-
>  drivers/net/wireless/mediatek/mt76/tx.c                           |   2 +-
>  40 files changed, 1396 insertions(+), 393 deletions(-)

In commit

  c670350a12e3 ("mt76: mt7921: abort uncompleted scan by wifi reset")

Fixes tag

  Fixes: 215bb6737bef ("mt76: mt7921: add wifi reset support")

has these problem(s):

  - Target SHA1 does not exist

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/2f595f22-8d0b-e19e-68ed-110d7a2af96c@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

