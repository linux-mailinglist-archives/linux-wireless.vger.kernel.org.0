Return-Path: <linux-wireless+bounces-31362-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GKCDgurfGkaOQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31362-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 13:58:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42111BACFD
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 13:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04BC53005321
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970637D135;
	Fri, 30 Jan 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYUJOe/p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6D37E2FE
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777614; cv=none; b=qQUPP20yIzPjZTD6DeJJBfr2GI6n6J0vN5LuEwaD7xonzN91CBGqw9TaoKYB3mlaJ+mjri7kmutLzv0ry016vAbEalfti5sMKoKiZsXBR8Uy9qLttZKgJlVJ6mfH40wSdx+P6FJEvR9GV79pXg9Gb+Seh+vWr/1FtIoNPzzljBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777614; c=relaxed/simple;
	bh=dg9kYr8aZfQN0Z5Niq94kmT7y8LXjeCMZKoKN1fucL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gzU1HfZwwbgtMnXVfe7ozkLvKIDwwhbggrgGhNNYkkoL1Z2z6OKbfLmE72ZWOCWx5Y4Zjwhzqch85m6kQyf2EFwN3+6NvzduAYUjKUNPk3LlrreTX9LtOHAlQU2rXcRff7t7YkwPZ+QcjCcb1pIp/LpccptyFWgx3apBQwE7zwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYUJOe/p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so22713255e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769777612; x=1770382412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=cYUJOe/puO5FiZ+6g7TGB6pDF25G31nSEqTwbmJK/HrQfCGnEi/ZMC/Up2hnPGy7ZJ
         u6Rzxm6wAxy+Zl29ClbyMNl0xZU6fvKazMSs4xJmQEtwS5iPyBEjUaE/l6eAxZTZCtvx
         La1QcZR2ZNJI8ZTesQXSRv6BfzH2HYb1Op/zxIXa2sjhTRXyoafKfvsWHHmSz71ASvWO
         Dgk4c/llexms3jwznIrmmxqeB8myHz0Ty9e/jOPlYAexv9vBYsrqlqxfhUTzPF/4VURO
         Mf8v9UZ7MviIwye7BhqbECqVSzNqf8OIH0KbxLb4ILplW+WmMrZM8supsYBqBvagtP0W
         lItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777612; x=1770382412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=kt2FYyhLM5dI9hUqHZK172MISZZcAgyJwJly4fCaKe6sQpuv3tq4rc7q7JC/snOVR0
         WiP94sdJkA4C65K4W+WmmFT1kLRrbuLh2GeYGojCI3eJWP/vvYMcrOvmUHI4+VqDsr8b
         ztLyd197yKd9xKikknd1VwkrDZuoknAaooshelY5t26jQY3PZsZ6L4Wu1LyHp18B/Sb2
         ZwCUCcsVixQkkSw63C01sk3E0aXNdFjK0oSxLsLeAAVhBXG+b/chTKyKNusHvqhmzUiJ
         eM+DbjDLULog+wW0Ya1HL+7/PmaQMcDPyAGzQfmCe7GAHt1VSJHJd2TPfswKUes2UgXE
         7r3Q==
X-Gm-Message-State: AOJu0YyxgdVe5oezJeEEd8MItbErlUYJZBccbTs6NXqbPcPGjvYQfZKd
	c6QnPfsWhChAusQgDOI0Q9UoNo6t2SM6VvAViJ7uzqAzjMtxMqYHRPfb
X-Gm-Gg: AZuq6aL+1BH4RJET5PXp0Dz8184+b1gvEZhovxJnYDSofoInTi3phGez9JBD6nL/EKn
	Z+l0Y68LQIQmH7+SEZsTl7cH5MJE1OYrab+Rc/EWwfzt0IIvSkyZKI9d7y9b8hiOTjUgnJ1gCBH
	pLecVj+9LZ7dbRZWRCa5wsj4skOb+yTfk2/lJgdlAToFwTJfKAV1c7hzk5xlvxTFRB6RJnoOWbs
	voSiApk6I7fRNt3mJ+ll5RRN/MQVeufyBYrtsWCqdXVxO/l2cDuWKj6dBQYg+4hI4YE+xKTGzDv
	31O1O/BcwkV2K9NNJls3QaTjB44U31UB4AZ27w4V9IEysFXM6WLoRFpEASLPjoT+eIgpOrORgBx
	WOXcAku781g16+YGVP/t54nXfFHTx554w5kiAJevAjhxjVvCR5PMNo13pbX09o7ZQ2YxvgjhnkV
	PndC8rdPYSUU2g6nqN4yv01UyXWD8W6E88iE4amurLt8r+EN1GQjpLUECf4UUV/09cqIgq
X-Received: by 2002:a05:600c:8b52:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-482db476c30mr33587235e9.9.1769777611406;
        Fri, 30 Jan 2026 04:53:31 -0800 (PST)
Received: from anesterenko.. (62.43.64.127.dyn.user.ono.com. [62.43.64.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e267b699sm12837375e9.16.2026.01.30.04.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 04:53:31 -0800 (PST)
From: Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
To: kvalo@codeaurora.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
Subject: [PATCH] wifi: ath9k: add range check for epid in htc_issue_send()
Date: Fri, 30 Jan 2026 13:53:26 +0100
Message-Id: <20260130125326.44456-1-alexandernesterenko837@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-31362-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42111BACFD
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


