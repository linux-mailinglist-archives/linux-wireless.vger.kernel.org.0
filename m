Return-Path: <linux-wireless+bounces-31364-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM3VFACsfGlsOQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31364-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:02:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0E5BAD86
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9F0230428A8
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A6837F11E;
	Fri, 30 Jan 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUDwfrtM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99D37F0FF
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777963; cv=none; b=JPUTcoFn9s8IjzL2DSscNKeUIB95kDyry//pX+FKWqLIvBSFDZXJdmRh7Z709pPoylSdoHdXdFfyHslx3Nf4OTGpgMKaemSRDT+hOFI5QfFjBOWBpyUenyi3S70S4tEZeoMS9+LutgHRNbJDIXToMNyyxqmIhTPBMTrT+TxpVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777963; c=relaxed/simple;
	bh=dg9kYr8aZfQN0Z5Niq94kmT7y8LXjeCMZKoKN1fucL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kt3J547o475D6V4zB7r2jnm9vUTZ9xGrfc1iuR25dfqQSTxqtj55selaLqkAo7M+9+pb415qEb1kmaj25wtc1Qd251S7WTKi5Aish4sj4rZy9jwo9/XiWlbi5chKnqHVrVQpKkv7MgYfhYi5vAq5llp2xGs3vYBe6CcAheoaByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUDwfrtM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so17303075e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 04:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769777960; x=1770382760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=TUDwfrtMBRTOay6PjScNvnb/YvIhPKnrWTzlLshk33D4cWqqb5SLCG52f8zVAp20uv
         f5j8HjAzxGwkD5/B01OKkAsq3mV+3OVOA6ItUUILgxa/HE2zd/uPFd2NTMHiL6IbnfER
         5ou8z1ASnJnLsY8ycmksZISmadxU+Y39FF8RSgpPYARgJGbg65eGIyL2mrPYcn31Ucas
         mCB6zp5rSJr0xNauFu3adYMV2mqIUgg+OXmmyUOe+/5G35PprQRznL4g5VkxMH/9EApL
         vSbIu/mO/TKuI1OTa/BwHMdJ+G0CcjoUcqcZ38X7GptBBd1yWC6gEVH16Q8NDBLsJV8Z
         Y9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777960; x=1770382760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=kKKh9KiJLswzZreg1pwN1h4n3G/E2hH/GfPLMGXFFboHSxVMeN5SfB6so+tl4X6y2g
         k8xlggs20IhAb/CMFVZ0YALv3VcfGSMcMx33w56Z4DBaDYYFveCPPkZNSQo5+a6N5W3z
         e9Uy3pxARG1f9NBheBIBjSbFNH8DF2ingwKcwl2/xE2uVeoF6lQt1jvgMwyGYZbWmz7Q
         Vo9cUpZ5NdwSyBWs6Zfcd3KjRnixLHEPlCiPllwzW6FcxUKu1JmQ9H7jY9nZ8n/nEWBz
         jwgM0fXdYMXHdI0UEQEzea/LBBmVIR7Li7MviHuGyIpC0K4eJh4u3INu9LZLP9AeM3b5
         Gj8Q==
X-Gm-Message-State: AOJu0YwDXyrNRG4DzjAI4zT8gmAULeeDPd5Lx4I26r34uuAx+iNqYfpP
	hapEJtVoRmKzXTohawUIXOOUT6Typxq9qgGWCW/SP8udNlO9q7gEkAw7
X-Gm-Gg: AZuq6aKOhtKB/RL4j7JBcuhEn+QcCnewZbwiWXpktXP3+xFocy9zTYuK+7B9xMEEn6T
	ZZ0EwEsTZWH4C78OnkdJv0RA/Dw0p/0xKT64hUu8W+FafumSwJWRP/jdU3g5SODvaMQvwYu2joj
	YsgdLn5gmkKQGgm/fCqwHn/95UYvG4zvzuLO2NMrKPKfcSyYLiH50hwnfW6l1L/7QxAIvQ/QfEC
	DjoMONOo+sK9JecGIOr5MUizHzcycpC/pF7LuRpqnJf3yMG1BKgl19aTJsiVofCPmHijitWsJnc
	IGNRtoCFXpDIlQ+XMAEgL+4o8JvPbnXA7ziSr4x46mWdmYbQP3n2nmGIrsPqjNtdq5hFnOFzXFW
	28uFFbulLSb78UnVuU3gspcVUCJdKop1QY5KoqjldOfL8LLOXmFw/XQ21sfJ18h9m6vELZt91kK
	dN2Qj+MXACBqCllWket4nnwTysFlXN7Xg6Z0UcMZK5wOweGxiZCJ/FiecZ8866jRvj2Nub
X-Received: by 2002:a05:600c:190d:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-482db452371mr35162815e9.5.1769777959687;
        Fri, 30 Jan 2026 04:59:19 -0800 (PST)
Received: from anesterenko.. (62.43.64.127.dyn.user.ono.com. [62.43.64.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm237357355e9.10.2026.01.30.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 04:59:19 -0800 (PST)
From: Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
To: jeff.johnson@oss.qualcomm.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
Subject: [PATCH] wifi: ath9k: add range check for epid in htc_issue_send()
Date: Fri, 30 Jan 2026 13:59:15 +0100
Message-Id: <20260130125915.47036-1-alexandernesterenko837@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-31364-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandernesterenko837@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E0E5BAD86
X-Rspamd-Action: no action

The fix for CVE-2024-53156 (commit 8619593634cb ("wifi: ath9k: add
range check for conn_rsp_epid in htc_connect_service()")) added a
bounds check for conn_rsp_epid in htc_connect_service() to prevent
out-of-bounds array access. However, htc_issue_send() accesses
target->endpoint[epid] directly without validating the epid parameter.

While htc_connect_service() now validates the endpoint ID before storing
it, htc_issue_send() can still receive invalid epid values from callers
such as htc_send() and htc_send_epid(). This provides defense-in-depth
against out-of-bounds access.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 00dc97ac53b9..7821a31c0abb 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -23,9 +23,16 @@ static int htc_issue_send(struct htc_target *target, struct sk_buff* skb,
 
 {
 	struct htc_frame_hdr *hdr;
-	struct htc_endpoint *endpoint = &target->endpoint[epid];
+	struct htc_endpoint *endpoint;
 	int status;
 
+	if (epid >= ENDPOINT_MAX) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	endpoint = &target->endpoint[epid];
+
 	hdr = skb_push(skb, sizeof(struct htc_frame_hdr));
 	hdr->endpoint_id = epid;
 	hdr->flags = flags;
-- 
2.34.1


