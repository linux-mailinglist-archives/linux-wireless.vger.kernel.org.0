Return-Path: <linux-wireless+bounces-28968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32BC5C93C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4A74353E42
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDBB310651;
	Fri, 14 Nov 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HCwPMqUT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJsMPwSW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C630FC31
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115772; cv=none; b=Y3dTQh602z19tyWvSzE/xNEon3TrqCkjxNSkpfPytgZNAznUum5koVLiOK2sRHStZyk7PiLJ6/+C7/36ZCvhUFrpu/aRbn1bzTz6A+j/21qhgAGknuvybyGj3eQCzLXzr+HYwF05fFkt2RIOctgF86upWPlD/e0wuPBJ7FFafXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115772; c=relaxed/simple;
	bh=k3nnJASyGzjwvyMuUxQFV6JFb1OmNF6MwYd2U70py9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDIXEHwkzY7s3hgQ1qw8WhaIOpaqMpDqu99rNIKc9QAidRdQvpgWgUvIpu48ffz7gfZHFLUn2XqzfXezx4QIR+wlD6UT7PQJGC58Mh8TwelH2sqizNX9MbrSg5gQkhTGXzkz2c/gpdrsnFfg1FIK6RXPMzBJct8od2xMXsRH848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HCwPMqUT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MJsMPwSW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8Nf4v1699799
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahWiBjMc2fo3WP8rF99Mw4GcS3iUglJWkT5uYMXPyOs=; b=HCwPMqUTwUNRWF4E
	u0ZGfTiYpzvQ3tb0ucmstDJkS/3ZNwPz+VVXwUWJGD5eqh3i3lzJgFkajsxvxp6e
	AgrUEDx+GnJsIdq6qaOOdN9FBTQozBsKjAvEzxJ5cXHcsOQWdkm5b2yABIAEkE53
	B0x1FsVnm+8KwWG8k8enKItScKckXKEpP68ij/tadSKMcSvOebc3rIRYXIrlhrPa
	KleZlNPN0g7gVR/hMq+hs6gLoKRyn+yfRD6cK2OGXecBhFGXBW2Jaj95jIy3VVFu
	MyjEovc0ooYtlbfwN3ZIkkNzXdP4lrCsB5CgLmQXk3drwKOHaJrGNdJKLnkKT49j
	nGDolw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9e1tks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:22:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so2739071a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 02:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763115769; x=1763720569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahWiBjMc2fo3WP8rF99Mw4GcS3iUglJWkT5uYMXPyOs=;
        b=MJsMPwSWjyDOz9LvlTGuauRyJ3pk7uB2eVKY+BAOtrF9JdBQA2hrhzSaFShGd3usUp
         h4Z9/xP2FODzcmacyxaFWPp6AlBdAYA9R2w1ZhGOZJHChQ4bxjHBk9zbHJnYoJvjOQSk
         0EpgmLvr7Wj+8BkpbeGJGNKtaP+IfmPWcqh0D8vJ0H1df1ziwiFLG3cs0iXjyZk6dFcs
         zVTkThEiOhn2Xy3SeT6epcjxRxjem6Bsk6dJ2PnoAoy4IVZ28Sy4oW79rrO7VLXpOyoq
         dFy5fRUlTvvUstFUyoi9golbZIMb77chjRfVyB2lITxLNRGwXWNmENPKNX52oo8/ZcxS
         m1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763115769; x=1763720569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ahWiBjMc2fo3WP8rF99Mw4GcS3iUglJWkT5uYMXPyOs=;
        b=KbjNepY8mQOicciQhi2ye6UTLniSWNkG3dHWgBibOlOtA5NxaVmoSX1h4ztqCFr8lH
         /J5LNzY9j4o1QPXzMvi6IfZOX0vCvUy6qa+auy/CPDQZpMUlyNFfL4R7vazHsif6t18y
         mXp93UmieTqDJE54H/BKUdy/0E8d8jXk+V62gEC6NMUpRGuNTgDk0mI0cE9yRVKUGPNy
         erYnTsNX58xt8moVS3KYXQISAQgHa78G+Cac46mPcr/aQ59EtgqTIFm12hyvTZyCt4Oe
         LTqQ+Ik7rctiRj4NUoelbFhRzoH5m+e9m01lD7p8yEUyV6IzecT9KR5NHY1ZvUWk+pqA
         nMeQ==
X-Gm-Message-State: AOJu0YxmckxMeF/uzXlAwipFBSJxEMTpXBsjyici0pcqju8SnyD5KZXK
	wwzPUqdH3aeAvDW6Pf0hIkBpsC2W0r4n3FZZyUf94qTyHrzMelbngTtV4TjHvk0ZJsyyCLjZ2h1
	9sbwzee0VKXc4oceSicl7ukdoRX+DBkWhKSfOLWoHHRGs8Lt3Sd9izBKUlETkLkgi7EbHPg==
X-Gm-Gg: ASbGncsD5ZOcPkRhwRmDUSh303WuAP/baTA6q3Sw8J3xK+hHXlYXH/W8ZeY/nKqd5z/
	IcnyyVR0R5Wn8XsJarMbreRZteYvEwk/5mQR+g45qe+MtQ4xANRl+Ti7iZLU1dhSnP5cMBaeQbu
	FnUiK25a/Cy4UO1N+5NjcIW6zEJrvUaAXGQI8ytHwBZO0vOZdDMhfQXUng+gIgK9y8QDMUacESN
	49I2HILHGLbGVeDqvFlM4TRBs8c2ZjZrd3+Em/JqfvantekhGFMW0YSEN2q1+qIRy0yJ4snnJqp
	oTACccbklVjxyl2zltZV2p1J8kNK4m7Xwy4YqsYUFROdM584Es3OTKk9iex7FOsbN372c5nVXPB
	VOefjA1/ekldT74UgTG8J5eF9PCS4
X-Received: by 2002:a17:902:f54a:b0:294:9699:74f6 with SMTP id d9443c01a7336-2986a755558mr27623615ad.43.1763115768522;
        Fri, 14 Nov 2025 02:22:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAYL4yAe6yDVMwggNZYuI710G44ZijcHgePARCZdvnUFPU4HcL5StexME9kyo5opZ3RwNdRQ==
X-Received: by 2002:a17:902:f54a:b0:294:9699:74f6 with SMTP id d9443c01a7336-2986a755558mr27623385ad.43.1763115767997;
        Fri, 14 Nov 2025 02:22:47 -0800 (PST)
Received: from [192.168.1.102] ([120.60.77.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245edasm50883705ad.27.2025.11.14.02.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:22:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 15:52:20 +0530
Subject: [PATCH 2/2] dt-bindings: wireless: ath: Deprecate
 'qcom,calibration-variant' property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-ath-variant-tbl-v1-2-a9adfc49e3f3@oss.qualcomm.com>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
In-Reply-To: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6347;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=k3nnJASyGzjwvyMuUxQFV6JFb1OmNF6MwYd2U70py9w=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpFwLfhfLZG7hwNQalZFkaKtKe3vWWu+Xk75X+w
 3YQ7r9LW1+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaRcC3wAKCRBVnxHm/pHO
 9RzaB/97wv8NzPTBqYcKzOK7mewrlHPXfc4PuQvOcHEq+C6zeuGwE/6GKb6es/Yu62eOuhB6Hie
 GO8peTK4ZSKZ+2ofnCcGa8ySrZ5V3I9QFVvdNi+kRBn6R5FEj5NwSC8iH4o8Z+7NSjycB3mMJ/Y
 DqtNHur05DpfSrHGw4JBJr5X59dTQ68J7Dulq02j/28f1Ee1zsYMYh65CHoHBj26cDYDf2tbwLs
 ONi3hrlOjc39Dd1qKMRvvYwKR3gi3Tm9PJSvBNOWdQ8EVF1JXnBTVTLg6Jaa2ruxKdvZyXVgh6T
 07ZlWPoJTAtwEjRrKRJOG2LdsVTYfG3gny5Nm8dY1HWW/+zl
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-ORIG-GUID: MPAdgkvzGcUlo-LS9ouuXxyQjz3k4fQk
X-Authority-Analysis: v=2.4 cv=SvidKfO0 c=1 sm=1 tr=0 ts=691702f9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9R49FEQIXN7mQozuOwW6cA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=SpmQgKv4x172yhoqWS8A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: MPAdgkvzGcUlo-LS9ouuXxyQjz3k4fQk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA4MiBTYWx0ZWRfXzUVtPqM7R46r
 MvvXocR2tmUFlUdOxGyEozh/BVnCotqPeqb7Db39wWeoa79C9RJ+J7X9uQwURt8OQ81T4HGXKts
 RDK01XzzEBOIIMLQrZPcTpn3vMjOnrC1L8FKwiRjrgFayfhgwBpzxl6dCjxcyaLolA3LI4slSOb
 bB50qYRipL3f+pLka+Rs/FT68wnZsL5ZkJWIh3EFrbpo8roC1pvjEp5P+YXzu06BQkG2mcnWrm4
 LCbgZNrntFHLA/foHjGtTDbqYWNRGNrsh/ECeUNV+6kF9k0QbbVFpxiLOJ3rhD9idRXh19DEmFH
 l73mQq3+12s5V4P7N9zbO2DRyGpZSOYG031s5tQuhS3mWYuK8ekjMqvHpK0WF0o5veqUzIQtFSW
 3EvjvDp2sc9obh7wk9YALU2ct8Lj5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140082

On devicetree platforms, ath{10k/11k} drivers rely on the presence of the
'qcom,calibration-variant' property to select the correct calibration data
for device variants with colliding IDs.

But this property based selection has its own downside that it needs to be
added to the devicetree node of the WLAN device, especially for PCI based
devices. Currently, the users/vendors are forced to hardcode this property
in the PCI device node. If a different device need to be attached to the
slot, then the devicetree node also has to be changed. This approach is not
scalable and creates a bad user experience.

So deprecate this property from WLAN devicetree nodes and let the drivers
do the devicetree model based calibration variant lookup using a static
table.

This also warrants removing the property from examples in the binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml     | 1 +
 Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml | 3 +--
 Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml     | 1 +
 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml | 6 +-----
 .../devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml         | 2 +-
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index f2440d39b7ebcda77db592de85573bec902fb334..efe11bdec30dcdb6d48185b68093ea8c247b8c3d 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -107,6 +107,7 @@ properties:
 
   qcom,calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
     description:
       Unique variant identifier of the calibration data in board-2.bin
       for designs with colliding bus and device specific ids
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index e34d42a30192b80311a4c6bb41bd3c8ffc66375f..df7d7aae3343168ffa92bcce16a0b429a6d7bfef 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -24,6 +24,7 @@ properties:
 
   qcom,calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
     description: |
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
@@ -139,8 +140,6 @@ examples:
                 vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
                 vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
                 vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
-
-                qcom,calibration-variant = "LE_X13S";
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index c089677702cf17f3016b054d21494d2a7706ce5d..45ae5d3ca73b75b0755466f4dd92df1625dcb4c1 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -43,6 +43,7 @@ properties:
 
   qcom,calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
     description:
       string to uniquely identify variant of the calibration data in the
       board-2.bin for designs with colliding bus and device specific ids
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
index 589960144fe1d56eb6f15f63a2d594210e045d27..cd6604eab5f3608811805d204a4c59ce1dcc060a 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
@@ -54,6 +54,7 @@ properties:
 
   qcom,calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
     description:
       String to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
@@ -110,8 +111,6 @@ examples:
                 compatible = "pci17cb,1109";
                 reg = <0x0 0x0 0x0 0x0 0x0>;
 
-                qcom,calibration-variant = "RDP433_1";
-
                 ports {
                     #address-cells = <1>;
                     #size-cells = <0>;
@@ -146,7 +145,6 @@ examples:
                 compatible = "pci17cb,1109";
                 reg = <0x0 0x0 0x0 0x0 0x0>;
 
-                qcom,calibration-variant = "RDP433_2";
                 qcom,wsi-controller;
 
                 ports {
@@ -183,8 +181,6 @@ examples:
                 compatible = "pci17cb,1109";
                 reg = <0x0 0x0 0x0 0x0 0x0>;
 
-                qcom,calibration-variant = "RDP433_3";
-
                 ports {
                     #address-cells = <1>;
                     #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
index 363a0ecb6ad97c3dce72881ff552d238d08a2c12..1e6ff8e7a6c20cbe4abe31cacd8b25a78af05f4c 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
@@ -151,6 +151,7 @@ properties:
 
   qcom,calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
     description:
       String to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
@@ -304,7 +305,6 @@ examples:
 
         memory-region = <&q6_region>, <&m3_dump>, <&q6_caldb>, <&mlo_mem>;
         memory-region-names = "q6-region", "m3-dump", "q6-caldb", "mlo-global-mem";
-        qcom,calibration-variant = "RDP441_1";
         qcom,rproc = <&q6v5_wcss>;
         qcom,smem-states = <&wcss_smp2p_out 8>,
                            <&wcss_smp2p_out 9>,

-- 
2.48.1


