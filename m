Return-Path: <linux-wireless+bounces-34858-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BJEH4YS4GllcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34858-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:34:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF29408B75
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5318F31E8501
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8F39656B;
	Wed, 15 Apr 2026 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv8tRT0T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C46391E5B
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291891; cv=none; b=lKIE35H8GHeWHUVnWfhmBIXzbftBsLSq+r3p9gTJDman7EHrMqNyvaTQ3B7bM7f4+L4M5jfhf9kBaNA+R42rO5DSQgT255JMZNcOyWotubr/6At/icE3JkcsQfhN+jBIT+8u+6mHhOjF+K6vCrUHd2Za9BQok7+mHOhUSeCyQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291891; c=relaxed/simple;
	bh=5o3FgRob9W9wc/xS8namn/WYH7tja0v2Z6kG08B8bMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBVUGwB/xoPEvPJaPQxaEif1Bgqxjk1bXpJHwi9KauF3/LAu0s9L2CfCwn5zKiSA+yNsq0+tIfrlUB4pyjoRVSRmu4OJ4DPHErzu9EXmVAyPsfgz16A/7HJxfgLC1A36b2dfiGzGd8zh3exzBSXYK8Q5n4vawtjo2QZ3qD++BnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv8tRT0T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso119936945e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291888; x=1776896688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGBHPqeAEUuZHUt2OJEa11zrHAsGxFriqr6V1G2fHCA=;
        b=Cv8tRT0T605xSxNBjiMJ2xM8KAWCgV4f3wjYY51lvkuufRYImz9OjdA1FIlw3dXDV3
         5+E3uq5ic8TQMFzxwYvaYZVa/HoSbbyk2xPruMoitpJXZpGNtqKa/+UyTkQah6oIG1J7
         FNZI0MYmBUbuj7E6bmqubPB8NctbIqGVIGlYcFrtDghztLn0pNl96ppF9li1u6HqLKp4
         Vf71dMqu/a+a0my+uBvKXZEve5C4+9HkSApndbZ5CfJm74RcTzXIvGBR9sz+QD8lXft6
         wGF3wQeGfV5tAJZ2Na3WjKqjieqqwUgRbfCNFMbCW2vAjEc2Vl8ctzp4tdBNQBcue58L
         lJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291888; x=1776896688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IGBHPqeAEUuZHUt2OJEa11zrHAsGxFriqr6V1G2fHCA=;
        b=U9Yq8DJy0K3PHyym3yiNLyCPC2+XW2xwj3RZSd8WBcF9eNxPYvdE9+5T50UdcPXQNt
         rXRvfq/5v8LYE7CWAjbYzjpqM1bfXre208XfIH6crZA24HUFJTwobnVQxAL7KxQ6kiYX
         p+9V8yzavQbqTE0wG8Vlt3Q0wmb7EBGjE2p1Ip0KrMi3cGIa83AtDF+GSM+Q64JTMB8t
         aifFTBrMGtVGfSc07LxGWYd6u0J8NJEWdP/GhfrlyPammjt0nsMpoFo4V1Sg6C1fO3UN
         mVIeOH76o59wwNpxVBaMA3uIMbM57MAjLCNeKbFueoFn1GLc5Wjj0RorB/wure5MXg4x
         wf3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+7xLbx5m/6K9/GCVSLflTyTa6bpNTZdUhTH9NkNOdDKZYU0Ag/NznIoKYlxnPvMznMI2Fn7T/oh9FFM18YqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxmWhocxr0DbtwKhyMnAHlou7KNGCmLTJZcEfPI93g3J7A5EQ
	0wBhkK9ymJs8VVSRIEAyQFHsq3B73mjtXHIXbY8Bak+Sw+YjPV3RyAw=
X-Gm-Gg: AeBDiesW376fBOa0rc2BSlVaYk6oLgBkXibF2OLKym7y+OCdBHX1AMLCxH5KNc1Haro
	hJCsSQYwl2XVRZ7Oklzo6KOPPJZBwsZpVfiqwAK3v8LJuZMnujVHzeNxh4HR9YtKqWntmkDfgaB
	VtWw3Df2forclaHu2LrmTuerWRDv+DfZvvlCKh1hNDnEbBixH3dIEyQcBDxVxt0jBSFGqlahyTY
	qWRRLzafCgumw3MwiP+KJdm+K9zNPdnLiCkE7bU01eFDG6g9t6iqfiE+81wqnU6ETo3/R/q8LnE
	7eaK060KJQoDkLgMTPTGzLxyNw1YPH+v03pU9E2XZT8Feek29+9nvdkNZyyuKCDmDwyn/DwG+Kd
	3mMCVDeaaZRsNLxKCTzGzvS5Cr/jMt2jnF4PpF4YDv0O3TP0bq5xmcwtmjjE7jYg5da8Y113JvB
	n1tA4=
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr225003905e9.19.1776291888294;
        Wed, 15 Apr 2026 15:24:48 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818e51sm3144295e9.5.2026.04.15.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:47 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: libertas: fix OOB read from firmware pkt_ptr offset in RX path
Date: Wed, 15 Apr 2026 22:24:45 +0000
Message-ID: <20260415222446.1546616-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222446.1546616-1-tristmd@gmail.com>
References: <20260415222446.1546616-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34858-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDF29408B75
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
drivers/net/wireless/marvell/libertas/rx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/rx.c b/drivers/net/wireless/marvell/libertas/rx.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/marvell/libertas/rx.c
+++ b/drivers/net/wireless/marvell/libertas/rx.c
@@ -75,6 +75,14 @@ int lbs_process_rxed_packet(struct lbs_private *priv, struct sk_buff *skb)
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
2.43.0


