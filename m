Return-Path: <linux-wireless+bounces-9172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E5F90CC91
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EE81C23706
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F528185E6E;
	Tue, 18 Jun 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkNHr8iz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75771185E68;
	Tue, 18 Jun 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714365; cv=none; b=SyGZECD2JTXvLjnq+kDG4WCGV7Y49sej0xsGVgArc1PPuSELuuoutEdlgZEwNRQIxpXhsO3r5umqu6eE9i7TZKsJyLYoYkIvV2q+0uucEVs9cR9v09+9MYjcGKhN1x1dAzfB25W/r0KitIl4traz6kOwkUpfOSpBErlsDV7+xHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714365; c=relaxed/simple;
	bh=Y/sTL8De8IA5zym0cEmbpB/VBmXT3Mu2W5mIyeOmsIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMwk0mBzIiNm7rqZxdGmIVWInRXsWoMkhXIIcf2WVXGplnJ6jEtuteQivjRQd23+iltPGS8BQyscwtGMzgLz0qJDBffXe1O6MfPpgaBt4alm0iqHp6dID50cKqE3fFhTe0zk/qrBESv6VbtbDi6R6yUEJ2J7Ih2TZjFiNHXkPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkNHr8iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B17C32786;
	Tue, 18 Jun 2024 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714365;
	bh=Y/sTL8De8IA5zym0cEmbpB/VBmXT3Mu2W5mIyeOmsIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkNHr8izMl+9xHYB8S0jPj1Ql8Uu6FZZygZmGhg+EFYdf8fYzRPVptr4Q4pGmVz3E
	 GOdO643jqKny1YazPphEqZ//xo2AKEt5/ARg+CsCbBra2RrgK8c2ZgOwJY8aH+Xcj+
	 oiybJfutg5ph5UhmXKBBH6q5MSHI9hMAZZofqGd53NQrUziVs7/l9NbZvF605GR46V
	 sZyfzwe5+iWl1fkOZiQaGAEkULa7vuJXZo837KzYdkSTSeTKabFTs9wzYMAZDxXF1Z
	 v5LiF5+IkdRGhd0ogT1xMRomC0UBb4C0MKURmqKQFon2y7dBFM5eo5YtYgYnec5Xfd
	 Y9eWkGKuBRV6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	ayala.beker@intel.com,
	gregory.greenman@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/35] wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill
Date: Tue, 18 Jun 2024 08:37:40 -0400
Message-ID: <20240618123831.3302346-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit e6dd2936ce7ce94a1915b799f8af8193ec628e87 ]

When HW rfkill is toggled to disable the RF, the flow to stop scan is
called. When trying to send the command to abort the scan, since
HW rfkill is toggled, the command is not sent due to rfkill being
asserted, and -ERFKILL is returned from iwl_trans_send_cmd(), but this
is silently ignored in iwl_mvm_send_cmd() and thus the scan abort flow
continues to wait for scan complete notification and fails. Since it
fails, the UID to type mapping is not cleared, and thus a warning is
later fired when trying to stop the interface.

To fix this, modify the UMAC scan abort flow to force sending the
scan abort command even when in rfkill, so stop the FW from accessing
the radio etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240513132416.8cbe2f8c1a97.Iffe235c12a919dafec88eef399eb1f7bae2c5bdb@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index d1dae33fe8884..662d07b45713b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3242,10 +3242,11 @@ static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
 
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
-				   0, sizeof(cmd), &cmd);
+				   CMD_SEND_IN_RFKILL, sizeof(cmd), &cmd);
 	if (!ret)
 		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
 
+	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d\n", ret);
 	return ret;
 }
 
-- 
2.43.0


