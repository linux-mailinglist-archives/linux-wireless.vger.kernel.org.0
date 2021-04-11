Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB835B291
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhDKJMc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:12:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31663 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKJMc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:12:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618132336; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=lZQxZbVYeYloDJsh+LdYzAdPrcMJhYSIqZfsb3nfYTw=;
 b=GvgzwrEw1Ce7d6J/AOMruoGarBuu/jjEFhNttuIZX+tv00+zUW9cLjp/JQMNDLyCj8tcSuGv
 VJmGYCpyD1cZeUiICxF1DCaqCytf96qs2CU2Mjw+Kq2+zOxLlXSby4zz3yk7DxdNAIbjhfAo
 mWqwUQxLvSQnYV9yf3M+5C3cQOw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6072bd6a87ce1fbb56bc858e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 11 Apr 2021 09:12:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 325CDC433C6; Sun, 11 Apr 2021 09:12:09 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99E99C433CA;
        Sun, 11 Apr 2021 09:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99E99C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2021-03-18
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <352fe51c-6228-02b4-2eb3-5ab6c178327c@nbd.name>
References: <352fe51c-6228-02b4-2eb3-5ab6c178327c@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210411091209.325CDC433C6@smtp.codeaurora.org>
Date:   Sun, 11 Apr 2021 09:12:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my my updated pull request for 5.13.
> It replaces the previous one and fixes a few regressions.
> 
> - Felix
> 
> The following changes since commit 13ce240a932fe9c809ec6e79ffc5a4d4ecf534ee:
> 
>   rtw88: 8822c: support FW crash dump when FW crash (2021-03-15 10:27:13 +0200)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-03-18
> 
> for you to fetch changes up to 1ee256de59aca1e16ba47b9d1c297eb92f905934:
> 
>   mt76: mt7921: remove duplicated macros in mcu.h (2021-03-18 10:45:18 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.13
> 
> * code cleanup
> * mt7915/mt7615 decap offload support
> * driver fixes
> * mt7613 eeprom support
> * MCU code unification
> * threaded NAPI support
> * new device IDs
> * mt7921 device reset support
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       mt76: mt7921: remove redundant check on type
> 
> David Bauer (1):
>       mt76: mt76x0: disable GTK offloading
> 
> Eric Y.Y. Wong (1):
>       mt76: mt76x0u: Add support for TP-Link T2UHP(UN) v1
> 
> Felix Fietkau (7):
>       mt76: add support for 802.3 rx frames
>       mt76: mt7915: add rx checksum offload support
>       mt76: mt7915: add support for rx decapsulation offload
>       mt76: mt7615: fix key set/delete issues
>       mt76: mt7615: fix tx skb dma unmap
>       mt76: mt7915: fix tx skb dma unmap
>       mt76: use threaded NAPI
> 
> Jiapeng Chong (1):
>       mt76: mt7921: remove unneeded semicolon
> 
> Lorenzo Bianconi (23):
>       mt76: mt7915: enable hw rx-amsdu de-aggregation
>       mt76: mt7921: enable random mac addr during scanning
>       mt76: mt7921: removed unused definitions in mcu.h
>       mt76: connac: always check return value from mt76_connac_mcu_alloc_wtbl_req
>       mt76: mt7915: always check return value from mt7915_mcu_alloc_wtbl_req
>       mt76: mt7615: fix memory leak in mt7615_coredump_work
>       mt76: mt7921: fix aggr length histogram
>       mt76: mt7915: fix aggr len debugfs node
>       mt76: mt7921: fix stats register definitions
>       mt76: mt7615: fix mib stats counter reporting to mac80211
>       mt76: connac: fix kernel warning adding monitor interface
>       mt76: check return value of mt76_txq_send_burst in mt76_txq_schedule_list
>       mt76: mt7921: get rid of mt7921_sta_rc_update routine
>       mt76: mt7921: check mcu returned values in mt7921_start
>       mt76: mt7921: reduce mcu timeouts for suspend, offload and hif_ctrl msg
>       mt76: introduce mcu_reset function pointer in mt76_mcu_ops structure
>       mt76: mt7921: introduce mt7921_run_firmware utility routine.
>       mt76: mt7921: introduce __mt7921_start utility routine
>       mt76: dma: introduce mt76_dma_queue_reset routine
>       mt76: dma: export mt76_dma_rx_cleanup routine
>       mt76: mt7921: add wifi reset support
>       mt76: mt7921: remove leftovers from dbdc configuration
>       mt76: mt7921: remove duplicated macros in mcu.h
> 
> Nigel Christian (1):
>       mt76: mt7921: remove unnecessary variable
> 
> Ryder Lee (20):
>       mt76: always use WTBL_MAX_SIZE for tlv allocation
>       mt76: use PCI_VENDOR_ID_MEDIATEK to avoid open coded
>       mt76: mt7615: enable hw rx-amsdu de-aggregation
>       mt76: mt7615: add rx checksum offload support
>       mt76: mt7615: add support for rx decapsulation offload
>       mt76: mt7615: fix TSF configuration
>       mt76: mt7615: remove hdr->fw_ver check
>       mt76: mt7915: fix mib stats counter reporting to mac80211
>       mt76: mt7915: add missing capabilities for DBDC
>       mt76: mt7615: fix CSA notification for DBDC
>       mt76: mt7615: stop ext_phy queue when mac reset happens
>       mt76: mt7915: fix CSA notification for DBDC
>       mt76: mt7915: stop ext_phy queue when mac reset happens
>       mt76: mt7915: fix PHY mode for DBDC
>       mt76: mt7915: fix rxrate reporting
>       mt76: mt7915: fix txrate reporting
>       mt76: mt7915: check mcu returned values in mt7915_ops
>       mt76: mt7615: check mcu returned values in mt7615_ops
>       mt76: mt7615: add missing capabilities for DBDC
>       mt76: mt7915: fix possible deadlock while mt7915_register_ext_phy()
> 
> Sander Vanheule (1):
>       mt76: mt7615: support loading EEPROM for MT7613BE
> 
> Sean Wang (12):
>       mt76: mt7921: fix suspend/resume sequence
>       mt76: mt7921: fix memory leak in mt7921_coredump_work
>       mt76: mt7921: switch to new api for hardware beacon filter
>       mt76: connac: fix up the setting for ht40 mode in mt76_connac_mcu_uni_add_bss
>       mt76: mt7921: fixup rx bitrate statistics
>       mt76: mt7921: add flush operation
>       mt76: connac: update sched_scan cmd usage
>       mt76: mt7921: fix the base of PCIe interrupt
>       mt76: mt7921: fix the base of the dynamic remap
>       mt76: mt7663: fix when beacon filter is being applied
>       mt76: mt7663s: make all of packets 4-bytes aligned in sdio tx aggregation
>       mt76: mt7663s: fix the possible device hang in high traffic
> 
>  drivers/net/wireless/mediatek/mt76/agg-rx.c           |  13 ++--
>  drivers/net/wireless/mediatek/mt76/dma.c              |  53 ++++++++-----
>  drivers/net/wireless/mediatek/mt76/mac80211.c         |  79 +++++++++++++++++--
>  drivers/net/wireless/mediatek/mt76/mcu.c              |   4 +
>  drivers/net/wireless/mediatek/mt76/mt76.h             |  21 +++++-
>  drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/pci.c       |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c    |   1 +
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c      |  16 ++--
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c       | 195 +++++++++++++++++++++++++++++------------------
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.h       |   8 ++
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c      | 153 +++++++++++++++++++++++++++----------
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |  70 +++++++++++++++--
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.h       |  34 +++------
>  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |  19 +++--
>  drivers/net/wireless/mediatek/mt76/mt7615/pci.c       |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/regs.h      |   9 ++-
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c |  11 ++-
>  drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c  |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt76_connac.h      |   5 ++
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  34 ++++++++-
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  23 ++++--
>  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      |   4 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |   4 +
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/dma.c       |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  63 +++++++++-------
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c       | 103 +++++++++++++++++--------
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.h       |  15 ++++
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  90 +++++++++++++++++-----
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       | 188 ++++++++++++++++++++++++++++++---------------
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |  14 +++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |  10 +--
>  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c   |   8 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/dma.c       |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   4 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c       | 397 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.h       |  10 ++-
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c      | 143 +++++++++++++++++++++--------------
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  55 ++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h       |  42 -----------
>  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |  16 ++--
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  20 ++---
>  drivers/net/wireless/mediatek/mt76/mt7921/regs.h      |  31 +++++---
>  drivers/net/wireless/mediatek/mt76/sdio.c             |   3 +
>  drivers/net/wireless/mediatek/mt76/tx.c               |  15 ++--
>  52 files changed, 1338 insertions(+), 688 deletions(-)

There are some issues, please fix and resend:

In commit

  912a9e0e427f ("mt76: mt7915: fix mib stats counter reporting to mac80211")

Fixes tag

  Fixes: c6b002bcdfa6 ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")

has these problem(s):

  - Target SHA1 does not exist
In commit

  bb0756361f33 ("mt76: mt7615: fix TSF configuration")

Fixes tag

  Fixes: cd795267612d ("mt76: mt7615: support 16 interfaces")

has these problem(s):

  - Target SHA1 does not exist

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/352fe51c-6228-02b4-2eb3-5ab6c178327c@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

