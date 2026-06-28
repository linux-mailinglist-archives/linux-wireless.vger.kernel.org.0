Return-Path: <linux-wireless+bounces-38221-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rxQuJhfvQGp1jgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38221-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 11:53:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE36D3893
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 11:53:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pSEvIzjS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38221-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38221-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80518300B849
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23A013B293;
	Sun, 28 Jun 2026 09:53:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710FC351C30
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 09:53:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782640401; cv=none; b=ZHntYEUGzmGNigk94hf/z55AFYahy0yGpd8pv+JfwHSBpzR1eTG7cVH9zArr8u1X4eOH2HYgSTyN4glqqXTuCqZ8war6bpNCqgjez3oa+JOQf7F2WzzTDxv4vFtKEa96ho1oNqmVTG5CxwEbf4aiatIm9g5CvenmlLLafrJRPIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782640401; c=relaxed/simple;
	bh=87p3YbDnJlD3mCUX1jTCXnjrrapaFLgXm/M7ANH4GrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGT7WyMvIAPNh4QRkYo8Hh4uFmYIp10Rd5WvC0GD7VJdedq7T8omzFhvLazh5KRA/iDVfmty7TedxoF/6akjuDHSLHb4HpZHpWsEFXTzJ+GqF2SNvsEBgIgsHp+00mp6rmdqRM5IJVbsoYkPvI/51/kXczWddlTK6Dco6j4XoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSEvIzjS; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-470174001a0so724483f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782640398; x=1783245198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azuQfsYhi2RuHF91Av10m+SL8w/ffFL2iYKuv1uN8YY=;
        b=pSEvIzjSNinQqFv7FNYz6GjIOm/AWe8McdVOBCiegKY2pKgObDO8tE+7aJKl7m1Sqg
         YERNunxNF4rtFJl8c2XzIdTYgSRtbE7QTKtfcqDyb0PS899fsKr5B0jqzqWA5MfHAxeA
         bPsl5W3u4+DcgnMpMxJUsKftnE1z1Es9SwHq9/WHXODWBgQI11SxpYHKXK5g6jIgqEX1
         YFPa8TYa/NpcxoEu0RmNgltnEd4+wnIC0lJ0FLTNthglYaEx0j+3rCpGyeWJ1OuHMm8F
         j+Dbq8kiYueaVKr8kH5KquQSx4nb4Gn4lzzPOh9WjqW5EcY+hENIDg+YpmclMc9Kqoro
         8D5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782640398; x=1783245198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azuQfsYhi2RuHF91Av10m+SL8w/ffFL2iYKuv1uN8YY=;
        b=jo9q4+XoV7GhR2IZJp0BszY6kdBRFQ88E0sOs7qlKA9KXosoM195zJN1ZRsb17aKkZ
         w75sjfs6WNxA/V4gUOnnoDfvHu/pPC0A+cht1gPMIxEtPupCL09Jm7pShjksHJ1Tqufe
         MZo/Pz5nES9kgOjUQKN9fbwRvObV20is3LOs/7G2UX+ZC6qx8VMTxJbG8/URFxey8VzO
         CjYN96RRdMCeMvbUUUOX+mhi1/79o/TrGtWWC+g7YbxlpsYNVXrNp+5KQnm+UJk17Yc9
         mIk9q8gyQU387xB8ITTX9GoYbCZxhvdntoe+G6FbYMqCXEw4TDTGN1c8AraBm5ZfsopF
         5cXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8LbTTU1qAQ4YLP6DHoJwG99TDj8l8ydgRMHEKPgkmDBqWuL/dH3FmNzWK2Fo6ocY+TY1ug/IaY/+Vm5ClUjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3rYw1ezWy+fMJsktzMlIPA9sm9Ebvx5aWFlMKTZdvyWexgpt
	Q2y/+PM1nZ4rtZXPRHVk+EoBbqPz8WBMwqIOW/qrkxaWBLUTJnVb37U0
X-Gm-Gg: AfdE7ck+N7hvRdjsXnuMkAwRkdhQDzSjBkXeJZ7ejQsJMSxMjdFElzYe3DkfQv7jHbA
	7YQB4BcF9pP3eo+WhYtWlYfTYSjtaeOVmcIU1mYnbWI6JLeq6TmkERt1agS7wxqal0cog+xDoYY
	QDBJ5r8reXZsMsO9CO9AVoQ27cjYpeXVpGVZoOeFAIhpWkDoXWtsJshKpr1jcGNwwshbuxP1ekg
	fvkshNGdvcXPyYntpog8nKnj5y+khPMibVILkBTx4QbSAOzrpDVqEejZEAiCAkfbvaFWOlR3msI
	pIz2XE2oXcl0dE+UWmJZss5IEZer7DV6nns2jvQtND7Att1DQQZfhPw78/n2mpLljWAUAi51JH0
	aLosYbn2tSMNgf/9AliyZYNz+R/Exy9OygrZaAXkrBsTaCdzY+KiOyWVv0RWVoDevrhGZ4ZmTNz
	tbPynpYRoa9prjHQAZa7b62UdFaiCqalh7rdNPuTaY/eTOzxIaBL8Ds+A1W3ZWlFypKiGGx8Wuu
	wc7KQA=
X-Received: by 2002:a05:600c:a013:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-49266892207mr194150995e9.33.1782640398324;
        Sun, 28 Jun 2026 02:53:18 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28673dsm189602075e9.2.2026.06.28.02.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:53:17 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH 1/2] wifi: mt76: share the throughput LED trigger across bands
Date: Sun, 28 Jun 2026 11:53:12 +0200
Message-ID: <20260628095313.7790-2-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260628095313.7790-1-petr.wozniak@gmail.com>
References: <20260628095313.7790-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38221-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44FE36D3893

ieee80211_create_tpt_led_trigger() creates one trigger per ieee80211_hw
and returns NULL with a WARN_ON() if called again for the same hw.

Under the single-wiphy MLO model each band registers its own LED classdev
for the same hw, and the bands can be initialised in any order. Create the
trigger on the first mt76_led_init() call, stash it on the primary phy's
classdev and let the other bands reuse it. This avoids the WARN_ON() splat
and gives every band the same throughput trigger regardless of init order.

Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 13c4e8abe..e56fb95ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -228,11 +228,19 @@ static int mt76_led_init(struct mt76_phy *phy)
 		 wiphy_name(hw->wiphy));
 
 	phy->leds.cdev.name = phy->leds.name;
-	phy->leds.cdev.default_trigger =
-		ieee80211_create_tpt_led_trigger(hw,
-					IEEE80211_TPT_LEDTRIG_FL_RADIO,
-					mt76_tpt_blink,
-					ARRAY_SIZE(mt76_tpt_blink));
+	/* The throughput trigger is created once per ieee80211_hw. Under
+	 * single-wiphy MLO every band registers its own LED classdev for the
+	 * same hw and the bands can come up in any order, so create the trigger
+	 * on the first call, stash it on the primary phy and let the other bands
+	 * reuse it; calling it again would trip a WARN_ON().
+	 */
+	if (!dev->phy.leds.cdev.default_trigger)
+		dev->phy.leds.cdev.default_trigger =
+			ieee80211_create_tpt_led_trigger(hw,
+							 IEEE80211_TPT_LEDTRIG_FL_RADIO,
+							 mt76_tpt_blink,
+							 ARRAY_SIZE(mt76_tpt_blink));
+	phy->leds.cdev.default_trigger = dev->phy.leds.cdev.default_trigger;
 
 	dev_info(dev->dev,
 		"registering led '%s'\n", phy->leds.name);
-- 
2.51.0


