Return-Path: <linux-wireless+bounces-22615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5066AAB109
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4201BC05C6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA337331080;
	Tue,  6 May 2025 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwX66eSW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9E2D611C;
	Mon,  5 May 2025 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485363; cv=none; b=LEqFW+5+rvBZzpf0OI0A5ww/dUmiYls+bJ/9BFe0X0YdxjI75kBmRFYQrNzxELbsAP8jnNAuI77jsiCo4+EfzGpdEBZE2gX/+G/HbjM7hNjfc8arX9vW34tQ8cXVopWyzWGLDb51IK0QL1Eqn+kxFc1o+pko0SAlQfoE6STZH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485363; c=relaxed/simple;
	bh=6frRXfEmp9sek6W1h84jJdh77Uz0lZNi5/Wp9WKpXVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQJVmscbXAeJH8RiIPm8+yAmk3ke3o5RUsNJ7cfb0Sm+ub9Q2BvXcRUfd7yuEVaIjABzW2b//joc2JRUJd85VwHAqzELXtLQ/pzl3H/0rkhmxFjJdCUbChwtawJIBsf36a60pcHGzbIcJw8+BpUPb4RH0zNykA9OFMS6TWVh3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwX66eSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B302C4CEF1;
	Mon,  5 May 2025 22:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485363;
	bh=6frRXfEmp9sek6W1h84jJdh77Uz0lZNi5/Wp9WKpXVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwX66eSWx9X3to9CszQ9QzPvCYBMiOdqVeYoZygiX6MQKH0aEX9v8zJmMHn+KNEHj
	 bpZMC+4hP+E3gC5NeCFbHaoQ+cFbM7remCMitXTiobWf0skCkDMp4FFipGokbVmVwP
	 uVMfrDkKuQZHibi+g/+zRbGf1RZQ6kdrnthLBDUDDX0YKSdWdJvfQcvBGKrnaSgeHz
	 fxfIFTGdcxILyKKfNeH/I13PKVCSY1p11gcBXHOMepR0f6EHwRo6QOfjR68S/R1uWs
	 l6JGYgFCFlJh0WonAv26Bd2GKOYC5tNua9q5fENCMc3+LTA28lB8TfQCxOe8mL1zpo
	 vXQqPvy8YhoTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Chung Chen <damon.chen@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 290/486] wifi: rtw89: 8922a: fix incorrect STA-ID in EHT MU PPDU
Date: Mon,  5 May 2025 18:36:06 -0400
Message-Id: <20250505223922.2682012-290-sashal@kernel.org>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

[ Upstream commit bdce0574243b43b3bb2064f609c0c326df44c4c6 ]

EHT MU PPDU contains user field of EHT-SIG field with STA-ID that
must match AID subfield in the Associate Response. Add a necessary
setting to prevent these from being inconsistent.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250217061235.32031-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 93d760b8b5e35..9346fe082040c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3128,9 +3128,10 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING3 |
 			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING4);
 
-	h2c->w6 = le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
+	h2c->w6 = le32_encode_bits(vif->cfg.aid, CCTLINFO_G7_W6_AID12_PAID) |
+		  le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
 				   CCTLINFO_G7_W6_ULDL);
-	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_ULDL);
+	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_AID12_PAID | CCTLINFO_G7_W6_ULDL);
 
 	if (rtwsta_link) {
 		h2c->w8 = le32_encode_bits(link_sta->he_cap.has_he,
-- 
2.39.5


