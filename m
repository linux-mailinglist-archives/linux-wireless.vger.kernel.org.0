Return-Path: <linux-wireless+bounces-23639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068FAACD351
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FCC179FA4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB1C18DB24;
	Wed,  4 Jun 2025 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3BUgQAH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5003F149C55;
	Wed,  4 Jun 2025 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998900; cv=none; b=vGiA5qtQcgqVQN6jQ2LlXyNNkrhdOkCdYCtbJFhZ9OJ4epS4CBdEQb3I2E3WUN6aDR2kuuN0eDSu8WOysnecvYh0Cvv96gagx/sm5ImYMnVjDam25pvRsiKmsCZcaW1FQN94k1hgoPGHomd3K2ZIVmeMNq9S+CrJQ3Bzb6neuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998900; c=relaxed/simple;
	bh=n6itwyVu7IznTswjm6Mq1lvXS8BgtKOJkwcUj82VR9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xb3o1oFnKaleSO7jM1UzspWIKPFGIaEB4hhS2FrP0DRO9Kvnr+EfphW8NyUYPoCM9g3LNzSaIRsAo0lCKqhEUxdzhUFCO10hp0TBtYohX+/qrN6z3BDr8Wfy72TucIJjuMuMISty80RRxuHvcho7F6LKRdoSqr60Jpp1IJOFxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3BUgQAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289F9C4CEEF;
	Wed,  4 Jun 2025 01:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998900;
	bh=n6itwyVu7IznTswjm6Mq1lvXS8BgtKOJkwcUj82VR9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3BUgQAHZLgVIM0gzv1Hok2miSrpxsQUYxGSRrLSCSnczsWENRAPNkSMWJvr2kM4i
	 sLtROz1csa3wnzPV0Sc2ZStE83f4sXHlb5P1cfqQvSrfPJExDMfA/piFSZcXTWsDHt
	 CwZVh5FhUy1kiuxCDF5M3xW08oErFzO1Y4nWmGPYrTlqKlsIW/qwPEnGk9Q6dSPXzO
	 C6w/AoCk9qqFTfyTrs2MIEBjeN15xc2fP4rH+ypbdkcFjBxqLU6DJQqo3s6hSkvj1d
	 lWVFnPZJczsHlavTXOnDiL1i4pG3OEQI7RmU65auwg2Zdp6GsQkfoJU14H5OizUJpr
	 0XrN+PxvGdHkQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 77/93] wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping
Date: Tue,  3 Jun 2025 20:59:03 -0400
Message-Id: <20250604005919.4191884-77-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

[ Upstream commit dce7aec6b1f74b0a46b901ab8de1f7bd0515f733 ]

With hardware grouping, during reboot, whenever a device is removed, it
powers down itself and all its partner devices in the same group. Now this
is done by all devices and hence there is multiple power down for devices
and hence the following error messages can be seen:

ath12k_pci 0002:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
ath12k_pci 0002:01:00.0: failed to set mhi state: POWER_OFF(3)
ath12k_pci 0002:01:00.0: failed to set mhi state DEINIT(1) in current mhi state (0x0)
ath12k_pci 0002:01:00.0: failed to set mhi state: DEINIT(1)
ath12k_pci 0003:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
ath12k_pci 0003:01:00.0: failed to set mhi state: POWER_OFF(3)
ath12k_pci 0003:01:00.0: failed to set mhi state DEINIT(1) in current mhi state (0x0)
ath12k_pci 0003:01:00.0: failed to set mhi state: DEINIT(1)
ath12k_pci 0004:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
ath12k_pci 0004:01:00.0: failed to set mhi state: POWER_OFF(3)

To prevent this, check if the ATH12K_PCI_FLAG_INIT_DONE flag is already
set before powering down. If it is set, it indicates that another partner
device has already performed the power down, and this device can skip this
step.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250408-fix_reboot_issues_with_hw_grouping-v4-3-95e7bf048595@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the surrounding kernel code, here
is my assessment: **YES** This commit should be backported to stable
kernel trees. ## Detailed Analysis **The Bug Being Fixed:** The commit
addresses a specific issue with hardware grouping in ath12k WiFi devices
where multiple power-down operations during reboot cause MHI (Modem Host
Interface) state transition errors. The error messages show failed
attempts to set MHI state to POWER_OFF(3) and DEINIT(1) when the current
state is already 0x0, indicating the device has already been powered
down. **Code Changes Analysis:** The fix is extremely minimal and
surgical - it adds only 3 lines of code: ```c if
(!test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags)) return; ``` This
check is added at the beginning of `ath12k_pci_power_down()` function at
line 1491-1492. The logic is sound: 1. **ATH12K_PCI_FLAG_INIT_DONE**
flag is set in `ath12k_pci_start()` (line 1170) when the device is
properly initialized 2. **The flag is cleared** in
`ath12k_pci_power_down()` (line 1500) after successful power down 3.
**The new check** prevents redundant power-down operations by returning
early if the flag is already cleared (meaning device was already powered
down) **Why This Qualifies for Backporting:** 1. **Clear Bug Fix**: The
commit directly addresses user-visible error messages during system
reboot - a clear operational issue affecting stability. 2. **Minimal
Risk**: The change is extremely contained (3 lines) and only affects the
power-down path. It doesn't introduce new functionality or architectural
changes. 3. **Hardware-Specific Issue**: This affects specific WiFi
hardware (QCN9274, WCN7850) that users may have in stable kernel
configurations. 4. **Similar Pattern**: Looking at the similar commits,
commit #2 (ath11k IRQ affinity fix) and commit #4 (MHI PCI shutdown
callback) were both marked as YES for backporting. They share similar
characteristics: - Small, targeted fixes - Address shutdown/reboot
issues - Minimal code changes - Clear problem resolution 5. **Race
Condition Fix**: This addresses a race condition where multiple devices
in a hardware group try to power down simultaneously, which is a classic
stability issue suitable for stable trees. 6. **Low Regression Risk**:
The change only adds an early return condition based on an existing flag
that's already used throughout the codebase for the same purpose -
tracking initialization state. **Supporting Evidence from Code:** - The
`ATH12K_PCI_FLAG_INIT_DONE` flag is already used consistently throughout
the driver to track device state - The MHI error handling code shows
these are expected error paths that should be avoided (lines 529, 607 in
mhi.c) - The commit includes proper testing on multiple hardware
variants This is a textbook example of a stable-tree appropriate fix:
small, targeted, fixes a clear user-impacting bug, with minimal
regression risk.

 drivers/net/wireless/ath/ath12k/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 45d537066345a..34855e2d540ca 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1301,6 +1301,9 @@ void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 
+	if (!test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags))
+		return;
+
 	/* restore aspm in case firmware bootup fails */
 	ath12k_pci_aspm_restore(ab_pci);
 
-- 
2.39.5


