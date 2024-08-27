Return-Path: <linux-wireless+bounces-12057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F266B96066A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E01F220F7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C641A01BC;
	Tue, 27 Aug 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="BZ+pfD+R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A119CCED
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752575; cv=none; b=tIGbkU4aDYyx31TvAW6ENeywfBr1CXrGV//PGBZhti5vcZsYVB2qeQbbcjfgj7EDkLZUxp9epNgUZj9i8+HOCy726kL4sfC8KebEkJ1wS7ZIMtFP64URJbxnpdJmWzNCJBgGgpStwHHiLIBtey1fto8iqfkCAi8K2nozm5WZ9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752575; c=relaxed/simple;
	bh=EjjckwANwW7sA6QztMy1IaOTz/DbtqZdfVw4xwyOPjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi1ttvBIf6CtyywD7tfYTJGS/ZC7pcQM1RyMG/MFCQl1kjh/pl018iRkJVaicn3XWxmDlDdbUq0R+rmUtfSTznXthoNOTWp9/naLv8jKUGudS1JEUjqCUzK7gwNOCc/8NuJCZ6C6/kD1p8BkyGdABtoqOb63AvCuPfUrJGKVZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=BZ+pfD+R; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tKop64SSuWbfbLlWJM/qdy25BerrT5+2FkLRc+sNm4I=; b=BZ+pfD+ROkIuYt5P3uHRg1ZpK5
	i1HS593Jt+vysbSekELZ5Kgw7JhvNTR7aAnFdmnmSY4UNzOCQsCmCTJvvO3xuPve2kG+V74vmK7e8
	rj+iE1w2EJ+FLx0OBWGWmDLzKGXffHJCVLhyjTEvBq/OAY3Zwyjqzr6PpwrZ6Ixto5A0=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWo-004Ww8-1i
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:18 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 23/24] wifi: mt76: mt7996: fix uninitialized TLV data
Date: Tue, 27 Aug 2024 11:30:10 +0200
Message-ID: <20240827093011.18621-23-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use skb_put_zero instead of skb_put

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index caa0ff619475..327337b31279 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -735,7 +735,7 @@ void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb)
 static struct tlv *
 mt7996_mcu_add_uni_tlv(struct sk_buff *skb, u16 tag, u16 len)
 {
-	struct tlv *ptlv = skb_put(skb, len);
+	struct tlv *ptlv = skb_put_zero(skb, len);
 
 	ptlv->tag = cpu_to_le16(tag);
 	ptlv->len = cpu_to_le16(len);
-- 
2.46.0


