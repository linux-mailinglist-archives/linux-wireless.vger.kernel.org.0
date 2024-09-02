Return-Path: <linux-wireless+bounces-12305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF02967DA3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 03:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B745C1F22461
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 01:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D661F949;
	Mon,  2 Sep 2024 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JBrktD2M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3122331
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242304; cv=none; b=tBlKC3+0dwWROagiQWl+nT3pB5e5i/JHs9YavSt8kgoYxQaN/jS3uKUBnlLnIKyMureJPvRAAPrrn9VCbTDK8p5uE7jqO0/y4kWCjzQPk5mrKPxRfxI9B+Hel1YHtxlOpvBo96CxacjwIE/Ip6OXdh7tmrpb6bzWPsAn6xOZMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242304; c=relaxed/simple;
	bh=1YzZv6o4l9Fr+wZUluIwJ4PL0a5/ndLc9PxoIXISyEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OmNNvTbhLeXNJKI1Kf2323zO8J6X3z/LW9NWmO13vQN2gpUaUccBqs/AFwgI8/eJA+6VboHoJVjkGdJQAm5+pCT3rB0bKU4zO6m9gnPQb2Vw80NA2xByx/82pxUFAuWpg0MGKnXabEKYMAFgNNAvd5O9vwlnd67C7nBa1GIFWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JBrktD2M; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4821wJpmD3542854, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725242299; bh=1YzZv6o4l9Fr+wZUluIwJ4PL0a5/ndLc9PxoIXISyEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=JBrktD2MvhJG6NQKTwNUKhCwgYVzcVeYzikTg7R8LSG/MoNBJZ0RlGL3P3O6kRm+D
	 IV+X3bArj4gRYQRMkFeJlFArkd1PtZ6ysaCOT2rmvLDjUabvZpDn3qvKDAxONsRkhP
	 d2mD7ur2XQNx3sZBVcceOyak5u23eo5VI0cy/nT9wGlosGwrhb0UIelyw0a70qwH7q
	 10rAJ4gj7gS4lur6mLbl14spPmWVYJFpngJPUUTGES5sY622wF45Frx0tIQAhjEKOf
	 cZSfP9Z8/Wg6Htb/Y/p3vh3smvuLSCpTVafUXh6IbAY0ac23U0uNqcCtaoH7i0jbHT
	 lWdP5CGJcRVaQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4821wJpmD3542854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 2 Sep 2024 09:58:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 09:58:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 2 Sep
 2024 09:58:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH] wifi: rtw89: avoid reading out of bounds when loading TX power FW elements
Date: Mon, 2 Sep 2024 09:58:03 +0800
Message-ID: <20240902015803.20420-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Because the loop-expression will do one more time before getting false from
cond-expression, the original code copied one more entry size beyond valid
region.

Fix it by moving the entry copy to loop-body.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7c3aeedfd93a..4e8914218044 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3970,16 +3970,22 @@ struct rtw89_txpwr_conf {
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
2.25.1


