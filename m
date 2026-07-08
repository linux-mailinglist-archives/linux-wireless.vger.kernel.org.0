Return-Path: <linux-wireless+bounces-38779-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ELSmLrXwTWqDAQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38779-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 08:39:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD07223F1
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 08:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RhNd85Mc;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38779-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38779-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6450C30099B4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 06:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FE13DA7D6;
	Wed,  8 Jul 2026 06:39:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D03B893B
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 06:39:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492786; cv=none; b=H7iYpnoWVbzmHf6OAIjnf4ORHo4vAtGHp/v+h15NjHpGyNmQtal6l66i268qlqDOsm1kUSLBhfWSb8LctsN+eIt4th6I6UOs+fWX3GHhN1WexiM7g3+VuRZWQAh5K6cM97VOwWaqUiB46m5NZ58NWlm7n6bX+tkzlTSLI2pgG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492786; c=relaxed/simple;
	bh=LgC4gkyGCU91XJ9gLGCgyFwioRp8mRnj3KTl84mVb94=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EXKdMaeTLN/fHnU60CUxtvNgOqYlafVpgjq8Ud4rgigsJJKvH4cpTtEdyy2g+rDo0tn66jZIIaRLStHsetX6739Ey5KJCxBq2ZmAXPt0DBGFOjUc6QE3Q7FmoV8Sr0rat4ieLy9P3ZD6U6qqaw4Bmdv8LdDTOvaNtC8NZ+rwW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhNd85Mc; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381ed661712so351193a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 23:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783492781; x=1784097581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vUl5ihFLZ0ZNzBKHgZhdM4ygyPUK+vq4TwX6IU2C3RI=;
        b=RhNd85Mc1nNIwNm4O9aX6F2NCvRagA58IXltmK/lAn/2q+TT4utw8MKnYhBJh4tFII
         W5bmRJnSrKhv4+pgOPhZbzYynRz7kv3c5za3ANd1c9HqAYCQpPTd6fIpl98/yYkfnzo3
         uImplr8tVFNGFXTq6QayFCkQOZePyDjcKMHH3/1PLkzJ7xcajaNjmjY5mauCfigCcwKr
         Ly9lY41SJbgxTtvRuHZPoc6YEcHDA2S6Yw1jlMs/GN5T+SQXmbXWb6+igb8CjhXMr4eu
         IhClXnHWHyYbNFSwc3nxWQe+jKq6NcGCmtzg6HLphZIiUQjkIAcuKOqqs91AXtEvuSyZ
         r8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783492781; x=1784097581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vUl5ihFLZ0ZNzBKHgZhdM4ygyPUK+vq4TwX6IU2C3RI=;
        b=TnmCRNLqjUgScHabnjoJqV/Y4HDNV3C6SDXHVG//E9MqU+ms1oEO6VUUgPENg1c1Qi
         +6CKYauxMOB5T5VKSZ8J6XbfPZx+vR5kq9ENnY5VrZYDWOKzd8oeokqFz7nLIvXd78NT
         JVF5ZecWb2AB3A8czq7oFEyuwFvrp2BfXAkqNKfras42XKUUmLxPz6lZOQE1C1MTGjDb
         VxEszcdZzOj9EFBxNAH6fNL2LHWvgpKxf1udrPJHg/Mpj8rOFKwab+W3PW+aifyZT009
         x1FmEWwXAYC8g+ehTb8Jfp2SlrlfUK5UpBS1WPpbopE+AM0y3pjU5WMD3dWCtL0QvjEX
         7IeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9q+1nSZDbhvEGKywimWBpRNDh/fPGb0GCKGs9gR0XBX4YVmbm5xVz2vS9zpOaWQHW/GBwicJwIMZQwqhcFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGlXSFjvkAMsWPeH/EFvoXkScW1QvQsnFKRp6epoxeM/b5vjC
	GHBzwhLeZVNSWGb0vZCtOVRLdwTQgafPqalyI7JV27FPix632rJAVSOI
X-Gm-Gg: AfdE7cnRN6oxgqp0wvDGrmoKEP+xbYWKqAk0XKlr9D+d3OTa1B8xzhHDh5zdZDsLAQP
	rnFI0G1WILmaB2h5MZAKQQFYKDra86IiW7nO6ebN7tdRPwZiFCCsPandU3Hc7JZIw0z1pykgj9M
	/6EPWYiUTIZCFZ2HE49qtA+l7aCHA2zQRiUE2D9SpSbUEdxZGELiKJMzfJoD/DBWIBZL7fALyxQ
	et0QPtyRS/iIt8nqfAsQFIRPFcOYe517HSliJCRSt8ghdHoi0eQBrod395OfRkAM3zAMOxKrsYm
	nFQfY7Xx+gdQK0ho+GbkenNSDv0wdRzHrtJOagRS/Wi1v5tHggd6vpXYVZJPMlIEO61C5Z4f8N7
	ihZoguz5yRFlHE8V2kavpJvLpJrv2IJWpaIylypyhyNU+OpRu0z7SpkYWvIFPpKGb/8jATeE5ET
	mesb4wdl43/YhnuUgISwaQ
X-Received: by 2002:a05:6a20:d499:b0:3c0:9c18:d5a6 with SMTP id adf61e73a8af0-3c0bd1b22ffmr1499684637.67.1783492781304;
        Tue, 07 Jul 2026 23:39:41 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3b25204sm1929874a12.28.2026.07.07.23.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:39:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Piotr Haber <phaber@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: guard P2P device vif in action frame search
Date: Wed,  8 Jul 2026 14:39:29 +0800
Message-ID: <20260708063929.718152-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38779-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:johannes.berg@intel.com,m:peddolla.reddy@oss.qualcomm.com,m:bhelgaas@google.com,m:gokulkumar.sivakumar@infineon.com,m:lgs201920130244@gmail.com,m:pieterpg@broadcom.com,m:meuleman@broadcom.com,m:linville@tuxdriver.com,m:phaber@broadcom.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[broadcom.com,intel.com,oss.qualcomm.com,google.com,infineon.com,gmail.com,tuxdriver.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57FD07223F1

brcmf_p2p_send_action_frame() checks the P2P device vif saved probe
request IE when deciding whether to perform a peer channel search. The
P2P device vif is not guaranteed to exist, for example in standalone AP
mode where no P2P device interface has been created.

If a search-channel action frame is sent on a social channel in that
mode, the validation condition can dereference the NULL P2P device vif
before the frame is transmitted through the caller's vif.

Guard the P2P device vif before checking its saved probe request IE.

Fixes: 6eda4e2c5425 ("brcmfmac: Add tx p2p off-channel support.")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 92c16a317328..bbdebf4c2010 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1819,6 +1819,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_if *ifp,
 	/* validate channel and p2p ies */
 	if (config_af_params.search_channel &&
 	    IS_P2P_SOCIAL_CHANNEL(le32_to_cpu(af_params->channel)) &&
+	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
 	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {
 		afx_hdl = &p2p->afx_hdl;
 		afx_hdl->peer_listen_chan = le32_to_cpu(af_params->channel);
-- 
2.43.0


