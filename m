Return-Path: <linux-wireless+bounces-34301-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK1JMfXozWkLjAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34301-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:56:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 425833834B2
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED2BC3072F2A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 03:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608E535F199;
	Thu,  2 Apr 2026 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+UYTIgU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PWmEjTd+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8935AC06
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102063; cv=none; b=TdWaxaFgtv6mufjdEsxD+m/AXk1bHfVp/pLgiezf6mStDrXc2XvH1RpVbd5aEw5u49+Tq8xEAb3k5jubzB/sPQD4CXTVxneIRCoAJ2PreMwTPfGIkJx6dfbS+9cUlf2jXO+1YKWADt9JIozO3Xr6v1S3q16SqkT+VHMPqOKEDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102063; c=relaxed/simple;
	bh=evF8UelYqeYrz/mPFVVwmW3vrS6iJxnqj0DMj4NnPfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahAQbRHe+FMgrSebllw5LASjSAvdXvakWEX74d8Wwd3jeG+RJYbvN8fD3fkxKL7unD63+Z6u3jnoOOLbdRhoPbajPfutVRpZDMmMpTDeYiZNvc61alVHL730YcDO528SsOvbkbE2oZTpWSV4vlLjdHe8ximQ/uaat8m3udy0W6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+UYTIgU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PWmEjTd+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M3xsM1128548
	for <linux-wireless@vger.kernel.org>; Thu, 2 Apr 2026 03:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G+ZQek3ZrEXnkEljZj/45IgLfCqU1WoOU94hrFBCK+8=; b=M+UYTIgUMZrH9zmv
	egLUbU1MCT6jsyUW6xUZUq2aAAjK7Qd8dEDAz4EYaHY2BWt8nyw3q6vGEmRfOTB8
	luZsv6LM2hwb7hMxmPBO+HsXMP1dgJJkwEBpB81VzN6G+qqAaPCz8kqPaH7YmdW5
	7mb/I9mI6tNCa7TS8KeHk5B3SmGG4NunhxxMbrjmZBA9hfAfQs6BQNPkeVh77xNd
	CsKHKXDkJ827mMOYc+AHVWXjPdEaDi4tosz+UxT1oukMVy6l2Nh6W+FPa4uC6mbX
	OlBzal8sHf1RaBWVoTFXBGiij2xs16yhLJ9NeqRpjTG7ooLXPtsCOy5gFx6CcoaR
	h0JUpQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d96k9a35w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 03:54:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c63f85c84so261418b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775102060; x=1775706860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+ZQek3ZrEXnkEljZj/45IgLfCqU1WoOU94hrFBCK+8=;
        b=PWmEjTd+g9epBRNl+LUQyu8GD5cDOFDT5/JsXJ32HraoK2HzJF2nWn0YEM4fo+7QmS
         dqNgXFbiClsHm2a+udhRjC20DVxkDXhZs7WW5+zqimwbma9GuxN3Vego7de4lHGObrei
         RNLla7p0s28l85hOrn2hKExBZ++ZTfIOLY/Bj2t2WZj7avpwnjhXYbOySRtqp+oRgsIC
         DgbHknVVXm80u8X8sCt9WMq0JA11STEG+Vdi/jYtLea7jjyfoqZ6Xs+53Lsifm1GHI8o
         cHvfu9xiKfVkULrYce/BfELJB+J2A7RwqQMDiqdRK+xLPZ2ODukx7gvCbkCLl/IUvLtP
         qfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775102060; x=1775706860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G+ZQek3ZrEXnkEljZj/45IgLfCqU1WoOU94hrFBCK+8=;
        b=F/H7L2MrZFbcD9YeFlPBXeUeNvXWM0FH04Ss/phgozLKVNKalUUIP3E2zRnuYFeimc
         WdxGaO9Tyd3xsYIjm6OHLzsHCS2IE5mxzlGpr8NPBj+iBV1GXEPsLtEfpBl1mHJRoroC
         ZDrtEoFKIBXBthV7ZkzDZPMuk6hajR2g39hgiB1cBnxjyAVQSYzmTzIpgLS3Ty8EeAFr
         W5E4g1coSc03doplPkv0tyoAgEMyCyRHaUuu2ELvBgXSZsIAJ6cjTYSnDl4enTWkdzpY
         eoGFJbYTnTK9nYUH5Kfm0knXZElo9QTr1Svh6DE2cI1K92on0YUSsBkKlw6nSM2xXjBt
         yGvQ==
X-Gm-Message-State: AOJu0YwIMd7fKYJhhWKuyQGSpGsw36D7JNe87GWjG9LXTbt934Uvg7Tx
	V661Vy4uHwQTbizxqLAsVSz8ftUCtjnwBV8N0CxNhs+YDJ85XUx2DaadLi7xCh+XgqvmZzBAI46
	U2BuS5AclqlXxhKFkPxyvQwHTWWKki/uoOSgkGIvmik776e50iZHD6UOSSS25JnZJ/kAXIRA9DI
	ZU9Q==
X-Gm-Gg: ATEYQzxZt7S+NMwgvRxrOaIx9G4xtqiRZCw6mK69QZLUuqfp/Os3T0Q+EJ0g/29WCAu
	V1Ch7tTY59d9x6qV7A01/Z3r+4kbM7UWNl7szXxItOzPlhia4Srzu6AvmEhw32X9Av92vOTHFVw
	pItidgsODaelx//DTsw6ypCD5eaiidRc61xdUjRG08/wPKdvk76prP7PzwJI0LypKmJsUEO9G75
	n7sN2pjKAcujWYJHxC7HdoNMI9+I0ug8yfV7cbkre1jLKvUZa9TRJOP6rgsHgUbGOnwdCapbCj/
	aUboE5R3eENe+aU5Nbqp/AmyaaWPpyKn7urdN7GA0kHq0p4GVLdbKO+9lD1epbOMfdgdLZF3k7r
	qM0wEuCI/MEo/jwOdN2iwYlnKne8ail5WH8zDeDbHISwWAbRHpQCVx0LGdY1jUkZq1zdiFsvSU7
	vJKro3uoww+RqdbZ+AYpShiC5d3Qgo0zgf7ULUgSg=
X-Received: by 2002:a05:6a00:2d1f:b0:82c:e692:1f91 with SMTP id d2e1a72fcca58-82ce89b5662mr6343745b3a.39.1775102059874;
        Wed, 01 Apr 2026 20:54:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d1f:b0:82c:e692:1f91 with SMTP id d2e1a72fcca58-82ce89b5662mr6343717b3a.39.1775102059413;
        Wed, 01 Apr 2026 20:54:19 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b272bdsm1456189b3a.12.2026.04.01.20.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:54:19 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 09:23:59 +0530
Subject: [PATCH ath-next v4 1/6] dt-bindings: net: wireless: add ath12k
 wifi device IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-ath12k-ipq5424-v4-1-cd1e0f0a6c88@oss.qualcomm.com>
References: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
In-Reply-To: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=doLWylg4 c=1 sm=1 tr=0 ts=69cde86c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=HmtOZnpMNtbFe9RdH4EA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: F4kUWivRQM6OSWtFurPsW7zqdQr_yt4-
X-Proofpoint-GUID: F4kUWivRQM6OSWtFurPsW7zqdQr_yt4-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzMSBTYWx0ZWRfX/CoX1E6QfHlh
 W2hMMYR02HSO657kxAnjk8i+5cLmMv5a6PJMs6OWj4s5SwspsTRXZEc+I1OcImEe7EREuD1QKlo
 3HxnOyexixmPi3Wz8T5InFe68ZdWk+zDbThLJxDzKRFc33prqVTs4kW8R4nV8XekcKX5g6KeUSA
 pMq87qTKRIjEUBwJZxufL5L1c8egJSEtM/T92D8l80gh139riXU4PpbCdPsuHk7LQrqJYlMRqPG
 T8QZJgAUMmKWerG6KkbdsFQd3VZDJ801p31aR/NLCrbyfJtpOzwEP2w5x/o3CrVSL96wnF5hH9y
 9jiyGe02AGC9Xj+Cbi1DuO8N1nFSwU6mqpvbTKbFJtoUWm5M6UfAeUBYQ/nSr7MoxjP403z/FbA
 xNNx+VXcT9iojPiR0jcl4ABL5uxmoGyh2CAcR2rotSXNeqabHdfSDbDuxqMcMrOI4Hqxmb048y/
 PgXhs43OazDfLvjyOuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020031
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34301-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 425833834B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the device-tree bindings for the ATH12K AHB wifi device IPQ5424.

Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
index 363a0ecb6ad9..37d8a0da7780 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq5332-wifi
+      - qcom,ipq5424-wifi
 
   reg:
     maxItems: 1

-- 
2.34.1


