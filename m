Return-Path: <linux-wireless+bounces-9156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B673890CBFF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC561F22430
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553901586F5;
	Tue, 18 Jun 2024 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7UnziWU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC221586DB;
	Tue, 18 Jun 2024 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714206; cv=none; b=K7oLiaJcIFbZcm3OfTo+vMgjCQr4Kwi2mqPJIIHshoUhLuEPO4kqJR9uot8AL8ASqYLHHUWspRu8WNBil78iKonLLz63bEuN227Drxo5ZJW7mvuwquBRPOwU1fSE904zJ0ZzfQvjeOd9zSpwOPJ6Bng8WZFFSO9M5TUvBPwovFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714206; c=relaxed/simple;
	bh=M1RugjN3VHPCtRbmhntRu0CJdvCroRDFgqX2s4cLkOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjCxBqDVrleXNDXH00uRY0fKoCincCE0eCc317+TVfmGds48dIsBUCJbrMF1Y3PR4Z6AuEV6UAx9/RPq3CUNwI52C+cgvcdEiSLI9mlWpRwEPiqOXeh/KTCegneDIpkP+u+1AMzE0Mw9n3cawli60p7loGpPC9GO+pFPbkEvOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7UnziWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF407C32786;
	Tue, 18 Jun 2024 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714206;
	bh=M1RugjN3VHPCtRbmhntRu0CJdvCroRDFgqX2s4cLkOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7UnziWUtygDr7lmGnHOePxS+SLzJdjKSmRk7lMN6PY/wjxwAg7PJADphfmWmOquU
	 BvGH7AarZJhoBcCZVSlTuturJEN92IcEBYXoAbFNg8Jv7/ZfwsL1k3xiZVJvrVwRn7
	 QYRaP7UohBwlchmEJ4i2yXFJih851bky9V3iuNedwo8rWqEXLrQ9x1EI8IuqZanNFY
	 P08bmUkgP8/jwUlZ+ebDtDvYxxnlHrUOsNFvXk3g84gpOHqOkkQUACh0EnXkx1CV1+
	 HM3pLYLGqCUqBLorfPCDgdJJMcBc3EE99/MCp4LE4zFvQLsKWxh6D70YKzWQCqOeTZ
	 xm89fdzCd7GOg==
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
Date: Tue, 18 Jun 2024 08:34:59 -0400
Message-ID: <20240618123611.3301370-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
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


