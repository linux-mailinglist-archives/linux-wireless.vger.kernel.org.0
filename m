Return-Path: <linux-wireless+bounces-34823-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNnBG+sP4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34823-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 218AA408901
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF23C301179A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86764391E57;
	Wed, 15 Apr 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGynCTxx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA13939BF
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291796; cv=none; b=EvMGJSv6caoKafR3QHldBuVUQZv6gL9Y+r4reoZnViNwkOGUb7915S0/So9Pe7faYgx3DiV1h9hSanGlR2QYUvoj3V9Aa4Z2zwMfelUJSiRhUvg9T9v7OEKsmO02pjupFQYyAxTLS/+MwcLOpS4ipQ8aY0OKLwb8BIfG6gxlhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291796; c=relaxed/simple;
	bh=b42wQuu5Bk67LUY7zRvQ0yi+2bQYfp5nEC1JxC5I5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5eeVS4zYsvsy15U3JAUrYD3efA5Jr0Kvuzb93PXVQLTp8PRYHZiMkQ6YzWrEI4ZGfBw4QI2iAI0OCwU49rAiOpQSpmVy5zg7a406ZTDlVhzO7tshOC36QOTdxmUnWOfFpFVVVfDdsxrz9w8dSWDW6v1mePmefrOr271VkOCqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGynCTxx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d74086e5bso2976146f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291793; x=1776896593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXIwdJgZS73raaBhobnFhQkQVjvIkBK9xYUC/yG7a/M=;
        b=FGynCTxxtS9WmjwjkPdJOhEXdcdhyWze+eBZQNBX7TlFUDxhDNSU1J+APYXnm7YNX2
         T4CgjWbkwv3gvq8qD0c+6VUsRNVWgKBeNQ44R7cRZ9CQRccH0efPoQE5C26GBckvRgy+
         JVBjmhySvshJ+IJOmxurqDLwRLIxGL0h5vadmDU+dO3ZjtE3uJQWOuLzy1Ap5FJ4PjU+
         VbzSXG8XQCqhvPb4A+w6X9AD19+FKHD44JncRCZ8H1VymMRNUqSJ2K7srqv6ME8Db+fA
         HBI8zODsOPUwxu+qhy82ZHZzIF6rwb+0ZfSOXU0y9zW2yVrVjtf/dQf8m1ZvtbeeMoVs
         HHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291793; x=1776896593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXIwdJgZS73raaBhobnFhQkQVjvIkBK9xYUC/yG7a/M=;
        b=f426J9weHjP0XJvqhybvRgRp0THH7xinnhqsMEdlYqVzwAnBlPQcWsWZF2Xl9Qg7jx
         DZQ60kR3Z1QjjKg5NWTY3a5MkOB8jixHLzrQ/wAYraJSEYeLGIEpR33mrQzohxdiDg21
         72KpiW/A5DVEsIAKRPgolimSj4f7hDegm4oJWYq31znGsHcjQSNFSoM2FTKnpG4Y2R/Q
         bmZbEkEmLqLXfRPMR9pftys1J5S0iqJW+Nrsz8ZMrE9gpruRRpfS3+j9AZK8xGt7Blbw
         vggUjudOLPPW4YXxruePsSNhy48nJZY8XPrnPOoqGhavjsNN0PHX4G5LEO/U3OWzlcdg
         pewA==
X-Gm-Message-State: AOJu0YxSs+Z6Xsk9QJTOVQLaPoPEmZSm7gLg9QgEcMMCcNQ8akcIw8aF
	zpiVCPzDtFGR2E3x+NENQy5Fb05yun3ihPbUWiiY3IseUQPikMeSmmQ=
X-Gm-Gg: AeBDieswei17Vc7QSw9hC8LRMBda9cnjdjE5Z73EwxhC6eYZzzU8Gxp6EVvvdUrxn4h
	eoQIWdJC+IiNDlpVImR9HmaGKZ873lxRsVdeNVEA997TTCzPPF9+XCtA1aKn3VCYQ41eSZvaW5T
	ROXrPJXWCOR3mjQceAtLWjn156sCawBNtndDLicsVLGoJsN5TOHlV/ZMnvgz56lfxcLvMeaxbbA
	YMB2sIBhkXc9ZVSk3KtZ1LiV7FfBFQb6X6jB2uVP6XRPK/lF0ZyLkHD5qnEOKqT9lx+q9UxzJ5U
	gdggrGXFPmk07FvIL7gnYGuHCCFb/zlugbNx0+xtxYzyslVXl0z0j+PImA4fYDplx4SKDCm0F2D
	OJb1D8nYEzwlYyqQeZx8O/ipOidDnEyC993/0huPSqdG+jynegNwi4EaE0H1pUyuyJBx7sBb2HF
	OBUfQ=
X-Received: by 2002:a5d:5d0b:0:b0:43b:5231:e94a with SMTP id ffacd0b85a97d-43d642da716mr35750102f8f.30.1776291793160;
        Wed, 15 Apr 2026 15:23:13 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm8662959f8f.20.2026.04.15.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] wifi: rsi: fix OOB read from firmware pad_bytes in management RX path
Date: Wed, 15 Apr 2026 22:23:06 +0000
Message-ID: <20260415222307.1537309-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222307.1537309-1-tristmd@gmail.com>
References: <20260415222307.1537309-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34823-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 218AA408901
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled pad_bytes value (u8, from descriptor byte 4) is
used to shift the skb_put_data() source pointer forward in
rsi_mgmt_pkt_to_core(). While the existing msg_len -= pad_bytes check
catches the case where pad_bytes >= msg_len, it does not prevent a large
pad_bytes from shifting the read window into heap memory beyond the
actual packet data. The resulting kernel heap contents are delivered to
mac80211 as a management frame.

Add validation that pad_bytes does not exceed half of msg_len. Alignment
padding in 802.11 management frames is typically 0-3 bytes, so any
value exceeding msg_len / 2 indicates a corrupted descriptor.

Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/rsi/rsi_91x_mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -490,6 +490,12 @@ static int rsi_mgmt_pkt_to_core(struct rsi_common *common,
 	u8 pad_bytes = msg[4];
 	struct sk_buff *skb;

+	if (pad_bytes > msg_len / 2) {
+		rsi_dbg(MGMT_RX_ZONE,
+			"%s: pad_bytes %u too large for msg_len %d\n",
+			__func__, pad_bytes, msg_len);
+		return -EINVAL;
+	}
 	if (!adapter->sc_nvifs)
 		return -ENOLINK;


