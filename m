Return-Path: <linux-wireless+bounces-31100-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBcSIubRcmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31100-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 334D06F351
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11BA93006115
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E96356A2C;
	Fri, 23 Jan 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="N6KcEEgq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0862F0C5B
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132512; cv=none; b=kafebsCJgAYt2XmTSwp1tTUtsyezmb4yl6aq0m3pRLYLzAnlcA+AcmZqvoPC/jA9uNNAFMU+6r8HjPwVPZm7UgF+NSZ5wUcqpyZna6zByXscPjR/1rATiPA8C0c8cO3j5wO7i+13UMO+AAwl4JXSiOlXToI875DXQUUNOtwzlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132512; c=relaxed/simple;
	bh=tLLfPaQ5mG9u/AWSKARryFR+sTpZpi51jwKPL/ZkxVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9om7G093Ir4Go3QDbhNzyytv873KCCfuYF0zjp15sTMcSfHqhMLM33UkTfuQ5M0gjrIXS5Ru19Np2NaXHTSSycRy5X4EvZ/x0ApCgwOrkVJxb8cDk0pV6WvPu3i2hgyU8RQESvKb6D3SHx2znW0o1snkeTRBor4Y6KSeabN1xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=N6KcEEgq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1fXjP52207706, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132493; bh=MuYlOyC7ujVk+aO5fPW68AxARqNamTwVynNoCBl7WVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=N6KcEEgqgTvIsXhgZuJxPlOezv0mo8qI5uXP5+K2vDcUo7Ur7D13Zz+ANn6ymM18W
	 BQ49+DwPuOeZ5RdTb6G55aoO6IddD9FF2nJbcn14m1wTtPvLaSGaRtM3SDXEqXE3yI
	 jtLsL75NC7hKv/sK7UKLe5g8xM1Tw3KISzMlXvyDhK7XZMPxMwGMmoPzwrzULZNy1d
	 z1T60MHDQu9nE6DC4ZIaBN4p/W4Fp5dGQs8cAGr2a734tttu099EdMn2OdGsL+J1Ox
	 KK9SyqoraeuH0u70VkPCsp2M5rLqvA3f1kvOWrhGgJqG1nzjDR/H8lOx2+Rnd1foSn
	 zZYMswd0XGbzg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1fXjP52207706
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:41:33 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:41:33 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:41:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/11] wifi: rtw89: regd: update regulatory map to R73-R54
Date: Fri, 23 Jan 2026 09:39:57 +0800
Message-ID: <20260123013957.16418-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260123013957.16418-1-pkshih@realtek.com>
References: <20260123013957.16418-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31100-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: 334D06F351
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Sync Realtek Channel Plan R73 and Realtek Regulatory R54.
Configure 6 GHz field of Realtek regd for the following countries.
PY NA BD ID VN TN GL GP YT EH

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index c3425ed44732..28466cb35ea2 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -38,7 +38,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("MX", RTW89_MEXICO, RTW89_MEXICO, RTW89_FCC, 0x0),
 	COUNTRY_REGD("NI", RTW89_FCC, RTW89_FCC, RTW89_NA, 0x0),
 	COUNTRY_REGD("PA", RTW89_FCC, RTW89_FCC, RTW89_NA, 0x0),
-	COUNTRY_REGD("PY", RTW89_FCC, RTW89_FCC, RTW89_NA, 0x0),
+	COUNTRY_REGD("PY", RTW89_FCC, RTW89_FCC, RTW89_FCC, 0x0),
 	COUNTRY_REGD("PE", RTW89_FCC, RTW89_FCC, RTW89_FCC, 0x0),
 	COUNTRY_REGD("US", RTW89_FCC, RTW89_FCC, RTW89_FCC, 0x1),
 	COUNTRY_REGD("UY", RTW89_FCC, RTW89_FCC, RTW89_NA, 0x0),
@@ -95,7 +95,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("MK", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("MA", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("MZ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
-	COUNTRY_REGD("NA", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
+	COUNTRY_REGD("NA", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("NG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("OM", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("QA", RTW89_QATAR, RTW89_QATAR, RTW89_QATAR, 0x0),
@@ -111,12 +111,12 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("AE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("YE", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("ZW", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
-	COUNTRY_REGD("BD", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
+	COUNTRY_REGD("BD", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("KH", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("CN", RTW89_CN, RTW89_CN, RTW89_CN, 0x0),
 	COUNTRY_REGD("HK", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("IN", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
-	COUNTRY_REGD("ID", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
+	COUNTRY_REGD("ID", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("KR", RTW89_KCC, RTW89_KCC, RTW89_KCC, 0x1),
 	COUNTRY_REGD("MY", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("PK", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
@@ -125,7 +125,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("LK", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("TW", RTW89_FCC, RTW89_FCC, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("TH", RTW89_THAILAND, RTW89_THAILAND, RTW89_THAILAND, 0x0),
-	COUNTRY_REGD("VN", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
+	COUNTRY_REGD("VN", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("AU", RTW89_ACMA, RTW89_ACMA, RTW89_ACMA, 0x0),
 	COUNTRY_REGD("NZ", RTW89_ACMA, RTW89_ACMA, RTW89_ACMA, 0x0),
 	COUNTRY_REGD("PG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
@@ -134,7 +134,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("JM", RTW89_FCC, RTW89_FCC, RTW89_FCC, 0x0),
 	COUNTRY_REGD("AN", RTW89_FCC, RTW89_FCC, RTW89_FCC, 0x0),
 	COUNTRY_REGD("TT", RTW89_FCC, RTW89_FCC, RTW89_NA, 0x0),
-	COUNTRY_REGD("TN", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
+	COUNTRY_REGD("TN", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("AF", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("DZ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("AS", RTW89_FCC, RTW89_FCC, RTW89_NA, 0x0),
@@ -187,9 +187,9 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("GM", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("GE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("GI", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
-	COUNTRY_REGD("GL", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
+	COUNTRY_REGD("GL", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("GD", RTW89_FCC, RTW89_FCC, RTW89_FCC, 0x0),
-	COUNTRY_REGD("GP", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
+	COUNTRY_REGD("GP", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("GU", RTW89_FCC, RTW89_FCC, RTW89_FCC, 0x0),
 	COUNTRY_REGD("GG", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("GN", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
@@ -214,7 +214,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("MQ", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("MR", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("MU", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
-	COUNTRY_REGD("YT", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
+	COUNTRY_REGD("YT", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("FM", RTW89_FCC, RTW89_FCC, RTW89_FCC, 0x0),
 	COUNTRY_REGD("MD", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("MN", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
@@ -260,7 +260,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("UZ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("VU", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("WF", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
-	COUNTRY_REGD("EH", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
+	COUNTRY_REGD("EH", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI, 0x0),
 	COUNTRY_REGD("ZM", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("CU", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
 	COUNTRY_REGD("IR", RTW89_ETSI, RTW89_ETSI, RTW89_NA, 0x0),
-- 
2.25.1


