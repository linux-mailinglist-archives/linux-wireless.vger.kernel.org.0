Return-Path: <linux-wireless+bounces-35169-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJE5FMOD52m+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35169-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:03:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A893D43BB73
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B616530E5243
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9943D9055;
	Tue, 21 Apr 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K21E2OWL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CDF3D75DB
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779423; cv=none; b=Dg6ET/OkyCFYjC6TVF48YZeRGXdxqwU+L8bA6Vqyo8xrOT9Dve+tpweCaH1PrSv+DUCoPTDH+LGxFefBMBndgmOtzTJa71K59ElFzu+Gng9v0MtssXOsyCmF9tB5IKsANrrrrYbf9mP4yPiKGzz8dFnuBd2DJlzl74GLmOo68aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779423; c=relaxed/simple;
	bh=ZVFCxeyGzS1bYtkAHnAkn8gMgfsWCuMTuyd42RH5/B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgqHiSNP0WmPKzlghPkBgVvj5nEJ8cWV7mc4b+VKvhAM/BvfdGYDGpzipZerXC+BLjz0weUcMlOFYyUtuR7KxUqvNzDCQRtxlm0iJ8DauxDdlfKFCd4SU1rXmc4wO2Lw73wq2T0GzYHOvtHZuaa9aIIZZuSgR4AnalQ8WeliH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K21E2OWL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48909558b3aso33704085e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779421; x=1777384221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbGiAf55DG/mqZeDogLKNQh55P9/BknLHQUpixUK+g0=;
        b=K21E2OWLdMxAG7rk4g0tDBBOl6pM8wtzvgxmYxsswJf9XgzsIkms2FivSaqcnH255m
         cfIt74VFd/7flAp2InsUAzYcUlfTvaeaFaqrVBETDW5pYqZtMlP6ivNi72+4969yzrt+
         F44AYTcKGeS8+ffOnxDqVg6qlGcEAEw9Ci/iNBo2ce/tFAZFxQVCI3Y/Qmb21TK8i/s0
         YD9sGjJFNLKW5b75dgzu0aOwLSB1wW6PKga0bzLD3yb1aSj32L06vBcuoFoAOgyIxh6w
         1vjNfnlLcQ/dU2UtLT53VNngc2UWPXrKdCtoagy0dNfQJbgvz3PQq++Ak02keR8TNFX4
         wB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779421; x=1777384221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbGiAf55DG/mqZeDogLKNQh55P9/BknLHQUpixUK+g0=;
        b=JOCRXQp39+e2OTO26UYtfaVNb2WOxbyGNriCPIUrQw6na1UPnQXbd7q2jS9ET/NZ0b
         /wjgpVLkvcHI1GFjOHxjaUweopHK1+Mgz/EJ3Ex7jTZkN8Tt2pf1f4Re8MDsTyxNYyHu
         x+blaDs7lxyLpmSYV1mdnodzc9aj5cHPT9SVZxh5Bdsq0EnlNLrSGn3Yvx6HA5J3IdMU
         pv1UnRAm+r7+n61dcd1QaD8O7Crh/h9O/QX2qoqwZgaboKg76dCh7hFcNvilkFrbrmgS
         ORx3rZeD3OSXPd1Mq4YJHwO//WDZamGfgLb/GoBIAz6Gq8YoNcSBB/b0JpnE32UvthA4
         7uoA==
X-Forwarded-Encrypted: i=1; AFNElJ8ba89WZFDMaqAo8S77zTLGwmpZO4vKdoK78jyOk/NJn2dkB3sS+JsWR4L7sOxaQYOrrL1IwRrgwvyC+d7TLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyNARIQcBGs+vfWLLeUoJpuNDcIrlk3nGs0HmmQmniUBRRVP1
	Tu/sXIKZWo6QaFwPMfriw0saUgv+hwCev2dJ5L7YnBKS/XCkYBQUlRs=
X-Gm-Gg: AeBDiev7z28ZO/kvsOKaPqWxRWANQgpjYh1dsVpwkQimiolIetLxjh3j+KZT5TV5icw
	NuSOzv3MXRZ4ueue6+AkBr3x6jx0OL/szChyiGfWw7tE00IgiYljKw698r0MXHwamB52qOPMxLe
	RA6ZwkVxZSjKoadTzDyWRHEr/zl3BIQWeQfxQJnTAFLIX8f2s9WMwEEBetmt5DiNDYrIOX0cHWD
	SvJq2b9C5CtUX3YcBRv4Ph/egl08kuDzGVtGStGIo88mqTcnwqvkOUdwhrGdLj79Duv10oY9aD/
	OYtQanxbFs+9jQNGVSB5Xka131yZu4wHVtdDPAg+xwwv5MYDWzcbUdqj6kqDTkFh9XnWA+U7Hch
	LUOUTX6voDijUuD2VzlWt7MqS7JspcNldzSvbs10238CaVil32uy6Pk/2evgn9ctTQuEir8TXqm
	7+0AU=
X-Received: by 2002:a5d:64c3:0:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-43fe3db2d1amr25927680f8f.6.1776779420791;
        Tue, 21 Apr 2026 06:50:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a092sm2761850f8f.23.2026.04.21.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/3] wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
Date: Tue, 21 Apr 2026 13:50:16 +0000
Message-ID: <20260421135018.352774-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421135018.352774-1-tristmd@gmail.com>
References: <20260421135018.352774-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35169-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: A893D43BB73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware response dispatcher copies all synchronous HAL responses
into the 4096-byte hal_buf without validating the response length. A
response exceeding WCN36XX_HAL_BUF_SIZE causes a heap buffer overflow
with firmware-controlled content.

Add a bounds check on the response length.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 813553edcb789..f65328329f4f0 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -3293,6 +3293,10 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_EXIT_IMPS_RSP:
 	case WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP:
 	case WCN36XX_HAL_ADD_BCN_FILTER_RSP:
+		if (len > WCN36XX_HAL_BUF_SIZE) {
+			wcn36xx_warn("HAL response too large: %d\n", len);
+			break;
+		}
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
-- 
2.47.3


