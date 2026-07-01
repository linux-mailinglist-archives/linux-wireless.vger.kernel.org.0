Return-Path: <linux-wireless+bounces-38466-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gP+ZKyw8RWog9AoAu9opvQ
	(envelope-from <linux-wireless+bounces-38466-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:11:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A656EF8EC
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:11:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="nI3M/mnS";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=kL8aV5wZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38466-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38466-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A625E310BD97
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15124B8DEB;
	Wed,  1 Jul 2026 16:00:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFF4A139C
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 16:00:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921653; cv=none; b=ZQH+jz0zUz1dPkdGlNQIBruwKCLyNMwlCjfweY/EDYP02+eu/563Q/1o5Mfog3SjGKwVPGbH8J20U4fjBkYvUOObcnpN0y4oMvmSZwViVo9fuJ07XiDpdc3d/s8DSkzy5wuneMnIBS91FN8cN+KX6Lp1JA5Q63aA8BQ8Ih0XGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921653; c=relaxed/simple;
	bh=zkO7UGTBhc0abSbmAA7xbPJx3KQa3FMC3+fWJRmAgxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKi3pNRc3FDFRbXP1Be0CJGb3mTXuCfn0ThJyvM7eCz6fEDMVop7+m1qNWFQPNNbuz+eRAdaXgOJ0sQgTKKJiTiydsC9okhXYoLJFFMiR6ashpUbXMlqui3rA2S1u8WBCGnOYKcrQ0O0xh0ZULUFJhqvCP4PwqqlhbBTVe377/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nI3M/mnS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kL8aV5wZ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoDIG1570319
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 16:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=; b=nI3M/mnSsplZXCvM
	E/yYWLSoIqVEdpGFBU5EwH/Gviv1hba+cB9tv/LWQc6yso+5yoIZl1/xERs98BVh
	sUlqRQWuUucfPwKyfl23pfghMzXqv9lYjjWJiAJlyLjAek/1pPn7EwsvDnP2KnMn
	aMGOlhKXkir+AMRgLkTzqcIl4N7QIjfUmZRiHs4qNQJZBFxExtThHLQ0YwH8Xc/8
	HseoertmTvfR5JrtSYZysP7IrkkfEcR6FYBk9RoiEfuCccjqN9ugmqnuryXBXknT
	oHIwJnvbojDg7qcYZGPfmki5GpS8DwHb7PMycCUrRljDrLi7zNo0MsCqNOVSHcH2
	K+DsXQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510ahedh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 16:00:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e38fbc5so101088985a.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921644; x=1783526444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=kL8aV5wZQ75DbDd/KhPDeeDcNsFqRkCQKKF/7S8gT6sozYcodal/6N4+QrkwLBS/Cz
         Rl+9UBBguntxERTTfz1adO3iYQUsnafEzgevBqNEkJqhXciEjKleaaaBwu2fIq/qSRPn
         FLA2HukOvCBRJ7jhGZWEg5rH30NRHGI8MoDCtMeZ1Ru4J29I2P4DXqMZf9YrIUOi1ffP
         iy6q2Gg+Dhf1DwbLPuqoSUukEo4aS7jJRqvY2J66r3iyndIQfizE4+ZCMi77rqEib8UJ
         vUqf9YyiU9tCcyNlJZEUe6u95bCjuI2sPob8VH5NGIDkRJygT4XHStBkgiOYyiZeZ9co
         fLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921644; x=1783526444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=sDvMe0ZrtlaqRixeGc8F/KFoyXezJmd8YiFFlZQCrbeDt5LT8CHf1Q7C9jKz1NR96H
         LtmrYevQC9nCFQH/78XdH+pCj8ZIR5qUa/qR1LYvMckiAIZFmuwPATFV1Czf7lzR0dG8
         j0u/zSh9dbJFiS84ujwMEnNEB8yyzyyIJykVidhod2fPbSgpJy0r6kJiOJHSdezCGvxF
         OQXzzueybUsGWmCO+s0RTSHgRnPW4RGZrghpHQkQtoBc4HceO76uomYZUTACzkI1VXb+
         jSPyWSiSOxvJuEF5XsPwF+1+fqnbxbDbjc0e8gCzEkkBw/t9tYSgWBWg8pSWAZ08Meqf
         TD+w==
X-Forwarded-Encrypted: i=1; AFNElJ/64RAc3kdb4rPCUUD0y35qeZAzWCgHhmekROsgXv6JHqHyodZnptrXwjPKWOTFloOXcppqCrXOdnKuTQysPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRoOHcrXb+8Y/wF0EMx7C3pamvtb33lVS9vxh1jDjM5iHaVKN
	JB/0TGd/1Z2yt6AId/nxr83MZCCvTv4o7ZU94iGkL6btm+E78Eor+XSMJ0TbfO6blUrxZ8/uS3m
	OkYG421wGTlty+2XT9kElVclKYcBc9IXIE81oZqlO8g1oxseB71ONfXSnSHUKo4KcnCdz7Q==
X-Gm-Gg: AfdE7cmNwqanCGJ+awzc+1h7hcVLeei6EbuXruk5RgljS0LLwt9jloCaEyt8E8YYIuO
	+vxvFt7a5/ggy5LYX6Sz0AgBOfsstnbfw/1N4549YFYHK/NGwyV3h2GtcxDeh/BYjd0El/zYyJz
	GkLRN9yyQ+f+H/7CT0JTOn30XtGB40d3RnHL5RVIYXu72+zKumIsZyh4lF2iiw4v747N+oJJOf9
	PgP+3Ie9YHHHDWgi8tk2ljcQsh4md2t/QluvqoR88JBHltfJfcxNs9Vwht6+keO48ku0Yd3/hVu
	IIDFfMWhVTvh3zBzKKXjhEei1NGbdI4KF3q4mvvKVm+Ryo2par/kOyfh+27snfVbbQCLiTaAOQB
	Y9ZfJU8qsdjzQxoXkWDxp+w/YVdRLA2MMkprNjhV9ewBJB/uXEJwN2t50mGID0C6+6rV+jecIZM
	7dJPw9kiJcIrl53uhmtPgyj68xpi0lgPwHLFWwuZNPaf8dJfIk6b2iYpTES6PK+LU=
X-Received: by 2002:a05:620a:6086:b0:92b:3720:bc59 with SMTP id af79cd13be357-92e782578b7mr323528485a.28.1782921643154;
        Wed, 01 Jul 2026 09:00:43 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:92b:3720:bc59 with SMTP id af79cd13be357-92e782578b7mr323511985a.28.1782921642439;
        Wed, 01 Jul 2026 09:00:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:28 +0200
Subject: [PATCH v7 4/9] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-4-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: bFFuOVemcbxJQ8QNe0sFw0ezKEGNfu62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXw4NjuwiqVVad
 wMaFwIr4rFv+menRtvrUn5Rlx7GXsXFSYV3WsyHdkm0/hfSxjBV/Ws1ROD89XJQku4MbTpilY7Q
 Fdc+0t8Yq1gZxRpw59O4VttsennC432tiq1SL9X3KtMGALUU0Spcvnn7nmDoUnDH/+Uu0ImeBLV
 qDPv4Dr4MbHgHeR2YAAt1ZbgQwtOXJv04VLSwcfetrdx4i0/qiqHICJ1KZKaATveyJA9YKZDuge
 ErsKTs4idXKTLlsgHyGsRRTmBpd6GFmu8a/TQU/iQMrzuf8J462CrsVSFXlsRAGdB9aa0TdD2S/
 4JRiajTTgMp5XmADbc4uNoWyhbgrj59Yedgtgw2sWi37CbIXDEN4WauE8ponkdJouA+gXuBUdgB
 vXQNJRGcdfCVPGKsrVJ6ogPyNaAmEmM4HLZMnBeELn2RXUWfGz9w76MM8FBUpGnKUd4yFQX6PzE
 D3idjMMWeuqgOZjRUTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX1Cmo8+J6USBU
 ZWUvX0BcgFxkpo+8t8Tdmn+dA8okMjx4VBCKFhYiKh3PGFnVUFfR9wN7fN3ThDCE5ZnwkI6JDRR
 vS3nte/LAHOrTZtlEo81ZW+OyPWr6Yw=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a4539ac cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: bFFuOVemcbxJQ8QNe0sFw0ezKEGNfu62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38466-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 24A656EF8EC

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1


