Return-Path: <linux-wireless+bounces-35171-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFvJN7qC52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35171-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:59:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B78043BAB3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2CC7306CC79
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C655F3D904F;
	Tue, 21 Apr 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAUyR4jy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489343D905F
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779425; cv=none; b=KGDp8wS8UdkO+k74B73OzYncLbCMksAy5bC24ho+LZAaRz8lMzVV2g0jxre0O3uoN2FmqOXyDPLGbi8gj9QR06L/8JZTqru4WqjqBhLjwJTNKyZQeRUEA1aLH+QHd2ZJX9xDiZsMtXJ4baIHMWQd5RHIS9qL/T7k5A4tjnz7cPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779425; c=relaxed/simple;
	bh=bryGMZUE122UB5+VxWx34ZJXrtUfuWDFD+QxqR/0SqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVyjp4SdZDSKsMDCCa2LfTbck3+Cg6JrdqDmbXYAXAcDu7v6/Hwz4L2lHbFZT8ZJYlZsEhHUevgRp8HqPb1lQQ/bIwFD/2+ZKb+n5jHlrWfMg8qrUbSlRLPYrRmjuw8d7kJ3cWhX0br0l6ULRtJ2KPorc6PZY7g44L4GtLLVf+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAUyR4jy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso3829347f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779423; x=1777384223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otAA4GaVEF+mBHTbPlhtMA1OAFDFVDJuOvEPR/n5ijc=;
        b=CAUyR4jyQ5JzZqZzY4UBJ1eEvwfSASOzR3UQOlQa+PgdvKPPrH9q1u5CL/uWfIcWX0
         BQfwgLyCLnugO3C8Gq06NnhVTcitsOPA2Rj1lqPpDXvbzB48aDV2j0i3PfQpBIVG36tT
         yI/xO+hW1JoptygB85h4vH2N4tIBAt5QH/v59BUtGVbjxFN//oqydGOW3oH3aVRNJzbG
         bHO0S6GTPKDweP7eMACgcXA/HNVdkg0fiUPqthHlE3wLjyLVFC1VyWNxKxNH3nYjpuR3
         w67XQm8htwupo/KbxGopPbdjiKt485vmrZ9jjYZNcpLb/yIulLHoOZ3kRSiq7vCD5fTt
         7awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779423; x=1777384223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otAA4GaVEF+mBHTbPlhtMA1OAFDFVDJuOvEPR/n5ijc=;
        b=VdYewi8LtFIDDqQ3/hiyrPX4kSPvBUE/FRpN18pI9UNCpfLpQmgezD8Rpq+quGbaz+
         0UFko70UZ+VNBSnWmAXVSgMO8SGnDtaVB9afbPy8DbicHZTXcIeLTy7TKsIatm6d1z9i
         dmaJr1nYyOCrrPDnk6AqNjAFWKI0nd0iITVH8Pszs711UQY9xP9iZoMNyFHPrB1ERc7a
         HHP8k3CyBuhzAI9LUa5lK4/YOABVDlIRtk4dNlCqdXuSxs3POPLTHJv5nrR2n9Y2orBG
         CHT2puZ2TBeXkeOFBYnGfyJ7h6tcU+oLQ8YXi+egT95EX7F71ClVGiVRzwHAkFm1LYiX
         BX8w==
X-Forwarded-Encrypted: i=1; AFNElJ9I4HsKPK0MEyUPAlfxOQlhE0yiU9Ehbm4UPQ8bJb1rVJfmgZTwNvptE7Hf0hrUJxXIYeK4S5tQATQbJ9DUEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw794sgwUTvII/KMvphqYhHfn5q61iC3iSbKvfOCTjcT1SiW3N8
	cFSEGlQG3+nT4dP7B0CebH8BfkR318+tEUOxOIxc+wHZ2l0+bN3k43E=
X-Gm-Gg: AeBDievSx4hnHQZvh2Z5bRv7R7+m1yUNNydLccWrhz8W5AGlrPOoeOn9ExlaeNkmbOo
	MNvAfeEZ/KdV1uREsBQD0VWXNstBkfp3K0WIR3GPnaJR+gFyotzu/N/NjfokANaeeI2wucDwnnt
	WcV0AVeWJxP76aGL11OvYkcWqE8MrSAeY1ooKZVjyqW+U8aD0B4Etr4Ih2qMri5VOfIyaRbmObO
	x8fBblGWe4K3UnI2hCT7AaVRc+3hpPV1cPfne6eKzGnUEMHZPpXRWWZbvsi2PUA0ZwrD8ytlLoJ
	OoaGOpB1Ht09xb6r3MLzZpziNLUtVuGGyFlaaAtO95iV1rZCgllVZsiQERIs4FwB2P4fMj/dfjH
	UQ0psa5QdilYU9FVayq9tnvLuJOZyj1NCEnv7j+8jGHkvlEq5Ikj4VMMHKFLeV6nqchdtsfK1oR
	KBsrsygsUgRwPddg==
X-Received: by 2002:a5d:5d88:0:b0:43d:73de:abd3 with SMTP id ffacd0b85a97d-43fe3e0bdd8mr27406356f8f.30.1776779422380;
        Tue, 21 Apr 2026 06:50:22 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a092sm2761850f8f.23.2026.04.21.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:21 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 3/3] wifi: wcn36xx: fix OOB read from short trigger BA firmware response
Date: Tue, 21 Apr 2026 13:50:18 +0000
Message-ID: <20260421135018.352774-4-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35171-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 8B78043BAB3
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
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/wcn36xx/smd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 2a0c946d81095..c0b477345832b 100644
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
-- 
2.47.3


