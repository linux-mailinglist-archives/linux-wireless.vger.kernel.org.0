Return-Path: <linux-wireless+bounces-35148-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICctBP+C52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35148-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E7B43BAE1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4883067CA1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A703D8123;
	Tue, 21 Apr 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmlz6TXz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD763D8116
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779376; cv=none; b=TW/faNaKVd6smxUAYN2ARAUKWaoPKH7h3SDKP+ciQ+jbz4mle1MyTKa9JIthzxTtw62NhRfMmZSBsQGKlZi0swjhABAA3KC5HPIuGpPD/6A+k8zYTKSRmMyzeFL070rsXb3WWO3ZvVLgrL9fM72jBsf+7mHOxInTJZ62bEX66fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779376; c=relaxed/simple;
	bh=C4CFfRMF+3s24k+rhrCDQR+uVdUTHr9rVtxeNjumJ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZ1mS5dQX7M8m9aFmAdOhUaoObGwnFT7DMwm7ms7Hj5wktoPtMq7QZBcBzYi2FBXoa0VLDv5PgDajtYtgzX4QvAsnsEV3U3MktU5STzabrRr0rnYaICHyQ4vyP3oy5Gg2T5MTL6dOKn5z2nmcukaT0v6QPYoMrAXYyFb2B825Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmlz6TXz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488d2079582so49733485e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779372; x=1777384172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOBaqxwAYj1dQn8NQqyR4iLTgA49hrzkake6CNNEDys=;
        b=dmlz6TXzJExaehm4AFO/VV8YW5qWFclnc+kWjcGu7MFWPuVvMhCOLMUmsodAerHUPZ
         27B4elwj+cgt2cD89C3L8Y/hkHD6Da1S3JM29G97IskE1ji8yhxHq6HeIxmULQXdlXaM
         MaGuc5h7paxOM3ukvhfq7Sq1ktjiepe/9T6M1DDedAWPFn3hiSH9Fq1Q/jOJwFyFMA8z
         hdehKGYSa8eyGQg7SkBji8VTWMzVB3kZwS2iNPce+LT7rZHEKw3fZBpYgh5sovWztUek
         ntkQd07jDOEp6wsQ0hTuaE6kOmV5SOm61Jjby2KJL4U4I+tixT7Kw1nJOf7DuCaYJgM4
         MIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779372; x=1777384172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOBaqxwAYj1dQn8NQqyR4iLTgA49hrzkake6CNNEDys=;
        b=QKYwyJCYJPycNOY69/1qb1yviDjGAtOOafnxNfW6Y2kxO5+uFadaKHSeUnrL/JX9V3
         pKndHIvwonPUwj4PAG/Wwag97g6krVYuuLfv0Bu8qbNYKCa1ve+JeRPegQ+NBkpPs36J
         FTzVtcZXZz5SsUKHbrj2u7+AFiDXnVsGe2xIorTm3l5fJhjGcWHS7AeBIYd+XVVEr+ut
         ZTjlEaDnfSD0j5PlkRIjvayMVaRvRRqsVtMb/8oaXHXn4k6tekzi1OB47vkG619HqS1T
         /lfiqxaop6z3Th7WNFOduQxK4T6ivEPK62xU/2d1aaAIyEDmEwnSZVcro7hWlVaKyEYA
         x69w==
X-Forwarded-Encrypted: i=1; AFNElJ+lfh+CtxE8c7fu51aaOU1g/1XCPGC9zgzi1rvomZ/hDFPzfnTVVsR/4bifWm4zO0ns7q2FkyW5IKIP/xUj8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5zfInbgoRNsdu4mSOW1ZkxwlhjsLm80T1xJgq/+QSUltD3ow
	ivyrUyPiUvOTvvabjgJObRd/cT6oAgO1B55FhlU0DdhAYtuK8bShxnA=
X-Gm-Gg: AeBDieuny45H5NJGt/qd2PXxRbix3Lms3s0GOrCIUlj3tAZdWD3a07a0tmyWqMa+5qs
	YKpJmb1s7Er7lm5DnIv5l+EmXRyh7n8RmMb3VKXX9NI6U23g6/DbSuDCrjp2N+KCqwEz1trEHvI
	80gaP2LIdzZYG3IsOyVQo+xk+g3Gy/NvdZCMpeDbaQ9SYsxXuFWn4y+d76yGZgYGtE7ML8vXq26
	sOJ/XRQpviihxMjC1kJ77yXH+IikaMXx/OFcgoEqWZ5FCL57lTdR0vKt9TO6xjIgIlAhkynytw+
	BOEX4eDtxyPVZ4AYQbOEjTPp4ER7rO8q4I8ZMZVpnNcceIsoxkVrbU/ypvJUzrVDwT033IJsvZn
	Qzxwx2s0r7G+JSu5eYtduM/hPlT5H6iP4Yr9BzadS+YZHaBW4rQajK7aY3xDoZEkERKHVlU/IHh
	dZlgnV5SSzs95SWA==
X-Received: by 2002:a05:600c:3483:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-488fb7787d7mr240927445e9.15.1776779372074;
        Tue, 21 Apr 2026 06:49:32 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c318636sm168157785e9.7.2026.04.21.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:31 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/3] wifi: carl9170: fix OOB read from off-by-two in TX status handler
Date: Tue, 21 Apr 2026 13:49:27 +0000
Message-ID: <20260421134929.325662-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134929.325662-1-tristmd@gmail.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35148-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 58E7B43BAE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The bounds check in carl9170_tx_process_status() uses
`i > ((cmd->hdr.len / 2) + 1)` which is off by two, allowing
2 extra iterations past valid _tx_status entries when the firmware-
controlled hdr.ext exceeds hdr.len/2. Fix by using the correct
comparison `i >= (cmd->hdr.len / 2)`.

Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/carl9170/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 59caf1e4b1589..06aaf281655b1 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -692,7 +692,7 @@ void carl9170_tx_process_status(struct ar9170 *ar,
 	unsigned int i;
 
 	for (i = 0;  i < cmd->hdr.ext; i++) {
-		if (WARN_ON(i > ((cmd->hdr.len / 2) + 1))) {
+		if (WARN_ON(i >= (cmd->hdr.len / 2))) {
 			print_hex_dump_bytes("UU:", DUMP_PREFIX_NONE,
 					     (void *) cmd, cmd->hdr.len + 4);
 			break;
-- 
2.47.3


