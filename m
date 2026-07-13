Return-Path: <linux-wireless+bounces-38948-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yX5iHn+VVGp6nwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38948-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:36:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D285D748388
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:36:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=l7lXHSHl;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=P4AxHARL;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38948-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38948-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20425302E30B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1D738E8DA;
	Mon, 13 Jul 2026 07:30:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8035837E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927846; cv=none; b=CK/wapf4acGG/hGMdV2eYdHrPO8hRUNDhd+pN997ICYu5pMF+nTMSG0ETnLYhCmY9nWLv7a0y/V51wZc4QZNBmBcvgXu/ibYTdpbrUJfOQD7rTUVVifFB3xM8XKz1KcvVwy5j+eVHBFXyhsBcFkBT5QMMdTAXF7zX1oAO1TRpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927846; c=relaxed/simple;
	bh=A+/sx+ytQ4G8yq4U68WgobXipHkg5atz+C/gynH1CTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DW8i8zSuRE/32IFFqYeTDU7PXBw1Ub+ko6TEL/bwYGoqQoRjWfoN8lNGUVaJCVso4NN3614PZbI6IRQrIoDhKrGAXjGUa+1IGmuu5sSGC+YiSDAzBdsk7o3APrXHeR4OTAqBJ75/6x+b72mJhO9W7jZii2CR70mlNN+cd5hyvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l7lXHSHl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P4AxHARL; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NrxW732376
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cSkM2sZ6NfRboh9TdbBfSTlyiPdbQTQESCI/5cewzIE=; b=l7lXHSHl9bMUc8i1
	h8BY14EUpwCC6HSX/2zktgIocWB8yKvJVyoAnxXnQ11Hg8S7L2+jDwE8CgwNrQe6
	Qs3OwbgJEw+ZU6zGyk/sbM9rMYUkjAZZHFACnqb7OUkuj/Au05WcOkV27MLuVvzt
	kx8iaJ306l4faZYumd5D8GknfsYlZTqwA/8VFeHaU0bEcHzEPa1i8fFApGAW3qTz
	UoC0MK5tyQstBkWUabs1y5eRxwkZhezjx2eeSZbjPY1nCMstE6AbohWS99Ou//lm
	+W4jOfCcbpr9C/06vI6gqGBb7WRP2cid5WJVGKllOLQ/oPcEaXA6N3jz366kq4Vj
	5EHqwg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn39d5v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c891ed872ddso4888649a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927844; x=1784532644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cSkM2sZ6NfRboh9TdbBfSTlyiPdbQTQESCI/5cewzIE=;
        b=P4AxHARLZ5TCUfCA6jYJcu9y0QRPaMZQVnszm6n4oh9fFpRL2hJ9JkK3Av7LRIkdmE
         cWloTgK8xxvONbfqgTC54OCTsFnq3GfJCRbssyroEU6Iyuuf+VyA7CiPNGsj6dxODWce
         1uxMAwRHHV3lJKh+4DmM2FhbhwfZYcYaydqWmqqV7Wk+VJ5zoh/EtX8AwPh/0IPexG0U
         7FXW/OANpEzix0H5+xx9U4XUDkpwTgOi8ioy3T3hklx6zqWlC/qzHJriOdKhUKLT/8++
         +IVOWgZ2UVxjtOKofTO4/sjdg4zKALyhEjskmG7PCsC/pVOuELxC8bvn3+YhyadPhUIh
         AB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927844; x=1784532644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSkM2sZ6NfRboh9TdbBfSTlyiPdbQTQESCI/5cewzIE=;
        b=AQ119azQSFj++XkUMYwDgW1VjchJPNGCClwVLk07sxbCztV1BY9SPgRdWBfMUmyz2o
         1oAR0XRqptsOieWnJW7BhT9najrlYx/B6cMBLbr4L5J51Wg/llPz7KN90MZJLd5C93SY
         5F06/5EdblKJQYeQsfTcHIuoSqBYvpCHARnRYcCwgMzQPP670LMzu4oTLmBz73N/mF7I
         G8sl2jOQnshyMrIhvkVl4NWW7uPiu1jgcBq8W/5MZQfPnmXcGQaESzhfyHt3rkbWTD5F
         AB0A3yL+gyPyP/eeOgDJQlJT6kDmtGaGMaNL/m6Y2cpS6IMT/0OHNvLj2/d+9q9XIA7W
         OChQ==
X-Gm-Message-State: AOJu0YyAQi9ZRX1NoSHAQwtKKkGDdG/oQtCo627KUe5tMEsxiuPk+zXu
	6LfBs9s68FrU+9w7lcAuqvd1isXoIBg+qCZ2BWr6dFXGL88OR5eu8V2iRYhOGP3jZp6UmhEtyjr
	g5GJAu013JdtCb4JEPW9OJ3PCqXIyZ7h3oGXZK0EWrNjSFH/triNS4dtasNPnkg7JJjhMcA==
X-Gm-Gg: AfdE7ckjpCIkVcySNxbkHKxVR5EgJESW+e0aQb1OlxOIGZPXQq4Vl/aYwEuloRu0YyY
	QkHAS5LhTCaXTUizY824PAyz5WmF+twC9SEm4s/ZLIqCG8HAax7SvHYlbMs3b0lz4WJqo1c3nFQ
	cYFVyf4loqzY7rF1Z2yFtUkxCvrPrnp/nH3+xXE/tV2x14hqQ1lvmtbPWjIHzJ3ZUPEDuyxV2vQ
	J7QzIVxMAq8/ussqKucnKLIwEngbdU+2uqsgwGq6plMBP5ES37knanVqvMkZWVxvgH5BgMHR49l
	+kevxRIzL4xEzH00mxrxJp1/1uO+Unbz9jyh1kvwmLfry33ORdGyQw0bBenhgtpbrmVrf5nT+wv
	p4vwtIOKbXkWCPo7dXzuutvRzwOgqvx95vS3fCAAKhMMbQSPCcWcYEabsg+g5LqVI
X-Received: by 2002:a05:6a21:9211:b0:3bf:a0e5:99a0 with SMTP id adf61e73a8af0-3c110be0c4bmr9837163637.47.1783927844069;
        Mon, 13 Jul 2026 00:30:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:9211:b0:3bf:a0e5:99a0 with SMTP id adf61e73a8af0-3c110be0c4bmr9837140637.47.1783927843635;
        Mon, 13 Jul 2026 00:30:43 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm7947252a12.19.2026.07.13.00.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:30:41 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:29:57 +0800
Subject: [PATCH ath-current v6 5/8] wifi: ath12k: introduce
 host_alloc_ml_id hardware parameter
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v6-5-20f6f212e413@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX3PPzjGTLzVQk
 SOe7Y2lxLuXMfMQ4W14WxgrEF6vuggXOJRNCjyPqOFzntCKOibM+Wa72EDT3EKqXxjcA/ypiROq
 a65DaWJ8Ec50PbZgJJtVzSIZ+5LElwh12vwGzfeKC7uw3XqhiBjUWve36+VdDLXA3wEIBW0IB4k
 Tfwe5F6qYmgEM+3vzsVQdgh7ZC4pZFuSfD3U3YM2l9ZKI3juZocHyai2y0zj0Y628w8PhV/Eb63
 WwE8MuhCS6uzvATiNjdA5o/ZySIdqQgr0CWhgChQwcMjQcaHXdYJv8oPZLtTWf+FCxl1KKKD1Fr
 o1e92A28jBfu/h15p21p1eFitimR17xW8ZRmG0pIj1DDykNaqkQx1ehMYH/Q0yrghl8zwEUdfxS
 NDbqKsauoKfLFrHqqGN0AAxuPMk9KvvCe56eohNAcxmKdR5UlDW3l67UxZnDlcJxpfVMNykGdC3
 NnDDt/Qqo5r4Xd6wkiQ==
X-Proofpoint-ORIG-GUID: 2n6NsvHsDXJlIAz2C55CH29Ra4Cs17yc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfXwaB0jtXRtper
 HnuLTJRXl3KGHymkH7ickWUVarqMgyBBoDPeQYuzRyVN754Hm+RQS2zlmi4JWNrYJvjFhgeDdbR
 QjT0UQeIiQ4PRaXMkb+f8xn/CdpeehU=
X-Proofpoint-GUID: 2n6NsvHsDXJlIAz2C55CH29Ra4Cs17yc
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a549424 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2Mqij7SlxvU2Fhucnr4A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38948-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D285D748388

Different ath12k devices diverge on who allocates MLD peer id:
WCN7850/QCC2072 have the firmware allocate it and notify the host via
HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP event; While others let the host allocate
it and pass it down through WMI_PEER_ASSOC_CMDID with
ATH12K_WMI_FLAG_MLO_PEER_ID_VALID set.

Currently ath12k host allocates this ID and sends it to firmware by
default for all devices. This breaks WCN7850/QCC2072, because the host
maintained ID may be different from the firmware-allocated one.
Consequently data path may fail to find the dp peer and drop some received
packets. From user point of view, this results in bugs reported in [1] or
the 4-way handshake timeout issue.

Add host_alloc_ml_id flag to struct ath12k_hw_params (and a copy on struct
ath12k_hw for hot-path access) so subsequent patches can branch on it. Set
true for QCN9274/IPQ5332/IPQ5424, false for WCN7850/QCC2072. The flag will
be consumed by subsequent patches.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221039 # 1
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h     |  1 +
 drivers/net/wireless/ath/ath12k/hw.h       |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c      | 17 ++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 12 ++++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index fc5127b5c1a3..1f56474efbea 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -793,6 +793,7 @@ struct ath12k_hw {
 	enum ath12k_hw_state state;
 	bool regd_updated;
 	bool use_6ghz_regd;
+	bool host_alloc_ml_id;
 
 	u8 num_radio;
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index d135b2936378..8091501cf742 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -232,6 +232,8 @@ struct ath12k_hw_params {
 		u32 max_client_dbs;
 		u32 max_client_dbs_sbs;
 	} client;
+
+	bool host_alloc_ml_id;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7d0d7d5fbf53..9e5fcbf8c730 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -15382,8 +15382,9 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 	int mac_id, device_id, total_radio, num_hw;
 	struct ath12k_base *ab;
 	struct ath12k_hw *ah;
-	int ret, i, j;
+	bool conf = false;
 	u8 radio_per_hw;
+	int ret, i, j;
 
 	total_radio = 0;
 	for (i = 0; i < ag->num_devices; i++) {
@@ -15423,6 +15424,19 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 			}
 
 			ab = ag->ab[device_id];
+
+			/*
+			 * the assumption is all devices within an ah
+			 * share the same host_alloc_ml_id configuration
+			 */
+			if (j == 0) {
+				conf = ab->hw_params->host_alloc_ml_id;
+			} else if (conf != ab->hw_params->host_alloc_ml_id) {
+				ath12k_warn(ab, "inconsistent ML ID config within ah, device 0 uses %s allocated ID, while device %u doesn't\n",
+					    conf ? "host" : "firmware", device_id);
+				goto err;
+			}
+
 			pdev_map[j].ab = ab;
 			pdev_map[j].pdev_idx = mac_id;
 			mac_id++;
@@ -15447,6 +15461,7 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 		}
 
 		ah->dev = ab->dev;
+		ah->host_alloc_ml_id = conf;
 
 		ag->ah[i] = ah;
 		ag->num_hw++;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index e5bf9d218104..0c277f51d99c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -439,6 +439,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = true,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -530,6 +532,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = false,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -617,6 +621,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = true,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -697,6 +703,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = true,
 	},
 	{
 		.name = "qcc2072 hw1.0",
@@ -789,6 +797,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = false,
 	},
 	{
 		.name = "ipq5424 hw1.0",
@@ -873,6 +883,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = true,
 	},
 };
 

-- 
2.25.1


