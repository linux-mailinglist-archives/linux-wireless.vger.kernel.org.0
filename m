Return-Path: <linux-wireless+bounces-37562-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 47EMOb3HJ2ol2AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37562-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 09:58:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884365D74B
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 09:58:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=oGK78Hh2;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=V1L3oOhH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37562-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37562-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A817131077F0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA35E3EE1D4;
	Tue,  9 Jun 2026 07:53:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459203ED5CD
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 07:53:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991601; cv=none; b=RN5lEt7u0CgJF7LIlJfCT8kfD8kW23sw9ROZHZeZzkAf9Rn/cqunBRQOxOnBsZ4Ul+9IyNXa3cd22MnKm5kQEne+2yAbkx6cGFf/s2EbkGEO3n6/VjR4fDOd/cREKwQUdgkYiQXuEfhH0A/LmU8ngMlie1geJi5aX262gmezsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991601; c=relaxed/simple;
	bh=yYJ5VBN7wBwAYsQ0zlbRkE0xdiTrAcSbG/QNNToAmpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2ijMydaEQvyg/lZF4PAG7ILZ+kbm/actTRHetXWospmVCC0RToU8VxDUHDu2BCAJpT4bjGfS6T/X4I6a7JuAgt2Aro7rbbFa1ie8PB5xuoneBBx55yr0dYJtWdw75FoBl82kKw3VfRJ1K+O3nMJoawGdNibSGUhoS0F1FUtr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oGK78Hh2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1L3oOhH; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6596G7741736424
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 07:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=; b=oGK78Hh2GvSSk3nx
	gRnEthzbKV089nIAjT+pSAu6UIWXHONVitXv+kCiYNajab87B+rFJbZw9tkGCq5B
	j1v0xQtK8QFmGL4AiAHzvO3DrS1j7d0IIx35SbMpvtzTsRXJqzsPsFplwmJ/7Uik
	xha+82hUokTCipYZ1DCkQE+tum05qEMgwTeSbTBu7/e0n4Qky/Kv7swLuSX18C0g
	g6uS3XehElds/iQla4W4q4foq9qDeMYFes1lTTi5O9+qZi7jVPiUZhNLFx1xcdtm
	WR4lK1+q0aM/KbvRlQQeCaaUEpY4u+rq/tDaV0fQr19uQbHeaLK8b943DzeCPHc8
	vbkc3A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdds8css-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 07:53:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ccd77414afso70926336d6.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991598; x=1781596398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=;
        b=V1L3oOhH+pqUN12byo5Nmtn4RJwdRG+59ehbHvN/X2dVdIEWt0SYBuNCeC/25nmRPW
         8MKbaJrfgXeWi7saPTOq8hHRGHRQQDW2pjiMgH1zswy190UleM0Y14+/bUVS/UZ5OYAF
         QbT45Xwmbf88kbYKq3zUTPKtFlFj4x/tQiRSrM5tIqnsUEh2/N4qT09wphEIaY1safcD
         ++voo/p3XpsQPjxpFAfvofRZI7HKZq6JijICU0ICHRYHg7sVNPAoSjqMTSNwN/qHjbqo
         4FIlWfCTCK0xfWuh3mP1mJIdl3+rIRPYBGPqGRc8b5htK6cga6TaG/sGFMwXPVEBbPi0
         uYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991598; x=1781596398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=;
        b=oVsmiUWRhA4QOg9OO7bw/aOIGxEatGDtD+OJdUfeW3VLrtsXsZcu7sQRDJuWQtVGqf
         ZzlElSez91ALwwgChzBytGJVWAYiEx+QVa2s8fwt5zul2KGPO3zyZTKfE4tdHWLI7qYP
         Mvu66oh+fDEu2hufgAB7sb5vcaWMsUkTUwiVM6k7j5DOlzZXyoRWyuPT1uFArYvuwE5i
         5lMykxA5TEpAzqNq1/WFR31KfaaDxrtLJ06l7VNfEdJ9tLAgSto4px/2JwutDNk2u7Dg
         mI1ipVLIAMBI4uTMlvwt1F0sjJTjN2IDJbUl57b/JpBNSBZE9KQHcjPvjJuHjtE1pkPy
         3zIw==
X-Forwarded-Encrypted: i=1; AFNElJ+lo6UsRa1z/yRnkkxKW6Y+p2eTC3YQgX9AUk9dyv7SBUClvqQMamkIVZJFtN3kpswl0JD9UJbvWXqNqf+C9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYnSUpnL4dpvd8U+idbh/pyLU1PCvztjTpqOScmKAxDIh7W1b
	Dkbqs0uGl/MOPPpXeaFP0abTOrQ9tr4OyLTJtbSSZs8JyzeYW/OgAF/g1B2ZpixqCli0vwz0G/Z
	yOjRlmpvwGlJ+ObcQ2G7azn8sqEHtxsLm7lR+KCcyqJKtlKm/O8IvXpGppOk+LshQmoWRqQ==
X-Gm-Gg: Acq92OESoCTUsZK1CuJvNiB+uAdfTMVYDrjg2Tl6hv1mUXhFYkf8Hr+MYL3YzTXVji5
	LPQ3gFgV1lRXehFTKwmO/7FBJcpgznNecATIH2rytrSJ+ytd8cpZt4pxmsW+E89sDVaBsvNOaKS
	BVgexA5qWNquzKlbV2G8NF4gqz7P/ls5glUE0+oFLXOz7nHtuXMrAZZJ0T7ICta2NGixsxUsZRo
	W/NV6S6dX7JlIowmFjzee6E8eY8ry4bz+k0ExWw14smqjPeUJbU8u6mVEf37ke3+WJ3EJ8RyQ/D
	su1wOpcb6hGAHaGRM4iw9futxRHBhZN4wMoiIy33gTeOhGuccw17zFP0IUT9qaztyYJpGkJJiMe
	UC2QYA1a2Gxz59jEeJrtmARswA/1POfWV1CROGUOHL5GDljvoif3KR3sxAakXxXWm6wORpufDsb
	oJOQnLANNDNXFbb0suzwaPa5GfWhBbZRltcUTr9U7GcQXBdp1c1cVjB+We+XZrYd5pU4TFW5mWt
	KPrnbfgDYTi
X-Received: by 2002:a05:622a:1a98:b0:517:a9ef:ce3c with SMTP id d75a77b69052e-517a9efd0bemr186043361cf.24.1780991598490;
        Tue, 09 Jun 2026 00:53:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1a98:b0:517:a9ef:ce3c with SMTP id d75a77b69052e-517a9efd0bemr186042831cf.24.1780991598097;
        Tue, 09 Jun 2026 00:53:18 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:17 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:27 +0200
Subject: [PATCH v4 2/8] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-2-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: ZA0S8aGEsbgpda38XsiYmjjINFGpvzT_
X-Authority-Analysis: v=2.4 cv=EI42FVZC c=1 sm=1 tr=0 ts=6a27c66f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: ZA0S8aGEsbgpda38XsiYmjjINFGpvzT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfX3nmf/LwZ1LRl
 ZkNBgkYX/8qK7pjkQM7Uz979f8b8tfMJAq8Kccs0Zp70vuB31YorVef1fAuBZd+3Hqi/eo4zIuu
 RFAqNtrNB/T2o4Tni9ykbPspRFePN3FxG91xnkB/9u+6zRLmnwWPDHHPAtv2bJZaX+WJaNjX6a+
 QbftmlZvSxNUwpeEvzZFl5NoWNh9qO0dJB/3sQ+XZ5hAqp0GNUEigcnqFPB3PAEGWNcgSWHo9BP
 TB9h4WoHrRH7/Ov2SKCgIIwCBNBb989pY6tWMbvHv8c5r+YvJSzXX3QfU1dQ3EgdTHY6jLM4F0D
 UIWtiqAtte1qFzSpUs3MYEhGFVZ+8a4fYlJG61FDa/IlnZukm3pYtBv+RwyWW4JjwKdCsVWCE+S
 0ITs1D1hl7dpfcMTnuqgzSBQXnANagkk/zN7jpbi+Em0dMe8eHPBtZNjnllgVVWCelPBbctvGFQ
 UbbUgE2ng8RFAzmYG/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37562-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5884365D74B

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b9919d48c41ac09f1e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description: |
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1


