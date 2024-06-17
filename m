Return-Path: <linux-wireless+bounces-9100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA190B096
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D83D1F2661A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F6A177353;
	Mon, 17 Jun 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NamWv51z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050F177352;
	Mon, 17 Jun 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630726; cv=none; b=QE/YH1IQpQyoYTyDBqrZljA0N7/wdHzt24DKh9LjDQb2Ez24fb6/2LmiaGxBV4o6lBWh+R6aL/Q8Kw9JdG5UxbdbZTanZ/RFyEJviMSlyS3ruRJ3s2ojAjeTu4KnDBVcKMfjo9R1chL6xVkTBOtSjWfm8xKrTvEpWmwxv6xYKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630726; c=relaxed/simple;
	bh=6YK1nSfeH51EVhdHDofsARKpTId9VzEdXwFMFFgqiWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baRT2MNb+o0HmkriSVWQd/UIU4YWs9NaUi9AIUkk8Vs+07mp2otqnLGIg48S5k+loJz4u95tlT0UbN4sMuXTW+Iqz5f30eHhI6ms9+1zJM2SYxz94ZQKE1ghelrqMDY3nw5qsQL2O0J6aToRKMpoPhN/QFickPZIOMuTGMsR2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NamWv51z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CA2C2BD10;
	Mon, 17 Jun 2024 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630725;
	bh=6YK1nSfeH51EVhdHDofsARKpTId9VzEdXwFMFFgqiWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NamWv51z+PyQCqOrJsyLWipmCC2AP9XdETNvcVdzAI1uohOYxJVpEyPH0Zz/53fpb
	 5CB1MV5H2gG0cSJBFQKemy0eTvoapBGFMMhVPH+8c8z6/bpwBxmgfRdaUob65WvQBV
	 P93X90JqUlAOy24hgEiJ9skE6QjCyQYbDUMuKEBX1bqA3qw1IaSFaTjTmIe/S6sFsn
	 9g7Y0yhJNZl/cznKRrzgwBIFe//+TDwZWOIL95tV/92cRozdH5eYPpAveZc2cdvzbm
	 7aCXxfxmWPUvrXVAlRDHTFtQjAZxyzdcnQr3JgsIZCfkCgZ3Wsqe1emf94u15MUfmH
	 9kbEdfjxmqtOQ==
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
Subject: [PATCH AUTOSEL 6.1 15/29] wifi: iwlwifi: mvm: d3: fix WoWLAN command version lookup
Date: Mon, 17 Jun 2024 09:24:19 -0400
Message-ID: <20240617132456.2588952-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
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
index 88f4f429d875c..9a36ce98b5bfc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1934,7 +1934,8 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
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


