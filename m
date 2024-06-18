Return-Path: <linux-wireless+bounces-9167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C090CCB2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D4DB22167
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860D3179650;
	Tue, 18 Jun 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfrGmTqP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E613179647;
	Tue, 18 Jun 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714341; cv=none; b=aEgkpPf6buZg+AtoL5UWNoIoZIgUEZaEMNmRP6A2L5Jn9cu57jDEZcgsq+t2MhVd97017xvv+kvLLs9/adHZhqDM5EN/KdKy8d9wZAebO1GR30ElrZDa/jLbQ1Fw616FuunZmoNstt6hj3Z7clDG6Ej3I55MhoyJKyjs5dqW/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714341; c=relaxed/simple;
	bh=XIyGDgJu4dSKHhftQsplVuFzDPLqDZkaH9/qzAjpwcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PklYJD+OB70xuNvl2wd/aI4sqvoKq3YlhXd3XOviMhv87/MZoKq9xVAM1PlgStpdDrcOWX309RB0yPHsPkTN1E9YmX5js8KYVQZIkzVmL/EgUKHOjbvRMIXZMt1SX/hTVGE/eEb118ZXDMtK2hcJZh6n0LGtJ+lDUL/lLVtAKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfrGmTqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1951BC4AF50;
	Tue, 18 Jun 2024 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714341;
	bh=XIyGDgJu4dSKHhftQsplVuFzDPLqDZkaH9/qzAjpwcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfrGmTqP3dxGN4c3ztWFqfg2dk/TkPRFYoKmwKM4+BZ1DJZRH25htWGNEgev9UB9b
	 CSWT3NW9IfVw63L8miXMNL5GF999r/H3KtIs4wRNG4OcWunwJBCNbkIqhZhTz9kNAd
	 JBQRcvjBhlAi39C2TVq1nr9+xEXAsAqvx6iuIVuaAciWij0TdlXawjtJqyeUzjtbRe
	 rWbA6YpACQCpw0xoNAJU9ZmJSFn0Pp+HJT6EqfDhIPwiiQIGiUdGGQjYD1ykefP9XH
	 Ma6AMeJ0UIEK+Z8jPd1e1Tyrix8aKNsBKWl1DtiX1JdzYNzK10u8g0Q5+VWcXTFpIs
	 jj1X0AQ1rpdSw==
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
Subject: [PATCH AUTOSEL 6.6 15/35] wifi: iwlwifi: mvm: d3: fix WoWLAN command version lookup
Date: Tue, 18 Jun 2024 08:37:35 -0400
Message-ID: <20240618123831.3302346-15-sashal@kernel.org>
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
index cfc239b272eb7..66aed6635d92c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2102,7 +2102,8 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
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


