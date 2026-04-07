Return-Path: <linux-wireless+bounces-34424-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DSpEqOV1GknvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34424-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:26:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAFA3A9ED2
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84F10301BEE5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612A378824;
	Tue,  7 Apr 2026 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UtybaZtp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Da4ZNBV9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5737880E
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539602; cv=none; b=MPlQDwVX4CIFzhmC3ukSsw/GWIknN3lg41q5xZRcugq8dJJs04+bL1djsLvOoshk7LExu75vkuQUBNaS77Mey4vbzpWL//3aARrPcAlurogNWE7eAH6J+V5GdVbqzITQ7drWBrFRpesr2Y4idy1tdGg59k0dSQsoZ0bwi8BQYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539602; c=relaxed/simple;
	bh=evF8UelYqeYrz/mPFVVwmW3vrS6iJxnqj0DMj4NnPfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mw11a9iTkF0GBbLQKz7ZLs6xHWbmoEEfBsxi4L53NUEm0OAMEHp1GU2qs6QQwXlznC2Hb4nLJv/vS/GZ2Tg0T2eUC0/Ft7ynwPlpR7hHSKUY42UOLz6wm56xZBgXrS7LxAGGegAs8TGhC/z94Tbj1iBbB0IM/Kx3Z9PaGVEfK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UtybaZtp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Da4ZNBV9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LSv702580241
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 05:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G+ZQek3ZrEXnkEljZj/45IgLfCqU1WoOU94hrFBCK+8=; b=UtybaZtpNuwIgnyG
	O8CFd4bbT2ohmZr3RZJF3G4hkHd1mk1LBdst2K4q83TCH36mIL6eZ1CTfq7nwmwU
	P190/bIq0xWDDL9O73Y769hu7+UwdFJK7ddARMgabS2HBfHdhMWBXwGxU+0NUIVj
	qhaMQ0bDdLkCYylbFtpXVYUXLJAOotzvBtWlgYGjjKNDEu9VrSLDxQLkOevltMOU
	l2g/ku1PdlfSy3dGj6ikXJN4dQiQYQo3Js1wX42pZ2gFiJI9W+TCDnBQAZqMpez0
	VHBOQYLB44sI1s0LQOxoseNUds8YFdS0T5fg8x6G+q3ihnMu/yUCCOVHBV5B1euE
	PModqQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf158n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 05:26:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82a77f807e4so5961146b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775539599; x=1776144399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+ZQek3ZrEXnkEljZj/45IgLfCqU1WoOU94hrFBCK+8=;
        b=Da4ZNBV9l6RxnGC7IX3quKWJsYuA7qsKUneJw3WnUdogw91xLTSwQtTHGpIj3Zzl+V
         AL6S/A8aYstB20KE71xAxKwv3DNtAiRoBEYYFgxh79TjWVylA6VP7N7kiohQHG55H0mS
         moIsplHD8Kc6Rlv5kNzI92/B/5WNH6id8C9+26ZycxOzPyQvOSa2d0opcLwdBTtz7LfA
         kMcla+DUtOTZUL/H0tVU7Q1zClVixlcWKl8ex+/X7ZoLXJliCEzZtz7dM12VCqcsHqjU
         jduNpmA1mq+2wVagcCwyY5+M6byI7vMVvZIJjiO5BTfd6w2XcLmZlDeH9BK3KaWKHKb/
         rSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539599; x=1776144399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G+ZQek3ZrEXnkEljZj/45IgLfCqU1WoOU94hrFBCK+8=;
        b=phs8BmtIGAaC7KnqFL9aEKs8qdD2KQx3dy7naayugIpVNgEhoEjgKQMeFMhESJBVqO
         nOH9LC8jBDhNNgFUIPo9netuST3Z+FVPX3XFOqWkM4A1kyP5HOcuLy2xH6O7x40Wsizm
         ER0/ctOahDqohrdoSj+XJ0C32QvVoba7+Q16fcs3vyV9SVmKQejLej7dXMBxEari8y7r
         SQbxyt2Y9Ve5miurDtOJh1u/hVYm4v73fbtpvNstpXlPzLhQowoV8X0OrBYS9DAPO+/b
         9Ek+L+ERPEYCsZm/U19SHTNUvrizStWt60fNljpjG6lCdlgOg7eayFNelpN4xcUDZp0f
         9aPg==
X-Gm-Message-State: AOJu0YzST8DtYOBk9e7H7VSYGNtn8jsqPcbUXdymX1UoU2rQ3Cx/j4OT
	AJIzBJrPUYioZNO50UanlKmzoeG9ML155p6Ijt57fJsFmGl02P5iXVnw9ybLf8YmtDKSelkQmW/
	ci8PDuT/5XrGqDc3lP2UiCXYSg/c8kMwZoQA3sip1Bh4o4yv4U9IZUdHBMs3LtpAOrDYhs89sZx
	1aYQ==
X-Gm-Gg: AeBDievyDWGV0v69nPDrh/U8eRpoTYNBtzA15cJ+YZnngezZwQN5uqH8O28q/mmsf5K
	sHuuklhkgMfbufCaS562fk4Ajg1FCOkjiWh9T454RvuSvuYDblbKkozW6DjpkOFImOcBskxKb1+
	rztSHuWYc3j2WlIL8b9g0WcH0mY8x/V0337tAb83gAszjO6NkGxplPkftLfeAWQ+CqBEz/6bLMX
	rriC5xmzOXyVpyMFlmElndFFiZ4fErbT5eVKj67DYG87TB8pEIVDOdTAl8INauDUsQXymoXNkWq
	EkL6yxPFEFcr/A+gWP0BJKVXlL1yfK2J87QWXbNBGfG3/oxLyrPbBYAw6fZZT48ripeIQ52FDiZ
	t7V99hvFqipvmad9od4l1o2eCf7stZjqkRhGNyHz+nhuo8JOPIcGRbUq7nIWHx9Hpm7yBfZtaXQ
	ZV94l7Nq+sfu61CwBtNRYmK8QuWOPvbxNcwWPgBAE=
X-Received: by 2002:a05:6a00:bc0b:b0:82c:24d5:21cb with SMTP id d2e1a72fcca58-82d0da284e4mr14976077b3a.8.1775539599379;
        Mon, 06 Apr 2026 22:26:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc0b:b0:82c:24d5:21cb with SMTP id d2e1a72fcca58-82d0da284e4mr14976050b3a.8.1775539598980;
        Mon, 06 Apr 2026 22:26:38 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm19897219b3a.41.2026.04.06.22.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:26:38 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 10:56:28 +0530
Subject: [PATCH ath-next v5 1/6] dt-bindings: net: wireless: add ath12k
 wifi device IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-ath12k-ipq5424-v5-1-8e96aa660ec4@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OSBTYWx0ZWRfX1zHQC2dzZTAo
 f9ui0aj3SFi3H+6RWl9Cv0r2PsIuv40jcYaD12ddGBSdvt914RuZDf0LzxcAtyvMmHaTstFXRkT
 FtJ4vhv5OQTjrCtymzYWJpdiFxBbO/WBJyFVyu8A7EK7yHXL8isFpePl2qNlxOk0adX5dS5MV9Y
 7mBnYv/QVCSQEgxngzMUMaOvjsIuJ3OWBzdNKFr4qGtMuxh17fSE2lHSm8nsgbTzyl+PcPjNuvK
 jfhBhZBzyTqMcT/rZAATZ6Lnny3bHShebCmB1+r6AGI6WkHa7eMckEsRrrbMGL6bYaQtpqs2DGp
 8Yqp268uC+pBQchsUUE44mH0rPyBmN6NJTIeQFAAN4dyfk9KR+ry9RMwhZ46lFt/Okqgx/3jXXs
 ScIxU64S+sCfpX+kT76ZQ1NIhOKLjG9ZB8W6JXz6LZSvPZiWaTKMS64EV/G2VHxfYOSUvunv4Ba
 dnHu0n3JT3Ozdkj586A==
X-Proofpoint-ORIG-GUID: 9VzXJvzvMiqoLmhC82AhqIBVLtBuWzc7
X-Proofpoint-GUID: 9VzXJvzvMiqoLmhC82AhqIBVLtBuWzc7
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d49590 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=HmtOZnpMNtbFe9RdH4EA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070049
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34424-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EBAFA3A9ED2
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


