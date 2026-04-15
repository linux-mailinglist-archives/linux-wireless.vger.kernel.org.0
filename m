Return-Path: <linux-wireless+bounces-34854-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAM0GKYR4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34854-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:31:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B68408AA6
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E84030FF633
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E13D5662;
	Wed, 15 Apr 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBlfEnpA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9E3932FB
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291871; cv=none; b=T7cK4slwleFFk0QYho9BA9000EekxrmSHUn3Ps4RK+23SwjvmkVwbqtIA/2k+KowOsT/BTAohXHLC1WHsG0O/X7q6Kjio+s0BePjUqxhoObj31u2WSxlpot0dUNqGqTs/IfiSu4/zjqFR38yO4Y2Dzb3hcCA1fgcfmScMlJdeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291871; c=relaxed/simple;
	bh=kfm1Kg2AOZpPT3km8VFKaoGD4P1o1feWu3yhc/jXJvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWasB77/hgiqtjHeY9RXy3PDbPv4X7DQYULJWAloEqoS5/QhtduZgXR1E3AuN+mNnJt+EDHt5PGRj1bNiMOJjNUVKkrt1xZXZdjgz6CAQdCxY5F16ZItgtVfKu8lO4vHksBRNBC6uOziuero5+u5acJtC5bdfRCBdDMS49mrGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBlfEnpA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so66796245e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291869; x=1776896669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZElen3Z4amwm0t0XWaoxOdcRPl3srZ97suuS7VwNhjE=;
        b=eBlfEnpAcNnJxJoqlZmW5j1S1Mq8byiW4JpJCrEiLURRRIpbiPwcZEiFw3JRMQT+Ab
         U5wa424oFE461yPKWS34iM+ZOL+KtRPc0YyKmKnPpEGUeWsbenVyiwH9eAFZQKRK0V/V
         ke3YjqskDUIn+7Ve7r717eHFFPMU0SesHIGDul/raV7X1lMFsaGxebImNeztVDoCT4U0
         blPys4ppKMPY5E7YkRjXhPeUr3w+kGIw2f0lkg6UPKduDOcpTWnLDAooZNzffrx9wiJt
         OIdK20U3epKGONjCZLcuZq+kaajlT/rIh1NljnA1wXKKqpB12xVfLqb1BdzrHVpYaUHQ
         +y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291869; x=1776896669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZElen3Z4amwm0t0XWaoxOdcRPl3srZ97suuS7VwNhjE=;
        b=RNqv65LeGPG4O5QKQ8kUCVD4ODRgZ4Wf4ICq/NRkOMI43zMI5uk9JBwIznm4Tbhb+9
         g3wLd1EOraKKCmylrBRDz+/eRhfI0HWk7kjxGJ0ryEUpsGHbEqNEuLlxrCTpP7Haeq+P
         /lKHPvAZcKw4TxbM5JMt8vhZGYs4fJ7jzD3lHsHtm1vw84dGJw1VZkUawURC9yixHZIM
         GTsFk9pb/koxZ0XlfgTnGDLHJS0f902w8pC8h1nlQh0Iq1H5dkxGBqI2cyr7Og2EChqe
         Czb9H57+3ha5nV1lwCQHeLqEqtLx1DY2vHFWn6TY7SK1W7FpfY3Fk+AvVujpC8XZBITm
         QaKQ==
X-Gm-Message-State: AOJu0YxBvYay/TFELNhXi+Lq7mXz3lIUlHBcmwS6JjKnr03sxp23hwpg
	4X/uIvl/V2dj5+euLCF2wx3K8tEiMpckkutmBxN934T2+NAaB0R++fk=
X-Gm-Gg: AeBDieseMS08hS0ZqxKVJzvHge+H+TNcY3gxnPEJqoiEAaBwCAOD+r2YiXLHGAonwNs
	V5aSMU1N/CIjs+pEyKzOqxGBk2ZE0xJlf9/hkQ5VJ/04BDfjca9woYlQ7UFmG7kN85b4EHSgDoQ
	wSB8qTiJVfDTEs/ZPFsocF7tlSOIeAdcpLfTp9BP8OvA27kWNMVhR4KkXnufv6/lsLG4ZjLKmzQ
	mA3UdXcl/zZulS/FHNrubmsNSUMZe3iuMU69W1QOkbLAd9ND2et1XpoHHSkX1u/R9Ws4c3SqpC7
	k2u+drcgVO3BDGHU6O+OdxeBKcMBDVwhvgKJvWKI84QF2rdg7TwZWh+WNnJzxkJVU5to+DAuFBn
	pD05OWAxIibyTD1JSpAF9m55LVhj2e2fWM79jwPZKa38ZeUmEtAjajVEo9GLBFDg56jU8hEKsFG
	ZTnN4=
X-Received: by 2002:a05:600c:64c9:b0:488:c40b:c8b9 with SMTP id 5b1f17b1804b1-488d67b8d4emr344470555e9.3.1776291868489;
        Wed, 15 Apr 2026 15:24:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813954sm1896615e9.3.2026.04.15.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:28 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	b43-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: b43: fix OOB read from hardware key index in b43_rx()
Date: Wed, 15 Apr 2026 22:24:25 +0000
Message-ID: <20260415222425.1544638-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222425.1544638-1-tristmd@gmail.com>
References: <20260415222425.1544638-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34854-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19B68408AA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled key index in b43_rx() can exceed the dev->key[]
array size (58 entries). The existing B43_WARN_ON is non-enforcing in
production builds, allowing an out-of-bounds read of 1 byte from struct
b43_firmware. A non-zero OOB value causes RX_FLAG_DECRYPTED to be
incorrectly set on un-decrypted frames.

Replace with an enforcing check that skips the key lookup for invalid
indices.

Fixes: e4d6b7951812 ("[B43]: add mac80211-based driver for modern BCM43xx devices")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/broadcom/b43/xmit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/xmit.c b/drivers/net/wireless/broadcom/b43/xmit.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/broadcom/b43/xmit.c
+++ b/drivers/net/wireless/broadcom/b43/xmit.c
@@ -704,7 +704,10 @@ void b43_rx(struct b43_wldev *dev, struct sk_buff *skb, const void *_rxhdr)
 		 */
 		keyidx = b43_kidx_to_raw(dev, keyidx);
-		B43_WARN_ON(keyidx >= ARRAY_SIZE(dev->key));
+		if (keyidx >= ARRAY_SIZE(dev->key)) {
+			b43dbg(dev->wl, "RX: invalid key index %u\n", keyidx);
+			goto drop;
+		}

 		if (dev->key[keyidx].algorithm != B43_SEC_ALGO_NONE) {
 			wlhdr_len = ieee80211_hdrlen(fctl);


