Return-Path: <linux-wireless+bounces-37480-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QUNxGnpoJmotWAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37480-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:00:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 049BF6534D1
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:00:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=MqAPwC2n;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dsdHE9zy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37480-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37480-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04FB83008C05
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 06:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89729393DE8;
	Mon,  8 Jun 2026 06:59:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE952E7F3A
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 06:59:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901976; cv=none; b=l4Cbqf38OEWYzq0lhy0Qtp5IkK9ib1ef1NmxqD0O0TDrsKWa0MaShChwA9IdxyH7dnkLPwqmyMhKbs3Wyy/pkhXtUt29fXUm7z53+3AKWyHO0ySHwinieIG+R7fMFZOliiGpvbBBxwuVuxnrxT+s3DpMHnvZRAAZ8ZfdKsaMhys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901976; c=relaxed/simple;
	bh=E5nG1I+R9Y1uL6wRIFYf8yLD8UQdyGGQWO5A9cA0m00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYLfrzfrcKT7NwqQs8KQqrdr2nDz94I99wRLIvnJkx8cHnSW+bp8cj3uPFniIbAtjR5vefy5OXYScU/51Ylhhn0Y9E1ZzbLZhOsew2PVkst/5wqTJ7UYK7d4vNJoXuBuUwHXDI5icLFody/oyro6343DovbkaQEqXpPRoiLZSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MqAPwC2n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dsdHE9zy; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586RWSX2833471
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 06:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pgUdrGoPw1Xu5Xr22jy0zL7ZwrcPwooNwDkwBB5G3IA=; b=MqAPwC2n2YBcrbGm
	B+wd/oLBLJa/2HJwNMtlj7vA7IdNp4IYBb2zBciTbmB/SypTYS6NK7pOe2OL+4C0
	6uLOrt1ypo0meMttsKaHEr3xzT+JqgD90WTTJBkHZ2Fk+GDRcR6Zxy/jLBbWgvlp
	h3amdyAUUppkopfpu9wY7mNmcoi98+nNJgM5Wmr1dNF3yWBAp8hbUrPsZyjzoc7B
	0b/0psSBMxKNeKIs3XbKiFZqcfF5IHULn5Q2BiepcInIgvji8nZiFr2/74H4PwV8
	c4QIr+6mT43zOHTSZbgmOerL7L0BoUfmn/fb9Nzly0m/yiPi5dwGexHIGHMsXoy/
	CjXZOQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4xp5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:59:33 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c67361f5easo6537736137.1
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 23:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901973; x=1781506773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgUdrGoPw1Xu5Xr22jy0zL7ZwrcPwooNwDkwBB5G3IA=;
        b=dsdHE9zy5jwfhSXtKd5wmvkD6SH+pnF+oHrRpjHN3LDS83+SM95XkWcyniYpJAqjM5
         7RU5aUNZBhbm7n0DZMjitRMf5EraTxT5q91BNvVknhkIT6whBpepa0rWSdF7GzrHrpE9
         xXqFwdxc9OVT3SfoTifjnb/JQTznxufnV+tv+BvPSU1WiSMrIRSIHg4RXTJwTqikD9ke
         nAk5w4i1RtTdUrGTPAk8Vr9iQnTGW9ha6qsmxcNsCbsj58l2a8XFZZuJ7EjQfA5w9vB2
         WTYCOEtaSFv5bBaWrDIHglIn3UykqlkYZLnUOWS8NtUL2I39V0giaDLpsP2e2EHjBFnH
         5TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901973; x=1781506773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pgUdrGoPw1Xu5Xr22jy0zL7ZwrcPwooNwDkwBB5G3IA=;
        b=WXQLdcjjBx1zLQ5FN5S/c6gQwW3l547KNZ4tFt93Da63d0aQ5/y6gMzZF/TkMlOKsQ
         piijxrELuI90012XeqLYlCzrDqSqzmctpLoDyZ6VfMuC1l3Uy7cLtHmuIJ2i9krvqoYK
         gX6epDLky51lzBndkAQclA3EWC/BzEeXxV2ldDbqbA6bH2B5z307KOeDHwEI4A3V7vCw
         Nnb/dufUzPUxuR+TjTMqoIG1VEHc9Z4UVmFC7894Zt3GRX42xgym00BNP64u+2nQDR9y
         YWLZT5PlxznqMXbk+kdFJWjUOPQ6SWQ5hHyAAHYiQx+6wxZ0kXJ/htwIP5fwRcprIo8y
         8GGg==
X-Forwarded-Encrypted: i=1; AFNElJ+/WST542KJVEBOx5Q/aGVS0w7HWUEoEh65ZG310KCnarTKEkAZEyaD5AsD8U9JvXx5Nk0kwHC9IDLLKoq36g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmar9oT61NTrBGjpz1NBJTlYBP815SHrhllTq3y/N3cdpffjF2
	rB0B7WdTtNG3GKp+AG8rhGPuAVO74DXmaIJXEOBJrx262Te2Y3RyyGpdpStX/X1OJYDnFCVngSl
	8XjrcwviuYLSwnrzvOUMiO0dqBnwMFvFVqfISDYQR7S5zojR6RqeykhdUrbK117wRVgTAqQ==
X-Gm-Gg: Acq92OFGaNJY9BQDBzfom6W5CX76A8eiTtr5lMcHY8GxyLHOe+yXwW5B4e+oOcJy5u8
	wb2oY4bOq1lCT0wz8Kqqh4GcWc4+HfC/GuSgtTEjd6OJKhnCcUNDKgwWxCqfQcxpi5JojcQQpOF
	W3Qxd1VaWy1xAwGh67S62FiP009V8Oc7rZsUf07g2dWkrcN4JCNhv9tTE6Qt45EW+bgv+gsFrzb
	/ZdgZwr6xlvedfJnB18lgS/oiYZ2UcdK07YYns2sGyQgUglc88CkJ9svHbOmt9rUvWNc5Px9xem
	ZfeWoph604Aia7eMgp6QHcPkxBQmb/wdNHtrglwYH0jlBBV/FARxRcdLNUFQeUcZ1mDCoV27Nvi
	JWjFTD4lFKlK9jZCW50TQ5FQrN4c46rLoOyNEogt/zWGRft9z2Zt1tMbfbzulVBtFgP89E73Gfs
	/IMY9NrzCF86Oq74k1hbb2N3feJYH0xULjjECaAlPr2SOoQw==
X-Received: by 2002:a05:6102:ca:b0:6d7:a2b4:bedd with SMTP id ada2fe7eead31-7002b70dd8cmr3085524137.5.1780901973218;
        Sun, 07 Jun 2026 23:59:33 -0700 (PDT)
X-Received: by 2002:a05:6102:ca:b0:6d7:a2b4:bedd with SMTP id ada2fe7eead31-7002b70dd8cmr3085506137.5.1780901972854;
        Sun, 07 Jun 2026 23:59:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:21 +0300
Subject: [PATCH v2 3/7] regulator: dt-bindings: qcom,qca6390-pmu: document
 WCN6851
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-3-efb68f1ff04c@oss.qualcomm.com>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
In-Reply-To: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=E5nG1I+R9Y1uL6wRIFYf8yLD8UQdyGGQWO5A9cA0m00=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhKC14cVjpzCIkVBne864oziewquNLDoUL52
 fYhWlSQOJaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoSgAKCRCLPIo+Aiko
 1R0BB/9Y2mbz86gfOC9j2ZzYs8DhUI7Azoa8HkqS9yVCuC2ehrxEDHOwDXGIv3y2pjQit3dbAT1
 zTmRFLTkCh+GjwD2lPp4ARpJjOBCWapE7XfV7mab3lIcJzngU98Vn1P+rMRNTMheLk7BdHT1HdY
 +gCN1eOka+f3US0A1wlcHC0lU1pcIblMkkPyrYGmTVvKSlmTJPsyCjY7hN6B7vwOp6faOBcVP1q
 NHZNhc8e582lJFFdpAjrr0lIG0GRq6doXbo7yYW/37sSf4+KpdxHzkIYvtzAagFLeIG1XZ1sNS5
 Stk7EEhBUxMpVaERvPk3CP26ctrSxLZ6pbsUa3VRMt3StEUW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: l9CRsJrEjgzq8wYuyDaAgJFAj9ivF4pV
X-Proofpoint-GUID: l9CRsJrEjgzq8wYuyDaAgJFAj9ivF4pV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX3FIcMyDzzjOc
 gRcfqajMIo6Fa78OAIs7QVfp3lAiN9ZNI3V+AppAzZVwEwDQ5TboGRjixD9NoJq8QTGrCwB1kAS
 asEX1CokKAOxY7rL8fkd43PgxVvtS8e8tj5X4AmoVvaYuD+JHaqRtK51idzhKFftOfFdbL5xcrD
 R5SUTBzHRrnnpp3S42nvHmpETn7+27o71YDo+n/f1FDNzGNi3G45M28s1wII37QATZ/PKWUS3GF
 8jMee9LKibbi9eIGujNd8VZ+0RM1S9urlMv48pDNNlJeFWmvE3ZFedAwh8U3a1HLfIXFngsi8S6
 Se7aVj/uBj8ld7kB3jX+UjG2y1oAie+dZCHekqjukI2oWAmp9lKYUTTXj+q8NPsJ/MP3ZP8qyg2
 NHui9PrJL400laQf1fy7drgxtuwNKPZBm6QLdWs7Akf2F/wMgdZg6YU5klcTIJCiHLb4wUY0yxB
 kt4PDhErGa+EnxmoZ2g==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a266855 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=_jZoHPq4qSgluh34qd0A:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37480-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:konrad.dybcio@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
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
X-Rspamd-Queue-Id: 049BF6534D1

WCN6851 is an earlier version of WCN6855 WiFi/BT chip, compatible with
it. Add a device-specific compat string with the fallback to WCN6855
one.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 105174df7df2..3d3c6fa7ecbc 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -21,6 +21,10 @@ properties:
           - enum:
               - qcom,wcn6755-pmu
           - const: qcom,wcn6750-pmu
+      - items:
+          - enum:
+              - qcom,wcn6851-pmu
+          - const: qcom,wcn6855-pmu
 
       - enum:
           - qcom,qca6390-pmu

-- 
2.47.3


