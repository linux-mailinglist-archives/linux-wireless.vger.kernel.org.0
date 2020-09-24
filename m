Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3B277715
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIXQpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 12:45:47 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:47093 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgIXQpr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 12:45:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600965945; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Zb9DUEzfy4ZNnzBsOvcFEL87GvLvGcqhsfD1J3G42HU=;
 b=tBMRptXUaod5BUjQ5kl0HznNg4bLJNW5FGeZLkge5zv6+3m3n6/yzWtYWgQQ8eja0CEuC6ZW
 7zOT0hvq5wu7hsgFPwD61hoIj8+pNV7nlFEDPNgoz/0irBrPLimBYcskKU0MTpVy3OHB8Dy+
 KERrkHPRtM5CSubNa7rEu+qRKXk=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f6ccd285fb64f6e371e9027 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 16:45:28
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7052EC433FF; Thu, 24 Sep 2020 16:45:28 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC502C433C8;
        Thu, 24 Sep 2020 16:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC502C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2019-09-23 v2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <5c510447-d7cd-4aa9-3de8-7f9b25367d09@nbd.name>
References: <5c510447-d7cd-4aa9-3de8-7f9b25367d09@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200924164528.7052EC433FF@smtp.codeaurora.org>
Date:   Thu, 24 Sep 2020 16:45:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my updated version of the mt76 pull request for 5.10
> 
> The following changes since commit 5acbf34e2a2cee13208e6466346ca987eb772d55:
> 
>   zd1201: simplify the return expression of zd1201_set_maxassoc() (2020-09-24 18:50:38 +0300)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-09-23
> 
> for you to fetch changes up to b9b852b9acae1bfef01fe0f1f7f41b35aa3a7e76:
> 
>   mt76: mt7663s: remove max_tx_fragments limitation (2020-09-24 18:10:20 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.10
> 
> * mt7663 runtime power management improvements
> * performance improvements
> * sdio support fixes
> * testmode fixes
> * mt7622 fixes
> * 7915 A-MSDU offload
> * cleanups
> 
> ----------------------------------------------------------------
> Chih-Min Chen (1):
>       mt76: mt7915: fix unexpected firmware mode
> 
> Felix Fietkau (44):
>       mt76: mt7915: fix crash on tx rate report for invalid stations
>       mt76: fix double DMA unmap of the first buffer on 7615/7915
>       mt76: set interrupt mask register to 0 before requesting irq
>       mt76: mt7915: clean up and fix interrupt masking in the irq handler
>       mt76: mt7615: only clear unmasked interrupts in irq tasklet
>       mt76: mt76x02: clean up and fix interrupt masking in the irq handler
>       mt76: mt7615: do not do any work in napi poll after calling napi_complete_done()
>       mt76: mt7915: do not do any work in napi poll after calling napi_complete_done()
>       mt76: mt7915: clean up station stats polling and rate control update
>       mt76: mt7915: increase tx retry count
>       mt76: mt7915: enable offloading of sequence number assignment
>       mt76: move mt76_check_agg_ssn to driver tx_prepare calls
>       mt76: mt7615: remove mtxq->agg_ssn assignment
>       mt76: mt7915: simplify aggregation session check
>       mt76: mt7915: add missing flags in WMM parameter settings
>       mt76: mt7615: fix reading airtime statistics
>       mt76: mt7915: optimize mt7915_mac_sta_poll
>       mt76: dma: update q->queued immediately on cleanup
>       mt76: mt7915: schedule tx tasklet in mt7915_mac_tx_free
>       mt76: mt7915: significantly reduce interrupt load
>       mt76: mt7615: significantly reduce interrupt load
>       mt76: mt7915: add support for accessing mapped registers via bus ops
>       mt76: add memory barrier to DMA queue kick
>       mt76: mt7603: check for single-stream EEPROM configuration
>       mt76: usb: fix use of q->head and q->tail
>       mt76: sdio: fix use of q->head and q->tail
>       mt76: unify queue tx cleanup code
>       mt76: remove qid argument to drv->tx_complete_skb
>       mt76: remove swq from struct mt76_sw_queue
>       mt76: rely on AQL for burst size limits on tx queueing
>       mt76: remove struct mt76_sw_queue
>       mt76: mt7603: tune tx ring size
>       mt76: mt76x02: tune tx ring size
>       mt76: mt7615: fix MT_ANT_SWITCH_CON register definition
>       mt76: mt7615: fix antenna selection for testmode tx_frames
>       mt76: testmode: add a limit for queued tx_frames packets
>       mt76: add utility functions for deferring work to a kernel thread
>       mt76: convert from tx tasklet to tx worker thread
>       mt76: mt7915: fix HE BSS info
>       mt76: dma: cache dma map address/len in struct mt76_queue_entry
>       mt76: mt7915: simplify mt7915_lmac_mapping
>       mt76: mt7915: fix queue/tid mapping for airtime reporting
>       mt76: move txwi handling code to dma.c, since it is mmio specific
>       mt76: remove retry_q from struct mt76_txq and related code
> 
> Gustavo A. R. Silva (1):
>       mt76: Use fallthrough pseudo-keyword
> 
> Lee Jones (1):
>       mt76: mt76x0: Move tables used only by init.c to their own header file
> 
> Liu Shixin (1):
>       mt76: mt7915: convert to use le16_add_cpu()
> 
> Lorenzo Bianconi (28):
>       mt76: mt7615: move drv_own/fw_own in mt7615_mcu_ops
>       mt76: mt7663s: move drv_own/fw_own in mt7615_mcu_ops
>       mt76: mt7615: hold mt76 lock queueing wd in mt7615_queue_key_update
>       mt76: do not inject packets if MT76_STATE_PM is set
>       mt76: mt7615: reschedule runtime-pm receiving a tx interrupt
>       mt76: mt76s: fix oom in mt76s_tx_queue_skb_raw
>       mt76: mt76s: move tx processing in a dedicated wq
>       mt76: mt7663s: move rx processing in txrx wq
>       mt76: mt76s: move status processing in txrx wq
>       mt76: mt76s: move tx/rx processing in 2 separate works
>       mt76: mt76s: get rid of unused variable
>       mt76: mt7615: release mutex in mt7615_reset_test_set
>       mt76: mt7663s: use NULL instead of 0 in sdio code
>       mt76: mt7615: fix possible memory leak in mt7615_tm_set_tx_power
>       mt76: mt7615: fix a possible NULL pointer dereference in mt7615_pm_wake_work
>       mt76: fix a possible NULL pointer dereference in mt76_testmode_dump
>       mt76: mt7663u: fix dma header initialization
>       mt76: mt7622: fix fw hang on mt7622
>       mt76: mt7663s: do not use altx for ctl/mgmt traffic
>       mt76: mt7663s: split mt7663s_tx_update_sched in mt7663s_tx_{pick,update}_quota
>       mt76: mt7663s: introduce __mt7663s_xmit_queue routine
>       mt76: move pad estimation out of mt76_skb_adjust_pad
>       mt76: mt7663s: fix possible quota leak in mt7663s_refill_sched_quota
>       mt76: mt7663s: introduce sdio tx aggregation
>       mt76: mt7663: check isr read return value in mt7663s_rx_work
>       mt76: mt7615: unlock dfs bands
>       mt76: mt7915: fix possible memory leak in mt7915_mcu_add_beacon
>       mt76: mt7663s: remove max_tx_fragments limitation
> 
> Qinglang Miao (1):
>       mt76: Convert to DEFINE_SHOW_ATTRIBUTE
> 
> Ryder Lee (3):
>       mt76: mt7915: enable U-APSD on AP side
>       mt76: mt7915: add Tx A-MSDU offloading support
>       mt76: mt7615: fix VHT LDPC capability
> 
> Sean Wang (2):
>       mt76: mt7663s: fix resume failure
>       mt76: mt7663s: fix unable to handle kernel paging request
> 
> Shayne Chen (2):
>       mt76: mt7615: register ext_phy if DBDC is detected
>       mt76: mt7915: add offchannel condition in switch channel command
> 
> Wang Hai (1):
>       mt76: mt7615: Remove set but unused variable 'index'
> 
> Ye Bin (1):
>       mt76: Fix unsigned expressions compared with zero
> 
>  drivers/net/wireless/mediatek/mt76/debugfs.c              |   9 ++-
>  drivers/net/wireless/mediatek/mt76/dma.c                  | 162 +++++++++++++++++++++++++++++----------------
>  drivers/net/wireless/mediatek/mt76/mac80211.c             |  43 +++++-------
>  drivers/net/wireless/mediatek/mt76/mt76.h                 |  61 +++++++++--------
>  drivers/net/wireless/mediatek/mt76/mt7603/beacon.c        |   8 +--
>  drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c       |  18 ++---
>  drivers/net/wireless/mediatek/mt76/mt7603/dma.c           |  26 ++++----
>  drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c        |  17 ++++-
>  drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h        |   3 +
>  drivers/net/wireless/mediatek/mt76/mt7603/init.c          |   5 --
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c           |  25 ++++---
>  drivers/net/wireless/mediatek/mt76/mt7603/main.c          |   4 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h        |   5 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/pci.c           |   2 +
>  drivers/net/wireless/mediatek/mt76/mt7603/soc.c           |   2 +
>  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c       |  30 +++------
>  drivers/net/wireless/mediatek/mt76/mt7615/dma.c           |  55 ++++------------
>  drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c        |   3 +
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c          |  25 ++++++-
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c           |  42 ++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c          |  11 ++--
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c           | 190 ++++++++++++++++++++++++++++-------------------------
>  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c          |  25 ++++---
>  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h        |  21 +++---
>  drivers/net/wireless/mediatek/mt76/mt7615/pci.c           |   7 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c      |   3 +
>  drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c       |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/regs.h          |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c          |  38 ++++++++---
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c      |  22 +++++--
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c     | 282 +++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7615/testmode.c      |  11 ++--
>  drivers/net/wireless/mediatek/mt76/mt7615/usb.c           |   2 -
>  drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c       |   8 ++-
>  drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c      |  29 ++++----
>  drivers/net/wireless/mediatek/mt76/mt76x0/init.c          |   1 +
>  drivers/net/wireless/mediatek/mt76/mt76x0/initvals.h      | 145 ----------------------------------------
>  drivers/net/wireless/mediatek/mt76/mt76x0/initvals_init.h | 159 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c           |   4 +-
>  drivers/net/wireless/mediatek/mt76/mt76x0/phy.c           |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02.h              |   2 +
>  drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c      |  34 ++--------
>  drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c          |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_dma.h          |   1 -
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c          |  13 ++--
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.h          |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c         |  70 ++++++++------------
>  drivers/net/wireless/mediatek/mt76/mt76x02_usb.h          |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c     |  12 ++--
>  drivers/net/wireless/mediatek/mt76/mt76x02_util.c         |   5 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci.c           |   5 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c      |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c       |  11 ++--
>  drivers/net/wireless/mediatek/mt76/mt7915/dma.c           | 146 +++++++++++++++++++++++++++++++++--------
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c          |  10 +++
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c           | 257 +++++++++++++++++++++++++++++++++++++++++++----------------------------
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c          |  39 ++++++-----
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c           | 132 ++++++++++++++++++++++++++++++++-----
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h           |  33 ++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h        |  48 ++++----------
>  drivers/net/wireless/mediatek/mt76/mt7915/pci.c           |  30 ++++-----
>  drivers/net/wireless/mediatek/mt76/mt7915/regs.h          |  17 ++++-
>  drivers/net/wireless/mediatek/mt76/sdio.c                 | 160 +++++++++++++++++++++------------------------
>  drivers/net/wireless/mediatek/mt76/testmode.c             |  19 ++++--
>  drivers/net/wireless/mediatek/mt76/tx.c                   | 330 +++++++++++++++++++++++++++++++++++---------------------------------------------------------
>  drivers/net/wireless/mediatek/mt76/usb.c                  |  86 +++++++++---------------
>  drivers/net/wireless/mediatek/mt76/util.c                 |  28 ++++++++
>  drivers/net/wireless/mediatek/mt76/util.h                 |  76 +++++++++++++++++++++
>  68 files changed, 1758 insertions(+), 1333 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x0/initvals_init.h

Pulled, thanks.

225060c428f0 Merge tag 'mt76-for-kvalo-2020-09-23' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/patch/11797861/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

