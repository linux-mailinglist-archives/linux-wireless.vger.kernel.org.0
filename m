Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534E42CC66D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 20:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgLBTTv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 14:19:51 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:41355 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgLBTTv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 14:19:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606936766; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=37NjZuggWZFEENhu0C4vIAJ1Lz7PTMqhVKgRu6R6YCs=;
 b=bSAzVBGmBodTyqP8aALXlugfTYXMSrXNKsWwlpANQ+Dp8bDf0jKUDsnfDehvPY3WFo2ROdzw
 IiZ0dLpSpblCtp83KuhA2gMRGXq8xFvpjYMkhqNm+vVRrVwzG7u0+WTEDoBCLUJ3YvCi+0Cw
 LSuWSr+8HPLif9IjIo0hKBeHGdw=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fc7e89cf653ea0cd84da29f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 19:18:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F04EC43460; Wed,  2 Dec 2020 19:18:52 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7D90C433C6;
        Wed,  2 Dec 2020 19:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7D90C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2020-11-18
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <7ec7cc33-ccf0-ee68-755a-9d118ced3102@nbd.name>
References: <7ec7cc33-ccf0-ee68-755a-9d118ced3102@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202191852.3F04EC43460@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 19:18:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my first pull request for 5.11
> 
> The following changes since commit 1ccaa898868d1971a6480d7d55668de522f5847f:
> 
>   rtw88: coex: simplify the setting and condition about WLAN TX limitation (2020-11-10 20:58:22 +0200)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-11-18
> 
> for you to fetch changes up to eaa41fd9b10bebf9c020047ff3e302bcbc0ad871:
> 
>   mt76: mt7915: fix memory leak in mt7915_mcu_get_rx_rate() (2020-11-18 11:32:34 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.11
> 
> * mt7915 fixes
> * mt7615 fixes
> * support for more sta interfaces on mt7615/mt7915
> * mt7915 encap offload
> * performance improvements
> * channel noise report on mt7915
> * usb/sdio support improvements
> * mt7915 testmode support
> * mt7915 DBDC support
> 
> ----------------------------------------------------------------
> Allen Pais (1):
>       wireless: mt76: convert tasklets to use new tasklet_setup() API
> 
> Chuanhong Guo (1):
>       mt76: mt7615: retry if mt7615_mcu_init returns -EAGAIN
> 
> David Bauer (1):
>       mt76: mt7603: add additional EEPROM chip ID
> 
> Felix Fietkau (22):
>       mt76: mt7915: add 802.11 encap offload support
>       mt76: mt7915: add encap offload for 4-address mode stations
>       mt76: use ieee80211_rx_list to pass frames to the network stack as a batch
>       mt76: mt7615: add debugfs knob for setting extended local mac addresses
>       mt76: do not set NEEDS_UNIQUE_STA_ADDR for 7615 and 7915
>       mt76: mt7915: support 32 station interfaces
>       mt76: mt7915: fix processing txfree events
>       mt76: mt7915: use napi_consume_skb to bulk-free tx skbs
>       mt76: mt7915: fix DRR sta bss group index
>       mt76: mt7915: disable OFDMA/MU-MIMO UL
>       mt76: rename __mt76_mcu_send_msg to mt76_mcu_send_msg
>       mt76: rename __mt76_mcu_skb_send_msg to mt76_mcu_skb_send_msg
>       mt76: implement .mcu_parse_response in struct mt76_mcu_ops
>       mt76: move mcu timeout handling to .mcu_parse_response
>       mt76: move waiting and locking out of mcu_ops->mcu_skb_send_msg
>       mt76: make mcu_ops->mcu_send_msg optional
>       mt76: mt7603: switch to .mcu_skb_send_msg
>       mt76: implement functions to get the response skb for MCU calls
>       mt76: mt7915: move eeprom parsing out of mt7915_mcu_parse_response
>       mt76: mt7915: query station rx rate from firmware
>       mt76: add back the SUPPORTS_REORDERING_BUFFER flag
>       mt76: mt7915: fix endian issues
> 
> Lorenzo Bianconi (37):
>       mt76: mt7663s: move tx/rx processing in the same txrx workqueue
>       mt76: mt7663s: convert txrx_work to mt76_worker
>       mt76: mt7663s: disable interrupt during txrx_worker processing
>       mt76: sdio: convert {status/net}_work to mt76_worker
>       mt76: mt7615: enable beacon filtering by default for offload fw
>       mt76: mt7615: introduce quota debugfs node for mt7663s
>       mt76: mt7663s: get rid of mt7663s_sta_add
>       mt76: mt7663s: fix a possible ple quota underflow
>       mt76: sdio: get rid of sched.lock
>       mt76: dma: fix possible deadlock running mt76_dma_cleanup
>       mt76: fix memory leak if device probing fails
>       mt76: move mt76_mcu_send_firmware in common module
>       mt76: switch to wep sw crypto for mt7615/mt7915
>       mt76: fix tkip configuration for mt7615/7663 devices
>       mt76: mt7615: run key configuration in mt7615_set_key for usb/sdio devices
>       mt76: mt76u: rely on woker APIs for rx work
>       mt76: mt76u: use dedicated thread for status work
>       mt76: mt7915: make mt7915_eeprom_read static
>       mt76: mt7615: refactor usb/sdio rate code
>       mt76: mt7915: rely on eeprom definitions
>       mt76: move mt76_init_tx_queue in common code
>       mt76: sdio: introduce mt76s_alloc_tx_queue
>       mt76: sdio: rely on mt76_queue in mt76s_process_tx_queue signature
>       mt76: mt7663s: rely on mt76_queue in mt7663s_tx_run_queue signature
>       mt76: dma: rely on mt76_queue in mt76_dma_tx_cleanup signature
>       mt76: rely on mt76_queue in tx_queue_skb signature
>       mt76: introduce mt76_init_mcu_queue utility routine
>       mt76: rely on mt76_queue in tx_queue_skb_raw signature
>       mt76: move mcu queues to mt76_dev q_mcu array
>       mt76: move tx hw data queues in mt76_phy
>       mt76: move band capabilities in mt76_phy
>       mt76: rely on mt76_phy in mt76_init_sband_2g and mt76_init_sband_5g
>       mt76: move band allocation in mt76_register_phy
>       mt76: move hw mac_addr in mt76_phy
>       mt76: mt7915: introduce dbdc support
>       mt76: mt7915: get rid of dbdc debugfs knob
>       mt76: mt7615: fix rdd mcu cmd endianness
> 
> Ryder Lee (8):
>       mt76: mt7915: measure channel noise and report it via survey
>       mt76: mt7915: fix VHT LDPC capability
>       mt76: mt7915: update ppe threshold
>       mt76: mt7915: rename mt7915_mcu_get_rate_info to mt7915_mcu_get_tx_rate
>       mt76: mt7915: fix sparse warning cast from restricted __le16
>       mt76: mt7915: use BIT_ULL for omac_idx
>       mt76: mt7915: remove unused mt7915_mcu_bss_sync_tlv()
>       mt76: mt7615: support 16 interfaces
> 
> Sean Wang (1):
>       mt76: mt7663s: introduce WoW support via GPIO
> 
> Shayne Chen (11):
>       mt76: testmode: switch ib and wb rssi to array type for per-antenna report
>       mt76: testmode: add snr attribute in rx statistics
>       mt76: testmode: add tx_rate_stbc parameter
>       mt76: testmode: add support for LTF and GI combinations for HE mode
>       mt76: mt7915: fix tx rate related fields in tx descriptor
>       mt76: testmode: add support for HE rate modes
>       mt76: mt7915: implement testmode tx support
>       mt76: mt7915: implement testmode rx support
>       mt76: mt7915: add support to set txpower in testmode
>       mt76: mt7915: add support to set tx frequency offset in testmode
>       mt76: mt7915: fix memory leak in mt7915_mcu_get_rx_rate()
> 
> Taehee Yoo (2):
>       mt76: mt7915: set fops_sta_stats.owner to THIS_MODULE
>       mt76: set fops_tx_stats.owner to THIS_MODULE
> 
>  drivers/net/wireless/mediatek/mt76/debugfs.c          |   4 +-
>  drivers/net/wireless/mediatek/mt76/dma.c              |  28 ++--
>  drivers/net/wireless/mediatek/mt76/eeprom.c           |  12 +-
>  drivers/net/wireless/mediatek/mt76/mac80211.c         | 149 +++++++++++---------
>  drivers/net/wireless/mediatek/mt76/mcu.c              |  80 +++++++++++
>  drivers/net/wireless/mediatek/mt76/mt76.h             | 119 ++++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7603/beacon.c    |  30 ++--
>  drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |  61 ++++----
>  drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c    |   7 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/init.c      |   4 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   9 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/main.c      |  12 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/mcu.c       | 131 ++++++------------
>  drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/pci.c       |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c   | 139 +++++++++++++++++--
>  drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |  55 +++-----
>  drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c    |  20 +--
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c      |  23 +--
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c       | 199 +++++++++++++-------------
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c      | 122 +++++++---------
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       | 544 +++++++++++++++++++++++++++++++++++++----------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.h       |  17 +++
>  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c      |   9 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |  92 ++++--------
>  drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c  |   9 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/regs.h      |  11 ++
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |  71 +++++-----
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  42 ++----
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 142 +++++++++----------
>  drivers/net/wireless/mediatek/mt76/mt7615/testmode.c  |  28 +++-
>  drivers/net/wireless/mediatek/mt76/mt7615/usb.c       |   9 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c   |  16 +--
>  drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c  |  89 +++---------
>  drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c    |  12 +-
>  drivers/net/wireless/mediatek/mt76/mt76x0/init.c      |   4 +-
>  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c   |   1 +
>  drivers/net/wireless/mediatek/mt76/mt76x0/phy.c       |   4 +-
>  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |   1 +
>  drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c      |  10 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c   |   8 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      |  16 +--
>  drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c      |  55 ++++----
>  drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h      |   2 +
>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |  76 +++++-----
>  drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c  |   1 +
>  drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |  13 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c    |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c       |  18 +--
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c  |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c   |   1 +
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |   1 +
>  drivers/net/wireless/mediatek/mt76/mt7915/Makefile    |   2 +
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |  47 ++-----
>  drivers/net/wireless/mediatek/mt76/mt7915/dma.c       |  76 +++++-----
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |  64 +++++----
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h    |   1 +
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c      | 434 +++++++++++++++++++++++++++------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c       | 520 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.h       |  16 ++-
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c      | 133 ++++++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       | 732 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |  54 ++++++--
>  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |  62 ++++++---
>  drivers/net/wireless/mediatek/mt76/mt7915/pci.c       |  24 +++-
>  drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |  52 ++++++-
>  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c  | 377 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7915/testmode.h  |  40 ++++++
>  drivers/net/wireless/mediatek/mt76/sdio.c             | 196 ++++++++++++++------------
>  drivers/net/wireless/mediatek/mt76/testmode.c         |  41 ++++--
>  drivers/net/wireless/mediatek/mt76/testmode.h         |  18 ++-
>  drivers/net/wireless/mediatek/mt76/tx.c               |  34 ++---
>  drivers/net/wireless/mediatek/mt76/usb.c              |  87 ++++++++----
>  76 files changed, 3396 insertions(+), 2141 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/testmode.h

In commit

  e9094e9b5d48 ("mt76: mt7915: fix sparse warning cast from restricted __le16")

Fixes tag

  Fixes: 00b2e16 ("mt76: mt7915: add TxBF capabilities")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7ec7cc33-ccf0-ee68-755a-9d118ced3102@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

