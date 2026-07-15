Return-Path: <linux-wireless+bounces-39129-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LOo7GYQrV2qCGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39129-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:41:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA2F75B28D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:41:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c7vEaGNW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39129-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39129-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AA063031DBB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E46313283;
	Wed, 15 Jul 2026 06:41:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A220ADF8
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 06:41:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097662; cv=none; b=Dp6ThQArL2YYESOmIGtaE1HYf8B4zgBTnfD7GLvOi/19rV5rkyuvSZTYzIlzZT1JOvfN8ySwVQJ1JuVQLbfQpNNmZWQiT/hgRdJnYAybuQg7cxLKWnKXW1thK684/uXH9QJDkrmqeCsYfZwtJ8ES1XeueDTgy42WWjQ4R/xAZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097662; c=relaxed/simple;
	bh=h5BFxK93+aSnNy14rKckWgOePbkl/k1HqzJ+gAWCAEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrJGqti3rZCrVUUOYRtmLrxgDWVwidCg1NgqP+/k7p8TqTsPa+NkdSLwb9BDF7jZn8lizujbIABWM7ZFSFsmLbHnGd46NVkTTn6zryyhloCQpSHH/YUXVxKKdECYuEcFkVZaaMWrCXUFy1ywxd32NMVEiALJ3tIJ+DKFdcgws28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7vEaGNW; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso3569528b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 23:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097660; x=1784702460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oeq61mqCq1QhzXC9+NpA6dqzmbivhALns06QC0nTUSk=;
        b=c7vEaGNWFLChVcnbwEJ6muypj/W2ehTIfueMqw6eGq3dsfXSkBFprnmsz2F9SLD5ch
         Vdn0RmsoBjLAq/kDuwtKYesBCfozxMVw5WtWlkHXfpiI1yrgnm15rPsdp+PNg4WTQKha
         DVdBnvjwPobZlwEgyM9+jmQxb483mLpNevPqDj2FHYEF0SMTsO30jA9F4PxjrgFmGdzJ
         Par7f8I9TC6dgcCSQ5NYXz2JMBelBh7AKkXzMrGSv/ZKUykACdreX8BOJs37sSEESFuF
         Z44FPj4wmLS5evNrXZeDkJYTcwMI2IbLAqOKq0gmvmHEm0FzO8q7hJpxZfiSS8Hygraj
         ovjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097660; x=1784702460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oeq61mqCq1QhzXC9+NpA6dqzmbivhALns06QC0nTUSk=;
        b=OyrUwa7p+JnHomgWuWRi4MKkp/ksbZRr02lkNgbpMRQZTTm3DKuIo/bdrOZBwIWbw0
         rkdbPwKl0JWSA/GLmfi9J596R6NxBI1P/YUS4r4FhgISO6djW77ywYs4QHLIxvXJy0si
         PGgGDrMFmL1eVy3XDJs47LAReCGRwJIPqXWB5xxLCY1qa37Rh/57qmsdN8khWBNMrTLS
         JcUcq4O0FIeKhsBNw8V1QmE2Bw+uAdParV+Vy+96LdvkA34/psgGXZgUrKR4VvAE54zB
         3oSWaQVXNRezjM03qkvhNsOtlP5HCQGCPe4yMVo3UKWJBEpBYK+RD/a0GwZ1QN9p3o02
         Jw7g==
X-Forwarded-Encrypted: i=1; AHgh+RpMr/TID5o6hCvIhYo2u1YvMUOQ1tlW8gi1YUV+CaDr19XOm4z2GWs4w7MOEF7+kS7WDBUzVoBUQUqSxFhR8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsl/Wxr6krBWg6ZdMArGJyeI4uYiCUbK8yKkNWrCqELGh1aMn
	l5fwNpbU/kfO57bkn5UO4vGZFAoKUU2TSCznS7bOgXn80hstAivjWwmg
X-Gm-Gg: AfdE7cnMt9/tQ5eBzyAQ1PHf4Xe3Vuuyz+m/S/xyemRThVVuNxg5T0wTDcOQnOsz1iC
	fk8fiU5Xzt3XPgmimecmPQ960Rn4pzVHpcsJtVz01a129Lk/KGbwUcs1qTSqRkctdZKRTNdFsq9
	6pEjCdUPFN8KeuROIwAs0XjeRgE/gi/EzlXYKCoOm9z57hwxuLtHo0qpOUl2J/VCKVWXZIj7QGA
	xHh81YAwVE/vDG5kfbFtdmWLgxX7/93hTnXXmTE4hQsNFJg0RXhivsX2BigGPFaR84ULzU1u/Lf
	8AQwsGH6WbdwAVYjmXTA6j0UOKK8z+yg2rJoUYwVY7w/NwLZ3bNyriZdfnwHqG+LZ72T73I/t7Y
	j+UsshOgvxJ7Ug/WZTsMZ9BVOlWQjz6cG0oe+K3+ZScf21pEr480Cne5HFH7I8vJtdbFfknIw6e
	i6qg6nnGyR6A==
X-Received: by 2002:a05:6a21:329d:b0:3bf:77d7:667d with SMTP id adf61e73a8af0-3c3573b6069mr5927585637.28.1784097660214;
        Tue, 14 Jul 2026 23:41:00 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca79aff904dsm9138269a12.6.2026.07.14.23.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:40:59 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Anilkumar Kolli <quic_akolli@quicinc.com>,
	Sriram R <quic_srirrama@quicinc.com>,
	Shashidhar Lakkavalli <slakkavalli@datto.com>,
	Kalle Valo <kvalo@kernel.org>,
	Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
	Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath12k@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v2] wifi: ath11k/ath12k: release QMI handles on late init failures
Date: Wed, 15 Jul 2026 14:40:42 +0800
Message-ID: <20260715064042.1988288-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39129-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:quic_akolli@quicinc.com,m:quic_srirrama@quicinc.com,m:slakkavalli@datto.com,m:kvalo@kernel.org,m:quic_vnaralas@quicinc.com,m:quic_vthiagar@quicinc.com,m:baochen.qiang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ath12k@lists.infradead.org,m:lgs201920130244@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FA2F75B28D

ath11k and ath12k initialize their QMI handles before allocating the QMI
event workqueues and registering the service lookups.

If either of these later initialization steps fails, the functions
return without releasing the initialized QMI handles, leaking their
resources.

Release the QMI handles on the late failure paths in both drivers.

ath12k_qmi_deinit_service() uses ab->qmi.ab to determine whether QMI
service initialization completed successfully. Set it only after all
initialization steps succeed. Keep the ath11k assignment unchanged
because ath11k does not use it as an initialization-success guard.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Fixes: 088a099690e4 ("wifi: ath12k: fix error handling in creating hardware group")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Set ath12k ab->qmi.ab only after QMI service initialization succeeds,
    as suggested by Baochen Qiang.
  - Fix the same late initialization QMI handle leak in ath11k, as
    suggested by Vasanthakumar Thiagarajan.
  - Drop the Reviewed-by tag due to the code changes.

 drivers/net/wireless/ath/ath11k/qmi.c | 10 ++++++++--
 drivers/net/wireless/ath/ath12k/qmi.c | 13 ++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 410a7ee076a0..6e3f82169d24 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3329,7 +3329,8 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 	ab->qmi.event_wq = alloc_ordered_workqueue("ath11k_qmi_driver_event", 0);
 	if (!ab->qmi.event_wq) {
 		ath11k_err(ab, "failed to allocate workqueue\n");
-		return -EFAULT;
+		ret = -EFAULT;
+		goto err_release_qmi_handle;
 	}
 
 	INIT_LIST_HEAD(&ab->qmi.event_list);
@@ -3342,9 +3343,14 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 	if (ret < 0) {
 		ath11k_warn(ab, "failed to add qmi lookup: %d\n", ret);
 		destroy_workqueue(ab->qmi.event_wq);
-		return ret;
+		goto err_release_qmi_handle;
 	}
 
+	return ret;
+
+err_release_qmi_handle:
+	qmi_handle_release(&ab->qmi.handle);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index fd762b5d7bb5..692f1b2c2031 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -4041,7 +4041,6 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 
 	memset(&ab->qmi.target, 0, sizeof(struct target_info));
 	memset(&ab->qmi.target_mem, 0, sizeof(struct target_mem_chunk));
-	ab->qmi.ab = ab;
 
 	ab->qmi.target_mem_mode = ab->target_mem_mode;
 	ret = qmi_handle_init(&ab->qmi.handle, ATH12K_QMI_RESP_LEN_MAX,
@@ -4054,7 +4053,8 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 	ab->qmi.event_wq = alloc_ordered_workqueue("ath12k_qmi_driver_event", 0);
 	if (!ab->qmi.event_wq) {
 		ath12k_err(ab, "failed to allocate workqueue\n");
-		return -EFAULT;
+		ret = -EFAULT;
+		goto err_release_qmi_handle;
 	}
 
 	INIT_LIST_HEAD(&ab->qmi.event_list);
@@ -4067,9 +4067,16 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 	if (ret < 0) {
 		ath12k_warn(ab, "failed to add qmi lookup\n");
 		destroy_workqueue(ab->qmi.event_wq);
-		return ret;
+		goto err_release_qmi_handle;
 	}
 
+	ab->qmi.ab = ab;
+
+	return ret;
+
+err_release_qmi_handle:
+	qmi_handle_release(&ab->qmi.handle);
+
 	return ret;
 }
 
-- 
2.43.0


