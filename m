Return-Path: <linux-wireless+bounces-38403-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OtXOJOkuRGrTqAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38403-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:02:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB16E7FC8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:02:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JBatlFmK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38403-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38403-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B0573025150
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DEB2FFF8F;
	Tue, 30 Jun 2026 21:02:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DF2F7EEE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:02:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853340; cv=none; b=pi+ziOfDYt5iieg7hIUm36dh4pn0Of9AP2OGO2ZIJF32/xMNtEWdaRmPWhzzgCplx1QBFfvWNVUyes/vOx5TjXLQsBKIGSjk0sjeoX84IhFhtnnRfMTJkjUhyzk7KTSLHqKMj7tXBxO51hJHWBObguTrVUlSTjuHXDQV5HmvTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853340; c=relaxed/simple;
	bh=nSX7CuPDkNgH38bufomCGiLzdjBfdvFFbqNwWNuYNiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q44afLoo/i2nrjlvjODEVt0mq9JLaMbBeQDOJrqXZiBsH7uydmFQpQ78s6XwZbWeRoaGNmzNbukilFFAilesYIQ4Cfr77xBpOh9+zRncZMCmIg1dxbG8bseGBdh4/vwwr2ZogtOTFC8L7k+E9ZtwgYaC8qqVKImC+tNWBrYYTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBatlFmK; arc=none smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so9665148eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782853338; x=1783458138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyAJVegbfyrJxQWNLL4+WJEBhbqapbMYo1uIZ2+vwQ0=;
        b=JBatlFmKBl+5LGWZC2hVb544ZFue6pteV7xCeHMapW30GTQQ9B8ea/L8hPko8e9A/e
         h53f0CKATR/W+VVuqo2mWbHZcDq8Lt+XMKP7BafTIXwzQwYxObBFAWd9nnsxwld+amHE
         aBd92t4i8657Sfvs5ukFxA9EFi/3lavsE88gAJF0idjciJ3l8fIyW7Os96tLI+cwjySI
         SBVAfKQnTJaLYhIHJTiUjPsA7Rk4SKDB6B8HvyGEJEVIDdWIGj46BkUX4N6XIPRVrHB2
         3Be2HzfTlDQUCPyOch+vddmg/8XboWZKaaG7QgsWvxKMEdzsw/6BSQzD2VFmaMiQ2g66
         JB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853338; x=1783458138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyAJVegbfyrJxQWNLL4+WJEBhbqapbMYo1uIZ2+vwQ0=;
        b=VpIXcUXxFvK/FrMBHwEElRww0mednepSH1gX8ETfNcHCeelcPkzOwl6FjvrPhO88Dh
         BdpsxDLtc40wenLzeG9QeyUFQ5f0rq/I+MsEOsZpU628soZ3vRbHu5rTxyjY0keEy3oJ
         /9mRSXSZx32UdNrkEtujZ7UVFiSC0PXelOAZjyovkIWCGn9Q+/oGcPMhMedVmWhZf2rG
         Q2IeL3KROogsgo4Oyww7A7IKq56z/R0pnV7qG2ZymmdtXpxOrTTzHJvXLfSGfkoYLGjf
         pN+7kcldUMzHIseQaER51qa5Pibp+SNPJ4H5NEK4foyZN6DEkfeGlPfLXHEjqeWIc32X
         jXag==
X-Gm-Message-State: AOJu0YwqD9mH62/8swkE5VassvZ3XU8VdE9fVqCEFimngNQgwDFVtrKZ
	pQrTmYhcOZ5WrBIQLOdsSL7FmHonEFwGcqwvkRjRdDnzinVEOPibcmnUg9GB4kMj
X-Gm-Gg: AfdE7ckixEhQYGG+0Xt3sb9t22EmEqrl4KqmmlazG/Ja1OQDQUjpuhm8fWSS6lKPyxg
	eyJATEmX7a9y83TzAv3yjECP4IoOI8YIkg9v9ID3TXpPD5/qoSAFyGYM0QUxNkHRru3XQ+Earmq
	KzDGRZzPXhd5GWiIenarsxRgabVa2MuLKeA4Dc5QPCDDe2qutlIA+X+gE+eiuS3d20AlfPtADo3
	ekxHL5N4ZyMwXzo0k+AGQ8LzchtX2xDR4OZ/UQgjh7aTDA5fd/pa4KjKYGYqQeK8plNUKf8nz4f
	9EK6PH0O4eLtpfhcuvjmuhquOo/yWjB+pGgy73VMVU9PivqosASXnAU2bSRD/GVBIqdZm6s+mO3
	4WIc3sEqM4FBiaCEIh3ynseWeKYyIWgogm0fvZdJCZdV6aNjEO9QCc0K9w1GJHojjP314iKiFgy
	8trKq/VMxt9GSfVXbwe7TcV2PKePZ2xE+QApVLfc9LUCg0IbCADu/MBMNJ8ZkDG1tl06LZ5wqOs
	iUlHiZwRw==
X-Received: by 2002:a05:7300:6144:b0:306:f474:7389 with SMTP id 5a478bee46e88-30ee134fe86mr3861886eec.25.1782853337951;
        Tue, 30 Jun 2026 14:02:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5c4c3sm11592642eec.2.2026.06.30.14.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:02:17 -0700 (PDT)
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
Subject: [PATCH wireless-next] wifi: mt76: fix MAC address for non OF pcie cards
Date: Tue, 30 Jun 2026 14:02:15 -0700
Message-ID: <20260630210215.400379-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38403-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5AB16E7FC8

If seems the check for err is wrong as the proper macaddr gets written
to from the EEPROM itself. Meaning checking err from of_get_mac_address is
wrong as the proper macaddr has been written by this point.

Fixes: 31ee1582717e ("wifi: mt76: fix of_get_mac_address error handling")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
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


