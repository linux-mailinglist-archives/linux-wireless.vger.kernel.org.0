Return-Path: <linux-wireless+bounces-38823-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l0u9HDORT2pOjwIAu9opvQ
	(envelope-from <linux-wireless+bounces-38823-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 14:16:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00420730E28
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 14:16:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=acm.org (policy=reject);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38823-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38823-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4078303B699
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE864218AA;
	Thu,  9 Jul 2026 12:16:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA641F7E9
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 12:16:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599393; cv=none; b=r1hd/bTRkqKDOjUwcwv0ycENxtTt80+ybPorkUqcmbS6a/CnKXsJMu6sbcHS6/wg33QnFN06J1kKExm3bL+0/xl88/gMGwV0GPlQ7x9e48LO/5AJKSLDIB1cMH1p/uE9X/fVTBrlYNfIhSEgyC8jnlfxJIOHaqsXYEaAQ3QcRvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599393; c=relaxed/simple;
	bh=HIHypxlLytZGTSHRjU6ziFuzBnYOi9naX7hETgbaqpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJXSHZqPAEDR7zLFF9yr4LCF4xr3kr7hS7iUWkfz+13LBStz55amyfdxfcuHE6EU4pZ7IDw+3GuyhvOs4TX3VO9BWDAY2DrendRFF9Wp380CCDpzh5zVBUiceBPyvqexSv6D2GL7imD6NjqakLB6V4TWfJ3+Q4Ctst10NuBFKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84863668029so34621b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 05:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783599391; x=1784204191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Ng1a+200d11qTnNY6DeqCpI1uBPK99U30nYmIrkcq0=;
        b=i/dELXzt5TEc+iCvWxsBKLkkWoeE/nuJUKgPJmWcZ1Tl9+qSrajOiGa2l22y8oPuXa
         LG/xcvP87fThxEtgJi3ghHdINiFjFyAZZ+7NfrUUgJtzmhMTWxwma2xFy2ctvanY9/Hs
         ZucFnkjiHfQjLz8XPHyww7GoN9REQyb5drlAwB7h1JQjEnGrBAp/SJA3YHq9A6RNCu49
         VVQs+tcL/QC4xN0TRf2PlTK0e7BiREaARVkKl/45N1aFYwezEz0KZuxtzpygj0GjFXKf
         s8ZQQ2x8wqbtBFh7C3AgI9k+aLI76Le/Gug0cq25sUULjdmhodmYNMCme6CcJFdFG+aV
         N4WA==
X-Forwarded-Encrypted: i=1; AHgh+RoA5m54LlusXRQ2900bWyIUQVmgvJAcz+MW+Utp5/L7XHjpW6s033MPm1uqbzO9UOUpfT9pLpSIO1KL3B4nAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmJBCistrpulbUwRNd6ivvh6hbhvxnbzqQG8neU9Sy8hkUMde
	Qb4xdxS8TVu1kbj3ykIeC5ivZIBWvQqHbJP0d4cSqT8i7peNAUasCD1K
X-Gm-Gg: AfdE7cnmD+vCxXlZR8fCE/O4u5Wg9MGsDTGRsfovLqzVuiQFSban5nQXVa7siLiv/gf
	yjzGlaaFF+Cn3zG6yGDdfHEADgZnwj/kI99xCCAhIxw3VDgvuPsWGzb2Pvz46VwbShMo8rXbscB
	zDndc5mXmlcT366otu6lFcxs/U3nt/Aaop8uFp4SMf71+WSjJp0rEMd01Hi51FK9PKmlVjK80ct
	3fcDDT87ykGIU61HUyYJnZ7+dz0j27XX6wEbMCXjFXJ25x8KQbhu09XBgR9RVlw2nzCxm/wL6m0
	yLfY/Q2D+IOpz9URo6ow14Q5lSzbyQbjlckjP2j0q+ECjkQtL38KkkVZS9/F0zuHTN6mzMCTx8b
	zr/T3Yw/F2ne5DKLKyRcRCld0lP2MQGTvUl/YoyLnM/D86z6w2PQi96o0Gq9THpj3FmC12Qctvu
	4hTvKhpbxCubA+ezchf4iwTeL79CNJqiQf55d0zGswq3+PAcrzknmEVM7agZzXXY+seGvvEdka3
	/OGCPERUmOuhg==
X-Received: by 2002:a05:6a00:a0c:b0:842:3932:71cb with SMTP id d2e1a72fcca58-84855fe8b89mr2198327b3a.4.1783599391199;
        Thu, 09 Jul 2026 05:16:31 -0700 (PDT)
Received: from 3155-XPS ([58.227.72.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8486479b378sm534048b3a.12.2026.07.09.05.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:16:30 -0700 (PDT)
From: Bogdan Nicolae <bogdan.nicolae@acm.org>
To: arend.vanspriel@broadcom.com
Cc: Bogdan Nicolae <bogdan.nicolae@acm.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: cyw: clean up PMKID and cookie code
Date: Thu,  9 Jul 2026 07:16:05 -0500
Message-ID: <20260709121605.10974-1-bogdan.nicolae@acm.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[acm.org : SPF not aligned (relaxed), No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:bogdan.nicolae@acm.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38823-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[bogdan.nicolae@acm.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[bogdan.nicolae@acm.org,linux-wireless@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00420730E28

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


