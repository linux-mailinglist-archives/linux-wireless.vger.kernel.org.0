Return-Path: <linux-wireless+bounces-34842-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMqDJZUR4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34842-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:30:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E565C408A91
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E824031BA4DB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5352C396D12;
	Wed, 15 Apr 2026 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssOjvuQM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29AA39185F
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291844; cv=none; b=pD7K2oXCpPzEtV89iNsYD0OO+WJqWn7oIRaGELBq/AFORfOEnMu9yq61PilKu24w0AlhmWotR1/DtYmtt3irbLWMiDRC3WrU3BnnZF+nTaNvjkV4olyGOaCfLZMRaJpLB/6LIKTyaA8zgzsytHeROgkuEg4/ulaY71MoHVcU37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291844; c=relaxed/simple;
	bh=K5/5QhY4iA7Fokua0uIgpTteAtMxD/nGLZBdF+03f3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljo/d51VwNBMYzuT2MU3lVS22o45qgzxJUG6025mbnqtGFSJMQmPRkDCqAKAuz/EmHHCE5DtpPBCm8yJniPHqSSj5oAUPqALGR6x6ZkdBROlFfeyqJ/CG5G7fkT6DMMCvBmLpts1HzDm8dhzcD+SQdmHmNFvDRumb1clPYE2Pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssOjvuQM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cf7683a28so4949319f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291841; x=1776896641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx4Rou8M2UzACrGE3Ykx0KL5iaINii3pzApwfXM1kO4=;
        b=ssOjvuQMRBjDsGoJCXW+hqhFlkTVKvjxRSQVzix026fK9Lu/2chYwebCFzDapVIoRw
         jqWxdiQfuqjicFHTlmWD4xAkynj9RCJxmtxP8fnC9umd5bQCBIaZJcelKerAGZkN6ZrL
         q+LPEgFveyorplNtpZASBnoQjqqETS3+z+B19ARevDwXRKHJygeTChg+kBAaGG21u8+N
         izatvMfsWYxqY7tT3VRZCQjP1aH+GrPpyP5OiJKFkvJixwcN4uptiJHGERy0dLIWLjVT
         4DQ1QmkvEI4kPskoCWXuIkJbwNXstSqIeYyBcG0OkFllS1biP2npkAdgO0eeeGOkGtUL
         27/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291841; x=1776896641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rx4Rou8M2UzACrGE3Ykx0KL5iaINii3pzApwfXM1kO4=;
        b=h33EgTDI3M76D+tEDTmzZxYK6CPY1qhay8AJVzEcC6i/hLCSHleisq4QCIULy/2Hm5
         E5lqS396nsSQ5jgh5MTONPk0jDvJk7pKhpzjPpyDcLuoxO49lRcvgIefrL/Ly7jS+/AO
         3ivsQVGDH56sQZFr0OcQWzvtc/pPy7kNwP22NgoTOpULkV0Jj81nUKnhwjhGygr2dqo1
         uP4K12TWXq6bVdPDoksg1oJzt+xwk8NpXvfIzIzBFv8SbWHT3gzjYFgKhCqQyRF/Qk4D
         ZYJehddjOBPIAqLwsZu3QLDNGvUsL7fCyXyMcaEBJDuB+ZvRTv5ltJ5XGCWlCflwkUS9
         OnEg==
X-Forwarded-Encrypted: i=1; AFNElJ9WbGIfUQRdvFiSGzksqkYlK8NFT0T7eubpfhMVu5Ssh0//CNZAGSo+zX0l2lLmY1SiCigCvsUNI3Pc7jiOFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBWHT8DZg2OzVF07EJ79rugakxnkjEhE0IiDKehudCNCpala7
	Yl9/mNEcUS1AUoU4jL6u2mXxFoia49jC5mTFDioiokbhzKiFS3t7z4M=
X-Gm-Gg: AeBDietQIUUF0bC1NCZBv4WiuA0KSbrpF4QRdZYu3fRKfPPJN2vCJbMS860u1lu6qzy
	/0OpfNPMpE2xDCIJ6OU09vsFuXsmdpboPE/8eyjUf6t9bR+Nt4FO8VtGuCh1HmDck1LQHVh8lEQ
	y72Yr3jYyhF60IobiWOpQoORp6zKhv85PTlJzxBcuk7QcwtD+OKS6UjuqEReIFdO+DEayisI3We
	ywCIeDJdcRocHA3dTvFJLfGIbSPFMXdW1eeHdiCWHNT/aF9s22EQYWaNdsMgIsOYhqv1/ixOg4U
	o2NQORP4ps57S4cW8ALvi2dHlb2aRdts3S/gFGb+0mH8lFpde+ByLD84/ZlzA7opTIpGvjFCVeX
	/TXH2PdhxI0osrGqXz8lZ0NnTd4GH+zn+79WKxbCKUAeSnBaPR1OVA6FKgKmb1LgC/UXNsqAp2J
	nrDBM=
X-Received: by 2002:a05:6000:1207:b0:43e:b0aa:7311 with SMTP id ffacd0b85a97d-43eb0aa7369mr1599135f8f.47.1776291841207;
        Wed, 15 Apr 2026 15:24:01 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3dfff3sm7613861f8f.26.2026.04.15.15.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:00 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/3] wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
Date: Wed, 15 Apr 2026 22:23:56 +0000
Message-ID: <20260415222358.1541983-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222358.1541983-1-tristmd@gmail.com>
References: <20260415222358.1541983-1-tristmd@gmail.com>
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34842-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E565C408A91
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
drivers/net/wireless/ath/wcn36xx/smd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -3296,6 +3296,11 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_ADD_BCN_FILTER_RSP:
+		if (len > WCN36XX_HAL_BUF_SIZE) {
+			wcn36xx_warn("HAL response too large: %d\n", len);
+			break;
+		}
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);


