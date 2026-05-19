Return-Path: <linux-wireless+bounces-36623-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MKOABLFC2qWMQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36623-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 04:04:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D0576402
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 04:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0671A301E224
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 02:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B483279336;
	Tue, 19 May 2026 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeuzRlJF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87921E097
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 02:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156217; cv=none; b=heqKv7J8waFjEcmicFGgmhFTH+EkC4lzgpRpAOos+u0nH7+23MDQz0GOvzaeMJQ5kBxPpX5qKkIAAJcFGMqeE4uFLVlu+aLdXzgvbcMxseGHZJ7k1+6m8gQJDNI8FBjXGZnR8oqH8IUhyKHzWjtZdStrwXiG60+fsa7PmjtCEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156217; c=relaxed/simple;
	bh=+2ks5IyZDIpyKrflcXcqYihPSNSz0qlvjHFT6HtFca8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBg99WT6/hk6QLfZVDul+YWMdG4fdXGkuyNmQgSmkJC4OU3Ie0w9kxn0DxODzZ5SKg+d52sWJxPDR994yLUrT44/h6vw6aKauJNBgP5Tq/BwQmQLtnU2jKkJoVp5cXW7EJwPxt6NBu8x6Y9t0JZeXyThgPiZfc1MVZDD9u2iB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeuzRlJF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fb8e9a4edso40559891cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 19:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779156215; x=1779761015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=poH9AbfhQYjUo+75MNUZiyRZvCuirjY3PJxBjhTKSTQ=;
        b=WeuzRlJF9c0HcQfOL43Dn8wOsOUo2LYNeAV84cKq1GbeqdIR2CRoIldwADpgxYJmyd
         8AW4jwXzUWFqmzm05YCZATQQPYv9/tIHbkRid/xtq+mzvEO1RwNXWEP+eDPtGPeuB1JV
         9HO76N9YBkxZ5llMRDvx0y2KBuTzhBPZaBTewEKqWzIji8ekSCdcwfgZvZS9AY4VuYk/
         Hn1sUF1foC/bXNTkoxoD8zUAIRDigyxnAunnC7iT85Y0Y/Rh84li379v4vCl+lqCInAU
         sMvy1ihAUC/qESdnOpjsFxWLxw3hRTYGlKVquH4RRcTtZyX5LH02EwJBee6y0wu5YS1m
         mLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779156215; x=1779761015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poH9AbfhQYjUo+75MNUZiyRZvCuirjY3PJxBjhTKSTQ=;
        b=U1HdpY3QC7LHtXs4ZbPfRQ0xyykaIGqnNc2MYAy0Rsi7Bj6XVVEdvfI4QmG0h6i2y0
         Y0/EiSP2QXL+sJzWB6iDMoUVh68O3i5LSlOIvqJH04M73kskAP/7AGAl39idsVP0Bn7s
         FQydgk2jIW8Hjx32ER60pLSLp2CfJcVI7H/p8lieIcxrp1zQaTx9lpz1z1pe/TtpIER8
         hHl9yzqszXreeGGSqoutO0G8imlAaL4ZrHi3axBpkcz6I82zowiWWkt2ofrqfiH7RlGI
         14agXoYNqO9TVCSKwC1/k13uoXydkEdEBWviepzP1Zi+aZxVSWhdXos7uNXnkmGHqQlu
         LB3g==
X-Gm-Message-State: AOJu0Yy+aqWgE2CpcL+vUMHG66C9Y8sMIk5qBCjLy2TjRNeuY2WVIc3m
	KwcqfEiO+sV7Fz5SKWIm9bdd/sHrQwmpNPiWSIvk95WE/svWaQuNJsictV7rCVfe
X-Gm-Gg: Acq92OGg/hPahxVuVimtymntHcjGyIG5Zx4gPe1JXMiqh0swLdKlzVdURjq8oJUmTb7
	mXMVg411XhHxcLlTvqTn96Id15qLWJcRBzm8g+XE/beRt7IgeelH/8dHPlg37Q8swQuyraPFqN+
	sKibPxMH/YgH/YzJAPV4MxnuUqbwZRXteIkDAwXutjqJwCSbpj/caUVBOh2g2uT5BKzy7CwZZg8
	2nME9EIHXKBIh7uYeaZOreCIUyl+Uxjdz+iHdxc7vCTe9E0NHRNRLtTZv+5IN3DzvLK1we27kKa
	oJ53SN6dyGtdtou1MpB7+TN+oPGId/l2jEhA8QjBG4xrFqCD70KKNpEglEkrwH6A5pKnEoFj8D0
	D11xnyKsRyO+Q9x5VkYll+I3yhFzd3nLIBLzUrhWHYhZ1cdXiE9HuK/i9YVLni8b6U+FjX6JeC8
	IkZMrMHy6Tx4dr18yzKNGVs0pDxoxxcPaEjq0NjWJO+B/FAjt1BadHzB7Idg1DVDpbgyopyyije
	BZorEmMlBVTeVK1i4q+H2msSOZNzUAxvyqYmrMEMY3RxiIC7PNgtN5X
X-Received: by 2002:ac8:5996:0:b0:509:35d1:ca3c with SMTP id d75a77b69052e-5165a007384mr241207301cf.5.1779156215389;
        Mon, 18 May 2026 19:03:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d5c4dsm148874901cf.12.2026.05.18.19.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 19:03:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	wcn36xx@lists.infradead.org (open list:QUALCOMM WCN36XX WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: wcn36xx: allocate chan_surveys with main struct
Date: Mon, 18 May 2026 19:03:17 -0700
Message-ID: <20260519020317.635011-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36623-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 984D0576402
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid allocating separately with a flexible array member. Simplifies
allocation slightly.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 13 ++-----------
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  2 +-
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index c3f0860873de..ad8a4bd910d2 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1568,7 +1568,8 @@ static int wcn36xx_probe(struct platform_device *pdev)

 	wcnss = dev_get_drvdata(pdev->dev.parent);

-	hw = ieee80211_alloc_hw(sizeof(struct wcn36xx), &wcn36xx_ops);
+	n_channels = wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channels;
+	hw = ieee80211_alloc_hw(struct_size(wcn, chan_survey, n_channels), &wcn36xx_ops);
 	if (!hw) {
 		wcn36xx_err("failed to alloc hw\n");
 		ret = -ENOMEM;
@@ -1590,16 +1591,6 @@ static int wcn36xx_probe(struct platform_device *pdev)
 		goto out_wq;
 	}

-	n_channels = wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channels;
-	wcn->chan_survey = devm_kcalloc(wcn->dev,
-					n_channels,
-					sizeof(struct wcn36xx_chan_survey),
-					GFP_KERNEL);
-	if (!wcn->chan_survey) {
-		ret = -ENOMEM;
-		goto out_wq;
-	}
-
 	ret = dma_set_mask_and_coherent(wcn->dev, DMA_BIT_MASK(32));
 	if (ret < 0) {
 		wcn36xx_err("failed to set DMA mask: %d\n", ret);
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 7ee79593cd23..8c43f67bd780 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -298,7 +298,7 @@ struct wcn36xx {
 	struct ieee80211_channel *channel;

 	spinlock_t survey_lock;		/* protects chan_survey */
-	struct wcn36xx_chan_survey	*chan_survey;
+	struct wcn36xx_chan_survey	chan_survey[];
 };

 static inline bool wcn36xx_is_fw_version(struct wcn36xx *wcn,
--
2.54.0


