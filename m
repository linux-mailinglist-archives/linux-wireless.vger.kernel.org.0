Return-Path: <linux-wireless+bounces-34428-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OuADgaW1GknvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34428-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:28:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3480A3A9F3A
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAC9330142B2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938603783CA;
	Tue,  7 Apr 2026 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="huOvn6VN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IAlg5Clf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB337881A
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539620; cv=none; b=HdvPx4UhWcEJBHSckGbuKTZw9vm96n2/U8Onvah4ja19nOZVIAfJfF/wluzsKAFy7LEpgCtBnZpFrDt7S4pHfpB8jh/yYGoYXFkdsva4xyy2FQsS62R7f0a7abL7PC/lhYmYReGlOIC2XYhP/Z2LkuRrIlbA7EkudCUbyF6pplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539620; c=relaxed/simple;
	bh=1YwDCLJW5AyG1KVkqMkKBR89/QMCu4M1b2u2EOFvvTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q34Imz7+vhJzVeRiR56iZaXsHY3Dch6rIrpczjjo3DJX27202r1aPjfk7CxfkGS1NY4Pa1Pjd+DlN6KdVNrWYzRLVuW9IPNtnGGSnAPvzaQ3jZ4fvAwAjPVVV6LZzFl/pYI3Pm3PRlJQhRPrbF9eOoy+WnB7QC9zv9JhtNgB62g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=huOvn6VN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IAlg5Clf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQX7q3402359
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 05:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wgwPXeYNZJkWYjL+cSvBNV11RR4OBiR17RVjGom99/o=; b=huOvn6VNueYZ+t+G
	OOOzY0jNl51/lYCMJly3m2aixKvXzmmJbKUeQJFIxZsa/W4Ou7nI6HD5wlgmRvQN
	Wz2Y7KbRk4s8GcIr+cXXuFbl5hIcujgyZnt0WQRA2nubc50pj9lk31Uqgb7aWC4Z
	YjlCkjlLBF5k34Fwp33DWbFa2c/ZZ2vF/zbKLvurHT89/g5iHHQvaBsWzVHsxS77
	bJVw4Ze4vAZbImMMKGKxeS/9g53gWXtCipUximiFLYerPTRAz+8bj4p438WqGp9f
	jUSP+M9NJgKVrpRZh9mPXVw1gh2zT3hxa75PpwRC6cEiPkY4qvjMbxowAnJzuosV
	XX8L+w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhs5mp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 05:26:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82cd9fa608bso8090710b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775539616; x=1776144416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgwPXeYNZJkWYjL+cSvBNV11RR4OBiR17RVjGom99/o=;
        b=IAlg5Clf52+zOs4ORvlGlXbrMrM1agLaxJjVcBo9jc2YaUOQvD33DC0wnZYXbBTcen
         eU53M71hh+ww1slJBvX1RYaLcUsJ/bzsM5Hf3yv3q2cv1KsdD7yRkxS/J0GIyiBwBZHA
         C+iGgCGdBXnStTU/YQC0jGrDEaketavOwAqlX5vDWcvtkb2wntxlx1O221vO5ti0JxIq
         mp9y8b8sDLSRcjSgtH8Kc6ggFdNreDB+n77rUnkO9cJfbWgxu6RkrtY3iUF2S7bMZvva
         5BCp7FECEKS4Q+I/9vxMjCFuVaZ9xj1Hc54w38SshP/TcjDnjobLlfpccrotXtt5PF2V
         vqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539616; x=1776144416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wgwPXeYNZJkWYjL+cSvBNV11RR4OBiR17RVjGom99/o=;
        b=UVo18ATOEAd1HGJeaSmqiok/0mIbTWFgoxodzY3g96R6tts78Nmr7ID+mrQGCJ8aL6
         jxUqy3BVLClosxd9UldHCNj+4Eu2dKQba/csMEoa9OS76+ELZOfLQCHjGnfdKm6mJbQn
         Lcg64WDi9LT+kZHA4Pba34zMRa+ArM5N/i76pLf7pjLO3sYlw3lpeCkaPJq4xsnh5HN7
         Q4QDWWSZWpmYejRBQcqZ/iBX28j4AHqSPK5lgdR9MXepRRN0ARRSqB5DmBhKeCPJYwHy
         WVoZdkyBf858ioKFS7LKWVZ22nU69lA+HjhGF9yAKdHbdwn7B3gIY5iMzHVyBU7/b/rY
         F4DA==
X-Gm-Message-State: AOJu0Yy1ZSMq6jH3JDY+GaqeAX/CtNlJ7N9hOYxh7hU6R1+ktBGK4rBh
	S+NGpnOQ7JK2Rmo5GSdJYy5kiHm2R2Jf0jfINhZNQ6WZD2U57tZst3n+mOI05mZbEdQe3GVUQ+d
	KpGU/bsaMne0MM06EWy/ObitlfY5ELf8fXBqUplaWrwEzaqkYWrmPkB5GpeQk4vP/Jdqw25g4jL
	N39w==
X-Gm-Gg: AeBDieu9Q6Kw4y4fTN/vP+a0lL8l23YeK34HArdROogdvjkuEtxTiFcJUYd7eLgzvNf
	sGni6fHcLyb7AfKIStO6GizBW+X1XZUeaCM4SLpBuYX0CoxxiLA2vwUb6+eMGwLFfgpJ/DBNme4
	XIG28FeuKUl9DBcScQOrr1Ed/+BnVyuh/1ACMJOoXhH/+h1FryRYzddjAPMmMrIDFJZaAe0QyFs
	FBsEHkU0uRGLjsXTp2Of9jRkevbkpEdVvJh88hMCFuQ02X/4vAO8Tau9li/l9lw1bDrXtwA2w4f
	ZLx3AxJUh8snrlDoZojjIEwA6g30fM15eH91Ymg5lEO4C/GtM2SiMpdyj8taCLxeK5z4jzCievB
	XQzuEhaWV+MgX6Ilwskf+mDIjjOD0JHIa/69RiHcNs7ykfxVkHgJeEO8boOJ2SFXK1Ld4sNhgMY
	3NEP/wi6rIYrdOVcrr3H3knN4+PAkR1vn4s7EGeeM=
X-Received: by 2002:a05:6a00:2e12:b0:82c:9223:cc95 with SMTP id d2e1a72fcca58-82d0da4e79fmr13975916b3a.1.1775539616064;
        Mon, 06 Apr 2026 22:26:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e12:b0:82c:9223:cc95 with SMTP id d2e1a72fcca58-82d0da4e79fmr13975883b3a.1.1775539615571;
        Mon, 06 Apr 2026 22:26:55 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm19897219b3a.41.2026.04.06.22.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:26:55 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 10:56:32 +0530
Subject: [PATCH ath-next v5 5/6] wifi: ath12k: Add CE remap hardware
 parameters for IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-ath12k-ipq5424-v5-5-8e96aa660ec4@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OSBTYWx0ZWRfX+LlLMITUrGhb
 AYWWLX1yplneB9zFULEkhSXyN4dtAYpYdhBjYPQjZy5akN3stsOqywAV1tTpfUzI9pHFU4+hmNy
 V2DwV8/cjF6EdNyWbRrauaOat11AP0azWSCYNTeqhogZV95g/3E5U9dzLGhLAKEB+hNr+rJf1U8
 KS568q664zZmk8u86UWUov9Ed5By9ztK4DDSgHckkZ6RPMaHUjOgdgJf0kP0guK2ncATXQd1DLa
 lvoSWLScXwAJol3em1drPIUF/aO0aUvLjjVv2ZIa/WuTcorw+PdRPVoxW5JXdQxHx/vGfxwDdUm
 jDVVH5NkUHaWZ++cGxb+ykoxPP+X9LV2qIg4Bk9Fmx7jdUrOf9PKDDuuV5ct0BMu9dBUZXk9FRB
 foLjBwBhxr/OF62ejcS4qX1xdIdcoUtHYWcd5NXIFxBQXZbWwlgBqKpa4MeniP4+Z786QkjiPYP
 KcbyL3keJc2pkEqeigg==
X-Proofpoint-GUID: 3WkWbGjsa-LSIV3pAyuYJQsWkk1aNK_B
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d495a2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=LDmrCAwXcT0UWmoAFo4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3WkWbGjsa-LSIV3pAyuYJQsWkk1aNK_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070049
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34428-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,quicinc.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3480A3A9F3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add CE remap hardware parameters for Ath12k AHB device IPQ5424.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ce.h       | 13 +++++++++----
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 22 +++++++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index df4f2a4f8480..009cddf2d68d 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -38,10 +38,15 @@
 #define PIPEDIR_INOUT		3 /* bidirectional */
 #define PIPEDIR_INOUT_H2H	4 /* bidirectional, host to host */
 
-/* CE address/mask */
-#define CE_HOST_IE_ADDRESS	0x75804C
-#define CE_HOST_IE_2_ADDRESS	0x758050
-#define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
+/* IPQ5332 CE address/mask */
+#define CE_HOST_IPQ5332_IE_ADDRESS	0x75804C
+#define CE_HOST_IPQ5332_IE_2_ADDRESS	0x758050
+#define CE_HOST_IPQ5332_IE_3_ADDRESS	CE_HOST_IPQ5332_IE_ADDRESS
+
+/* IPQ5424 CE address/mask */
+#define CE_HOST_IPQ5424_IE_ADDRESS	0x21804C
+#define CE_HOST_IPQ5424_IE_2_ADDRESS	0x218050
+#define CE_HOST_IPQ5424_IE_3_ADDRESS	CE_HOST_IPQ5424_IE_ADDRESS
 
 #define CE_HOST_IE_3_SHIFT	0xC
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 2b5d1f7e9e04..cb3185850439 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -329,9 +329,15 @@ static const struct ath12k_hw_ring_mask ath12k_wifi7_hw_ring_mask_wcn7850 = {
 };
 
 static const struct ce_ie_addr ath12k_wifi7_ce_ie_addr_ipq5332 = {
-	.ie1_reg_addr = CE_HOST_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
-	.ie3_reg_addr = CE_HOST_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie1_reg_addr = CE_HOST_IPQ5332_IE_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IPQ5332_IE_2_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IPQ5332_IE_3_ADDRESS - HAL_IPQ5332_CE_WFSS_REG_BASE,
+};
+
+static const struct ce_ie_addr ath12k_wifi7_ce_ie_addr_ipq5424 = {
+	.ie1_reg_addr = CE_HOST_IPQ5424_IE_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IPQ5424_IE_2_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IPQ5424_IE_3_ADDRESS - HAL_IPQ5424_CE_WFSS_REG_BASE,
 };
 
 static const struct ce_remap ath12k_wifi7_ce_remap_ipq5332 = {
@@ -340,6 +346,12 @@ static const struct ce_remap ath12k_wifi7_ce_remap_ipq5332 = {
 	.cmem_offset = HAL_SEQ_WCSS_CMEM_OFFSET,
 };
 
+static const struct ce_remap ath12k_wifi7_ce_remap_ipq5424 = {
+	.base = HAL_IPQ5424_CE_WFSS_REG_BASE,
+	.size = HAL_IPQ5424_CE_SIZE,
+	.cmem_offset = HAL_SEQ_WCSS_CMEM_OFFSET,
+};
+
 static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
@@ -824,8 +836,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.iova_mask = 0,
 		.supports_aspm = false,
 
-		.ce_ie_addr = NULL,
-		.ce_remap = NULL,
+		.ce_ie_addr = &ath12k_wifi7_ce_ie_addr_ipq5424,
+		.ce_remap = &ath12k_wifi7_ce_remap_ipq5424,
 		.bdf_addr_offset = 0x940000,
 
 		.current_cc_support = false,

-- 
2.34.1


