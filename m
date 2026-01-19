Return-Path: <linux-wireless+bounces-30960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A81D3AB1C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 15:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAECB3033980
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67416378D66;
	Mon, 19 Jan 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bIoSRJvI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hwA+3m5i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A8376BF8
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831378; cv=none; b=BUuI1Fpx/9fFgQRwSGxpmnsNgLsWHLysKy3Rfoq7JeRenCn37KyZxHvEtXRFL7Bl5OwUpV6rcMq97pBE09ydIpAdo/FsI98Jd+VqtgZoIv41dq1WxclGINJtGAxm/532IxStUKw+3XNA1l96EEaZ//dCeKVXwPKPegdSvoBnPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831378; c=relaxed/simple;
	bh=a+u7mLrY7xCjaxOvNnubGsDkYiT/hMo3LPRrkBAx8hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s1C/2Knhf5T2bZ2t+w7qXaPO8BKH5v9FhpNcm22hnc5l3VbWuFIy6Lyet1p50C28Sk3NNdIxmWFsRAh0bWBg39RqI8QCVJ4TKfPITdMTD1uG+TJwneEedufBDaUUBEeNsp5XcCvT/p3/TDpJ7MGjsLhlcehDAWAmtQ3BLk1uWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bIoSRJvI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hwA+3m5i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J914CW903258
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=J5/a5GAcpRG
	BaODL6+7ZjI/35JuzQp2n7BUtvP6Jbr0=; b=bIoSRJvIVVKzpf7NzjpQo2kA4Sr
	8zhPaRHIddZ4dTAG/FOa5bdM4kQeURkDii9gKqkX7cfyCDWmKgE+WFjRwPF0LpeW
	6aAk2SRegb0NMZb+so7GYaSch3sGaoEdGt7Tbjfr2STLSqi5S7WfZxPk+NR/E02+
	ONp2xKXdXKCJxT0JEES8KP2W7OtvtVHv29I/c8FrZxDWdoe8m6o2nW8zDpandhxs
	pAo+k1Xbf0KS5q4GdtxhUkX/67+skuJFJnvPxnKPbC4DtMEQ6To7cz1KUmKJfcbp
	ko26tsoLzPBlh1MNIWMDPSf8BibV3gk8hVVsOmAVRGd2sUm2LMFGAniKgGA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsb4yt23p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:02:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c5659f40515so7433273a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 06:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768831375; x=1769436175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5/a5GAcpRGBaODL6+7ZjI/35JuzQp2n7BUtvP6Jbr0=;
        b=hwA+3m5ihCGeWwEnOGpregbWAiQ5fl/bv1P8x6HNZPqo43THW2zFakiYA1mRjszsZj
         DxC+qO0tRtQBm6RTxEpa95yeaqFjnzRZuBBO1QmibT0kEW2K49ndB84jCB44YxSYNmZ4
         2i1MyrwOoy8vfN3G900GFpPwn6DyEyutuOZZ6P3lVJLCS+ENNN1McrLc4VgeHX4tg0ck
         FC6UmVXIu+YBZoRqkuHRE43e8YKAQq/X5PSfNipOHn1XYz+dHFXmzTUvreLg69FE6TJG
         cuQk6kWzGLVQHuS3IHlB8PSEhFwROBfO1PUB+8uY6OVJZMkRcjUtO4WmS+8mfmgxXG2G
         Sz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831375; x=1769436175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J5/a5GAcpRGBaODL6+7ZjI/35JuzQp2n7BUtvP6Jbr0=;
        b=xVFuYZ6MtZzykMIc9T/NJo1i4KxUrVYqImz6duAie+K4Uj1O2CgNXS4wip1kz2pzSm
         A8gf5nc19kX4kuQjLe1k1eew3Lw1sWAdDTxfTqWpDZwstfnEd09Ilf+OTCtd+EIy26lj
         xCbaxQAeyk+XIcH9DQBYlC9cBuVRe338R3A0oqBfVQv67CqPP3+gtZ72kWdx3KH6b5gc
         9Tt5pg6AX25hcXbGX6LH1eP82aYN5NOsZlQ+F1bF4qDgABrhBHJoM1/KDroFnSxTWIhR
         KkeGOgqjuOEPxVjtVRNW1aUguqrspiCKkYqjv5dXcFEAVGJ+qr1LWIyo8ELPA2z0vh4D
         k/9A==
X-Forwarded-Encrypted: i=1; AJvYcCV9c2216eWxoh2ZoBqTBC75qYB2kcOft1tzM4IQFxOj9N37FG7yiZrSNANW+MqfmJEID7geCgM0b1ip/hwIGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1dzAqXr4c4tAepoGwHWWhNSrSvxSymMVa7VlSOxMGjMJWpBl
	QvIaf0VEmKXJBpBU3jG4+EUCDzOFf+zMikN/7MOAOb2QfmBuh6AKNqqJ3gZziOQpS/Q0mOU72O9
	MINCy+/X8JSQTMj8dy8afKUy3Th2wKzVTxSpphsCfZqqe6vvFwioVnct4uhVXRsIRXfVmruKTvy
	ld9B9/
X-Gm-Gg: AZuq6aLUw5NOABEE/UyxenZEipOr8XVi+012GpcAMyOYj3lFGnjFGDlMqOYm2MOenNp
	PS+MKZT0k5e+wzl1FgdyJYaX/GZz/nf86+8y4hcf+S/kFJhdWbjENrv3ahDKCYl+TF5yUVyLMfX
	aFYHpjItdc5U+CUA7BIz2LAtaFKi0fuzh7Fi7QTq/4Zlc/Wrcfy1BVWU5GS4U8NSTFAP7GzOpdt
	AXaeegZmszCdl62Ivli2iSMjpnEb+aBDQnuLY/TvgbSXATqySHewD6wfkobEHDj68kFgG6TJuPp
	WhIvMb/RePKa2Hh6ka6TaF/KM+WyhOSqUufZN1naajVkZDA6Fj/J1fZMkftTdgD9sZ7ZMQmMN+F
	Tj84B7SizNZo8enJQIGUm+wehVaIFl+VhBVEWX2BISqFtPYakJZfEvUMDwK00GhKvblMk
X-Received: by 2002:a17:903:138a:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a7177e0b55mr111488425ad.54.1768831374642;
        Mon, 19 Jan 2026 06:02:54 -0800 (PST)
X-Received: by 2002:a17:903:138a:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a7177e0b55mr111487955ad.54.1768831373959;
        Mon, 19 Jan 2026 06:02:53 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a71941b915sm97416715ad.90.2026.01.19.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:02:53 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzk@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH v3 ath-current 2/2] dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name' property
Date: Mon, 19 Jan 2026 22:02:38 +0800
Message-Id: <20260119140238.3360658-3-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119140238.3360658-1-miaoqing.pan@oss.qualcomm.com>
References: <20260119140238.3360658-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SNhPlevH c=1 sm=1 tr=0 ts=696e398f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=gumsBO624h-QSWVlTkIA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDExNyBTYWx0ZWRfX6tZWGo4zQlx0
 nzID7lGm1YO2VvPKZTh0FLE3NMM+3GqFWRZAyqIEiV2/Qzcn+uxOCrBgkHOm/J72qoJWM3v7AGc
 9OuKwkHu+lvxTsKh9BQAwKg309TsooylyPyofOAAHbDO9aKW3vxA9wgIakYZezd/FCunWtlHQ5a
 eQm1GJeVu87haMYaJnbgmijRpLYzM7B07qcZ6KBQ0ybGLO8OmI+hjEmWItbdMsdOGMp10mzkfd/
 Wli3xZ+d7E9kFE/GyQH21gTufslbmvl64ZEUt1q0D6cNxWin2w7tqnjeeH0/51y3DmRKsekCMXx
 AbFyLKXrSVWyUTA9NVpYjFDVUW7XEDJWSopIIrakMFA/IIVwJi2K7QWCFUChX+EYwQGEbRLqeen
 dtQ6DlDeI+tteKaTb9K2lLGWOzt+s/C/8FCODSFqJmHIZ86E/MZr5gakkeWhEGieXP7pQk5FvFw
 TuUoZ8r8E8MBj41LFwQ==
X-Proofpoint-ORIG-GUID: _u07qW1EjMSeHui6YURyos3iW217PXEM
X-Proofpoint-GUID: _u07qW1EjMSeHui6YURyos3iW217PXEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190117

The firmware-name property was originally introduced to allow end-users
and integrators to select use-case-specific firmware for the WCN6855.
However, specifying firmware for an M.2 WLAN module in the Device Tree
is not appropriate. Instead, this functionality will be handled within
the ath11k driver. Therefore, the firmware-name property is now
deprecated.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index e34d42a30192..0162e365798b 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -37,6 +37,7 @@ properties:
 
   firmware-name:
     maxItems: 1
+    deprecated: true
     description:
       If present, a board or platform specific string used to lookup
       usecase-specific firmware files for the device.
-- 
2.34.1


