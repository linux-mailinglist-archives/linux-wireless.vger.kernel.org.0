Return-Path: <linux-wireless+bounces-22617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4056AAB1D1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6B416369E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F041B782;
	Tue,  6 May 2025 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcMBiFvX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B62D47A0;
	Mon,  5 May 2025 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485618; cv=none; b=bQDYLR/p/X/bz6LmsdP0htXWtJ5joLNhqBHsMolUVOH+SqR33m5i/i6PAiqJMDcsjEshTVjggg5TFbS9VQ6D7jMcGYG2XD0VaxuXOJexeVzH17CO3bfPc6JVQ3v3PZ2brvBRDNSyiQDtJpSPXWDrIxH0WgliJPvHMxGl7y/tGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485618; c=relaxed/simple;
	bh=7qWmpSCbmCkbyX0HI+xB5K/1jBgksHFuwBEjz21DAnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIKSJmzsG169FW4MrohfCZ2ZWrFuNxQ9DhKGpkHhSGn9vE3ipk15Y0TGgqVUKJFwQ8N99BkBisjxbFbgozDMSu7yNlC+O2VFNYiKlv8zjCTkphZziLZlKJVrIDUdQRVCaXdZXoz4+OKYptxYTEz2NOkF65f+7PUhF0fJw3awz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcMBiFvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13184C4CEE4;
	Mon,  5 May 2025 22:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485617;
	bh=7qWmpSCbmCkbyX0HI+xB5K/1jBgksHFuwBEjz21DAnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PcMBiFvXiIaSnDQjbdUluVClVXpSbHpf2L2sIFseSPm5vx8locbZqt0E4t9w4/OvD
	 xw2XTjrCwcPQgvtQ5KFekuqn3yIebZpD+dYVX7LUkdKX09C1cxnBtQWixqTWegrVNP
	 3zcGv0bK7PRO/7GpoRlCELMJJ59HylIhKEpCbM4phAB3FbkXCCyHrodFMsjo5215Ew
	 DIamv5HvpnmQpD/tnB5tmZIoaG3eJpY9xICE8mm7eyvTrWRBj2VVp4UQAXPOtQFPuT
	 yCJ3RIKZj1qBgUORczsQv+m0WngUNSjg2fLG8BxQhegO+EtySCJSyZ9ORJWtLsYfQF
	 uc5jLH/BZozkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 389/486] wifi: iwlwifi: don't warn during reprobe
Date: Mon,  5 May 2025 18:37:45 -0400
Message-Id: <20250505223922.2682012-389-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 696cca64308dc641d0bbe4aa2c09dd9752aa288d ]

During reprobe, the sw state is being destroyd, and so is the
connection. When the peer STA is being removed, the opmode sends a
command to flush the TXQs of the STA and uses iwl_trans_wait_txq_empty.

This one warns if the FW is not alive, but it really shouldn't if
there is a FW error - and return silently instead, just like we do when
sending a hcmd.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20250205145347.76425b10e5a0.I3bf0de2eb090a8b94c4e36d93dd91df61fadb808@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index c88e4c20b505f..783f9c1254130 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -455,6 +455,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_txq_enable_cfg);
 
 int iwl_trans_wait_txq_empty(struct iwl_trans *trans, int queue)
 {
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
+		return -EIO;
+
 	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
 		      "bad state = %d\n", trans->state))
 		return -EIO;
-- 
2.39.5


