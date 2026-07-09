Return-Path: <linux-wireless+bounces-38824-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eG8JIQeUT2orkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38824-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 14:28:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2571730F9B
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 14:28:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VcQYxiwu;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38824-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38824-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D23308D498
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56476420877;
	Thu,  9 Jul 2026 12:23:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85841F7DA
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 12:23:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599823; cv=none; b=lTzi/TZVHS6ius9I0yjfCOeJom9QY45Cunc82aA150fuSCGQPQvuN6q+E/FQeUyHerz9rj65MiWN5tppqTxTM0Qj0xtquElSnfaAbTRTGVOLI+/HKUVe7OwaiuMBlTbJrTwhBvLGrVB8TWbGWUBoFlkFUoKaEIxEW4VFbJPfm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599823; c=relaxed/simple;
	bh=HIHypxlLytZGTSHRjU6ziFuzBnYOi9naX7hETgbaqpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQi7r15GaXVPOdEW+sQslumx0PHOvxx8u/Yj4v+Ur0V4MMasvhEnbqtD/nXDAKVqSSSF8LGGh95Q6AUOQ2Oe4O5D9HxV7qEyWyU+5f6NIlXGAH+vczUFFEMf5Hv0jQ8gecM44+tLgpVhxq33Ls5uwU5wXdNtYHp6KuMRRo9p5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcQYxiwu; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8484a24ccf8so117228b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 05:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783599821; x=1784204621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Ng1a+200d11qTnNY6DeqCpI1uBPK99U30nYmIrkcq0=;
        b=VcQYxiwuegS/MepWRjWJoFWA+lv5bsLzSXhJVkI7NbmlJvTgfzy3mi1U3BMR46/FX0
         mrhmyst/GdQw8BB5EHdJEeEcXvBOt6wl4L2YDj9B8IVKXw7u121DMHStoju7XhsJkUZe
         UorHyk40C4PJqqrQz8CgsRb9EPq7EZ8yjpqxOJ1GB6pDd40WShme36iserWU6hQ8yuqg
         uUEGKsKQk+WBRSzsrW3T2GROC2NEMUDG9yIrweA0Eq5cl8RXHMDsfbGmlN48bDZj/Bp4
         cTZTkoYRn3xc/xVedEIZyiHcuZN8TNKOY0fJvgyUH8laihjiyybOvxOPFcWwZzEWwrFH
         ICCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783599821; x=1784204621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Ng1a+200d11qTnNY6DeqCpI1uBPK99U30nYmIrkcq0=;
        b=SjIMNj21R61MxEcDFLTcP0rGFPPwk7Rw8pBxekSFT8H6ufQGgbdYXOEGxv6z40UbpH
         WmN2QQjskRzT1FW+zHnS8F7JGOxf2/PjKq0RMIQVaOTJo55dLTIfYtQiXAIPtMSpe+pb
         bifRsQjwjuDdSer48ijTfnBC3qq+QmWg8bWBezq1mtB4RJ1FCi9FzynQWYOxiGWODjMm
         7ncaupSftohuhulaDctOIwZ9tORgCTv1Y8WTWomf+05Bx5sKay7nLGn+3dA62+kpubrJ
         ph+5BWICbGAtorJE8IhZnKQZX0Rw0fu8aLuZhtKLh+k+CjWRe8wgYx5Bebtb2p8pkGZw
         p54g==
X-Forwarded-Encrypted: i=1; AHgh+RrIFaTC+WJPulVGu77OR25jP8btSBjUuYh110fhM4eIZcWmn9hiIlVNVZ3NyA3dxJTTe79XGa0rMzkW4y/jJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7w5/sSgO1NhhpySyYcXx6vWasmcwqYHfQFltbigUxDupj8Fs3
	jdtGQMGvp7e4ox6I+bEIEwYWQg22D1DJz5rYG63OP5DcLVM0mv/hM26J
X-Gm-Gg: AfdE7cmgJ5p41mBdUKK2gCL5gNrR1JsDD+cuYzhFQdeKEYjJzqv4gJM4u+8b9CtDIaZ
	s10Iz8LKlNmxoZ3HWSU/V1Ts0ymjz3BilPzdjqTcQlJ+X3RgVGFSnZxJmhyVJU30V5KT409N4kV
	2jQFpvVrbiews7DtbbftpH+7XO6N2Y/kQl4CiZW9EJiOTMhXOfcbFXzu5uUoGJIaQwzT+xIV50G
	dcwntpO4GwqFGoA7uAiXhFrMitGmBKOzoNGXQgN6e7qw9vve18pUAceCwlmz5bqht1ykJoC+Ndh
	UzLwh62bLjpx7HgwN07FoKy1OHdtAJ3KkTbzcBTkc1QYD07JIyVXuk+xbB0umuzkq1IU3TLYzzw
	UiSAYSAGF/iaas6Ch5M6R1KBLNdVFVfFkzCdpEBfTC3f47LQ4+zFIlBMXQzT8sAs/Zl1+1Yx/x8
	YR5sA7avyrZWVvFxN4y47wVgHC8+eMZVRs8ml1RwfEcT9KykHhsywT7v54DiDRSNLHwP3MuuXm1
	RNB8Cvy/gDav7ka
X-Received: by 2002:a05:6a00:b47:b0:82f:99c5:868d with SMTP id d2e1a72fcca58-84842fce286mr5194785b3a.4.1783599821422;
        Thu, 09 Jul 2026 05:23:41 -0700 (PDT)
Received: from 3155-XPS ([58.227.72.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848490f7bd8sm2249744b3a.13.2026.07.09.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:23:39 -0700 (PDT)
From: Bogdan Nicolae <bogdan.nicolae@gmail.com>
To: arend.vanspriel@broadcom.com
Cc: Bogdan Nicolae <bogdan.nicolae@gmail.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Bogdan Nicolae <bogdan.nicolae@acm.org>
Subject: [PATCH] wifi: brcmfmac: cyw: clean up PMKID and cookie code
Date: Thu,  9 Jul 2026 07:23:15 -0500
Message-ID: <20260709122315.11400-1-bogdan.nicolae@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,broadcom.com,acm.org];
	TAGGED_FROM(0.00)[bounces-38824-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:bogdan.nicolae@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:bogdan.nicolae@acm.org,m:bogdannicolae@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[bogdannicolae@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bogdannicolae@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2571730F9B

Avoid setting packet_id to cookie, which is always 0. Instead, use an
increasing atomic counter. Avoids mismatches of completion events later
in brcmf_notify_mgmt_tx_status, where packet_id != vif->mgmt_tx_id is
checked.

Also, zero out auth_status on initialization. Otherwise, garbage will
leak from the stack to the firmware (when bssid is less than 32 bytes
and/or when params->pmkid is set). Then, pass the params->pmkid to the
firmware (without it, the firmware caches a garbage PMKID on successful
authentication and denies a subsequent association request that includes
the PMKID).

Signed-off-by: Bogdan Nicolae <bogdan.nicolae@acm.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index ce09d44fa..cca53ff19 100644
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
@@ -155,7 +157,7 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 	memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
 	memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
-	mf_params->packet_id = cpu_to_le32(*cookie);
+	mf_params->packet_id = cpu_to_le32(atomic_inc_return(&brcmf_cyw_mgmt_tx_id));
 	memcpy(mf_params->data, &buf[DOT11_MGMT_HDR_LEN],
 	       le16_to_cpu(mf_params->len));
 
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

