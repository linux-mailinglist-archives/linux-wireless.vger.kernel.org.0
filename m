Return-Path: <linux-wireless+bounces-30181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21979CE9934
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 12:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 391ED301B2F8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FAB2EA151;
	Tue, 30 Dec 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4EV8odo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OGc3bYBR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA32EA171
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095335; cv=none; b=oaJ4vJy9SxJzcCYzHbfhJz86KbSDXDYhYiu0r3g707JstdVYvs4eTNzipi+yRvpfq3/BszSQVLPRgNxLf7P3JR5or4ekhNve/L20+mOOiFcRqMcS2HY5G6C0MeabnX0rbjoOYK9cjmPXTlMMO2CqFxMAnhRPiSr8KIQkXQ1w7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095335; c=relaxed/simple;
	bh=lAyvgKKpxUpCZonkIlZPIQ67jJXIdL9qvmQBennlyWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4dmLP3IaDnMeQf0L89P0q0xngxcrno1W9r2RJX9xpifxyoTlDui1jMgo6ldsTDaMVnaI+rrVfi5uBio6AdgI8XA7b1ihMM8jnvVxYYw7w+qniZaLf9n58OzpDZk3THlEHnf8BRh3RzifytXm3K4tyUQBAcf8Ve6k8aYRHCu7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4EV8odo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OGc3bYBR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU8n4UY2284829
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 11:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6gblwXdx1w6zeAfSq0Ah8UQfgC2QXdkAi6Y
	w+qrgTSs=; b=b4EV8odobWNQ3gyKq8GaYk9NBDr5mhm5tc+ZN3zjcdfLWukMy98
	2hUobZVtGI9z8Il+MZ9xOP+ncZ1VT6NoaJOjLA77L7rAUdf8NqKHdEcho8+ZGo18
	9uLH1Jn60kVzEwfdvn0Urb/vUXFZuzSnruvuz+rbJGxktWZXj9aX8WNV4rTZebl3
	wBzeQh36XgMGD6PyP9VRDh0R3puZBYFe1ZX2uDpFjSEcBxsRxxDcPeM/H5h6bxm5
	mOzS+KcmHncXZ/2oCnJd7B8oJZ3CMAte2TBuIX2g1kp68NuPoajQp5c8vkOiujgG
	TEUunEpURRL7HVxuN5nAItjpdtECl+fAIQg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc06gstww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 11:48:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee09211413so263543481cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 03:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767095324; x=1767700124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6gblwXdx1w6zeAfSq0Ah8UQfgC2QXdkAi6Yw+qrgTSs=;
        b=OGc3bYBR39YZe83KQzDW9rYVu1zmb3eue8bB7voHOPNLSYjaO5jX5pUbmJf1DKKvRU
         UTzTb2aLkikbnoO8sWXwpMivIsHSLz5C5qtdyVtQE+va7C4ztkUukrD99jiEnIOLDXRB
         W+43g9/Ht+tBlW+aSgBvAp+59SbpgDu98TU+SybYJIvb/2KissUPJ5WMD1U8agVZMqcN
         Ipl5F76s4Nh3FQ6Pyh1lpBzNQDNWVrExZEcLMZjlpbVKHDC/aqS7j6QO6QjOQKZt48Wq
         il9RhhGjcwnqSOLvkZKMZqAJLoJEGXNv68D8EDJ3NPQfky/8sxv+bv7+ixHYEn0UCKT2
         A0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767095324; x=1767700124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gblwXdx1w6zeAfSq0Ah8UQfgC2QXdkAi6Yw+qrgTSs=;
        b=oEzADzi78qiNQil+8xYYHFeugfMqr7xh9ciB6+JhD9MuGe8o3UaptkBDEVfvzhIpA5
         g/KETZSNWaz2e1w7J/729AkqEjGRfG2yYVEJmaioaWyujJwF59wau893FM+EeI22Q2Js
         4d5nSkF81CCnicvT+uo2sYlN+kucbZYP9pniZqqhot6yPz/VMrDgpbJcoSbIsobhmtqz
         RT/iY5RHtmDh6Okg9rDTCj6V1t2fNydViPEMVgQOvFR13yjBTEJ/Wd0lE4Ytzp5gyW9I
         vkDAoSm8wGvgB3ABMZcW5xbzvkQusztQ9/5Qq1q0li3ompgKGKwZLe8Fpeu4pnPheKkj
         URbA==
X-Forwarded-Encrypted: i=1; AJvYcCWao/mxZdYqrJAjMUuxMgVDRiJk6qxWDe1qNrFmr9x4EwvOqYwqVV1PneDK6Us3vQuA9FUublhLRMf65Cqx6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjw4C3iVSxsiH5zY+YkH0Fpjd1QqdO1im8qdzXrkCiL0sL8iy+
	JE2vq1iGWD4bS7hPIibDOU4ljSVtNNbxfT3l/lst5BBLDrJkLSyCHxhNJ6ojh1CmbLX5bU02I3m
	uJGVAQaTMICy8hR+DTlE5TaUzHSbt020PzUrZNDUTPiK5QN99UF0fsYb8zdqzzVUzycLJGw==
X-Gm-Gg: AY/fxX6X3mzfF6gQ32AEy93zIWH9aKUe4SbEzi6kpDG3C9K/W3aL1+SdhCh/y/kv1Ih
	LKDDJjvX2fTFduIX2cZxKZ5Q6uMJ8rgXcvPhZUphos4NvZ/SyZ1GTZZLHzyDBejIqZTK5rGsHjN
	CGIdH4BXtKB9nvzTkYE3rDh4pZjJ3AtyoGI4i87Kuko8ME7wnMgOFa/wVpH6VtvMHG1pfvhjCWU
	9TAotcKdG3hp9MBP+j2Jc/fwtpe3z4x/mZSkHj82H4mKM2GFfT4pFrIy4Fdk28bCN3HEQOeIfzW
	rwtEHkzJ1SE/N5n0EXq3tqSZ6jv32TiIV0NDFghqIqIZ/aThdAemZYQGG9ln98naveWsj9c9YW6
	R2pJJikpCS1xsmDkq2YFcSib+Wg==
X-Received: by 2002:ac8:5d14:0:b0:4ed:e40c:872d with SMTP id d75a77b69052e-4f4abd93b38mr420088211cf.59.1767095323924;
        Tue, 30 Dec 2025 03:48:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT2CyFCv0kChh+/rJ7qFH1ir6g/EgKmb5547xvY2AGQtQgM6N/P6krs/2LT5m1Gxwmi5VU4g==
X-Received: by 2002:ac8:5d14:0:b0:4ed:e40c:872d with SMTP id d75a77b69052e-4f4abd93b38mr420088001cf.59.1767095323509;
        Tue, 30 Dec 2025 03:48:43 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43277b0efefsm34802877f8f.25.2025.12.30.03.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 03:48:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: net: wireless: ath11k: Combine two if:then: clauses
Date: Tue, 30 Dec 2025 12:48:36 +0100
Message-ID: <20251230114835.52504-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=lAyvgKKpxUpCZonkIlZPIQ67jJXIdL9qvmQBennlyWA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpU7wUljIvkOtmX+Z+bkysoiEVpeQbXRIwAvk2Y
 skPD9L6LM2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVO8FAAKCRDBN2bmhouD
 13heEACBodmZ41wf1yFk7HyKQ/dqO+OqYHQb4hCGMPfwrvEGpumQa4LNARPBc3Rfl5ST/aXDazD
 XGYt8Yuqx72rApNn0vyIe6mo5ef0kaNGY9WbtqcwJdrYdFzwI5eauiGzeecvp2BiNSX3OtrjiZD
 xoefzt0D3irAEYutb2Yvz6kD0bbdbgj+TKH98kjwP4pBlByXn+S6iCtmtU898RVHSIk6hEEw7S7
 UJj1X+a96nUIwCprSM33lfpuC4Gt4IFBeXRMHyG6JNV0+ojjVVnlCybmzOIY7QR9IKXyDJMJtSr
 Rl9k6W5bCIFmzTuVL595TB43lI/FRGGlb5mgqb/nK74sBIpzm2RQRmgxmzgojS/djO7NoV1U2p8
 IGRe5mrVisqJO52SNRsjB02C2VnJ9+VpQ6nZBrBHiskOyZp18OhC18sCUsjIKfpE6d4IdMPxqcz
 kTdE9EYfJkI/IitJ0uanDBLapC+J0JEADt3NyYpgbbqIQewZS8WMsp8lDtCsRwuIN2jUKT3kbft
 Q0Ld0Ipw/BYns8/3rZZvJaDfaoq1XCZWPnSkSCCk6HKBabldhIQGjeWbf5r+PimzZL/foCgBaX3
 fZMwV3LYu0Z4KLX+anXtLIrHat5WE7pmJcuWKwiTW496IKDi394+oLM9U/DPdiCcBEWoApN8bz3 6ziFiMHMlj+e7mg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4rSzfcD6jtz3lMu6AqgjaJEp0WO0dJFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDEwNiBTYWx0ZWRfX4hpFSsWuk6ty
 u63kt2goiQgx6sBip+xgZt3SFqA25Q7D3yh9E1TOKJHcvEAvFW+lU+/sYidrDKuFcm2hXgovLoC
 P7nZ0aP3WVVJ5JdujVRBoBNAHLOSQzm/tgg2gt2oW/r2W2zKATw+g98grdIqZ4gegcjBOsONxnh
 Er3IoCQwzPl1sh+5E7aYnlYhnNwsLDHhOlMWUB9ZHAZR88Kgk+scDK6+C1nXG0QSITrO0otk0oM
 om3S7rGO/SA114HWhB36QFtR1U0wAXf79uvFx+Pz0kUeAHOfGhqK4ICwU49qFwTwk8twXPyVjDp
 dNHl+kJ+Ls/TjtEzMVxINzrdJBlv5uNgp8zPHjxrtRukwPe2/7hyII2jV+hQ03Slcwdt+A2+bR/
 dLKf07Z9MgWCb1WUS0krC7twAN5LNE/fJ8c1mZpDlBBjaLY642cXfdodiFJ0liF4AOdnmpDA8Zd
 0ihxj7f1JQfEww3+dfA==
X-Authority-Analysis: v=2.4 cv=A45h/qWG c=1 sm=1 tr=0 ts=6953bc1c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pcR5wRsarG8z_4OSWGYA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 4rSzfcD6jtz3lMu6AqgjaJEp0WO0dJFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300106

Simplify the binding by combining two if:then: clauses which have
exactly the same conditional part.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml    | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index c089677702cf..0cc1dbf2beef 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -214,15 +214,6 @@ allOf:
             - const: wbm2host-tx-completions-ring2
             - const: wbm2host-tx-completions-ring1
             - const: tcl2host-status-ring
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,ipq8074-wifi
-              - qcom,ipq6018-wifi
-    then:
       required:
         - interrupt-names
 
-- 
2.51.0


