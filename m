Return-Path: <linux-wireless+bounces-32779-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGHlK8xCr2mYSwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32779-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 22:59:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C7A241FB5
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 22:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 645D6305B286
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12BF36D9F9;
	Mon,  9 Mar 2026 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhV8hBhF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0336D4E7
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093566; cv=none; b=MdFnbly9uKwy9j/fd4XaYkKdwg7Lt+pAUMb5jXeWAdiQnCQqBNJKB/olPcEYS5+Z8gI+67jCGNOEOHwLdbO+1aNXr2iMHY32KkhyqDz6r3UDGf4mi9S7lHSKA3RhwvtnY8ICbag8cuQQDwmsHs93BLcvvhrbqV2EVUSt0eVK1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093566; c=relaxed/simple;
	bh=kObAVCbb+jpcqXP8F2TOeB9w96vxc/Xlt6AHbX5ZaNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRaW83HWFuFVhdE5L9C/1mlKUlRZkIBynDkLWIKSrbUCvdvP3HsLaiUdMJqJs66IO0lQ4NNp4lOUi3e2ETDOlIeYSd4YSBewqPvQNruL9Aq2gaPR4WPkTNMyKszxlStNqScDAUHPe9xBd1PaTICEOfSU+8/yiP7aby7zpVLuS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhV8hBhF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad21f437eeso89031295ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773093565; x=1773698365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFThMTXhCHZfafF7yRX+oXe/JOAwoBeaEDhHGhvUqK4=;
        b=PhV8hBhFHsrN/v/3nKZ4FX/ByfDb6AXxU1z5nyYcc1MxUThLTbDm7qaqG27+MlRh6/
         +xFQQBO/oOc2vnHPhFlFabL7JiE8IKo+ktehceGsyFqKjUZSEApH85UKYqBzWEzaeVOK
         bM3WrlfKnBmGMS10Ij4MS6g1am76HVW8maGBR9SPQb/ArjXEbWlH2AFH1CJL7Ep/M9qd
         ioojQCpg1sBGDoyCDp8mmOelwNiRy7TexiN75MM6uxOD/cH+Cod1nRMAKab9IqhprcL3
         lBfzJCZo2gKmRbckx5vzyJGcI4DjgCLvWTU4ESiQXUz+R7Kr/bzZtjoRDXwhaaO5F4qM
         Vo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093565; x=1773698365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFThMTXhCHZfafF7yRX+oXe/JOAwoBeaEDhHGhvUqK4=;
        b=jBt1urdG5IHkoSy0k0ZzEGwcuiysdPDUQiaKoF9gFhZkMcprAoVSbIC/JwvLLhj9+O
         1+56btKHL/sCmpdPFFrUyUTLNEEoLs/MnT0QrzmhDxoLpvrOwUntLUU8ijaEZdg9/ack
         Eh3fOYsvgRHB3p5VtQrrTHL1felLClamirqUtwYSnit8GOUBf6I+ZTewZY8OX8Ndfy1J
         peZj5qgQ0mfLbMxmy0cVjzgTGMvLnR2lV21b68sy+qsJQ5/RJDBiByxjwlK3LBehdkwa
         FMs+dvk/OpPMQMNNbDTgK4d3bmLaCjYBktmPhoz1gAkobddM6CthWfW9si3nWx1XrvZq
         crDg==
X-Gm-Message-State: AOJu0YyToYVGElVkLUnA4jlVqQ9M3FQqwaAP2QrDK3hruXGGzaNFKTGc
	lZkHSybwB0iJFPKyX2BYGCba89kmL9+f8+8cBXAwwT6VPntjx/Pu2BJpW6nVrUK7bMQ=
X-Gm-Gg: ATEYQzxyUJ2+FEZsxde4jGEMBYT3omp4l3puC0kRvXec7Bo6bQCYoc5hNC6GyTJnYvr
	6GHf2vxtebQO3NJijEohpk3qbHeWhPuokG6+ukGfr/jxnSOA0V5AwjW6JHIXkLqielNf1yBMO8M
	9otoBImnEAwd6z35QRoYxHEFaU17TYAYRlj/WFYWK3UEi39KqqVn9MZ2Dv886Ne6TjxQWCRuqBY
	BHfyx1Q2WmxlL0umSqBtCy/SnsG35a+jy230Hl4Om0bYV/fOh/ExhwnwZwtWcUHnEcSpSpUFKhq
	1PntcVwHkj+Tx9vDznmlM2H6flC+cd/oHPCnnxjeRbK8DqhQdfr2+Gch9Pak96tOmd4Qgti988N
	Fi6EZdg/J4qv6G/+FZkMv9aM8DnZfoaNhbVQkUYvvO2o4heeEuda1Krr1pGDGM6mwC8L/OcyA6S
	Gy00xGfhXNmYFq1kOXG55hb4zuo8DMsfPH43vrHOYxckLPU+NRhg7LEQ==
X-Received: by 2002:a17:902:ffcb:b0:2ae:5c39:89c9 with SMTP id d9443c01a7336-2aea2036f7dmr8927095ad.24.1773093564589;
        Mon, 09 Mar 2026 14:59:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83eafc64sm169450715ad.40.2026.03.09.14.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:59:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 wireless-next] wifi: brcmsmac: use FAM for debug code
Date: Mon,  9 Mar 2026 14:59:07 -0700
Message-ID: <20260309215907.5789-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 51C7A241FB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-32779-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Debug code requires a separate allocation to duplicate a string. A FAM
allows properly sized allocation with a single kfree.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: rebase and remove debug from member.
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c     | 15 +++++----------
 .../broadcom/brcm80211/brcmsmac/mac80211_if.h     |  4 +---
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 6255d673d2d3..7912a999f6f7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -317,9 +317,6 @@ static void brcms_free(struct brcms_info *wl)
 	/* free timers */
 	for (t = wl->timers; t; t = next) {
 		next = t->next;
-#ifdef DEBUG
-		kfree(t->name);
-#endif
 		kfree(t);
 	}
 }
@@ -1499,7 +1496,11 @@ struct brcms_timer *brcms_init_timer(struct brcms_info *wl,
 {
 	struct brcms_timer *t;

+#ifdef DEBUG
+	t = kzalloc_flex(*t, name, strlen(name) + 1, GFP_ATOMIC);
+#else
 	t = kzalloc_obj(*t, GFP_ATOMIC);
+#endif
 	if (!t)
 		return NULL;

@@ -1511,7 +1512,7 @@ struct brcms_timer *brcms_init_timer(struct brcms_info *wl,
 	wl->timers = t;

 #ifdef DEBUG
-	t->name = kstrdup(name, GFP_ATOMIC);
+	strcpy(t->name, name);
 #endif

 	return t;
@@ -1574,9 +1575,6 @@ void brcms_free_timer(struct brcms_timer *t)

 	if (wl->timers == t) {
 		wl->timers = wl->timers->next;
-#ifdef DEBUG
-		kfree(t->name);
-#endif
 		kfree(t);
 		return;

@@ -1586,9 +1584,6 @@ void brcms_free_timer(struct brcms_timer *t)
 	while (tmp) {
 		if (tmp->next == t) {
 			tmp->next = t->next;
-#ifdef DEBUG
-			kfree(t->name);
-#endif
 			kfree(t);
 			return;
 		}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
index eaf926a96a88..3b25a56958b3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
@@ -42,9 +42,7 @@ struct brcms_timer {
 	bool periodic;
 	bool set;		/* indicates if timer is active */
 	struct brcms_timer *next;	/* for freeing on unload */
-#ifdef DEBUG
-	char *name;		/* Description of the timer */
-#endif
+	char name[];		/* Description of the timer */
 };

 struct brcms_if {
--
2.53.0


