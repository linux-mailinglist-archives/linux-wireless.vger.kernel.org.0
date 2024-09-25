Return-Path: <linux-wireless+bounces-13185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD132985CE5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C520286FAE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF4F1D5CF2;
	Wed, 25 Sep 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkmJCqy4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640018A6DF;
	Wed, 25 Sep 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265654; cv=none; b=r2XFsN18OF6oT3kVrQ53yTWZC1EnJuEgFC8xtXKuXxNykOFfq0Fq8Pl7cZWxU29mJvm2NDSPtDzdk6rh4YHSmZupWtWlAstw6NxUb82Eydy50pW5JBCcHG1e8D2DTDlVQ3IDz0nvDlNdZXL/ACUcZxBykfDrng83Dc8uTQ3YXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265654; c=relaxed/simple;
	bh=P2w64Aq2efARiZ8VGD56xRaPJVP2QrWbD3IRoDCqVMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxmnRow6t5V+BQf/I1AeZhqNkaO8aDeof1Zjug+sp+SOO+B9kMMojH6s2cBy/hKNiynNm6zD+196b1/aTDWwgPxkbjtJUTPTZ+AUKqM6ng8LoaIDtsBbq689H/WHrijCib+sh9Yr5QFPwhWtGJOagkTTOJBMr40QBVPt3DoE6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkmJCqy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0326EC4CEC3;
	Wed, 25 Sep 2024 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265653;
	bh=P2w64Aq2efARiZ8VGD56xRaPJVP2QrWbD3IRoDCqVMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkmJCqy43TFOgIyBIUncUErEUJFZm7lEqcpwY0sA1CKn3L+2x5E+gXZH7LC3j//cp
	 Yb/+8/xSdlASXpttL5qTSy4k/tKnu+QPVwDt0ZkLutsFAZvHpfNSUgdpLTmT4stuPJ
	 CDOqtTyDJvHbqrDxYeAFzRbVMQyhUnT+CgMLBKWH49P/BBF9STGhVm+PszM9yxhS2v
	 ZGv7sAMckNgtrNhTD6FemKy5GuCMgfez4oHTSLhXWCcIvh0XOXwcTqTpfA44x+QvUc
	 LoycHMsnbKzd6Nw3kdJCQEy/FuA86fJIIWy4acjE3jGEgRWf1UvkL4inKS5TUJ0wMK
	 slc4i25gxdTmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 061/197] wifi: rtw89: avoid reading out of bounds when loading TX power FW elements
Date: Wed, 25 Sep 2024 07:51:20 -0400
Message-ID: <20240925115823.1303019-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 112bdd95fc6ea..504660ee3cba3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3888,16 +3888,22 @@ struct rtw89_txpwr_conf {
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


