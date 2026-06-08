Return-Path: <linux-wireless+bounces-37475-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o4f/Gj1TJmqIUwIAu9opvQ
	(envelope-from <linux-wireless+bounces-37475-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 07:29:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AD7652D0E
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 07:29:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Em5Zj5EO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37475-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37475-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C73EF301C8B2
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 05:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE06378814;
	Mon,  8 Jun 2026 05:29:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E93254A8
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 05:29:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780896553; cv=none; b=OFwX6oidktn8ETaxhC5lbInqZEiXkZhn7nWU6IApF+NULKC2If+oeub2J5JIu8kTXZ9OmoiPpEl90Jm935N1d/xaAp9Nojo5maSq/Panki8SW5QYliZGk4zr9T6q6hrnuw2QbbQOqZjO8j3zNfuQfnDuqiOFuyhPAGpChAi7ClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780896553; c=relaxed/simple;
	bh=sn1Da+qab2ghu45yZQ1NL+qe/wKBTFTs4DdzaUey6UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhRxT3kngz6un+jb2hto3R/IWEkc6PJLTu9OZcdxrCweRuAl/kmTkBiilvNnVbopvTShXqaWo0hB/Y0henNoLOK+0Zcuezp/cXpyhv5Uqk+PEt/lT9uttIqcW+U0GGgnYrdKqTyQJYqYrrZWREQRphLly0nISCcHpFyjoy+i2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em5Zj5EO; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso26263925ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780896552; x=1781501352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTm+lQvzMCNToRs7ARjdaJ4x4SDnep7jgjKlP4xAmow=;
        b=Em5Zj5EOLsCk/0Kstii8635VMFBTHfMg46CBtdF5K8p73APGUYG9MCXRfNcrn/8zZR
         D2Fx5Q1BU2fRjz9PTRAIIA6eM7nC5lzPYM+ZrYosUhBh8UaFXwnjLz8HQC0idv5wSXLg
         sEdLiX/BIW2MKE3elQolku35etuL5cELshAAzWO0pL9JcfKHoku7EmmgJbMc/QvcGFCJ
         x83oZw+MqZOBPxMs0Bz8DU9ThW/6FotaazBNwwb61jGg0KEdjXjVBrgxXPseSTlYLgvm
         ofd8wf/h4IvUv2NmrPpAluHmqjDMaRMk0TJgHXRb5OIeIA3CV9Aav9baScQVZdHYcuEM
         Z/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780896552; x=1781501352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTm+lQvzMCNToRs7ARjdaJ4x4SDnep7jgjKlP4xAmow=;
        b=VdOjE2qM4aODhuKrd2gpSOIdpv6ajAJViVV1wiN7d5UKyFKiXEMSJu0lIKfiJ/2rln
         22DhKSht2gl3ZOTXeXPOuEX0HOjn1BVec4M4jPrMEne7sHSI88uoCNMwHQtkhA2bJjUG
         6zYxC4cMgtpp2tJuwUPmmoKjSuE5S5h8hHpJM3Zxyts6bn8+KzvugLxZ8eb4frw81fYl
         R0rPx6QQnQMFKJs1jfbXX7L7wyqLj7dROsbE7K88xjma688gzfCo0XMbhZ1uecIGq3MS
         EmwG1eAjAaVZR9Wdvou8TrD2pvgkYBiV6XdHw57F18dg667BN6TLlNb6cAMBYdE+iygr
         Dquw==
X-Gm-Message-State: AOJu0YwTRiOWM+Dj+QmVOirGFVyRe7KKnoW7RPozv2qMIR3p0WKjiF7e
	PaDP4uPd/6EaLZvDscB0c+Za9NIoAeayGKbme9uWMIFjdIoiEjcd8t3Li8mPOaua
X-Gm-Gg: Acq92OHzn6iI8NKbYjRcdwp2p3SQuJnhzCRuHeVUW63NV9cjnQZagLkoCdIrXsG0m8t
	V0n9n86ghf7nuY5EmycKOSNbmxW01F9mGSzb1bveiMqYbyzHDvGf/ulmqd1e4mSWziYdasvIdY1
	RXn6W6hUxDb3I3nZiKddItSra66NlOhY2/8c/PK9WxwwUbyyHmzJfFDG9yhdSE7JfIakaYun7pk
	KrCwPSRhWyG9lBESBzM7zjZzKgYaTbxwWpnPGYK4mHekWPpy0scvwOr06w3Mp+fKQl6GT0B5kip
	XcOmPlNcBvnhapc8HX9P7nHztg3/mFEq/03QqTQSZcIzRyT0IzSCzWs7Bjmx4wEbsWmCTBTyOcy
	SPfJpPBgek3gy/wKiTznfSa1Bxg9Qi6DLpfmjODp73fqPQwkY6NHiK7g7M0G1v28OhwRVbhShwM
	Gyjc2OMyr8YzsWBLqJU8cv2O6K6XOG5OwReIQxsI/8NlaBL8KQ++IvzSj9E+QlW6lw1U67YJarw
	NS3Af6Vib4nV6Ls1jfOGEaz4sdYI2TC2A+FC3r7DQDWOw==
X-Received: by 2002:a05:6a20:7490:b0:3b2:86c9:baa5 with SMTP id adf61e73a8af0-3b4ccfdbb5dmr16989108637.38.1780896551959;
        Sun, 07 Jun 2026 22:29:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b56c5sm14461062a12.27.2026.06.07.22.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:29:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 wireless-next] wifi: brcm80211: change current_bss to value
Date: Sun,  7 Jun 2026 22:28:54 -0700
Message-ID: <20260608052854.11718-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37475-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:arend.vanspriel@broadcom.com,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0AD7652D0E

Change to a single allocation and remove some boilerplate.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: change to value
 .../broadcom/brcm80211/brcmsmac/main.c        | 40 +++----------------
 .../broadcom/brcm80211/brcmsmac/main.h        |  2 +-
 2 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index c7eaf160e1fa..ec3aeaa7bab9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
@@ -418,21 +418,12 @@ static int brcms_chspec_bw(u16 chanspec)
 	return BRCMS_10_MHZ;
 }

-static void brcms_c_bsscfg_mfree(struct brcms_bss_cfg *cfg)
-{
-	if (cfg == NULL)
-		return;
-
-	kfree(cfg->current_bss);
-	kfree(cfg);
-}
-
 static void brcms_c_detach_mfree(struct brcms_c_info *wlc)
 {
 	if (wlc == NULL)
 		return;

-	brcms_c_bsscfg_mfree(wlc->bsscfg);
+	kfree(wlc->bsscfg);
 	kfree(wlc->pub);
 	kfree(wlc->modulecb);
 	kfree(wlc->default_bss);
@@ -453,25 +444,6 @@ static void brcms_c_detach_mfree(struct brcms_c_info *wlc)
 	kfree(wlc);
 }

-static struct brcms_bss_cfg *brcms_c_bsscfg_malloc(uint unit)
-{
-	struct brcms_bss_cfg *cfg;
-
-	cfg = kzalloc_obj(*cfg, GFP_ATOMIC);
-	if (cfg == NULL)
-		goto fail;
-
-	cfg->current_bss = kzalloc_obj(*cfg->current_bss, GFP_ATOMIC);
-	if (cfg->current_bss == NULL)
-		goto fail;
-
-	return cfg;
-
- fail:
-	brcms_c_bsscfg_mfree(cfg);
-	return NULL;
-}
-
 static struct brcms_c_info *
 brcms_c_attach_malloc(uint unit, uint *err, uint devid)
 {
@@ -527,7 +499,7 @@ brcms_c_attach_malloc(uint unit, uint *err, uint devid)
 		goto fail;
 	}

-	wlc->bsscfg = brcms_c_bsscfg_malloc(unit);
+	wlc->bsscfg = kzalloc_obj(*wlc->bsscfg, GFP_ATOMIC);
 	if (wlc->bsscfg == NULL) {
 		*err = 1011;
 		goto fail;
@@ -3813,7 +3785,7 @@ static void brcms_c_set_home_chanspec(struct brcms_c_info *wlc, u16 chanspec)
 		wlc->home_chanspec = chanspec;

 		if (wlc->pub->associated)
-			wlc->bsscfg->current_bss->chanspec = chanspec;
+			wlc->bsscfg->current_bss.chanspec = chanspec;
 	}
 }

@@ -5423,7 +5395,7 @@ void brcms_c_get_current_rateset(struct brcms_c_info *wlc,
 	struct brcms_c_rateset *rs;

 	if (wlc->pub->associated)
-		rs = &wlc->bsscfg->current_bss->rateset;
+		rs = &wlc->bsscfg->current_bss.rateset;
 	else
 		rs = &wlc->default_bss->rateset;

@@ -5450,7 +5422,7 @@ int brcms_c_set_rateset(struct brcms_c_info *wlc, struct brcm_rateset *rs)
 	if (wlc->pub->_n_enab & SUPPORT_11N) {
 		struct brcms_bss_info *mcsset_bss;
 		if (wlc->pub->associated)
-			mcsset_bss = wlc->bsscfg->current_bss;
+			mcsset_bss = &wlc->bsscfg->current_bss;
 		else
 			mcsset_bss = wlc->default_bss;
 		memcpy(internal_rs.mcs, &mcsset_bss->rateset.mcs[0],
@@ -7809,7 +7781,7 @@ void brcms_c_init(struct brcms_c_info *wlc, bool mute_tx)
 		u32 bi;

 		/* get beacon period and convert to uS */
-		bi = wlc->bsscfg->current_bss->beacon_period << 10;
+		bi = wlc->bsscfg->current_bss.beacon_period << 10;
 		/*
 		 * update since init path would reset
 		 * to default value
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
index b7ca0d9891c4..2d133264f4a7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
@@ -614,7 +614,7 @@ struct brcms_bss_cfg {
 	u8 SSID_len;
 	u8 SSID[IEEE80211_MAX_SSID_LEN];
 	u8 BSSID[ETH_ALEN];
-	struct brcms_bss_info *current_bss;
+	struct brcms_bss_info current_bss;
 };

 int brcms_c_txfifo(struct brcms_c_info *wlc, uint fifo, struct sk_buff *p);
--
2.54.0


