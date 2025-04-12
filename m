Return-Path: <linux-wireless+bounces-21467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED08A86AC8
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 06:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CCB1B8435C
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 04:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72144193086;
	Sat, 12 Apr 2025 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QBpxb7U9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45118FDD8
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431858; cv=none; b=GvQyKISOoHAAy6X6c0CabeJbE2gzgQA5sAioBV3DmBCBJWH99YVCsIAu37nxtwPHa5vuUWQKJnzylF4XPPMJYEN9dUyNy3z2/p7B0Ij/5873myHiJWS9Zg4kvwz3cmQ/2VIMCdajVIHBf2mb0jVVSYz4chDzmxmmC9euChU5mpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431858; c=relaxed/simple;
	bh=oaLfSJxSzeJR9Rtek8qj1Vt4DB0A3q5t/ljDNAQbLK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JBFbalW4w49I0ykuD4bwz6G1YLfJj2onzpQQEHUw7VBXGw6zaEQe7N57R2NbPDeEFANpPFAP13oPaHmOzKf+DMPVAnPjN7XG58T+cnx6pSpcM+4Br3skrI/sbFRNAf07yQiANow/hiYPT/AcIZ/y86cMDmmCRQFrrvP89K6S8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QBpxb7U9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C3jitw008829
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yltj8V/FaVbMSn3d0Z2qwwLYdmKBWgYnuTV92lGPDnk=; b=QBpxb7U9Mn/ZY0IW
	QUjlFwrAc6rBkpKJ/KwtkZYNv9p0UuJ9zZOO9E/x217M+Xn0YUgajqZKCIYTjV4r
	CfvUkQpXXExzx5cx4Pt2sa8xdKuQfn8Tp8xISy1OhOQadjHre8iXTpVpWfshPg2S
	PRljKOAdcQA4PuGWr9rZWjQ7i8NOIdR8kU+qsg3n2ppyWqHQJwNuiTIvLShfghtX
	LhlJY+10/9gpHWoGi6+Y1cxfoEjbvKOjzWVJLxlU6W3bxOHD1Y4rzORgTil6QyZN
	7iZ5GRPj8Qky7uQFnA6/UPqYFEOnyJBzDxnUL8KCfDRlvalu3KDo6toQApVBiuqr
	hyd6zg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmm6dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-223fd6e9408so23769125ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 21:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431855; x=1745036655;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yltj8V/FaVbMSn3d0Z2qwwLYdmKBWgYnuTV92lGPDnk=;
        b=qUP5TeeIlfov2R3m/rut15ZAs1rdCA1paH3i+gr7Q2FGWWBNS2knTz+3rPWk9B8nVt
         30fBKOQaqhmiCoOY41eYM1TlPw+EJ3s8RHIiB1WU9/3oXsA4XEXLbrvHVMCXlFzEdyFG
         B3EYDb3nuarorIavTJRvtXrlA9OHWiciDvjdzNERTZt3j7Aw06VjW6cu72YCSOKqM7bi
         9Chsk2vweQJBZWwh0nYJw7Y/m2BRma/lmdDK7+PlVLWghE5EmrrTtEz2ZJRhPLg91GJC
         SCOyZvRWUYJw/LmEIhv6IE/ql2MKBIAlvwQVSViPMsCytttlPpvsU9RtvHoGmHMHeU+V
         aI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZpNLw2uMocvUuSvFwz/ez+eK9y1D/cRpW99V5Ib9OfSyoSbls1RvI+0ABX47LqErrmXOwQmzCuWEOMG4QJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcNC9YcVv2Sdo7kjvzQH78TJM1PTSt+HmTU1slvZtngcBWpRD
	kWXEtHlD000EYqC5cpJXZrHA5H+MsJBq1EBmnI5LKegeiZ6FvtyS0VdgNjYphhyeQiMqEJyflDY
	z+2wlRCv/Xs0zDfRBOwAte+pBHzBNxhwNwfuUDYVOEuaYH26kSbKVRGkPMh6heRt1CA==
X-Gm-Gg: ASbGncuprzFBaj9wxcPntOoV06X0Mno0/9VXxA+4J60WvIepVG70acMU/JvsGD4OuWS
	i/3e6Hu4anFFMnuQOaJkUOQ7ZdIBMZoFzuvxu2+CL1OmODSzQpSooKNdXzyfzo6E4dbA7tkVNkc
	Aswzc/Xvmv51tNHH+0oCVu+HXowbGtLYTS0yI5XWXmHYrmZJaMP3NjjkD9iTQOkY6C4ue1b+ZmS
	zPRIBgbKIcgrSsISxT8YZ+NUq/UaG8MUJsscqlRDfxfQuwbTNsAIgOxBCSBDBgb5vA6c9uHItsu
	xdSwVF1xtaoX7dUyebxyWS8MC1xmYykrsmWYdTzIHfON8WJS
X-Received: by 2002:a17:903:2d0:b0:215:9eac:1857 with SMTP id d9443c01a7336-22b6943010fmr130686815ad.5.1744431855265;
        Fri, 11 Apr 2025 21:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaF/ZdumqPMm7Lo9UgIJs3LlV557WY/BkCBFOJHRD5je46M0dwSnCadkd518sE39kMcv9Fcg==
X-Received: by 2002:a17:903:2d0:b0:215:9eac:1857 with SMTP id d9443c01a7336-22b6943010fmr130686505ad.5.1744431854652;
        Fri, 11 Apr 2025 21:24:14 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm6829912a91.12.2025.04.11.21.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:24:14 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Dinesh Karthikeyan <quic_dinek@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <35daefbd-d493-41d9-b192-96177d521b40@stanley.mountain>
References: <35daefbd-d493-41d9-b192-96177d521b40@stanley.mountain>
Subject: Re: [PATCH] wifi: ath12k: Fix buffer overflow in debugfs
Message-Id: <174443185385.2972989.16898377871566470788.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 21:24:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: fNLTdccUpQxnA3LIBPqE8xk5O4J3lfny
X-Proofpoint-ORIG-GUID: fNLTdccUpQxnA3LIBPqE8xk5O4J3lfny
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f9eaf0 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=591 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120029


On Wed, 09 Apr 2025 14:01:25 +0300, Dan Carpenter wrote:
> If the user tries to write more than 32 bytes then it results in memory
> corruption.  Fortunately, this is debugfs so it's limitted to root users.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: Fix buffer overflow in debugfs
      commit: 8c7a5031a6b0d42e640fbd2d5d05f61f74e32dce

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


