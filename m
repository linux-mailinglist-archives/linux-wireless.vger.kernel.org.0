Return-Path: <linux-wireless+bounces-26793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A0B3A249
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 16:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25300160738
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B051E487;
	Thu, 28 Aug 2025 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHFBY08+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057231063B
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391789; cv=none; b=GjVfREntOoI/ymvDOnxat22B4S+lzjJMx1gxNhAaiUZL5ECa+xtnpM+JXQw6r+qZlVYjtrj0E84r2bTFVZjtL1Ox5yhB8IrK2HXJklQVrAcTOkiwBaGuuP8Xq5plu7ecb58phR9sriJYYc/Uig8/p+kLd6D5u4SvKj+Na3DaxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391789; c=relaxed/simple;
	bh=ERI7zziQ/qkUFC+Z0G4NsSnVttMbxiqLb2QoPBS+QME=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=QipphhAloYQhk76x4IW+ThiNAhYupsis45Jt2tJREma+EsZiSxAhrmHvtIYWILxZczk7ImOgXxv+e9MgvhB3blZ8dQgewHFo1gTULAscwf5yRBOpU7Q2l5GHVfmfElJz5NsTaFxgNCOIqCPpsogsD/qnF4ZykpANyfnbsa4WM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CHFBY08+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SE0Y8M029319
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 14:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XjZ3jX1113k8dvFlR8NXrb
	bl126/WddYFoCad8ZhqNg=; b=CHFBY08+ZwImMbXRu5kSZlY82MC5tAyuiH3IXv
	L4gzBww7ikVz7mXzwHlJAu9Ejiii6i7G5WWbcTflYsRaY58L9mUi38ES2Oy6GsJ4
	OzMV/aNRdg3sRrs7r3p3CEZ/aXYk35wyE8ypSGu71/96gOL6vMYA1PyLoTT4Z7oT
	Jn+v6R97ecA2zi8UDF7BOMvfQB6M4d833ysLh5fVj4eEZ4EQTOTtnqQreeP2xZXA
	9ALRkqvIOcouoSVjAEIXoe85T8I9SYZcV2sL1mU/UZULrQSeiWCWzc6u3OjDZokV
	7hJPT35cuVg3eNW5b7MuOTO/1Ew30Ehfmg3OPNzbi/IOPF7A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w30qpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 14:36:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24895637fe1so12022695ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 07:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756391786; x=1756996586;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjZ3jX1113k8dvFlR8NXrbbl126/WddYFoCad8ZhqNg=;
        b=h4cSMPX119k19a9jW8Lzd5TQweD+9+zx3PSUEsBr7iWVwvXXrM2SklIJGTfoqyPt8G
         kXhU9jN8g9xr9Yp0oJtQPn7lh7C4A7QMzMThCmwWbVxqjW+Elw/+FToqV3fFTVdprj3E
         XK5B0HgsCQQxFZuKzWpJQkuJPpjaNw/3LA98zHBKWVmbIHp/rW3z+/tt2yVSlXDWTt2e
         Irh3P5JPVNKqXCPXEi9q0i0mCjGFe9GX1SQycBmU1JXlvV+0UVW65C06PesPAE00J9xb
         55dZMhqfD29tVjuAu5LOvlvM49Qo7uYoUQuEzAx6hN+45NguHDlvtyFrHX0UjquROD7e
         nVKg==
X-Gm-Message-State: AOJu0YyXbPo+4YfvNm5loTdVgmWx+Z4BIFBnG76e+rqGP/Kzg/p/gusN
	5wsJPhWUuouCb9B254P8gSaXMq+1Q5TEUdQ6cPPiIoRH2xmptzWSvcD8CKwMW7FCm7YsnCrhGPJ
	COiyxrt6cMO1SjvoPfYy0v7R0e02qTCztskqeL/VekVtFLk2q/grE86iTEE2bM4nN1n8PyA==
X-Gm-Gg: ASbGncvL5xcAVBil/rwmEU5Xn2/hzxkFJEpG+4XdbIr+jqZK5zhck/mSG+z6vzG4bID
	BCXWmE3s0888lWorSiCwXjdQbAZ9UP2j3meco5cWEpcM3qMbq61oG5dERQJDW2xmBbLcB1Agowl
	FvTiZFp9uEl6h636Gbfd6uJwtrlkmAHypWregMjXMDQazdAHwPIv0U0NeNbKRqxucLM4/qAhY5Z
	MhoUYi4EDUuC12KgXm2uLACi5mPgTI37uJiy5ff8KGGAZ1k4y/Cw0/ML5C+ECYM7CK+vhWcOGdd
	BqGEpH+FUxvNMp9NJguGN4JT4aNz+D0eIANTBALB/c1f0iTHT1W8z2p6fG8v3wDy6uLPKltMnTE
	S
X-Received: by 2002:a17:903:2287:b0:246:f14b:31d1 with SMTP id d9443c01a7336-246f14b3365mr173812615ad.32.1756391785834;
        Thu, 28 Aug 2025 07:36:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL2bqK0GrWCTia2+2Ggcvj+uvADGJopEJM1qYkYmwTlTNYATTf2IHqE+217g1/8c+O+RYceQ==
X-Received: by 2002:a17:903:2287:b0:246:f14b:31d1 with SMTP id d9443c01a7336-246f14b3365mr173811965ad.32.1756391785205;
        Thu, 28 Aug 2025 07:36:25 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24882c840e1sm63260945ad.69.2025.08.28.07.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 07:36:24 -0700 (PDT)
Message-ID: <9eb91098-48a6-420f-bb6e-e7968ab0a2e4@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 07:36:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath11k firmware ath-20250827
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68b0696a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=K7P3aSCmrdTuO1j2XbMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX4HoNpVmfRjew
 57jchj2HGKgET7rQHVyWNn8xtyHBSpRme/ugpD3nt7eqEdP2ukPJUZZWfz3FppsLQRp9uuoSWsi
 q05qrAeSo16J7MOl8Xl6BsI6AwrRg1yOadxSufIyNvPybHOk5f8SNPCWPRJukQko4z/Brr5cB67
 bxP3uZ+F7sQuufvh2YBDWby1S1VFXrBNOV+HPQ0ye+q/GwlePJori6JjCNinclYevUK7qHmp2As
 5sFQVUWV8i7IDn7wxeGEsc+pVH+sD11Ppap2jDUt0wBLrl09CsfuZCzQIYKz8AobGU/ABRq0ziD
 DWuZfKRou5dp8p5eTmw6LfvmcxZUG4FPKMdfFhfK7hMzugM7IkL2U6P42OWi0j5QFosgpaxDdvj
 IJoPVJGh
X-Proofpoint-GUID: Nhaak5VCOhZoFfnK86Zh5WPSp-R26P-r
X-Proofpoint-ORIG-GUID: Nhaak5VCOhZoFfnK86Zh5WPSp-R26P-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

The following changes since commit f044bc789f8e7a4427593b687801644c39e3e8b7:

  Merge branch 'amd-isp-staging' into 'main' (2025-08-25 18:22:13 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250827

for you to fetch changes up to 0cfc1632ef7b1cc15eea36214fc67098f6d49531:

  ath11k: Support WCN6855 hw2.1 with NFA firmware variant (2025-08-27 07:43:22 -0700)

----------------------------------------------------------------
Jeff Johnson (1):
      ath11k: Support WCN6855 hw2.1 with NFA firmware variant

 WHENCE | 2 ++
 1 file changed, 2 insertions(+)

