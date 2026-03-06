Return-Path: <linux-wireless+bounces-32676-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIXmNrFiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32676-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002C228A9E
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91E2B3135EB7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7DC371D03;
	Fri,  6 Mar 2026 23:23:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA01371CED
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839422; cv=none; b=KpTO2xGNsFmnVAjesT6DhqNUborFL2t+VpsEOtVj6MI23Ksa6e+tEQfdqI7gXej8QcSa3qmy6uczC2g6v+AawQXpylAGeWvOVRrVJIAmxeEQOKw/Rmb/4vCLnv53uEzwhgVaHE4jvCFZC1dOftzIaFtqTcy6xJcinmOp02a3sxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839422; c=relaxed/simple;
	bh=rwDiiHqso/m193RHnJAy3/FL4gUTQD82LQfp9OtBIVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nf9Y59dvRfI7EjQXseuzt2Fnvl8yzzKfEOQFKyBHfWzYMj35MDkCm1fOpT9auNGjalL/XxZ7yqUqqz6n2KpldpibZ1hN0d0vIwHFwyFeA2gHUrKnuLDIUwsomVg2/t8Me2pJX2VPeDzPV8F+EGmH6LEqNfhqWWmuqEiBNYO3VWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-463b3697846so7696838b6e.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839420; x=1773444220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZWeFiCnrk6APXuKyptiq4X50TlocyQfsSTuqJwSQAA=;
        b=PAV3eHEY5HenS0nOdCYmNcbcpkpZFHOz0rQkz/R+0wOUy9OtqgoD7R4+59i4VVIuLb
         sU+EdBvBEb23H7UadWRqFs4kuQCwrdp6mlRzporwRCYisycsF6FNQkcBPDB/dB6EK2o2
         BFLmYeZyDHd00XI4wSWUFKSuVEnIJGOYo4YerN8CpxM2CwKlItAvyrO1FGm2+q9DZqeS
         tWl1TeBThEuzlGbSdWEeCtSBJ/QnRyYKGm0wVavHGvyR+Zgnu8xBxmOBi5UkehAvzJNa
         grY82prPNDrDUzZKCvI9fUQZRo099EIh0pQnaOuZOT9xvNkA+D7cWDxKtCHdjj+Mjqsz
         MMxw==
X-Gm-Message-State: AOJu0Yw/ZWiPeZVqGTU5O6XZ4pUN5Y7Ip978b5HyDcmN5EOXol7QQuMf
	ZhBAtKp8ph2nj5S9566nPln8LU2htJJk+X1aA6ZmYYv+3q16ZlJ8fazT4sr3bg==
X-Gm-Gg: ATEYQzwTqEleVn6Spg6qIG5gbG2a2SBLkYkqAStxb7vJUMZ/tAqyvn3RtBue0rTJkvL
	tEnt6UZRaP2wU0Csu2J8oCB0OeOoLYdPxLT51/GmbLAOzU1KNyQVWOrQ9dIYXkepYTbRGGrhEK7
	yrFlHSvL/ClyTNna4lnpumPY3xT4PTLH6bQIeBk/Xe7v4svLZANEiH28uRFAQmzKQCudlCiPFXU
	Tjv3lMC+qclelFxKDT+uMepxUSK6SkbubHsShnWwfNxKTqN9NtGx63Dz9PDHsCNgGtX5ZR91eK4
	BaVWLcmYHKjUiQXtiwQDuO8T2tmXdUi+4BTA7zxTxX02VmyLOzsE79Qn3iR09UJZEYuQv/h0vDd
	gysEqCpykFeEqdObRI1h27KdDU4ymfsV+5WODbje5GI8mjsBQGVEnyDnwrLnkIvW9zpkN2LO1Bo
	3JjkWa50ZZLvBSAsPcZjtn+tBWRH58iamGTKUR79QybLgQ4yU=
X-Received: by 2002:a05:6808:2394:b0:455:e5c2:a6f9 with SMTP id 5614622812f47-466cd097d9fmr4666819b6e.14.1772839420166;
        Fri, 06 Mar 2026 15:23:40 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:38 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 11/19] wifi: mt76: mt7925: resolve link after acquiring mt76 mutex
Date: Fri,  6 Mar 2026 17:22:30 -0600
Message-ID: <20260306232238.2039675-12-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 2002C228A9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32676-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.352];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

mt792x_sta_to_link() uses rcu_dereference_protected() and therefore
expects mt76.mutex to be held. Move the lookup after
mt792x_mutex_acquire() to make the locking explicit and correct.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 68f168a093f2..135a803b4382 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1071,11 +1071,11 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
 
+	mt792x_mutex_acquire(dev);
+
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 
-	mt792x_mutex_acquire(dev);
-
 	if (ieee80211_vif_is_mld(vif)) {
 		link_conf = mt792x_vif_to_bss_conf(vif, msta->deflink_id);
 	} else {
-- 
2.43.0


