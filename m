Return-Path: <linux-wireless+bounces-29486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17FCA29A7
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 08:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41D2E3028FA1
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F38261B78;
	Thu,  4 Dec 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fKFLdc71";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SgmeO45l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD826B2D3
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764832283; cv=none; b=fskV2JGBO6K2qIxXVX+5JkEyDuYjgg9PKvl2wqFJPf4J/MRU0LEWg2H2Xr/Anx4Y2dlZsjQjeWIlSFXOt+MjnGpfPEqS2Kyd2KfLYzQgmPS+M1dwjVw1jbB6e5EUKOVfakFT0SGoQYEAVPW91WH0addmy3/6YeJi/iffMc+qD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764832283; c=relaxed/simple;
	bh=y0UAhi2vrUBNMI7eiX5+ttOvJJeuhtYyklkwIMbvGKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiSRCuRSh9swiGvbZddQQyfap+z7H7gwNAJIrHanwbACrrq9w+cbWcru5wBkCrA78F5tEORj93OM26medc8yaBmt0JOms83HqrOPTo+27aQJnUA6hjKTY9RZWXwEX6AC2vZqCXwUStufgD/EEgwflo9SIbSNPIygwxOj3iTpOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fKFLdc71; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SgmeO45l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B468lT6734677
	for <linux-wireless@vger.kernel.org>; Thu, 4 Dec 2025 07:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=X5dN5yZ9ItC
	8K4kgYMQf5DsqZ5QTAm8KkS0z5PvBi2w=; b=fKFLdc71YwSnEPot8G73icRdbIC
	upzhNi0Ezvuc6NmDSoQLFY7kpPswZ9vyJ3oIwAC66yC40336Vle/xRWwKn5buHt7
	SrErJZUDsdIYxbcOWrfCqkbV0q2XkZ89KJHH/Bg6PQIoA76BbNSWbO9RjvRl7qqf
	8WKSS6S4PE/Fy0YT7ZjVMmo76K2ZUy1R/rgJUuj8o7Mu/P8F/wI3xilCM4ZVB4kJ
	jJJiP/EwFg29wqlacYMjlDwXmmZaCqvd4SFmhNo8BkRaywD9gsLz4OhuXsAK0XB8
	vaOwUESaJwIskln8Koqfehy7DgUA6HTfZp/0OphRxxavvbVFlaCmiMI9dhQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atr7yjcmg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 04 Dec 2025 07:11:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7d5564057d0so1653225b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 23:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764832279; x=1765437079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5dN5yZ9ItC8K4kgYMQf5DsqZ5QTAm8KkS0z5PvBi2w=;
        b=SgmeO45l4m1nV6TSuF+Pez7Zhb4CHekBJVRMT8wpMROjO+2e1S63FTqngkuw0v+jD1
         Aa9/eUkWvtgfcNGEBrtGsmPhQ6KCRBeTyGZDBNFZWVRWdGAT3YZfhhW0LN8iV2EpyRo9
         oAheQoH5yUOcyFmgdWjuS0mb5SFRtZCcC9kFbSv2iatSEoV2XcfVRfIF8Y6Lf/tRFK0V
         uFQqukQ2iFaXahxwdZ+OWLZrS4R41pKVLCa+yOXGZ8k36qTl7V9OjnNnLJwCvm5Pcj9t
         wZ+zvfpnE5yPuip0eqtz/AM9i9UWlSjYp+UECHZ5YhW/k7TJsfz2V8PdMpgYU/63lTF6
         rJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764832279; x=1765437079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5dN5yZ9ItC8K4kgYMQf5DsqZ5QTAm8KkS0z5PvBi2w=;
        b=He4LLXiGb8HrYUvX2hv3lvk3Lar/LWhbIqOE+qrCAsr204+CEfsb6wFvZibx04UyLV
         RR+Tib9jM9PylaXyhsWgy0FR2tmwkk3v0f19TzJce3bhoxTsOVhiIwlkcFygcczUCqUs
         9cYXcDTtBHUz9GQSNKI4pFJE3PaUjJKw2zSMbF/GxhkByVhJF3nKWA3g7ob48N2J/Kw6
         eqOsvLOJAMihwvMvF8bsH60hvpzSIGnXvO6fK1JvRJ7TVCTTTYR4Na0BOwR9RyKN47lk
         PYY0jmxOsMajR1MlUiX7znBbqtMWeZNtyATb3PGV8+Dr4KltF/MJym98q3RomrgoafV9
         EtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXza0ORBztnUOMK9HQkXpBaaArIIHKPQLZocfPzoRrbHXvagbbZza/nC009SGQpDULmedxI5girdbMnBuEmsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzju2lzEBwLtKqSxiPOWaIKT3JCPKdxd+pgBwvm54JxPFldPwpm
	BpgWHXk6Gc8l7C1N2a3CWanONYLic1FSKWOrEo1EDL5zO4L3ropJhdLpAz10xJ+5svy7lZZvLZ2
	kjP2ER3n0hDKipeG5H6AEiS5kQX4vPeX0DNsV8BkhZqqBjqGU8gx+ocmDpnErr0NWaY2Ixw==
X-Gm-Gg: ASbGnct6hEaQ/69VBT9oDRtSIlzNuqUmgnaOM/Pl2uV6dB1Z4V4g4Z7ZON7LKt8eVyq
	gjn+WU7UgpQIZfSoWhVsOBQqWcBfAXJjzmX7IW9nnxsjxMDZB+XSJ2qQYBMjx8cwp1lMGXJnnHs
	sUZYwFKJyc9wuOuweRaxd/Kqlgk3qlXP2FINKCw26T01qdXgTIBsuBUQB9wNmN1fUm+DejkCZnI
	yRCbZ+tk4Ip6mF7oXqDNJhxScGHjTzbHSPzmFOJRa+rkM/jS2rgu/6QdhiZY8EH9iQAbJXbEak7
	pFQQypJf/yNbNryXXHg20UNN8ulGMOU9v2ia4yzHyDRNm46c+W4zt7qy/LH190o3ASfGV5Hibse
	k0XOY0WB47GX7kAMwB29PXnENlVdN3oCtHLseDiTDUDYwOBWBI4IJppGK+f5v6VmYC2xk
X-Received: by 2002:a05:6a21:9983:b0:34d:d030:6739 with SMTP id adf61e73a8af0-3640384fb33mr2392103637.31.1764832279075;
        Wed, 03 Dec 2025 23:11:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRimZYOSogE6sc3Z8nzoRkgTMJ+lV0kNJ7Xyql9Svm92IYE3Ca3TS6TItapIHe2OVC9kCfmA==
X-Received: by 2002:a05:6a21:9983:b0:34d:d030:6739 with SMTP id adf61e73a8af0-3640384fb33mr2392072637.31.1764832278645;
        Wed, 03 Dec 2025 23:11:18 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ed331sm1117470b3a.4.2025.12.03.23.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 23:11:18 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-current 2/2] dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name' property
Date: Thu,  4 Dec 2025 15:11:00 +0800
Message-Id: <20251204071100.970518-3-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
References: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QPuWDIAUsxOucu6H2Xvhkxx_mqsoXadT
X-Proofpoint-GUID: QPuWDIAUsxOucu6H2Xvhkxx_mqsoXadT
X-Authority-Analysis: v=2.4 cv=ZMTaWH7b c=1 sm=1 tr=0 ts=69313418 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-5GDireV7CNCQn9VzVAA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA1NyBTYWx0ZWRfXyAC4TMHZDA/K
 lvRqSpBttCuwXS/JQsIWTyaSstHXSo+/rbg/6iPdqHe5x7okQL2flWdHWNNI/4KZVtEqOjNzPR2
 3ScrGVocS2Ed39ZRji5QSThJ515MZl738KbCJylfiXcoSJVc9xooNHmqjsOXGLSOOaHP88BZRX7
 YivKiANJX58GIUFJTJTuI0nR4snxdmjOybz3Gu3C2VEzZ93hgUhmiTf+PZNm/JloCCAs14ZbPbS
 pVRGfU6jzlNZ2zBq60ldWue74hm2DKnV8x+/SNze4ExFG+AIGl05VWLUNLFNdrSoZcZDVByOOzI
 yAKBQAudFv4Wz5w6Kw8JjdPNKnujqQS9VocfxAWL3bna17DqqUiJI/NJ9IoEZNcRZ/ybmApMflw
 i22KS5nua7MrAskqDNuMEC3HM/Ne+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512040057

The firmware-name property was introduced to allow end-users and
integrators to select usecase specific firmware for the WCN6855.
However, specifying firmware for an M.2 WLAN module in the Device
Tree is not appropriate. Instead, this functionality will be handled
within the ath11k driver.

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


