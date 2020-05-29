Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C821E8566
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgE2RnD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:43:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50310 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgE2RnC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:43:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590774182; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=tndchcg24c4U26DyuCBCL2SdAK/gcbI9DaDrR5y4ym4=;
 b=HkyXQKWLlAE8ffSfHtZk1dTyMpHN5jgl/wgvA7ZWJeEtGLOZ0OFXPTuk8qK0Zc7AJl4x3wEU
 ZyAzyX44nP7MO9PRzsBTA9jrDFuDLKf7fWg38ALAsNTup5Sbp24BsDvwdeUoL5ea9OcBUn3m
 EVqnN4Fas7G82cNMkn3fXcQSKnI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ed14996c0031c71c235c398 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:42:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2D46BC433C6; Fri, 29 May 2020 17:42:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E874BC433C9;
        Fri, 29 May 2020 17:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E874BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2019-05-22
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <d0de94c9-f367-0f57-950b-c76e1808bdcb@nbd.name>
References: <d0de94c9-f367-0f57-950b-c76e1808bdcb@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529174245.2D46BC433C6@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:42:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's another pull request for 5.8, replacing the previous one.
> 
> - Felix
> 
> The following changes since commit 50ce4c099bebf56be86c9448f7f4bcd34f33663c:
> 
>   sctp: fix typo sctp_ulpevent_nofity_peer_addr_change (2020-05-27 15:08:02 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-05-28
> 
> for you to fetch changes up to d9045b18cd445e0d0a53903ffd5d79793d9df59e:
> 
>   mt76: mt7915: remove set but not used variable 'msta' (2020-05-28 17:57:25 +0200)
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
> * mt7663 powersave fix
> * mt7663 scan fix
> * mt7611n support
> * cleanup
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       mt76: mt7915: fix a handful of spelling mistakes
> 
> DENG Qingfang (1):
>       mt76: mt7615: add support for MT7611N
> 
> Felix Fietkau (3):
>       mt76: fix per-driver wcid range checks after wcid array size bump
>       mt76: fix wcid allocation issues
>       mt76: only iterate over initialized rx queues
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
> YueHaibing (2):
>       mt76: mt7615: Use kmemdup in mt7615_queue_key_update()
>       mt76: mt7915: remove set but not used variable 'msta'
> 
>  drivers/net/wireless/mediatek/mt76/debugfs.c        |   2 +-
>  drivers/net/wireless/mediatek/mt76/dma.c            |   4 +--
>  drivers/net/wireless/mediatek/mt76/mt76.h           |  10 +++++---
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c     |   7 ++---
>  drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c  |   7 +++++
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c    |  22 +++++++++++-----
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c     |  17 +++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c     |  66 +++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.h     |  25 ++++++++++++++++--
>  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h  |  19 +++++++++++---
>  drivers/net/wireless/mediatek/mt76/mt7615/pci.c     |   9 ++++---
>  drivers/net/wireless/mediatek/mt76/mt7615/usb.c     |   3 ++-
>  drivers/net/wireless/mediatek/mt76/mt76x02.h        |   3 ++-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c    |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c    |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   |   5 ++--
>  drivers/net/wireless/mediatek/mt76/mt76x02_util.c   |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c |   6 ++---
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c    |   3 ++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c     |  58 +++++++++++++++++++++++-------------------
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c    |   9 +++++--
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     |  41 ++++++++++++++++++++++--------
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h     |   1 +
>  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h  |   2 ++
>  drivers/net/wireless/mediatek/mt76/util.c           |  12 ++++-----
>  drivers/net/wireless/mediatek/mt76/util.h           |  14 +++++-----
>  27 files changed, 335 insertions(+), 124 deletions(-)

Pulled, thanks.

5cf2740f1d45 Merge tag 'mt76-for-kvalo-2020-05-28' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/patch/11576267/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

