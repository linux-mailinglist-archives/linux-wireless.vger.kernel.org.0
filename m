Return-Path: <linux-wireless+bounces-24217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39591ADCB3F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 14:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E7C188DC6C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3E4238175;
	Tue, 17 Jun 2025 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoqJMW9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167D2DBF7E;
	Tue, 17 Jun 2025 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163040; cv=none; b=R3yZiP9zreEGYYd87sFRWVXRzFN0jrmhb278e+55Pj1zVecHgWQ7/VO+Um6m95Bx9UaVzpipIk5ViAoc3cJ9iVNWI6KQT9vCLqhlo8U5o5FA8jANWu+6gz3QhHP9gBhR6vm8c8iIppzTTWfOQ0Uv+xVPGFOUgoW78yfbrkWTboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163040; c=relaxed/simple;
	bh=C8g4YSlQBzpaVLue4Q2qPO1KGmVA6Fr0j6utFVKrhCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibLmd8NgHUvj0y/Xs+GxcORvYxuSCLb9Cv3T2b8+jMoer2bCJvQ7g8UJ8CFe9/msav/tx1xvqpDolZjT+vlnXUI31G7N4VmRHpiJJRt5Jk8UKxBhIJVXs2/XixWw7meVT+Uu2gHWSrCMuU+e+KJVAslaxH5OD2HfxMYYuXiylvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoqJMW9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC1BC4CEEE;
	Tue, 17 Jun 2025 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750163039;
	bh=C8g4YSlQBzpaVLue4Q2qPO1KGmVA6Fr0j6utFVKrhCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PoqJMW9klRsCS8RwKdR15KbtimU/1YD5KxhUNYh1+PEvUJfvDjlCgx9nbGlgn+fFQ
	 xID62htav2dxQioQqy+7h+qiAZKCiICHFHAiz0pgA8K73jyezJ9N9vJX95VOVKLQPZ
	 /xi7AiUkFB8CLpllJ3Ba82pgJcam4KhTsLuZZztuQx+WeqGcw79IalfzoCJ6fVrFyz
	 sS8+oU/WOWBgRCLAEhPI9H+orATC7hiECU/mgd0wBpkUBcoK43xXTGYCE6Q0yfiTov
	 i+RuP2/kwai4mII21i/gMlmpfKHycFJ0tGi/M1jLVYpsFsLCRRIoNDr3MlMZ8XkenI
	 UryAOHySDo+Cg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/5] wil6210: fix support for sparrow chipsets
Date: Tue, 17 Jun 2025 08:23:50 -0400
Message-Id: <20250617122351.1970032-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617122351.1970032-1-sashal@kernel.org>
References: <20250617122351.1970032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.294
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
index b00a13d6d5307..35c5fda9f8105 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -190,9 +190,11 @@ void wil_mask_irq(struct wil6210_priv *wil)
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
@@ -201,10 +203,12 @@ void wil_unmask_irq(struct wil6210_priv *wil)
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
@@ -858,10 +862,12 @@ void wil6210_clear_irq(struct wil6210_priv *wil)
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


