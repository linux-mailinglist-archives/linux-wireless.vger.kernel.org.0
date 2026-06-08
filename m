Return-Path: <linux-wireless+bounces-37478-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dAsnEHZoJmoqWAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37478-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:00:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B433C6534C6
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:00:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jmWamVzi;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=EyCNY+aK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37478-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37478-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 137F0301724B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 06:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A538F92F;
	Mon,  8 Jun 2026 06:59:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CE38F646
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 06:59:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901972; cv=none; b=uD8cDa8lgIvKnJgZWVkSQ+Q4BQs9TsAADIHMpFRLNFvh3Ezl0ZSmpskQOLIHok4x72vI1Y/pkvmdUP+YCSGIO9bb7o1qZ0Px1qPSgskTw6NhOvYSHUGx6YBmuG33Mn1zfvi8Jjgm813DxKUb4UumyvmOZnduLRP78xXUZz27R1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901972; c=relaxed/simple;
	bh=h4yLRvqGyQTl6OR0GngMd/YRroUj4EhJo0XPHba7d0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=syePOxyYOMgBCFwy2sUvs3RC/QmWX3n+TUG9Dv2lzjp1rEKmUAFH9ur+ZoZH2u1jxFvg/YefB9D7ye//7i3KYg7zDIOhOc+U0NSjw9R/I9/ARr3KwvWRTKCDfW0sk54jagdW7B4XtO9GkSEHIUIcm/0k5kDJb8XnaM+9XwpqqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmWamVzi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EyCNY+aK; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586RWBc2833497
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 06:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M4dWomgyfsAxdHYGato4YCIl0rH04fg4NjCDPCL3Zf8=; b=jmWamVzifzUA7OyK
	S4oIA1/vlZxiYhDV90onPQ0h2LcNIWYzMSNaUTfnLYHHGfFWxeK6agFN69na9bWR
	kjELk4NUA10ReeOKwXNAvaf7pqBHZEM2QNJM/f9LzxRY9I5CF5GbIvLFXd42RKej
	6gd39AaKkn3I5tIOT2eKqJfnHj/xb2tToLX0nN80Z3lNYSbMPJCLix+6b1d0LHSY
	4/ubfgizZJ/3gNqlgauLFrCDsylkF5nhyNem3lY18RbNv2kAEFpMsUbRIuNuqUN/
	sGK0DZWtA4lez1hsReBdarZ7cCmT8MQd8vRo0x1nu21BbyS7sPYaglofBwc0dy3M
	9P8+Hw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4xp50-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:59:30 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5a2afc494efso5969579e0c.2
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 23:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901969; x=1781506769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4dWomgyfsAxdHYGato4YCIl0rH04fg4NjCDPCL3Zf8=;
        b=EyCNY+aKKbySRJonIvXlu8jtYjmXkJ9XThF/KenosMtHWNri5CIYtFW5uP2UAijh0Z
         Hay1sLGcSrT9h+WkK9UT/w0DucGuFsdjrUYevC8U5aAJbp2hg9p0uHQaRJ6Sfese9k24
         psWyZZ81iUpEhbY3e9u72JosMU9Rfwk2h0tFPQGZopLMCIvcHbqtIfxzcT/1RM7TXBqj
         7aDBbZdl79rf7a3rNOZ8r6QELPklVcyV4F63W5FmJjwXwR2scFGlW9LiWMI5aAl/L7h0
         hDWZRvV7gb9e99K1ZupacYaBm8mhE7KhaNI3hbxtu3IZlGprYfeW9QWnBuvKg6YslaLW
         puuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901969; x=1781506769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M4dWomgyfsAxdHYGato4YCIl0rH04fg4NjCDPCL3Zf8=;
        b=VmuNzxSdDAZBKST0HR7wRY5PbIr2ABtex7gCwGf5/oi2iXA8EejGIrwOc/ATsc+Dw4
         6iR/m/reUM4l5U/oAyRlmcxpbghyf/RO8A130DEGwkCCbe9xFrrW48YQM+nH8yaU8I2c
         4fLp1GcSbp0sdzCrleN0PO9tklDue3PGUAO88E0Rvfl3cO128cgy5qlKXCaVwfoEOJnd
         686v18P4ZNet5EvERhA/I6FrjsTsWu8kJeML3L7flbAZ230yHCfPtn82707ovSLnwRbo
         Rxqz8eiVbvQknkds0IdJK18D4xnSrORz98ikrYy1B30oanLk7nXW65RudcFgOdkm03MB
         rZUA==
X-Forwarded-Encrypted: i=1; AFNElJ/7/NHihzrsrJevjOinRL5uZF5Cc6sYZJxeRM8iZX+L+PXD9G4LGYnmDytDxHptjo6IqRMZ3H6IlWu0sT3cSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnO7msMj+SGKRQfekexH4RtUGRMb4/gfv+52rsHmMegnpLwBq
	v1En2WLDezoXp6uj23VEAo8NWUatiUnSF4CUdID0zyFXFscN3e3RxmKNEsveY3PiKTfQY0uN3RQ
	j/lkJ7+X55ietbwHV/+Xd2TM3Yd5RoUS3mp+KASCQXBwBsPPIcOt9sz3OBiE3lY2y4bKDcQ==
X-Gm-Gg: Acq92OFtOnoTTwnsJXMuzOgTfkBWYsvodP8kkLeaHSqv3JVv+GCDYx9gdpaE6/83r/2
	8gPtO1Xzmm26NezSxl2nRZJhnctF1WStGnfsErIlWDgsDiuEtcc8hFqi/A3fLMgHgBghU0i9gQN
	fJt8w/MBOlGhkfMcvIz2CxhF/LEr61tvuOzDxHtELpQIMNuvOsVubnN4eMzmQMBpEO77IDPZe6K
	7otAyA3e3hIVQAG6iWiyqSyyodFl5ScKXihx9T79bbE2CNBfl9DqDk6njWQLHFMxHUHQ7HOD476
	UmgBfrZ2Nr+X6bkIE6xXKvRupB5cM+nQ/IBwXQoN1q1xcCe5KSdpF/PNUbMO/DSr+Cc46L1NskU
	w2ZkS3EaH1HkvfkO5pz/EcqYuUdE/1Yrf/7ySjfduF3WWmgZTeVE+3JP38FDn186b8HUtpoH9DS
	SYJ8ixkCAqKeyimDFwJGgn4Fo9Swsa7gT8AY3Gc/ejlMd1eQ==
X-Received: by 2002:a05:6102:6b0a:b0:633:1fbe:79c8 with SMTP id ada2fe7eead31-6ff09f907c7mr7172119137.23.1780901969469;
        Sun, 07 Jun 2026 23:59:29 -0700 (PDT)
X-Received: by 2002:a05:6102:6b0a:b0:633:1fbe:79c8 with SMTP id ada2fe7eead31-6ff09f907c7mr7172103137.23.1780901969023;
        Sun, 07 Jun 2026 23:59:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:19 +0300
Subject: [PATCH v2 1/7] PCI: qcom: fix parsing of PERST# in the legacy case
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-1-efb68f1ff04c@oss.qualcomm.com>
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
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=h4yLRvqGyQTl6OR0GngMd/YRroUj4EhJo0XPHba7d0Q=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ZahpdkIc/m2AU14Tot6u730x8n+R6Ny+q0YatY9z5p0
 4SPgmydjMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZjIrDccDH1i8QtkmXQ2xZTW
 b1zltt7i/P81d0XO/4gTdw1jO/yv2Uo0IWb22yesSzpb/83cH7cxnOm6xv6KoCURiq+6AmQ36/S
 77q+1fONfHV9zeMKG647/DxsEB4evcv/7+0Bm789ttzXbM5a4zAzxP1eQtEfWS/Pm+m9TX2j2fW
 eOrzE/5/Tg50/m3sk7MiSy/0jcvuAY/ODdnxhT8e4ZPUeZVsgmyb+9/OiI/UuJ0CphjZwNM9zEZ
 0fVpL61rNm7/HSlRJJhZVvRffZ19dt/rN6ZMqnlg/Fjtb7jTzncP7ftlmlnnf7ZVdjd7PznrO/L
 fDzMej0lEl7+ycgTU/dn5OUIMZodpsfIOS9N1XB322FNAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Ciaata-09u9xu-PzDQ0FkWQTLim6V76C
X-Proofpoint-GUID: Ciaata-09u9xu-PzDQ0FkWQTLim6V76C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfXwGiLJhbCEl6Q
 8EC3Ykearw/Ceno+7BXiAkz6HOxjmOSOKQ8LJU0RLUzSUx4q0xFRdULNuAo53GPt34OconC1F+V
 hR96+RhjSjl06xWcqHZjfGGu6NPli7YzA+7KwUqgKJlSaWXYtz07yXvf3c9+1dMHBoDIlM16wnZ
 1WnlHWcMB9uh9k5vKzCasWBnoHbGl3ddCma/HBHMA+iXZttIQEV4ZWVcEKtUI4Z9+WzhPFLa26P
 XRYmgUBPTQwFT0X75KQ0BTUZ+tBRwm+L0XpEoKqQi6y7SqLFH8y+02cOFihJpIO+mHY77hwiyLt
 pZIDowlectTYNk67oeLpRXg8r9lY7iHXkwSbfuq/4zBhPC6GaSnq7lx6zhqf4L32g3vJ8vn0L7J
 OePv4OK/CU+8WEo7ARfSzOxmSGoNYW2XUGuyeUZtIB5FwbjWiY3TDNb91/PNTkPnBYnNitnvCDF
 2FN9awm+udKR85mGxAg==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a266852 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=A_p6hzaB3oH8elZwPmwA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37478-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:konrad.dybcio@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: B433C6534C6

Commit deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT
configuration") fixed support for the "mixed" platforms which declare
PERST# pin the RC node and the PHY in the RP node, however it also broke
support for a majority of existing platforms, which declare both PERST#
and PHY in the RC node, because now PERST# is first acquired in
qcom_pcie_parse_ports(), which then returns -ENODEV (as there are no
PHYs in the RP nodes). Later qcom_pcie_parse_legacy_binding() tries to
acquire the PERST# GPIO again and fails with -EBUSY (as the GPIO has
already been requested).

Move parsing of RC's perst-gpios to qcom_pcie_probe(), making it obvious
that it's shared for both cases and skip parsing it in both functions.

Fixes: deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT configuration")
Closes: https://lore.kernel.org/r/gieaybsg2ckxpctvqj77nlwu7utama2yeyvebkonmexsxrra3v@v3fobqasxnmy/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 11fc60489892..7664c7c28c0e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1907,15 +1907,6 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	struct device *dev = pcie->pci->dev;
 	int ret = -ENODEV;
 
-	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
-		pcie->reset = devm_gpiod_get_optional(dev, "perst",
-						      GPIOD_OUT_HIGH);
-		if (IS_ERR(pcie->reset))
-			return PTR_ERR(pcie->reset);
-
-		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");
-	}
-
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		if (!of_node_is_type(of_port, "pci"))
 			continue;
@@ -1942,7 +1933,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	struct device *dev = pcie->pci->dev;
 	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
-	struct gpio_desc *reset;
 	struct phy *phy;
 	int ret;
 
@@ -1950,10 +1940,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
-	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
-	if (IS_ERR(reset))
-		return PTR_ERR(reset);
-
 	ret = phy_init(phy);
 	if (ret)
 		return ret;
@@ -1970,7 +1956,7 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
 
-	perst->desc = reset;
+	perst->desc = pcie->reset;
 	INIT_LIST_HEAD(&port->perst);
 	INIT_LIST_HEAD(&perst->list);
 	list_add_tail(&perst->list, &port->perst);
@@ -2107,6 +2093,15 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pp->ops = &qcom_pcie_dw_ops;
 
+	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
+		pcie->reset = devm_gpiod_get_optional(dev, "perst",
+						      GPIOD_OUT_HIGH);
+		if (IS_ERR(pcie->reset))
+			return PTR_ERR(pcie->reset);
+
+		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be updated!\n");
+	}
+
 	ret = qcom_pcie_parse_ports(pcie);
 	if (ret) {
 		if (ret != -ENODEV) {

-- 
2.47.3


