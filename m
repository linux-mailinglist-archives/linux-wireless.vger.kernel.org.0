Return-Path: <linux-wireless+bounces-37921-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AAuNOiQxNWqCoQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37921-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 14:08:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382A6A5980
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 14:08:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=kWLAJ09l;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=CNGELTas;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37921-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37921-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B793300F192
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D7368D67;
	Fri, 19 Jun 2026 12:08:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A66357D0F
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 12:07:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870880; cv=none; b=p9/0UZBdmJSHKUSnqMDynLIHjwkAsXG6F+CGuZy4pYLF0PSobDkjoNav8YG0DodVHS2BvT8dNpTINYax6uSu6o64uBRa4lLqJHHn6TdT+AlBp6kBaOmE9O9XbUolmm6o+pCdAyuS+wh+2VWxJ/nkciBMbcPu17mCXzxwtdgPIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870880; c=relaxed/simple;
	bh=7MouL3HqX9ECXrrVkc+lqVmYrDTMPglO2FxVU1mDDUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VSFv7kubC36eeSGlvw6zbowPt6VfZgs0RtSaM6Lfjc2TyKP4RUucvj5VixChiCu1nLDfVhPMmJUavU50wDT7PkyJzJ7FwUgmdMrxXwLMy5LPcOK/WAKe9ZlqKpcBPfkoqnSIi4t31CXM5c/6hDpSjd/7H1eKONjheXrqd9Pw3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kWLAJ09l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CNGELTas; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7PTVd3710158
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 12:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zgx9wN4RH5WyeVxVnM5MXT21ptHceSoyFLQ
	AA2pSnvk=; b=kWLAJ09lLu8+BuBzTeLlKhj39C8yByDraaboiCm5Xi364E7VClv
	IxDCIPzq4A4opb5jrmkQ5AvzXwKjOsuzkCPNBplbhXxJeWUkiI6ELtLqh2kTLDWb
	dQ1caKnl02Rpn4udBjDo97ORRYjGURDtywr5UzaryBNs96en2CX3emrN3lw3pxIK
	df6143VOAI0xB9BAknxzWOOhkO4RpIfjySxnGiO9T3RTRiY9ITcvOAnULP3W7l9l
	domo36uY0yV/I0dnhDWSMTmdR3JBXrkS+3SL2BAxf2JpM9bt0vY2Jmmh0F4K7lzS
	JnxBleGrhWisdZ+tmHqw5gKRO/QwPbZ0Tsg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6731ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 12:07:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c69f08f527so19849785ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781870878; x=1782475678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zgx9wN4RH5WyeVxVnM5MXT21ptHceSoyFLQAA2pSnvk=;
        b=CNGELTasqwobSUsiyRoKBlJxlyccp0CiCZ3MbOzXjbDtAWGuGw44nUmMSnvAAEsqEd
         7DX5ZMWG7NvnrEIlR35P3Ki2VF0yCDSImfq3UW92Jh3YJv5CSVYFcKlFBN/42ND7AUSD
         VXr3iQ5BQAqX6Wq8UZ5HcdwKMUUh5joPKTzyA2O1zLVRuTLFYE/hcNlZraSFL+ve1/+E
         EvFsGVckC1WguDHjbwA1oZawtIT8+o5T+qwIrWqsQhVXXToQQurHjoyNCt0utU188zAV
         PBA71vbr4gRsDGyiHEdTgMnKIw74pUgpYxx96K8uq9G8xkYLLtheewmTtQvl5AlgiAX1
         ugKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781870878; x=1782475678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgx9wN4RH5WyeVxVnM5MXT21ptHceSoyFLQAA2pSnvk=;
        b=T1HmaOtQPbPC8+vrXSy77Q47XXw/FzrVrVnxX3LRsNEUlSWSZg4bkFHIJodQ+6AqF1
         70PRQ/LUCZz5YB7Nd/xMzaipSFv8/8dNkDNmWrSfmW/Wk51zo/57LeOLWWypYLso0Z+6
         MuxNV3ZoOc1xcB/yONluCDIUia8l5J6Lr4HBuY5iNmcT0GCUwjM924HAR808jvqVFcgx
         E1OXlRTFFirjoB79j0VLJ6kyBcLuczn9+eN+GkLKBdPNdG4O9+aWFaA4guSL+E/BfYyE
         gUmhCjfYyDzacPfm/WOYY+kkuPed0oB+uTEs1o2RLujkCMlZGySuRW8wxjPGQiNGclS+
         wUNw==
X-Gm-Message-State: AOJu0Ywu+wSJ20L6q0WG01tZSNqBSW4cafDdEHWFEu2UcXohU3DvJmLQ
	WvKmTjeeExnqjPHd/BzMgXK5RQCvzwWBdYpxKx3uAeFd8HgjLlq7bh0ATo1jxEluww6zGINK63f
	O9CjrEjzoSSK3aRaT93fletxDE8ZW07ACGvpPd7Mv5LR/7BQXeLiPcz5gYOvBIFJEdgsRg6vahU
	oStw==
X-Gm-Gg: AfdE7clX2waW46KKfpQ+tbgj/x3FOxAc8+72zr8bQWUiMTaiAbbW1jlkfA7j1fho5HE
	N8vobXVHBhjR0P8RyE1nOMBdv5bzLESmP5i/QDUwAqPvTSotAaUSl64RU8Ssw4Fwq8YX9CtoLma
	dRusJlCcxGJmX+eJ+eFHqDJD5xotHWUyzfqBz/cp6Ii44w3WZIyOCltmrGnqExK9UzRK3WLwYeH
	ISVzLWaiE0hsQU2wWUfg4R97XDJkBEFubNV4u7paxVqZAEgI8VY2lt756CWzBsCcSOBJoc+a5Tb
	qn154Ylfl1klnT8FLeY7nUzWqOmsqzpXTuyBs/c60bEmAyGCRwGJqaO86TrbzFc2Ai9Y4O1lZAT
	yESSR9JL0adVENH/6UUdi+4T0++dyQ5Z5AMo9cD5wgBlz/qpzIs/H1meJ27HHDk8aBzDgNBjKCc
	groIn7BCK5Ycow5jMRyLedF4ka
X-Received: by 2002:a17:902:ccc8:b0:2c0:cf44:3b3d with SMTP id d9443c01a7336-2c71901af93mr36154725ad.26.1781870877762;
        Fri, 19 Jun 2026 05:07:57 -0700 (PDT)
X-Received: by 2002:a17:902:ccc8:b0:2c0:cf44:3b3d with SMTP id d9443c01a7336-2c71901af93mr36154375ad.26.1781870877329;
        Fri, 19 Jun 2026 05:07:57 -0700 (PDT)
Received: from hu-aisr-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208d67cbsm23004965ad.26.2026.06.19.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:07:57 -0700 (PDT)
From: Aishwarya R <aishwarya.r@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>,
        P Praneesh <praneesh.p@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: reset REOQ LUT addresses before firmware stop
Date: Fri, 19 Jun 2026 17:37:51 +0530
Message-Id: <20260619120751.363340-1-aishwarya.r@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RLl_11JlA6IsDdepFaSLQqdEBTfLkC3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDExMyBTYWx0ZWRfX2pshYJCOz8gr
 jHSXVrUmbsC5urSqqTrQxpnsadT5CbJsGoFm7IfBMrxC7vev2FJHIsleMZ1Q/bHHJbMRgl1VEsn
 HyAHoP6yKh44KbOWnN+YHNt/gpWnn8WgjVZZWhyIZMEEyzdRaJAr+5oELP05uRO4DLLjoMYER42
 jma/+dJAk1mhs32zP90TDa0A/lsbgki6Fs/JdaXfSlPPhBN3zTa05xH/fl+9EbOcE7qUnCfnORR
 My1g+qmC4SD7ACO4XkWzuRrZ2xdxNJf4meJcMksOSqkm8BL33iXsnlkh7cSlMHxWeFjNRS7rvDs
 2mr8QGsxHOmekUZ8G7XoOdhTzwxTvq5DNEIXH02giLXzsKUCebyVfW0eMn4CPzLyhxRbBm10A7z
 grHOcvOZI3uUvRur/91l4dDSZhlk7KpQh2Gh7T1FPiVjZWOrvICIFM7XrAcgaDZ3D994G2zMXg0
 j0wYrZX/l/ACpKz7xGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDExMyBTYWx0ZWRfX6AJTq37kLokR
 xX3Jld04no0j6v1hi8txAeMTWRnabvemWUIumqd+wAJ3sqmFW/ZpQCWO+vkXihF5bRPDeV8W5Ve
 IrmdTn9t5gZt89ANAUxKAAQgwHUSS6w=
X-Proofpoint-GUID: RLl_11JlA6IsDdepFaSLQqdEBTfLkC3E
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35311e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=id8SikcatB7TCbyXZYgA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37921-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aishwarya.r@oss.qualcomm.com,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aishwarya.r@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aishwarya.r@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4382A6A5980

During module removal, REOQ LUT cleanup writes 0 to the REOQ/ML-REOQ
LUT address registers. That cleanup runs from ath12k_core_stop(),
after ath12k_qmi_firmware_stop() has already stopped the
firmware (mode OFF), so the register writes can hit an invalid target
access.

Move the REOQ LUT register reset before ath12k_qmi_firmware_stop(),
so the registers are cleared before stopping the firmware,
while register access is still valid.

Additionally, handle the error path where firmware-ready setup fails
after LUT programming but before core_stop() is reached, ensuring the
registers are properly reset in that case as well.

On the crash-recovery path, ath12k_core_reconfigure_on_crash() calls
ath12k_core_qmi_firmware_ready(), which re-enters ath12k_dp_setup()
and ath12k_dp_reoq_lut_setup(), so the LUT registers are reprogrammed
before use and stale values do not persist across recovery.

There is a brief window between the crash and when the LUT registers
are reprogrammed during recovery, during which the registers still hold
the freed DMA memory addresses. This is safe because the device is
non-functional in that window and will not initiate any DMA access
until firmware is restarted and the registers are reprogrammed.

No functional issue has been observed so far due to this sequence.
However, this change proactively avoids potential issues such as
invalid register accesses after firmware stop during module
removal and error handling.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Co-developed-by: P Praneesh <praneesh.p@oss.qualcomm.com>
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  5 ++++-
 drivers/net/wireless/ath/ath12k/dp.c   | 14 ++++++++++++--
 drivers/net/wireless/ath/ath12k/dp.h   |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 742d4fd1b598..efe37dc91afd 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -708,8 +708,10 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 
 	ath12k_core_to_group_ref_put(ab);
 
-	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
+	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags)) {
+		ath12k_dp_reoq_lut_addr_reset(ath12k_ab_to_dp(ab));
 		ath12k_qmi_firmware_stop(ab);
+	}
 
 	ath12k_acpi_stop(ab);
 
@@ -1371,6 +1373,7 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 	goto exit;
 
 err_deinit:
+	ath12k_dp_reoq_lut_addr_reset(ath12k_ab_to_dp(ab));
 	ath12k_dp_cmn_device_deinit(ath12k_ab_to_dp(ab));
 	mutex_unlock(&ab->core_lock);
 	mutex_unlock(&ag->mutex);
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index af5f11fc1d84..fbc0788b37a0 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1097,7 +1097,6 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 		return;
 
 	if (dp->reoq_lut.vaddr_unaligned) {
-		ath12k_hal_write_reoq_lut_addr(ab, 0);
 		dma_free_coherent(ab->dev, dp->reoq_lut.size,
 				  dp->reoq_lut.vaddr_unaligned,
 				  dp->reoq_lut.paddr_unaligned);
@@ -1105,7 +1104,6 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 	}
 
 	if (dp->ml_reoq_lut.vaddr_unaligned) {
-		ath12k_hal_write_ml_reoq_lut_addr(ab, 0);
 		dma_free_coherent(ab->dev, dp->ml_reoq_lut.size,
 				  dp->ml_reoq_lut.vaddr_unaligned,
 				  dp->ml_reoq_lut.paddr_unaligned);
@@ -1568,6 +1566,7 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
 	ath12k_dp_rx_free(ab);
 
 fail_cmn_reoq_cleanup:
+	ath12k_dp_reoq_lut_addr_reset(dp);
 	ath12k_dp_reoq_lut_cleanup(ab);
 
 fail_cmn_srng_cleanup:
@@ -1627,3 +1626,14 @@ void ath12k_dp_cmn_hw_group_assign(struct ath12k_dp *dp,
 	dp->device_id = ab->device_id;
 	dp_hw_grp->dp[dp->device_id] = dp;
 }
+
+void ath12k_dp_reoq_lut_addr_reset(struct ath12k_dp *dp)
+{
+	struct ath12k_base *ab = dp->ab;
+
+	if (dp->reoq_lut.vaddr_unaligned)
+		ath12k_hal_write_reoq_lut_addr(ab, 0);
+
+	if (dp->ml_reoq_lut.vaddr_unaligned)
+		ath12k_hal_write_ml_reoq_lut_addr(ab, 0);
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index f8cfc7bb29dd..9b39146e65e1 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -701,4 +701,5 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_dp *dp,
 						  u32 cookie);
 struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_dp *dp,
 						  u32 desc_id);
+void ath12k_dp_reoq_lut_addr_reset(struct ath12k_dp *dp);
 #endif

base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.34.1


