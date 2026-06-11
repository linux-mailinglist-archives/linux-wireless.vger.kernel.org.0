Return-Path: <linux-wireless+bounces-37649-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f5BSDYgsKmpWjgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37649-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 05:33:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7CD66DFDC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 05:33:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="FPdrR/SM";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="NF8s/912";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37649-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37649-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A00C53012BE6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC72BDC05;
	Thu, 11 Jun 2026 03:33:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41030C176
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148806; cv=none; b=SSRdU1PAHJC1AQtJCtcBNQgfHhJEDmC8XlmoNFyMGzkTxLPe0LOgju+5KxoyKEb7Elv7bXnQTF+4GNJBd3ZTXaLMWGoT3Aof6sr9LVqPpDfLJW/l5sEavepyH4de3EP2hU7ztV+Zz/eQT/Vm2rOqTfvQLzZfb5TMmhXAWh6zbuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148806; c=relaxed/simple;
	bh=VAy9Y43aZFbImb0eimhCNNXIUD3i+m7rfbkf9yl31WU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6UtvWKAW7Aaij4sYB8Ye2/oAlDjE8Uggr5cCEQzyLS3qTqJQnUI340RgJYemJweedRNBtcIzEHX1qvl+ji/Izog623HswVKXbIzvhACX1cIZ8pMvJOJwvo/gM7PclNJXCb+mDr8zrjBUuLFcwFNPipND8FOEK1p1lhJt35MAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FPdrR/SM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NF8s/912; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B0NRVd3184198
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g43XeO4Dh6c
	O/pZEQr5ju05m3Cr2XMlgsLAM3KbtotY=; b=FPdrR/SMKM76elVTWCnDM1s/ez5
	0mpPl4zuZLhUD+PXIxULF3mDhMa2j83cF2rZGY0Idy6c0JZ6bYg5ivY78ABmGwhQ
	N2JAia+HhMMS0ixdtzNZNmtgvhPPI4HVK+9nOwAIKXQtZWKzUlS7y0UYWUdeKeNA
	3bCN/YRL0HpIz77wTgzJV0YsXusENVYcpSQ8eOCD5Q38n8qH1AUr4U8xl9y7RxU6
	0/999F4MTKgUBia6cRZRwen5DrL/itNVVpcaNtmNWirDmKfM84mk6TwxbMhIifR0
	57N4bH5GhmF2EJ9hCsU2eVa9+ohSLNGnIeVlZLcAtPIlrem7vZhDPnGNscw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6usdr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36ba98cc003so5261454a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 20:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781148804; x=1781753604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g43XeO4Dh6cO/pZEQr5ju05m3Cr2XMlgsLAM3KbtotY=;
        b=NF8s/912R6sE3cQScQQD6jHXR+fk2L6xnfm1JwpsldPbDQhP7u1CrDXKaYM9WPQkv2
         kBFTNgr5kBKlg4KdYMLQLIJYsB6kVAFWDDgViGajAmBwKMU2U17HZ4Rpu6Vl5LxGDcoc
         vIftk8Tr8Txwm/tCL3YpwOCoGq6eYW5fj7MJFoiKu5ZfdNgcg7/xfmTTa6hgLRkqUrjk
         CA+3jETolJRUjTizsRHtThXiQWanrCd3pGIPKo77ZW+MiRjR5+mD5nlS4I2kTal1cQm4
         J2l2uMzpejK2jyXwpnY+DHY/4Iz6AdNJ+MV71xkQZlDwpKDvPv1By7uIIiM7RopmOHoh
         JIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781148804; x=1781753604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g43XeO4Dh6cO/pZEQr5ju05m3Cr2XMlgsLAM3KbtotY=;
        b=F2CV2SoJYfvUtG+OHIZBanFscjTEPS1O3dz+nioU+Thjd1z+mGfNG9ckIj+FW+YuxJ
         7Vh1yqo0i+v/xLK00SUUtlZ2b82Kk9IBJpf238jLwdrObz8QQGuvneyWJasKIc8J6c6H
         dl4sDaSx1hoOLPC8xJbFyrQKTBjzT8p8OsSN4eb9rHZOQ337Jmws2nqlbsvXCHnlPDXc
         8Z157YnfkUjzXR5hcB6UWp3jHvsnWLk8fb04+uT38dcPwuOTOKWWzNvV5CkhDhAFq7wx
         HjmIyB0vb3l8u891j5A68ZLjS1gB4MtiF740DhteZVsN3AtV58KDLM3jEXA4+tNq5YhV
         NotQ==
X-Gm-Message-State: AOJu0YzhiiHlh02Sg4EIK+/e891Kyyo7AYt4fdpJpiLdK0rm6vu9500e
	j/z/erYljLy/dhNtvwbwRu2xlNI3gVMCj85hpVuA9Iq84HfLcz7NyrzLZeHGvfpXBasjuu2sd9N
	uUTj1AzwnVOnCnM1YPEPhEyib3KgTMB0cSvWHnFtq4a4o/FZ0rCpi4I1wvdgugUL716PB6A==
X-Gm-Gg: Acq92OHQUjQgO+16M1haRYy+54j/wF6/W6TH/qmHR8hnT+Z31wGN6lVekIAkmkanzIk
	3YiM9FPxo9pfS3DY35JZ9P/81g74vwq5C6YThMiPjealcO5Fto5o+LxrybHRGdFAG/0Wy3ArTKz
	5QyjFnifQ2+9LBSSeEdluWN+f5msCnNgDLMBiw7d4nWGYerXzQPlBH09XHhQJLaXnlCNpV5Cxdt
	gwEBiy/HgGyzzMCL8trLDCEvo6H1bLsHYsErx7mAb04xrWgEGJSCwpeqo8Q1DCKyhq9MsEUwQnu
	hhSawFwQjkzmH3aO77JB1sfqrR5kxtORUMQPsNBpOU5Xr01ZjYBU5XVmfTrdE4qHZc8srtJ7RD5
	KAI/alGC+DdVNz7Wto13bG2U4cRY3skuwfc09Uj6rFYUJNkTxyYzomWT78lIYaSsJe0kvtmOT1r
	lXvs70+4Qi/3hUTeoQX+YL7dMN3gaR+aYCRit6Wuh5L37pmtNEabCAiw8=
X-Received: by 2002:a17:90a:e7c4:b0:36a:f612:e695 with SMTP id 98e67ed59e1d1-377a591536fmr1193539a91.17.1781148803577;
        Wed, 10 Jun 2026 20:33:23 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c4:b0:36a:f612:e695 with SMTP id 98e67ed59e1d1-377a591536fmr1193501a91.17.1781148802969;
        Wed, 10 Jun 2026 20:33:22 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775287186dsm896041a91.6.2026.06.10.20.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:33:22 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 2/3] wifi: ath12k: refactor QMI memory assignment
Date: Thu, 11 Jun 2026 09:03:13 +0530
Message-Id: <20260611033314.2330-3-aaradhana.sahu@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a2c84 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=FsuqK5EfqoqfIKw4FYwA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAzMSBTYWx0ZWRfXwMu8YQFJnE5g
 MvQomoDjGX5CBB/TGJ6oTKerAkHqV6naCmYR0LUpqCBuLsTErWmcwoq29aQT6m8wolKWhc++B3Q
 PlGjm0RN6Pw7qJqwJfanDD1PRjPJC88=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAzMSBTYWx0ZWRfXx4QV5ZFqv+BF
 HRuUOyXy/vud3+Qn73UHz/CwCfVPiu/778Vx9QyWoYlr1AiJilbhXwt0w78oIZEestISU0c451u
 jdc6eyhbEnYRLdSiCdluCVFGUCpRBETefSCVPa2astciuIo+jJooDSyHjIHuYhe956h8r9zvD6J
 7Uz4NFAP+8BBERVYXy1EXPvTHjqVRQCIgA/Y9RaAZ0Vl+EzivS0SSo14Fm7ZYBZEQPuvh+rPnMr
 7WlmqeUMQ79MLhGZxGsFrkZSFr3ppndsP//vaeCyn7I5Dw1D5vV9p97qFuW1ieD3CgIkbGvWm3P
 QqF7FOg/FZ/kVsPCy6JHPsmps7pP01X1HRMbLurr/h4hLfB79aBv3MVDPaFMaE7P16AWx1hgOQF
 vnQioJPjKeyMdbBfdcj4HgiYw4v66XldsVhgrMx4+VuvL8mF9AgCTkQ+oedR+3F0KTCaaCW4ISn
 kkuWi3/UBTXnPiYJ1LA==
X-Proofpoint-GUID: X6aZWci3gIJ5MeOpSTMiby6dbMW-LjdG
X-Proofpoint-ORIG-GUID: X6aZWci3gIJ5MeOpSTMiby6dbMW-LjdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110031
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
	TAGGED_FROM(0.00)[bounces-37649-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 9F7CD66DFDC

ath12k_qmi_assign_target_mem_chunk() uses a large switch-case to handle
both memory region identification and allocation for each memory request
type, leading to redundant allocation logic.

Refactor this by introducing ath12k_qmi_get_mem_reg_name() to map memory
request types to their corresponding reserved memory region names.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

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


