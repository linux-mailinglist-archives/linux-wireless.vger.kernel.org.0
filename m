Return-Path: <linux-wireless+bounces-38713-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b0lNHYU6TGrphwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38713-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 01:30:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C90A7164F4
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 01:30:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ef77M0+L;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38713-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38713-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA393055C72
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 23:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7C431484;
	Mon,  6 Jul 2026 23:29:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C8423763
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 23:29:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380546; cv=none; b=LhSWOJXS6WI70JL4RS8uTQg6RmCFufvnZ+Mr3k7njgyb0ycHKp34BLxdJVyPt4Xqml1tU3akXZ4TM45cjCbaDQRDTqLRMcZz+WPoMY7ogI1fjgXyV8UvQsR9iTqg9RJ031NGzTG6DVLI9TizA+zZQBUGf06z5cZqoW+Sp10HORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380546; c=relaxed/simple;
	bh=19TwImbklmpwkHnLj+6cGll5thN/SAZPHDjrio7qhBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byM9xY3M3kZG+kUs+mTvnDNP1bnUVye9uI34vbWC8+rRnzzfj2JLsQ0noocTFAmi46Ch9tEhh/1pC7mqPganY5Gw5kmHdYaYjqBd5SgrX3yf+lKc0fBHU/2WB6ut3aJtu+kZAU8s43hOx3FClO4nZHAaNMLBHiirNtzf/BSHjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef77M0+L; arc=none smtp.client-ip=209.85.219.41
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8e9c9d63815so13973136d6.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783380543; x=1783985343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcBgjqeSOfuptOO3Y+Jfj7CL+AEDlaiqctCql/yUeXE=;
        b=ef77M0+Lwy/NdF1ZZzoL3NxuOzl4HA6pUmn1Cx6ZpiJh928JZ60X9gCxJPSZsDwnyw
         rsXYy9fMF4rGjITtDvS8ssnu/Yjr/3t2hA7ys5gSJehkQ4fZUwBoFosqXu0ELUT1yFv6
         VFesVQx3w1r3cx4krXo9JXlmig912wN8XcPlY8UWDz+44EnhidDJmYmI6VkChxSDeyI3
         rfDEmaDIalmAVuHrtXZG9omRdLPkn24zfB2H50l2tuqAUolmJspEUCoGaJQdDCnJ/dDx
         uO0IVjeYoMsGVeC+D1yfV6+M1JmBl1uEKDG2Uv+qBVsrgDLXaYy/L5GWoYQyWGPFw7UA
         kWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783380543; x=1783985343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcBgjqeSOfuptOO3Y+Jfj7CL+AEDlaiqctCql/yUeXE=;
        b=MuJo/Erm/4GNNAEA7O1y6slZFO9azHazivVotoxpe9iMEPLiRG1JtGVMOmHXt6sC2v
         AnZyH3j7PU7VMnDrbHMdKEvWAInJM87jWnolkf8qWA1GpaB8sJjNc8YUOpdCTY404Qvz
         wEhzcYh/yag4PQfK0bOL5jH52698PjL9tZdi1OF3xzLOR5F5/0PTkZTd+jDQHy2S/cMR
         0VAk/9DDbce9QaXxxQpwfQu7LpjM0zcD2hg10tELM0wPCILewbaStdNqPGLvRTuuPxDo
         UZBtZ9Sb66YenbyWG148Z2q+wHMqPtDiw1JXsF/3Jh1C02q04EbGsCfHp+2IAcv0Oznp
         SpiQ==
X-Gm-Message-State: AOJu0Yy2EtYgMDHF0kXzftW7kbokobkHeQwQ6FCrXxrGpPiWad4KhTVu
	KfiGzbkUQu/sZoXMCMPFqR+ROc5CKrujGb1grYityr9JhTZuOZz8AAy1LKkjBg==
X-Gm-Gg: AfdE7cljyjDbbLtcfrQVTF54Dj1L8WOp/CtkMrdiBn0FDEbRcQOe2xVpZHSqUxtCIDE
	LrxoGnVgrRVHFLDQUm9Rrd0ojxZR6LJhZgBwYZGVpCPhhzgk2FZGby35LF2Z49Hl/HKmEc/OnAA
	AxfZs0vFVkZwbPvwh/N7BILT367mfR6/+E2vVjdEigBDJMIccTzadgmEeKa+CFENbayBj2YkRXH
	AHW+4/SquGWQgZN09CJm7kOa8ONO13KvIa2gd7QX6TRYoCt5acW+5GNpg/w6t0WXQ5ylzeU4DIO
	ykMa92sVzlcJkZhrZYVszDvHM0jj1EVPSC4wyvTYnVie8uzMqFxFbHcjnjOdKocUwF8a8Rug1A6
	hSgHlMts4ySpCOracNHsPnK7gO6AcS7oU8RR6T/shOpbCS6kE+Qe2Zmznb/7ccEiM923qLZi4oa
	TQsJOUc2HvWnKSQDYR9N3N6M1RVkbftI4qZeExlnUl17I8S2JsVB6NBmE8QedhQK5DKiZ+QcKxu
	BawOyk3r0pJgyRJ4QTf
X-Received: by 2002:a05:6214:5701:b0:8f0:11df:c80d with SMTP id 6a1803df08f44-8fcb56c8c27mr39823556d6.42.1783380542597;
        Mon, 06 Jul 2026 16:29:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de83f8sm148902706d6.33.2026.07.06.16.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 16:29:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv2 wireless] wifi: mt76: fix MAC address for non OF pcie cards
Date: Mon,  6 Jul 2026 16:28:57 -0700
Message-ID: <20260706232857.807044-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38713-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:rosenp@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[schwarzvogel.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C90A7164F4

If seems the check for err is wrong as the proper macaddr gets written
to from the EEPROM itself. Meaning checking err from of_get_mac_address is
wrong as the proper macaddr has been written by this point.

Reported-by: Klara Modin <klarasmodin@gmail.com>
Closes: https://lore.kernel.org/all/ajRmlyx_AEGybykL@soda.int.kasm.eu/
Reported-by: Tobias Klausmann <klausman@schwarzvogel.de>
Closes:
https://lore.kernel.org/linux-wireless/30a90714-02d8-45f2-a7f1-4cfe0627d50b@skade.local/
Fixes: 31ee1582717e ("wifi: mt76: fix of_get_mac_address error handling")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Tested-by: Tobias Klausmann <klausman@schwarzvogel.de>
Tested-by: Klara Modin <klarasmodin@gmail.com>
---
 v2: add extra tags and target wireless
 drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index b99d7452800f..afdb73661866 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -181,7 +181,7 @@ mt76_eeprom_override(struct mt76_phy *phy)
 	if (err == -EPROBE_DEFER)
 		return err;
 
-	if (err) {
+	if (!is_valid_ether_addr(phy->macaddr)) {
 		eth_random_addr(phy->macaddr);
 		dev_info(dev->dev,
 			 "Invalid MAC address, using random address %pM\n",
-- 
2.55.0


