Return-Path: <linux-wireless+bounces-38322-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XOQaCVdgQ2pgXgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38322-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:21:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F656E0B21
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:21:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NxiFvEiI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="Gp0L//14";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38322-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38322-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74B7A3007515
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 06:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B73E3DBE;
	Tue, 30 Jun 2026 06:21:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BDD3570AD
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:21:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800465; cv=none; b=UOg5uJJpNxeDfL+6Hyisgwi9RHgo6D7kSYiFGP5WZ1AYs7dzJoQmrlS3E+Rd6i456gTlHxis6sf8785lNXat8N9oNwKtPicG8NNMMYyIplQzNgKyB7zFNNyO1d+u+i6qqwCHzqCO1Krj/etDjcamWwtC2yGwvzNmCXj0K/gL0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800465; c=relaxed/simple;
	bh=s10i3BXkDXtWMzGpsjlJ4v6Z+51MuGDV9xzVv9Y+gHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNLyfZZSKqZwDj6yXCR1qrfijbrtuMo/EiiwSr+ngawGP2F+iqRf3VzIBvuGYr3XF97JdGL/hJVoF4LizehbrrVvNUuxCp4C/3GjW9OtCqg7zclY0FJs1AJMQoOm4e4m1AMeBUTKimbTTieDuRGlOxgoapZqhP5lkx2fcMQzTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NxiFvEiI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gp0L//14; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CK4B1088655
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cVuhi7J4Q2I
	GUBXUFL+C2F/k1v1kbFtd7h8qRD6g0Ys=; b=NxiFvEiI2flI4xgaVP1z08et8eS
	6io0SzcplPWnXS4BPeV7PVdei0/xk8ih88Cr2b7Mi/D3KAq9QnneD4tOFkHlQANE
	CW0lIFkhhfljGxbZZO+v6aXDYQjWJFChZeCFaFWUkUA/jhtOgLTk7VcZjQ8Ykhc1
	A3OLyShHF9LYPA8PUlkAJdiTs5XvO4EqKXLKLFRrVsoB1g5NfOUhaAhCac4N2Ce6
	uXrdo6GeGu4BgU6YW21Hdp2do324fLWfSFSt61E8FYLkXyvqT3i+4sxYLFOZi/rq
	XcsPBR81PaIRqsvWGimCj9Ttgtp0FeHWKLYL3lkR2bAlNWsjtggNRJjg8qA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fghqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:21:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c9b1b608e2so25732075ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782800463; x=1783405263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVuhi7J4Q2IGUBXUFL+C2F/k1v1kbFtd7h8qRD6g0Ys=;
        b=Gp0L//14e5H4tQrHwcZrdqXNochA/MdN/xYl7j9KNAjJkjO1lO4DqXvHrGgQabgYkY
         y1xxXgZtdStfW1Wavhug5Om95FjBlHpfcX4+OlWF+TKwNT+jqEJHffx+5v7qjHDiC4N3
         e6/c+/lNqAWD3f5vjb82M5TVEXkvo24YgT+w0H05TeOvZwbOEsHaOODPUyFGoqCAVkEi
         XvNVBtmDccWDzUCEA5geC09tj/yXdLOfUU64Kyt5oP+BbloJUP/2nfvOiWo2lSvHx3va
         GvNegItxoJHfMvjI7Zek0TFzbNIIfJyJk5JslM3cZPoHFmWYY4f8qRhADFT/cL8ECZAZ
         5PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800463; x=1783405263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cVuhi7J4Q2IGUBXUFL+C2F/k1v1kbFtd7h8qRD6g0Ys=;
        b=K5lR6Bo3koV0i+JLjC0QNoU+4QBVJJGN0juvfwIuOuKxqNCRttm/h/D0fTW9WVQUe6
         m0SWaB3gpokxNXYT5kc7UrMv23KglbNYoEiOYpNOJasWCFSZ941YaLriw1T7+gcm9p+w
         OG4J96A6O5399xmBd3JYGANNw35+20quMuEsIKZex4KIUhk6zqLXZDVc+sqf0RLet48L
         oaGy6kkNC9HbFBqcoL6JIUOvDAJCcOdoynR4DtKxB8FoRlgghSX1f6H5p7/vXUQiI2Vg
         iMOLwioY6M4OKxMBiFkMjDKm7f/dykpBGwEsFfqNt522KrPtOREBq98jD4vHlucDMHtm
         fYFw==
X-Gm-Message-State: AOJu0Yz3JsGm798WHHawwQiOvxNDA0Bv1hIqfiOIoRli3VbGWWcE6Uv+
	nRvwxEs9KmqCz78NyWLnsu/+L1wI9GelmFGaSqtx1GBbFbKaNJFaHIc9B5Y4rlMXq8kQVHd8vOO
	o2zP+978YazpuygmEvM7XWpfqV+Jb/SPQCHVGT3rghIaLdmCu0h1LRb9H/iblyHO29NBYIjjRuW
	AjwA==
X-Gm-Gg: AfdE7cnq2XD4eXZoN0TJ72PWQQ/jgWorbslBhjUfeXcCU79MXXH2ZePuzsNP0VY1g1i
	GPZVk4UdGs017L8gwu5jo1aHdgoV4Hhnr/bwEi80GZRmEDF4HuaGRzv8PZ9Mz/a0VZg5E0zytab
	8RhE+KpUOfjh8DjWDctomsAQLkVbwkG8YKj6rqyHx90dnrdZOnk/tZbm5+LG5bUIwW+6+2iq6a4
	DGII/ZxTArOFHjCXZCAO/VjCfw4jx+ZorKjiMx66oWgO+YRHexp9iy2fdDP7yWJ7Sb66JQ2Ah2I
	bDSljlDRipN7H2a4g8b/FYGPlkj//bI0r0GPGTxyXdswWL+DB/gVZ+DeRLy/zDReKLGZNJS4wUs
	qIvpt3z9ncw7AKLLpAz9fzjzqJT7/fxZOam1k5TYVnUI88ktkiwbYV1FHM0ZHdwvYVqO3jADBzO
	KRxmY3lXM4BiRO2iE17bZnEzNZaId2D26Bog==
X-Received: by 2002:a17:903:1c7:b0:2c0:ab82:6bb8 with SMTP id d9443c01a7336-2ca2d8a615fmr17660255ad.27.1782800462660;
        Mon, 29 Jun 2026 23:21:02 -0700 (PDT)
X-Received: by 2002:a17:903:1c7:b0:2c0:ab82:6bb8 with SMTP id d9443c01a7336-2ca2d8a615fmr17660095ad.27.1782800462171;
        Mon, 29 Jun 2026 23:21:02 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382d0d22sm6413835ad.80.2026.06.29.23.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:21:01 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next v2 3/3] wifi: ath12k: allocate HOST_DDR and BDF regions after Q6 RO region
Date: Tue, 30 Jun 2026 11:50:48 +0530
Message-Id: <20260630062048.1615178-4-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630062048.1615178-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260630062048.1615178-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfX6TaXaEfOeru/
 lsIc40HaVlsciO9vex59EX64HEdmgfAGHe3DTqcqM9lF9GU7LcUuI7iTa4+xKptDxMTWQRHDnDm
 amteTvYUJpklg2xaB//vKjlwNSv5BMGvoqar9fSQBcboh+qht3pYX771bm568B6uoLv4LZz1338
 97MxOsXYEjwIY26niyMc2viMmczXwU89/ac/6w6V0fbbN+yTVR1uPquVkuYaC5O4Djyl4lAf02X
 ydHf+spzKSfi/ZXkuVctMBBNh/Wk9oFZeOAtqMbIXAUfTcvwGZJndjHYEkPDZtU9o5tuaGFjxmT
 pDrzQ9fObAbtTNXGbduprMp1+pbC0SUX7h8ulSFssRypG1Suiil6hiPCxYcg1THm7kWXRlOD5FR
 NnUBIuSY1A7xmraXqaBdhI2w/TaQJ2eNQiOORyIAtW6Q1O7qAOcDpF4a5O6OteRVp2HqxQi57GC
 ao/lYpG9daBSHCAalOw==
X-Proofpoint-ORIG-GUID: Ytyl6bfT_lIdQWv_huSKqwBUcfJfO8T3
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a43604f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=o3RYbcsCsqBjKZiLPF4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Ytyl6bfT_lIdQWv_huSKqwBUcfJfO8T3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfX/idjJxXSWchS
 WAijQpd8eLmEcK9P9Zzu6JELKuEcEVFcUz24vKx2Taej3wwP3eE2Iqk4FfWNGrfB9ZLXwVpxe4v
 S3x428BXbqtk72eyFbrE3+LuJRzZcpU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38322-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,m:rameshkumar.sundaram@oss.qualcomm.com,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05F656E0B21

Currently, the Q6 region contains a read-only firmware region along with
the BDF_MEM_REGION_TYPE and HOST_DDR_REGION_TYPE memory areas. The firmware
expects these writable memory regions to be assigned after the Q6 read-only
section.

However, the ath12k driver currently allocates the HOST_DDR_REGION_TYPE
starting from the base of the Q6 region, which includes the read-only
firmware area. As a result, the allocated memory regions overlap with the
read-only section, causing the firmware to assert during QMI memory
allocation. The Q6 memory region layout is as follows:

		Q6 Reserved Memory
	+--------------------------------------+
	|                                      |
	|  Read-only Firmware Region           |
	|  (Q6 RO Region)                      |
	|                                      |
	+--------------------------------------+ <--- bdf_addr_offset
	|  Writable Memory Region              |
	|  (BDF + HOST_DDR allocations)        |
	|                                      |
	+--------------------------------------+

Fix this by allocating the required memory regions only after the end of
the read-only region in the Q6 address space. The bdf_addr_offset parameter
indicates where the writable region starts. Both HOST_DDR and BDF regions
are allocated sequentially after this offset, with each region placed
immediately after the previous one to avoid gaps and overlaps.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Fixes: 6757079c5890 ("wifi: ath12k: add support for fixed QMI firmware memory")
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 5bf045971c94..6d5063229221 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2746,8 +2746,8 @@ static const char *ath12k_qmi_get_mem_reg_name(int mem_type)
 static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 {
 	struct device_node *np = ab->dev->of_node;
+	size_t avail_rmem_size, offset = 0;
 	struct target_mem_chunk *chunk;
-	size_t avail_rmem_size;
 	struct resource res;
 	const char *rname;
 	int i, idx, ret;
@@ -2781,9 +2781,20 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 			goto out;
 
 		avail_rmem_size = resource_size(&res);
-		if (chunk->type == BDF_MEM_REGION_TYPE) {
-			avail_rmem_size -= ab->hw_params->bdf_addr_offset;
-			res.start += ab->hw_params->bdf_addr_offset;
+		if (chunk->type == BDF_MEM_REGION_TYPE ||
+		    chunk->type == HOST_DDR_REGION_TYPE) {
+			if (ab->hw_params->bdf_addr_offset > avail_rmem_size ||
+			    offset > avail_rmem_size - ab->hw_params->bdf_addr_offset) {
+				ath12k_err(ab, "qmi mem offset overflow: bdf_offset=%u offset=%zu size=%zu\n",
+					   ab->hw_params->bdf_addr_offset, offset,
+					   avail_rmem_size);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			avail_rmem_size -= ab->hw_params->bdf_addr_offset + offset;
+			res.start += ab->hw_params->bdf_addr_offset + offset;
+			offset += chunk->size;
 		}
 
 		if (avail_rmem_size < chunk->size) {
-- 
2.34.1


