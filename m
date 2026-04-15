Return-Path: <linux-wireless+bounces-34863-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEgzKsQT4GmPcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34863-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:40:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED7408BE0
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B0A3168856
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934F38D6A4;
	Wed, 15 Apr 2026 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Apz1Mu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A434751E
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292637; cv=none; b=c4BvbqnP2SDlg472j8sed87GWjN7scY5UHs1MWTZsEjjgWPvP6MciUpkMq3GWJ6mTViDyb3ecZZYbEmfE60wTlnRToIxEr9CFjlE200ng4fMyPh3ydwTtAVniPipTQA0+D0bk/3+148TtyxNt0qZapRk8rqZZjcynV8Li2pNxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292637; c=relaxed/simple;
	bh=d2Lj+g/W9ca8SXN/DcXG9vOg0X/HWgbA3Y9HMpkWKVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O07pjuva2tyTDmkpRmLqGBUDoVqD+54zhu0kdBnoUi71IqrnioJAVyFQuKgfQc6PJk2Hi4vWZXR5YQJiC+zF7JSHkeCO9VLFQJeryluZvLkRGGUdPKPCUb9ui8fWZTHj5bqH/bmcrKKP9kHMYhyg2n4EiUNT9GAAsqj3dW37gTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Apz1Mu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488afb0427eso86494735e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776292634; x=1776897434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXUnoGF+RGk1J+y7bIlULUzEO6llEkrIJpWaZB0xE40=;
        b=A5Apz1MuOHqJ7LN7Hb1H/dBKCSz9MnUTVeO8ju6zOQ9wwFoa7BmXHdoVQs3Bd7iz+o
         nlLpfXe7y1PrPNllwg5Ah/F4GFKKgQE0sBmCRBQ0fMPqvRPgMXQ/VEmKAszhW1EPURCd
         E2PbWt6+YWYjbJu3B8FSBKt3r47ixGKAh8sCeaRnSJf0HyHqIZhqC2bdvCad+CXLLSkN
         d151Pwgjt6SkUZMe4FZzn/aeRmr7jYfzxw8DI3G54ASln6KN76Kmg5rbd3260r8uubwR
         k2vU5+6CgLh3YRwSDMkkZIqGwq0zVoTzuHkKb4w8pMg5vjDxUZ96IakasgvGW5v9BMso
         WFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292634; x=1776897434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXUnoGF+RGk1J+y7bIlULUzEO6llEkrIJpWaZB0xE40=;
        b=sDNt2W4oTCqss/lP1ojWe3+bYCqDneJJml34l+7G/Hz9c5Hc6qr9JcZPvTZS3a+sX5
         Z41kKkvDJFXQXzFod7VDbcu7ZbbgiiehdpHLs7sy3pOCovlZ5X7U6MZWXTNg2lH+l/E3
         JpH+utlVDAO1XbA19AEG8gTc2/qV9juuKmnhVJe4iLdm/b4Otjfj6QNTHfVgbZbz0J41
         V9f5phLR42M4da6U4Xe75CqKmY9E6M9Y4ija43hrHht0KVDPQpiqpJnaoGvkODD2ASyl
         sxBChk6b96D4+e3AgU2xNdZFBJbLMOL9Nf2OsoGsacJZu4gDyGYMZ5jf6BW9eKwO39gg
         R+2g==
X-Forwarded-Encrypted: i=1; AFNElJ/8HFjJCzI0a/hMql+s2O8K+bKvRAEBqcwLoll6Mc5L7mq8qmRggWH4TbfOTB8+jv6848OfMHwEbgrn4+YYhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4MRjweBZWMaF77o9T9eP/EfSct/08wQIO1hCzcNWlWAYkM9f
	wfFD1gO3IcH0iy4a0xW5lAP6cVmSmANQBYmT5FeJkwvzFMu4wFNchsI=
X-Gm-Gg: AeBDievqCQp2DtXHJl9g8KYUsEcSzzjBKmm/togm8CcW5EPHjh757dXyq/OW1ioufed
	nl1KRrjpv7fqAafA8NWg52KM+aSMm/zAkJqepn1qAqVboxWHpb6KTzRPS8kM6TT/6UL428n4x1G
	7Ov8NCS2daKxCArUzu26XAasI5EP00j8F4lViiU0VcemwOFtMCD9IOGyUKhFUATqSjJ8+yI6DPm
	Ojk0kvukKY+w99bCDuTgYGafDm0PR7SStgzCnFVgN28lGNOHXplFRqGNB8APBStovJqYFPgiVG5
	L8ClY1YTFfZ2i9wSKoWPoRH1QMQ7crcyi8wA1QJxhIiS/EfRPNglcq1qQAHl7DL+aO4omJlNlW4
	yhxw65pgLgdWkYrJ0KBlqI74t2YI76GdLhFhoCREN4tvpM6EcdCFMZJjI8JBtCnOR1Pt/8wXTy+
	l0F5c=
X-Received: by 2002:a05:600c:8b2f:b0:487:1520:d107 with SMTP id 5b1f17b1804b1-488d688da37mr326888625e9.31.1776292634247;
        Wed, 15 Apr 2026 15:37:14 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818da1sm2550345e9.6.2026.04.15.15.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:37:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: wcn36xx: fix OOB read from short trigger BA firmware response
Date: Wed, 15 Apr 2026 22:37:10 +0000
Message-ID: <20260415223710.1616925-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415223710.1616925-1-tristmd@gmail.com>
References: <20260415223710.1616925-1-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34863-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18ED7408BE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware response length is only checked against sizeof(*rsp) (20
bytes), but when candidate_cnt >= 1, a 22-byte candidate struct is read
at buf + 20 without verifying the response contains it. This causes an
out-of-bounds read of stale heap data, corrupting the BA session state.

Add validation that the response includes the candidate data.

Fixes: 16be1ac55944 ("wcn36xx: Parse trigger_ba response properly")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ath/wcn36xx/smd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2599,6 +2599,9 @@ static int wcn36xx_smd_trigger_ba_rsp(void *buf, int len, struct add_ba_info *ba
 	if (rsp->candidate_cnt < 1)
 		return rsp->status ? rsp->status : -EINVAL;

+	if (len < sizeof(*rsp) + sizeof(*candidate))
+		return -EINVAL;
+
 	candidate = (struct wcn36xx_hal_trigger_ba_rsp_candidate *)(buf + sizeof(*rsp));

 	for (i = 0; i < STACFG_MAX_TC; i++) {


