Return-Path: <linux-wireless+bounces-38402-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EY/2CyQgRGp9owoAu9opvQ
	(envelope-from <linux-wireless+bounces-38402-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:59:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CD66E7B05
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:59:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cdR8HRwp;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=XN24c5TU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38402-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38402-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6EAE300C7F5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C161477982;
	Tue, 30 Jun 2026 19:59:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C747277F
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849564; cv=pass; b=MIW3osLmoUwqkMWyTcgLROEAEZ0sBsV8DIe3aURa/QTQoTo13crMtP2txL1HP2pjdY9/JZbTNdG8VdeMuxTh95jluSaTpCBDffCd4huuaKa5lwnXxgRZ58lZj9L8NNlA4FQucT9oiBlzqWmt5o5dyoHFr9S0NBXqc++ZB6gltPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849564; c=relaxed/simple;
	bh=RiKwOhz2rdMC9/aebYm1g33822i4EXTv8wYdbkHCerM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cohp+UqAbA8Ecl5DAZEIkAVoX1LEHGwe1rfDtHaCxgjnFRUxsuVeSqhkG5MgQRH35TVso/4VW2EfLtL29b1zmmWiHS+6lLGLoz0rtDVB9uUqDba7vHTNzwcwyn1o5HAtt4JgPCuAPjoxVZ88jF8/7zqfIKXBpctEfuKn9hLAbJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdR8HRwp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XN24c5TU; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDahX2873364
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=; b=cdR8HRwpOL0F5KGf
	Pa72vskx0M2kP/Z35S2cu0vrb4j+OEKIt6KMM7Th6UonX+P19BpjlUhTk5Li1d1Z
	Y/Wv59ciZPfT/RYaiQrRsZFm3fZPcDfKBwaFfoTbWjAmnFyZj3n9bpk2D9uAq+as
	Zefne9lZYGQzV3whovwFyt/TN8jYz46vzYj5NL0+/lOGbG9MlNpdo0tsMl5xk0yg
	fCV3pDFQVQuR35FiZSvIftsxLo2l1P5E5HN15BL52dlkXhgQkdoSVKvLPz9tpEoo
	i0SPA3tzquu7dDbPf2qsPBmIKC29344dcx2/YoqDcNf3SztycbPjKCqS4n+bRngs
	SWWdJg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sgbs9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ec3314f65fso76871306d6.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849561; cv=none;
        d=google.com; s=arc-20260327;
        b=AT0m0DNUZhU7SPTS6CYNAQgfIcmNJPb0dzw2XNs70wmbNyfSfejwClOFfuTV6ykQva
         ITj+A8fgJwmgcXAnQRWiN2zJnDEoGf4Wjba6m4GJCoBs798dLtuAT6i2nFLJfDlYlgum
         M2zTg/SoKVMcubiQZtxKG9UY9+kc6xB85Oy8AW6Br2J/rfyzio9P733iyIPyWbLcBny8
         DmjgT1a/qgbPqe2U3xmTk72El0FcNEHFSLbcMb6gcDV10XqEqONsQT6dpGDrxmOWjnkJ
         lhzqj2GI6sohrxXguZ/63LlqMIxzkn4kl1EF6QlCBaZYWmBaG0VqwbtGaHmHG339XlK7
         0Ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        fh=t3NdBDBpb0bqmNS4xrORIuZ/8U9i2bXl/LskVoHGGk4=;
        b=juH+h5c8UknlKZAC6U5KnoTbBZBDQ/xGb2zLtVE19NjKdK8c4UBcE8svlATyuNaoAg
         Nm/3ziWghKmM8FwnhDdH81e7b9d/tmDXvSu81PTsDw1BqOxLwDm1VXbrnKVP/kLigtxC
         moiH07LeYkxKRbceYV16o9xISyHWLbAGZWFWcqiMAMQHxogZuowE/srox5E2MXqlJj/t
         b8sH9Gt3fejvWpmBefni5dMxjEgLxUqkreV7izGcl+JgHpGykosFx4ZLkTNGT9FuUEx1
         gdJYhUq4q2oZK24h+TILQHR2vDBsUaLDCcWcGemLv8H8YiAzWQst3iUHUNvn7RSguy9V
         ebXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782849561; x=1783454361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=XN24c5TU1mLtMwwVQrpsA3cb+Ec8JVOKflkTLwTXGBmehHakzQGPaN2aEZbPFpbD97
         LJXI7Xi/LFKLihPbM/Ozc33AJiWJHQW3D1ngB20cGK4F0B+mw1KKlsWOORfLOvwYsoe+
         pmnAxjzZ9/JjnTdkln0XJbGOPCH4QQHP6a4M2/WUsRbPfukntEC+Cb5T4b5ddzPzo/1E
         Fgqd0htDz4EopwjnY4LZMQlSDeipFKR95uSEQi4bnEoxNaYVXOfOSGL1EIqOhDX1SE0p
         xMUobMZUWaIXPebd5HgAPV046c5JKpeaohJhunSH/eiRKkNKEPKNFA+8OSveeGfCXZK+
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849561; x=1783454361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=iuQ3cmsKhyljFYwL4nmkHEYxoSJ30RmaRBeKPq5+SZQx2BsiRA3owU/qS0m81xJ30N
         FFLahLRFRNTDhRc3F7v5/z0+k2LLRDIDs2r9ckGFSJe/e+aZGJ3ONHSexYrmAJypH8vX
         mWxfbm34lCBCmNls6UPr6JKI5bPIuYpbPgvmzRKKmKhMw+vp+6wFAqGaK49FACdW1kbC
         PIIhdrDeLv7wGL96m5VL7s4heiauM89thb07UfeXVw7ve/pb14Kmd9ASXe1+hXhQxzf2
         Y4uLwaiHI20e1/ZYNxTqN/Zx0pv/zI4Aocdj/eEs5ijNZ5ImpEbACUptReflE/bw3Ad2
         ktJA==
X-Forwarded-Encrypted: i=1; AHgh+Rq27+h3nu2wz9ge+x4eo6PExEuT11D5nMeTrZSuFa+qXF2QxsqCGxd7Ap8f81sFV+lozDSzEjy+al/p3ySpBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2F/a2r4DLiYmuj1nK9VDMzn/ACYSP9L54CSi8ASPBszDJk2jG
	3gWMglaE5MYV9uPDNTi/RhmRRHSUElhqS5t/KyKCV7xK9AraMe5M1yvrFnUKoA8znkvEqM+CiDu
	SK6QrOFrWtOqKX5lMCCF56bOb9c+EXt3gx1saU3IcLw1rftkp8Z8XxovBvVnvqAbt+0FfwFGd6y
	pIJHo4G4NKElW+/ErjFKLCKQxjp9wmY4VNXrPBBjLGFKXL
X-Gm-Gg: AfdE7clzwM6bDqTqZ+xfrZgESJL9unT8/6cOoOF4p3YaAq37iGT/xLK8t2ldJO3Up81
	GEMVGd+jdQmG2WFXFXC8xuYBggCL+dJUPaD+HAS02T3bnbR3kwKKSEzxDrPX9/Bv19tXStVyrC/
	1e2HqA74/RFg71c34SZTYS9/QQJrGpmbFIlw08m1FF6PmWDZaeyulGDt0TrvuAjjSBHM6vpGiQB
	E8FsFKKs1P/Ovk5zy5/yPJdnE3tmAAJAXg1qJgciVFyhWVmLGRpmv+UYfmR/sr6wpP5ue2thLD1
	Vf3pERERGYM=
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id 6a1803df08f44-8f2d1343d13mr25863906d6.31.1782849561043;
        Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id
 6a1803df08f44-8f2d1343d13mr25863166d6.31.1782849560532; Tue, 30 Jun 2026
 12:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com> <20260630180219.GA4139943-robh@kernel.org>
In-Reply-To: <20260630180219.GA4139943-robh@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 21:59:09 +0200
X-Gm-Features: AVVi8CcrbqRCRkmYSZLH_ub9JNgkd2IUQmjyz1dD9_QoekOgl29FSB3CCebEUbk
Message-ID: <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: hUAXTi7azLaaSpU90VV7hlNiV1wOkPN-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfX7N+30OilH/5q
 6ySSx36YCQ58yGsOCN2czb1KyB+ecyI3EtNvTt9RTSwChqXU6zuDT24fWva4cXOKKODnVj4eqnM
 tSOIQYbPQEtZGQpChvXXT2Yb3eK0X4Y53JIi1MKYxTFd99ZQRLFLAeBiEr39kDs36Vnt03E1gdT
 keBFrcY22vzyE/axFvaVQ8ipvlTOL8Ed315Inxu0j+dRBblws+fM9Y5P4oUYdLi2SW6chdqEXB9
 EQCQScipGD86Cj5Cq+Vns79xj6ZnzvWA6my75fU+wKfYGXKdR7xdXycyfR0JXGTA2Kj0bAtigvf
 /9BZUcF8xSYM2gjAXgLU0jXgm9UTGFH7uOf6sWGJBUXty4HE9KcGznEslK42eqjatiklmE5nD43
 81rsd2u96JNEjI866agIzf4gYrRW/cOYgOmmr9tNjFZGbtIuCAY6F2I1tKfsdsp9MuItjFxs6/F
 oa8pTN2kpb0etE54YlQ==
X-Proofpoint-ORIG-GUID: hUAXTi7azLaaSpU90VV7hlNiV1wOkPN-
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a44201a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=2sLY7anfMaDELvqluMMA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfX0msfC+UkmUAX
 QU/bGkdGIq6D3KSTm+qItXdZstyVu2JIAB2zs1Tfe3rN3yHEz0hfYKgVjw+G+Eq1vADwVZvmCca
 DcsOjoh/+ukkyhHhbFg0IxLbadvHYW0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300193
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38402-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:ulfh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:stable@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.
 de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk,vger.kernel.org,lists.infradead.org,makrotopia.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,mail.gmail.com:mid,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20CD66E7B05

Hi Rob,

On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > Child nodes of a fixed-partitions node are not necessarily partition
> > entries, for example an nvmem-layout node has no reg property. The
> > current code passes a NULL reg pointer and uninitialized len to the
> > length check, which can result in a kernel panic or silent failure to
> > register any partitions.
>
> That does not sound right to me. A fixed-partitions node should only be
> defining partitions with address ranges. I would expect a partition node
> could be nvmem-layout, but not the whole address range. If you wanted
> the latter, then just do:
>
> partitions {
>   ...
> };
>
> nvmem-layout {
>   ...
> };

In our case, the nvmem-layout needs to be associated with a specific
eMMC hardware partition, nvmem cells can be a simple sub-range within
the global eMMC, each hardware partition (boot0, boot1, user...)
having its own address spaces.

That said, your point about not abusing fixed-partitions is valid. I
initially dropped the compatible =3D "fixed-partitions" from the
partitions-boot1 node when it only carries an nvmem-layout and no
actual partition entries, making it a plain named container node. But
it's a bit fragile if we want to support both nvmem-layout and
fixed-partitions.

Regarding your expectation of a partition node being a nvmem-layout,
do you mean that the nvmem-layout should live under a fixed-partitions
node? Something along these lines:

partitions-boot1 {
      compatible =3D "fixed-partitions";
      #address-cells =3D <1>;
      #size-cells =3D <1>;

      nvmem@4400 {
          reg =3D <0x4400 0x1000>;

          nvmem-layout {
              compatible =3D "fixed-layout";
              #address-cells =3D <1>;
              #size-cells =3D <1>;

              wifi_mac_addr: mac-addr@0 {
                  compatible =3D "mac-base";
                  reg =3D <0x0 0x6>;
                  #nvmem-cell-cells =3D <1>;
              };
      [...]

That makes some sense, this would require extra work for the
emmc/block layer to also associate fwnodes with logical partitions,
not just the whole disk/hw (hw part), Is that the direction you'd like
us to go?

Also, Note that regardless of which approach we settle on, this
specific fix/patch remains necessary to validate the partition node
and prevent NULL-deref.

Regards,
Loic

