Return-Path: <linux-wireless+bounces-35497-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAYtFBDL8GkKYwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35497-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:58:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6848772C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B2A43037911
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79293466B5C;
	Tue, 28 Apr 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DtAn6knq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BhiMwWGK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1D45BD7A
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386213; cv=none; b=mzQHnDQPdFyg3x1+nnnznDwd5zjTISWYfv6zSofPd+rnopz1IowAO/uw+wsLBDE3CgUmDz0qFtU8lu2Ctp2+bp3DrNP0YO1NOUnN1os/bgBbVKpn8OlQMcIdUFhtxcCzmZrx5DT0dJ/msAB+fctkPAEg8/bOl6PuljjtrG1KYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386213; c=relaxed/simple;
	bh=8aNLvyuCs0cA/dQVyyMYQTpbdYd3gLaJzFwxfD7t/3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZgH9hJCip3ccslovPpDt9Yx7prdXgeMUvMxSEmbTm8dcl0evJV1/ONjZy6Rh/ec+tp9wk8Hb6Xt+KBmRYXmNspG/9d/01nQp7LEl7K4SbFYknBTyeWtQ2uZCh3CU125ZVnr2gpdNgt2AQsT8Ij3HcH1hzoahRnAbfxVo6byKoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DtAn6knq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BhiMwWGK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S9HXm2662902
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=; b=DtAn6knqeUmwx9Kt
	yl5DkawW+RQTgBprHQ4phVtcWPE7jBsnsjJgw/ee0YFczkz+EmS6GxaLa9qefrjy
	285x9ymwBvfViyaLyksWqIX8SLt243kvbWvUMVwKepOIXt/q/qaJ9msPNOIZ6r1v
	tUjKo1nOMMERMOKRjwq7/qWcfvsbLG4Upaacz7THphct2lW2FasJqtwVaLUNj3v6
	7k127p/VB1RiM0iltEkZUuyAKIAExZi2r7wUx48Nbv2PHdyeRxglifKabRP+lQif
	bnhT4R13shiAIqp2BYCpbPUNEvt7SFXSCSwyE7K2rxi3OJcPKm3bv/v3T13HXrIt
	JkSH4Q==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n4bps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:27 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6961bda4505so5745862eaf.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386207; x=1777991007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=;
        b=BhiMwWGKSC1alLhVU2T2QFBceIihX5bW/wNaAehaBlGFj5wqyA0+Ik3C5lSW/KkdJH
         5M9EWVj5RjWkbe9+ijA1Y2li3E0sRERTWb0WNVf4EChKXLqoqoykaWqoOeObs/w5DJ/C
         evI66CNGwDhewDv78D8ZG+Yt6HhnYyVL/K3kMXpLFLqeFaRNkSk9v+7FZfTBRnLJOabn
         uGgcXVDTnuevrsv2LwhyhVqAMHBuqbqED7ocUIt397U+tFIWrlgch/2sYY+iIZuCsCCE
         mGSudBuRVPhFtkLLVk10nkr7yk/Waekd3Cuu74V6JcWALp6K16TprLLAWaGiQXTsxOTJ
         wOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386207; x=1777991007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=;
        b=Z0V/w5+zfw8nS6owCtatWnbT2pFK62Z4DEpITDDTrZhgJ8a1aHxN2+PfZYgysKo0m/
         J+7iArr3kNmLfyUcMHuy6DzfwlhmcAo4h+HDYx7p4G2D71yO05DSTPKxn9AxFtMOb6qH
         0agocL2HTpLph83nFRhW2R9Nnri7QH6WUOY4At2QMyo/2Eryj6m8mvn90ptN17e2fDop
         SIvtPXEQDk/vwFoIEvRAOy89gvjQ2gWlCUVkMogUSJCJUyncQrfcxKCAjHhiWjwBOSMK
         rdemZlB0faUXZSRRRu+lU9q7y8tEEGhtb0J8Uc/wLb8oghFLaFUxpHTk0HNW57XxXyZp
         M1SQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cV43VWzol/ir0J4tK9DfUNbzDnCQjIKHFByvyf9V7lmKKoM3S9ROzDGNq6SVYkOg8ulBilcdZ3Dj01yf6Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9XS7mp9l5TzXOc9M+Zvgk4pNoSrrSE/x8bhLcoqBMl5kULyl
	RhEoSiNahp8CIQwIBVIrv29XSb2WdPTkuSA+d2c5n+JwpXbUzpHRa4groVKqSJIifC2vRv1qZ6f
	M8HLgYjKaAZT2uSeDazX9KNLPTlrSqA0aw8n9PHA6JGOc1+ETR8ICGZ7bwPO0PCzdR36lLg==
X-Gm-Gg: AeBDietl9jOL37uhE6wC0yTS1Xdqyf8LKEwSwhD8V+upBuGQ5utLqhMPF+StZNMKFG/
	56zA0MG3mR6eE0w8RdggIkF3XqBk49A3v7TrFheuqZrYOilShWqIkKJrjaklMp6XSYQnWBJiESj
	mPrtEMXafv8RYh1ypReCD6RNgte0w9FhJC4THk0raSvdvLrENqfxDKacNd9zqUqBQWs0e72tsOW
	KSdca3/l1EvRLqgwxDwCjxjKDC1PFpa/pEfQ3/OiBrNPerO4mlawMneUlGi93sh/VUGQstDbH1V
	tWmRo2SBW1etSkjOXc7hoA/FvtGS53NVRE3r7IIWvxB+nzODhGK7j2Cv8SRNBSHFFpFZTLBpJ+b
	WKJD6sbVVJCf9GSNpdximogZUO5hCqdR0dSbr2Fo3utC3/tUGXS9o4d4Dmu1PmN7rMl/dlSOU90
	upguRwK7nJFxXPIc1GzfWBUE9ApyA=
X-Received: by 2002:a05:6820:2d0c:b0:694:a362:e3ba with SMTP id 006d021491bc7-6965cb93af6mr1550271eaf.48.1777386207303;
        Tue, 28 Apr 2026 07:23:27 -0700 (PDT)
X-Received: by 2002:a05:6820:2d0c:b0:694:a362:e3ba with SMTP id 006d021491bc7-6965cb93af6mr1550261eaf.48.1777386206866;
        Tue, 28 Apr 2026 07:23:26 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:11 +0200
Subject: [PATCH 6/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-6-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX1i39TeeVzINV
 0QrbfYLT9OEqonQk8z+ODu3ZWVB/NRApm33dyxRzC8CgUVR8vfPGH+0vgx20qIklsSXZogASurr
 ROV3FofOBPPWct9fqcSdgmplf61jshPKiqBD+H1ZwR0ERGaOZn1fKbcX9v96VJe1O5CrgNy9d2v
 MVuzWSmPb7/50hoJl4XpGAvp0H5ju6NSjSEgk1O1DsXxOBjELQE7DydpvUyT7pYPWZMX2ITWrew
 q6sSMLY1wysRSiNl9bT9ygxUgQZ8mUMtZUscGUfDgCU7d2R0Nzo58pBo2QytDR/LsC/KZCuHQOg
 SLcsjabNojkojcfSMJrxr0O/GBjCSzLC4wJT2HCEzVE1v5Cde1zS+Ma3CuqMR96scMVNDtpk6Gl
 ViqTRU5irPwTFjcJ5FTUOCb/mV4Ihtd+/qJR9CqkIMvzUUq+IFHp3HlAerEiKffnKSDUmQKua7E
 eecL1Xqfcshpe+W/pVg==
X-Proofpoint-GUID: 7V_3QicH3Xzx4A4PjWpRY1QawB3wY-TL
X-Proofpoint-ORIG-GUID: 7V_3QicH3Xzx4A4PjWpRY1QawB3wY-TL
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f0c2df cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136
X-Rspamd-Queue-Id: B9F6848772C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35497-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../bindings/net/bluetooth/qcom,bluetooth-common.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..ecb3de65506f7f0f1fc1d0b9bbd316163b7c26e8 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,14 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    items:
+      - const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1


