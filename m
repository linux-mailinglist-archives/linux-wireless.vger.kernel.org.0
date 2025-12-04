Return-Path: <linux-wireless+bounces-29500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A41CCA39D9
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 13:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D94D303267A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9233290A;
	Thu,  4 Dec 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Rt19lVIy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0F35898;
	Thu,  4 Dec 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851580; cv=none; b=FUAr7nJlL/W9skR07DzFlxgZwk+0ylzgA5Z9E3LKd+EN4vsoHuiCd1DWp6B2KQQIJZtHyV/sC9rZgsacKQd/7/qarpInMDlYeeu7Ux4ixhrcMW+sctbWZtz3bmk1Pv1L5b7+NNToVzJrrsmxwcc11jKsiJpAPtrGWs7I50lQwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851580; c=relaxed/simple;
	bh=nzGviWTowbFDvg9CkLQGTjeKNGLFA8NodFvqRXZKc18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0vlC+72fbQ9T60k+rra4tnDv2U2D6+zrWB892fHsY3T5BKiDtfFY9ZhYPpwZ36QgHvWYTtYVM0rMHLa3luNZuO4PTOP7WZQgCYsg9eFO71++7gQwtYYgcRVTU7akPE65/6miUMf4VsCQr20UO1Fw4eOKWO0+FI2wtZKRYpKstk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Rt19lVIy; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CC953265D7;
	Thu,  4 Dec 2025 13:32:49 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dSzCFe4Mlnug; Thu,  4 Dec 2025 13:32:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764851569; bh=nzGviWTowbFDvg9CkLQGTjeKNGLFA8NodFvqRXZKc18=;
	h=From:To:Cc:Subject:Date;
	b=Rt19lVIyfW3kp5P/XWUOixuLx7wqH3cjMi9Zz5zGL2y2+Jy2phaNSCqH697MiQg+l
	 MTL7lUu2iHf3xLJjgvM5M9qV7i8o2TSU+n0kxUZLpX++5J1B9TJudUcEpyjgfTt/0q
	 H0SHULImyiyelmKyJgPopbEZ6LuWGoJn14xXP3c7C4o2UOb0BJMpgsLUnrmysMINHa
	 SwE7Lfr02y/xzrgWHxSqMEnw7QaP8yfkoZd8wglsEsKuck23Lt3wHl0ZNt5NcHmb6S
	 a1UkijaEMaODqHJvZtvkVYkwTIrUqShgNVS4eqypR4OsFAuZEh5GmZOx/Z59TXiv/1
	 v1VKeHDHzeLYw==
From: Yao Zi <ziyao@disroot.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP
Date: Thu,  4 Dec 2025 12:32:04 +0000
Message-ID: <20251204123204.9316-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if
required ops are NULL"), PTP clock registered through ptp_clock_register
is required to have ptp_clock_info.settime64 set, however, neither MVM
nor MLD's PTP clock implementation sets it, resulting in warnings when
the interface starts up, like

WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469
CPU: 1 UID: 0 PID: 469 Comm: wpa_supplicant Not tainted 6.18.0+ #101 PREEMPT(full)
ra: ffff800002732cd4 iwl_mvm_ptp_init+0x114/0x188 [iwlmvm]
ERA: 9000000002fdc468 ptp_clock_register+0x2c8/0x6b8
iwlwifi 0000:01:00.0: Failed to register PHC clock (-22)

I don't find an appropriate firmware interface to implement settime64()
for iwlwifi MLD/MVM, thus instead create a stub that returns
-EOPTNOTSUPP only, suppressing the warning and allowing the PTP clock to
be registered.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 7 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
index ffeb37a7f830..231920425c06 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -121,6 +121,12 @@ static int iwl_mld_ptp_gettime(struct ptp_clock_info *ptp,
 	return 0;
 }
 
+static int iwl_mld_ptp_settime(struct ptp_clock_info *ptp,
+			       const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
 static int iwl_mld_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct iwl_mld *mld = container_of(ptp, struct iwl_mld,
@@ -279,6 +285,7 @@ void iwl_mld_ptp_init(struct iwl_mld *mld)
 
 	mld->ptp_data.ptp_clock_info.owner = THIS_MODULE;
 	mld->ptp_data.ptp_clock_info.gettime64 = iwl_mld_ptp_gettime;
+	mld->ptp_data.ptp_clock_info.settime64 = iwl_mld_ptp_settime;
 	mld->ptp_data.ptp_clock_info.max_adj = 0x7fffffff;
 	mld->ptp_data.ptp_clock_info.adjtime = iwl_mld_ptp_adjtime;
 	mld->ptp_data.ptp_clock_info.adjfine = iwl_mld_ptp_adjfine;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
index 06a4c9f74797..ad156b82eaa9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -220,6 +220,12 @@ static int iwl_mvm_ptp_gettime(struct ptp_clock_info *ptp,
 	return 0;
 }
 
+static int iwl_mvm_ptp_settime(struct ptp_clock_info *ptp,
+			       const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
 static int iwl_mvm_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct iwl_mvm *mvm = container_of(ptp, struct iwl_mvm,
@@ -281,6 +287,7 @@ void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
 	mvm->ptp_data.ptp_clock_info.adjfine = iwl_mvm_ptp_adjfine;
 	mvm->ptp_data.ptp_clock_info.adjtime = iwl_mvm_ptp_adjtime;
 	mvm->ptp_data.ptp_clock_info.gettime64 = iwl_mvm_ptp_gettime;
+	mvm->ptp_data.ptp_clock_info.settime64 = iwl_mvm_ptp_settime;
 	mvm->ptp_data.scaled_freq = SCALE_FACTOR;
 
 	/* Give a short 'friendly name' to identify the PHC clock */
-- 
2.51.2


