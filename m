Return-Path: <linux-wireless+bounces-35500-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC5wGH3T8GkSZQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35500-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 17:34:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CC487F50
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 17:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 398B434CC7FF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED4E46AF2A;
	Tue, 28 Apr 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPGoa7ID";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+YOnSvu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D768466B69
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386221; cv=none; b=pBDnhiw/UQ9/SCPjOBHTLQmcb9/xwOxyC1UZ5Vy4mrT246/H961pEq5dO8/SUeCQ0dMF2w0IONJ7j/LbjY2KG9bvW544QRNrsklL2id0VOp/+RKirMbJN2b8X5VY0KgzWOyi6DNgoTirh7gFfKLRJQS26GzEvtGKRu+2euI5Zfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386221; c=relaxed/simple;
	bh=n11bfCJoefHvmThlP8x1PiTVeFVsEIhjZBpXIg5IZ38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXRbqzcTIHBdJ3K2ek4yediaRkAvrSL1jZB7f8IeFgNtAhSZM+HqYNR5ssnRAWcElzx8ORfdWYs2yE1cDACEZ6b977klWtz1335tABUICFK1EKT4R086u05Sr+DLbCf40tGPZoC+sh8EdT8drTlwRpYgZEpCBbc0NMPHYCPiA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPGoa7ID; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W+YOnSvu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S9riVc2111945
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+OP4W0xAiPDjd5bYE2eMNSeXnhE/RBCJAZjyE4cLE8=; b=iPGoa7IDfNVUwgax
	iQmx3Hn13dlYxiKhW6NWQgJkVCcfVhWY3w1NXgiUS/AO4kbXtAzsbJqfdPE5LbOD
	aMaZdelub8/Unp8pb+HXCzEQBsR8xginxDxZ9BlF6F2PJ0wLwDzUrqo+sdtDjJgg
	8FcBPFGCgBaJlXLIhj9Wis1DcxlQZz6GYLY/WXYtai2KxqkaTJ3x+/fi70R8b0wg
	68KmHm/howOh5nqx9HVMUGO44qYYBxUDt6ASdrC9UxNoI8W+c8giWCAV02VWXESm
	vxIU4fZTShIm+pLIAwBfOkXCqylEyi+86em422/0qZen+6+ECfncdGkpPZGVtiQ0
	f5FCwA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbm0j1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56f6c90b142so18108756e0c.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386214; x=1777991014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+OP4W0xAiPDjd5bYE2eMNSeXnhE/RBCJAZjyE4cLE8=;
        b=W+YOnSvuSQQpqtDg7DbjYnpyTX1XJVYJf6A1bb+Ip4Lzf5TlttRBrXCT4cBfSlMzOh
         cqG8G2vRw7pI0cO5nxGwVAugaz7WvHhgx34NffLiauzyhVyyuq0Gs3/wFAWMFbNyeCvJ
         EwK+CAaAVer0/gZIm/mIR+MkRTmANRol8euvzcHeH+6GIGkuoKGVNqu/ULHxraIbgilW
         R+z4KLmgQM+9MrC7tnYGQ8P7txKvDzpsBg0m2gK7114Nc3Jf/qxwsbAZV2+tFICOmop3
         Y130KMSTgBPrv4LAPeWeO74xW8AEcgiOTieW+bcmucWcNvxwWmtY7hZ3hfAfJf1wbGjc
         ZsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386214; x=1777991014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w+OP4W0xAiPDjd5bYE2eMNSeXnhE/RBCJAZjyE4cLE8=;
        b=hsi4kcOCBrbceQkJfmzKnLwBnq3F6JpK+SD2PSLXtwFVCbFgJwLiIRKUD761w8AD5C
         dYqbTaObAuSsZO8EyB2BEpRbXdBcEL8MufQ9J1jtMPGBJylZOKSs2lFgzCSA0CvD6iFQ
         VA90+twj9RNHc0PkrtjuDYJPCgCmDF0CgbYALD1R3isjxCW7Xr+4Br9ZRh4jolN501Yg
         8ISqgHO4Yx/UKAn7xU0VEGpCKMQ2ce6VoWSOAoWVtMGVnPQZ6aeWsO0r5l1rktuk+oGD
         AvGXpyBYHDbSqG6wBTO9cB+DuwSu9huRBjLNUO583b3u+gHJpdJhqkBz3klYqCfutmAS
         CWsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zk8+YK5Mp+l3owryEZtZZa4CHHdlm2wMyKhhgJkB/07DjnekVg92+JLvl3410Kl6iYgLpy+2oaEP4WxA9gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+2wcV9X5OtnS360HdOdAeWtQ/iIcerOhbxQQbXi6BTZhGsZH
	RzsQrXC3h/Go/YzdgAPzZ9RumXPB5C9+5DBIuVotp2KTMtQ1MFJCDKpyfyhaAR/afShuZ8Q5f8f
	eMJxpkmMdaypif9B99bEv/5tm8A1a1M8J9WIkQH5Fhfeqbs1GoR1kJ7iF5eXohZtXosc4hQ==
X-Gm-Gg: AeBDievFcK+gSXft5/5Zvk/kboCMrRO2U4o0uLh6FbhGu3LWZM9t8Ma3rhZU00scOdV
	F+uScu0zi36TKm1uBgh1LvH1iGFQb80KhCri7RDzJQ5IJIcQMQDkRZOBxEDjD0TXcQwJ+FI+UXv
	FC3fyFC8NCsZBiHhcEpA8pMifOSgvX6N/4fE5e6N/aFZlsiR9zYifatbrzV0BabIuumazQXeQzj
	j1BrBZ+egEuDYEYB/qYsf1tsnno1SxvPpzrI0xcPRHepJHn/ghDk+kZ6ZLmnHC2zDbjBYywXrGc
	BIFWZgp6eta/5v1QvDr4QjG+9DCrWuHjXYlP66k/YeEyLZQbqUcA/QJA0kKY0fgHlnZVg0YiswT
	rf38kVPwYtikfyxcIMr43PY+ZufroFrRazL09kMHWaSW5tzQqNtkejHEbSQPzsiv16VZrZxi15W
	OcVN8y/sdpO1ZQHcO6Mur31y+jgu4=
X-Received: by 2002:a05:6122:4201:b0:56c:860b:c34e with SMTP id 71dfb90a1353d-573a55b83fcmr1687241e0c.8.1777386214194;
        Tue, 28 Apr 2026 07:23:34 -0700 (PDT)
X-Received: by 2002:a05:6122:4201:b0:56c:860b:c34e with SMTP id 71dfb90a1353d-573a55b83fcmr1687200e0c.8.1777386213784;
        Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:14 +0200
Subject: [PATCH 9/9] arm64: dts: qcom: arduino-imola: Get Bluetooth BD
 address from NVMEM
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-9-6ad23e75190a@oss.qualcomm.com>
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
X-Proofpoint-GUID: B9Vx1w-hooeTm7kdemW6Pw5WQ6TOTDv8
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f0c2e7 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=w5cLSrw8bnM9wMX07V0A:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: B9Vx1w-hooeTm7kdemW6Pw5WQ6TOTDv8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfXz3FI5MUf9iDz
 nhyuzmk1juyee0+gtlAwEtbPBtQruP748oi4mMhigLj7/DRENRDmvu4/GP/eprpgEO1QntpjRLR
 KQu3j8Zg4IOlFw119w5U1UVbBbAEJtkpjM1REQccNe9VwZ35mpbqeY0VxzNhJRWX3UJ78L04AZr
 c0yHLrWkqS0siC1xfx7ol+z212j5PezkIUddatqwPNlLpXo8OGsMPnBRrj8rheu6w36zzH1Csym
 2IRQMeZ/8uLbbITB2f8jYRHQBWtAN9e6jZKzRBZXkDhuO9v33NpTvvoorfIpEuN/Y23fygz+w4z
 K4t7McAJnyF/5TSgAMm/V7TjXIvIISQ7EVOeVFEhx8t5/eHyakOcXCxGbSrTk3SBZBLI+Pgm21e
 sDe3N2e+NRpc/TEjOGJQuqlZvlUvUdd9RFvV6z7v1nabX7ZA4VQaQBhbDcBZyUYtr68+0txJIfT
 wJAj/DkNr1XKHjEAEPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136
X-Rspamd-Queue-Id: 4B5CC487F50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35500-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

On Arduino Uno-Q, the Bluetooth Device address is stored in the eMMC
boot1 partition. Point to the appropriate NVMEM cell to retrieve it.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index 35a30cd6f47d6d2e018f6841a05fe929fec15738..109fa76e05625461935e321e15dbfe6c7d452e78 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -536,6 +536,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 

-- 
2.34.1


