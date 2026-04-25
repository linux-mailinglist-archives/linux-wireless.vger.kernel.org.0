Return-Path: <linux-wireless+bounces-35303-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YITPCi8b7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35303-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5D7467904
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26BD730056D6
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82662303A0D;
	Sat, 25 Apr 2026 19:51:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35265303C83
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146667; cv=none; b=HIQIuyDjRQjIX6bzdmy8qubpCqMNWgaZmqMXQsNQ5bPFygtz1/Cc5uPVD8c5PoG9u/ZqJj/0QJquBc5t7TIB9ep2mS5qSgMz28cDpJmxbC9YpMfaZ3D1TWpI3gm1IjqKHOPHMoccJieC64CkWT9UM2QuirqlTBWMb0H2v4c44Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146667; c=relaxed/simple;
	bh=6ZxPIGSYtuceQWIBxS83nSkeLsLcwxUG2Pu9YRm5SDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVKpEyRTkr5yJ7TpzdIxJhT3BV4AmxX2sjqUDDY3EjaTm2gBK6niIJe0D8pIJtBr4O3Q9UvZqZ4Lt3GxG1E5fVoL2yFXfW91AOZ7Oy/1GlGouKlgb/zRbTAmONI28Gd7GCW85SQBnKTu0rCN5bROvii7w090DBOo9FpmbhzqP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d1872504cbso7660088a34.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146665; x=1777751465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0CVP2NI4wEGcr08f75y7514rRrWBedST0NWFV3z/OKM=;
        b=ILpIfinK2QkzIv1NgXO7TAkUIaQQ5y7q99zAvwQPWZdFqYRJCm1SqMaffdjxNbDd1I
         K0FGRFgwLIyZnqMiRVBH33i16Kswi/PM0LksYaxDJV9CVcYr4pcE6PFy9wMuwl3au9Dg
         7UIucP5yqHDBPWz2f61sDJChbGC23vDyBv5tavNdG1ooOV+Z+sVA1fveXKCJeARErFZd
         cdTaI+l3NnYqcIQ11qPZGqWd1ViY+8+d/rTVwUOT9Ye86hKwlVgrmMqRXCEIocaX1t+h
         EylJFnc89hGQGi/LU8bHdxAHVQ7RIDqypL7hTOWBlcfBylRsSiEuMMrjhWk9dPSIaRJB
         BDUg==
X-Gm-Message-State: AOJu0YzPI1Kd7K4sRByRAqOFI5hSd4g63OS9a3HPD0pRJiuEg3EoAQ9D
	Fnge+wsN1ePz0yi1YTVfJ4J1FLlDGUIPSuemL9obZb3V2uFjYlALKL/x
X-Gm-Gg: AeBDietAtNTz4wQcreoT5nMo1nnxlG8BU2ui9KK6QqHYU8/46Ej7t/xjkIjQr81JA9u
	cf1uOmJOAa68TROA5ZYrGRE1HvywoZSkKlJYYiKnLsaN0INH6ZCgIBLqOPVHsE3nKSsZun1k/Hm
	23E6+/GG6o5OUFgd2jENwvHUFz+l+m3/NzmZK64p9wPi77xwTsVzPMVWUsf4J9Xt+iefVPl3+3n
	Akove5L9TArWfGiw2LQK1p0HGpXs57CAWgxGAs4UNyPPVdUDYX3NO0dsW5ePJBBlrji3D5HUVXO
	UOnc1hH4vUbT2zKLXcGHTAvomZUaDVNtIpYqi4hg33SgiuG32DrMVXg1QMJQntlxoaVYgm0mL1h
	U3knNtOXyOFb1CJZifcHHi37Lon+VAtmz67dv5sy99XfGIsf9KivO4l0rRVdouUUH2NKjhSPhVA
	u/SO9z2VE80Jhgmjvi/MdVZdxuHSWF50yMqgbHT1zXdVvV1cfcm2hJJykAqlMdPhdtUKrqdSuwz
	w==
X-Received: by 2002:a05:6830:2782:b0:7d7:dcbb:280b with SMTP id 46e09a7af769-7dc954b47ebmr19354311a34.1.1777146665303;
        Sat, 25 Apr 2026 12:51:05 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:03 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Javier Tia <floss@jetm.me>,
	Marcin FM <marcin@lgic.pl>,
	Cristian-Florin Radoi <radoi.chris@gmail.com>,
	George Salukvadze <giosal90@gmail.com>,
	Evgeny Kapusta <3193631@gmail.com>,
	Samu Toljamo <samu.toljamo@gmail.com>,
	Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
	Chapuis Dario <chapuisdario4@gmail.com>,
	=?UTF-8?q?Thibaut=20Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
	=?UTF-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 06/21] wifi: mt76: mt7925: add MT7927 chip ID helpers
Date: Sat, 25 Apr 2026 14:49:56 -0500
Message-ID: <20260425195011.790265-7-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD5D7467904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,jetm.me,lgic.pl,gmail.com,humeurlibre.fr,mediatek.com];
	TAGGED_FROM(0.00)[bounces-35303-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

From: Javier Tia <floss@jetm.me>

The MediaTek MT7927 (Filogic 380) combo chip uses MT7927 WiFi silicon
that is architecturally compatible with MT7925. Extend is_mt7925() to
match chip ID 0x7927, and add is_mt7927() for code paths that need
MT7927-specific handling.

Also add 0x7927 to is_mt76_fw_txp() to match MT7925's TXP format.

Tested-by: Marcin FM <marcin@lgic.pl>
Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
Tested-by: George Salukvadze <giosal90@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Thibaut François <tibo@humeurlibre.fr>
Tested-by: 张旭涵 <Loong.0x00@gmail.com>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 802cb26ed6e3..45479cc29134 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -174,7 +174,12 @@ extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7925(struct mt76_dev *dev)
 {
-	return mt76_chip(dev) == 0x7925;
+	return mt76_chip(dev) == 0x7925 || mt76_chip(dev) == 0x7927;
+}
+
+static inline bool is_mt7927(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7927;
 }
 
 static inline bool is_320mhz_supported(struct mt76_dev *dev)
@@ -284,6 +289,7 @@ static inline bool is_mt76_fw_txp(struct mt76_dev *dev)
 	case 0x7922:
 	case 0x7902:
 	case 0x7925:
+	case 0x7927:
 	case 0x7663:
 	case 0x7622:
 		return false;
-- 
2.43.0


