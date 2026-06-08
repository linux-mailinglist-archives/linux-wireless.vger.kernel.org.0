Return-Path: <linux-wireless+bounces-37508-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iSNhAF6gJmpZaAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37508-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:58:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92376655663
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:58:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hZQpRPo+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hr4bCXZY;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37508-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37508-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DD7D301EE19
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E131F347538;
	Mon,  8 Jun 2026 10:50:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB7345745
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 10:50:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915857; cv=none; b=IDwp64SMuGdzgLAe439q3jIghpYs9HCJgutZ/5gKC75uJ8MqxMyAuiGRk1ctQGiOwqO2Pzk3UsilbsU0ZtoTyKoQc7XLdjChRgN8t6CD5g8hLtuHr5SXD1R9LDXcSPYMM8L9xW1SjBm7FHcCW3oSfdL4CWpcRSSlImMNTjIStYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915857; c=relaxed/simple;
	bh=jD3L8jwoh7BLSovJJN4zvcH6m1V/AR7MZ04B9wQ9s00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7F6pjloE7g4Fwx1XecW9qL4rWwkjNfGdBWuHHCJkAoHGLjEsoTWnOwNPMHblv1goFcY7L0LlnaVY1G39rcYagESgpHcBd4COW6aY+3aMSiyqlZbfoy/atLSXCtc7rUiwWwI8BtEMMOEjR53ciK16F9ywiZR8w4bKLgAUkaEqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZQpRPo+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hr4bCXZY; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658929iH2677495
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 10:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=; b=hZQpRPo+nxilxMSI
	MMd5pcC9T+mAN3WIClek06Ot8+e/Ai2PmtXJR1Bu3+KZbDdoe2285pscWypVAbn4
	Ur3BnSeo9OH2q8sbNYwqp3BPlAKJ7q5Qnih4dU2Vzv9u7i6hBiy38j5Jrfe3D37D
	SCtq/HTl5YOqo42uhJh94D/tnWW3GQyLuvyxIiKC93i6vhFj+nLPlFGsw3GBEFqM
	EMx9SM0Oia9iv+1qjpuZjiK2IL9CAv4gank/QuwJ2Ob6LSYHcRzdICOxpZXivgve
	W9CwtJ6yqg7NinEBd0Q5d9N/mM9pUL2Tj3z1+UJ2wI/cwuKMOm+dGb9ZZ5qsNGGC
	UIU4Xw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrkrfe6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 10:50:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517b75c1ee3so14018971cf.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915854; x=1781520654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=hr4bCXZYD1D/FgfGLH8fVQtgaFNfZ/jcG/341Xv6HxsE0xVAGR4TxeYnZNV95gZD2z
         Y3fRbZEWXW7ZpazPux6+u3A4EHDDY9wEjqo9IHRFfaO62tkPnBUhtTFjeLRjFnrKq0C5
         tEpdUMmyrdvnoSEutVCvYrnYX9+uxLnvw1ArQVq9wJjlklsqUIA8A7uoIHabO/bNUiC2
         MsQhRLX9toF5H9ohuTu7RUyFsuU/mggbcwyYIWeMNJvJft5bAasgJ1YS20TpOHAOLaKm
         hSGcMgaET0GV//I47h7B2CVskXcPWYEdenv0JHtKS+55I0T7fMt7vpNvu4Yg0vrQt8V5
         727w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915854; x=1781520654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=rXujNa9pjzFxoOHrifncBd0JR79WPIXyl69M29YTfB88G8+/ZLfqjtASDJ8KvUcQhK
         jFUysViMq7fhmouzzZpIwAZOhhXGNxcuIA7AG+9KrXIYgyo8Tqpfy7VPoK2Ln5EoU3Tr
         0GH36Ex4fLUUr58Wm3mZVA4GRtNN5FC+MhU55qC8FNYycTGHIvBUiSzjRrQAEfGNoiZ2
         7uetYPSekHTqAIrUtr1qVHTWsZ9csqenWfPWRqvWPk+W0a//ET4I8o6q9M+vqF+f7aVF
         rocJu83h/HSe3SBI5bDKKIPY6lk5syVxYppszgPZrRtrefEApc72XSMEdPlon3xDVzXU
         FVfA==
X-Forwarded-Encrypted: i=1; AFNElJ9zyvJ437MAuWiEDqLHyTr/xgbBzgPwzPUCI4wlZEXbPY9LyMeTtntDHdYcZ7atWbMNNGFjEjjHpg1KKn1+qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxYnwApeNc/oB8Xsce44LYvTgYX3nr8zoBJH1Xqi8WXQ0zKSH
	+NaUkUc2lJipvu7SjgPTiuY8FK/2EGTN3WawaeCXsEBUIOKyuoT9PcndjwXCpXYW1uQOoe3hf7M
	yxvpdnv4qY5EgTWaZ17tdFP1uIG+SonLxU+oE31lJwipU5dh14uR9/gnHPTlZW59eWra2UQ==
X-Gm-Gg: Acq92OEnKuzozLZ8PbHPxwtqrjjzaBFSyM4mSSk/dgDljyg3IsfQQIf9l+4duXS8Rjh
	Xe6uWPNEZ80z54cjTMlRFciOL5F+kVMiIGP4R/10TD1UmR9N47PsH2rexqPdq5kowB/3z4zbF7L
	qqB7RwCo582nX2Z0dT69AloV64BIyQu3lOZ89FNpvKpSPpU8ZxWX5D3C2APx47uXnCELnAcvPTe
	U0oZjd5KyLBQR1XAe/icR3yhvD0MnsMBsTGjZBUGqLt6GEXHyWDucl4uY82ENMqp6cBhMmWxgdr
	mTAitin01aI/IQ7jjlrOQNggH8EiPqaGMxtGmS0F4i6J983GEmLN6lWnz70s9pd2yy6b/D1J5rf
	7HM6kTuBOz4f0dsUSzKygrtPUrMzrDaLXhqys9A7XVk+2hOc73wbAAnKsKjwTUdVjAn6gCy8dOP
	Yaqxne/uNDKVEm8BO48Vovm/5hzKmg+oSYs2cK0DxUCgO+48ZCPJfgVt3txoUH5Fw5XRdHzQrLw
	Iy32AGg2wh3
X-Received: by 2002:a05:622a:5905:b0:50d:770f:ad23 with SMTP id d75a77b69052e-51795b4b9c4mr203104951cf.26.1780915854216;
        Mon, 08 Jun 2026 03:50:54 -0700 (PDT)
X-Received: by 2002:a05:622a:5905:b0:50d:770f:ad23 with SMTP id d75a77b69052e-51795b4b9c4mr203104591cf.26.1780915853745;
        Mon, 08 Jun 2026 03:50:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:42 +0200
Subject: [PATCH v3 5/7] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-5-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: PiWs9ncPqYI-ozzz0hVsnQ8bTxq5L-eZ
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a269e8f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: PiWs9ncPqYI-ozzz0hVsnQ8bTxq5L-eZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX1UkoVuhx2E3U
 ZBGEpSaJM79V3QEfZElZlsfh5zbiRnzmgHeKdj8PLSqAmQ5vcTNEftDhvZFpzKiYOv0lEpRmq/5
 riwbX/H3rC3mk+jpOC8MuUafpPL25aZk1px0pa1p+6UYdXsmU9DORgdLLpzeegxiiG/vU7PVF82
 G0Sm9hUV+bC7/qpn4RDEKZ2sRFkDPI/t7L6yE+bAsEquHM1gsF7vHZJt8P18wFD1wFnIgFXNfgI
 wE5Cm9pIDFyllM9M2Vl9ErrmAPO8cBX281QBmyGhXR+KavJuhZpQ5aFT7lUXKj++AYzdz8b5Vec
 HqHyST9AhyDwNZzePa5Yknz210gBC8uhxJ5Yb6bq1gYXXVESJA/i8xcUpDzQm+LfzztfsNKWMJG
 TUSS+zMThCvXN2xXkAPBbBC79k9HYH4V6bH/3e9zurAHhemGA7KKbfGRpRHM/IzcwiayrUzbBSZ
 jWC8G9O4olCKV363hjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37508-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 92376655663

Factor out the common NVMEM EUI-48 retrieval logic from
of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
accepts the NVMEM cell name as a parameter. This allows other subsystems
(e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
different cell name, without duplicating code.

of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
"mac-address", preserving its existing behavior.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/linux/of_net.h |  7 +++++++
 net/core/of_net.c      | 49 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index d88715a0b3a52f87af23d47791bea3baf5be5200..7854ba555d9a55f3d020a37fe00a27ae52e0e5dc 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -15,6 +15,7 @@ struct net_device;
 extern int of_get_phy_mode(struct device_node *np, phy_interface_t *interface);
 extern int of_get_mac_address(struct device_node *np, u8 *mac);
 extern int of_get_mac_address_nvmem(struct device_node *np, u8 *mac);
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr);
 int of_get_ethdev_address(struct device_node *np, struct net_device *dev);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
@@ -34,6 +35,12 @@ static inline int of_get_mac_address_nvmem(struct device_node *np, u8 *mac)
 	return -ENODEV;
 }
 
+static inline int of_get_nvmem_eui48(struct device_node *np,
+				      const char *cell_name, u8 *addr)
+{
+	return -ENODEV;
+}
+
 static inline int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
 {
 	return -ENODEV;
diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..75341c186123e949fbe21f1e51fce3ac74d4f56b 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,7 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
+	u8 mac[ETH_ALEN];
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +73,54 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 		return ret;
 	}
 
-	cell = of_nvmem_cell_get(np, "mac-address");
+	ret = of_get_nvmem_eui48(np, "mac-address", mac);
+	if (ret)
+		return ret;
+
+	if (!is_valid_ether_addr(mac))
+		return -EINVAL;
+
+	ether_addr_copy(addr, mac);
+	return 0;
+}
+EXPORT_SYMBOL(of_get_mac_address_nvmem);
+
+/**
+ * of_get_nvmem_eui48 - Read a 6-byte EUI-48 address from a named NVMEM cell.
+ * @np:		Device node to look up the NVMEM cell from.
+ * @cell_name:	Name of the NVMEM cell (e.g. "mac-address", "local-bd-address").
+ * @addr:	Output buffer for the 6-byte address.
+ *
+ * Reads the named NVMEM cell and validates that it contains a non-zero 6-byte
+ * address. Returns 0 on success, negative errno on failure.
+ */
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr)
+{
+	struct nvmem_cell *cell;
+	const void *eui48;
+	size_t len;
+
+	cell = of_nvmem_cell_get(np, cell_name);
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
-	mac = nvmem_cell_read(cell, &len);
+	eui48 = nvmem_cell_read(cell, &len);
 	nvmem_cell_put(cell);
 
-	if (IS_ERR(mac))
-		return PTR_ERR(mac);
+	if (IS_ERR(eui48))
+		return PTR_ERR(eui48);
 
-	if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
-		kfree(mac);
+	if (len != ETH_ALEN || !memchr_inv(eui48, 0, ETH_ALEN)) {
+		kfree(eui48);
 		return -EINVAL;
 	}
 
-	memcpy(addr, mac, ETH_ALEN);
-	kfree(mac);
+	memcpy(addr, eui48, ETH_ALEN);
+	kfree(eui48);
 
 	return 0;
 }
-EXPORT_SYMBOL(of_get_mac_address_nvmem);
+EXPORT_SYMBOL_GPL(of_get_nvmem_eui48);
 
 /**
  * of_get_mac_address()

-- 
2.34.1


