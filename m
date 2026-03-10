Return-Path: <linux-wireless+bounces-32912-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP91DfY8sGmohQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32912-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:47:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF713253E63
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 790BC321327C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B50A318EFA;
	Tue, 10 Mar 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oYalrSCp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K4Suhrcm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFC2FD68B
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155780; cv=none; b=cmqDRU/+FVin+iL3wGez5AlKa9xBiRO0g3Lk6TNYX06uL6Br+PCUXwTMgId4dUs8Sg94FP2TFW5s4oNTdQddAbM1XKs7pKGoxk4ULxirXiqJC4WB0f0Cq18ItehrPhMreOSDlwTO3+zT4Wu/hX4rjS+MZ0n0tPhWAeGySudspfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155780; c=relaxed/simple;
	bh=K+rufhdMHIpMLFzgsA1/xrZ0aq1658PLWs+Cw7fghJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AX70EKEaS8vr7e8jJUfYa+goOUtz+5OpqRINDRuhEzZ3/i8L5t7k4BeHO4ycqPyMnORxg12kwSaKBSSqitZg3gPd8mDttGuGNC0FVcISsq0bMMlKb5dh/DDN0V5OnJpQRLtkmQ86TAL+YpEc0AXvUQcPqkPGeJK780F7dxCHEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oYalrSCp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K4Suhrcm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaV4u963384
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7QRtgjL6YhmblrErajJMNeEeuRhcl0G8eAa6X9zELIE=; b=oYalrSCp9EC2AEJL
	BYOrejBHy1pEcinZHGReifgf4OrwtOeh6YP63vKbwTWK/rAdd7jaOI/3jTOZVIZg
	mh+dxABpo3pLa1SJ1g3yDSk33eaDg0wBP/19i9IitRANzT47YWhdEs6FgYL0UOAa
	q0Ndwe8g7AWE/Qv92kpSeHp6ZrMTZJUWGYe1X9J5RuwZSElNMvL4gauZxoS3fO7W
	GMSiv2IJxAWIjhQDU5ubYRFh6RvaWTzkawKC/zxre8lS7Q9mUM7OzvwOU4A2aIlj
	BV93BL/pI7/3DPUc+PdUXlbXm96UH5FD00RTwk6MT9RV/Xtqpk7pmW7scILjG03Y
	kb+Zdg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct477ksc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:17 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-40ed781f705so55817294fac.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773155777; x=1773760577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QRtgjL6YhmblrErajJMNeEeuRhcl0G8eAa6X9zELIE=;
        b=K4SuhrcmrOZEQXFotLXj3myWzlymVFGQgSUXlhfm/M1zQGXorOiC62oyzrSZsI4w72
         SCNJrv110ORmcMTr0QtJOqGK4MIczGWnYnzWm4BN3K+26eTFfdnN4BimMYRIKczeA+Dt
         OSJ+N1SPgbTuZwe50JpYzujUpOuVSpnsXuy+Pk+wTWGeprh5CbZZZZgUXY5LXwdkzLAa
         F/hgHfFSidZBXgyToH/VyqmtdZ6lst38yAAqg7IJgdQg1NqTgWcygoeHcIdfvQ1DcjdK
         9rsphgxyNbAnOLvkXhjR3FLLsKdvu7ndgmf6lMjCS85DTo01m6gd0XdMCL+u9jXoTNuL
         n09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155777; x=1773760577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7QRtgjL6YhmblrErajJMNeEeuRhcl0G8eAa6X9zELIE=;
        b=FFO2wkkuMQhFLZs+xiYN4Il2vkW0fh+tkAls26HFcsYQHehZFuRp9Dv0z8foxVTozG
         CQAqI2SiSOy9lDEVJ/E6edC6MCLuvuJGudgjBtb7q9x2W+MBuZvYi1/u+5xJWaDuMsDX
         cwKgxBFwo3KBklkySIEoS6Kfuc1oxmWr70/5EPgkCrUAC/LQItJQCsJXck4mug5JiY5a
         pItokjlF3DRBoaBoZkrkMvOXawuWFnCo/zYgPrQBc/nq6umHZtin2ve/hzFVEhPijXBQ
         sbKiTvmK3RsDvlu3DvcuiGap2P9/Dr086dH3KeiX5odFEESYU3rAFLEDElLC9TeRlE+b
         MNOw==
X-Gm-Message-State: AOJu0Yy6K8uBarhyonCKleJus3IpeIJc3STxTHoMqGVitD7dsNU9FrCx
	tw/pyyNpcx5GrV85gPCaPoGjPna4U+4wqyYeyIJ3QBKOPeOuZ0Bf2o0qHih7di6nFklf54hImCx
	v+5iGVY6B5Fjrp1G1+9NOQv+F5ywYDWSUx7D2HeQXmZxrIynOLY2nR1P9UMuawJZTZAIhXQ==
X-Gm-Gg: ATEYQzyxRUshdxaMa4MjIGWABczEk42T8+Msq1OmLocwLX6G/qZm61d/Mms1hPYgQzR
	vZolgepfn2VG85rfMkirLMEZavwX4TXPAhDGS6zIYheDgu0ccjGdGXpukCo3hbm5W60MzYXsNk2
	no4QgFEFq7xyY5RqQhyX+HlCL8Hh0h/UpHjPX7dGgX0bk+iJjxqoNZqsTS9tc4vAyaS8W//3P8F
	iphKi70GtZvizXeghobeUcqJZ/rwcfGHr+dE40k7VZhPiEvOz9wWwr7N7f63tVl0cKP3TergOce
	FYgM44b0Mb6n6U802gW2YgNLsW8HI97NyGYyseNmjHO5IWrbCm/XwGOUniHfqtlrCLlVi3GSlpB
	FjGnhd4XxL2Qr3SnVZgb8c6SZeZqIrMDnf7CarvbDifrRpxQIr6hVnuRyU48ZMlX0v61tmI3Mcl
	S3
X-Received: by 2002:a05:6870:34f:b0:3ec:5267:cb6e with SMTP id 586e51a60fabf-416e3ff5d5bmr8759325fac.23.1773155777263;
        Tue, 10 Mar 2026 08:16:17 -0700 (PDT)
X-Received: by 2002:a05:6870:34f:b0:3ec:5267:cb6e with SMTP id 586e51a60fabf-416e3ff5d5bmr8759310fac.23.1773155776796;
        Tue, 10 Mar 2026 08:16:16 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756dbc7afsm2714603fac.14.2026.03.10.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:16:16 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 08:16:12 -0700
Subject: [PATCH ath-next 1/2] wifi: ath12k: Clean up the WMI Unit Test
 command interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-ath12k-unit-test-cleanup-v1-1-03e3df56f903@oss.qualcomm.com>
References: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
In-Reply-To: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMiBTYWx0ZWRfX8/klB7WDyPi4
 6eMXxtCewrrUQryykZNcE8miQGmI+a6TVJee1UcWy1XKQOqzLsLWm/nzpHXgP95uf/M5wQU+jbt
 6eDl9XrXq15B2p03RwbrszJlqQbAMlsxlqv8cKAlqB0fKFI2DF+oyHtjTSJrQiracjFXAJwpptB
 5fOT7VgFJLQt+TQO3DWrBe5/r1lchpFW6V56i/c7kc3XuQ2hqn6la4L8tYc3FOH7kuDi+WWGgaT
 nU1mjSJdechPDRDU0CgiByjMAsVCedne8aS0KQGJ8KdZptcSPWSlx0lotXA8cLsaaU6KI0mZ78a
 3Pew6ehJZ77utsbQR1BHKT088f5Ks7FvIrRQRsQiK+qq4dXDnCrZxQoIJvJcmS6AyU0BgkjYYat
 SFDRFeVzLJbSdCHyLEUfp9yeEsmbyiK6tJWrpDheEajMU341fwqbvSRdxF8YaYCWR8jxu69Bcdj
 BNI1D3RqyOS2cneJuFg==
X-Proofpoint-GUID: 2sMKuvVRxxgzjlXeKsC0UJEDKTm-UtxU
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69b035c2 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=zm9tmq2CayTrKmE_1UcA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: 2sMKuvVRxxgzjlXeKsC0UJEDKTm-UtxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100132
X-Rspamd-Queue-Id: DF713253E63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32912-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently, ath12k_wmi_send_unit_test_cmd() provides the interface to
send a Unit Test command to firmware.  The payload for the command is
passed in two separate parameters, struct wmi_unit_test_cmd ut_cmd and
u32 *test_args.  This interface is strange in that it passes the
ut_cmd structure by value instead of by reference. But even worse,
this presents an interface that is not endian clean since the ut_cmd
structure is defined in little endian format while the test_args array
is defined to be in cpu endian format. Furthermore, the implementation
of this function passes the test_args directly to the firmware, without
performing cpu_to_le32() conversion, and hence this functionality will
not work correctly on big endian platforms.

In order to fix these issues, introduce a new wmi_unit_test_arg
structure which defines all of the parameters needed by the Unit Test
command in a single structure using cpu endian. Update
ath12k_wmi_send_unit_test_cmd() to take a pointer to this structure
and perform all cpu_to_le32() conversions needed while forming the
firmware command. Update the only existing Unit Test function,
ath12k_wmi_simulate_radar(), to properly fill and pass this new
structure to ath12k_wmi_send_unit_test_cmd().

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 58 ++++++++++++++++-------------------
 drivers/net/wireless/ath/ath12k/wmi.h | 11 +++++++
 2 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index b93e33edf369..65a05a9520ff 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -10017,50 +10017,46 @@ static int ath12k_connect_pdev_htc_service(struct ath12k_base *ab,
 
 static int
 ath12k_wmi_send_unit_test_cmd(struct ath12k *ar,
-			      struct wmi_unit_test_cmd ut_cmd,
-			      u32 *test_args)
+			      const struct wmi_unit_test_arg *ut)
 {
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct wmi_unit_test_cmd *cmd;
+	int buf_len, arg_len;
 	struct sk_buff *skb;
 	struct wmi_tlv *tlv;
+	__le32 *ut_cmd_args;
 	void *ptr;
-	u32 *ut_cmd_args;
-	int buf_len, arg_len;
 	int ret;
 	int i;
 
-	arg_len = sizeof(u32) * le32_to_cpu(ut_cmd.num_args);
-	buf_len = sizeof(ut_cmd) + arg_len + TLV_HDR_SIZE;
+	arg_len = sizeof(*ut_cmd_args) * ut->num_args;
+	buf_len = sizeof(*cmd) + arg_len + TLV_HDR_SIZE;
 
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, buf_len);
 	if (!skb)
 		return -ENOMEM;
 
-	cmd = (struct wmi_unit_test_cmd *)skb->data;
+	ptr = skb->data;
+	cmd = ptr;
 	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_UNIT_TEST_CMD,
-						 sizeof(ut_cmd));
-
-	cmd->vdev_id = ut_cmd.vdev_id;
-	cmd->module_id = ut_cmd.module_id;
-	cmd->num_args = ut_cmd.num_args;
-	cmd->diag_token = ut_cmd.diag_token;
-
-	ptr = skb->data + sizeof(ut_cmd);
+						 sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(ut->vdev_id);
+	cmd->module_id = cpu_to_le32(ut->module_id);
+	cmd->num_args = cpu_to_le32(ut->num_args);
+	cmd->diag_token = cpu_to_le32(ut->diag_token);
 
+	ptr += sizeof(*cmd);
 	tlv = ptr;
 	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, arg_len);
 
 	ptr += TLV_HDR_SIZE;
-
 	ut_cmd_args = ptr;
-	for (i = 0; i < le32_to_cpu(ut_cmd.num_args); i++)
-		ut_cmd_args[i] = test_args[i];
+	for (i = 0; i < ut->num_args; i++)
+		ut_cmd_args[i] = cpu_to_le32(ut->args[i]);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 		   "WMI unit test : module %d vdev %d n_args %d token %d\n",
-		   cmd->module_id, cmd->vdev_id, cmd->num_args,
-		   cmd->diag_token);
+		   ut->module_id, ut->vdev_id, ut->num_args, ut->diag_token);
 
 	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_UNIT_TEST_CMDID);
 
@@ -10076,8 +10072,7 @@ ath12k_wmi_send_unit_test_cmd(struct ath12k *ar,
 int ath12k_wmi_simulate_radar(struct ath12k *ar)
 {
 	struct ath12k_link_vif *arvif;
-	u32 dfs_args[DFS_MAX_TEST_ARGS];
-	struct wmi_unit_test_cmd wmi_ut;
+	struct wmi_unit_test_arg wmi_ut = {};
 	bool arvif_found = false;
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
@@ -10090,22 +10085,23 @@ int ath12k_wmi_simulate_radar(struct ath12k *ar)
 	if (!arvif_found)
 		return -EINVAL;
 
-	dfs_args[DFS_TEST_CMDID] = 0;
-	dfs_args[DFS_TEST_PDEV_ID] = ar->pdev->pdev_id;
-	/* Currently we could pass segment_id(b0 - b1), chirp(b2)
+	wmi_ut.args[DFS_TEST_CMDID] = 0;
+	wmi_ut.args[DFS_TEST_PDEV_ID] = ar->pdev->pdev_id;
+	/*
+	 * Currently we could pass segment_id(b0 - b1), chirp(b2)
 	 * freq offset (b3 - b10) to unit test. For simulation
 	 * purpose this can be set to 0 which is valid.
 	 */
-	dfs_args[DFS_TEST_RADAR_PARAM] = 0;
+	wmi_ut.args[DFS_TEST_RADAR_PARAM] = 0;
 
-	wmi_ut.vdev_id = cpu_to_le32(arvif->vdev_id);
-	wmi_ut.module_id = cpu_to_le32(DFS_UNIT_TEST_MODULE);
-	wmi_ut.num_args = cpu_to_le32(DFS_MAX_TEST_ARGS);
-	wmi_ut.diag_token = cpu_to_le32(DFS_UNIT_TEST_TOKEN);
+	wmi_ut.vdev_id = arvif->vdev_id;
+	wmi_ut.module_id = DFS_UNIT_TEST_MODULE;
+	wmi_ut.num_args = DFS_MAX_TEST_ARGS;
+	wmi_ut.diag_token = DFS_UNIT_TEST_TOKEN;
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_REG, "Triggering Radar Simulation\n");
 
-	return ath12k_wmi_send_unit_test_cmd(ar, wmi_ut, dfs_args);
+	return ath12k_wmi_send_unit_test_cmd(ar, &wmi_ut);
 }
 
 int ath12k_wmi_send_tpc_stats_request(struct ath12k *ar,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 0bf0a7941cd3..8d766dd5b304 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4210,6 +4210,17 @@ struct wmi_dfs_unit_test_arg {
 	u32 radar_param;
 };
 
+/* update if another test command requires more */
+#define WMI_UNIT_TEST_ARGS_MAX DFS_MAX_TEST_ARGS
+
+struct wmi_unit_test_arg {
+	u32 vdev_id;
+	u32 module_id;
+	u32 diag_token;
+	u32 num_args;
+	u32 args[WMI_UNIT_TEST_ARGS_MAX];
+};
+
 struct wmi_unit_test_cmd {
 	__le32 tlv_header;
 	__le32 vdev_id;

-- 
2.43.0


