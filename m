Return-Path: <linux-wireless+bounces-37765-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FhRWK8HcLWq2lgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37765-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0678267FF0D
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:42:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37765-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37765-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8195300D6B8
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC57342509;
	Sat, 13 Jun 2026 22:42:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4A223DCE
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:42:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390527; cv=none; b=CCLRV5hzxUllxqhCcOELZHcgBBwmSR3h2X5l0+vQJ8IfMu3qea7XnpJNaUk5nscvnZ0J1K9MBa8wk/o3ajLwY3wZzJMldRu6n+PbN/LM52bf3qXTnNAYRbapHLWs4NAjEoAiWxk/kHYpKBGkUD21+o5R/dxsYLAfq206coF3dnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390527; c=relaxed/simple;
	bh=RH1q25LpXRGVxxKcod8jy62uDGfF/F1PQcFiCU5xeSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNzHeCcGyj5lT8vrqjSPhVeSB0sBk+x8+bFTR7x4vgHjcna3kADmTI2wu2IKE9twngDFRAVpYRTo+927Lrbr4j4k/nngHECOpUV6egaF3hkanMPyP1mK94xzkoJFDqBsuWnCu6qXEod7cUZcc6m8SBqXTthk96lyaSjgw4bwf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.178
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-306f36df4feso1530608eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390525; x=1781995325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eNnaW9ugZlbc80Hn5pdKU8P9P/zwK+1nCkZYt/5PNac=;
        b=mI2TpgeM1wdNe+SrlVyOptu/H++ltp6bwyQxByXM4DbhIXYbGAX8eaOspHTsRW3XdB
         2c8nvLMSCPFGdNWx9RUKGuIpIdbqFNH+BArlqpwZr6RD+Hv+UDSnx2qnjvBT9a70WLej
         uhMrv8YCOiPacMHe1Ao8wkPFbpB8xTNdMPJjP0kD+mNh1XjtorhEnxBWrwsFLTEqe91t
         cOLgAten5yQSFp9IWDRI+ShYVbJmxMAS+/uIjCToiXWQWCQpyFNn++WambOOTlqywzbU
         k34DiDTdjAzkbqL3X5dtweymvxLY+nd0ssLL1rm8tEydDbiNFpjtib5K2875hlTV85nH
         1nyA==
X-Gm-Message-State: AOJu0YxHFjLk/uaHUCm0xVmKhirPJ70z2neG8VSyZF3GJFTM5UFWMFRM
	gXbXgC1C5Ig28KcJSzs9TruMsdTlijjSznMJyQas6jEpYQHZea6Z2vvuKemtQJGi
X-Gm-Gg: Acq92OGuBvWYh7/wzSQrr8JNCfJu7BdyHp8ILx2+UXY3QZpejjACeJJPmE3qcHdJaY1
	qbY4JWZKR5cuehX+4dw3K7bDGcBRremgyN5jRmFIo/m3YpL3OTdQTdwMLKOty3sB9PHemkFmjaQ
	SBROS9g1lXak+LNw4hydKhDAK/nsfMZ07+TAfzFtvE23EeVSb3v8dZT0NLYbABn9C/ZICpCiCDv
	0dIQFua3s8N5tPisoTBiuu401pqH8SDKtOWy928ZT6/Rw4GqUZ/4cAqQlQCkHkFkmPpVia0NJdA
	4asLMQPnT6TezzcEyEfPVbGE8Co/fSq/u7XndEsDqcpaaddUle27MtO9baUxW+bf7mmYrAFKVwv
	UfydRmdtIkTyJTstR5+F4OYKdEeBum70MMqC7JLINBlItXwue5E8tMPjOISvvucXrfyNkblFFE+
	3N6BgWSTsLmT64u8G6sfF/wapdOl0iOYWeQhVLSgQHpYU4PDdHaNyKllkKQY+aA3s7RO2SBwBq5
	2bkNlrClEfGVSoaXpsVPdj4isj4s0KRxMFUyNJH
X-Received: by 2002:a05:7300:bd03:b0:304:d600:8731 with SMTP id 5a478bee46e88-30820cf4765mr4232755eec.15.1781390524924;
        Sat, 13 Jun 2026 15:42:04 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm11104825eec.28.2026.06.13.15.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:42:04 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/6] wifi: mt76: mt7925: stop init retries on hung bus
Date: Sat, 13 Jun 2026 17:41:26 -0500
Message-ID: <20260613224131.2396026-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613224131.2396026-1-sean.wang@kernel.org>
References: <20260613224131.2396026-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37765-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0678267FF0D

From: Sean Wang <sean.wang@mediatek.com>

Stop retrying hardware init once the bus is marked hung.

The control path is no longer usable at that point, so more retries only
issue failing device accesses, including MCU commands or register
operations, and delay teardown. Exit early and let the failed device be
torn down quickly.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index e85b0d104fbe..e9ca5aa1e407 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -137,10 +137,18 @@ static int mt7925_init_hardware(struct mt792x_dev *dev)
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	for (i = 0; i < MT792x_MCU_INIT_RETRY_COUNT; i++) {
+		if (atomic_read(&dev->mt76.bus_hung)) {
+			ret = -EIO;
+			break;
+		}
+
 		ret = __mt7925_init_hardware(dev);
 		if (!ret)
 			break;
 
+		if (atomic_read(&dev->mt76.bus_hung))
+			break;
+
 		mt792x_init_reset(dev);
 	}
 
-- 
2.43.0


