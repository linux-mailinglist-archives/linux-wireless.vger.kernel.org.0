Return-Path: <linux-wireless+bounces-31363-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BysJ52rfGkaOQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31363-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:01:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBC6BAD34
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74AC53039883
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2A8352C47;
	Fri, 30 Jan 2026 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQT31aW9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DE350A36
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777815; cv=none; b=c/41rAS5yZkKA1Ozd4Kilcg88RNs0TbToWiVTOBiibaD2uY2eoTBwGw+cJp+rlFXkO7ucHSN2DZ9OG9Mm0hlv4ui7LQQdJoRdc1EzhffSdep4YQ0/hURrWU0V0EyZ1JjTOP1YE7Z0V30xfJI/9kkky9ktM9kG8B2qUmYcUrFFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777815; c=relaxed/simple;
	bh=dg9kYr8aZfQN0Z5Niq94kmT7y8LXjeCMZKoKN1fucL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ke55j/Vb9zQeVaPezcwZpsMIg6Aq74qiOSP7uXSj/kzdLMT9OR8mdxg1mul8+gi9IgKFN1sWuAQlnFbjj9l6TNMWMxGSfFCAj8kTD38qo3iggQbMOrVuhhUUmzAvcidhpKK9zU5JOLzKCtVCW1pWddL2fjYw2KfAslDtKXQa35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQT31aW9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so23504775e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 04:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769777813; x=1770382613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=TQT31aW9kXm7Y4MrPD9NDb+keD+yzYvE0/tN9KSiKLKKif5eza+UuY0Da1Z9j38xxU
         ehJe/rX57rm/7QOOZ0Tr6B9iOwJIeXzDoV6l3nTIQc/URTBoo2cHNLB3IsXMRVNHml0B
         fhQApywnFACwOZ4xn4WbpQWPYNbZcm9zNfBGA6ys/NTXzFyupljiU565bNCFRRbaKDs/
         Bf1m3+/w9v2zNo5iFQ2VfjF8WtcXZkL/LWo+PaEbf3JCNp4KzzMkKkRzp6qmCx60ZI6L
         aMZ9UlZG8I8Dn98umdtVOhd/jr0vixXEZQIEFtWmgCy8ZYnxQexRQUS36ldRNzHrXrIL
         VELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777813; x=1770382613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQzOK0aKaeoderdrXRGweVvWgIMEPYBk9+gZ71lrHVY=;
        b=wsqxcDpIAvppANJFGZqHVyAExyFQzpM5JazaxUPfh5lMykXKePvsyTxzCj7dTEW7WM
         gGg+hZhlPKG0nOwjYSnIBxQ6uhkW2LpltE7TmZAxEcJqhM4fAFE3EKlIyEIZ145vFN4K
         jwLJ28HnTckVXgrMgOdH9o98mjMsulIYBSAJtMtCZqD3tlL1r/2APBfwCZVFremZNAhG
         Y29tA1PoC1Owr3YMh4HVxUVBoO/P3l4IYcF82Kz+kXqdaJgKSAW/xU2Ir3jXBSADUeN5
         kQ4h6N36FOMk/zZAqHIc1a+IMrCY5pR10vaq3wE/Jd49pgpgqS7MGZmzwT+o1vqVdd8j
         8fjg==
X-Gm-Message-State: AOJu0YwvVFg/81YFAcC1SodJ/zYuXmLznSFTCALl2MCsA9OYO9UP8plX
	h2TrEadpYjaYF4kDTHMOHf0gNhSWe0z/ktJv56ON8o5OsRXUZzHXdOye
X-Gm-Gg: AZuq6aKW3Sgb+6mk0oH6nJN1dvkVLd9x0UVOtSX9gfcqr16vNEaJiV6pLHwevVh4Y7i
	F+EGnE99iJVosoSvuCHI8piQWPqRbyw+8p2kTlFsIh2wsLwe1UoOwTgXHdWk7qhrtb76XIDT5HH
	rtEBblS4ImHHslNr5evxtRNrSD7jKOW2rZh6VMepvXb7CCAEAARJFOYJAj7w7YwnNDfDNCWIaN5
	Ch6beK0Zn+44+PTQHk/yFQgyPgVdyLTFou3EITgXogfQK5uyv494D4DUCNtVpvxvpYpBNt6WVJd
	hOktcQVpkxXQfS7StDySoSdpwcosgGCdX08Z64QDmGihqAW0v201peeu6q0L33xpBUi0LS4zwMv
	K29c3yCBcq3KeF9bh37P/YLCqTwH57mS1iip8MHIJV5CWJYY++6ZEo4Z9NEU4naNNsmC6oasnhR
	iEnMIJ+ILrqy7jfeAfjSADbXvIuVRqp7y5Ld/fpHQQCwmgYvDHbBicgzzbAA==
X-Received: by 2002:a05:600c:1e8a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-482db4958famr33084195e9.27.1769777812528;
        Fri, 30 Jan 2026 04:56:52 -0800 (PST)
Received: from anesterenko.. (62.43.64.127.dyn.user.ono.com. [62.43.64.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dffd47c2sm15117155e9.0.2026.01.30.04.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 04:56:52 -0800 (PST)
From: Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
To: quic_kvalo@quicinc.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Nesterenko <alexandernesterenko837@gmail.com>
Subject: [PATCH] wifi: ath9k: add range check for epid in htc_issue_send()
Date: Fri, 30 Jan 2026 13:56:46 +0100
Message-Id: <20260130125646.45925-1-alexandernesterenko837@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31363-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[alexandernesterenko837.gmail.com:query timed out];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandernesterenko837@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDBC6BAD34
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


