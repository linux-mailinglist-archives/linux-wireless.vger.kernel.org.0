Return-Path: <linux-wireless+bounces-9181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682090CD15
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D65EB27606
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B461A4F10;
	Tue, 18 Jun 2024 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbxbFff1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E713BC20;
	Tue, 18 Jun 2024 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714458; cv=none; b=YfNxiDemIGaTYTC7Hu3bUqS/kiTNLBUPOB4xe18YflJ/nTRjP8RhTnFBf8N7+wLQfnmSiwLKoLEucdiW3ePlIbRiZuASdnmQ8OQMJkH42HkoQtz2hOFtEsFnR66n4bHroE5YJwGK0stPRkQzXYQ0qzeVHfqRh5Ngvx6MbDYNwjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714458; c=relaxed/simple;
	bh=iWE2UB15Ff60WGB6hHzzKXo7kY7WJ33e1jmtNvHU3Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5l81hOv0Zi6Ado3TRCjvMPdTMV1+E88kADpfXYSD8IEK+RnXJKAE1ob5Yd5PYwBJdWoRekeUsiAzhjBYdLlSgCqsStbcKCs2dPrm5Woisvz57kZ6m8EPPq4sSnOrSciIPi1bGpjFlrEHIcpk7qYhCcPEsjUK4X9aBnsol+N0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbxbFff1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6A0C32786;
	Tue, 18 Jun 2024 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714457;
	bh=iWE2UB15Ff60WGB6hHzzKXo7kY7WJ33e1jmtNvHU3Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbxbFff1Agmthgt0Q5IyiP36EbmnH+tr4EInFDsVRQ9OcO/m5wrTlKWHRTDux0uBa
	 VNE54IDApEinnjAcdOi6mMwZCMT7et3DolAxpqGtW3BP1Gc1zwpvThXm9qi5Cjsti2
	 RAlrWzhKrbvcTcfSHUEvETUT6xLAXXaq6z1nhGgtnN3T1JatTatsGwyRrHnUXV7zqW
	 CPYVJiRxjyTuDBb2f54Vbx23z5fFWL0SD8cFdBliOwZ4lWKZ36z+Kcwo+Tx3Cum2TJ
	 mVLN+ywSq1zPXyArFJaIxpwz08AB+9Xk+HzsDrjQzu6Td348PFOWIMbQ0YrYhgbkJI
	 2Z48LzuY241FA==
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
Subject: [PATCH AUTOSEL 6.1 18/29] wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill
Date: Tue, 18 Jun 2024 08:39:44 -0400
Message-ID: <20240618124018.3303162-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
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
index 686a55515cdec..9bb8533874d8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3057,10 +3057,11 @@ static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
 
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


