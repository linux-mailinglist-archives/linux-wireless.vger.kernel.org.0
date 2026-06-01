Return-Path: <linux-wireless+bounces-37225-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCE1ADz6HGplUgkAu9opvQ
	(envelope-from <linux-wireless+bounces-37225-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:19:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535696192A7
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDDA4300AB27
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 03:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2E27703;
	Mon,  1 Jun 2026 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eZxvDY/a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCCpof1S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F818B0A
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283949; cv=none; b=E0Z/TsSymj0h7V2887+xvST3Uz3okUQ9MWGZv4QvMiBz54hBfbLkFt/WADV5LN7Wf28YzTYvZpYU0l2Zde/d0hKJ3cPkDMFM74oYGEgzOcepZy54UfVN0HauZkUtsZCt7y1Ohz4IGwmsC6d5FnQtanGzpr1SWgJnSIeyrHFid3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283949; c=relaxed/simple;
	bh=fkKy16xTaKlIqCVWgibEHXC4jNIUlr1lTfw7LmyOlFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b37wdwRdwEZJhXhJLmy0qdHeN5VfBPE/0sOt4i2xhIkjR/c/R1edBHMy9LhHqIqrUmsAuj9SbddfBVwVCug6pIA5+OlEzIGWeXA0s0SpYYAW1gu1VBvIPH4tvia/tig9mx7se4VRR4SBnuEmGfDPkJ2PmHFDPSYA1g5OuvXMu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eZxvDY/a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BCCpof1S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VH8h591286003
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 03:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qd1Ud/gLx8tjIkNIoBuyPO176UGs+/dpZBk
	Wv6jkelA=; b=eZxvDY/aWKCBPnmZzLYqEsPcB9e60TUrCWZA8l/IRNete0yZxOv
	BSuwgzK4GAQMourFDUUPjpS5goVNr2fn9EyuVR8GYR/qQ8LZBMForuUfHgT81kOd
	Xq0/W1FsKU7HhLQeC61cdl2Za2CcMha5RF0onZqmrQxB5R6g/rs4/fzm71TfwBF+
	3p36GiPiZapugDc/qupFQPlmrMOnZbMme/Gxq1z6VwPvCu4WYk89GhMIvCs6/sCt
	T/75UeSWY/HFchymWmc4CetAOXxVYPyA7Y6Q/O3KlOrdZz1dEEJj/Iky7BYq5PaW
	4KuLmE9QHqa7Y0NcVtr1dI4/6pSMXcbYMLQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efs66w7fg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 03:19:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2beff6b6e74so47681305ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 20:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780283946; x=1780888746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qd1Ud/gLx8tjIkNIoBuyPO176UGs+/dpZBkWv6jkelA=;
        b=BCCpof1SKgCaUtjz0EcdayOXhBgTu/hZielT3fFzlgsGLDuuKsJBNAZy75HdXhNkYD
         DJm9wWRMcM8pjWwYv+yHodPb0JkDF6Wqsm5xUFGwRaxlEuJZKdKzjtGcznwmYchr9Ct9
         fZwl84zDHLpbprBjoGqAft6axMbd79NYwJ1q96zOFOqorCAaRI1A2KibfHWB7pDeQFHQ
         acn9/UBqOPgwdZM5rX4z+Xs525JGF6DU/ee8nYlW9cIu6Sj1yDrY1zs0pqxqk/sOpgLq
         1Nq+yf/6v/G4QNmB58EBiwjMaWt4/QzKOL975CgRaOagh6axHODweXQP06mOFsVx/RQy
         ojXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780283946; x=1780888746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd1Ud/gLx8tjIkNIoBuyPO176UGs+/dpZBkWv6jkelA=;
        b=FnVCUF3Ajh2AJHBQc4pgxtI3mEhfgIU/GNu91flIO6Ys3tSngcEvu+k//XW65uoH0c
         H/1QUqjTtHmYljxHyIB+cn2lglPecVU2q7sUDVkGYaGNB+EAqa0jRLYs50T9HvQT+cSw
         mYnHwndgwMP/WVKL5XkRGfffXLWZz8bfoHVL4WLv513axxVe79zOtJjo0CSzrc7qKhxq
         rRvR+TuXm0gf5CQqVa7wUemf/8lRAS1arU1cmvWdrfjJo0g5LQ3udX2GT/HVlYKjQYFt
         l9sKyce4iNb0YkKYPH3yazjjWYvnW7ECG8MKF5HZRpr7LKwBrXGbyITSk+gus2nUBpRF
         jclw==
X-Gm-Message-State: AOJu0Yz/g0ZiI7Fw8LhN9/2nWmemgnAKcydiw6v8N9gs44W/4h9j9030
	YFXgRrlih7kSggmsxTEIJzUBiHXgvKZBtByjHMB37hwFqNvNPvCd+8pYv1tulf0Baz2Zz2AUUqB
	8VLUvqoXWuMYf+bnF44FePBXXQEeX78RrpotEphL7JMtZxm91/fY2HD8QFZP631kDStD+uBtrn7
	ulKw==
X-Gm-Gg: Acq92OEFEFTJytVP5gZ+CHlxRdXvd+zG/fTACWj1YdkkRyi6TChZipd/xfwUyJpslzq
	+XUU7MQL26oYiTeWBbhkXz5R8rkahkA1ktammIpi7Vv/Z1hN/lyghCsQoKXWSRhLmRfmOuPbojn
	5bNmcFAQXw7AhzZAF+TauCogE/INjFkVfpzyjBgzQUkfvwu7e7mVN1wOoVlxBtOndQxsJOw3DIy
	tYR8QJfGgTNCnPmJbOcAh16XPhnVkMGIiArhOQykha0W42+GQPvaQ7WiZ84z6/r6l1rQdI8BlB4
	VlqjLZ1Q6Eptw7YAa4DWmZkvQWv2XwjGyx1O0vKx+USR+S9yEHa9RoCEisMmwIdYYrpiCyu8TQg
	uyrAW3daToEeD2LuYAut6V2kZiVzX3q7pAj4vveoMIpDVgQ8Wk2NIXCUPzo73TvuxZLfGUeiel1
	K61vMV/FiVDo4U6+0lA3w8dvFgqfGg15L14+zSpIT5XHFJliE1hn+8E44=
X-Received: by 2002:a17:903:986:b0:2bd:2de3:519a with SMTP id d9443c01a7336-2bf367939b7mr92783645ad.7.1780283946041;
        Sun, 31 May 2026 20:19:06 -0700 (PDT)
X-Received: by 2002:a17:903:986:b0:2bd:2de3:519a with SMTP id d9443c01a7336-2bf367939b7mr92783215ad.7.1780283945486;
        Sun, 31 May 2026 20:19:05 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd6desm88336815ad.24.2026.05.31.20.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 20:19:05 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: add QMI capability negotiation for dynamic memory mode
Date: Mon,  1 Jun 2026 08:48:50 +0530
Message-Id: <20260601031850.3715354-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzMSBTYWx0ZWRfXzbjXGrywAwQT
 WYdS7V9HS5qoL6lIg1wDsRsRy5IBqwiEtsFw46hvxWBTOt/FVqYP3qnQXL5ScuqPxC92fZ/hIKT
 TgBi8j5xSDGYBczZTaFrmpinNmhl9drMYIof8CanSp0Mj88x9RYok6F4ScQSOwN37sCfqcOFPWC
 kzKFmv0l64PYUwuZ92sVd5/X7IRLEGEn5cfF5Vw5tmIWYWDojAtMO6+nuvriPXjr9dV/Ha2q9i6
 c8COpVxibMrnqMSx5B9YkMxetmxNLRxRwGmzpW3WEMRvZ6j8V3nxE5f7lt2p6CTrTRsn8LJYiHc
 ZrwsvOjBimDbNx3TmFNMP1BwuadfycWd409qfmeMa4cUkjOdQQ0aIYk4G4mulFVW6yZqAasdv8L
 m7apHmYkD9hoYqBubUujSAT8bVL4bSQd6j6KjYbJkyuB4dMfK0ZQMDomAsQuCze2GKo6ZhZa/eF
 9z+oRfXGqCJ+8pDgU6w==
X-Authority-Analysis: v=2.4 cv=X8di7mTe c=1 sm=1 tr=0 ts=6a1cfa2a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=FGVNU_2SYgeZMn_85CMA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: qDeo7nwVhJu47lUaPVND_yhMNNTeOI29
X-Proofpoint-GUID: qDeo7nwVhJu47lUaPVND_yhMNNTeOI29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010031
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37225-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 535696192A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/qmi.h | 10 ++++--
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index fd762b5d7bb5..85406d6e6da1 100644
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
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x17,
+		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   dynamic_ddr_support_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_1_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x17,
+		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
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
+		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %d dynamic_ddr_support %d\n",
 		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
-		   resp.num_phy_valid, resp.num_phy,
-		   resp.board_id_valid, resp.board_id);
+		   resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
+		   resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);
 
 	return;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 2a63e214eb42..dbde76e5a78d 100644
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
@@ -267,7 +269,7 @@ struct qmi_wlanfw_host_cap_resp_msg_v01 {
 
 #define QMI_WLANFW_PHY_CAP_REQ_MSG_V01_MAX_LEN		0
 #define QMI_WLANFW_PHY_CAP_REQ_V01			0x0057
-#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN		18
+#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN		22
 #define QMI_WLANFW_PHY_CAP_RESP_V01			0x0057
 
 struct qmi_wlanfw_phy_cap_req_msg_v01 {
@@ -281,6 +283,8 @@ struct qmi_wlanfw_phy_cap_resp_msg_v01 {
 	u32 board_id;
 	u8 single_chip_mlo_support_valid;
 	u8 single_chip_mlo_support;
+	u8 dynamic_ddr_support_valid;
+	u8 dynamic_ddr_support;
 };
 
 #define QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN		54

base-commit: e6b476e4ea19919b4c06ba2f5504258ab5d5d9aa
-- 
2.34.1


