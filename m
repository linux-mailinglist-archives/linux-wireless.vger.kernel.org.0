Return-Path: <linux-wireless+bounces-9094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE87690AFEE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E461F22866
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55DE19B5A2;
	Mon, 17 Jun 2024 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2egVMGQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D41C8FB1;
	Mon, 17 Jun 2024 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630642; cv=none; b=s5fR7A5T1VPDYsXEPCo6cmiEdsTn+fWtzot89umGQM+je+bSBrXfggzInBgel+3mOFOKrnH8P+XdrVFFdkU1mdGi6eKR2LK4BjAt13F2k4ifQgo1YUKJCIaYsY2USJFl4wHMVuQjWq88KdWAhrHgGBbyRKUH71DEL8cEHH6d2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630642; c=relaxed/simple;
	bh=Y/sTL8De8IA5zym0cEmbpB/VBmXT3Mu2W5mIyeOmsIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXXs0+9dNwfF389oxzmbuj4NAMEgIil+g2x0d71ShtOD8eUGV7t/kkQU5hHetc0cmb7VwZmVnQ0PR67oQQ0sfe2TwrZ3SVRfeEeBQ79kDENqhQ9KyyaiY36JV99sDF1e+BAlhkh1g9wyzZ5i3yHD5z3BWW2V6Y/njM9Ojr5RAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2egVMGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E641C4AF48;
	Mon, 17 Jun 2024 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630642;
	bh=Y/sTL8De8IA5zym0cEmbpB/VBmXT3Mu2W5mIyeOmsIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2egVMGQGW+nw5NBqatJscAxwkapFP7VKrvINNV2MnP4j5cW2NdgBMDfiEeIHgXPL
	 0KnRrTPhDwXHF4qxJVhwXcz+KeEKb0EbLPkEXvm3ksnPJUjZUBBwGkyVkOH1ZscXEt
	 B5bka+N46sBItxJgNMuwo4zBpr/5LRwf7sOsuIYrSMcZ2B4piy8CFz43vgW887L6og
	 VHR8/Poau+9/yzjn1+15h+0rZfQZ04ZUNIlyZTplIdY2iRr0myUBgwXCDV0JksQRRm
	 8ORtlZFEW1EmEjHlPj2A4Qp/KrtvCTOzgDVVCRtPSJVszelLYLQinvSaBCRC9IlrbY
	 kRszjnyMJ2bKg==
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
Date: Mon, 17 Jun 2024 09:22:18 -0400
Message-ID: <20240617132309.2588101-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
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


