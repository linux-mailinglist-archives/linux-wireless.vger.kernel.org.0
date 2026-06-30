Return-Path: <linux-wireless+bounces-38321-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HvsHElRgQ2pfXgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38321-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:21:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C916E0B1E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:21:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=j0uc1K07;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NoTSGVOR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38321-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38321-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4819630041E4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB853CF211;
	Tue, 30 Jun 2026 06:21:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D919CD1D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:21:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800464; cv=none; b=lXFGh/7WvLdJZWMFqlJvO+Sef9V+RKfz7lCZYUCUA2W0p8lz0/Bek0VZbg0Ace10sFzBT9+c2rMZa5gOFX6OOA2mKn3//PWlHnEi6ZW3bCXwya91cMRvuOBKaFJbkSXyxSH30yfkmNtMPgjUYDFAt6x00nGUbLJ8N7tjcTExkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800464; c=relaxed/simple;
	bh=De27nLNCx534SM4DQc4uLipoSpPxYpygKS/tkT4p2DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVyHr878Ll/gQ4Uk821wjWGOFEMXn/aAMiBCqQBy4Elo+8sBeK2DQzXiLGGYi+58Khfeyj45o+2kDymt+pdL78nljS14Rd9wxn6+5NoQIifpKeKmsJod446ufKuh2NEEptJTDTa+xoR3+2ONStm7B0pNfByTZLvqlV6B8rSFsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j0uc1K07; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NoTSGVOR; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CM8H1097871
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tc9ZgSH1IhN
	cvRK3+f/zV7bRmIGfWIN4CPW7NYpsFnY=; b=j0uc1K07spziNDsQ7oK1GcNV/HC
	SL9TGlvjVIx3c4dhmQDjuePVgfLxNW7rXF4ANy+KCHToH6zySauTlhe1OXo1RtjY
	7Ykm24e4S5/1CamVUZ+CQTVeF3hgsmN1T+wgHWeqfvTloLThAv/W4PT+08ZNEN2T
	f2YnAe2Vml6krS4XqZzjtrukc/USUApAabiHTHgGOgQRMsC/dwUIBhEymhPJK2ra
	+pRQggdwqhrA5wdSEzr8TOa2nPaRBA1TNpzxVHz0mVIp3GMf2RdLAQVSJCBIX9+T
	DS1/dmoP44oFTqf4tz1V8tAu0W0WqhQNKjLSWv2CWUWzYwM9pulXepeiqRA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1ct5kn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:21:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c8018f11fbso33561055ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 23:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782800460; x=1783405260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc9ZgSH1IhNcvRK3+f/zV7bRmIGfWIN4CPW7NYpsFnY=;
        b=NoTSGVORka9fVtTIABzQdHdDqBePo3Ru1tUg4nmyRyeCV/VIhcgBDLkkGwrBOmS9px
         IBM5m+MgdmidJuOAWo1lJdsklElFFVYMHOKQ9TbjMNBPMRXboZmiQjuBlTHsyYbRjjhu
         /PnzboMiI2uuBGzfK5D1FRnJZGm+AJDEejAttmq0PqVssigTKuX5AymrDnMjingnLcnM
         j/mxqi4cfh+w6NIbajv6i1UeMMK7YFuj1pLh9zKqhIM0pF4c+7fr7IjiL9Z14JlFHbir
         xT4UMvcNlz6LtGFfwWxzT/Ksoa0l0dXLKP8JVoHM2AzM3WIoJKB6oA9vfCCFsUJoqIiz
         P35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800460; x=1783405260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tc9ZgSH1IhNcvRK3+f/zV7bRmIGfWIN4CPW7NYpsFnY=;
        b=ETd50sxixtYSbg46oGNrQP8uIW1M1Dfd8vRAGDpKoMxk06pF7fygJSK2+xCP7OxGRw
         HS96/orEJKwoxO+Qmq9AmWSJfH5HRbQqL1ms+JBxB6zYl//PaYIaMWS8GuOBnL5ftkUm
         HGXmkSVC/WQtJLiifIZcUjj8+XdSwbWNgGGTlJnT41bhng6u/SZWFiNUP8Yq9Ou+/xkU
         W4xTxCgSs0nG5ksAYAWPlakekvjlHtt67oNX2YxV0C2dYYLlZWIK01VZOp9VVSyw+A4S
         5UCtZusFXN6SrdeXcAgNwDcWLDbVE7HiOGBAMnftklowFl0Xv68Pvx00uP3z5QjSSrWr
         cEEA==
X-Gm-Message-State: AOJu0YxyFVC19ZXVJhnOiOCOfXznU+Yvvr7DActRnox4trsOv/tOcTpN
	Rvb5VK3F3Tc9q7zybgTVnqt3Wzc0+YLorVW+KH8daXBJNJgB2gwKEk36pmpoIui/T3dezc24waJ
	IlmGqi7tvGamPrUFHUEyJORHs1yTBEUs/0DoZUX9fyJsXQmlGWIkGOuSe3fdJ4LZngsxxkQ==
X-Gm-Gg: AfdE7cnXP1NrnAf7Ife2zGuk1pCQBxpWJHWpiw1Qk6Cl3CdXR04fFmLdyjLcHEyYFYK
	gSZNdSGsCgnnSdtx8pRbnaB/u/y/qoL0HO3/i3Ic9yWmSERIFDNHxAJQyzssP8ogF/toAG3FrWl
	bdvaC4vv0Efi1RhtswKk/rHqhD4xBSgjER3Mgvptd+lObVMfDOWlTzXUp0lK6wtbGIP4ca/RgNl
	nsfic2kWfwkrvlxCCFqEPKUUKs9BBetbIvDNsC2oPTG7kNbH3BAcmaji86Bw9rGrNUWVIv0uxub
	i6x7XqQeqJq5G84Q46/mHj7TVDPy0HMvmd7/e6+CW2LH/foE6EGqDaLkqTtNkmeu5DfGZqgM5T0
	S/v7RgEYnovmjkUVOliYdbOE3YKHl091dl8f9bqacs+c/+qiWzUtfEZx94I0NRaYdFgsAQk8345
	9uvtVRVAR1apzAskSPBHmMmJfep2eQ2Gl0IA==
X-Received: by 2002:a17:903:2347:b0:2ca:1bbe:c3d0 with SMTP id d9443c01a7336-2ca2eb32b77mr17377605ad.43.1782800460236;
        Mon, 29 Jun 2026 23:21:00 -0700 (PDT)
X-Received: by 2002:a17:903:2347:b0:2ca:1bbe:c3d0 with SMTP id d9443c01a7336-2ca2eb32b77mr17377295ad.43.1782800459640;
        Mon, 29 Jun 2026 23:20:59 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382d0d22sm6413835ad.80.2026.06.29.23.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:20:59 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next v2 2/3] wifi: ath12k: refactor QMI memory assignment
Date: Tue, 30 Jun 2026 11:50:47 +0530
Message-Id: <20260630062048.1615178-3-aaradhana.sahu@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfX7YvZ+2Hyw5A8
 t18VphDf72sXOTSq/BBg4lYk5rWcAEyP7kSW+/S4BO4GD+XjrHUJ85SbNyYBIpJYAz9Zw1QbR0V
 lmExniliyJMfMZZ3wzPggpdSD0FCnOmn+Y9LKry9KOy2E8s7n497nG3MvlBsJvfg2Lt35R+rSiQ
 Sb/EOVapqz/QL3df1A7/piecR8ktzBYRTQ/yaq/U1+cH4R935K76DCWRe+Pi7OL/wZEW1zZgJvK
 MmftUMu57Te+6aQaX3WeRtRut2UjR+vt5HkeAxJf+7sIJdtD6b/+FDoWNTCEHUT9M3wLnTOvIRy
 bSotZZWz2qE6hnc5Ddx65as/E8vlbJbpDqpRCz41O+V4fwlnrRJkERxM86HgUekzlM/9H/CVd+b
 7fPGw/kGM/2StSpJsTsPFaJsJ/fSuRVy6ea7JTbDma/uuHjMqzZytdG9xq3I0ciSW/swtcj0z1E
 rRCLfVkiZMYIEAg153Q==
X-Proofpoint-ORIG-GUID: vx8Oz29cY0lZ1U42QGnJEyIsn6NcS2Q4
X-Proofpoint-GUID: vx8Oz29cY0lZ1U42QGnJEyIsn6NcS2Q4
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a43604d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=FsuqK5EfqoqfIKw4FYwA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfX4OvJREP70pQ7
 hIMNnPyQZI/HDmXW1LeSN2o6R2zwtZ1qJXLDyQC1DZu55EuFy5c07TppiHnDk4l9XruIJ3UodJw
 ubC+VfBSHWf9Ff+0+9cCfdNIXqy/UZE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
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
	TAGGED_FROM(0.00)[bounces-38321-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: D0C916E0B1E

ath12k_qmi_assign_target_mem_chunk() uses a large switch-case to handle
both memory region identification and allocation for each memory request
type, leading to redundant allocation logic.

Refactor this by introducing ath12k_qmi_get_mem_reg_name() to map memory
request types to their corresponding reserved memory region names.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 157 ++++++++++----------------
 1 file changed, 61 insertions(+), 96 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 0176d6a4bf8c..5bf045971c94 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2726,120 +2726,85 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 	return ret;
 }
 
+static const char *ath12k_qmi_get_mem_reg_name(int mem_type)
+{
+	switch (mem_type) {
+	case HOST_DDR_REGION_TYPE:
+	case BDF_MEM_REGION_TYPE:
+		return "q6-region";
+	case M3_DUMP_REGION_TYPE:
+		return "m3-dump";
+	case CALDB_MEM_REGION_TYPE:
+		return "q6-caldb";
+	case MLO_GLOBAL_MEM_REGION_TYPE:
+		return "mlo-global-mem";
+	default:
+		return NULL;
+	}
+}
+
 static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 {
 	struct device_node *np = ab->dev->of_node;
+	struct target_mem_chunk *chunk;
 	size_t avail_rmem_size;
 	struct resource res;
+	const char *rname;
 	int i, idx, ret;
 
 	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
-		switch (ab->qmi.target_mem[i].type) {
-		case HOST_DDR_REGION_TYPE:
-			ret = of_reserved_mem_region_to_resource_byname(np, "q6-region",
-									&res);
-			if (ret)
-				goto out;
-
-			avail_rmem_size = resource_size(&res);
-			if (avail_rmem_size < ab->qmi.target_mem[i].size) {
-				ath12k_dbg(ab, ATH12K_DBG_QMI,
-					   "failed to assign mem type %u req size %u avail size %zu\n",
-					   ab->qmi.target_mem[i].type,
-					   ab->qmi.target_mem[i].size,
-					   avail_rmem_size);
-				ret = -EINVAL;
-				goto out;
-			}
-
-			ab->qmi.target_mem[idx].paddr = res.start;
-			ab->qmi.target_mem[idx].v.ioaddr =
-				ioremap(ab->qmi.target_mem[idx].paddr,
-					ab->qmi.target_mem[i].size);
-			if (!ab->qmi.target_mem[idx].v.ioaddr) {
-				ret = -EIO;
-				goto out;
-			}
-			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
-			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
-			idx++;
-			break;
-		case BDF_MEM_REGION_TYPE:
-			ret = of_reserved_mem_region_to_resource_byname(np, "q6-region",
-									&res);
-			if (ret)
-				goto out;
-
-			avail_rmem_size = resource_size(&res) -
-					  ab->hw_params->bdf_addr_offset;
-			if (avail_rmem_size < ab->qmi.target_mem[i].size) {
-				ath12k_dbg(ab, ATH12K_DBG_QMI,
-					   "failed to assign mem type %u req size %u avail size %zu\n",
-					   ab->qmi.target_mem[i].type,
-					   ab->qmi.target_mem[i].size,
-					   avail_rmem_size);
-				ret = -EINVAL;
-				goto out;
-			}
-			ab->qmi.target_mem[idx].paddr =
-				res.start + ab->hw_params->bdf_addr_offset;
-			ab->qmi.target_mem[idx].v.ioaddr =
-				ioremap(ab->qmi.target_mem[idx].paddr,
-					ab->qmi.target_mem[i].size);
-			if (!ab->qmi.target_mem[idx].v.ioaddr) {
-				ret = -EIO;
-				goto out;
-			}
-			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
-			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
-			idx++;
-			break;
-		case CALDB_MEM_REGION_TYPE:
-			/* Cold boot calibration is not enabled in Ath12k. Hence,
+		chunk = &ab->qmi.target_mem[i];
+		if (chunk->type == CALDB_MEM_REGION_TYPE) {
+			/*
+			 * Cold boot calibration is not enabled in Ath12k. Hence,
 			 * assign paddr = 0.
 			 * Once cold boot calibration is enabled add support to
 			 * assign reserved memory from DT.
 			 */
 			ab->qmi.target_mem[idx].paddr = 0;
 			ab->qmi.target_mem[idx].v.ioaddr = NULL;
-			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
-			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
+			ab->qmi.target_mem[idx].size = chunk->size;
+			ab->qmi.target_mem[idx].type = chunk->type;
 			idx++;
-			break;
-		case M3_DUMP_REGION_TYPE:
-			ret = of_reserved_mem_region_to_resource_byname(np, "m3-dump",
-									&res);
-			if (ret)
-				goto out;
-
-			avail_rmem_size = resource_size(&res);
-			if (avail_rmem_size < ab->qmi.target_mem[i].size) {
-				ath12k_dbg(ab, ATH12K_DBG_QMI,
-					   "failed to assign mem type %u req size %u avail size %zu\n",
-					   ab->qmi.target_mem[i].type,
-					   ab->qmi.target_mem[i].size,
-					   avail_rmem_size);
-				ret = -EINVAL;
-				goto out;
-			}
+			continue;
+		}
 
-			ab->qmi.target_mem[idx].paddr = res.start;
-			ab->qmi.target_mem[idx].v.ioaddr =
-				ioremap(ab->qmi.target_mem[idx].paddr,
-					ab->qmi.target_mem[i].size);
-			if (!ab->qmi.target_mem[idx].v.ioaddr) {
-				ret = -EIO;
-				goto out;
-			}
-			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
-			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
-			idx++;
-			break;
-		default:
+		rname = ath12k_qmi_get_mem_reg_name(chunk->type);
+		if (!rname) {
 			ath12k_warn(ab, "qmi ignore invalid mem req type %u\n",
-				    ab->qmi.target_mem[i].type);
-			break;
+				    chunk->type);
+			continue;
+		}
+
+		ret = of_reserved_mem_region_to_resource_byname(np, rname, &res);
+		if (ret)
+			goto out;
+
+		avail_rmem_size = resource_size(&res);
+		if (chunk->type == BDF_MEM_REGION_TYPE) {
+			avail_rmem_size -= ab->hw_params->bdf_addr_offset;
+			res.start += ab->hw_params->bdf_addr_offset;
 		}
+
+		if (avail_rmem_size < chunk->size) {
+			ath12k_dbg(ab, ATH12K_DBG_QMI,
+				   "failed to assign mem type %u req size %u avail size %zu\n",
+				   chunk->type, chunk->size, avail_rmem_size);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ab->qmi.target_mem[idx].paddr = res.start;
+		ab->qmi.target_mem[idx].v.ioaddr = ioremap(ab->qmi.target_mem[idx].paddr,
+							   chunk->size);
+		if (!ab->qmi.target_mem[idx].v.ioaddr) {
+			ret = -EIO;
+			goto out;
+		}
+
+		ab->qmi.target_mem[idx].size = chunk->size;
+		ab->qmi.target_mem[idx].type = chunk->type;
+		idx++;
 	}
 	ab->qmi.mem_seg_count = idx;
 
-- 
2.34.1


