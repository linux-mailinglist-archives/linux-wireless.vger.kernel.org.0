Return-Path: <linux-wireless+bounces-34251-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KMDELRZzGk9SgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34251-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 01:33:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 435C5372D43
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 01:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1272300C541
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 23:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA316396571;
	Tue, 31 Mar 2026 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8FEI+xN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91ED347524
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999978; cv=none; b=FqnwBJ0KYa5uluJn/nLnRbCzo4udSApo/ySMmqBzPaQNRPC2RTh+XV8K0otGHXxMIDMFvKtAqYCkVwfVUH8UuSTysqyl5jq34EUvmI0kkE0tmRpuZ+uK5SCmKuQHgpEmAmmIONV7IzkKBHpnO3OO6Q2HAl8l7CAmat8yH4dJqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999978; c=relaxed/simple;
	bh=244mleRO43LNTUCWzp/ZKAnyfQyLqVy88A4aiCBlJ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6/xzvwIJiGDk7tFOEAnYY4/sMg6ERefsbEuPQTYSoeEmBhUbANpNmA6vp+m6NDuAs8h+SWidFkBif6sc8J4vf2YcCxsZElBL+d7MAA12/ruDU7TDS+MAiFa+3CrSIKGAP8mICye5yDniBXOlaVWl2Pg8e5PKuOvDtlGEX1tw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8FEI+xN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so2233724a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774999977; x=1775604777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=adQV9YrsC4jfyVUOST6M3hgxRoSvm9YrFP3OZEy1JPc=;
        b=V8FEI+xNTR6Rnkosnz8GlXOo2jxM3dVT6vU6v9CAd21n1NlzHAOHFlJwn6BSlp7okA
         wFJuPMV0DtMuphxqx+qR0dPYARx4UM6zwddWLn3sGn5bwT+mkYRu/lD3b9wClpawXigv
         ObR0Lq63vztctpp6q/ipeVyiivQv10aw98RBnOUJtSP/kbea7SUBdXG9xx4YGew/by/U
         gfmNeLavOuHHADwGdFFkKU5L7E+VsbLXExigDcK53wtCQs48nr1uZ4TP4nHVkSLLmhMo
         qJR6QqGZC12674cgvb9cdHklbyWztj/cM1NNse3dTnVLq5j6HA81D10yir4WLQj3dllQ
         v34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774999977; x=1775604777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adQV9YrsC4jfyVUOST6M3hgxRoSvm9YrFP3OZEy1JPc=;
        b=VA/GxGUBNmu5sWmOThhKcXQlR9d9UJnJqbSZ3aD3RN0bqt7I/KS3OLBwWpHBHxiZDU
         BHwCpwnUy9AOotFgl5hdY42wlqxaUfP3XGe46nJo19kN0b2JifdlzixI+VeqmaKPTlim
         bKfkv4icG5O2zviDMT2wkAxSkP/RZtGgjORB3Nws/0tY6oGmlRs2mmohNzqY/7Q81N4y
         GXZpydoNdoguq4nN4l9mPY6XJEn/q214XyZQm3PCYdPSribx2nl0TGYx/VVuIV3ZgzEQ
         vuyaXUJ4GSxb3bexsHgrz7pMMsqzQHUQZ7fVCnE1DhmtqyGYlvNzUZYpAlL1jDSdbTPR
         HVtQ==
X-Gm-Message-State: AOJu0YzivQNMK/yv+mBCagISDljd/9fywMmXPl8TzFTxaA+kMeJlaXQd
	JrnrnLuXwKcv8rIeiaMpLS/MhlWTi0Qr6BU9V6x1kQvK7ks7QQO/F+qsBBQz5A==
X-Gm-Gg: ATEYQzxIQrbWcQZKEwp2W7lc6PZKgzEt4pWuB0KY7qYWHbGaN2ZH7e132bUM4V1hdPi
	jec1+eEUKz9CoHIb5l026UBjUtjgTRbvvLy1O+2vYlWV4qxWNDytBA8b6BD0FbGNeD2ywZiQMLk
	8vb/4+q+gsDvDze2YCrVV9eyzdeCA+GFNllpTeqiV7yYpig5go0tcWLnMiZ3K2f5zgFErqBElgB
	bKCZAw+qvWtwmDebp2AFUT5VpqcOfUlq2iyJ3/sX9zBGmcPeyAdTJT8CId4WMhP8jzYfKorFekY
	5guoBGr7v63yBFDEQ5ty2zxHcB4Enw0nl8ljc6tkS7HxOO37hUFIbWOm5msQP5DAVMIE0LHuzXG
	wQkzOvP3EuuV5Mgr+W2a2mLTC03nUKAnlzE79rmfO+cCeV7BbY9tMdDKjBLQC2KH5Dp5UcCCgjf
	E7k293W1hwKVyv5ztVmBJxiqrI8FqhgBW54NbWd92QW55AHGJkv2qCih0=
X-Received: by 2002:a17:90b:4c:b0:35d:a62c:19de with SMTP id 98e67ed59e1d1-35dc6e7aabemr987113a91.1.1774999976654;
        Tue, 31 Mar 2026 16:32:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6d8682sm2775605a91.14.2026.03.31.16.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:32:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: brcm80211: change current_bss to a FAM
Date: Tue, 31 Mar 2026 16:32:38 -0700
Message-ID: <20260331233238.23527-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-34251-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 435C5372D43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Change to a single allocation with kzalloc_flex and remove some
boilerplate.

Done as a FAM instead of value to keep -> usage in codebase.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../broadcom/brcm80211/brcmsmac/main.c        | 32 ++-----------------
 .../broadcom/brcm80211/brcmsmac/main.h        |  2 +-
 2 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index c7eaf160e1fa..4f57d64b1dd3 100644
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
+	wlc->bsscfg = kzalloc_flex(*wlc->bsscfg, current_bss, 1, GFP_ATOMIC);
 	if (wlc->bsscfg == NULL) {
 		*err = 1011;
 		goto fail;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
index b7ca0d9891c4..e9cbb95a5a17 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
@@ -614,7 +614,7 @@ struct brcms_bss_cfg {
 	u8 SSID_len;
 	u8 SSID[IEEE80211_MAX_SSID_LEN];
 	u8 BSSID[ETH_ALEN];
-	struct brcms_bss_info *current_bss;
+	struct brcms_bss_info current_bss[];
 };

 int brcms_c_txfifo(struct brcms_c_info *wlc, uint fifo, struct sk_buff *p);
--
2.53.0


