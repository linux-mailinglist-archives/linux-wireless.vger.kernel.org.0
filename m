Return-Path: <linux-wireless+bounces-38252-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MLIrD6MOQmpIzgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38252-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:20:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543A6D64A3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:20:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=OIxdtzs6;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=IwobKGNQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38252-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38252-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB867304C7E1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CFE3016F1;
	Mon, 29 Jun 2026 06:15:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F024BBF4
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:15:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713750; cv=none; b=VabtnCWIMSjHLhRalR7CnHIYnrVL76XCY02br/njv8EoXnNU01fUbM8/TPz4eKeg9hxSx2YKd8CtedWi7FLq7DiyfSj0QgM82YSDJx1UqeCBoqAJSpCmyY09VqVxLhshIzmQFZjZCdnbjSf47BHIpycU/xT9MgjcsVaSEaTC+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713750; c=relaxed/simple;
	bh=A4DvHO83NLi3k4QYfdPwuslfwFtqt5t6t3ku8mxTDG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISEaJ9z+o2SFOHeIXj2/LpCYj+eJTwmhQ3LedopDpxPCZudwIwUrQPBNhMgPp9rW1QnG8a5OLa/7FgPqxfpQqMIWUppIFsoMING2nfYUOJVsKeR1GUnK5EtJcrc6DFlljNMrixd9U+w5MD45vYD0t/IyQdmQEB9JvHQoKfHRzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OIxdtzs6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IwobKGNQ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NH3R1771381
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=r2B+SEBRZM49En7lUIrzDje3vE8zXDCU9Jc
	5UdMhRfI=; b=OIxdtzs6HgI+UVVC5WyY75CCcqsCNU0KdWi6TSq+hA0C2KzbjHi
	G6IQ57zUXVRsC4Q1YjUXRbDy9sKL299gTYv4wWx1TJ0JQ5iPRO8WY1eQDuJtrb5p
	jlrNgt2St1rFEBnuo/o8kxPyR2Cl8HiiQjwiaCfjgaC1s0xEsdESXn5xjALYiLkK
	FgZfKnKVOu9ZHWq9NS9JEqxEPam305R2X7v2VeamPE9C+W+FbNFZxtAtN8KyY3jx
	HQs2BS8fJJ8t5YiVglCnct1T8vtQ/UkS9G41g48LaZWzdqTXz9F1CseZrd1MwVj8
	Htw3p29u+Pal8c2LNOAzptISZLJa/zLuz9A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tumsy0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:15:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c011c7cb9so7454427eec.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782713746; x=1783318546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2B+SEBRZM49En7lUIrzDje3vE8zXDCU9Jc5UdMhRfI=;
        b=IwobKGNQH3HFAdrSbg61WKLWjHMcD6CZA4Hi0kZzl0e1PLkuqjaLIQolGG0BvIfj/6
         wR6VWpOPRv7qakWK1xoaHf9skvnCS4laM8t4tgE0BLCvn2eCjwYK/nNEa5ZQp+H7bnUZ
         cwfL3cHrkQtav4ZbwEockx8AAVF1ZvdsJx6mXZH2F68fLezDAfeVJLwsIteKhTkGGZZJ
         FLX3aLCFMWxcY+OXYWilVh+G8aUKwf0/nxzm4Ozc3iA6xq8OPyvgyiXmfy7U1MuYh0nV
         45FViW8PqWLE4XgSVXqX+3SuvWtEcVysCsGnP/q/veI9pOcHbA0AGL5VPQZ6Wmqw5ibU
         dxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782713746; x=1783318546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2B+SEBRZM49En7lUIrzDje3vE8zXDCU9Jc5UdMhRfI=;
        b=clfyipj2T/otb0j8MT7m1qqB94j2oxzj0C6lRvrazR8cHSrmYFXSLQHLaI1uxdnU7G
         B96i9mURInCiEuD0tpxKUovps3KzOgQrPje5NZwxbRWbGDS0DNLEAxukgKTsBfY5M6Zc
         LaR/YfeQa4Cgoft/zGQ7a63l3CWES3txBrvvRSJlQ+8Q8T32fppe+NCwpJzMIkiEcTGg
         u9BktphxoV7xuNtzGdOOubpYxW+h/RWce+M68AJTG3bnzUuQTgGPfAHlbeukJj41fq7D
         ZJ+30sv6Pl/2wdX5hcjDrdEZfIbmSOZsAGz6vuYtA9MfMry9CVFreyKwSxnT3B9r8UGD
         I6MQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQ8U7e5kM22IaJu6MCEIDReBMBnRFqIwAE2n6eM5hYed9f8ECN3erki5DyImn5oRGN+yE5V0HhfLPPCEaoiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwyYP4qrUHgQ19cRNHNhf9coAqxTxu2f9bk3fw5VT7ySln2NV
	6PXCcS6dFIemzoT7HsrmfpHNZLEqod1hIdqUiKLzjEQw1FoHsiYkkhw6gCsv2uL2Bu0TywovtGY
	AHXSgJNroAr9KwZNefkBM1F6jVzfk+2X4yh6dQ2cwabDpT9J+qOHqSOyXoQTgW8ZCFt2YPw==
X-Gm-Gg: AfdE7cmomMHdnq6Hl+jPUucPrOetpXL6GG53YWK6uMC1z1dctpsLC365B5t4HmEL0nK
	70Wz48zfaTqCT8LK6FBnUbQVvkKZTN8i2nW8AJkpT+W0areQcjrFWxlayMPHG54fVyVQrXrFYEl
	OGoyDkkot8WNyzOOGKq1TsKrgtbC/7p8JlWhiV5VuZuBiKpgQnrjqvgTYI+VWkfmk39GQaOeyF1
	EoU2eLrg2lDIrWxuUYGE32QEuKzRG7ZyITVASr9dIxZwe+jFgetLYnUAlhkZl1bZIJzPjuXlP1b
	s1hNWoh3GkY132eAA6BXX136IfmsLfmL2//H2Igx4dRFr/Q079DPMV5M6m6Nv5zwTYRljmGvPqn
	MsXMOW7Dy5AKZMraMdlZvRI1e78v7uoLWxNKl6wgL/M7A6v6aN4ix8uEAf0OV6IiVGYo=
X-Received: by 2002:a05:7300:8ca4:b0:30c:a942:c913 with SMTP id 5a478bee46e88-30ca942cad2mr8937505eec.13.1782713746432;
        Sun, 28 Jun 2026 23:15:46 -0700 (PDT)
X-Received: by 2002:a05:7300:8ca4:b0:30c:a942:c913 with SMTP id 5a478bee46e88-30ca942cad2mr8937479eec.13.1782713745832;
        Sun, 28 Jun 2026 23:15:45 -0700 (PDT)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm44682520eec.4.2026.06.28.23.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 23:15:45 -0700 (PDT)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.zhang@oss.qualcomm.com
Subject: [PATCH ath-next] wifi: ath12k: fix rx_mpdu_start layout for QCC2072
Date: Sun, 28 Jun 2026 23:15:28 -0700
Message-ID: <20260629061529.1993932-1-wei.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BrTDcpzM3ademyU3Vm_IczWR3Jea0Cvp
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a420d93 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=lA1hHB6PSS1hPxJoZ9cA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: BrTDcpzM3ademyU3Vm_IczWR3Jea0Cvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1MSBTYWx0ZWRfX7NTAT/EgwSSo
 JCtrI+s9dt+rDGkhhdv6AEN6tY111H0a5Bi2sCxMamZpvy/kJ8pq8AVhSP2Z46JT8gDhZIea74d
 FFM7qxgEyJsQZT0mOd3+MWe2N6jmb6alMjgIhAGs/zaYW8xlWbM9Tgn6XTgdjzce9CMS8D1PYvH
 CdoW7763/r97GQhkv/drjqqtDoYpy129HlaArAkeOw+9ro346hStj+uwO6koM2XJVkAKoKldYEU
 +LrtVZd+kp1qaFet9ON58EOJw2L+Boomt6HP03zRnSxxTk+0KytC+z7+RRZZAvZoYAstOG2ucKA
 EKWt79GOzqt+XM9rwaI7ljFgVnAyuhJJJjzkAwI66xBpkerMq2H9zOGhaa8ILo+LdK61G1Jcwts
 sDd1x7DJPiHaMNY80ro5QIdnICrAAAdypm4M2xUknXh9FXBhWjSJOHnLPYQKUUjRbG58ZbNO/DX
 pg0aOBMLO9E27EcXrzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1MSBTYWx0ZWRfX3OjnuH7XHLGX
 laqHeThz7+mn3cRYam+3PWNrgBodzIHCzOR4wYWrHlpiv9sxr71mT7OuuO+/AwWm2ScD3xRbIFV
 4fqMwYOWycwtzMiY9zvS1dgS4KmSU2A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290051
X-Rspamd-Action: no action
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
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38252-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wei.zhang@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8543A6D64A3

QCC2072's rx_mpdu_start TLV has a different field layout from QCN9274.
Reusing struct rx_mpdu_start_qcn9274 in hal_rx_desc_qcc2072 causes the
RX datapath to read the wrong offsets for info2, info4, pn[] and
phy_ppdu_id, producing corrupted sequence number, PN, ppdu_id and
mpdu-info flags (encrypted, fragment, addr2/addr4 valid).

Add a dedicated struct rx_mpdu_start_qcc2072 that matches the actual
hardware descriptor layout, and use it in hal_rx_desc_qcc2072.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00188-QCACOLSWPL_V1_TO_SILICONZ-1

Fixes: 28badc78142e ("wifi: ath12k: add HAL descriptor and ops for QCC2072")
Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
---
 .../wireless/ath/ath12k/wifi7/hal_rx_desc.h   | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h
index 0d19a9cbb68c..6d69851e529d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h
@@ -140,6 +140,38 @@ struct rx_mpdu_start_qcn9274 {
 	__le32 res1;
 } __packed;
 
+struct rx_mpdu_start_qcc2072 {
+	__le32 info0;
+	__le32 info2;
+	__le32 reo_queue_desc_lo;
+	__le32 info1;
+	__le32 pn[4];
+	__le32 info4;
+	__le32 peer_meta_data;
+	__le16 ast_index;
+	__le16 sw_peer_id;
+	__le16 info3;
+	__le16 phy_ppdu_id;
+	__le32 info5;
+	__le32 info6;
+	__le16 frame_ctrl;
+	__le16 duration;
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	__le16 seq_ctrl;
+	u8 addr4[ETH_ALEN];
+	__le16 qos_ctrl;
+	__le32 ht_ctrl;
+	__le32 info7;
+	__le32 res0;
+	__le32 res1;
+	__le32 res2;
+	__le32 info8;
+	__le32 res3;
+	__le32 res4;
+} __packed;
+
 #define QCN9274_MPDU_START_SELECT_MPDU_START_TAG			BIT(0)
 #define QCN9274_MPDU_START_SELECT_INFO0_REO_QUEUE_DESC_LO		BIT(1)
 #define QCN9274_MPDU_START_SELECT_INFO1_PN_31_0				BIT(2)
@@ -1492,7 +1524,7 @@ struct hal_rx_desc_qcc2072 {
 	struct rx_msdu_end_qcn9274 msdu_end;
 	u8 rx_padding0[RX_BE_PADDING0_BYTES];
 	__le32 mpdu_start_tag;
-	struct rx_mpdu_start_qcn9274 mpdu_start;
+	struct rx_mpdu_start_qcc2072 mpdu_start;
 	struct rx_pkt_hdr_tlv_qcc2072 pkt_hdr_tlv;
 	u8 msdu_payload[];
 };

base-commit: 1547a99cd8d8c1ab3e04dbd92b72b3b5f7cb85a9
-- 
2.34.1


