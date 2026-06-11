Return-Path: <linux-wireless+bounces-37650-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AcvdG5gsKmpljgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37650-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 05:33:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D52B166DFE4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 05:33:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hEeh2kKh;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=fFaLbqM9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37650-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37650-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53BBA3104305
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 03:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060CA2BDC05;
	Thu, 11 Jun 2026 03:33:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E53128A3
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148807; cv=none; b=glP4qq4okM6+D8s5XFIPhWd2dtrbvYYWmjXh4gbEKAi//jHGEksjbWh6P8k+p0v+mjKbYhnD547o7J0mMsEq4gmtfkrYrAJwEKCpY+G7R2X6R7J1sj0Ynmfc6rRKXtLqbMwuyhVbNNEbj/Laavk/T2Udbzz7s5DcxewecUwSG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148807; c=relaxed/simple;
	bh=tYGlgM3WWze2hc9PNcwsbFROOuQfTGv3VPZ0Hl7NkQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJ8SlkKqjXnzyiEcfBE5c5c7ANiZzdKRGwd8/cVBpg4sQ7/KLPYUJHMyWw9/NfqDDR6TOU1YigaB7OMWSKazUmEdUN1xILFamHkX/7w7iKpphCAySGEm1ge01RMka0GhnsbAU5VENPxqPjmxpBmAir1TpgEWKPLBZDG7/jdp8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hEeh2kKh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fFaLbqM9; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B0Nhte3159720
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wANYbend8iu
	qsdCtlChTQdQSao4D8V09xXZgnJmxXi4=; b=hEeh2kKhUskne4GhQccTE3yx2x+
	dmJiE+tq+Kr7zRKrvmL8/RsZlj2JaJLrbqF7SRetZfDZU382ky26u5vMqTS1cpGO
	mKB+bteJV7eoHWMntJocn0aI0FFCWtlGGcZ2reQeG5DKypz4pKOVzq1+/jCb99/R
	wb6U/KOZxx/W/3RDECMf0RS4L9ahgS/dPKgFcR7UYAWG//v9sgyl77PBB7gOP1Kx
	cy7k5gNpVsS7fbwM5YVy3UcRrJX91ZsNUOMPv14DR5vnuDc3UEnL7ywUoEvTTckI
	GPLn4XaxvAtBxzH21Mb+cF4ZREVVlKUG0wmF3MFFqJGPg4xK6P4g4dneTDg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701e9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so12070917a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 20:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781148805; x=1781753605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wANYbend8iuqsdCtlChTQdQSao4D8V09xXZgnJmxXi4=;
        b=fFaLbqM9lNlve8XRQvGwCbUMXZMCTAECgc0IvYg9fHtQqnC5t/d80z9zOJy0pUAsSb
         wZpA+Bk6zDygcql3CYQYg5SashGCKAH4sJWVpfrymPddUvW7b4VXJI+J8MG/EE1zhzKV
         9fviumGRE34109GcT/rtr38cRYL+Ki42jyCQUHVZRTJNt6lw2/hxj4zQ+33NkvdyjJeX
         iaEQjrtyYL8HK40h1jBwbDdzxu4vZ17agJcxRhZrjKu5Xxbpb6YH/CY+ol8JWqs2pKbN
         eVIqVEosOFVoOeHqZOVGE43vU0M95STQoP2wYoKIv88RJF/X0ZFzuljCRSbNKtaa+VYZ
         JWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781148805; x=1781753605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wANYbend8iuqsdCtlChTQdQSao4D8V09xXZgnJmxXi4=;
        b=OluQZOOrwtXfGoqaux7c7xVarcbt8uMLgU3I9Bha24oPw6doOjlvBCHeUGvZT2JKRp
         2qbQCHd/Ci85hWZo6Y6XoYLdOteotND441FwVK/RipdNy46BUzyIuT2zY7VOx6U64ykB
         bhDhM1ilyq3sCBSn6FYytNagOvcGMfPnSTuvQ4L8K7+ryQeqxRBERK5aX5i1jlEJ4Ucq
         NtqYqUgdhjyKMVuHbo4QL/3mCipO+oXyS6cjA0QVovEd7E2+YaPdcihDZvO+O7+8UnzZ
         Kf8mjCEHPRIGT209oPK/wR1IQMWbIY0uen3LcdcLimc46x2g1uNYqzXziw0pDFMs205P
         oUCQ==
X-Gm-Message-State: AOJu0YzLY+BEGLiRgHbagj3D85H2LPai19o9jIDdta1U6rvZg5NikgMT
	lsUsAZw997G+4sZQ6VYJZEZQB0HmnUZftj4HMdjsosxEThFkIQScPygeWXPzwnP0I7n9as73YaL
	FsIvndVXGtMByvJNAPIwa49K05gJ0WLt/2rMM5FdXnBBUrJL7WoDLryVh0/JLqISmUcFzRg==
X-Gm-Gg: Acq92OFy2+fu+8I8p7cRdNeI8UV6+CtYeBCAJIX/psdM0mGEgTrGEDVOs+aWf3O1n+l
	w69khmOiVOviDAyJqmj49VW4k37Jerylsm877aUt/R0pXNph9RJD0EIS+i5BDMKqqAFoE3U9dYr
	6+FJs8Y1yD7DGQ0UnltGZqD2x76vpB0V4Rw+AuQWMpqGxCuiT2jaz5MsIbd+UU/Jy14AaeOJyYs
	FeXu5In3RcqsZ7QPEOX5xbXIXFN6vBGgMI90Vn0OqtH4eUtv36aHhfwo5CpPBFKV3CQ7OX6eRuB
	Fj+EX2T2xIEV8QlBCHSSA3AFSuUQqbcKsVP+f/PrIatwhnpCmuaS1J35GtRQLcXKo6D0hrjzJxd
	Ftw3uFvM603cs2NVEauO6OAT4VSX4G9hcMQ6XGtl2/0Tg092Dp11DRUmz0bj/sQJaURV8hVV/bq
	r5xGqetM93rfMXHOU9YvBXfSP93U7q7r75I7IQN03JN5TG39ejOI4JgRg=
X-Received: by 2002:a17:90b:3f8f:b0:372:94b9:76d8 with SMTP id 98e67ed59e1d1-3779dd65b9amr1186311a91.6.1781148805573;
        Wed, 10 Jun 2026 20:33:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8f:b0:372:94b9:76d8 with SMTP id 98e67ed59e1d1-3779dd65b9amr1186286a91.6.1781148805125;
        Wed, 10 Jun 2026 20:33:25 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775287186dsm896041a91.6.2026.06.10.20.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:33:24 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 3/3] wifi: ath12k: allocate HOST_DDR and BDF regions after Q6 RO region
Date: Thu, 11 Jun 2026 09:03:14 +0530
Message-Id: <20260611033314.2330-4-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAzMSBTYWx0ZWRfXwCgsHBvKjvXH
 KLzvUeXqSxC6PCYj2U/XqtIe/9GjtrZpWzjfId9UmBcP9XPIhvXwfDbARlFQtRyUDD+AaI/BgFd
 Da3DyO1gWLymH/VQF9wVrMGfvqpLtRXtThqTX1+iN/w+MhDCPW+2l8WK0v7oyHM05xGKUSuRRE2
 HZP0X+AI4j7Y+5BwIWB286bFqXDhJGHNcnq4iTnvEObFmi38aNqVSpjTGbntNiLnpYjtuSdtc4H
 QDhrnT4jdrx9yXu1/p3wa8XOe4ZKCPq+C2bAoRlS6MMZZ3XUSLQwPbHb8lJP67uIMFz4Rw0WQu0
 m9KZYor4O/C4BopOlJ8eTS0NztwfQ758+ApYLmK6Kzps3uVwWpizDY6Jb09mmL9U9ZuzXONlLA3
 i+UX7/BxS5B3Mke1p43iCYoAVbxTWKKxdvofDY8H7Lxm4u8mm9wKM14dz2vEEvfLwm51pZcYrDK
 julidYne9Z68LRKSLrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAzMSBTYWx0ZWRfX9aZ6GrisJk0A
 eNeAuOcYEnGjSbdpT2ajV5R03kqFxssLJDcXNcJgtCvj6vYMrO5ui84BOG+YOObZ/CzrtQMx+Wi
 yQuPH0ebkpxOWvRT6iMm76h45IY18hE=
X-Proofpoint-GUID: 8vh20ITMcl9aJxE2C5wZlerV5BHBLwbW
X-Proofpoint-ORIG-GUID: 8vh20ITMcl9aJxE2C5wZlerV5BHBLwbW
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2a2c86 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=nT0BbeqX0ttObqoriowA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110031
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37650-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D52B166DFE4

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
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 5bf045971c94..11f57b0755ea 100644
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
@@ -2781,9 +2781,12 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 			goto out;
 
 		avail_rmem_size = resource_size(&res);
-		if (chunk->type == BDF_MEM_REGION_TYPE) {
+		if (chunk->type == BDF_MEM_REGION_TYPE ||
+		    chunk->type == HOST_DDR_REGION_TYPE) {
 			avail_rmem_size -= ab->hw_params->bdf_addr_offset;
-			res.start += ab->hw_params->bdf_addr_offset;
+			avail_rmem_size -= offset;
+			res.start += ab->hw_params->bdf_addr_offset + offset;
+			offset += chunk->size;
 		}
 
 		if (avail_rmem_size < chunk->size) {
-- 
2.34.1


