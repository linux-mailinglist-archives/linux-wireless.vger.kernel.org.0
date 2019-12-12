Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416EF11C6AB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 08:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfLLHvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 02:51:02 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:40744
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728099AbfLLHvC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 02:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576137061;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:Message-ID;
        bh=30SbRHuyYH9I0+meSymRw/7OWb5sfw3MRD2S/c4vwDc=;
        b=hWvDkJaeneGDaECRSGj7+udI/ECzzAE2s3Lpc05E5Lpa+JbyfDuGjyZtkmKrbD7Z
        SVxAnLMWUTFrdVaKsYHiHXZd7fQhYQLXJk7lhVE5bSL6WX2J5dpTL6aGEtu9XKOBxx0
        akGkx0bgZNqIph2s7t5vl8CTuRKFX5O9KOVhKXnc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576137061;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:Message-ID:Feedback-ID;
        bh=30SbRHuyYH9I0+meSymRw/7OWb5sfw3MRD2S/c4vwDc=;
        b=GmDEOXHdOP6dA4nFc1HbbgtzK7uRdVcBCenkRbUNY4uT4Gk5TOqtwdh2vFFXMv4S
        7mL/oWwSTdCV/wDAL0GSmQs5s7WNtk/BQaSu1f7Hd4QciTwY5OxI2eMxbS0bGPwveOB
        FbxMM28k7WOsKJGzuSu32K57OhnHilz/e8T9v0BM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Dec 2019 07:51:01 +0000
From:   Zhi Chen <zhichen@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH,v3] Revert "ath10k: fix DMA related firmware crashes on 
 multiple devices"
Message-ID: <0101016ef916f2e7-28683312-1d0b-4c2e-b967-c13c3e45ce31-000000@us-west-2.amazonses.com>
X-Sender: zhichen@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.12.12-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
PCIe hung issue was observed on multiple platforms. The issue was 
reproduced
when DUT was configured as AP and associated with 50+ STAs.

For QCA9984/QCA9888, the DMA_BURST_SIZE register controls the AXI burst 
size
of the RD/WR access to the HOST MEM.
0 - No split , RAW read/write transfer size from MAC is put out on bus
     as burst length
1 - Split at 256 byte boundary
2,3 - Reserved

With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary 
when
issue happened. It broke PCIe spec and caused PCIe stuck. So revert
the default value from 0 to 1.

Tested:  IPQ8064 + QCA9984 with firmware 10.4-3.10-00047
          QCS404 + QCA9984 with firmware 10.4-3.9.0.2--00044
          Synaptics AS370 + QCA9888  with firmware 10.4-3.9.0.2--00040

Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
---
v2: restored 10.2 register configuration
v3: modified commit message
---
  drivers/net/wireless/ath/ath10k/hw.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/hw.h 
b/drivers/net/wireless/ath/ath10k/hw.h
index 35a3623..59a9a58 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -813,7 +813,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,

  #define TARGET_10_4_TX_DBG_LOG_SIZE		1024
  #define TARGET_10_4_NUM_WDS_ENTRIES		32
-#define TARGET_10_4_DMA_BURST_SIZE		0
+#define TARGET_10_4_DMA_BURST_SIZE		1
  #define TARGET_10_4_MAC_AGGR_DELIM		0
  #define TARGET_10_4_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK 1
  #define TARGET_10_4_VOW_CONFIG			0
-- 
2.7.4
