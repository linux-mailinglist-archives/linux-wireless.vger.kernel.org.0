Return-Path: <linux-wireless+bounces-37809-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y7xwEtbFL2rmGAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37809-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 11:28:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CED6850D3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 11:28:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XOELhX8N;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bsOawze6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37809-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37809-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA4993008C3F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F068C3DA5CE;
	Mon, 15 Jun 2026 09:28:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A83DA7D7
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 09:28:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515723; cv=pass; b=JJ/vpKDggq2bUG10Grg/jYlT2cO9/gtDI9jfSaX0Rit83nNKj9rrI5ZicK69A+ZAEYfFlfEiHGVBgNev7ebWMXNEOnapJyQBKnn4SI/Uu2gjtMaMZsCRy67yvly+K/9avOWRhyA6jXi/ruYxUGljdSbzATuSGJclwzSqjpXNvj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515723; c=relaxed/simple;
	bh=BR4ukWXw930jyHa5ruidGUlGFCpRYZad0Pwt5fuelE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbPUxv724dXj+iJWXvOtYxP7RHLbTJ3/8IVpUx4C3JMWjN22o2YZI7Tclv/7GDAxVmCWZxf5h9Cebh+PMGjwV6/CNnI/ht6GoyW571gMD7898rd6/ru8GOdmkEcOH898hRBzm8Eiz7tVLcy0uvdSLBadhCCRx4Fc4eXHmlGFh3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XOELhX8N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bsOawze6; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F99B6o035460
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 09:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cJ91cGOE3AFgPVR4MUNMTN4B9fXw/iUPFEgbOHjaEU0=; b=XOELhX8N1Bf4wA6b
	/Z3rYd8zA/Ixlfqk0s+4bCGEbYt8m3l1ziZJJgwE4+po+R2W0exjvmC66UB/8yAK
	i+0ZF9LYWYGvgwie398qzj85q6qFgFqfqx29wRnhdrwyFdYNagD6y5Duo6XAHt8V
	m4tWLkBGfvBsCBUfvaRQKuh2GcLoZRG0dS0gAVHwGQbe2gMDwghQAdaCmz0gge25
	IMdyAqpQjIZ46KDqY3aCW+UjmrCYv5DCpbuF7ipNF8CgiOteLxg2HOnLPgemrDOO
	G1LbCw8BpRRYv7JI/RDPYhxLhjUFcPujE2uKk0Wiu6jPRn31BmyyGqoViecHpk4G
	yiG74g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etegur2tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 09:28:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5178aed25baso61216881cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 02:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781515720; cv=none;
        d=google.com; s=arc-20240605;
        b=BF5DHV+fale2e2+GLTE30u09qaKPxCLzc+iPzv8ZuWkPEC8Ifys8lI+8rHxQVHKdhf
         WFLOReqaFKHb7XoAmKi6LrGW5Wq/+Zyagmqm82WNkzuWZGLnUOYvctV64zZ0AzWaoi4d
         X1Tj6Cu5ZmXOfgt62fv+7MF7KjnWhoPliJncX4XvL1o+2SiGIntTi4CELmMH/gzyxV/5
         B/eXe+56nEsHcPeKLa4EJXARW8kG20O+BQskGtusg3G3Cep8O2bIA8SZAnypBUUAvXvN
         fTMkBpiKwd4sP9LWEnWzflX1Rz2HxFVRIEMs7SdoWM8Q+OOWmHcDPdNMst+k9fZRmEe8
         gtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cJ91cGOE3AFgPVR4MUNMTN4B9fXw/iUPFEgbOHjaEU0=;
        fh=eCtaVQ7b45+atM5Ih670fzYBGvvbGSw9Q8aXIjq8tkI=;
        b=F0WCiyc4cGQDe8ohM9W0lIwTErQGdEZ30ugYOwDGrGpCWjlUVp3483qqX6p49SZ5dv
         wLGanUSXbw/nAagnJt/AlpH5zL8AOgqPuKiN68sKquAwFUatuI6ooT/8FwW/TF/5+RJv
         QdyCgYzm271G4dYmriIBzGjQpy6cFJwn3Hghr9kn7GCwsOQuHXyRhm8tnkAI9w1Y86Zd
         6TOlYkcLaTDRo0TcKvQI9aGeEepJVHNplh690Bya29dDtPB5i7taR9Y16SePEN3mBLe8
         UjTPKd9ciQLn7CASaskPE++N0/223GhshJhDzC/TH5vBqeHlqt/nDfOEMOYBPFc5Qfic
         vfRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781515720; x=1782120520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ91cGOE3AFgPVR4MUNMTN4B9fXw/iUPFEgbOHjaEU0=;
        b=bsOawze6cQrbID2XPmgCK0OKODivpIP4cAHccagYFbgR1EUM5UE9AiEo5mfq0DbbG7
         3OHngjl3Ai57K4j6iGPa9AEYK+pxD8mUW4oiQXy7/TxGUEO4mkl/eJi/7S56Jt/TmUFk
         rDRwhUl+ImKOZomyAgYadNLodxxqbKu0U45oWaRJyoOq8CzvFd84S4hIjuXdJrn5p8ad
         lQYYOsKtQYem2Pj0SO5PP+CUFnRnxdBMreGSJ6+gKNT99JqkHLtfU0H+HE5as7ejZYdU
         xAR7grWCBr8L4S161qLdmPQ9ohCyj5YPSpOj/J9MSsmwey1EJevjhjR52P7vMOqoviQ7
         aPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781515720; x=1782120520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJ91cGOE3AFgPVR4MUNMTN4B9fXw/iUPFEgbOHjaEU0=;
        b=YMrmRGYptuLVVe9XY5+LuJcguUmkfmS5qUIV8tJn87X64xkmR2UKDfCbpZopqaigAj
         d2Mo/7dGlPakSIcYfL95di/dyfUBlZdTRmDyEW9HbZ3pb3ewFKLsfxd04kGXnccD1Xkv
         XAZTolZ8gQAl9nocOEBKkakaGFTf+5aKjzvp7/bSvNRzhvqsQDpzQbrDaf37qMNh8uTA
         SaeRVyHSG0KmE7Il3PA/oewnzLKELq1POprNq+/135QoVMgfJcILo7soYcgNmlqZeDqX
         S22Hm6wgKrVOa8Izfabaf+NJoiRonEtCyt4CCxkO4ZJ+jS5xcOtu/5YA5xQsl4jwdqb0
         t1zw==
X-Forwarded-Encrypted: i=1; AFNElJ9DqjGSVqO9z6rWrxoDv8CvOA2VYSGyrWhCOH5F2JAAWn0OCwUgk/7F+5GgWgczfcfgdaYHBbL7k7GwxdER4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjYZ08w3RMXnJP1QUvd6Z1wI+8bR2zXwkBE2wCCdNb8PIvIQv
	Rn9L7qNG9INN5rdctvb0OJa3DMKlSqlBJqPUbFNbO39aFmcAJ1AhnyzkhVb8s+vw57+PzF94Kcj
	ciMW1cUCQ/r6HVTcx56KWxBr7ITk6dM1f+zeIzGucaNU2u7xbz0CjxjzJBUaw6kUvgtIbFdy2xt
	SiZaXC8Kg765RwqDkJLStKcV1gGEKicru5TzV/GVQle/N4
X-Gm-Gg: Acq92OHY8XGpYlKky9t4kRqvqbhH3iTxsESFr7m7iti/8st4QfYFzek6fb2tWDq4e/K
	PSSobM+KcFwivYZChpH/Wr1qKLCcYCNzV1g+h4IATw1Nm+OMYORlKQePGoaMokaOg8+pTiJm8X/
	rVRuScztLMF71KEKZGK1GL0zC23tL0175YnLut4wTIJotpNEoBze7cHvEpEh2+l2VLTHdpzXSRF
	PykGOoGb/8FKEBV68fbhKBA3r6aVbeBzvPZ6kNK74sJo03VOEQJL0R6/uHd9MUSOLf9cwn5MlqW
	E3sqPKEv5gP9e3zU5I6b
X-Received: by 2002:a05:620a:1999:b0:915:820f:c78e with SMTP id af79cd13be357-9161bfa0d31mr1962336485a.52.1781515720046;
        Mon, 15 Jun 2026 02:28:40 -0700 (PDT)
X-Received: by 2002:a05:620a:1999:b0:915:820f:c78e with SMTP id
 af79cd13be357-9161bfa0d31mr1962333085a.52.1781515719471; Mon, 15 Jun 2026
 02:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
 <20260612-block-as-nvmem-v5-5-95e0b30fff90@oss.qualcomm.com> <CAMRc=McQkLnz2OS2RREAbcrsp47cL-W3bCduq8LwPBBUcVNyJw@mail.gmail.com>
In-Reply-To: <CAMRc=McQkLnz2OS2RREAbcrsp47cL-W3bCduq8LwPBBUcVNyJw@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 11:28:27 +0200
X-Gm-Features: AVVi8CcVJ9tT2-ROJWBj3M8PVcaYsYfsOzvYsFfBdtVBF-QvEOp396eVPW8z9IE
Message-ID: <CAFEp6-0qsqhcwnSjm3=bG21jsCktzn5-L5sk2pNTZcGuVXaiNA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] block: implement NVMEM provider
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5OSBTYWx0ZWRfX175AvqHO1khJ
 8Pq+q68PJCqs27qyNdFdFxS/61knTDPEH32BCTiE9UzT8g6RUSZLP2f2yiH1g6CWE5goqwkiwUN
 F0xai1BOBCrt20LUTemmZ6g8fY+hbwj2WkGbQNH0FH+eIRFhMOB4DEF0Cf8caBwk1S+HXP6QMMb
 FN1iHxJK652+/uiA6wm+4cOTc/7/HcjdTyjN42jKcV7kyanFfcvdif4feCSrinaQex1FMu+oyOl
 v7XkogsyB97DROK1RsWTg2TylOhUI3O24SmiEoHqlf8wPjnftynm6ZgIcQpL5OMhmFF0+pf226x
 LaPwVxRQhrgrt/zLA96i+khKnaAgdCNjLg5hzhRzAUQqnVU6OivB+lbUiqZ90Mq16OH1oKA5qjq
 EivH7J89Uh8zvHua+Xw7m3DCUC7tIZuVSZZtm6x22My+wLEDia2Cl5hWKzo3eBsT4adAaw1ThrD
 LiSboCyDkqH7BJQFSxg==
X-Proofpoint-ORIG-GUID: 1l5IHmrLA9IOO0PmIVZA_ur8iBFaB3In
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a2fc5c8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VT4XjZGOAAAA:8
 a=6Rv5uNetd_8wmlz2G50A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5OSBTYWx0ZWRfX1SIjcd6R5zZk
 JEqL2H/LiUaTPjMu3EvZiuOtyA6KfbbRKRkn1OmjuNqvjFM3hqNjT6uNNYux1XRaDQRNAchQfjy
 PuL7UB72FRWuqzy1BBh/b9mmX19nWQE=
X-Proofpoint-GUID: 1l5IHmrLA9IOO0PmIVZA_ur8iBFaB3In
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37809-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brgl@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,makrotopia.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3CED6850D3

On Mon, Jun 15, 2026 at 10:53=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Fri, 12 Jun 2026 15:20:57 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > From: Daniel Golle <daniel@makrotopia.org>
> >
> > On embedded devices using an eMMC it is common that one or more partiti=
ons
> > on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPRO=
M
> > data. Allow referencing the partition in device tree for the kernel and
> > Wi-Fi drivers accessing it via the NVMEM layer.
> >
> > For now, NVMEM is only registered for the whole disk block device, as t=
he
> > OF node is currently only associated to it.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  block/Kconfig             |   9 ++++
> >  block/Makefile            |   1 +
> >  block/blk-nvmem.c         | 109 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  block/blk.h               |   8 ++++
> >  block/genhd.c             |   4 ++
> >  include/linux/blk_types.h |   3 ++
> >  include/linux/blkdev.h    |   1 +
> >  7 files changed, 135 insertions(+)
> >
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706=
f75c92bdf8b648f7c 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
> >         by falling back to the kernel crypto API when inline
> >         encryption hardware is not present.
> >
> > +config BLK_NVMEM
> > +     bool "Block device NVMEM provider"
> > +     depends on OF
> > +     depends on NVMEM
> > +     help
> > +       Allow block devices (or partitions) to act as NVMEM providers,
> > +       typically used with eMMC to store MAC addresses or Wi-Fi
> > +       calibration data on embedded devices.
> > +
> >  source "block/partitions/Kconfig"
> >
> >  config BLK_PM
> > diff --git a/block/Makefile b/block/Makefile
> > index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800=
ea266190a43b3e63d 100644
> > --- a/block/Makefile
> > +++ b/block/Makefile
> > @@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION) +=3D blk-crypto.o=
 blk-crypto-profile.o \
> >                                          blk-crypto-sysfs.o
> >  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) +=3D blk-crypto-fallback.=
o
> >  obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)        +=3D holder.o
> > +obj-$(CONFIG_BLK_NVMEM)                +=3D blk-nvmem.o
> > diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..c005f059d9fe56242ebaef9=
905673dff902b5686
> > --- /dev/null
> > +++ b/block/blk-nvmem.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * block device NVMEM provider
> > + *
> > + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + * Useful on devices using a partition on an eMMC for MAC addresses or
> > + * Wi-Fi calibration EEPROM data.
> > + */
> > +
> > +#include <linux/file.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/property.h>
> > +
> > +#include "blk.h"
> > +
> > +static int blk_nvmem_reg_read(void *priv, unsigned int from, void *val=
, size_t bytes)
> > +{
> > +     blk_mode_t mode =3D BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
> > +     dev_t devt =3D (dev_t)(uintptr_t)priv;
> > +     size_t bytes_left =3D bytes;
> > +     loff_t pos =3D from;
> > +     int ret =3D 0;
> > +
> > +     struct file *bdev_file __free(fput) =3D bdev_file_open_by_dev(dev=
t, mode, priv, NULL);
> > +     if (IS_ERR(bdev_file))
> > +             return PTR_ERR(bdev_file);
> > +
> > +     while (bytes_left) {
> > +             pgoff_t f_index =3D pos >> PAGE_SHIFT;
> > +             struct folio *folio;
> > +             size_t folio_off;
> > +             size_t to_read;
> > +
> > +             folio =3D read_mapping_folio(bdev_file->f_mapping, f_inde=
x, NULL);
> > +             if (IS_ERR(folio)) {
> > +                     ret =3D PTR_ERR(folio);
> > +                     break;
> > +             }
> > +
> > +             folio_off =3D offset_in_folio(folio, pos);
> > +             to_read =3D min(bytes_left, folio_size(folio) - folio_off=
);
> > +             memcpy_from_folio(val, folio, folio_off, to_read);
> > +             pos +=3D to_read;
> > +             bytes_left -=3D to_read;
> > +             val +=3D to_read;
> > +             folio_put(folio);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +void blk_nvmem_add(struct block_device *bdev)
> > +{
> > +     struct device *dev =3D &bdev->bd_device;
> > +     struct nvmem_config config =3D {};
> > +
> > +     /* skip devices which do not have a device tree node */
> > +     if (!dev_of_node(dev))
> > +             return;
> > +
> > +     /* skip devices without an nvmem layout defined */
> > +     struct device_node *child __free(device_node) =3D
> > +             of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
> > +     if (!child)
> > +             return;
> > +
> > +     /*
> > +      * skip block device too large to be represented as NVMEM devices=
,
> > +      * the NVMEM reg_read callback uses an unsigned int offset
> > +      */
> > +     if (bdev_nr_bytes(bdev) > UINT_MAX) {
> > +             dev_warn(dev, "block device too large to be an NVMEM prov=
ider\n");
> > +             return;
> > +     }
> > +
> > +     config.id =3D NVMEM_DEVID_NONE;
> > +     config.dev =3D dev;
> > +     config.name =3D dev_name(dev);
> > +     config.owner =3D THIS_MODULE;
> > +     config.priv =3D (void *)(uintptr_t)dev->devt;
> > +     config.reg_read =3D blk_nvmem_reg_read;
> > +     config.size =3D bdev_nr_bytes(bdev);
> > +     config.word_size =3D 1;
> > +     config.stride =3D 1;
> > +     config.read_only =3D true;
> > +     config.root_only =3D true;
> > +     config.ignore_wp =3D true;
> > +     config.of_node =3D to_of_node(dev->fwnode);
> > +
> > +     bdev->bd_nvmem =3D nvmem_register(&config);
> > +     if (IS_ERR(bdev->bd_nvmem)) {
> > +             dev_err_probe(dev, PTR_ERR(bdev->bd_nvmem),
> > +                           "Failed to register NVMEM device\n");
>
> Using dev_err_probe() only makes sense with a return value. Which makes m=
e
> think: we won't retry this after a probe deferral. I think we should retu=
rn

Yes, so here with the nvmem fixed-layout, there is no way to get a
deferred probe error, but better to be ready to handle this anyway.

> int from this function just for this use-case. Also: if we *do* have
> a layout, shouldn't we treat a failure to register the nvmem provider as
> a an error and propagate it up the stack?

From an API perspective we should indeed return the error. From block
core, Do we want to fail the entire disk addition just because the
'companion' NVMEM provider couldn't be registered, or should we only
abort/return in case of EPROBE_DEFER?

>
> > +             bdev->bd_nvmem =3D NULL;
> > +     }
> > +}
> > +
> > +void blk_nvmem_del(struct block_device *bdev)
> > +{
> > +     if (bdev->bd_nvmem)
>
> Nvmem core already performs a NULL check.

Ok, thanks!


>
> > +             nvmem_unregister(bdev->bd_nvmem);
> > +
> > +     bdev->bd_nvmem =3D NULL;
> > +}
> > diff --git a/block/blk.h b/block/blk.h
> > index ec4674cdf2ead4fd259ff5fc42401f591e684ee9..cd3c7ca723391c40be56f1d=
d4810e641b7c8a2b3 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -757,4 +757,12 @@ static inline void blk_debugfs_unlock(struct reque=
st_queue *q,
> >       memalloc_noio_restore(memflags);
> >  }
> >
> > +#ifdef CONFIG_BLK_NVMEM
> > +void blk_nvmem_add(struct block_device *bdev);
> > +void blk_nvmem_del(struct block_device *bdev);
> > +#else
> > +static inline void blk_nvmem_add(struct block_device *bdev) {}
> > +static inline void blk_nvmem_del(struct block_device *bdev) {}
> > +#endif
> > +
> >  #endif /* BLK_INTERNAL_H */
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 7d6854fd28e95ae9134309679a7c6a937f5b7db8..1b2382de6fb30c1e5f60f45=
c04dc03ed3bf5d5f2 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -421,6 +421,8 @@ static void add_disk_final(struct gendisk *disk)
> >                */
> >               dev_set_uevent_suppress(ddev, 0);
> >               disk_uevent(disk, KOBJ_ADD);
> > +
> > +             blk_nvmem_add(disk->part0);
> >       }
> >
> >       blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
> > @@ -704,6 +706,8 @@ static void __del_gendisk(struct gendisk *disk)
> >
> >       disk_del_events(disk);
> >
> > +     blk_nvmem_del(disk->part0);
> > +
> >       /*
> >        * Prevent new openers by unlinked the bdev inode.
> >        */
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 8808ee76e73c09e0ceaac41ba59e86fb0c4efc64..ace6f59b860d0813665b2f6=
2a1c03a1f4be94059 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -73,6 +73,9 @@ struct block_device {
> >       int                     bd_writers;
> >  #ifdef CONFIG_SECURITY
> >       void                    *bd_security;
> > +#endif
> > +#ifdef CONFIG_BLK_NVMEM
> > +     struct nvmem_device     *bd_nvmem;
> >  #endif
> >       /*
> >        * keep this out-of-line as it's both big and not needed in the f=
ast
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 890128cdea1ce66863c5baa36f3b336ec4550807..f15d2b5bf9e4fd2368b8a70=
416a978e22c0d4333 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -30,6 +30,7 @@
> >
> >  struct module;
> >  struct request_queue;
> > +struct nvmem_device;
> >  struct elevator_queue;
> >  struct blk_trace;
> >  struct request;
> >
> > --
> > 2.34.1
> >
> >
>
> I like this approach better than the previous one.
>
> Thanks,
> Bartosz

