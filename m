Return-Path: <linux-wireless+bounces-37991-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uPQIFekHOmpD0QcAu9opvQ
	(envelope-from <linux-wireless+bounces-37991-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 06:13:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB466B3F87
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 06:13:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SxllELRg;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Zq4conXC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37991-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37991-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F115D302803D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 04:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9601A3A381D;
	Tue, 23 Jun 2026 04:13:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776863A257F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 04:13:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187999; cv=none; b=S4QjgroHNpOS5G+Z6+GD7x45yl+TfZ9mvymeKHflwGpR3qqhs1JPl7l44NlJ/6pDdkGGNVeI/Yd3A3+DF5H0q4croXa0RJt9K8opMfxejAb7+S3EmpumwE+SeQ2Zaefe4zg1oVZUzKg/wxQjKqsxrNdSgDew6HLdPXXAxVjCI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187999; c=relaxed/simple;
	bh=R3ZbpbLRqKlrVig7omLat8jNpa9fs221thCZvpGI95o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sDRfCbNsOZV/4G0nx6aUEneN34dTGUse0+6MP171ilWRiklqpm4fuI9JI+s5atlrywSS7OXNOrZyd6Xjp1Vv1svXxSw6VfRehFe9QqTQ7SBSxHihuaIJC0DBmrvBvrDcBITdlxVgAnA5TbijpSGh7luYs23XzugVdNjrWijcESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SxllELRg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zq4conXC; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0iW6M2200465
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 04:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1IZbHyzoXo/3ZP5PNgxLFx
	k3VP+JtWM62ECDSBs3Fnk=; b=SxllELRgb/YLCyRRluN3K3pLVnQ6UqTmHXZYva
	NNnJwVkNr1PAFljr3hu7C0o4iMXhQOt2EqW7jO/YwBTW0977d/rSF6Oe88+h+3rs
	b53YVF73OdW+WfO0hpQaqtBLi95lbjZDta6IBF6401kR/8psuz/GlXvf7HhS2xkW
	MlPRKvTrSwBuoAnUzr6jHJufgn0YQSCTmYpPc21Le5CRbn3rP3oMjUJ5/PvkyO90
	KAwZZ5jSawuHQ92mWTDnhXALWvv4TDJshipsBXEb+O7ispgXVsu5nwGqZN/3lLuP
	6ueDdfgxGcDrg9oBDI3BhYL2PSY6RHIQpAEW3CeeNT++kM9g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0uehy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 04:13:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-845338eb797so486481b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 21:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782187996; x=1782792796; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IZbHyzoXo/3ZP5PNgxLFxk3VP+JtWM62ECDSBs3Fnk=;
        b=Zq4conXCAzmFlzSF7rMQRGzBEL6NNuriRef8FSRe/nRP8YI9LUBJl42PK8qSpHlUB2
         2aPQnyExXAbv7pspGX6G2cFB2PtDWzdpjZzX3nS1zl0BjQrMDCOCYNYdVC/YNWIKgzCQ
         qncneuq0ZQFt1V1hFsu/uSLcDxOMO+mqiXvbusEMwH5aAChVSCuEDu5iYN8qpFo5LXAW
         BSvvQsX3ndY2JYBZ1LOiNEebTvoxKishjbV/BLXPqyu8EPmLDEtRIP+CHy34JmrLfFeO
         nJ8k+N4dCjjdQyGyKuTvRuG/ghlMofillBP3X3WZsQDAhQlrg4ffNL+AYGScQjYrF6Nn
         etgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187996; x=1782792796;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IZbHyzoXo/3ZP5PNgxLFxk3VP+JtWM62ECDSBs3Fnk=;
        b=DMjqa1kqyvU7As8Y30/y+3W5Ab//UdURwlAbfEDSlSJWqCVyfuFkiz9epFAwDLWwtB
         IuotX6oxckYLJAXXRSLeXhL+YHYLE0C2+oAdcJ6sdlAiz+oaKy4ysktSLkgT0GBZTj4E
         hMLRWe3s2b2LW22Tyy/oqwNUDlsAbRt2YBvl0UrYrqhKam0tVYElTumSRfM2STw4RA+X
         oK+l7FgUWrlO1nGbqaPxVJ099MCR2HmPi4QK6M8IaiYvRZf4E2N5ji1ZGAy2RG90AMMl
         Rea+/lHNQ2BmRQpsnXgqZVpW//cwh9hnvY1JgeTTT6SwdQaQDu+WN+rCjppLhikzCVR9
         DWzA==
X-Gm-Message-State: AOJu0Ywe+c5KvZLUkpJ3mIc8FgYhKchtsHpwFbnbrK6svhMyZ61WrLxq
	hSGY7UHY49w9CDSjjDsk65aB4nJWoo1PtHhbQf0azZs7GJOvMTU+3B/SmsgvkUUewTrli4odDjP
	EYVB+VIDlmnNI8HtoSVL16cXOaJZqbx65r0fCXiM9mxap7qbSi9S/24D1m84DPRV2agrwFQ==
X-Gm-Gg: AfdE7cl9HgHgYecvz6Qi0jmwY7V9Lp+Hf20ymnBuXVzipCR32b2LH9YHIIOuJv9YgKu
	Cp3QEbhsWJuDKrxZcAsWx3ihxsd1Lg3Hj7szUWtNsaIXqbXGXqv58iXyI1tiomRH9oma6wXFm5t
	N5hsKcx6yTUKD2JP6VPRdJ83wyF11wcICtN/1phnuS1l46En9FnjAfb7YzrEFsLmt+ouSAY1/gd
	kLTo3MnJG2TT59EHSkhCGyPr7xOENYJrsrAPM5+0ZGT7vYEs+wnY9tptswd+ziQRfRgh6uxZxKi
	NHpyp+63313gHV5t1HO8Pq9NZU8ELNIPpJK30lF6yPEgmqU3YVDCT+bq+lnxIzwqjxFwMYZMNcb
	Mh4S4gnqdaE6TcyhDJ/Km+BoFlqwH+MV6YdBJfWKr9SEdom6kdEXHNQQ+/yQjQa+8xGB6jhY9lF
	JSMPguRCBjZ1SAPxqQY4pGMCexhBWE
X-Received: by 2002:aa7:88d1:0:b0:82f:684a:84ea with SMTP id d2e1a72fcca58-84591c2bf32mr1765417b3a.13.1782187996026;
        Mon, 22 Jun 2026 21:13:16 -0700 (PDT)
X-Received: by 2002:aa7:88d1:0:b0:82f:684a:84ea with SMTP id d2e1a72fcca58-84591c2bf32mr1765398b3a.13.1782187995565;
        Mon, 22 Jun 2026 21:13:15 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c2d9sm12159382b3a.6.2026.06.22.21.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:13:15 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 09:43:09 +0530
Subject: [PATCH ath-next] wifi: ath12k: Fix inconsistencies in struct
 qmi_elem_info initializers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-qmi-inconsistencies-v1-1-0fc17f2b8338@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANQHOmoC/x3MQQqEMAxA0atI1hPQVit4lWEWtaaahdFpigji3
 S0u/+L9C5QSk8JQXZDoYOVNSjSfCsLiZSbkqTSY2rjaGYv/lZElbKKsmSQUjLYN1I0x9sY7KHJ
 PFPl8r1/weUGhM8Pvvh/DRjctbwAAAA==
X-Change-ID: 20260623-qmi-inconsistencies-34ce5bff72a6
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzMCBTYWx0ZWRfX+4znjvTX6P2y
 QG/6nKRhvY3QnzIJkQKQoH6D8Nkl96oCz0PBaonm8nfFdMRx4HmK2Hd/S/iL9uAYzJnqK98J2yH
 6AS6chvvJ+aHzVAu98WQLjfNjnHSWuM=
X-Proofpoint-GUID: CtDz2oglSE6CWC3brF4G8LeZTr5170En
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a3a07dc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=5wuKFw-Lxssn0LJ63IsA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzMCBTYWx0ZWRfXyf/MDVX8TvNF
 id3I0T3IJpqUFWkBNZuE8jGnHe7oaIVtesHYj4pTSYFH3ZdQZrw3wtQAjFXNo7dEwyDRnBsGAz0
 GoQTeRldNdZOC95PPdS024GTN4PMUmT1twxT5nhH9ncmGQtOB8EbH5zAeo3QmAryoKJTq1S5E+8
 xoOSYdBLHX/b4IBG/r+hvWtiJ0Qi2xkVd809ON7EgUO+9FDjbH+wzqdMJwogCWussrb19JK+hG1
 8BvmgpLln678HbtqG1t3QwVdzkhA7xmq3kTXDkzi50OsNFoFfll/saCfSNEt7rdjsQTBWSVcBzl
 YDwPAb1DrFYfX4ri5kD8rWcDxCDHf9R96Hk1MImjY6vm803AdsmUJ+6fN/RO8M7+RSmAFYD5Jqc
 Q75tWr18fkbErcs8Fvn19q70/rhnVpe7vkcb9znUewnY/ragAHJBUBy5ArWrgySpf1fq59jPvu7
 O7RTv9mCnxQQDRWht4A==
X-Proofpoint-ORIG-GUID: CtDz2oglSE6CWC3brF4G8LeZTr5170En
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230030
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37991-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:raj.bhagat@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACB466B3F87

Currently, the struct qmi_elem_info initializers in qmi.c are inconsistent
in how they align the assignments, with tabs being used in the majority of
places but spaces being used in some places. In those places replace the
spaces with tabs for consistency.

Also fix incorrect and missing terminating records in the following
qmi_elem_info initializers:
- qmi_wlanfw_shadow_reg_cfg_s_v01_ei[]
- qmi_wlanfw_mem_ready_ind_msg_v01_ei[]
- qmi_wlanfw_fw_ready_ind_msg_v01_ei[]

Tested-on: Compile tested only.

Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 144 ++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 69 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index fd762b5d7bb5..c176cc150f64 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -21,45 +21,45 @@
 
 static const struct qmi_elem_info wlfw_host_mlo_chip_info_s_v01_ei[] = {
 	{
-		.data_type      = QMI_UNSIGNED_1_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
 		.array_type	= NO_ARRAY,
-		.tlv_type       = 0,
-		.offset         = offsetof(struct wlfw_host_mlo_chip_info_s_v01,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct wlfw_host_mlo_chip_info_s_v01,
 					   chip_id),
 	},
 	{
-		.data_type      = QMI_UNSIGNED_1_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
 		.array_type	= NO_ARRAY,
-		.tlv_type       = 0,
-		.offset         = offsetof(struct wlfw_host_mlo_chip_info_s_v01,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct wlfw_host_mlo_chip_info_s_v01,
 					   num_local_links),
 	},
 	{
-		.data_type      = QMI_UNSIGNED_1_BYTE,
-		.elem_len       = QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01,
-		.elem_size      = sizeof(u8),
-		.array_type     = STATIC_ARRAY,
-		.tlv_type       = 0,
-		.offset         = offsetof(struct wlfw_host_mlo_chip_info_s_v01,
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01,
+		.elem_size	= sizeof(u8),
+		.array_type	= STATIC_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct wlfw_host_mlo_chip_info_s_v01,
 					   hw_link_id),
 	},
 	{
-		.data_type      = QMI_UNSIGNED_1_BYTE,
-		.elem_len       = QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01,
-		.elem_size      = sizeof(u8),
-		.array_type     = STATIC_ARRAY,
-		.tlv_type       = 0,
-		.offset         = offsetof(struct wlfw_host_mlo_chip_info_s_v01,
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01,
+		.elem_size	= sizeof(u8),
+		.array_type	= STATIC_ARRAY,
+		.tlv_type	= 0,
+		.offset		= offsetof(struct wlfw_host_mlo_chip_info_s_v01,
 					   valid_mlo_link_id),
 	},
 	{
-		.data_type      = QMI_EOTI,
+		.data_type	= QMI_EOTI,
 		.array_type	= NO_ARRAY,
-		.tlv_type       = QMI_COMMON_TLV_TYPE,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
 	},
 };
 
@@ -585,21 +585,21 @@ static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
 					   board_id),
 	},
 	{
-		.data_type      = QMI_OPT_FLAG,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type     = NO_ARRAY,
-		.tlv_type       = 0x13,
-		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
 					   single_chip_mlo_support_valid),
 	},
 	{
-		.data_type      = QMI_UNSIGNED_1_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type     = NO_ARRAY,
-		.tlv_type       = 0x13,
-		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x13,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
 					   single_chip_mlo_support),
 	},
 	{
@@ -1625,42 +1625,45 @@ static const struct qmi_elem_info qmi_wlanfw_m3_info_resp_msg_v01_ei[] = {
 
 static const struct qmi_elem_info qmi_wlanfw_aux_uc_info_req_msg_v01_ei[] = {
 	{
-		.data_type      = QMI_UNSIGNED_8_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u64),
-		.array_type     = NO_ARRAY,
-		.tlv_type       = 0x01,
-		.offset         = offsetof(struct qmi_wlanfw_aux_uc_info_req_msg_v01, addr),
+		.data_type	= QMI_UNSIGNED_8_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u64),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x01,
+		.offset		= offsetof(struct qmi_wlanfw_aux_uc_info_req_msg_v01,
+					   addr),
 	},
 	{
-		.data_type      = QMI_UNSIGNED_4_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u32),
-		.array_type     = NO_ARRAY,
-		.tlv_type       = 0x02,
-		.offset         = offsetof(struct qmi_wlanfw_aux_uc_info_req_msg_v01, size),
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_wlanfw_aux_uc_info_req_msg_v01,
+					   size),
 	},
 	{
-		.data_type      = QMI_EOTI,
-		.array_type     = NO_ARRAY,
-		.tlv_type       = QMI_COMMON_TLV_TYPE,
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
 	},
 };
 
 static const struct qmi_elem_info qmi_wlanfw_aux_uc_info_resp_msg_v01_ei[] = {
 	{
-		.data_type      = QMI_STRUCT,
-		.elem_len       = 1,
-		.elem_size      = sizeof(struct qmi_response_type_v01),
-		.array_type     = NO_ARRAY,
-		.tlv_type       = 0x02,
-		.offset         = offsetof(struct qmi_wlanfw_aux_uc_info_resp_msg_v01, resp),
-		.ei_array       = qmi_response_type_v01_ei,
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_wlanfw_aux_uc_info_resp_msg_v01,
+					   resp),
+		.ei_array	= qmi_response_type_v01_ei,
 	},
 	{
-		.data_type      = QMI_EOTI,
-		.array_type     = NO_ARRAY,
-		.tlv_type       = QMI_COMMON_TLV_TYPE,
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
 	},
 };
 
@@ -1772,7 +1775,8 @@ static const struct qmi_elem_info qmi_wlanfw_shadow_reg_cfg_s_v01_ei[] = {
 	},
 	{
 		.data_type	= QMI_EOTI,
-		.array_type	= QMI_COMMON_TLV_TYPE,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
 	},
 };
 
@@ -1925,7 +1929,7 @@ static const struct qmi_elem_info qmi_wlanfw_wlan_cfg_req_msg_v01_ei[] = {
 		.data_type	= QMI_OPT_FLAG,
 		.elem_len	= 1,
 		.elem_size	= sizeof(u8),
-		.array_type = NO_ARRAY,
+		.array_type	= NO_ARRAY,
 		.tlv_type	= 0x13,
 		.offset		= offsetof(struct qmi_wlanfw_wlan_cfg_req_msg_v01,
 					   shadow_reg_valid),
@@ -1934,7 +1938,7 @@ static const struct qmi_elem_info qmi_wlanfw_wlan_cfg_req_msg_v01_ei[] = {
 		.data_type	= QMI_DATA_LEN,
 		.elem_len	= 1,
 		.elem_size	= sizeof(u8),
-		.array_type = NO_ARRAY,
+		.array_type	= NO_ARRAY,
 		.tlv_type	= 0x13,
 		.offset		= offsetof(struct qmi_wlanfw_wlan_cfg_req_msg_v01,
 					   shadow_reg_len),
@@ -1943,7 +1947,7 @@ static const struct qmi_elem_info qmi_wlanfw_wlan_cfg_req_msg_v01_ei[] = {
 		.data_type	= QMI_STRUCT,
 		.elem_len	= QMI_WLANFW_MAX_NUM_SHADOW_REG_V01,
 		.elem_size	= sizeof(struct qmi_wlanfw_shadow_reg_cfg_s_v01),
-		.array_type = VAR_LEN_ARRAY,
+		.array_type	= VAR_LEN_ARRAY,
 		.tlv_type	= 0x13,
 		.offset		= offsetof(struct qmi_wlanfw_wlan_cfg_req_msg_v01,
 					   shadow_reg),
@@ -2003,15 +2007,17 @@ static const struct qmi_elem_info qmi_wlanfw_wlan_cfg_resp_msg_v01_ei[] = {
 
 static const struct qmi_elem_info qmi_wlanfw_mem_ready_ind_msg_v01_ei[] = {
 	{
-		.data_type = QMI_EOTI,
-		.array_type = NO_ARRAY,
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
 	},
 };
 
 static const struct qmi_elem_info qmi_wlanfw_fw_ready_ind_msg_v01_ei[] = {
 	{
-		.data_type = QMI_EOTI,
-		.array_type = NO_ARRAY,
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
 	},
 };
 

---
base-commit: 1547a99cd8d8c1ab3e04dbd92b72b3b5f7cb85a9
change-id: 20260623-qmi-inconsistencies-34ce5bff72a6


