Return-Path: <linux-wireless+bounces-38148-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x189NwA8PmqQBwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38148-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:44:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6446CB749
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:44:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hUstw7Hx;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ORVcdjxL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38148-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38148-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C325E3007352
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631672F8EBC;
	Fri, 26 Jun 2026 08:43:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E013E5A20
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:43:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463420; cv=none; b=lQeOVXhmNdsarUmBWnmkjbDoM/ATXOPZCTtWy9N/GCzmKjIh+DVEBw0kO0zK6ywrYa022mOz5Aw2+etJUrizEFfTPig9SK87Sg6r3Q/6+CmjTa4itwuTFyzgp0cNtTboteHCyTxXOMllG5k620m1FHnvJuSrDUzhbge2LMhXsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463420; c=relaxed/simple;
	bh=gEvMzi4KtXvSF10AiVaC+GzTEb0SxWQjIMiC8Rv5ACU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ClsnHtuD4dZ+SIQROFFxk+rt+sAxV17W5wtQeOti4fANRkb3vnET7jzcLsFT29cnERN7zvFXhRkYLZgqWV4bUl+FU54cdBc/qYYq0QQPlM/1LuoQQ/3dIGKLRjWLB6seaSTk4LcJmuYw4zzgMk5gYSMbX9KKORYC6KRbTkEF2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hUstw7Hx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ORVcdjxL; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6Vxm5631891
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DiG6xrFFnY3h+S/4VDuUJoQQWaLq0xCJdWX
	ESpTaCaU=; b=hUstw7Hxfyz5lcx2p4jAraLwLpMKnj5w7qec6T/8raY6i816x9x
	ntBVSVK9rIvPGPs8g+om4TJHMijgtedh7yn7L5t4r2+IhNxp3/Ort/BkC7hZM5v0
	65cmU6waov3107UcbOFPtvGVyqPlZSWH6ubwMT7HicF4E3gck2JIfDHefbKe9Mne
	tXLvdJt9RJwwu9WeFWu+LYQaaDtM2zPZVa/SBD5THFDBJ+8mQCIj9CMs64QjKmrC
	I8ov9dwVXTEIBWi9aKi/K9Hn1hoKUtXLVHM8c7waBdM9xotEQ6bxtYz46rCWUOdo
	Hhy2mx+sYcOVD8UarjtGFvns4HFJukscmQQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1asktqgr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:43:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c1f6c5559so879338eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782463416; x=1783068216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiG6xrFFnY3h+S/4VDuUJoQQWaLq0xCJdWXESpTaCaU=;
        b=ORVcdjxLKmzCwX7OFxoaWJKs+bDnH+TIzGy7JYgQAld+K6xLMPN/2R55l62CHZtwVW
         Sbu5Z3VKhAKj3IAcjdIvY6pNZ6Sl2OfpKhVya3ZOhfRF8nMy1CitO5B9uFVLuQjFG17N
         50qKVWBFNaOMmeuQdu87+WOohHZt+LP1uLCP6SCX+pBmo5841vybed5ZCwbn2Qb2wraL
         JpKnIUcCBqXhmJGt2Y/sSwhVTlRFF6UUczke+gdcsrrMr0xtfuUy4vSwa7YcwWPGMvm4
         DV8RogWdyfu80/1bmjU9LX7mqFCA7jepmQyl2fj3bxZkaW/EM8lbYS6Ky9cFrQZ9hknm
         giiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463416; x=1783068216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiG6xrFFnY3h+S/4VDuUJoQQWaLq0xCJdWXESpTaCaU=;
        b=EZGoxbA3qB7zeQPew+O8D6qq6F7QRSFzc0bykUla4odaKGtKIMXU2qXWKY7cmKDc9w
         FIb2UKc2w9HRXHNR1p/l6GD5UP2kOkHKJpaOxb5LKLXRRXqj9z9zupMTzc15z1ZhCS5W
         2+RKDLwRZVvRbBVdd9b8tDEbcm983xwHXe+haoV+RRUlXApyW+aD+Gvx4mN07MYRHvop
         UH177Vv3cv5HLN91TaO6qKRcs/9bsJh4Qe14ddwZVsWZ0dvm1qogDJ5feaFS6883dXng
         TCdr3Pg/xIL17hzyDjasnj+YwNGi8odhG/Ony5cJVm7w8ZWfjDJj23WaLwfoaRv8FJe8
         p3aQ==
X-Gm-Message-State: AOJu0Yz2Kp9xHlUWaXrj9y0YOhwLgVyQLyhPUAVHfsUP/lkz3hGscvba
	Q3KqIVkB1ucjn5Yk+gpZ0R3/TtBkatbqIaT68g5w7mbYxAtUSiOIof8vbmuT0tQeDms9zE+CKTu
	UddGRFE2z1W+NPs/JyjAcZbRm+y8dc0SI7rkZKrRj9cDNGuDeyH+NnO2ikSxggQ3nh0aggA==
X-Gm-Gg: AfdE7cnX2hUIFdc4NmtmTV02kHkLISQtlLU29gGojzuBe9QKRK72tr04erer18sZcp1
	4HWBj5xge1bt1dnW3zHLE0LAqT+pXRR5hdZTtsc9YsGPlzMp41hfVFyMqwsiVBbnPcKRUd1z8ro
	H/sYAwROCYiMvR2dra0Dtu8d5n1SwnjZGoiRiPlNimA3WCi+DPJJMuYVRin5Msl/SuXqDiivP6L
	cR7T4uN15XNimyK07Q4B940i2SCR3TUZl7HVUeQpfBu7QDmPKujhH6sCSLFM3uS4viv3WCOr3SG
	BMB5Lz1yN0lBFtFavqZRPg6R0NaoS2xz3CleMaypf4I2ocB26D8gOuMCu/7y2inwH7YZ7FlqIrt
	HByKnyRiQxgfOHhTcV0Zg/oBuu3MS/q6dyprp2AXXPTfB6i0iWj1b+QuAxI422TxIBas8GsKpSP
	6qLVo7S20P8H21wkJABPmxP/R7Zr7JxJyv4Q==
X-Received: by 2002:a05:7301:5789:b0:2ed:e14:42e9 with SMTP id 5a478bee46e88-30c84e0f0c1mr5869383eec.34.1782463415686;
        Fri, 26 Jun 2026 01:43:35 -0700 (PDT)
X-Received: by 2002:a05:7301:5789:b0:2ed:e14:42e9 with SMTP id 5a478bee46e88-30c84e0f0c1mr5869358eec.34.1782463415114;
        Fri, 26 Jun 2026 01:43:35 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca208sm16444583eec.3.2026.06.26.01.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:43:34 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next v3] wifi: ath12k: add QMI capability negotiation for dynamic memory mode
Date: Fri, 26 Jun 2026 14:13:27 +0530
Message-Id: <20260626084327.2022076-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA2OSBTYWx0ZWRfXwOOCC5jez/Pi
 1wG5RnFFwdEl4BsG4afBaBLYyWIG/vfC7jIs/B+XKmmFN3J0m61wS6syE6afnnXKVYRrR0lOWlj
 fOcMLpfsr/YY2vpFaeAd1Y3liUDNLI0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA2OSBTYWx0ZWRfX7sGLKz5nfYpb
 sPRhKB0E1or25/b5/lkZEq4iUeZ2LDUwS7JG4jsRZB+ujO6gJQCHCgdFqbUMgrWqsCeIXakZZ9O
 paShW7Ry6v2i5mAGMlVUO/0eXSvdOfc/v8uYA98h7T9n+EaPFF1odUGRTWRtS0heRH9UqgmKUv7
 WkhHdX1mKlzfQFiDRDtEgNuQ//eeDPtxyiEKB8WZJ/9oVLY2xoT1/4cBWWXwvsWPrSKylQ1SNk/
 Gic32wsQ1VGa2xHKU+mWf5RsALgEESqHFpJ58INiSfci5ouEZ613BzQ8hZcc/ueNy2zZcrXL/pO
 yxSn7+ZnOG4d1E3FQpaDrtYYvopnBviAwbplt3hjT9jJQizy0qZ642BwF16ZPEc0rTVO/6VdkCQ
 eODgpuQZ/TxU/0040ln3cJIpScZfJnYUCEYV05p+wD+W08gCvgIKPcNTnn5hCnY7GrgErm1E/R/
 COvJcavqeDx3MqWHqkA==
X-Proofpoint-GUID: QYAXwM47zPMwrrCPwwGsX4NJRQJTzOk_
X-Proofpoint-ORIG-GUID: QYAXwM47zPMwrrCPwwGsX4NJRQJTzOk_
X-Authority-Analysis: v=2.4 cv=AMxnnMPh c=1 sm=1 tr=0 ts=6a3e3bb8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=m9xaxUC3f_2y1K4foloA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260069
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38148-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F6446CB749

On AHB platforms, firmware operates in two modes: fixed-memory mode where
firmware uses hardcoded addresses for memory regions such as BDF and does
not request HOST_DDR memory from the host, and dynamic-memory mode where
firmware expects the host to provide memory addresses including HOST_DDR
after the Q6 read-only region and relies on host allocation for all memory
types.

Introduce QMI capability negotiation to support both modes. Add a new QMI
PHY capability flag dynamic_ddr_support which is advertised by firmware to
indicate it supports dynamic memory mode. When the host detects this
capability, set the dynamic_mem_support flag in the host capability message
to signal the host is ready to provide dynamic memory allocation. This
triggers firmware to send the HOST_DDR memory request and use the
host-provided address.

For backward compatibility, if firmware doesn't advertise
dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
where firmware uses predefined addresses.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
v3:
  -Restored QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN change.
v2:
  -Dropped QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN and QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN changes.
  -Used %u instead of %d in the debug log.
---
 drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/qmi.h |  8 +++--
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index fd762b5d7bb5..e15a0c0120d3 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -506,6 +506,24 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
 		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
 					   feature_list),
 	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x33,
+		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
+					   dynamic_mem_support_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x33,
+		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
+					   dynamic_mem_support),
+	},
 	{
 		.data_type	= QMI_EOTI,
 		.array_type	= NO_ARRAY,
@@ -602,6 +620,24 @@ static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
 		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
 					   single_chip_mlo_support),
 	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   dynamic_ddr_support_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   dynamic_ddr_support),
+	},
 	{
 		.data_type	= QMI_EOTI,
 		.array_type	= NO_ARRAY,
@@ -2248,6 +2284,11 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 	if (ret < 0)
 		goto out;
 
+	if (ab->qmi.dynamic_ddr_support) {
+		req.dynamic_mem_support_valid = 1;
+		req.dynamic_mem_support = 1;
+	}
+
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
 	if (ret < 0)
@@ -2319,11 +2360,14 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 
 	ab->qmi.num_radios = resp.num_phy;
 
+	if (resp.dynamic_ddr_support_valid)
+		ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
+
 	ath12k_dbg(ab, ATH12K_DBG_QMI,
-		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
+		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %u dynamic_ddr_support %u\n",
 		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
-		   resp.num_phy_valid, resp.num_phy,
-		   resp.board_id_valid, resp.board_id);
+		   resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
+		   resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);
 
 	return;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 2a63e214eb42..9bdb290e2cce 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -156,9 +156,10 @@ struct ath12k_qmi {
 	struct m3_mem_region aux_uc_mem;
 	unsigned int service_ins_id;
 	struct dev_mem_info dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
+	u8 dynamic_ddr_support;
 };
 
-#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		261
+#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		265
 #define QMI_WLANFW_HOST_CAP_REQ_V01			0x0034
 #define QMI_WLANFW_HOST_CAP_RESP_MSG_V01_MAX_LEN	7
 #define QMI_WLFW_HOST_CAP_RESP_V01			0x0034
@@ -258,7 +259,8 @@ struct qmi_wlanfw_host_cap_req_msg_v01 {
 	struct wlfw_host_mlo_chip_info_s_v01 mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
 	u8 feature_list_valid;
 	u64 feature_list;
-
+	u8 dynamic_mem_support_valid;
+	u8 dynamic_mem_support;
 };
 
 struct qmi_wlanfw_host_cap_resp_msg_v01 {
@@ -281,6 +283,8 @@ struct qmi_wlanfw_phy_cap_resp_msg_v01 {
 	u32 board_id;
 	u8 single_chip_mlo_support_valid;
 	u8 single_chip_mlo_support;
+	u8 dynamic_ddr_support_valid;
+	u8 dynamic_ddr_support;
 };
 
 #define QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN		54

base-commit: 1547a99cd8d8c1ab3e04dbd92b72b3b5f7cb85a9
-- 
2.34.1


