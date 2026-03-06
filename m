Return-Path: <linux-wireless+bounces-32680-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFW/Mgpiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32680-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E83D228A1C
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9B4D302510B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A44371CFC;
	Fri,  6 Mar 2026 23:23:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17F35E950
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839432; cv=none; b=GO4f5itLZFU3DZkndRFGUhRG+GR9ogpHJrrvCYQTYZicGouE73SeNVKtlp8ZnjyO09YHDD9LHNyyRxCA8fbILYnGmTsr2bB4UU0CZfXEZCiRv+/QqwdkX7VpavktzdC9W0hJwQdhdDWaeN8NkXRXTzD0QIYkh0syepEsl13Ealw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839432; c=relaxed/simple;
	bh=PmgRnCbBFuVdfUCYmvJ+68rzDuNswAQW7zgmTjj4vkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ge1XBoXGeRCz+Gs7zAHtdaqE4+KE/9DkgK8jjpHuf9cngb24aWuZ4jGVOyn2StmWnaaygN6W0Ho0RIW1uSuFnjtN5DiiP2NjGmWq6b23ziZhpwZ7oKU1BOMc+dAlK3+kcDqmeo2tm2fCvUyfy8EKRF7o9eB+SAI+I731/dEuqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d596a5be31so8697381a34.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839430; x=1773444230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RZHt1hQYwL2zDMvByDBWz3LSjb+YIIi96dDLYWC91BQ=;
        b=T7QjtXCKQhzc1Ud/HAnURd4TJkNSzBDuzSzVP/wa+hMPhVURdzTSmTur1OtccHg2K4
         /YR/Voscv3+hVeuyKfobC7gYWOjFQ2LKPIRTjQcuEGf6AN4Y6t9v7xl8lu14V5XF3PyU
         ZNGx0/Cz1ta2tOgQAX+LEK3vrG50MJF8kskInNGIOXGEKsTSluzNt2Or8ZedHlkBPVle
         jPJ9ZS6nvR6sxJA82sacpto9X+jn/9TfCkf5qr/2+FfdNP5wVi+9f9MP5b9nNTPbqH1F
         PMTe8hNGuOrVkCBNlnTIMTSgqEtW3QP8HMmchuNjRqeL5Tr4f5WmaPRkFP2bEA0SkyrB
         vUXQ==
X-Gm-Message-State: AOJu0YzM2hIm7iQIZypFzEHl/JqfWoi5vVwaXxUgk1hQR2SHJ1gsC7XQ
	iLPyHqesBxt+sHMjjuagexuUtafXQIn35h/4bCXyhzdjSVY1QeVTdp9Q
X-Gm-Gg: ATEYQzyMr6XOb6DtgRUrDhERpPBMMRKHPcRe7huCqjkJ+qLOmJxpjHdkUPbra2QRnDS
	DyRe79YKmowT5u7I24eG7FUFIeoSf8p+ej6KUbEewhHH0RYCUUAuhSAK8F8gQ3AZ8uqS+RiEfJ3
	+1mT8jKJ/EUnKv5vW0BF2jRAOcIuliCCZopmMpejyujJuxnOyLQf8vUqQA0hZjIQAJrgpLB5AH8
	5E5jq252tnPNtZw0PkjLjRg8WyVBuGvEUHTsTYeQEeBQgJZ09vHwRmOj8ihKqbjqmCXEBcJ7J+i
	juRRbEe0fyHckgE/mKR0sGjFjAcwDoqslvoGNE+u4G/e+j9pi/ZWZfuFZrxkySrjziUFOtmER16
	brdCYgfVtVSs+mkTJ79eOdhE80eyde0PriEZbUyy4Bz9+j2b4oITqXD7rUv6aDNn1IDWvWjYYNv
	qwwgh0yzbxnecPDKk3v7lZXlD8fcJ+LyBvp3ySljsoWNLGzCw=
X-Received: by 2002:a05:6808:7006:b0:463:1f4a:3b91 with SMTP id 5614622812f47-466dca336ffmr2127111b6e.14.1772839430495;
        Fri, 06 Mar 2026 15:23:50 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:49 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 15/19] wifi: mt76: mt7925: drop WCID reinit after publish
Date: Fri,  6 Mar 2026 17:22:34 -0600
Message-ID: <20260306232238.2039675-16-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306232238.2039675-1-sean.wang@kernel.org>
References: <20260306232238.2039675-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E83D228A1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32680-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.350];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Remove the redundant mt76_wcid_init() call after publishing the WCID in
mt7925_mac_link_sta_add().

WCID is already initialized before publication, so reinitializing it
afterward is unnecessary and makes the setup ordering less clear.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index dbde91727cd0..d99dbd707fcd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -891,7 +891,6 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	ewma_signal_init(&wcid->rssi);
 	rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
 	wcid_published = true;
-	mt76_wcid_init(wcid, 0);
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
 	memset(mlink->airtime_ac, 0,
 	       sizeof(msta->deflink.airtime_ac));
-- 
2.43.0


