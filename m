Return-Path: <linux-wireless+bounces-24214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CCEADCB48
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 14:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C797B3BC337
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679F2DBF7E;
	Tue, 17 Jun 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDP+3kzZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3A28F92E;
	Tue, 17 Jun 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163001; cv=none; b=PDTiMzU4DvA01O0baRAPDw2HD3q/PaTYP9OLSqbNQjqdroUe3cd7ChALpA9aXhB0rfyXgfZne0xnBkhBRsjexRc4wGmucqocG1mGXFmpUdn3tBQ3dLJVlYAI47ahbPxXD6+p48KatqiKvOLs5z7xtoT2JqtS5DvfwdTs0+OiNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163001; c=relaxed/simple;
	bh=Rdc1gAnURumpTQ8uzxF5Gaj1pWDRUTDQlueSbbPsqp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6D/srUQOnG8OSAmHuu8+I7NZdzuDF7hjDtBDGwomKnpzopENuafpBTNF2oMWVZ+WcQOU64YNFCk0Qx/aqDXML3etUZO0YYYWAm6FrjvpDyWKOr8PDKCU8rzKfZDPSvSMDEbHuPuqF2sFbOoyL0c1Dxs1FqXkbHXQBNJ5x3C8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDP+3kzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B38C4CEEE;
	Tue, 17 Jun 2025 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750163000;
	bh=Rdc1gAnURumpTQ8uzxF5Gaj1pWDRUTDQlueSbbPsqp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDP+3kzZ0+EF2wzVRnLseMkyO5qtqCot23P2chwktv+2TFjYDe3PO5xV7uAA1/qSv
	 oN7zBMEES+JwenPNc0fHYY+f5CTWwxA9mF2jIlDhFlEwVz5JwD9Tjw+rXvFU8Kbq1n
	 /iq7b8aGhIH74lRyR1X0OvoX+1sggAD1UvtRTiadwQw52D7B6cf4KEBAdRSL9jqs7c
	 uYNiv5syb4OBXbEgIhnYxf/l63qruB9KjNDbjYkYU+3Zh12vbum4hFFzMfHQbdnvrp
	 RSS9k8Hp3cUGff+a4lGkCrqR4YEC4Rks0s5SZHR1flMp4xGnXFAmAXE62gn1OdbiqZ
	 EtyvRPEndGIPA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 8/8] wil6210: fix support for sparrow chipsets
Date: Tue, 17 Jun 2025 08:23:05 -0400
Message-Id: <20250617122306.1969438-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617122306.1969438-1-sashal@kernel.org>
References: <20250617122306.1969438-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.141
Content-Transfer-Encoding: 8bit

From: Sebastian Gottschall <s.gottschall@dd-wrt.com>

[ Upstream commit 593963660919a97a4546acfd706dac93625724f5 ]

the wil6210 driver irq handling code is unconditionally writing
edma irq registers which are supposed to be only used on Talyn chipsets.
This however leade to a chipset hang on the older sparrow chipset
generation and firmware will not even boot.
Fix that by simply checking for edma support before handling these
registers.

Tested on Netgear R9000

Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Link: https://patch.msgid.link/20250304012131.25970-2-s.gottschall@dd-wrt.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's the
extensive explanation:

## Analysis of the Commit

### 1. **The Bug Being Fixed**
The commit fixes a critical hardware compatibility issue where the
wil6210 driver unconditionally writes to EDMA (Enhanced DMA) interrupt
registers that only exist on Talyn chipsets. When running on older
Sparrow chipsets (which don't have these registers), this causes:
- Chipset hang
- Firmware boot failure
- Complete device malfunction

### 2. **Code Changes Analysis**

The commit adds conditional checks for `wil->use_enhanced_dma_hw` before
accessing EDMA-specific registers:

```c
// In wil_mask_irq():
- wil6210_mask_irq_tx_edma(wil);
+       if (wil->use_enhanced_dma_hw)
+               wil6210_mask_irq_tx_edma(wil);

// In wil_unmask_irq():
- wil_w(wil, RGF_DMA_EP_RX_ICR + offsetof(struct RGF_ICR, ICC),
- WIL_ICR_ICC_VALUE);
+       if (wil->use_enhanced_dma_hw) {
+               wil_w(wil, RGF_DMA_EP_RX_ICR + offsetof(struct RGF_ICR,
ICC),
+                     WIL_ICR_ICC_VALUE);
+       }

// In wil6210_clear_irq():
- wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_RX_ICR) +
- offsetof(struct RGF_ICR, ICR));
+       if (wil->use_enhanced_dma_hw) {
+               wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_RX_ICR) +
+                           offsetof(struct RGF_ICR, ICR));
+       }
```

### 3. **Why This Qualifies for Stable Backport**

This commit meets all the criteria for stable tree backporting:

**a) Fixes a real bug affecting users:**
- Users with Sparrow chipsets (like Netgear R9000) experience complete
  device failure
- The bug prevents the device from functioning at all (firmware won't
  boot)
- This is a regression that breaks existing hardware

**b) Small and contained fix:**
- The fix is minimal - just adding conditional checks
- Changes are limited to interrupt handling functions
- No architectural changes or new features added

**c) Low risk of regression:**
- The fix follows existing patterns in the code (other functions already
  check `use_enhanced_dma_hw`)
- Only affects behavior on non-EDMA hardware (Sparrow)
- EDMA hardware behavior remains unchanged

**d) Clear cause and effect:**
- The problem is well-understood: accessing non-existent registers
- The solution is straightforward: check hardware capability before
  accessing EDMA registers
- The fix has been tested on affected hardware (Netgear R9000)

### 4. **Comparison with Similar Commits**

Looking at the provided similar commits:
- **Similar Commit #1** (Backported: YES) fixed a Talyn reset flow issue
  - similar hardware-specific bug fix
- This commit is even more critical as it fixes a complete device
  failure rather than just a reset issue

### 5. **Critical Nature of the Fix**

This is not just a minor bug - it's a complete breakage of Sparrow
hardware support. Without this fix:
- Sparrow chipsets cannot function at all
- Users with devices like Netgear R9000 have non-functional WiFi
- This represents a regression in hardware support

The fix is essential for maintaining hardware compatibility across
different generations of the wil6210 chipset family.

 drivers/net/wireless/ath/wil6210/interrupt.c | 26 ++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index 67172385a5d66..89d4394cedcff 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -179,9 +179,11 @@ void wil_mask_irq(struct wil6210_priv *wil)
 	wil_dbg_irq(wil, "mask_irq\n");
 
 	wil6210_mask_irq_tx(wil);
-	wil6210_mask_irq_tx_edma(wil);
+	if (wil->use_enhanced_dma_hw)
+		wil6210_mask_irq_tx_edma(wil);
 	wil6210_mask_irq_rx(wil);
-	wil6210_mask_irq_rx_edma(wil);
+	if (wil->use_enhanced_dma_hw)
+		wil6210_mask_irq_rx_edma(wil);
 	wil6210_mask_irq_misc(wil, true);
 	wil6210_mask_irq_pseudo(wil);
 }
@@ -190,10 +192,12 @@ void wil_unmask_irq(struct wil6210_priv *wil)
 {
 	wil_dbg_irq(wil, "unmask_irq\n");
 
-	wil_w(wil, RGF_DMA_EP_RX_ICR + offsetof(struct RGF_ICR, ICC),
-	      WIL_ICR_ICC_VALUE);
-	wil_w(wil, RGF_DMA_EP_TX_ICR + offsetof(struct RGF_ICR, ICC),
-	      WIL_ICR_ICC_VALUE);
+	if (wil->use_enhanced_dma_hw) {
+		wil_w(wil, RGF_DMA_EP_RX_ICR + offsetof(struct RGF_ICR, ICC),
+		      WIL_ICR_ICC_VALUE);
+		wil_w(wil, RGF_DMA_EP_TX_ICR + offsetof(struct RGF_ICR, ICC),
+		      WIL_ICR_ICC_VALUE);
+	}
 	wil_w(wil, RGF_DMA_EP_MISC_ICR + offsetof(struct RGF_ICR, ICC),
 	      WIL_ICR_ICC_MISC_VALUE);
 	wil_w(wil, RGF_INT_GEN_TX_ICR + offsetof(struct RGF_ICR, ICC),
@@ -845,10 +849,12 @@ void wil6210_clear_irq(struct wil6210_priv *wil)
 		    offsetof(struct RGF_ICR, ICR));
 	wil_clear32(wil->csr + HOSTADDR(RGF_DMA_EP_TX_ICR) +
 		    offsetof(struct RGF_ICR, ICR));
-	wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_RX_ICR) +
-		    offsetof(struct RGF_ICR, ICR));
-	wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_TX_ICR) +
-		    offsetof(struct RGF_ICR, ICR));
+	if (wil->use_enhanced_dma_hw) {
+		wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_RX_ICR) +
+			    offsetof(struct RGF_ICR, ICR));
+		wil_clear32(wil->csr + HOSTADDR(RGF_INT_GEN_TX_ICR) +
+			    offsetof(struct RGF_ICR, ICR));
+	}
 	wil_clear32(wil->csr + HOSTADDR(RGF_DMA_EP_MISC_ICR) +
 		    offsetof(struct RGF_ICR, ICR));
 	wmb(); /* make sure write completed */
-- 
2.39.5


