Return-Path: <linux-wireless+bounces-35668-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCxSGkvi8mkmvQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35668-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:02:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4597E49D771
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E8EE30296AC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E026374E46;
	Thu, 30 Apr 2026 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="zPkTQ+bX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B2377ECA
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525107; cv=none; b=LN5+BsUXW2nuhRYK4kCc2bMGqYXi6flXBWSyuZjeZzt2e5jMC/X4sjK2QjxUUUi4UvVRMhoHmVulMg64uYf0o2phVfjB8gDlCurAC0Z5B0eIQxaqKlIWadREhaSjxesvnlCAvQX+icA+9KMs8TNwELMedyASAbSp4+ClzgGpuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525107; c=relaxed/simple;
	bh=oCc7gcXJeu51Lta7mt7R5GL/+eB6xIUqhxFp3xd2m34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAAs+y6Ie1v3LMFvaZlORKiB0iMbiImVSwlAlCXiPCSJulCralJn9njpFODRHu7fEkBZzcibuVnPadV+VNCJj3GmIL8ZMLCB874GDhsDlZcdMdYnfGV0uV+UKY36HrxJuJ2ROhTkmm1hveHkSV3O9baSyQ1lPISRVoJM6yg2vZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=zPkTQ+bX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-83177129e28so230771b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525105; x=1778129905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP095ZhYw2b8rtfTp1Te2wsBKkizx72gLLNn2a1UW1A=;
        b=zPkTQ+bX/bbSzyFDp04IDLbdEMDQoIg6B/4YFAyvhHasCL7x6UVsxDgRcv0SFU6iFw
         4ZMFP8udO85YbnluzmRF7r2Tzh3R5pgmbc/H6vpH2v+iltK5FiKvlQ64HCHKB2P1qYbP
         eR58EiPhE3bZUeQ0buTIuyyc7hZPaTZvIocyLr6p/vZJhYLf2OJGgSiciroQoczxg17b
         5zHk94U+dstDYvVZUGRaB7LMmCjpmeIFgXSDUBLY7opXF7p4C4TvaYdH8k6FkHEp5pVh
         T4BT6MRFTB5zu8IVKOZjHq/2GyrrGcZaK0E3gwsdKWdxwAb9tFj+ebQeAKpjXLJX+c2T
         Lj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525105; x=1778129905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XP095ZhYw2b8rtfTp1Te2wsBKkizx72gLLNn2a1UW1A=;
        b=JypXBXSQ/7DwYWQuyM1lrpuNhTBLmsTqYw6H64I89VbHZ+Y6RpSUWYL+Gp0lW8e82N
         cwDpRZaQivXvji3i9CDl8ZpzO8z7hk1UB/icJXE4UyhCW8WoB+UDGXrYTVujhWGtkhc/
         VNEc1JdeChxOUxF4jaUs/NTksKIG61p2fmNGE8xVXbuTgi8W2U7bI4TIvyY/T3o8oUe2
         55zZhFc4MeIHcNVHY0TfsYy7OHmdRSD15d3unynLeGr8MjPTmo/XNpcOIBMB+B1mwayc
         FcUQh2BENHOwJRgn5BCe0nQzru5FW+I4h7Yb7lQOxJ05PMtdLhovT1A88MLVpy9QsW4+
         bnug==
X-Forwarded-Encrypted: i=1; AFNElJ+7FcYfF9DvvJ444SueANFYwcXW8VKfc63sfMrswsDH3Lvrv9E5sfryud0vdZkYxv0KOglAc0s9A9fOfBgNLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqAwfynzgO+1YWeqQFQfeFEV3+4U+Ofr9YmP4solV3RFp2xk/
	ZBsph6D39WCnMtlB03aspXc+7xCFOrdvJdatxEtJcVxFDyX0Wcwkgw0ph6QknFRMdpE=
X-Gm-Gg: AeBDieuPfPVSHeGbaqrS0a85dKR9ZM9zQZywll3RYP5KrSUHCvgtuvfqaPheAyUUBcP
	cQc13E1l8CXVsYmK+L+5Cv7b9eshgjogOBJ9wOAjXJNo/w5hT0sGw9qofDolomS4vgOp0R86jTz
	rNAjUQSrwopFXAmTFDZfyM4XVr3kug4JZtJeMJDH2E0qFAbFzNAflDNWK7qLEjaJm1WHwiNYV/y
	spXRPQmCvgEvJpQRXvdZDc16/Jekmh9rQuYsirWkrfveeALU7KHReUpKVxfB5Q6dblqycAyzeR8
	BcOtnr91oMWCUWWSsoblWwIiTsywPOiDERonXLsKFtwsvXpidBPPFFU4ACAxj5B4IqHrSHND0nG
	4AbmwhC2o0q99nTX3EycnzX49kXT2J6Hd15WVqsWm2bk8XYnj+uW0kcZSxs6TWwnMPVGdySa9YP
	/g/PIRPsPE7JJAN3Mujb4RPKPR2kQKuBsZ4ntGv1X1/AGTO3LdCqLpLWt55jQXtIpUmdW+Vbukc
	+tAYkhCxqgsOy4Yxj8nL1pZYggjlLJ8T80FXN5qhw==
X-Received: by 2002:a05:6a00:b605:b0:82f:453e:3863 with SMTP id d2e1a72fcca58-834fdbaca42mr1653172b3a.22.1777525105512;
        Wed, 29 Apr 2026 21:58:25 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:58:25 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Ulf Hansson <ulfh@kernel.org>
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 21/31] mmc: sdio: add Morse Micro vendor ids
Date: Thu, 30 Apr 2026 14:55:47 +1000
Message-ID: <20260430045615.334669-22-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4597E49D771
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35668-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email]

Add the Morse Micro mm81x series vendor ids.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---

v1 -> v2:

- Use a single VENDOR_ID
- Drop B2 chip which is not needed

Ulf, a mistake was made in v1 [1] listing multiple vendor IDs instead
of a single vendor ID and the subsequent device IDs. As for why
the series is structured as a series of singular patches is due to
how wireless driver submissions are as per [2] to simplify review
due to the size. The final submission will be sent as a pull request
with all driver files as a single commit and this SDIO commit
beforehand going through the wireless tree once you have acked.

[1] https://lore.kernel.org/linux-wireless/CAPDyKFp6dhmpkMCs=ejYTpR9oNbNz0urtFD2HTvRwOp2Y7H3DA@mail.gmail.com/
[2] https://wireless.docs.kernel.org/en/latest/en/developers/documentation/submittingpatches.html#new-driver

---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 0685dd717e85..111cb1758830 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -117,6 +117,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_MORSEMICRO		0x325b
+#define SDIO_DEVICE_ID_MORSEMICRO_MM81XB2	0x0809
+
 #define SDIO_VENDOR_ID_NXP			0x0471
 #define SDIO_DEVICE_ID_NXP_IW61X		0x0205
 
-- 
2.43.0


