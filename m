Return-Path: <linux-wireless+bounces-37371-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wB7SHgPuIGqS9gAAu9opvQ
	(envelope-from <linux-wireless+bounces-37371-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 05:16:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D463CAC6
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 05:16:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LKNI8r09;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=kZm3ejXJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37371-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37371-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BA853015188
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 03:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B1380FEA;
	Thu,  4 Jun 2026 03:16:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41080269CE7
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 03:16:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542971; cv=none; b=eJz8fOabcB5WOYtaq0y0Z29DLY+aarnsV0dWUEU55P/m4DPrqqEl+oeBmtAr9qL3zZDX9NNrSQzOStMB72Q/SkUSgy9qt92LolOX/WmF89JX7Uzk3JkzSPhYbLEko3wU1olre4prrv15F+AZ9UUIG0W3kJd0gNySLKWNfdjOs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542971; c=relaxed/simple;
	bh=5Fm8Z1Wk5bdsDVDr9mpa2FEPAIHY3mmqGFjdwPgh0aA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mXd3YcUActfnOliukfJ6m4hTpzTZM10gxFSt53rRlr2oWCSnyMtMmZBkZc5IphyFxQ9nGspeWJtSl0DJwvOrkDAzQUXoXkYMiau7QZhtBhpV2Kwf71kPoUSob4oyc65JwsLXfJaHMjukH7Xq4to7zWe4okekgTRWYN6StQhlUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LKNI8r09; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kZm3ejXJ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6542DsC32260724
	for <linux-wireless@vger.kernel.org>; Thu, 4 Jun 2026 03:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/rQrilZvfEdbVQGwvZi/nn2E5Isj0FIpMXt
	oYPlM6dI=; b=LKNI8r09MsA+oU0fjZ3AzmUn1qFA18znAFjP3ZVPaQspImZtM3Q
	b6NhS8sDXD3no31opH6woZ3XttKOgo+ClB4B12zXdutlnkYq4pbXxapb6+0TFhsF
	TYUZlcK2JyMDCglMeTv9zUrooytV+CvORgRcvcvLfnMprqcAj9Zt6qNpX4OE5tx6
	6BEM3BIOFwDWi5NxD8q8fcX+F14QnCmDWz3WO/XLO6lLfi95YyM2O8X88BFGW5zJ
	Kie+tKRo6QOWaCVRgC6t2BmEGsvojQAL8gaKVxxyLrr2uCdVniwKha0a68n/gOme
	C255i4oJW/GwLCth+oqS82Uw/YL4Ze2U2Lg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mj4tp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 03:16:08 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-842211d6e48so326030b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2026 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780542967; x=1781147767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/rQrilZvfEdbVQGwvZi/nn2E5Isj0FIpMXtoYPlM6dI=;
        b=kZm3ejXJb2BB5K2TKDxH8CWzwPc9gKoJpgZ8Ye70tFoIfLPNMPeYLwylLigox7TApk
         Vc2z8V4L5PdQ5ZLR3MEYDcp/7ulA7SkvT6xVfy4IDwFLp+67PQRuCLkF7rf+CvlIdfqL
         zwUUAKCegE2A1Vt4mkfI5zLGmEYZstEbpXTLT57Ux8Es02w9uwfnrxXb8/rSkIHCp0df
         26MRMj6p4cCAqiQZ5jZkILTxtYBzfwFF95+EC8YDh9S7rnLPqqwKTOcBMG435jgS5hu8
         r+NFLVvFGPWXslmilusiSRSKCFohERuxKvjxhN8hX3JjGKvJ3toIPLlEUuznozhOufER
         Hykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780542967; x=1781147767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rQrilZvfEdbVQGwvZi/nn2E5Isj0FIpMXtoYPlM6dI=;
        b=PI3qiTL0E4OQ9VOj55mXeFK+RSyMxEmAxfhWHmP1xvYaWci8TkGByCnYt/1oUu7UFQ
         8OKLVpz2NDYUF8NSyiyWUQ/6leeImUqULwUeJE4cm6aJSN3zwMA16MwQ7qoKBHEFf9Cl
         obEC2jwtcV5iw5y6N8t6gjmHf2zxTzjfdQU5dAiopNKkHgnaNZEiaY2M5YHd2ErQC7EV
         ANqLXwF4Z/jsnO2Upxz2ahwN1dbjjX4Qp46fZMjrF98DchGjYIkDT6A7duDwz7cHAhZt
         DiAijKhUeCQMKfD+dOlNkBeE83/yLWc9xxBroJMINjMevbGIZP5BJvvcfMRwKzi5aAik
         qoUw==
X-Gm-Message-State: AOJu0Yy8pcu+BFFU3+nSdRmfgnGEcajTQcQI1pqrU5EX6X1ZuX53Wy4Z
	9ZltELgyqVu0KK4U9Nrz+YBOxvBHz4qq+5GN6ePvUJRFhiPVovUtTm8PO36dTHADKy2Jjr5svOU
	5LFTr9sF94y07MJ46bxPb07PC6M3ijWB/VGiUwchE+kBF9vrMHBM1hbZBEU27ATs0K9ZLOQ==
X-Gm-Gg: Acq92OEBpoKjl79FCs3XYMOOwYhei6VUuC2u5htf+XFjSkZzOwkOGirCO9gXYcFJ4Lu
	9ERN6YIx44IbjmKZB0IFHlYreyUJqhCA/BH30tHWubt6FmCn6jmycHI//Im/UG79frOs4DVzos8
	GtjxMZQboKW73vLICwfQSPd1t1aLcG2mHu7l08Jl5OJdrV9k4+umjoV8ASzIaAFYx/YOhvdt+ll
	2pJMs0zfl34KWNcUjuRfFItvoUggmMdcIDHXvxZSiiOkjMEP2PqL/1/OpBuWF384gZgSASSfJPG
	/nrtlWGAl8587SGhKJ5c3h7+DhhP/y33T6tQnCunA9VvNyY9Mi37lcR7Zg3XczKS1Qg8VOiUDfh
	WdKCc+iOtg5cRcgeF1Ye4UXgKqiPNv4nN0kONLRGZuhgOYtri3LdyL/LBjuxvNSKG/qZSI/nsL2
	GaXnYqA/NC8ymf+lRsQsXb9r1dy0LGw48DAtyojxjeYyiQAN0Xhlha74M=
X-Received: by 2002:a05:6a00:3d01:b0:83e:d427:9817 with SMTP id d2e1a72fcca58-84284dffa92mr5800350b3a.11.1780542967098;
        Wed, 03 Jun 2026 20:16:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d01:b0:83e:d427:9817 with SMTP id d2e1a72fcca58-84284dffa92mr5800336b3a.11.1780542966652;
        Wed, 03 Jun 2026 20:16:06 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282915fe8sm4489750b3a.54.2026.06.03.20.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 20:16:06 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: expand UserPD ID mask to support up to 8 PDs
Date: Thu,  4 Jun 2026 08:45:51 +0530
Message-Id: <20260604031551.4178754-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Z0OTkQ9qFyHfMTs3YJxVXCiZ_S-1bNqb
X-Proofpoint-ORIG-GUID: Z0OTkQ9qFyHfMTs3YJxVXCiZ_S-1bNqb
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a20edf8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=LR6MN0zy8BHNabX5pRIA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDAyOCBTYWx0ZWRfX3mb15Pb3cpf4
 WHGAP5yf82F/gGqMM2RnN1MfV0mzOJqH6MDkHfaYO4/SCy86MDFPWUhD8JdWExEHvUccgMcBk/P
 3UVlDF9EBhvv4D+ScT0oW5GjNymKU+4zVRaaugo4PLDNmY64z1p+qUypPj/Gru+mjaT2ERx/JHO
 PMJEmi+f7FVX6u6/9P1BTbomVyKNwpBmFkJYNmohssh0Tk7RbHwQuCGdOSm6zRIojOzYmIQdDzk
 wl3NUFjRUarjD6JidbbG++Hn5ySjlbt/Elu5AdOT8fQngV54FjEdtt7KsAgyRz7kG3RCeewWmwv
 dpkiqZ2v28YccNkWup5LdbCZuoufm5oFvtZA296nr9yvSMqhpEoXLNLzCh/da0+x8aXNLEtXXIa
 zOi4u6yvMLlQa0PnVrye7TFT3cdNcGs3glie8mrm69PPKMNf37FuyHVMBN1qh8kNWXpLf6jxUD4
 jZVLxhKbMbCYvtgAH2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040028
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37371-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 472D463CAC6

Currently ATH12K_USERPD_ID_MASK uses GENMASK(9, 8), which defines a
2-bit field and limits supported UserPD IDs to values 0-3.

Future IPQ5332 multi-PD platform variants support more than three
UserPDs. Expand ATH12K_USERPD_ID_MASK to GENMASK(10, 8), increasing
the field width to 3 bits and allowing UserPD IDs from 0-7.

ATH12K_USERPD_ID_MASK is currently used only while constructing the
ath12k AHB PAS ID, so this change does not affect existing platforms.

Also remove the unused ATH12K_MAX_UPDS definition.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 1 -
 drivers/net/wireless/ath/ath12k/ahb.h | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 30733a244454..4912172e106e 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -17,7 +17,6 @@
 #include "hif.h"
 
 #define ATH12K_IRQ_CE0_OFFSET 4
-#define ATH12K_MAX_UPDS 1
 #define ATH12K_UPD_IRQ_WRD_LEN  18
 
 static struct ath12k_ahb_driver *ath12k_ahb_family_drivers[ATH12K_DEVICE_FAMILY_MAX];
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index 0fa15daaa3e6..a153db6cf1d3 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -27,7 +27,7 @@
 #define ATH12K_USERPD_SPAWN_TIMEOUT		(5 * HZ)
 #define ATH12K_USERPD_READY_TIMEOUT		(10 * HZ)
 #define ATH12K_USERPD_STOP_TIMEOUT		(5 * HZ)
-#define ATH12K_USERPD_ID_MASK			GENMASK(9, 8)
+#define ATH12K_USERPD_ID_MASK			GENMASK(10, 8)
 #define ATH12K_USERPD_FW_NAME_LEN		35
 
 enum ath12k_ahb_smp2p_msg_id {

base-commit: e1c8fcfd37f76b46a581b794e27765258c9a537d
-- 
2.34.1


