Return-Path: <linux-wireless+bounces-35173-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHsaNRuD52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35173-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776543BAFE
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE0D6306E8FC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24423D9DD4;
	Tue, 21 Apr 2026 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkdU0DqI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ABE3D7D7C
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779433; cv=none; b=M5DJCS7YgXJfT2ppmruCNMnOvFoUBrfpYcZ+mLiJk43JDeRUbR4xZjfeaj7IpMn2YqVdgPWMX5dqJAeyCNB3CdXsBFb01tznYeaGC6qv3OMXL61UzbZF56xA4w2TYt4zJY9smawjmVdTBXnkweH8+YwnWI7Kd1BKl5B2Oy/RX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779433; c=relaxed/simple;
	bh=szTqRpDbKzFwfUbR+Q2atdkjCKUQ9MELy0g3x8U84Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4xnf7dNNM1LPmZtW1hSyqgbQH25+lv0iPgx6PszeUbY1YRS7uf3WysFO3jTqJo+gNShyrqAgaTUbLWpPFjXROe229JOxcHC75O5qh2zUexKxkpEyvu3MPlGgL8pgzrqNZbvEDc1TyWLbRsWmheFE82RLhEMcu2/DEE3CawyYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkdU0DqI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso28024875e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779430; x=1777384230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv1rwiKV3qGmtlMGDgyUhwSVXxUoM3CcLuFwGkgkci4=;
        b=CkdU0DqIntoCEheNJUO6jsLrTNCJUi3RtnylNEGEGqjzRyDEy2dUCXj0LgAVjcLzK7
         NWyv/wp1eh+rjfCIRhcj61E5n0ohSS+7U4lXWDnaO0zgaadsJGoSXAMyHGuoAdu99pLR
         mw1iAtjbAF0OKy8Lk0JfZRPjgonKu69MOYwtU8iO1rJX3ASRO7qBmdpFzPB3V0Mf1Jat
         4ngmoXtxW/aZuijUrkIjtyfJHCjWZqJ9eyNAL0IrDXRmi0SFh/pwPupSEb9jgnXBftTt
         WdBmi1e++2i3jB43aZT2REwJID4AL+AZA541zHX1PiUaNFHf0ncNzY5AxRtFgpvpDA7o
         uh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779430; x=1777384230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cv1rwiKV3qGmtlMGDgyUhwSVXxUoM3CcLuFwGkgkci4=;
        b=aQYHJCzyAYFfih9pTOFWvBV2qO0aukmOB8ND9aQTPAVHfHaJJh2DxyozWXJyA5L2qA
         yKHKMTw+uQdwjUKFggtISYHRR+R08+/mHLOumINqoGPHobt5Z59o2PkCMLw0PNg71AGk
         wGtodNU2D3CxdvOm+sFbnANdlfIMDD+Tzs/JJr1RfxjaEobOjb91DHW3g7UA0ulD5yOL
         ozLYsmqDnIZPjEwGdAcFkko30J6oxX5nb37OZ0WinwQjtp155O4vTKBl6nbIO3YoUkVu
         VRNW46c4TCDcm2y1cHN+To7PsvfbPtP015PD0PIvycflDEG//gvvRD/x0oqpU5LG7b8q
         m48w==
X-Forwarded-Encrypted: i=1; AFNElJ8MSaeUznoTDf4CiWwk5OKvf+aObmELLLYg+cQk6X6SOxkIphkZd/LNNu9GFQ22RX7HHLCEAatTOVxlCszGjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBNI9bd9wxcCC2xXvxDWkte2oRFQPf1OBjQP70aLFYXKGnXeY
	VWzqC077freeRVI5qO9LYX0Haq9eClWhugdrx6J2sY0j8bP//w7pVN4=
X-Gm-Gg: AeBDiesZVneb8Dh4Oug6gp0mW9Up0oNTaiwEsskQEcuJ+ieVya+aG8SvHAAygQAeyTz
	iaF0hltl8P/NWlsVjEsqU0a0UlbeBvyWE77ifmwJew20+rlN4UibZnjsWj9OLJNbMgPPId/p8ZR
	+qCcrRNF73i1VhxwVC7HzFmWOu2UB5ndXijHpFkCnVGbblfRLtW9RiOgOokvFT0aoQZKtPVBcHE
	WQqvj6br9d/lvabwf5ot+qGuhQ3l5DlZeNMSTx4/8EyI1NCY/TSksKwqtdkjkyA8cTB3+DD1DVL
	V/SPsGV0/BTQh5SIXjW/3yO3GwQEFlP0andmLHkksP/fsu6hmHd55bqJD9CTlZmEys+sX4aJZW/
	iys3KyRy25O4/XlmL2oke6oV64QxcQ4iDZXD639D/P3W6rjKphOfubWu4z13MeMQgITCZz6BH/L
	vNQUw=
X-Received: by 2002:a05:600c:3515:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488fb78e7c5mr249072725e9.28.1776779429782;
        Tue, 21 Apr 2026 06:50:29 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm394031315e9.5.2026.04.21.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:29 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/2] wifi: libertas: fix OOB read from firmware pkt_ptr offset in RX path
Date: Tue, 21 Apr 2026 13:50:26 +0000
Message-ID: <20260421135027.357622-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421135027.357622-1-tristmd@gmail.com>
References: <20260421135027.357622-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35173-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 9776543BAFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

lbs_process_rxed_packet() uses the firmware-supplied pkt_ptr as an
offset into the skb data without validating that it falls within the
skb buffer bounds. A malicious pkt_ptr value causes out-of-bounds
memory access when the function subsequently reads ethernet header
fields from p_rx_pkt.

Add a bounds check to ensure pkt_ptr plus the minimum packet header
size does not exceed skb->len.

Fixes: e45d8e534b67 ("libertas: add support for Marvell SD8688 chip")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/marvell/libertas/rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/rx.c b/drivers/net/wireless/marvell/libertas/rx.c
index c34d30f7cbe03..3497595a67595 100644
--- a/drivers/net/wireless/marvell/libertas/rx.c
+++ b/drivers/net/wireless/marvell/libertas/rx.c
@@ -73,6 +73,15 @@ int lbs_process_rxed_packet(struct lbs_private *priv, struct sk_buff *skb)
 	}
 
 	p_rx_pd = (struct rxpd *) skb->data;
+
+	if (le32_to_cpu(p_rx_pd->pkt_ptr) + sizeof(struct rxpackethdr) >
+	    skb->len) {
+		lbs_deb_rx("rx err: pkt_ptr %u beyond skb len %u\n",
+			   le32_to_cpu(p_rx_pd->pkt_ptr), skb->len);
+		ret = -EINVAL;
+		dev_kfree_skb(skb);
+		goto done;
+	}
 	p_rx_pkt = (struct rxpackethdr *) ((u8 *)p_rx_pd +
 		le32_to_cpu(p_rx_pd->pkt_ptr));
 
-- 
2.47.3


