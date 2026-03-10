Return-Path: <linux-wireless+bounces-32913-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGlkAvY8sGnbhQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32913-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:47:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DC253E62
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEA313166831
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B9F319617;
	Tue, 10 Mar 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJmxE6Tj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H75kGfQo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA93101A2
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155780; cv=none; b=NGbB6LVfj5cw5k5PyuL8T0zKjSMT9JXtyhHqQdMkXM5yVHrL/RSuJGnjlYT9CCm8hUvdMuc4+2NRkGOmg6Dlv1X5DF3okZrnTOe74BeQ9caiXAeBVetxUvQlzDSXGn1v/Alk2yZnOdF93OHvegMXizurBCLutsgubftUgSb26Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155780; c=relaxed/simple;
	bh=Nu3Dp+y6MszwQX7yJKU+en9iXx3eI22tAWE4mBS7nMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/euiVj9Ez1p/BuSTrQy8OZpG7QHtYLOjMEdFQfGAdteoTNt8q9238cwttZ84zdmjUKycd8sR35rQOf1GljTqsXsvKofJYUMIBAxgZ8UNd8kNloNHAaL70YmqPbMrFsJZUI1O8irR+l48OZ/7f+oQqK6V/gNVDPXoVjScgA/m/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KJmxE6Tj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H75kGfQo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaWdD2861986
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bqcakmoHDuBBUbMmN3usT4bN+rL094zzXf0IoFNFqRY=; b=KJmxE6TjokllmSpz
	LKM/hQLno0qsrIVXRl8bqQIAtpgRhqTmJPOlwVSzlthgU4Ard5o3ha244Ig1ZzRr
	XLkdBBNSqs+YKr9iEncSamQoc5J/2QsQA0LCNebsjGA4E3E4Tg2d2Zd5/AdIsfNL
	bliDT9aYD1bxQ/mrSE9tEkM4rEHF4qHwUXcgk7tfQki6H5mrU5YUU7IrU6u5IBa8
	boGxcDMHxOpp3bLrE6KI797V8cqYQRvGcAxLjpxFcumUUF1h7j7dSKkHP9BFZgLZ
	hQTZJ41SUkw2pThcxOUYfS5H5xNLfxHh9eo11FcL67OfsaERTnQq5l7r8Nx+4/ey
	JuJq7A==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cte3w9xvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:18 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4170823763cso21152856fac.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773155778; x=1773760578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqcakmoHDuBBUbMmN3usT4bN+rL094zzXf0IoFNFqRY=;
        b=H75kGfQoW4thA1L0ZyzwzB4WPy0oUIz+1hQMjMvdxlG2/Wl4Gcpyec3qsfz843u+6n
         vxCZwwuNxOHA1dJIDrg3/L7ontDvfJhUt15Y9Wc1cYfWRh4m1BpGGj4I54cttfMUYurZ
         RqRZaRxRhYAnJ2J3xNCgzw68OXLJN8un9tCK/67CDj3d1+pb4Jj0rgORVBigpFJQi83x
         bMdlNsqnOdTN5LzxQC0HJMBsrfjLFJU8iuF3fwpKvohad5hFgTghcRzDZL8FkV+CHw5l
         L+vV/BFkgGwHjx+LSgfMmUt9ZAtm1YNXhmlmIQJ3x62wbiCaQpIDQR64NBUwNrCZqiF3
         gRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155778; x=1773760578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bqcakmoHDuBBUbMmN3usT4bN+rL094zzXf0IoFNFqRY=;
        b=EYBIhkAQAkw8JESX7NHbYpCLy5gGC+OMhqUPmAJhvlF7oKe+ay5jlzNLBE9NSoOiHA
         wSd9aVAXn4NLUFya8jdBjzv17bXUCV1jefR6Yr2m/XIl0yi13FRPMSgLdawHrQjR9uda
         a2c8o1uzj2a7vk7cswUUuJd+u8W5jZPQmputDIbX71O2FThRd2p3A5BhyhbRbdNnduTV
         y0d2ROBiRx8X9O2tCNvem9rV41jriEKa0lgmW6ffXv4TGLp5w1E/GB4MhDkfB5RdzIOV
         JRiSx6+X2OYjC5wg5XuSkWtIGdPwipZNGsPOz15/a1ErHwtIYTL/FIBQlAUCYaQFEz2W
         omiQ==
X-Gm-Message-State: AOJu0Yx0pnfvOfzYNLe1VNWC7ZXAwJQYHCpQ7iMzarBEUIHtCCYdpvDa
	GPWCOSQf0fzcxBayaATflfAzy1CuhVMDymH1BwUg+xvQfXaU83vKk/+bDRfyFZi8oRcMPGsyOSI
	O0A7BDzg3z3JPGL1SnMAVwBykpbhx0lZraJ7Nv4LUXzWt42TVBfsVle6RaDEqwkJKkH/1HA==
X-Gm-Gg: ATEYQzyIFXAP4gR6zsm/4NTAivya09vMIAN1Hb70LsCFSHtKz6zB9Z63ujeDTcvch0W
	V73OlVSuHEVSC+RdatOT8t0uCNHTTq+Q6Ujyj9CbOcgjbI+5v465ITgkFZn+tdcxP2a9kaUXQjt
	8mIdOiUeomuWPKkEmD9cP4hklcBibH7BWYFb1m2LXIv31d2v/pHjw//KyqRwpwPZu5GWK63WUlL
	8JQsR9OFTrCa4S1V4p1HTMNGDz62YoGp8FfaGiHRxaNJ/UaUZMdfSpNrVDvYiLSIume2Yj+4QlZ
	Kfhy3V2SZwgv7WDda2y2a/LNXAQOJ1gj1G6+WpahyL6JnrRvVbDL6jE0DP8hcs5auwXJpXCISu0
	x+W4EhnoZyqdPEunInpG30jg3n79QDrV4lsr2fRUDQiLjAufZT5VG3a6KXh/EAuapbYz/AFxUwE
	vf
X-Received: by 2002:a05:6871:288c:b0:409:bd2b:91a3 with SMTP id 586e51a60fabf-416e44a1f90mr9624374fac.32.1773155778207;
        Tue, 10 Mar 2026 08:16:18 -0700 (PDT)
X-Received: by 2002:a05:6871:288c:b0:409:bd2b:91a3 with SMTP id 586e51a60fabf-416e44a1f90mr9624353fac.32.1773155777763;
        Tue, 10 Mar 2026 08:16:17 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756dbc7afsm2714603fac.14.2026.03.10.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:16:17 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 08:16:13 -0700
Subject: [PATCH ath-next 2/2] wifi: ath12k: Remove unused DFS Unit Test
 definitions
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-ath12k-unit-test-cleanup-v1-2-03e3df56f903@oss.qualcomm.com>
References: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
In-Reply-To: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMiBTYWx0ZWRfXxQHSfVB+CBhh
 G60RXqT20PPxfoOzu7h13iFNvRWxv90bbNsTR2TqZp3WBVfMNsUQ1Xpg8POpeiIoQqc/eRvSnIl
 LbfC5d58KrEaun/cpItsQ3BEWpSiDuO4bhoqnB/2bXNJ9Y4oUdmAktv0Ds/cXVqo+Df8RW0z2Yh
 0mVCDulIDV/llowIboUUqdMFzq8zKBVARGMMZx6HWIvCq25tgcDV/6F9h0LdLDZeK5h1yYybWMT
 xlFPEX0azsNMGoeuD+968zZprvYRekV4XhTpvGN7Qze847FIrC+84n/EuJdHxMwSy9Jr7C0FIBJ
 2yZOyF3jZiBjyVktIPtzkMm9Qx6KYO2cXVltD86eUsUpcZwVEpBVKDUzkWAERY65g9Zcx5sChsN
 PnB3KltAlF+DnTT5XF7lsrt1eiIdR7dy2ND0/IKyhEfuXAKv/l6iTg7Z1koawesXKPUmRuw85MK
 ysbQ6vAicwmDbksl2Qg==
X-Authority-Analysis: v=2.4 cv=GtFPO01C c=1 sm=1 tr=0 ts=69b035c2 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=bMVfQdeosIbDT_emMCAA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: uzysC_Z6OWZBs6Vq6pX3dXULLeC_J7Vd
X-Proofpoint-GUID: uzysC_Z6OWZBs6Vq6pX3dXULLeC_J7Vd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100132
X-Rspamd-Queue-Id: 743DC253E62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32913-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The following are unused, so remove them:
struct wmi_dfs_unit_test_arg
macro DFS_PHYERR_UNIT_TEST_CMD

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 8d766dd5b304..5ba9b7d3a888 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4193,7 +4193,6 @@ struct wmi_addba_clear_resp_cmd {
 	struct ath12k_wmi_mac_addr_params peer_macaddr;
 } __packed;
 
-#define DFS_PHYERR_UNIT_TEST_CMD 0
 #define DFS_UNIT_TEST_MODULE	0x2b
 #define DFS_UNIT_TEST_TOKEN	0xAA
 
@@ -4204,12 +4203,6 @@ enum dfs_test_args_idx {
 	DFS_MAX_TEST_ARGS,
 };
 
-struct wmi_dfs_unit_test_arg {
-	u32 cmd_id;
-	u32 pdev_id;
-	u32 radar_param;
-};
-
 /* update if another test command requires more */
 #define WMI_UNIT_TEST_ARGS_MAX DFS_MAX_TEST_ARGS
 

-- 
2.43.0


