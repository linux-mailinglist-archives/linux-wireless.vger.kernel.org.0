Return-Path: <linux-wireless+bounces-34826-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM+SO/UP4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34826-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D41040890F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 015A730719F6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A37938D6A4;
	Wed, 15 Apr 2026 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXWGLxOw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7C5386C06
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291808; cv=none; b=olVc5eUyAr3QPgZ9TCJzIdxKOtg972NljJ3/rsiWhz1jPA6Dz2or20Kaj7BeztnAS0SSNEV8/u8A0jp6N3I9bEOBlBKaBXR10Z8o2oTZnpwVhwR9GgCEFMUwc/5MF/bKAY9miFuFQDqTxfuo31kc+UlW51Ax5TAXj6U9t58Mz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291808; c=relaxed/simple;
	bh=4ow2CUbfAykWb1AUr/pjXrvkDjKzH/5bLVW7cyLSbFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idyyEc0o9gZ+cW9Q34HY6XUZFekeN7WS+EhYmd0Kow9eXZSw+kYOc8PnFi50Is2F0WuyjYeRrcKTNdQZlKe1OV1XUMeQkOi/kb53H4fSI9poCv/WuUjKOUCrwuyJOidZ5UEAVcNtghFk0uUQayPh9D6cMp9maKkd9w/gyRU8Ask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXWGLxOw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48896199cbaso76478845e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291803; x=1776896603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBHZ3elBfpoOc3dzAqhsGdJZlPJkyY7fwDZN5hydqU4=;
        b=cXWGLxOwKEPmoLB0NeMEUKOcWxC8ZgPe1SE8NpbxVM76TT/tih2AiJrDMWicIVhNwm
         VxobMvlwVY2XHQeTQMvEPGyKWw21BnCb/XcvMfIgQUx54UGA/YItibecU212aFuwSUH4
         onTTV4OgtK8Yg0IWDYCSuw2Xv9XhQ0tt60kI93AQooD/1cAzSSILZi2qP1GMqlr3xz70
         KjXY5NzJmN+UyqHw6nfZxOIONEoG1T/zyHL4vFfuPnM2GFnAim3Fm2BcArdmZfb2EHj5
         rIfhc0PvL4yIlb9HBacoGzUapHeerISWGgWvWG0BONpzWar5Ehzh27BlQPbsF7jdh4Bg
         earQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291803; x=1776896603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VBHZ3elBfpoOc3dzAqhsGdJZlPJkyY7fwDZN5hydqU4=;
        b=ZaHXfUAMPUEwSxLmhRvrrVLUeQs6gZL/gHILKCRauwBwdLAR+0cmLNkCGxFKtSdqXd
         XvphSqFPlTv0YGUxNsnhG03qhRZb2tkgqR0ivYz9GW5K3XR/87q6tGl1bsX7Wa7RQH9r
         1jTb+BrSvb3lTO6kygqoD4hdohRWdVll1gytCJ8fP20M7VVnn54P3GH7LoXqv73Sa39y
         UFPWT0C5cNW6PNIKVbZ16CbCmHyPtEMdleV5f0gqEe6oW/ZO9wokcIohDDdzbaTXz5sn
         T7pTZKv/7gG/xuc/okM+Pt7R+WqzuEEyN4zZ/0BoM7GGGldgNXrGdIlB0RlJ8kWNPXMc
         Bd5A==
X-Forwarded-Encrypted: i=1; AFNElJ+dxAhJ+zRq54jKDbRZZtQI2NcPwmAK14Km/2dMFhen3KLj6JrFLuep7pdTEcLvY7ANDWCzRMluqAfe97S6sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NRluT9+VQm5TXgc70KK2zMs/SnIbRm6ELHE6jvRMah1Y8CIi
	83WPwHwu/JEpgfLmNM7OahGfXSf5AYaJENHGZDsqBPJ9GUksLqJ4EZI=
X-Gm-Gg: AeBDieuwx21T19q5Z8QzKuhENv92nQ9UV7vmV2sfvI5nGit7gXmsw+kGpxvDoqgEAGS
	UKx/VcFiCVjlGFMJPzM0TrR6IQ5Cc8LcoZWNgFhdAN+B0+0gpdBhA8vaIIPUBmHG5nQ1+IHDfcV
	W+1zeUsd1KNu1iNft1yIfdhoDUNr1Z3paygfKrVqrgNCESEiLuQ7Hxj+MzQ3hfhhrM3aKtFxN+M
	XrlBi/WZHvW1OgYuhZMAxC5H2W/g6140Na64MTH0MN19tkIHIJQ/4zMWJESn5Lj9PU0bSpkXYcq
	KPsiXP38Wmwuj1Sduf3JzoaOuwsEGIEaklfhY5o68Ae2lrZZMiany3q6kcTHy/HcSPsxj6jhDaI
	asS3CsJCyfg5VlSda1sRsrit/6LI0U16j2F8DN2gXvYEvuABilm3U84VoV0nImGhAlVSHj454Ww
	p1CgU=
X-Received: by 2002:a05:600c:8b6d:b0:485:9a50:3384 with SMTP id 5b1f17b1804b1-488d688209dmr299733775e9.25.1776291802731;
        Wed, 15 Apr 2026 15:23:22 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9a742sm28702585e9.14.2026.04.15.15.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:22 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: carl9170: fix buffer overflow in rx_stream failover path
Date: Wed, 15 Apr 2026 22:23:19 +0000
Message-ID: <20260415222319.1538389-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222319.1538389-1-tristmd@gmail.com>
References: <20260415222319.1538389-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34826-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D41040890F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The failover continuation in carl9170_rx_stream() copies the full tlen
from the second USB transfer instead of capping at rx_failover_missing
bytes. When both transfers are near maximum size, the total exceeds the
65535-byte failover SKB, triggering skb_over_panic.

Limit the copy size to the missing byte count.

Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ath/carl9170/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -918,7 +918,9 @@ static void carl9170_rx_stream(struct ar9170 *ar, void *buf, unsigned int len)
 			}
 		}

-		skb_put_data(ar->rx_failover, tbuf, tlen);
+		skb_put_data(ar->rx_failover, tbuf,
+			     min_t(unsigned int, tlen,
+				   ar->rx_failover_missing));
 		ar->rx_failover_missing -= tlen;

 		if (ar->rx_failover_missing <= 0) {


