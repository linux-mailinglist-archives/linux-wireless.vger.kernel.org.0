Return-Path: <linux-wireless+bounces-38607-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lpWxKRo7SGrpnwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38607-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 00:43:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B264E7060D9
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 00:43:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=Fp+lQsYh;
	dmarc=pass (policy=reject) header.from=acm.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38607-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38607-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23207304B04D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 22:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E29259C80;
	Fri,  3 Jul 2026 22:43:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB61F4631
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 22:43:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783118614; cv=none; b=GPpbFYJkC3B1xyQko0ZZnRugS/yUL1bGHb+1Cw2lQwOJ1BtmtpXHTQVLK39qrc9M1fCzi739ld3vrNLkaJVmYza5++q0JaS6CSntI6ifVCMPEmunrfh871O0YvH0NexBjaNyP/TQECQ5dcfslydEZWWBNJU5McOUrrzkRpUBvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783118614; c=relaxed/simple;
	bh=eoZe2aeMSGB0yLehGKbPfX7pLT30XOJhOwGSvyjPs40=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TsGkAw/fVlzRj2Xyu2NagJLzGH7EWqldmmyJaDtNPME/RQmly/SsN4ICz2Npt8gll1hS8A1KZ1Z+/Gufl4DG5LLjic2XONr7JEuLwDLS+D4xVOBPnMOO+CmfKjaUW8MTM+qnuAsD6y7cojpQ2L+HCKj9MKMOWzYxFSo8Y2Bubu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Fp+lQsYh; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gsTLX4mRWzlhH0B
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 22:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-type:content-type:subject:subject:message-id:date:date
	:from:from:mime-version:received:received:received; s=mr01; t=
	1783118611; x=1785710612; bh=9crJ0MXL8cyvtFFWI/xFl//GhDodklwUxXl
	E6rcG8t4=; b=Fp+lQsYhT38vmjqS+Jw3W1E0eddkMzTFGklANH0yBpdpwlyfrcC
	RPtJ6j+S7KKjBmwPhZZdRQEWam3fJ/T+bhXaBx8BUc0QjHREfFy9xyaVDrrwwTZA
	8U82jlvq6HuFtkFdvVvJeufSuiyD6mLV3coA64VcbYcIkpgmY0Q5wqOmKyHZCrrB
	shCTJOqogEGQEJ2z4yLnetoftlHSviv5l+gblzcQK1xHugoON1l1fCNLtT4r0Lwb
	39PtTa3Rg5odWuMBzm4ZI/Uf0Ijt4Eon6p3LhGEs1zErDf+ALeRq/QnTFzHbjvJn
	RL0nLB9kfg6Jqy9f7OdG4PhsSHDHhijzK2Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TYu0dcLdx-YU for <linux-wireless@vger.kernel.org>;
 Fri,  3 Jul 2026 22:43:31 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bogdan.nicolae@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gsTLW2yTfzlfl8L
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 22:43:31 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698c1df9651so172670a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 15:43:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YzXlDjIaOyMW7X/MFKiwjnh7pRjWbd/tTVcswW8yipErPu8nKj/
	YWaeECkBppfJ6jaEZ7FTglFhKKCkgyq6g5vz6F1S2in6KIDo/FgQ3Ya9DbcJ3JkuH3aiQ/3n9Hh
	JuV8gg7TaJ8gPVMo0qH1wLdjfjeHRnBA=
X-Received: by 2002:a17:906:7952:b0:beb:3449:5fff with SMTP id
 a640c23a62f3a-c12e3cb2fe1mr35273866b.0.1783118609795; Fri, 03 Jul 2026
 15:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bogdan Nicolae <bogdan.nicolae@acm.org>
Date: Fri, 3 Jul 2026 17:39:51 -0500
X-Gmail-Original-Message-ID: <CA+ORkNQPL_qdLOSC2Ae0Y7-wihKVRaaO-DUajN-3rpjzyoEtjg@mail.gmail.com>
X-Gm-Features: AVVi8CdXe3pSxerqc5jsVpcP3oM9iW5EoM3Wh0UnMLjs3qoByk61FbqQ8rG9ylA
Message-ID: <CA+ORkNQPL_qdLOSC2Ae0Y7-wihKVRaaO-DUajN-3rpjzyoEtjg@mail.gmail.com>
Subject: [PATCH] brcmfmac-cyw: clean up PMKID and cookie code
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38607-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,acm.org:from_mime,acm.org:email,acm.org:dkim];
	FORGED_SENDER(0.00)[bogdan.nicolae@acm.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[acm.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bogdan.nicolae@acm.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B264E7060D9

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
.../net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c  | 9 +++++++--
1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index ce09d44fa..06e5dc79c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -2,6 +2,7 @@
/*
 * Copyright (c) 2022 Broadcom Corporation
 */
+#include <linux/atomic.h>
#include <linux/errno.h>
#include <linux/types.h>
#include <core.h>
@@ -23,6 +24,8 @@
#define MGMT_AUTH_FRAME_DWELL_TIME     4000
#define MGMT_AUTH_FRAME_WAIT_TIME      (MGMT_AUTH_FRAME_DWELL_TIME + 100)

+static atomic_t brcmf_cyw_mgmt_tx_id = ATOMIC_INIT(0);
+
static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
                                struct cfg80211_crypto_settings *crypto)
{
@@ -155,7 +158,7 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct
wireless_dev *wdev,

       memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
       memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
-       mf_params->packet_id = cpu_to_le32(*cookie);
+       mf_params->packet_id =
cpu_to_le32(atomic_inc_return(&brcmf_cyw_mgmt_tx_id));
       memcpy(mf_params->data, &buf[DOT11_MGMT_HDR_LEN],
              le16_to_cpu(mf_params->len));

@@ -200,7 +203,7 @@ brcmf_cyw_external_auth(struct wiphy *wiphy,
struct net_device *dev,
{
       struct brcmf_if *ifp;
       struct brcmf_pub *drvr;
-       struct brcmf_auth_req_status_le auth_status;
+       struct brcmf_auth_req_status_le auth_status = {};
       int ret = 0;

       brcmf_dbg(TRACE, "Enter\n");
@@ -208,6 +211,8 @@ brcmf_cyw_external_auth(struct wiphy *wiphy,
struct net_device *dev,
       ifp = netdev_priv(dev);
       drvr = ifp->drvr;
       if (params->status == WLAN_STATUS_SUCCESS) {
+               if (params->pmkid)
+                       memcpy(auth_status.pmkid, params->pmkid,
WLAN_PMKID_LEN);
               auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
       } else {
               bphy_err(drvr, "External authentication failed: status=%d\n",
--
2.54.0

