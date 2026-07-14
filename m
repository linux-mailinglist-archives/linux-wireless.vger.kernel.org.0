Return-Path: <linux-wireless+bounces-39076-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IfxXGwFRVmov3QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39076-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:08:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B87563EE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:08:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DeIh8Z2T;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39076-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39076-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8B5B3020AAE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B75480352;
	Tue, 14 Jul 2026 15:04:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3748AE18
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 15:04:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041486; cv=none; b=RTMLlZYBk48cBzb2SAen7jYeiFfpbyYQuDDO0qAy1RJAJzjbkXFsxIa9eVb5RTsjcFjN0eNPq/EZt5G7kIxzp+DT4KJhrXUENtPTZTnzpsZX5J9dIF0DG5FFt/dSRZbE5EFmqI53QpP++Qz4D/m+jiQ6y9Lvn69BVAUb4fzMpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041486; c=relaxed/simple;
	bh=zw7sWG9NMsbCDcycSEpB+JJ+Mh7QJC4TEmEfQVhsny0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUle1t1O6ZM2xcbezWTZgjEp/k1OODudPTT2gKgv3nlE0xjxZmPw3AdSoYAb4WyvyYos88TWNQIfIvx1AJLEJtgvTOAoybfciea5S5MXag9StMIiY7zAlE9dBi44/1/KlbQZ4JZxIw4b7iljsfQmf54pn8FgHvkzTRZmPqJRNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeIh8Z2T; arc=none smtp.client-ip=209.85.161.42
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a375aa918eso124348eaf.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784041483; x=1784646283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ah3OjIXDJ8FGYTbK7t3P/0aF11VxI9dGNiWaxqwvQI=;
        b=DeIh8Z2TutJGgVSHHRuMdFLl4hJpsIQLgBSn4+yQUfakoxdvJ7sku/ESNbcDBjFRG3
         9B+DKNEJRpdmPSN3lfM9/TJ1bDjH/pM78vNSg9njZnNY3t2wa1XPId2Dv82KfE+yVFtC
         rP3EoDGZTWJYf083/wBXLf2Ijr4BpsUPWcZ0UcXobLuuARuSFztnA9nZiTwNud4PLtYo
         kpRSM3s2wrYyS3JhaHr4ftnyecVvqPaCjOJSBdHG536ol3VxjFg0vOussVncjR4dlNYG
         OxVfomnpEWsGeI0sIYRwF/dvZhgxZKpIHxOr774bBdtLWpCk/A6XnYwsoDOgiFyVEfkV
         0e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784041483; x=1784646283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ah3OjIXDJ8FGYTbK7t3P/0aF11VxI9dGNiWaxqwvQI=;
        b=VBIUtq9GRA8b8F51l8Hw5MkH/YWVP94GhSOlEb6n679roRRkm10cf4LEuUnLSWMGXh
         hD0fUiL68W6FGODlN2tRWKC6o3r6ifLzPHRtrtwVmcgg99ukKR6vE+pyEom0jHa6UbUC
         sixkZ6TBiZm+NfYYteuaL4OmVS63yzCPJFsM6YSIQzGZrQenGWyhbrUYdMBs1aKUz2xj
         JgMnDYehpZmeFgRyq7fl9Aw7dGj23+gyr64SrVKeA0kcQrNUjUMfJI7iIl3aEauXYttZ
         P3yaFGacQBslKROIViNDABha/MtuiSjRl9uX5Cog9NIoR0ByC8lxPeQ1Uq4Imsdh5r83
         YgBg==
X-Gm-Message-State: AOJu0YzaoDItVKrNU09iazH0JEGFDqMIZhTsyENzwIEPJzeiNxmM65l9
	WJqLfKAguAvUmNd9Jnps9F13r4bvECWN7mctoi5IgRW6pXG0Y9ul8d5R
X-Gm-Gg: AfdE7cmg0ch4vx4eu6Tnpv3m+TIGTpkt6DxKrLQRARsce3Y7YsakH4CTkV1LkqfWJAi
	9CIMP5Qr4M8gk1yWolHbCc5ENWbG84HT4ELJRwY3jwVlmpEx0i+fMxN8kPcr5XpQkVzwhQ1fsGP
	dZjALhYa+pqYK4UvkPantXwK0nEZfSTQ05cRB0aaUKZvxlAa/tgHdCOxK+Q1z6TkYjOd5deMr8w
	N1aJzUUk0FNl+zmI2hYOI7cXaErlmDcLEJ3yTRGKSiy7Mj9dKhfyvpFZLzfZlfh0fbfbk2B86rK
	9qyCSvDdcuT0ImRWvS2++E4JhbGpfdE1Xqlhf0mBOcJtUfQws/1HG8ZxRdqbIq33LkcpMMosok4
	Af1NJtvweeAIrrPtEK/3dDBq9I8vko+zmBp+CQsttZSBnQelCgkvBFGh/KSUM1Sc89uSJQXoX/i
	fxLrfhmmeCj56x6sJcP855YzHIGGUvxwTV+JZHY9gyAjOyrwTMZh/JE0/6jWi8OWESBerbn8+b2
	imZebe7OyHkilz+I6vu1ho7etwrJX3JLMrk4LaGMDiJWn+8CMiXq7oeCa8=
X-Received: by 2002:a05:6830:2692:b0:7e9:c6fd:c36e with SMTP id 46e09a7af769-7ec097b3ac9mr5781922a34.3.1784041483243;
        Tue, 14 Jul 2026 08:04:43 -0700 (PDT)
Received: from 3155-XPS.case.edu (casewireless18.CWRU.Edu. [129.22.1.27])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae206e2sm15301403a34.2.2026.07.14.08.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:04:42 -0700 (PDT)
From: bogdan.nicolae@gmail.com
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Bogdan Nicolae <bogdan.nicolae@acm.org>
Subject: [PATCH] wifi: brcmfmac: cyw: clean up PMKID and cookie code
Date: Tue, 14 Jul 2026 10:04:23 -0500
Message-ID: <20260714150423.53960-1-bogdan.nicolae@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39076-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bogdannicolae@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:bogdan.nicolae@acm.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bogdannicolae@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D74B87563EE

From: Bogdan Nicolae <bogdan.nicolae@acm.org>

Avoid setting packet_id to cookie, which is always 0. Instead, use an
increasing atomic counter. Avoids mismatches of completion events later
in brcmf_notify_mgmt_tx_status, where packet_id != vif->mgmt_tx_id is
checked.

Also, zero out auth_status on initialization. Otherwise, garbage will
leak from the stack to the firmware (when ssid is less than 32 bytes
and/or when params->pmkid is set). Then, pass the params->pmkid to the
firmware (without it, the firmware caches a garbage PMKID on successful
authentication and denies a subsequent association request that includes
the PMKID).

Signed-off-by: Bogdan Nicolae <bogdan.nicolae@acm.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index ce09d44fa..99f8c5bef 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -23,6 +23,8 @@
 #define MGMT_AUTH_FRAME_DWELL_TIME	4000
 #define MGMT_AUTH_FRAME_WAIT_TIME	(MGMT_AUTH_FRAME_DWELL_TIME + 100)
 
+static atomic_t brcmf_cyw_mgmt_tx_id = ATOMIC_INIT(0);
+
 static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
 				 struct cfg80211_crypto_settings *crypto)
 {
@@ -123,7 +125,7 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	if (!ieee80211_is_auth(mgmt->frame_control))
 		return brcmf_cfg80211_mgmt_tx(wiphy, wdev, params, cookie);
 
-	*cookie = 0;
+	*cookie = atomic_inc_return(&brcmf_cyw_mgmt_tx_id);
 	vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
 
 	reinit_completion(&vif->mgmt_tx);
@@ -200,7 +202,7 @@ brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct brcmf_if *ifp;
 	struct brcmf_pub *drvr;
-	struct brcmf_auth_req_status_le auth_status;
+	struct brcmf_auth_req_status_le auth_status = {};
 	int ret = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
@@ -208,6 +210,8 @@ brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
 	ifp = netdev_priv(dev);
 	drvr = ifp->drvr;
 	if (params->status == WLAN_STATUS_SUCCESS) {
+		if (params->pmkid)
+			memcpy(auth_status.pmkid, params->pmkid, WLAN_PMKID_LEN);
 		auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
 	} else {
 		bphy_err(drvr, "External authentication failed: status=%d\n",
-- 
2.55.0


