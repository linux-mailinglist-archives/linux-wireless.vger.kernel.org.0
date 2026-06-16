Return-Path: <linux-wireless+bounces-37830-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gkUCMezLMGrPXQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37830-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 06:07:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F068BCB0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 06:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=o8uMOSfU;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="Y38/RZHe";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37830-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37830-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49AC3304568A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 04:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4053C1414;
	Tue, 16 Jun 2026 04:07:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD013777E
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 04:07:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781582823; cv=none; b=pRXLq7IEHQMm4tRMUPMK4XOBIFjhSBF4qsuXNzQGrFGY7rdcAKmNKdskN+f3q1x3BuVORPvVwLbKZmzk9yJdzkK+kH/0s3reL/hwM5Fxk+89A5TNQG8rRCNWgrnqloJ726nISNO8eTe9HgIlJjShwYqI8bef7KxF0J/tEjIJkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781582823; c=relaxed/simple;
	bh=Fq6VXLZv8E3/vjVVMYjP1Kl3oftqMPl6/w0L9tQ7PqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQPXAu1JNv1bHeBbkqinSWoRED6qCV49chlYLKrAL91sPFuksIYr1i12A5XQBi7bT6Hj6ZOJbhsB9Rf2PRh8eNVy1Hl2eUcfLtxg7w9mVnxJVwkhTKWexbheXGr+gVCvw/bIFL1QCCY14R7j+f3TfkHlRO1LEkBzIafjupo4IH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o8uMOSfU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y38/RZHe; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G1xhxk1690548
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 04:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fiRe7kfcXarbpaCK1YAHjPNf+dPFJ1apoza
	dLg+YPHU=; b=o8uMOSfUVKFJzrURJRANv58cusXzAxTH9FmVZNVPF8kZw2AGxH7
	s1vkj2ytie4pZV+XflRFDbVb/R7U2p2SCayE8ucL/TAem3bsZvrsdVVAW2mVwyfI
	iODyY3JeQATt53pbhsP3vU/JbQL5SNa2HKyTt1qqenAwmeUWPadjKoA7aAUDC/ee
	tXxYu7NAOZmcxRIYLJbXC2/WlDueSjP81YsLdyx1kMYnEOpW7J6fUBHgK3qsPPxg
	1CECTCNR1/DuqRqqYBRe23siunaS28DGoS8heCGZECRWKQe9LqVij5AqS2l60ZrM
	wLQKCcfdLXzMyYm3OAisUArvO4if3LvuGuw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjvpxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 04:07:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d97955899so3950937a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 21:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781582821; x=1782187621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiRe7kfcXarbpaCK1YAHjPNf+dPFJ1apozadLg+YPHU=;
        b=Y38/RZHeLGVwUA+A3EvbCXuTbNE8xWMYiGpbbtiyKhpq6Evo8F06jUCgSDDWNxvkq6
         739uaq1Qvx3HQ+uZZXOzf/aaTb51x4J3PSRZC/ulxFlWnngQOgLWnC+O4dTLODr+efWH
         Ar6n4ZTHPgv8IaQpdoPC7LUnNufXdhw5yTj9bpExmR5WAQIAVimiH4GQoCYlGSIghukC
         P/RGsRT2hZ75FhwL0daMrEO1zQIiUzZ6QOd8XecyAXyMOJ1HfjxxyCZXEaoy/tTN7e/y
         anV2vqhS80sxgXSqvDjykNASJHU3VdOWdelTiHXFmCYrb1y+M61e8Iw4hHDEqJSAk4DC
         fktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781582821; x=1782187621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiRe7kfcXarbpaCK1YAHjPNf+dPFJ1apozadLg+YPHU=;
        b=qXF2UhQ6r20IvC2SOKsU5JHRs5kA0bPjvhkDDr4sozv2DjmaEFZd8kKhuR68PLYig1
         rhONHqBfAEoRDJVMqlso6+qwPqZ2E7GJI7FpYseLw1xofqTSp0p7qOZGj0GwMJgNoktR
         IuczlebyYX/F68gOiol9G95YpX1FMotBxI70eQjzMuKGc0ElrD6HQaBGLpP4hrTrEz/o
         RzT6XE4E1FLu3bgUuzc8mCBJSIT3ifgTqRDEFK98CvfKLemlj9ZxeZjpNzVDbew07STE
         VOxdVH/seggR6tZWBdk3zSgbehMfNhXqkosoESU2mzvT2N2VH1Hi8J4olI964VxvKheO
         yGqQ==
X-Gm-Message-State: AOJu0Yw0MH5K7olxGeQ3aNDGnNOpkelGqwKEKO96LESIRxT0DyevwWmW
	YtbOLZPtAW0gEAWF+IYa7goxjrqF6z4hQxgAGPUw9C6plq3oYsKtgdZOeOALumB4dR5PrEm15r9
	wHpjSpp7XyoTq/qvAsdQ/m2BAL7XbTxGrkUUT/tq1UcnHo4htRECM0TS8INZBKXW+K9LRjg==
X-Gm-Gg: Acq92OHf06jTD/vPaK+dMck8zhmvxAWNnauEPViHB5dUO7hOkF2NMG0ojfOcOBqhlra
	9BgndJfZ6bIZCEWnbK7i7mhKCzqOJzusgBob6fFWWuBqaGb28mLA+34FhbIE+yka/hTSI0lLEwa
	9+cYxjf8DxZd23PzJ/N40UKYMqfQKmDB7ywBJ2YMrib+JqWCO46LpxqjAwZv6dxQHiQYCasQRMG
	tljCfdYYEjqWq4icW72EqtNKSIF26gWMRh0+cVDNF/y9Neh6HBP8lJCg16GeEZgizESR6Qhfiyg
	WTbzjZn10VCENfMOb1EzufYi2SJb7uk5AcQZsAWuSYbVL5mR6EDh1mNjX8N22S3dv1XLIHypDT+
	66HgGfvZkbfH2MUW2bVN0S3JKwWlZ8BfBh0dyKlYZDabhERM1mKdUh0KOqebQNRMRTXrWmRocJq
	YlrUXX3umhCuHjnnSRdTifTjLc/TOZ5gzQuCSUMiov1EF7
X-Received: by 2002:a17:902:ce07:b0:2c1:6259:cda8 with SMTP id d9443c01a7336-2c69a1f4063mr18929555ad.25.1781582820987;
        Mon, 15 Jun 2026 21:07:00 -0700 (PDT)
X-Received: by 2002:a17:902:ce07:b0:2c1:6259:cda8 with SMTP id d9443c01a7336-2c69a1f4063mr18928445ad.25.1781582819234;
        Mon, 15 Jun 2026 21:06:59 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432f77479sm118045415ad.63.2026.06.15.21.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:06:58 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: correct monitor destination ring size
Date: Tue, 16 Jun 2026 09:36:53 +0530
Message-Id: <20260616040653.3985702-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAzNiBTYWx0ZWRfX8EozcjeZ0DAa
 uL8kmUDVsZrgrHip8oKgIUzUvdn5REVN3xIj0SO3Edlma1DckuSl6pvXSneTOx7PqmYjeDVW3rZ
 inRDZqpmApStBbveWAhqO7SLyVTdnnJClN7NtaLKWRCfaPt1wPqDKnqfgYM8bdtmD17GEsEN+ga
 fUvJtDWHjIs4bwoyFHo6g0uHh2G0EcDjCfVFVzQmrq+IUpcrAYj4N3NGLUgFeW/QElXYP+RP+Kj
 KhJWyrN3dS8+Cw+65N+Zpop6/4lsIgn8eomXCoJuv9DQhgexDLWaRqI8E88Ucjwdj7ayldICdAf
 EHDfh5RwHCaSDhpi+ZzJsnt9jg0oPThE+w+8He2SE6OVRNVyQYDofwdTFSG1/q4a4ErN3ZUZTNu
 H5syfk+8y1eJeRPsnpZ7KVLdEAKKEN2kWbXv4oBg/zN0R6Ntyw0oxkknzlLfro3Dbi1rxGhK1Le
 kwcaFRjTWpkG2GTSl4Q==
X-Proofpoint-ORIG-GUID: DDoHu4nnPm42KX8_o0qPOzN4cSHik3B1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAzNiBTYWx0ZWRfX/XJfve7A9mIf
 V/Go02X+Y3SE/VyC1tlCOEBS9hsbDl53kuv14bY70m5zewJFyWmKrBCXE80mXoHKC/hEff5VL8y
 Z7+ZBsRgG7Piuoly8vBwOGGFXZqE928=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a30cbe5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=b5TSSxGLzCK9vQyPxlUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: DDoHu4nnPm42KX8_o0qPOzN4cSHik3B1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160036
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37830-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 270F068BCB0

The default memory profile configures rxdma_monitor_dst_ring_size as 8092,
which is a typo. The intended value is 8192, consistent with all other ring
sizes in the table being powers of two.

Correct the monitor destination ring size to 8192.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 742d4fd1b598..b488bd8fea9a 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -49,7 +49,7 @@ ath12k_mem_profile_based_param ath12k_mem_profile_based_param[] = {
 		.dp_params = {
 			.tx_comp_ring_size = 32768,
 			.rxdma_monitor_buf_ring_size = 4096,
-			.rxdma_monitor_dst_ring_size = 8092,
+			.rxdma_monitor_dst_ring_size = 8192,
 			.num_pool_tx_desc = 32768,
 			.rx_desc_count = 12288,
 		},

base-commit: 83f028be15fe071efbee8e27837538d6cca77e87
-- 
2.34.1


