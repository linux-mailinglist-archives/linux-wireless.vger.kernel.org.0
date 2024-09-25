Return-Path: <linux-wireless+bounces-13165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7022F9859A1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB828221B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E041A7269;
	Wed, 25 Sep 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9kPV/kE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53431AB504;
	Wed, 25 Sep 2024 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264383; cv=none; b=f+gMvA7KsrbZV9f7nzsZYDgc4GguMlEd8GaMaPTSmCPG6KfQqMAsijzrHsZMILWcaPgLaZThn7CaoJylyOmEinasIWiwNwAXzpVO89Ipf8EtzG4C1QzUM4dPEZFRjrfCXmprJ/5ePTngYl2fNZ3pCPzez6elpR9gbGUdyxn+1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264383; c=relaxed/simple;
	bh=NDKFUcHo39S3JcK037MgD4trZzK54A0vUtbeOc/5DyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ8Xhnt/9gXBJN22AR3Bkc9wvK/+qO2TPsf9N9aENOTsZcfjfk7rV3m+fPxL2euyEvhmFjd7dFxFokXyOehyPFkd44IlRpW2zp5QDWpQEY4bmzUTF67R7nQoX22lahifmFnOYLqhUEhca5IJFQgCyY3gz/9NxTTAzq9pDuoP+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9kPV/kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E26BC4CEC3;
	Wed, 25 Sep 2024 11:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264382;
	bh=NDKFUcHo39S3JcK037MgD4trZzK54A0vUtbeOc/5DyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9kPV/kEqrWXQ93UTZvS5DSslpI2M3EcuebdRehfS+FdSMJZUapTTbw48CPs9t/SW
	 moPek+x0yWIkXm6U8WDKF06Ft3VA3XzKPkmdyN54wBDpzaBUVeINNPkMfBBgSBD5do
	 1pp9lUov/BOOITa5A6U/tEtVPZ2q3GN6F5OK0ZpI2gQ+y1RZBIk7kz9HFsTNrsriDW
	 NpjIfsyFAIiDPzqky/tK1Z/1BZc5o3wRx6mfjbstJtd5wJKKUdHOgB+2A32FSWBhkL
	 uIvebK+g31oeAk+QgU6Gu4NgIvHB2hL7obsX44geyy2mA80gEDE9VkM9h7UFmf6s1C
	 AplRiXa3EgqUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 076/244] wifi: rtw89: avoid reading out of bounds when loading TX power FW elements
Date: Wed, 25 Sep 2024 07:24:57 -0400
Message-ID: <20240925113641.1297102-76-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit ed2e4bb17a4884cf29c3347353d8aabb7265b46c ]

Because the loop-expression will do one more time before getting false from
cond-expression, the original code copied one more entry size beyond valid
region.

Fix it by moving the entry copy to loop-body.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240902015803.20420-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 11fa003a9788c..a7ec7eed83812 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3909,16 +3909,22 @@ struct rtw89_txpwr_conf {
 	const void *data;
 };
 
+static inline bool rtw89_txpwr_entcpy(void *entry, const void *cursor, u8 size,
+				      const struct rtw89_txpwr_conf *conf)
+{
+	u8 valid_size = min(size, conf->ent_sz);
+
+	memcpy(entry, cursor, valid_size);
+	return true;
+}
+
 #define rtw89_txpwr_conf_valid(conf) (!!(conf)->data)
 
 #define rtw89_for_each_in_txpwr_conf(entry, cursor, conf) \
-	for (typecheck(const void *, cursor), (cursor) = (conf)->data, \
-	     memcpy(&(entry), cursor, \
-		    min_t(u8, sizeof(entry), (conf)->ent_sz)); \
+	for (typecheck(const void *, cursor), (cursor) = (conf)->data; \
 	     (cursor) < (conf)->data + (conf)->num_ents * (conf)->ent_sz; \
-	     (cursor) += (conf)->ent_sz, \
-	     memcpy(&(entry), cursor, \
-		    min_t(u8, sizeof(entry), (conf)->ent_sz)))
+	     (cursor) += (conf)->ent_sz) \
+		if (rtw89_txpwr_entcpy(&(entry), cursor, sizeof(entry), conf))
 
 struct rtw89_txpwr_byrate_data {
 	struct rtw89_txpwr_conf conf;
-- 
2.43.0


