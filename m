Return-Path: <linux-wireless+bounces-35298-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJKaIAUb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35298-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE5A4678E0
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA7B0300C80A
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42912305E28;
	Sat, 25 Apr 2026 19:50:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEE3043DB
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146627; cv=none; b=ZRTwLX7mteq/h7bIh4HEkw9d/Pzm4Yy0JtgJfHMdjGG0uykEENLssdXOWuHPH8p770QpSYEnBsH5eNT94brIPuXjwlqErzaMNxfHE2YpNIMv+eA6ggxkhSRsQ1W0j585qlVbJBuM7TA8Hy91UCDLYvS0p7rfQBaG1KPrP8+tO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146627; c=relaxed/simple;
	bh=wLIxdqahlw4c7+reIxYPnfOLk+b+S/xE6Wj6PgHgp9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hov+T7LE0+IMvKSXnfET9yKpiQmF8zDlWPeq+SANnD5SsqCtVaraaUZknDxV+O9wboxnHRrZEwT6OUfbiubOKFqUscTRyyleIVj+thmR8E1RfADmcTC3yhcFM/sgNO0glUfmFxb/FO47Sf11Zu/3zjAWt+4m0j2HtJ1La8C2CHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d55b97f358so5823162a34.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146625; x=1777751425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWRSKgFmDsEBT3ODy/e0S7epJ/vxH7tu9uKFy4AW+1Y=;
        b=BU+rqCRg1UaP1KOXyseXobet9msVWmeIa9w475DBetSS9s7ISPB5kIwkLnJsrZhgOs
         vjYKFLFrcFzxoLiD43fEspYI8s31vnSeXlqPE2Mfjd5vzD97HQ7jK1RwzThlc7WrUrUc
         DMdRsMVWLl1JSeMpq4/YWnRT1/ymCwyzd51YCAsgZzf/JLP07nzHYY5kqhn7xOsAW/Nk
         fxsoAboUGFmJ9ugIqwmaVJuWmH+jYM9WOo7c2DTS8Ha8Yf/yc9yXaKuGUq7Z0MfhG4lf
         ckVXHxz8yoGi3wWwTtdvtqhqkyNcSBmqt1NIgO32ERI+VCM1wlxYZ5OyqtQVwN3N5gAl
         xCPg==
X-Gm-Message-State: AOJu0YwFhGvm4TarhRmCzi8ltiD8d0YOCcXUUD9JZEfmUkxUpGvVCmTq
	8SK7Aeb6OrjRgygX0IHrGHDMARSKZgVa6FjiMu4PvcYzi5MDN/bugzf6
X-Gm-Gg: AeBDietj2dwgg5ujboAtwGl6WYypv5hDVn8DKy34xmbpsyBPSoGlFNyNiio/3ZF5ah4
	q9DYhOY6UOZ3bZbs0If2LXcq22bsGC3k4fT+Rz+mTp+acFEvK3PdO2/UsZcL4DKXMzjZFCh4aZa
	B5oFiidtmydjAy4zdsrf63feQ+OtjNeshCsVpWp0PTYFgBcWN4YYV6SRmsKgAZwGjCzx7nDwLQf
	LNaCgD6XlYFYP88Sr73vaUvf340/Qtq6LvOWTtpMxNpNvzZYIzWhPY13QKe4j2QIDeYKzmFyOa0
	+pHrHCCIZTbOg+2vWijtRNmh2jUcwU60lKJYuhBmFkGNT8CsjkBHg6QrUnTt86znzRVwiQ7pojj
	ZeWWqTFWD7PXNKRp4NEG0dlg9/FBGDgOIziwIVwEyBoK5UmrNTZg0xhQGitD+dinA1SsSQWHtFP
	3QfXpbS16GblWk8sor5px4XjO18IZWNfCSwAPm2IsGu63eYCaDrZdkarIwaGWGiRGlu0q9y+pc9
	A==
X-Received: by 2002:a05:6830:3141:b0:7de:44a5:51d1 with SMTP id 46e09a7af769-7de44a55dd5mr9306976a34.7.1777146624702;
        Sat, 25 Apr 2026 12:50:24 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:50:24 -0700 (PDT)
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
Subject: [PATCH v5 01/21] wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links
Date: Sat, 25 Apr 2026 14:49:51 -0500
Message-ID: <20260425195011.790265-2-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: EDE5A4678E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,jetm.me,lgic.pl,gmail.com,humeurlibre.fr,mediatek.com];
	TAGGED_FROM(0.00)[bounces-35298-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

From: Javier Tia <floss@jetm.me>

In the error path of mt7925_change_vif_links(), the free: label iterates
over link_ids to clean up, but compares against `mconf` and `mlink`
which hold stale values from the last loop iteration rather than the
current link_id being freed.

Use array-indexed access (mconfs[link_id] / mlinks[link_id]) to compare
against the correct per-link pointers.

Fixes: 69acd6d910b0 ("wifi: mt76: mt7925: add mt7925_change_vif_links")
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
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 73d3722739d0..4d8ca04a128b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2179,9 +2179,9 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		rcu_assign_pointer(mvif->link_conf[link_id], NULL);
 		rcu_assign_pointer(mvif->sta.link[link_id], NULL);
 
-		if (mconf != &mvif->bss_conf)
+		if (mconfs[link_id] != &mvif->bss_conf)
 			devm_kfree(dev->mt76.dev, mconfs[link_id]);
-		if (mlink != &mvif->sta.deflink)
+		if (mlinks[link_id] != &mvif->sta.deflink)
 			devm_kfree(dev->mt76.dev, mlinks[link_id]);
 	}
 
-- 
2.43.0


