Return-Path: <linux-wireless+bounces-21459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F28A86ACA
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 06:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59ED5440516
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 04:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B9D1624E0;
	Sat, 12 Apr 2025 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yq3bj0Ck"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F124315F
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431852; cv=none; b=R1jE/TlhZKQBIMp7dkg7flYC85mtXu6ZoC7hGBF0OQkNuzS9XTWBhq1OWCyISJSHK0wdrHtHxy/c4EeRVAppLKxBLD8wjdEXyI+S88ytjWDXyCn4KF9WbWO5f/ChWBBLlShvmK1htgj5/G/5FMgQQXZyNrSGPSInpzr39WuFEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431852; c=relaxed/simple;
	bh=2eE4tZdnw5EWjXf6aPNEcvxGZC/gLtvm2Q9/oaIYGU8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aQkzkeiUeTc96wrbrM7TOcAL6yIQaqi24p8daNq4h3+bZkjFv/tcl/VSt+CvH7GnOfpsZNTgY7hTH1ijYdi9zEN4mgv7Vt8VyP0PmiqVQQzJWFAnu/pMpu8eFyArK2laKlnHJRJMjQRDyJx0+CCwKy7gP3rN7/fwKXHN7SIDwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yq3bj0Ck; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C3l9Zu010397
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tqN6O5ULYQADoM50LR6WnyAaV2Q202v8B7Mm2bDgXcs=; b=Yq3bj0Ck0ZQgdYC6
	sAvqZsUJnUptVtDZDeKCkoTSG2QKK8vY8s0ruzsVpiN0aqXmaiztgHh+d/PKx3W8
	LfhiV7wD/eXYvBAlwc8/s7cQcEC1XU6a78q+pPTTFyzPXVJhHkE01gjAxrMaYiMi
	dvXQ/gdRbth514ij9FH+2CxOIpbhewbBl3OihZqoA1hmDo4uo+6CLRmTmq8SeJRT
	l4eSG2s45vC5ZkvIcpJBMc5uLOPzVjirmgnWgzsufk2C3DpXhFybxiujlH7oQa++
	ChFLh6zszpAFsQ/0fafBzIK7DjBhBXOm55Z5LsvzF/YZc2u+TEZtjf9Tly459PE+
	LD7D/A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmm6dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso2721745a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 21:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431848; x=1745036648;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqN6O5ULYQADoM50LR6WnyAaV2Q202v8B7Mm2bDgXcs=;
        b=A+q8YtHueC7tG/1gf1Bh3m6oJVL9p9Hgszq6H+eLiPGLSaCrO9XCxkGIDW7SEhg080
         iG53fSQcztAstTLhcyCesqYU70IW7FN5brzpGUrPkfr+o+OhBcinHrz6t9hmspnAIHbT
         v92+JEjySx6kyg7i0DPUfYxkDs65/tvXCl7QSbXOTcvD3X2HnYGJCb3N1FjW/qKnUwmS
         oAhSFmpEqo/E2iQoR9AGsgAghOt6IwG4D/ehotG/5uot2nZoY1n2yy7u+lpYh+mFMfzQ
         pTJVoEC8Udu+dpMYEHxTHD0R4OXZT5o9tRDCpQMyrUeilCHTTMd6Q0COOnwWhjx3gwCr
         Msfw==
X-Gm-Message-State: AOJu0YywxI3DBTUlysv5X73/xbufiqVq6Morgw4U9+Ggdg/MPLN2f/LO
	kLXKAAS3qmu0nZ8LcpxtEnQ/vISOK+uERvHUX71W6ymehza4ky5pD2OtQJ0gQBCgs6vr3y9Y7e0
	B5WZcPnSj1/PwPxjgAQWrj42N82mYdbH4vz/rbqAFqX8zi7olaY8nm163STYxjFTsOA==
X-Gm-Gg: ASbGnctgIZu5aqegLo1m62tiVlOSWNzYgS113SbCYE+bebKCIsV4/K9v0HI4YaaSNPq
	Xhf8HBctNKWstx+KgcwZ4tBHgYFDG6UknE7QEXQxUlF2RN+vT1hA/PuY0bV40ERYR4AGgC8gDC6
	Rljrn8cY9XGuBI8FCMxUDER5GVU6eEEXS1VU2GdsovwQXiC6jeTLT2HmQl6ePNVX/OYSagJug/3
	ekslPl8uAv0E+3Cl7WEwCQ0SNsk0Eb3W1wo5XJcbm7pdJ+t9gIWhxJj64kFTsspUdT9xgiYBc7c
	UfMxnW08DblxAm/hfFveOpeHWceMagvJ2u/v4i+EfxcvB1Ci
X-Received: by 2002:a17:90b:2750:b0:305:5f25:fd30 with SMTP id 98e67ed59e1d1-30823623d65mr7856968a91.4.1744431848003;
        Fri, 11 Apr 2025 21:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh70vguOhIvOgg+D86CUV27Dur3Uhw5gZEQCAuuq9VzOZes/H6uRcl59Q1uDxF8mphAShGSQ==
X-Received: by 2002:a17:90b:2750:b0:305:5f25:fd30 with SMTP id 98e67ed59e1d1-30823623d65mr7856948a91.4.1744431847627;
        Fri, 11 Apr 2025 21:24:07 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm6829912a91.12.2025.04.11.21.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:24:07 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250402182917.2715596-1-praneesh.p@oss.qualcomm.com>
References: <20250402182917.2715596-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: add rx_info and replace the
 usage of rx desc
Message-Id: <174443184681.2972989.9130874472554364249.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 21:24:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: stcmIh4hG7sbiC84EplXSMEG0PvtHnzm
X-Proofpoint-ORIG-GUID: stcmIh4hG7sbiC84EplXSMEG0PvtHnzm
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f9eae9 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=1WJ0sSg6dNN4DLLMY2MA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=432 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120029


On Wed, 02 Apr 2025 23:59:15 +0530, P Praneesh wrote:
> This series adds rx_info to capture required field from rx descriptor and
> corruption in rx path.
> 
> P Praneesh (2):
>   wifi: ath12k: add rx_info to capture required field from rx descriptor
>   wifi: ath12k: replace the usage of rx desc with rx_info
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: add rx_info to capture required field from rx descriptor
      commit: e88e6e3c9ada84ceed3fa223ce11af94fcaf3ad3
[2/2] wifi: ath12k: replace the usage of rx desc with rx_info
      commit: bd00cc7e8a4c1048d14c9a9e9790c582119785fb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


