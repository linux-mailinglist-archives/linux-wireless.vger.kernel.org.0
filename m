Return-Path: <linux-wireless+bounces-9077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7890B144
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9FE6B310E8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215F1A38D4;
	Mon, 17 Jun 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC5KQ1of"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3981A38D0;
	Mon, 17 Jun 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630481; cv=none; b=HliwtbyymrIqhSth+oPvieEXGIBQe8j7ZTvY1djaTKVYxjIL+Adu1GcAe6ut8MrjDvFrN9+9EDp4peTUSBTj/j/Yv0TxLMUP3Y0/cbgDb/UGcHpLPkMM/jqTM0YUkfAOHy8OU+tDB+bUDqGJzjJZHx2X1Pwe/awuIxkt4UhIyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630481; c=relaxed/simple;
	bh=M1RugjN3VHPCtRbmhntRu0CJdvCroRDFgqX2s4cLkOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oC7LTxJh5J+u9WzVa5K4toUKX3wIbs+9yRN1C8m79tUDZYcvDQ69GyRdPfVsEwP2y7lAPlDTNVC+jDtZBi3kQC1zh4xVWsydBOtcvHBa8BPiwCVgPvBHkGNXNm4GLTlWj+UhSOqnH47EbYE+k5oW1DVYS/ClFfMS68AEkqlbemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC5KQ1of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3BAC2BD10;
	Mon, 17 Jun 2024 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630480;
	bh=M1RugjN3VHPCtRbmhntRu0CJdvCroRDFgqX2s4cLkOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PC5KQ1ofBISPIoW+iqazHgq+TCmFb6iHv74ksVmOHupgBgFibnezhWuhbZGpUa6mF
	 kO1elsFz+jIdMaz+P42vOTY05UDkpncnN0sqLwYFO3rw3hQPfo7kqWWLBtPXtXfY+9
	 /mr87kuIxNqnVFn8DksGpWou5rwS6HQQYuXzYoQDT3pVDSki9jx0FW05y3IQcQR+Bx
	 nu6I7o7mDjkVpj9CuBUSd5PXLkNsZr7pi8RwH0IWkxs338x5dcCFTU/clWpw6wfEj4
	 jm8cNz8fbEuKPlJJqslumfAEIW5MfBePXd5JMBz/y84nG9KZ4VW4jvZBln9tL1EHQn
	 gEXs1QmY+96aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	shaul.triebitz@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 18/44] wifi: iwlwifi: mvm: d3: fix WoWLAN command version lookup
Date: Mon, 17 Jun 2024 09:19:31 -0400
Message-ID: <20240617132046.2587008-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

[ Upstream commit b7ffca99313d856f7d1cc89038d9061b128e8e97 ]

After moving from commands to notificaitons in the d3 resume flow,
removing the WOWLAN_GET_STATUSES and REPLY_OFFLOADS_QUERY_CMD causes
the return of the default value when looking up their version.
Returning zero here results in the driver sending the not supported
NON_QOS_TX_COUNTER_CMD.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240510170500.8cabfd580614.If3a0db9851f56041f8f5360959354abd5379224a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 52518a47554e7..74743c3ceeefb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2182,7 +2182,8 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
 out:
 	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
-				    WOWLAN_GET_STATUSES, 0) < 10) {
+				    WOWLAN_GET_STATUSES,
+				    IWL_FW_CMD_VER_UNKNOWN) < 10) {
 		mvmvif->seqno_valid = true;
 		/* +0x10 because the set API expects next-to-use, not last-used */
 		mvmvif->seqno = status->non_qos_seq_ctr + 0x10;
-- 
2.43.0


