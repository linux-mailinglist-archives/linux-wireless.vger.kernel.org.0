Return-Path: <linux-wireless+bounces-38396-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o0lKC9rcQ2pKkgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38396-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 17:12:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 920966E5CA4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 17:12:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ME2QYQQw;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38396-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38396-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9A930FA3BD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3742DB794;
	Tue, 30 Jun 2026 15:07:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE032E134
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 15:07:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832033; cv=none; b=TnAat6PfcYvN6+xuzQd0l21AASe3oW3fn7a5ilOuzv7R7uiobvLvOsIZDz6RIAXXoSeIzpE6fsyoFoJkiHnXDjFQPoK7WMBGIp0Eoewf3/g/riCO/EIbdr47MlOGQ6uTFPlgJWNOASug3nJF4EekkNA1lv0fDbs+e9yPWd2je4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832033; c=relaxed/simple;
	bh=s5sX3m3bK4c40hkrPSrTPpPL4Zb4TpwZTWCPzXHH1NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk1K4RSJ+Uq/69S/6IjWFI3YWL1jdiavNVNaE4E6R/lNM16wKzcFNHlAni5MXid2YmkMYMlbYiUOLTTbIfyug8V9o49fyB/U0Kfp8IZIASkntkhRnesMRQycoPIBk4WYc2WKoIiozbomcSRm4F9LoPpIGTl22zlUUJHbbvumzXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME2QYQQw; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so3895236a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782832032; x=1783436832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhvDY45MSy6G6g9L6tyWvHlT65On3gQKFm/j/jxjGrE=;
        b=ME2QYQQwAmNxHWAacx2gxr/6uKwoD0/xhtAbQVVpJc2ldnY6LXSzp8sxZg3RKLRZYE
         oBLLo4FqE3tGX6wOF+4WjqU+UlUAMsPE9AJpxYrRwyj3D7Z+D3WWWuOHO8EJhE1ykYdF
         IdXJ5bHJyDGg9FtA2v92J01AM8Ff/Rzszx+BYZTw0ZevQ8x7XOu0bCeraAgSdncZxw0j
         6Y2GqrRE7fEXu6slbDuYMXOwTsvXSiyhRkC6GEtNrFFmS1RizeIZxCMXCxOBE4fGWUu3
         9oalxedbvEErsO/RcX0T9nVT6OI6yOMxv21l+jffxxo6s4f/+9kej40nKEF/AE3x8kGk
         w/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832032; x=1783436832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bhvDY45MSy6G6g9L6tyWvHlT65On3gQKFm/j/jxjGrE=;
        b=XTLrvYlzNZArgz5+9rKcqtUB1MEpquhb4hcoEEoMYXCC32Cdw2cn5RvJXP84Z9Srd5
         Qzaez7y3TGlXlIFX/s1WsISqpkjTdxSII3g3hY0V1tONudHzI/KHnXr7KVbEkPzkGc2W
         gDv5Ky5Evc88MAXMkRynSugvUslSBjCSvYJsgQ+0TCcSAEhOTPeaCZpozNhAh4TtN2GV
         6xu7NWoquK3gpuqgd8OxeCUoLT3xsN6W5J+JvMKzGiSLMt99ORvmhu047JM/7vGF8Wwh
         sArUosUW3FSzP2UPafLDxxyw3EpEBF5oBWgmuNNYeBcpU2H+xPQ2PmoifENIPXPfrJ3+
         esMw==
X-Forwarded-Encrypted: i=1; AHgh+RppNHvezlGkq+n2ZKs4jbFyekX/idS/vakunDZJLEK3DTo92+Tga5lA2t383OLRu5lz8UufBz+x79udomLI7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qp27wk2q5m0KtTmNV8QRWI28UYh42MARLstWJIOla7X3uFhV
	zyRyieSHRI5BSqsp6HPXCgoPfd2+B7yHSvulwiK6nISlWwkICHxlXhAJ
X-Gm-Gg: AfdE7cmjcoNMQ4yf1/cwZC1QubltjbIz7zCPOszYyO2T8wz3uYAZ2c3r9jJWKFRY8mA
	2G3zccut/ikk9xtA4ItM6SuEpE4JiU6w9IE0NSroAENOUQGau8nuuiFdmeGOD7dILkanFDlXClm
	N3s/Su/NmZLg4Dcd5qDkF1Xq78C5Qjv1yLfBylbm1j0akDLaejm95YLkC3j64eBXwMjMFZ0Z7C/
	HH5M1AzlIIaX4M7GL9xGCYK0VJDYoSfNIxPUdCWaHG91Ce0B+cUNzFYM6OMVA2LQdKllqINrWle
	CHEnRO47UrmhRVltW1VfE/nbg0Y8SA84sTNFyC0H2MN4IZ53it8r3J/piWVP5I50qZoNJX93nrj
	qvkR6huxS3S0ZMRbU+WD8SNWupDWiRnJlxM69YwONzpdSiisW+j24jSYpNQ7dKTJpjL+dtsRWfo
	Vmja5QGXa5F8bavvEMsuqYRrpXfRzcSL5GPRP3CaPA7ZucmGI/cojfyw==
X-Received: by 2002:a17:90b:2e47:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-3808c0e3eb2mr667892a91.25.1782832031701;
        Tue, 30 Jun 2026 08:07:11 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095b684basm41811a91.1.2026.06.30.08.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:07:11 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH mt76 2/2] wifi: mt76: mt7915: fix net_fill_forward_path for non-DBDC mt7986
Date: Tue, 30 Jun 2026 23:06:49 +0800
Message-ID: <20260630150649.1629-2-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630150649.1629-1-hujy652@gmail.com>
References: <20260630150649.1629-1-hujy652@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,lists.infradead.org,gmail.com,genexis.eu];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38396-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:hujy652@gmail.com,m:benjamin.larsson@genexis.eu,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hujy652@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hujy652@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,genexis.eu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 920966E5CA4

Current implementation assumes that the hardware supports DBDC or single
band and binds to band0.

This causes net_fill_forward_path to select the wrong queue for non-DBDC
mt7986 because it binds to band1 and getting the following in dmesg:

ieee80211 phy2: WA: --> drop by reaseon:1, msdu id = 0xc002 but failed!
mtk_wed1: error status=00000002
ieee80211 phy2: WA: txblk
10324e00
len = 128
DW0 : 10 00 00 00
DW1 : 00 00 00 00
DW2 : 00 00 00 00
DW3 : 72 0f 94 68
DW4 : 00 00 00 00
DW5 : ff 03 00 00
DW6 : 00 00 3c 40
DW7 : 00 17 dd 14
DW8 : 79 6f 00 00
DW9 : 02 c0 00 00
DW10 : 58 c5 34 10
DW11 : 00 00 00 00
DW12 : 00 06 3e 00
DW13 : 00 00 00 80
DW14 : 10 8c 00 00
DW15 : 00 00 00 00
DW16 : 00 00 00 00
DW17 : 00 00 00 00
DW18 : 00 00 00 00
DW19 : 00 00 00 00
DW20 : 00 00 00 00
DW21 : 00 00 00 00
DW22 : 00 00 00 00
DW23 : 00 00 00 00
DW24 : 00 00 00 00
DW25 : 00 00 00 00
DW26 : 00 00 00 00
DW27 : 00 00 00 00
DW28 : 00 00 00 00
DW29 : 00 00 00 00
DW30 : 00 00 00 00
DW31 : 00 00 00 00

Fix it by using phy->mt76->band_idx for queue when it's non-DBDC and
mt7986.

Fixes: f68d67623dec ("mt76: mt7915: add Wireless Ethernet Dispatch support")
Suggested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 51643a48ed15..1b433733661c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1743,7 +1743,11 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	path->mtk_wdma.bss = mvif->mt76.idx;
 	path->mtk_wdma.wcid = is_mt7915(&dev->mt76) ? msta->wcid.idx : 0x3ff;
-	path->mtk_wdma.queue = phy != &dev->phy;
+
+	if (!dev->dbdc_support && is_mt7986(&dev->mt76))
+		path->mtk_wdma.queue = phy->mt76->band_idx;
+	else
+		path->mtk_wdma.queue = phy != &dev->phy;
 
 	ctx->dev = NULL;
 
-- 
2.47.3


