Return-Path: <linux-wireless+bounces-34850-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDqIAcEQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34850-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:27:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B814089EA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7755E309E52C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583B3932DB;
	Wed, 15 Apr 2026 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb7srIw1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BF392C48
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291863; cv=none; b=tzLkykMQGvhc9nGVtTR9HzSr6kk0wVgDFArsCkCb8fhwvN7Ho65HtZRszi+S4lHo0IXCbuXBJc+TxbASOn47OcbV6uNSM/xBfwFVtOG3++erW12z3s/hJN57LJoR23Wue/tbEAafJ3NEp82+v7U65c+3jl1uYfuibYWMlCeuMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291863; c=relaxed/simple;
	bh=0wivxeATJ1R7QASx0gG1n6FGs9DcS3KagsubRpWxHcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgD++eH4XC24bArYmXW3nf1FGmfpWyaf8DDhXpVbgur+etfR7dSfInawJ4Z0JDM9WGj6XDY21rVPnKC5u5fLWzUHZqGrIJzNP8qnEUflAJG/mOjNCpJX7sUyIE5SBk9a7tbYXKk8I2fNds6vckeRmMiVwOPR99BywMWCa6GuEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb7srIw1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so52449115e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291860; x=1776896660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsGJqE9S1K8MiDiNVwiamVo+WSU0FMEOfRpkR7k/vC8=;
        b=eb7srIw1iieJxYg8MIqkjkoiY5z1ZCg38Wy6mWSx82DHOMjrtxVmRIKpGVSDIAGDu7
         muVlq1ilGhJxjcyaa89s4In6uyrTq+3NGvX6cA223OjdV1y11jOQHHDdiRQksYnJi/La
         iPqZNMNtVQxFVgMgxpdfFnF1P7LGFWJyLmSRZQF1uTqlsE45yyQMZWXXK5HtC+7M+7FB
         PMCuMqgejxHyC540rVvpcdlOOzKAAtdBUa8KU/U7tOzOHaSOKZL+Wb2j9UvK/unK7TXU
         ORZjjW7HaIYeyqhf0vOH8y9UmWhiWIddj24jfobbsNdII26Ioncg8OqFMUIQ3d4Sdt0y
         kjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291860; x=1776896660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KsGJqE9S1K8MiDiNVwiamVo+WSU0FMEOfRpkR7k/vC8=;
        b=Fd0Opjo65cHY4WUJe1uE12z8qqsd9zLvg/UBag6G7i2xQg9ztXdU56HgzQStfKU4H2
         hah4igZS4WlbuiA9S22jQPT19OGyjCpXznjBNwElyca8i4htKZ9NDTf/uSL1o0Aa11TG
         9OBXwVh3qmsHriNwQInkeaapTaPY1gDO9GBnJvWP2aAtOZGgGGrrpY7H0EXa6/cfOXyz
         XZSoatzZSueRHoDV4DWGFrFvO3VEY4lBuXboXTVg3qh1o4MV1Jv57T+kD78KCSysiDMT
         5OoOU/eES34fU5KXXUBDuHYw5pxjtVSZolrSJwa0kj5zvai4KBbNDRa49xcMkYt0Zy2q
         Z/cQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mFNZUpGHyghify8fg+OSX5HWjmxc+8M1SXye0UGhEaL9vsmRCknCBTdmQ6m5pgdwEWvaySmQhISZwdSGm5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkTm/pHEbCikcSWIL1y0x/hu6MP1nZiXxoPFyaEya78/9aKZv
	OnWjTuIy5qVTuumDoRdshyRV55lYHR7aeCCJsA1tOX/Xpzkm6JxQjN0=
X-Gm-Gg: AeBDieuFuJ0Qxph7USPsqfDUBgQHXTnY3lm51TQdcKuXZo38oMeEUoA0QCa3NW+nNdy
	CNIlQl3yi9aQIA8ZCQbKhXOqJe7XzcNXTnHYMOvU1EEiFO7hjwff5TSP35xqfpc6tULvvlgnMHa
	CjjMYeZZ4GlDbhEVBHzx3LM9drNDXiwywxMgQcTFgnoCC3xtjnb7ls8C2nfgwRZ5iytvcdn1ZQz
	12EvSFyI7uInlr/WDmnONbY+djlQRyKXB0Kgijf6fqhcbTE8Do/b8FDWBdAc5PxV3HsHLKkGmCT
	j6J68IjIXsopAs8H/oVJYqQ0iH7rrMitNR+KuEA2KeSborNS8DprYO9gIaOGRTmYG63GzdlHC4S
	2ql4gMtk8cOUrrcIjKQ39DaxkXXfOxolU7K1BsPXX5q4/6rOkIXqpNPlDfetRE3F3HTkodcR+Wm
	SW+MA=
X-Received: by 2002:a05:600c:45c6:b0:488:a797:f0ac with SMTP id 5b1f17b1804b1-488d6ac2226mr283863695e9.28.1776291859876;
        Wed, 15 Apr 2026 15:24:19 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813954sm1890655e9.3.2026.04.15.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:19 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: wilc1000: fix integer underflow in wilc_network_info_received()
Date: Wed, 15 Apr 2026 22:24:16 +0000
Message-ID: <20260415222418.1543832-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222418.1543832-1-tristmd@gmail.com>
References: <20260415222418.1543832-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34850-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: B0B814089EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled frame length at buffer[6..7] is decremented by 1
and used as the kmemdup size without validating the value. When the
firmware sends 0, the u16 subtraction wraps to 65535, causing a 64KB
out-of-bounds read from the RX buffer. For non-zero but inflated values,
the read exceeds the actual packet data.

Add validation that the frame length is at least 1 and fits within the
available buffer.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/microchip/wilc1000/hif.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1572,6 +1572,7 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	struct wilc_vif *vif;
 	int srcu_idx;
 	int result;
+	u16 frame_len;
 	int id;

 	id = get_unaligned_le32(&buffer[length - 4]);
@@ -1595,7 +1596,14 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	if (IS_ERR(msg))
 		goto out;

-	msg->body.net_info.frame_len = get_unaligned_le16(&buffer[6]) - 1;
+	frame_len = get_unaligned_le16(&buffer[6]);
+	if (frame_len == 0 || frame_len > length - 9) {
+		netdev_err(vif->ndev,
+			   "%s: invalid frame_len %u (buffer %u)\n",
+			   __func__, frame_len, length);
+		kfree(msg);
+		goto out;
+	}
+	msg->body.net_info.frame_len = frame_len - 1;
 	msg->body.net_info.rssi = buffer[8];
 	msg->body.net_info.mgmt = kmemdup(&buffer[9],
 					  msg->body.net_info.frame_len,


