Return-Path: <linux-wireless+bounces-31034-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPhbFdbpb2m+UQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31034-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:47:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0BA4BB6D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C794260DD72
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770F13AA1BE;
	Tue, 20 Jan 2026 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpmbZPfM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043D354AF6
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939876; cv=none; b=JPmL30vzq8RXqljQyWHmB14NFbir3p60AB4YubS3olPqq2WCqFfsEyy3JAUy7z4DqCOu4wavTMpSuNYBgMT+eSry9PJ/QR1bputpoIruAcj86Mda0eLU+R/bqAbnT0nigXFkCRgzJva0H3ipUxvgmemy0pb7pyYsPEv0P8nB+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939876; c=relaxed/simple;
	bh=RRBH0UHPVlQWfG4Wwrnkl+pIQ4TyQWXm/+2gN2alFno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6hzbQN35oKjKA+Y/InZT+yuPZS6TOwY80cu9o+/TkjOr3s84beac53ur5YVI5+KGg3nwgG4bda35izOrWotGfndEpdaFflpwMXu7bquBj6pGvg9IRfItouqQb5AZRmk42ELuN0V6mq0eQsIQrsZEMbbkGNYRUpuq312IO0s9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpmbZPfM; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b7070acfdcso776654eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939871; x=1769544671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gozi34aOF6cyrG5FN8NDIhdFKRbqzfMHt5Dibx6zW+g=;
        b=IpmbZPfMJbTcE7N4BYmMr+toak0NrblOGnuNQxWmSU8pbjDaJY4l3SLVh/2kG6gUG4
         aPGpCXnjESHDaqLpv0A2y/GMET+gAu+O7Pjw71pa7GWtrrh+MrY7iiBiQH28rOtg/4bx
         GKadHOhLG8FdYYgmuj/u2Vi2Fjx3f81m+kmJosgTjuE7cx95LfzIr/eOUHwMAtNPb2Qq
         jPcnScs6zUlWeiv996whQa74sHUhOdjkDlfAx9ZRbZpGf39fdBBelOx3SCK/+H6phiAC
         P3Zmq3W3CjNNMoFAs9zIdBGHv9Onq9S1efzwU9zsRLk/5zpgC5+yvZrNd0w2UljiGtIc
         TeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939871; x=1769544671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gozi34aOF6cyrG5FN8NDIhdFKRbqzfMHt5Dibx6zW+g=;
        b=ArFeotnv+/JIh1SOveIMuV/em4x2BcYIOI3SUhfNDb8zGYr7WfNHSXTbJtkg93yS4W
         VI53sivMc+EKYKrMjzMJaQfo9dOryf4CvrY2gZPzqGsF/Asbjw5hlWrrlB9xZr7SUF4n
         5iKjkOsXO+oz6KymFNIYudELb/1D3+oTpDb5sVgWgfANGICHm0KfrBHoFGxphTmmAKQc
         bfuNosKGsPkpLSE1GRSaUptTo81rFeflEPSKgnqxwYqB0UUvJlAvoaUhht8j/IjAajcu
         SL9MnHnqeYt/HSK4OJvvohlyQfAYIbSUB7vlTr3a0zULqDx5C2hG5t7FG8ppOFSiMvPn
         TvLg==
X-Forwarded-Encrypted: i=1; AJvYcCUmGo4TqUL0HpTodBypw495iO2MWLMONvQ0NS3AMHUVG/b3TVv+iUFEpaEFZGNpoi8UwfuLu+r4sgXFbMJxiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMTqb99j4zDsNSpwZFVnOBsGxfiKjQxmoAv0DXgmwJH0cMWyv
	qf4gMY3N4yqiXFf9k521jZRVerR0qFFuYZd0WN8yLC2ZAoL59cPop8KG
X-Gm-Gg: AZuq6aLoOIUfl0iPGYZbGwbKKStmVf3ymDJZOEFFanL9Q2jXgMXVUEEi6bDL0X/ZLuJ
	2C8njepyio1Dj8AK16DRcZM4HuEcIwETlQv3UG7y+2u0qYNVG4S/SbrMDJnfQkmC8j3fsWEkGcd
	Mfpdl3WbnWzowuu9rEv/4/nF9tWB5ijLHOxheZmvJ39lOXU4Ijfi/WE1qGCiFhZUC6ZpaGdr/t1
	IerMTKVUAc6cYskhJTdxMyqU6D114lnS4nMxZdHlqQxtmsrHMh0zoRw00SIeIlAGc26TwxrUsVU
	dVLwNmdZmOtcG7JASNzA+UWT3a2+7jOOAcV4e2gZABbkAVOOlKHiTLH6MWB34z6yHP0PMPQG+5i
	18slD7Y4suNWhN22u1Lm6OWlBh24G3HmjNZ8bWoaNymRTvwBwkrZsaq/tSiWsoesRKjdiu2Xflc
	YZvFvC2SDIBo1Bo94E+7ovVT4n/Tlcs17gEsIYC7vOjj4GE2mubaU78WQFmnlXZw==
X-Received: by 2002:a05:693c:2d93:b0:2b0:5028:bafd with SMTP id 5a478bee46e88-2b6b46c68femr9374962eec.8.1768939870242;
        Tue, 20 Jan 2026 12:11:10 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:11:09 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH 10/13] wifi: mt76: mt7925: fix MLO roaming and ROC setup issues
Date: Tue, 20 Jan 2026 12:10:40 -0800
Message-ID: <20260120201043.38225-11-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120201043.38225-1-zac@zacbowling.com>
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31034-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,zacbowling.com:email,zacbowling.com:mid]
X-Rspamd-Queue-Id: 2C0BA4BB6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

Fix two issues related to MLO roaming and remain-on-channel operations:

1. Key removal failure during MLO roaming:

During MLO roaming, key removal can fail because the WCID (wireless client
ID) is already cleaned up before the key removal operation completes.

When roaming between APs in an MLO setup:
- mac80211 triggers sta_state changes
- mt7925_mac_link_sta_remove() is called for the old link
- WCID is cleared via mt76_wcid_cleanup()
- Later, key removal MCU command uses the now-invalid WCID

Fix by checking if the WCID is still valid before sending key removal
commands to firmware. If the WCID has already been cleaned up, skip
the MCU command since the firmware has already removed the keys.

2. Kernel warning in MLO ROC setup:

When starting a remain-on-channel operation in MLO mode, the driver
passes incorrect parameters to mt7925_mcu_set_roc(), causing a kernel
warning about invalid chanctx usage.

Fix by checking for valid chanctx and link configuration before
setting up ROC, and use the correct link_id from the vif when
available.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  9 ++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 20 +++++++++++++------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 59a5b22a6ed6..7d68b08f445a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -609,8 +609,15 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
 
-	if (!link_conf || !mconf || !mlink)
+	if (!link_conf || !mconf || !mlink) {
+		/* During MLO roaming, link state may be torn down before
+		 * mac80211 requests key removal. If removing a key and
+		 * the link is already gone, consider it successfully removed.
+		 */
+		if (cmd != SET_KEY)
+			return 0;
 		return -EINVAL;
+	}
 
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 1c58b0be2be4..6f7fc1b9a440 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1342,15 +1342,23 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 	for (i = 0; i < ARRAY_SIZE(links); i++) {
 		links[i].id = i ? __ffs(~BIT(mconf->link_id) & sel_links) :
 				 mconf->link_id;
+
 		link_conf = mt792x_vif_to_bss_conf(vif, links[i].id);
-		if (WARN_ON_ONCE(!link_conf))
-			return -EPERM;
+		if (!link_conf)
+			return -ENOLINK;
 
 		links[i].chan = link_conf->chanreq.oper.chan;
-		if (WARN_ON_ONCE(!links[i].chan))
-			return -EPERM;
+		if (!links[i].chan)
+			/* Channel not configured yet - this can happen during
+			 * MLO AP setup when links are being added sequentially.
+			 * Return -ENOLINK to indicate link not ready.
+			 */
+			return -ENOLINK;
 
 		links[i].mconf = mt792x_vif_to_link(mvif, links[i].id);
+		if (!links[i].mconf)
+			return -ENOLINK;
+
 		links[i].tag = links[i].id == mconf->link_id ?
 			       UNI_ROC_ACQUIRE : UNI_ROC_SUB_LINK;
 
@@ -1364,8 +1372,8 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 		type = MT7925_ROC_REQ_JOIN;
 
 	for (i = 0; i < ARRAY_SIZE(links) && i < hweight16(vif->active_links); i++) {
-		if (WARN_ON_ONCE(!links[i].mconf || !links[i].chan))
-			continue;
+		if (!links[i].mconf || !links[i].chan)
+			return -ENOLINK;
 
 		chan = links[i].chan;
 		center_ch = ieee80211_frequency_to_channel(chan->center_freq);
-- 
2.52.0


