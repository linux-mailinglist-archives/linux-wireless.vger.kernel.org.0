Return-Path: <linux-wireless+bounces-36450-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BBsMgx7BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36450-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:46:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB6548878
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B414B3070F2C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628D726A0B9;
	Fri, 15 May 2026 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="u2UUkyBX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0887CA52
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809543; cv=none; b=SJFTJknCB9yNdvHN2lC6XXKbTdcxHtkTxMJjyQk0IZrEL+uyEKDLSH+Q5q3eM5zRHQbH27JKJsWJExfPUgVnop8NNZMpqafLBBhq6fB47MfxcBAAQvdAco4Zk46FGudKzpzmJkv/pLBByIrC3cZqR/a9vRyCp4hyvQEfZy9VplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809543; c=relaxed/simple;
	bh=p6QMj49Fy6UClSRNe6yqyxDYalkfIhS5tsrniPxVwpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rswpB5/ykAmkl7kuwUxQMUAy2Q9dI7Rn1pBWr1C4TCgNF3xB97snqbVvjoG5v0uAyT+2TQcb7fF9TJsg6KKVT+5TYwLAMtYZnQzZz7CsGinbjmwl5xPx0CAZdCobo/x/RsXURRzbS/mQVmNImb/soRMYb0SCKoaKtUO/G84onDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=u2UUkyBX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1jex272587314, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809540; bh=uceuQgOp/x9bXh5eeLhWtjPTWYdawgYd8BVg2hX3qWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=u2UUkyBXVnppKgMaYLQgVYDLkSQgWSZegLqL7C4W15lAvtaTfm9NuO0n9KjZ2JfE3
	 M/577cVqnrNCDzhnqXm5Y2lLe6mG20GsPDT4tknEGIwhAGelMoJ4yg6eHssBf7lPfT
	 epy6CmZ0hmI63+DHIZhCwbDHFBpaCjZw40kUP/YTpVRMDkYeNzwFSe1vV/QKM1pfRu
	 z5gpm460mYZ4impTA+8TWKTejHMleHs/uS+u0UAkzCghGPLIsAUMxjwjKSrsLPqa/w
	 DO1QbzkTLz2lIKOAv6JwonqZ4R3fxOhagqG+0Eptu/CcnceJD/aJ8ykwzALcarFmmZ
	 qCefoq8HROluQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1jex272587314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:45:40 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:39 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:45:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/13] wifi: rtw89: mac: add field of release report size to DLE quota
Date: Fri, 15 May 2026 09:44:31 +0800
Message-ID: <20260515014433.16168-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515014433.16168-1-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 30EB6548878
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36450-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The release report size is defined to indicate quota for TX completion.
Define the field as vendor driver does.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a6dee97d99f2..fa5ba90f11c6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4157,6 +4157,7 @@ struct rtw89_dle_input {
 	u32 h2c_max_size;
 	u32 rx_amsdu_size; /* unit: KB */
 	u32 c2h_max_size;
+	u32 rls_rpt_max_size;
 	u32 mpdu_info_tbl_b0;
 	u32 mpdu_info_tbl_b1;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8df1b9af719d..5c22b2accf7c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1889,8 +1889,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.rsvd0_size6 = {40960, 0,},
 	.rsvd1_size0 = {587776, 2048,},
 	.rsvd1_size2 = {391168, 2048,},
-	.dle_input3 = {0, 0, 0, 16384, 0, 2048, 0, 0,},
-	.dle_input20 = {128, 128, 11454, 2048, 0, 2048, 24, 24,},
+	.dle_input3 = {0, 0, 0, 16384, 0, 2048, 0, 0, 0,},
+	.dle_input20 = {128, 128, 11454, 2048, 0, 2048, 1024, 24, 24,},
 };
 EXPORT_SYMBOL(rtw89_mac_size);
 
-- 
2.25.1


