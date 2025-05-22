Return-Path: <linux-wireless+bounces-23329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BEFAC15C1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 22:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0CE9E2822
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A5C24A073;
	Thu, 22 May 2025 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H76vvczQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic301-21.consmr.mail.sg3.yahoo.com (sonic301-21.consmr.mail.sg3.yahoo.com [106.10.242.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8524A07D
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.242.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747947442; cv=none; b=JxZZkrmutX29XFqvFOrXfcgeJls3qrLwoI2vBUYACMuIsRqCY1z69MdPNQrbMCwmL20FJfixua+rmKIrTzWmOAPyntoQGsJCJflBoHPLUUh/QaRkxFb08wnqj5VLw7PPdQ2UsIkHwT+oN3svVfJC9hGOq3htGBx8F9FbU38+zSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747947442; c=relaxed/simple;
	bh=cNOSCFWOLKZP7eE3yFPfHSdWwgFg8Eei/ZR02aRi4Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=OrHp65mqsk46lspixylNdtHiRo/Tvp4CcNPtiWNvjkTChLgjUQv+nCqfgBbUfeeYSds1Kk3BDkU67zoA9z+WL376pNIhRpkC6/Ru3/h+ve+P8NvKbHZQUNBfa/mleobgGWSJpFBeCHHNk2q6OSK+PO9oX8lRqP5DGXBQ4W5pRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=H76vvczQ; arc=none smtp.client-ip=106.10.242.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747947431; bh=WkXBQ/6jm4t5+g2iqIwRa73oLwIgViQhZB+CGikZxY8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=H76vvczQyUCTCty/5wjMwyLjjC4EL/a5Bl7esJLZtbfF+w1VuANN4NLpeufEeao4nOkBWU9DUqt7FvRsSOKVyBfjZ82L8av+FyN95XuRKun+Koyv/DS0MpIFqWkLI+ItbSPExjQVE36ZoprDqFUzN4Y7sqkAu5siOH5oJpJr7mOVEdVxbbOk2qsiMTw1ifGvfd3OhAU0YaqbJIUCkPvMJwCwaaM9Ys+5wUdJmnMMKH8BChtBhI8j1jF0EBrbR0vAEXBXtwPLBAdK0al6wp8I2eeLGy4VrQuPPQ7yElddf8t0l3W5MDazEc0B46PLwsglx7GvTOSLyeGAfc5iPOJUDg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747947431; bh=PWY612N53H1qByP/PTIYplw9/L2la2VwiUTlxRNTSqE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=J2KwWg4H2jOkOo5YanZ5dLnfYkghFdR/v93nZKMaeruq0uoIfNNGazfMQX6VTRUD/jVke8XE9jRlvI8XMd0EWXGTvJqPfNQeoCuXwpNgaJTaBm9ubSeUa2wvwb3JZ+dP6x0DShHQFKMqGbsE8ytE2n2l0s6mBB3YLAJzcMguV+froIDjvTDDmid5VJr0L4bwsiwQvFQDHjFGnVWvM5DdpCPc0/YA9T8SynyPQza6rwUKRpfn+XFc8F5vJ2l85eVQgjNVUEb/yC9lFlLPT+m2IFEJrBIu4NuYd3DqjELftKMlTkecmehxXc4Vl/8L8KtaM463aCjafD8TLnpXfA+icA==
X-YMail-OSG: btq1b6EVM1nhBzHyV8zfTEvlt4sRgw1RSCKMTe1xPp.Hrv3hFPED9EI5cOSN9i.
 innCM27yI9xh5zeHMCnSA7HoEi82aiGJGbqodOoGAwpl.LjZDMVb_Jv9vrrdwhu3Ni0eQtwX.bNt
 ilGHOcS8ek6pGbGOJoc89B8UubOcIiuDvLsCIYUlULg0cJWummxxcNAXLoBxOTOlVB0yTyuqZzM5
 oNBSafmnwPh39gePZSVkf_s_fx9hO49iz8z8zWvfHT6bINi1mvWPFsMaa79ykTE5CZuG.azEcmIF
 ZpD2QtILZyi9wPLWOyGMK9tH0ntWAMnAI_Qc_rSjlLfxDz9qCFVsZFdB1VWsl2z34CWkQVe..VpR
 clWwhcVbOeiOsoJYBnFUVpWsiQ2vmJSEXLO1BRodGgg3RAKepSQE9UQ8M5Bsz.HdZR56X2bHGzuh
 BrlxHqa5X0plDFUsae.Y.AvHYxQ_VCkIpz4dQYdU96526sE6vdNOdltMf9s0iCdOvy6wdC9bpJgq
 w2onwqFCqOuHNPXqUCsgM970kfS7QCee3faMmjXr.P6LY15mWV7vvTu9sVtf7p.Gu8U3j3N50nhL
 qQJHWWjDovDVtFbtX3B4mG7WpYsTCuZExo6U3EUgSwredW.eUNgjn3_gt8ESkTpBDFjDdXMBwx04
 rMNDaL8lGM.ajGSIsih4DGnIRJQM30hYIlofdmHFZ8hFYSdH17x8VFxujE90E2L02w5dsGJ6DRtD
 MiZDWqCzb02bnFfT3xFjjkJJo31lHTHfK2ikvxGfZeh332nHdq2iO3F_BRUje6O0ro1Fg5VfNpdx
 m7B.kOwohQHK.9ZY7D2_3Qpa3jOG1xy1X3xxj2SYG6XwVBqoyWdmrhF9nlD40QamhWDzjc3UwQwO
 mmj79UGAjwcAyoltRNBMQKA_830AcBjxOa7AVIY65HVNUAcSx0fjmkjmN7oNNioOXJAiqggBHKKi
 bWlkihK0uFnVpz0Ibi6N8h6YUpjAKM0cwFmIKcq3L0_hPlZbD0HnxQe.V74DuAYrfYLMxBoQCUjz
 NUaqfF1i7cq62rnbDn.osQdie4rU2sOnZZNtjgn9z3CDritc6AcnfeNRotXC0N8FmNqI.vObo8x9
 3ZTpz41_hPTYymwGBRY6m22iRGMMOSaAYMD91onr2EBP_VcmmAc440F09j_lzobgZ7T0Q0WQFSSQ
 NyF97e.899_14Rsb3qm_iYcDkMBu1xTaeWPyqrlnEjX5gP54bPVSJ3YJvPkB9mwyuQKeSXVwiFwI
 njrd40gjEc.X6yNjHG7ntsWyaWrU7DVzYhAMRn28__UbUg9X18SwBD.Tcm4oTzSmk4vlLjBNO_kx
 WEQO3okPRsrUmiLV.jiF3zT.6UDw8f.xCYY47bqXNgzM_N7pYALgNnDa_QRfaThrztzd..E24JNW
 pVH_HHUJVnIECxVYwndA5mo2ltuigr0NSzpqv7P.tUkJI_M1Hc1mffRyDUhWpUYAUJEgKZ050QlK
 M3NHvY9hx6kKSOZMGUbUz7aQXDM5g68paSk3mZSMeONGFGlgVjWquuuEGa1qTjtw2CmuJYdRwCgC
 447GHBSfQYUSBsIciD1biEvE_PYVGvp6W2gpgeFDNuG4LP4GowU8rSO9kd5npFNCFafrscBX0egP
 o7sGVxOVjaHoNUum39WctZqRfrBHhQoXhv7eMwGZllLjgKB1iBQFKD6rl8kH6ysjH5yAx3YckM7f
 DEn9QDDpucbS5eugIOJFrD_FanBlbKDu4y9uIngTsmaXXHcNcLyNUoWefhU_XEX_xVTwGnhUDYjW
 B3YR3T1X28BvnL33_TQho3u8gItb2RKGW80NmCi8vE_KQKnJ64ycO.iUMRmIj4LeFZUGX53LEwrO
 fdbKi1qe_yPL2DWROP6hRfmp5oOf5e1UhweKuIl27ii7Hzq5ngJsPNdeY.cWuKBpto1rz7p_Qzl7
 oBbqcrMTB2.Z1Yp.dxVJlVSM1yhOZkb0e7k3hfy2vAPBpGHPJj5zEb_ZWyJCDzCaLX_r6UW4R15Z
 TiclmTbxrjdnykUmRSQZKUNEVHcLZtMowdfTfMwb_5eVK3XyD0OZBY065bLIvogMYgznJzRREMXX
 u_yIGwnbOfxBlrrnDPabLp92jAwo44wYoVrx6apHgxW2HWDatBpRRles__r0swpg075jsJtyqRaQ
 c6r_m3Vx9eFyw_lH.AxVTkLZi8ap3wyoyNyCaYycsLWcW0wd9bowPDOCJ5.u5OFvV43g6Ac60job
 93OA6fBMwwPQ1DNuOeXK3syyRwJ6303Yn0e8PEha9KAvh374tEH3FqR6X7QuLekyoQo9TY72UOKy
 vC6j.9vEvbnyFMyN3mWQf07CrzQmEDv15GGLLS7Rb4cES8Q--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: e8fdb12f-1175-4b73-923a-68eb1ca40875
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Thu, 22 May 2025 20:57:11 +0000
Received: by hermes--production-gq1-74d64bb7d7-lwch7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 54d4537dbd31a689292303adb7330d0f;
          Thu, 22 May 2025 20:57:06 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: viro@zeniv.linux.org.uk,
	mingo@kernel.org,
	tglx@linutronix.de,
	kvalo@kernel.org,
	algonell@gmail.com,
	jeff.johnson@oss.qualcomm.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath6kl: Fix spellings
Date: Thu, 22 May 2025 13:56:53 -0700
Message-ID: <20250522205701.393612-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250522205701.393612-1-sumanth.gavini.ref@yahoo.com>

Fix misspelling reported by codespell.

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 drivers/net/wireless/ath/ath6kl/core.c     |  2 +-
 drivers/net/wireless/ath/ath6kl/hif.c      |  2 +-
 drivers/net/wireless/ath/ath6kl/htc.h      |  6 +++---
 drivers/net/wireless/ath/ath6kl/htc_mbox.c |  2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c |  2 +-
 drivers/net/wireless/ath/ath6kl/init.c     |  4 ++--
 drivers/net/wireless/ath/ath6kl/main.c     |  2 +-
 drivers/net/wireless/ath/ath6kl/sdio.c     |  2 +-
 drivers/net/wireless/ath/ath6kl/usb.c      |  6 +++---
 drivers/net/wireless/ath/ath6kl/wmi.c      |  2 +-
 drivers/net/wireless/ath/ath6kl/wmi.h      | 10 +++++-----
 11 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/core.c b/drivers/net/wireless/ath/ath6kl/core.c
index 4f0a7a185fc9..830350bda531 100644
--- a/drivers/net/wireless/ath/ath6kl/core.c
+++ b/drivers/net/wireless/ath/ath6kl/core.c
@@ -91,7 +91,7 @@ int ath6kl_core_init(struct ath6kl *ar, enum ath6kl_htc_type htc_type)
 
 	/*
 	 * Turn on power to get hardware (target) version and leave power
-	 * on delibrately as we will boot the hardware anyway within few
+	 * on deliberately as we will boot the hardware anyway within few
 	 * seconds.
 	 */
 	ret = ath6kl_hif_power_on(ar);
diff --git a/drivers/net/wireless/ath/ath6kl/hif.c b/drivers/net/wireless/ath/ath6kl/hif.c
index d1942537ea10..c693783bb9de 100644
--- a/drivers/net/wireless/ath/ath6kl/hif.c
+++ b/drivers/net/wireless/ath/ath6kl/hif.c
@@ -513,7 +513,7 @@ static int proc_pending_irqs(struct ath6kl_device *dev, bool *done)
 out:
 	/*
 	 * An optimization to bypass reading the IRQ status registers
-	 * unecessarily which can re-wake the target, if upper layers
+	 * unnecessarily which can re-wake the target, if upper layers
 	 * determine that we are in a low-throughput mode, we can rely on
 	 * taking another interrupt rather than re-checking the status
 	 * registers which can re-wake the target.
diff --git a/drivers/net/wireless/ath/ath6kl/htc.h b/drivers/net/wireless/ath/ath6kl/htc.h
index d3534a29c4f0..d61be202677c 100644
--- a/drivers/net/wireless/ath/ath6kl/htc.h
+++ b/drivers/net/wireless/ath/ath6kl/htc.h
@@ -485,7 +485,7 @@ struct htc_endpoint_stats {
 	/* count of credits received via another endpoint */
 	u32 cred_from_ep0;
 
-	/* count of consummed credits */
+	/* count of consumed credits */
 	u32 cred_cosumd;
 
 	/* count of credits returned */
@@ -596,7 +596,7 @@ struct htc_target {
 	/* protects free_ctrl_txbuf and free_ctrl_rxbuf */
 	spinlock_t htc_lock;
 
-	/* FIXME: does this protext rx_bufq and endpoint structures or what? */
+	/* FIXME: does this protect rx_bufq and endpoint structures or what? */
 	spinlock_t rx_lock;
 
 	/* protects endpoint->txq */
@@ -624,7 +624,7 @@ struct htc_target {
 
 	int chk_irq_status_cnt;
 
-	/* counts the number of Tx without bundling continously per AC */
+	/* counts the number of Tx without bundling continuously per AC */
 	u32 ac_tx_count[WMM_NUM_AC];
 
 	struct {
diff --git a/drivers/net/wireless/ath/ath6kl/htc_mbox.c b/drivers/net/wireless/ath/ath6kl/htc_mbox.c
index f8a94d764be6..122e07ef3965 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_mbox.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_mbox.c
@@ -938,7 +938,7 @@ static void ath6kl_htc_tx_from_queue(struct htc_target *target,
 
 		/*
 		 * if an AC has bundling disabled and no tx bundling
-		 * has occured continously for a certain number of TX,
+		 * has occurred continuously for a certain number of TX,
 		 * enable tx bundling for this AC
 		 */
 		if (!bundle_sent) {
diff --git a/drivers/net/wireless/ath/ath6kl/htc_pipe.c b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
index 2f2edfe43761..7b823be9d846 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_pipe.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
@@ -718,7 +718,7 @@ static struct htc_packet *htc_lookup_tx_packet(struct htc_target *target,
 	spin_lock_bh(&target->tx_lock);
 
 	/*
-	 * interate from the front of tx lookup queue
+	 * iterate from the front of tx lookup queue
 	 * this lookup should be fast since lower layers completes in-order and
 	 * so the completed packet should be at the head of the list generally
 	 */
diff --git a/drivers/net/wireless/ath/ath6kl/init.c b/drivers/net/wireless/ath/ath6kl/init.c
index 9b100ee2ebc3..782209dcb782 100644
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -207,7 +207,7 @@ static const struct ath6kl_hw hw_list[] = {
 
 /*
  * This configuration item sets the value of disconnect timeout
- * Firmware delays sending the disconnec event to the host for this
+ * Firmware delays sending the disconnect event to the host for this
  * timeout after is gets disconnected from the current AP.
  * If the firmware successly roams within the disconnect timeout
  * it sends a new connect event
@@ -221,7 +221,7 @@ struct sk_buff *ath6kl_buf_alloc(int size)
 	struct sk_buff *skb;
 	u16 reserved;
 
-	/* Add chacheline space at front and back of buffer */
+	/* Add cacheline space at front and back of buffer */
 	reserved = roundup((2 * L1_CACHE_BYTES) + ATH6KL_DATA_OFFSET +
 		   sizeof(struct htc_packet) + ATH6KL_HTC_ALIGN_BYTES, 4);
 	skb = dev_alloc_skb(size + reserved);
diff --git a/drivers/net/wireless/ath/ath6kl/main.c b/drivers/net/wireless/ath/ath6kl/main.c
index 867089a3c096..4edda694b1bd 100644
--- a/drivers/net/wireless/ath/ath6kl/main.c
+++ b/drivers/net/wireless/ath/ath6kl/main.c
@@ -583,7 +583,7 @@ static int ath6kl_commit_ch_switch(struct ath6kl_vif *vif, u16 channel)
 	switch (vif->nw_type) {
 	case AP_NETWORK:
 		/*
-		 * reconfigure any saved RSN IE capabilites in the beacon /
+		 * reconfigure any saved RSN IE capabilities in the beacon /
 		 * probe response to stay in sync with the supplicant.
 		 */
 		if (vif->rsn_capab &&
diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless/ath/ath6kl/sdio.c
index 9ab091044706..83de40bc4445 100644
--- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -486,7 +486,7 @@ static void ath6kl_sdio_irq_handler(struct sdio_func *func)
 	ar_sdio = sdio_get_drvdata(func);
 	atomic_set(&ar_sdio->irq_handling, 1);
 	/*
-	 * Release the host during interrups so we can pick it back up when
+	 * Release the host during interrupts so we can pick it back up when
 	 * we process commands.
 	 */
 	sdio_release_host(ar_sdio->func);
diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..38bb501fc553 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -93,7 +93,7 @@ struct ath6kl_urb_context {
 #define ATH6KL_USB_EP_ADDR_APP_DATA_MP_OUT      0x03
 #define ATH6KL_USB_EP_ADDR_APP_DATA_HP_OUT      0x04
 
-/* diagnostic command defnitions */
+/* diagnostic command definitions */
 #define ATH6KL_USB_CONTROL_REQ_SEND_BMI_CMD        1
 #define ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP       2
 #define ATH6KL_USB_CONTROL_REQ_DIAG_CMD            3
@@ -882,7 +882,7 @@ static int ath6kl_usb_submit_ctrl_out(struct ath6kl_usb *ar_usb,
 			return -ENOMEM;
 	}
 
-	/* note: if successful returns number of bytes transfered */
+	/* note: if successful returns number of bytes transferred */
 	ret = usb_control_msg(ar_usb->udev,
 			      usb_sndctrlpipe(ar_usb->udev, 0),
 			      req,
@@ -914,7 +914,7 @@ static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,
 			return -ENOMEM;
 	}
 
-	/* note: if successful returns number of bytes transfered */
+	/* note: if successful returns number of bytes transferred */
 	ret = usb_control_msg(ar_usb->udev,
 				 usb_rcvctrlpipe(ar_usb->udev, 0),
 				 req,
diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 3787b9fb0075..1ecf6a2171df 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -2601,7 +2601,7 @@ int ath6kl_wmi_create_pstream_cmd(struct wmi *wmi, u8 if_idx,
 	}
 
 	/*
-	 * Indicate activty change to driver layer only if this is the
+	 * Indicate activity change to driver layer only if this is the
 	 * first TSID to get created in this AC explicitly or an implicit
 	 * fat pipe is getting created.
 	 */
diff --git a/drivers/net/wireless/ath/ath6kl/wmi.h b/drivers/net/wireless/ath/ath6kl/wmi.h
index 68384159870b..3080d82e25cc 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.h
+++ b/drivers/net/wireless/ath/ath6kl/wmi.h
@@ -655,7 +655,7 @@ enum wmi_mgmt_frame_type {
 
 enum wmi_ie_field_type {
 	WMI_RSN_IE_CAPB	= 0x1,
-	WMI_IE_FULL	= 0xFF,  /* indicats full IE */
+	WMI_IE_FULL	= 0xFF,  /* indicates full IE */
 };
 
 /* WMI_CONNECT_CMDID  */
@@ -1178,10 +1178,10 @@ struct wmi_create_pstream_cmd {
 	__le32 sba;
 	__le32 medium_time;
 
-	/* in octects */
+	/* in octets */
 	__le16 nominal_msdu;
 
-	/* in octects */
+	/* in octets */
 	__le16 max_msdu;
 
 	u8 traffic_class;
@@ -1742,7 +1742,7 @@ struct wmi_scan_complete_event {
 
 /*
  * Special frame receive Event.
- * Mechanism used to inform host of the receiption of the special frames.
+ * Mechanism used to inform host of the reception of the special frames.
  * Consists of special frame info header followed by special frame body.
  * The 802.11 header is not included.
  */
@@ -1860,7 +1860,7 @@ struct wmi_target_stats {
 /*
  * WMI_RSSI_THRESHOLD_EVENTID.
  * Indicate the RSSI events to host. Events are indicated when we breach a
- * thresold value.
+ * threshold value.
  */
 enum wmi_rssi_threshold_val {
 	WMI_RSSI_THRESHOLD1_ABOVE = 0,
-- 
2.43.0


