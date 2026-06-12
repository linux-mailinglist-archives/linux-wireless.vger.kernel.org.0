Return-Path: <linux-wireless+bounces-37738-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /EugBQwJLGo5KAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37738-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:26:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5905D679C87
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:26:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=G9bbuHJn;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=aDDfRKsV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37738-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37738-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7910730136D2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD871402BAA;
	Fri, 12 Jun 2026 13:21:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67EA400DE1
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270491; cv=none; b=rYwn6IS1PDkjwGBvtULJKnUt5gqZtZkWVTXfZ/gGB/25Oow5ljSkrruWsn3DiHOODATygxi3U9wU/l96JDnGesSBIQCHvDfdBuW7TGEOMSS6oHeEtxkb8RNfOcRFNWmdEOcqLcQ+bmF+LSJ5J+eIriFtl+DqXs4d00vuhqzNkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270491; c=relaxed/simple;
	bh=45LaNgBPxbRtyHZ0FmSbWF4XyTOkfAE6p0u9C1oK9dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSVzgzsG0nj0V/QBW05VP3sFtr1FjUYQ+3k5MPK/PwPmCo2R4zEizwYSRgMQXh+mhGurlPXul1HeexmUknDu7JRKP9+T0xw26omO6AYBi0XskSzAfYMRdJkEz9MDzpKZMdGtbrV1JjZWsvQREqYefIyeAkaq+6jOheUinv7tGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9bbuHJn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aDDfRKsV; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCjHkh3760870
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=; b=G9bbuHJns2jGAuQl
	c0OmC1/0RgFcZ7pu2qqlJpfgj0uKXnddJ3xd6ERtg9Mapdhviz2VhO57OIKzGvkI
	4EEsAKnu+WeJ6SpHHFNf0w6wB7C0OtHHfqPPxm6hMdJHVRmWUl/UlfzSYO2Zi3tt
	YpqODGm5tWyaKKsCqpRTKDrvuRPSHVTdRnrdIyipaf27n7w+OVs6YoTdLT0TH0ci
	WRKo8AfPax9s6U9HtnxoAtmH/2saLwqAZFP7nULUVgKyfS/ERJBRE/3KAtQrHd2z
	Zbu5Xr+GlfJ/PedbDDCY6Hfnma/rCEm7wdbusenoP0BmtcCsiRQ1Vl8mx2LxuMVe
	jixX+Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er29uu2k9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:28 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-71b5daaf011so320338137.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270488; x=1781875288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=aDDfRKsVLX+OoYZcn3QTr0Ix7AHpiG9z4IXLX5laFH8XkPVJoMGoL/z+ykTy99h+6i
         edDCgjMKntvmJWvFR84k9WzNWtQdEOVYWbToCVQcd73pppMJYgKq/nVJYcHHuJvvRX+q
         Z/kkMWENIB3VAYJicYkhkyzlRh7MfZLrZZzhbsUXZBT5/rGUOdpM9W1pTE/XwkWTTVdc
         GsvCsMq5e6Sk63a7ZyRcR2mbulGltznIa9BTWibG3+Zvgs1Lig4dSWszSIhgzQEhXrb3
         NUydsx2VSE6/01kVOAJzRJe+9eC6NmDMSl7x/tt9k05auxmzZYk20ZO25GmKNgeGpfJy
         0aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270488; x=1781875288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=cvlhbEoNbZZ8dANNpLKFzbBees+RiFk+HThVNvRmkgjrne2vcVPzc1Cv0GTcm3jwTB
         aY0tJ3N9zqPQcygoC9ZsF3aG9dpsUXzMbOccwnUxli94UhlkWcYR4qFpTwisijD5CceJ
         ERvF5XUfGyo4MNJfaZQ2h7ZJGhKhHeSMfJbJ3dBdy+yrFAtQhH0BNV1z78oCyLCxUu7e
         OUAF7IrSQXY4xU+j/fyTB2o8f76lWHuT+PlY8HMo8LaeY0srW+zzeib3wMzoS/BaBdtx
         8x55STO/F7nKnA/FRkid61BO+Aik38+NYot8VslW/emvIH69T6Ta94GyEr54/cW3n/3r
         gHxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Ow4/fTwddirg+uecH7aby6+sdMdwSlLAGPJfH+g85xgNvyx3+JXsfc5SOmKx9pXkB+1oE1HaAgdWfrI4uKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89sMV6XN3f8l2+NJuxMuPHfm40AntDHc9ePolK+tr8ygQ8ZU7
	Cu7OVUangu/Vo0dHVT4RfCB1pzMU6enK1drn2EHe8ZifpcLNJA+6zSHCI5euH0ppa/EHJXchQNc
	14J5fhj3m2aju5yPZ9XalOY2sPBLqzo7CyG+Dks3qjRYmVniNMHFWoMy+j3BAxcjAmJqzLQ==
X-Gm-Gg: Acq92OG/caBG8ikGDbrFSOlbtTEQD0psnBdloxNEsMWBdQcCiBe1IPAdyQ8yKCGocSs
	opWQwa7LKeWup0VMkKkAgffa0O7AR711wy1og1oK/eGUeRIRRGuXaC2c+WeDdgXyNAYrA3vpdS3
	LlOmgdFizW57UGw8L+9OgpCosQRa0Z0YbsRUjk6GaVKMeFtt3TXic7PxTxPshodlDxdQca4QgjI
	xDg6IQ1dnQTKD3VUXGfBf2+nqFfyUXBPLP9l5xjcZrnHLQBIDaE6wiygheceNGnM6p7QFQ3Dd2b
	FAadJSxegDmCCGfPXJAiiaoXPwhmD5E4ToyQV5FQKiFDCoRFdiUPQ/j/VF2xhKEBEKCFoLBtUyg
	Ar/MBU9mHEO/GSEy9asRP5gyDfk87HhCYzS7Vxrz10d++uaO9HOylKHU3mQGZy9Eb3QYsRs/oR1
	gyv1Tt8NqWTDgMuqiI1o/YEIk5SqHD46x7wqsmu4g27VRxgTvENx0Jm7hn1i3LbN6hEu7jY+PQ
X-Received: by 2002:a05:6102:a54:b0:650:a5d1:ee1d with SMTP id ada2fe7eead31-71e88b229famr1135180137.10.1781270487907;
        Fri, 12 Jun 2026 06:21:27 -0700 (PDT)
X-Received: by 2002:a05:6102:a54:b0:650:a5d1:ee1d with SMTP id ada2fe7eead31-71e88b229famr1135110137.10.1781270487392;
        Fri, 12 Jun 2026 06:21:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:21:01 +0200
Subject: [PATCH v5 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-9-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX1Ug1ETuddrBy
 qEQE+nPo70VWU+ymP6Ph24SEIGIZeCUd3MiV5NBQQqvePqOaPNnQnG9sNFtZp4/lue6Xfvw1wwY
 1FkDEAV9Xl3oDTBW7+O+STpJ5/cRgfw=
X-Proofpoint-GUID: AGiqkx06Ht2Vve0U47b6M7yzD8eDnG8s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX65WB0CrUuWa0
 18HiWRIYSTp0vVPTmCYEdn4ZFa/6793Ir5gtlgDtNtvPhDeNJuC1B7UQr9DROad+LRfd0JENGya
 ZtPfJIZRHFfpIbQzV6zhntGtUlcJKAnEZv0ZJuXrqa8vHpKWank6m6WGGMqUbLstmHLO1zEf3qB
 sHItyR4MHjEh5pt1aygaEiOHxBFUpyEftf8MxU49zuHvrYEEnA4kCtDH8twsc5j9paCnyyfZhWc
 DkV0pGLEFnba+vALREo2ly622/IjYS169FPFRyHuh1qwYpWQh0Qt7qgvnkZPZydMenO+c3boakZ
 jnqMejxq9+YAD2DUdJPkCwR/0o+yuqYb+regX11OeRd2aNTYk85OpsjJQzQmBbtUqUynCgtHtqK
 Y5mtsQgMDmBYKI43Rg0UqA90n55Kv+6NKLpbm2frv2isp2+SmzNQKiBpt/eA74+NPayz7FrKdb2
 gBw+tcTLpM2iImQuSuA==
X-Authority-Analysis: v=2.4 cv=DppmPm/+ c=1 sm=1 tr=0 ts=6a2c07d8 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: AGiqkx06Ht2Vve0U47b6M7yzD8eDnG8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37738-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.
 com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5905D679C87

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are relatively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and Bluetooth
addresses, and point the WiFi and Bluetooth nodes to the appropriate
NVMEM cells to retrieve them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..128c7a7e76b5b089044745f5d6407d6391055fc2 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,40 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			compatible = "fixed-partitions";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				wifi_mac_addr: mac-addr@4400 {
+					compatible = "mac-base";
+					reg = <0x4400 0x6>;
+					#nvmem-cell-cells = <1>;
+				};
+
+				bd_addr: bd-addr@5400 {
+					compatible = "mac-base";
+					reg = <0x5400 0x6>;
+					#nvmem-cell-cells = <1>;
+				};
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +545,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +593,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1


