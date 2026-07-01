Return-Path: <linux-wireless+bounces-38428-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p2PWFamURGoOxQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38428-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 06:16:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D26E9A79
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 06:16:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=kedfVAW9;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Mc0TfEBS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38428-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38428-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F22803010BA5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 04:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97029221D89;
	Wed,  1 Jul 2026 04:16:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D8391E57
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 04:16:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879388; cv=none; b=sfgUNphPyM7aHROWYNDqMHKCcheYz5OJhf9sx+F0ZJ1vJ2C7VXfAg2r7WLdQ99O18QfNdfE9MaimCoAH/EJrMcrUZKfs6By4o0HUAH7Tm6VP6MQFqXje8xKWva82snmf9yFp+SNKUFs5HDMC8b2o26JCK0jEYSn1apkx3F5cum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879388; c=relaxed/simple;
	bh=tUJV1t9TVxiwZ+atpr6MbKcz93e0CVD1PDsA8rtlDXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ou6cja1PVoRHsB68x4VF0H3qVDKEhMFkd2LxMfwIMTXKIktITkRwsuNiYKI7wEhw44KmLwL/5eNH3FTc+XJ1QA2McxEml0agiG7Krr18A4pp/FWN1PukQSr3i+twhKWMZJi4C8jdlAXdnzK09NGTL4VYlRN7s4OnvpnECxGjwHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kedfVAW9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mc0TfEBS; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612tV573867981
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 04:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ycXyi+wv38YvNjsM48RPX109avL7iaPl7sH
	kupEPGpg=; b=kedfVAW9aDSOcYC+Fu+MXXG2ZQtm8sPFKvvsFZ4uTpLb/b92/VP
	IiaL4p328tsJXUiA1z7hd10J1D6lEfZlYNp2baCHvVUIfiOJQm7QmrVUblyFjwXk
	8rY+mtYWzZjxR//KykmTmYKKLK4l/Mjb5mBWN0azp4AdRbyT4B4oq0F3ey8xMg6G
	NR1NRo9ptB5nH13H2PtTDbFEzj3aubTxyXw16PWH0pbeD7qBz5M02kkDK9CzWzqu
	5mJtIh6yxmqB+T3R3xdo/ySZjLI3sbyRN5K/oo/j0eXh4uFk7szR5Py5a4BX7LMN
	3S7ff5BU4WML2XLHjHOTx2cYLdYYyB6sDGw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfyafk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 04:16:19 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139c6673856so318294c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782879379; x=1783484179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ycXyi+wv38YvNjsM48RPX109avL7iaPl7sHkupEPGpg=;
        b=Mc0TfEBSv4R+tUiUP+dWDtpIoR/b4iI6/cZRmx72MpIy2olV6dUyf38M4KWXO9uhlO
         mP63nSy1Akk7sNptI0QGR1e/qd9RksDko+XUb3iC7h31KWv3OZKxc4n+u6/y3f/u0H65
         hrkjsn72eSq7JX9BtjTJInTBDbcKiGKcFgece1h/yX0q9aytVPiLyVYluwE8UxQvk1Dk
         GDgJ/OsF+PRBAQvxUTy7HF9cSW29pUUocQX34aBi+6n5UP23Ou6v3rlzgXht+tATek01
         YM8Qp3u5TJIVmNDl/ocFXZfku4ZuGVjVD5ZcFAmc8+R7Oc7X94MyDaSmdGE/hagfo1z/
         8cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782879379; x=1783484179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycXyi+wv38YvNjsM48RPX109avL7iaPl7sHkupEPGpg=;
        b=rp3iMTitY25DHwB0xOVyzFiCQABXENnXzyNZcvNUwprEh9yz6/lbb24s8bXwfXroAW
         dKTdMDABa0hpPbyX+4FwKqgCqWyik8OvnYFVNBXbo/tLq15KL/wsIdv1WMHGegwfxl5v
         I35QRBELX4hJT0MHB+uHDbPt1hXDNmkvtRnXcsEKSaKEinBQarKcfZjUGiOx4bjOX17b
         H2sb/dNeO+cul1IFYCpXjfYUJhU/6BGbN+FUSWXJflcP39fMVxsOkwFRsSg5aADXSVjI
         aF9dgLBs1Kr0mxAYeW59PtnpRX9J6vcPQb13e4THviCRFNpJ8S7LYrZtr7zWLvGxm2dr
         ZlKw==
X-Gm-Message-State: AOJu0YxdpkDBghQ8Gqao0agOsc2U6mWmILlyDtc2sZ8wY0pyna3mBG7X
	nYCRBGzY9ELDbJpX15hWMoNYS0vGK/VCIJGNImCzv0lT/WVZ3DF/4ir6gion7RDRotKrWhGHNBt
	vF38wd9dM3Qgtin36tdsoRFTFxFClwcSRFXuJTwIwjpl5l88+XrBJzk+1TqwolXgCcw8v3+Xg3z
	TE0g==
X-Gm-Gg: AfdE7ckiItsJnAXl3XcIeDIAXHmv7vGWU36yq1ucGsCF86TUdztC6N8kFVLCzfoXfEz
	j4OyqzXrwnawLwzw8mePxeUTn/dZkSmdkpbiCb8Y7WjutLu4KhjLGNH//k5CM/tB3/Ae+I4w87a
	UMtzyfq7Wmzsux0vjVHALb4LhjRjy3OWc0Fg3U8cSU9zt0JxcRVri7ExuJfOWofhiIY6ASNureX
	sqMPVpSl4orQVq3e2LCTpMAAVVQ/ToYd21ZQplhNIiZRzQeG2kt1D3Jup0vqoVpRJtX4gNzpjR9
	6sqqeOjlYt5VAszYOl1MNkBCXYzalY0KM5KFWZq5FpaR/hdkYLtSUGg+V4Ndh0dFKd7ptE3EwBd
	v8V2I8lNHrODyGHMxPLNSoghncj9wuWlh4zhG+/tx5gwVm+ADO0hVDoj8yTfju9GdHiGiSzjMuV
	uRjW/5s4jBrI2wUW+hU0UUUqbFTH/CZ4HTJg==
X-Received: by 2002:a05:701a:c94e:b0:136:da48:5edd with SMTP id a92af1059eb24-13b36d74b44mr140292c88.4.1782879378628;
        Tue, 30 Jun 2026 21:16:18 -0700 (PDT)
X-Received: by 2002:a05:701a:c94e:b0:136:da48:5edd with SMTP id a92af1059eb24-13b36d74b44mr140254c88.4.1782879377882;
        Tue, 30 Jun 2026 21:16:17 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab20921sm11246491c88.4.2026.06.30.21.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 21:16:17 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next v4] wifi: ath12k: add QMI capability negotiation for dynamic memory mode
Date: Wed,  1 Jul 2026 09:46:11 +0530
Message-Id: <20260701041611.3077185-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a449493 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=9vsdZt7S848NgKRuMzYA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: 19mdRjAVE-G8PnnSYVmQL-t2ngiG0MEq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0MCBTYWx0ZWRfXwtkl5PmkRsoP
 CMQcfo0TJwz39AW8qG+Y+DzFpiLmtTU7foSx6LiX4Akr3/oEf3EzHBDpDVH9QLi4NDMkaPL0kEa
 uSq07FxCse1gI1q6L0y4ZUBULADGAkc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0MCBTYWx0ZWRfX0cTLsYC0xEbt
 Mt9H/ft63QxpEvMwLK0mw7Rm6HUY8rQNUq4nAe7fJht0kT9WidDSWaEpSjxOdoJpQDZIQRHxnPR
 oVyzfE8UeaV+7R+l0Eg+15SFpaGwHg7EHxDeSl+5+Pctg+T9TCc2pG2mEibOSZwezQwhXOiR6UQ
 vNNYGhe7ON33rdpU8lWUE3dMAtP9PADRCCrFPxxWn98Qh8bw5jz2hAX64sPGPtnB7lNdpBQi0Zs
 uDP8zFVSEO6l/y+9UAhpj5JinmCGiFBULmfQ+8LeUo7rpjS5lZPzQ0QSg8jPWxUrnVVLd7r05jC
 dpEBkObwwcOC5Pofho7O3DnSSytOi3mCPdRsldodY2K0XDvaJ+fJXFLWA3zDhQfufE6Oc7NRbJ/
 hAJ0ghmn3FLa2mF68jEivz9hvu3p+V6NIVrMHaOEkyq9gUGbx/t84IEiGv2bfv28AtABq1jhohh
 DFyuFx/00N3IjNepDEw==
X-Proofpoint-GUID: 19mdRjAVE-G8PnnSYVmQL-t2ngiG0MEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010040
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38428-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,m:rameshkumar.sundaram@oss.qualcomm.com,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA9D26E9A79

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

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
v4:
  -Rebased on ToT.
v3:
  -Restored QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN change.
v2:
  -Dropped QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN and QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN changes.
  -Used %u instead of %d in the debug log.
---
 drivers/net/wireless/ath/ath12k/qmi.c | 49 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/qmi.h |  8 +++--
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 1f3efcc16ac3..cabdd544bbc7 100644
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
 		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
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
@@ -2254,6 +2290,11 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
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
@@ -2325,11 +2366,15 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 
 	ab->qmi.num_radios = resp.num_phy;
 
+	if (resp.dynamic_ddr_support_valid)
+		ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
+
 	ath12k_dbg(ab, ATH12K_DBG_QMI,
-		   "phy capability resp valid %u single_chip_mlo_support %u valid %u num_phy %u valid %u board_id %u\n",
+		   "phy capability resp valid %u single_chip_mlo_support %u valid %u num_phy %u valid %u board_id %u dynamic_ddr_valid %u dynamic_ddr_support %u\n",
 		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
 		   resp.num_phy_valid, resp.num_phy,
-		   resp.board_id_valid, resp.board_id);
+		   resp.board_id_valid, resp.board_id, resp.dynamic_ddr_support_valid,
+		   resp.dynamic_ddr_support);
 
 	return;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 80a9b42a2548..cbe5be30053a 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -153,9 +153,10 @@ struct ath12k_qmi {
 	struct m3_mem_region aux_uc_mem;
 	unsigned int service_ins_id;
 	struct dev_mem_info dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
+	u8 dynamic_ddr_support;
 };
 
-#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		261
+#define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		265
 #define QMI_WLANFW_HOST_CAP_REQ_V01			0x0034
 #define QMI_WLFW_MAX_NUM_GPIO_V01			32
 #define QMI_WLANFW_MAX_PLATFORM_NAME_LEN_V01		64
@@ -253,7 +254,8 @@ struct qmi_wlanfw_host_cap_req_msg_v01 {
 	struct wlfw_host_mlo_chip_info_s_v01 mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
 	u8 feature_list_valid;
 	u64 feature_list;
-
+	u8 dynamic_mem_support_valid;
+	u8 dynamic_mem_support;
 };
 
 struct qmi_wlanfw_host_cap_resp_msg_v01 {
@@ -274,6 +276,8 @@ struct qmi_wlanfw_phy_cap_resp_msg_v01 {
 	u32 board_id;
 	u8 single_chip_mlo_support_valid;
 	u8 single_chip_mlo_support;
+	u8 dynamic_ddr_support_valid;
+	u8 dynamic_ddr_support;
 };
 
 #define QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN		54

base-commit: 68151ce3373843fa89490d2d92f0497c4877c845
-- 
2.34.1


