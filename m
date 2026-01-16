Return-Path: <linux-wireless+bounces-30883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C44D29990
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15CE305C4FB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63E3346A9;
	Fri, 16 Jan 2026 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KLUf8wHK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QX5oaXUq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40647328B55
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526821; cv=none; b=J8uYe+B0fTX53gMs8d+/fF1qcXUEgXD34kSeSuq2ovJ2FN3fPBWflsRQlw2+O+Uj/qGH+K2pGIa9LQFdYNLJt9Ua9D+CQf/tp85Gr5GmE5LKroCyBElkCFu3J4+pk+TTuoIsVRQ5bYa1+HCEfg7Ya8MvJinfmbayLXFXjZc6UQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526821; c=relaxed/simple;
	bh=IFPq2AGE30TCwQrfggaxZJB1FmacEQG+xSFhJ2lnDwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rkj/ANE/EG7AEQu0qB43za1JLUwO97RQuEgH0awYHKBXrEWpp0I0U3Q+puVEdv8Ea/F9EDbrgElA2y4BpZh2pSvlIJKkUJCMFAZMjP2ZCEYNRx8wPK0Ff7XaM3e2qClJSOU78jST4U5VyNsMx0h0CoXELPtGuXuo9+1/knd8nXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KLUf8wHK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QX5oaXUq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbYd41240908
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S31i/edPzlupuozbV6kshI5yVsEpVcN/4WOUy2AQf2Q=; b=KLUf8wHKbf+n0bjT
	n+FJ+U5suWLcXqk/WXGJX26euoJ6LAGrNOHEWxQAcslP623T9YzDTBDpGIZiBZOF
	8T4TMSmC8XC9RfLg13zX9x5PYUPEjlplXZ7upuRvFxLafSsD/Wu0KbY3p0VbIDci
	du8aX8hpFvL32mMZIEroMcV5bN9f4ajsbBfDwspcZ63pbA9vJs8STYjXTESwpQpd
	03Eeu0YD3Ygink6GBVpAM9NrJ/U93gAzTnIhnAXl5uKtsabj3biRRWqlqOjm1lAK
	4G1lSOAou+FrRFP5IU/bFtztEC+nDlkido1pouz/u2WzuwS986Nl+iCQWLnKLLii
	AIwMFA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96srbc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b0531e07e3so1730671eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526807; x=1769131607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S31i/edPzlupuozbV6kshI5yVsEpVcN/4WOUy2AQf2Q=;
        b=QX5oaXUqXgZy0DQadm0kH0WuY6YQMjBlO9AHKPBVU3gd4bs0WFxNBpt2wAW5C3v6pM
         AuUJW3hAwg8tu/QqJ73ENzVHwXb0WM6Zg85q5Try9J/WkCa69nGc5xsST4CUQp/bBNXQ
         dDO58RJ+WHr1YuH40bPlzVApdsxyyEbOHVAKoOjkbo2eBf11Y8oqLtqbJkHTsDfRP6KE
         Kyr2LDyNXCO00U9Yy92lYGCjofCao+bO/QB/b75t4Ki1set+jAVF/Co3/EHF/yq8EDLp
         Cuxzth5tWRpOYdYT4lCRCO7/0R3iHL0Kr4u6x+p+EidG6/8ZFjEZQsQbw2ytLnssd1IK
         hkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526807; x=1769131607;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S31i/edPzlupuozbV6kshI5yVsEpVcN/4WOUy2AQf2Q=;
        b=g8qWjMbqer72MmzLmaSShj1TVK4nqelH96Em8cyn5wNBTz/jE3oy3pnSgcO4S3/kMJ
         /AARVsBvGWbsmZX4/bWwmuid5pn7xjAl94SymTFWXcriFLRYuvksDvnGXJ+vdX8F9TTc
         7iw0LBOU0VSZK5cMPFPHQ4j3wGBNHsTC5ITWaP3ftZurTwJRdTH8x2AGmrEkbGH6FVlS
         Xs49/WkZrB5cyVHsYJYm5wFGY75aun9oVo1Pue/IMpv+Quhr0k6+uAtKBqYUMqy7wqpg
         XkcpaSYtJUkHXVj+QHrfiJQh1ObBvbGGRv2BUk/M3gntuu17nGM/nTKAFAVerhBdXGxy
         X/aw==
X-Forwarded-Encrypted: i=1; AJvYcCVoxbQF70Ni4Y2GtD2TaluiPKPTdAF7SGmbqoH78uXrsGuL5oDlta6l0WYaSPqNyBCOhuzNn275UU3b2or0ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3pdSYeLNnEt0xaJSIZMSqkiE4ApCn5cFDayA3zAs9vLhM5ZR
	cvT1M9PsBw3BeKoXocOQlOyHU7UEUdDlzUeNiD8e2kbMPzN6AO9N+dpHrO2NzQejO583YPcBdon
	Lya2A3sgsc84JnlY/VhhpHyyYr5kpssXqfno8B9Kv1i6I6Txlg7HEoXxf/Z/7hcGVrO9VHQ==
X-Gm-Gg: AY/fxX6SBDw22s03jEWL8yC9SiWpDhKSPZs10iFF+a3VfppTr5ck2l9VRrPo2E+tX3k
	EOa4kXS+gIiIiv4r2rYJ9ZCpeOnraP3dV4csJjxBfb4QkXmGhUNwSkHmjDHjh0XO1cSa8DzkVFR
	tJ5qF8K6wtMeXR/7BXbHgt3XpjHtRApkkAloZ5FibpeFNlNWTI8JRaefr7Sr53hl5p74Yiwqa3E
	LxA7ICTM+pA7Skcztb+XSpOSIOFyXv7eAh+gMbLS7Lu/YvcndiUjF/QxP47RH51gGWYptk9TdNT
	ZEETr3zMNLanBXCUdX1RxyazVr9jLsZYI052+HRonRpoo22JWqnOVafg4Z9lBCapBOVYtHmJqXS
	LEwjrLIjIP+ob7FQCso2nil/zuNU2T4v1KJS5EXMsq74kWPqbzEHJEHi2YQz2lVQY
X-Received: by 2002:a05:7022:660f:b0:11e:3e9:3e8c with SMTP id a92af1059eb24-1244a7a5dd4mr1841828c88.49.1768526806680;
        Thu, 15 Jan 2026 17:26:46 -0800 (PST)
X-Received: by 2002:a05:7022:660f:b0:11e:3e9:3e8c with SMTP id a92af1059eb24-1244a7a5dd4mr1841808c88.49.1768526806008;
        Thu, 15 Jan 2026 17:26:46 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:45 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Ross Vandegrift <ross@kallisti.us>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
In-Reply-To: <wj7o2kmb7g54stdjvxp2hjqrnutnq3jbf4s2uh4ctvmlxdq7tf@nbkj2ebakhrd>
References: <wj7o2kmb7g54stdjvxp2hjqrnutnq3jbf4s2uh4ctvmlxdq7tf@nbkj2ebakhrd>
Subject: Re: [PATCH v2] wifi: ath11k: add pm quirk for Thinkpad Z13/Z16
 Gen1
Message-Id: <176852680551.1143034.16045961047643085317.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: PXALWrRr3O3SKae7-Gbw0IL3fZdbzxzg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX4vtnSX2tSgP3
 A/U0OFB5d4G5Zsl//9WCNqUYUbJxKy1D1GfWD1g5dQtM/exaH56K2VnpTKE1GglXwc4QdVka3Sb
 peywKhr7BcVUBHU4jB9ImZrxb9fet9M04wHskBApX6z4m4HCS6BDb5pmqFqW4oKGn4KM/UZciJx
 GCgZXg0BStEdKaLPgpuVoqt/I7Fw9U5icfI/BBVi57IJAIbNKJa6HE94sdou7Wly9RmGsMAnPeV
 Wzd2w7ni+Y/x0C5CXQL5FeiWvanN63r20ATloqgXPb1aHFBGG+OZ9s8nT+r3S2K6QdTZ12sSMuY
 MLXFH1ig7cMBO+DV9Fm9fYjw3nMu/kS0eFDfIBJeOyhVMe2euHG7MsI5AdnR5nn8oy1LNEtMLnf
 Z8cjf+vFWjFSnpq6MzolHlZkW2vLaOPaWKtWzG9waeOlcw4kw7J3prVu5FWYT62oSp4iFYlgvKH
 M9KZ9ux9zmynT3SiIww==
X-Proofpoint-GUID: PXALWrRr3O3SKae7-Gbw0IL3fZdbzxzg
X-Authority-Analysis: v=2.4 cv=M9tA6iws c=1 sm=1 tr=0 ts=696993d7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jHorrVxA7sVQ16V33f0A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Sat, 03 Jan 2026 17:00:34 -0800, Ross Vandegrift wrote:
> Z16 Gen1 has the wakeup-from-suspend issues from [1] but was never added
> to the appropriate quirk list.  I've tested this patch on top of 6.18.2,
> it fixes the issue for me on 21D4
> 
> Mark Pearson provided the other product IDs covering the second Z16 Gen1
> and both Z13 Gen1 identifiers.  They share the same firmware, and folks
> in the bugzilla report do indeed see the problem on Z13.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: add pm quirk for Thinkpad Z13/Z16 Gen1
      commit: 4015b1972763d7d513172276e51439f37e622a92

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


