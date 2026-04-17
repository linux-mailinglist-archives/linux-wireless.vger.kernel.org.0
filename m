Return-Path: <linux-wireless+bounces-34926-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOSqMJgV4mnZ1QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34926-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:12:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0041ABD3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60363302D0A6
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E63BB9E5;
	Fri, 17 Apr 2026 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le3gwoOF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5D384250
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776424310; cv=none; b=VPcGu+cZJAPGvUN9jjRfe2TskOKTQJrLltT7Elunoz1UzYRmeg1iU2VSkWKCByvmyFQ0N8IKtHYQY99vnQgN2QC5DtdzYcsF5+PBMSi2Ifo9NXBS0SGc2hDVzuzIvbTj2gKJNPlFq/XytCrPQJ+oXIDGYYKjqi6oj3bJkNzRaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776424310; c=relaxed/simple;
	bh=oXxvYp7mSxvDjDiF1oqhXSRgzy+AMfLNV5vfZJKXa88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4MhFGAOVSVqRhdlJXg58lo0XLNMz2hG5Mtdss/++UCfUbxrPlHlllEYFDPk7FBMEANCVPdR2S0VQqS0AhtyJOTpNDBZY9pBpspW8NKt68yHUQ80xutYdAEKFvjd7NPz4Y59oXrJZBlKkZedjqj9ECPAq/jgACh0SzqkCAGXM6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le3gwoOF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so7368185e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776424307; x=1777029107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZN3gfZee7R57N4dlGIBXrBPV0sAI+/BLIAVKZCa0Ck=;
        b=le3gwoOFGrVmtZNbTdJ1VkbmPjsqOfNHvO+n8KQkE2K8eAz7EgILbr5F861XgYhqNq
         ZlMu94WLVvTldkth3TAqrmFNwMBn+Feh/DVeRLlPopFQ7BU2QlyhBYopgj5ZLwxt8Tbv
         F/hGX3u5qCs/At765ADqStaBXk6xEiBrJaIp7rgXWpW+MBbE7f8QJOLep6eUJWMCJ60l
         nBVPryZdKy3XUuK5eD7Puvlhwil3zwdiyVeUenqj4BunNHIIrIlU5T9gs5ZHN/IWd7N9
         QwY/SBpZnbQRjoxvCfTmJjalbmjr3UXMyKnCtPgKXWT8nUTh9VvbYgfMFyHenYJOgV/+
         2ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776424307; x=1777029107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZN3gfZee7R57N4dlGIBXrBPV0sAI+/BLIAVKZCa0Ck=;
        b=MDOQ111JWwLbTbIk3f5E7wKpCOGIVgdqRjNmIaMuVunNuw0IGN41JvHFg+j2X0rwh2
         W5XvwKucszdI/bUFbKkXrXV8QgylohNjWTx96BssVTQwy26XujppglguQFYpK2zwCvs7
         yJMC+zcG2k8LWGrguLoVtI6aExmEqwCQf/Fu5XIVEhJODpwNBAOa7BYa63gTkZfbI9Nr
         axYwroSjfU6RCV9+gNXHQ3b7VDQN0nYeZ4Ql8P0gZ4eJJ4g25a6RPS8HFpgPC6ylJ6Yi
         w0CxqykyjZWkfcPmhO3UdbGh0IRoEuyTzjIDtlR5WdGxcwU6wVXDJqF1vfOHgf3iEUJO
         tytA==
X-Gm-Message-State: AOJu0YwG8u8qQdoVhXM6MF3TxnpEAqG0tB+udnkYk4fZcK2MBkdNEGW1
	cqNW2UomEA6ExUSRdmoftsQOHZrUUevflI3Kt3VbC71/RRJnsvBwfTIYpwZJd2s=
X-Gm-Gg: AeBDiesVpb6M47F1v66zzJg6iXoep4L40uWZOCanalX8crhLpKNpitVT5Sc3r64ySCE
	nCV4WCUc3yYZMY/VPductvBWOmjrWA5uZDD4a7UcioOWMocTI2TFk0DOxnMxVK+sdVxH/RQ9nsr
	kmBU5k2VMQExaCwpksJ8MzsAFTTPD5IupDYXM1h3nWz71gnUu934ONZ1qyTztgxZL/uW9LoGXTi
	ZeC3fJBAdBgydD7sRHDRpB7BV4EAdUkGxIzQFBdFFYq5/VcmDZ2yWALGehBZMjaOYkF7AJpTuJq
	38lD+lgmVHFcefxF/lofAd/ovBh+oyfUEYa+4u3o6wW4kO1eB4m2klIWpliOO3wOd69o0nQB3+o
	sKoTu9jLlVrMgZtJObIv8a+ToUJYDjbtCigbXKMH1BhjoYBW8FvwaxYWJdyUiA/wKKR3FPxke5h
	+ayyA=
X-Received: by 2002:a05:600d:8408:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-488fb773f0cmr25674465e9.24.1776424307402;
        Fri, 17 Apr 2026 04:11:47 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm62121235e9.3.2026.04.17.04.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:11:46 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	jonas.gorski@gmail.com,
	m@bues.ch,
	b43-dev@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] wifi: b43legacy: enforce bounds check on firmware key index in RX path
Date: Fri, 17 Apr 2026 11:11:45 +0000
Message-ID: <20260417111145.2694196-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417111145.2694196-1-tristmd@gmail.com>
References: <20260417111145.2694196-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
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
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com,bues.ch,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34926-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 6AB0041ABD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Same fix as b43: the firmware-controlled key index in b43legacy_rx()
can exceed dev->max_nr_keys. The existing B43legacy_WARN_ON is
non-enforcing in production builds, allowing an out-of-bounds read of
dev->key[].

Make the check enforcing by dropping the frame for invalid indices.

Fixes: 75388acd0cd8 ("[B43LEGACY]: add mac80211-based driver for legacy BCM43xx devices")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/broadcom/b43legacy/xmit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/xmit.c b/drivers/net/wireless/broadcom/b43legacy/xmit.c
index efd63f4ce..ee199d4ea 100644
--- a/drivers/net/wireless/broadcom/b43legacy/xmit.c
+++ b/drivers/net/wireless/broadcom/b43legacy/xmit.c
@@ -476,7 +476,8 @@ void b43legacy_rx(struct b43legacy_wldev *dev,
 		 * key index, but the ucode passed it slightly different.
 		 */
 		keyidx = b43legacy_kidx_to_raw(dev, keyidx);
-		B43legacy_WARN_ON(keyidx >= dev->max_nr_keys);
+		if (B43legacy_WARN_ON(keyidx >= dev->max_nr_keys))
+			goto drop;
 
 		if (dev->key[keyidx].algorithm != B43legacy_SEC_ALGO_NONE) {
 			/* Remove PROTECTED flag to mark it as decrypted. */
-- 
2.47.3


