Return-Path: <linux-wireless+bounces-21558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B16A8A596
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2873F1902D33
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3E42343D4;
	Tue, 15 Apr 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FzRHpkTe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805223371E
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738182; cv=none; b=ZBIUYwGLRRPRQUmo2y98ITQYz3JBVbDvLZmwflzfzTy36V9Nu604QKVYBIefM5tbuWHptKmDGnP/7+bnP+DrGyaXdmKMLE+Pk5KJMHXS4ITD5fW7WuIge63+ceIS/U08niddghpGikku39+NU+Uq/6JlqnEAA/jjxNK4TC/Su7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738182; c=relaxed/simple;
	bh=9m68DChNC48Fpc8siTFzBscS9XAITIUx4gw60s5sHyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHxpIGiEPCcWTfy9MQwr407qbCpnpSpH8n/hH61KVWxLYKKQpI/H9Qz+aQsBZjVAExuW7K7ziedJAARDFLLcpZUwJCULrbtUpw9Aoos3Ao+dWXMJDc8jMqoaN2Y3IagcJaiRZ63APMlCifF9Ytc4piDyU7AjYAfB1g6dl7FamvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FzRHpkTe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tEji018854
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 17:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	68zxaR8Rk8J54M5CK4OD8Nf5704X4rrP2izr3pG/fXM=; b=FzRHpkTeS5PMR75u
	7wlx+IZP2wkjAIo6Z+kQuwqXXPkpVBI3hWYpS7ZwPfzBTbEBS1UATS8QM/4pKrAG
	PWB6yj4UA7afXfNz2a9rUWo055l3z4UuTvhimS9IyAcrS9ftKG7M3o+NcUTIjUq9
	WMIGjmz4xNQZW3n8uZnMi16pHtPZSZoc4pA1r7oVvkX6KBAA4Zx0NR5g4kmXwtxJ
	DM1KZRrB79yQBs2G5MNjPmKxIyey52TBkQiu1YCYHnP/omWsRXFP5NabAslKvzIv
	7ACF501pj2j6XyhJCWF98oivnT81Pe+iN5V0GpmTp2dI5Ct7xiRch/zdeg8+GDcl
	G4LzRA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjgw74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 17:29:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-227e2faab6dso48849135ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 10:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744738178; x=1745342978;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68zxaR8Rk8J54M5CK4OD8Nf5704X4rrP2izr3pG/fXM=;
        b=BnhBNrv4RDjXTs68xlb/u7fBmGxT5e8OBgUb5QZXC6AVP2jJLsY33TBrrMzao7rizc
         hWhlu5TlKBXWxtNJwB/HKSIRV5n8hdseRESHnnFOJ4m/vIGcirrRd8uoTRh0iAxrhoEs
         SLt1Q8fPPcdbTcmqSbwkay9gNLPx3isSlvnwgbKaCj2nlGNwTU2ODoMSl+1fkUzexLFy
         j0bCUzVqUBV3G75rZyejRsDxHdJltN3NZYN6YyHs4ji4+Md2A3IUbEOi01Ekpwg1yPnt
         sxsq1F0uLPTY0UeukiaXwqEFOpo3D2Ffr2bJ4FqetbW7WfVLvDCDuMhZVQxACiPfGOOP
         VyKA==
X-Forwarded-Encrypted: i=1; AJvYcCV3bXHhkmdfL/4d0HFbxeQkpJWuegaMQPgw+BpHDecmctl9J/CayKUoFKmEfqhgupmf/UOyFBJYYclVlkAFBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3DDUshDZvKs862WQ57lDpJXs2QnjaCTtXxEYQhO11d7b+OXD
	H+E60dW3a+1l8uxx1KwX2U8Y/YZJdoa6opgw3S8k7GeNUrRhoDYIbHICoK2P8yUgzohyLGr8GKV
	sGb59gDlp3vtAjN0vuhdVukujfcLXgP4rmGWK+bj7aFU6IAagy1oBHTh41X3bUbq0PQ==
X-Gm-Gg: ASbGncsJGLAf6UYZs9+2bmkuEpShBRXYFWMhhgOt4UUSct56f/F1DngmpjvvjD6PljS
	Aq4w5uG0l6DDA9BTr3vY3cKaps7wlonN0/cuBXRCoOuGZ6Z0/338s31CDTSNfyDE0OtqWPJ8KK0
	fB9mx9Df41AhF9uKrr/mBJjp3Z3ksrq1ukOb3oM4elx8MDRPM17dNREtwQY0QFLyx0zH+ylhLlI
	TAeIl8fz/ZEuOf/At5YV3b9pjTHqyvw7e2TL9HVqM33SboKfrawSiJ01T493QRk1noO70EReZ5s
	VrhHyDmGfSXSYUy+ov4NAf74fGRNIDZD+W/m5XDvMpvQwxcH3dGO4pa6tKukKBIoTFg=
X-Received: by 2002:a17:902:d550:b0:224:194c:694c with SMTP id d9443c01a7336-22bea4bf56cmr277869675ad.28.1744738177740;
        Tue, 15 Apr 2025 10:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8L87C2PUH81kzhhjelJom8UKgFRRDMXIPSGtzV7/a1Rjs40pFRM+XH7SuAR/inuj8vxFnXQ==
X-Received: by 2002:a17:902:d550:b0:224:194c:694c with SMTP id d9443c01a7336-22bea4bf56cmr277869325ad.28.1744738177389;
        Tue, 15 Apr 2025 10:29:37 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccb5afsm120874155ad.226.2025.04.15.10.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 10:29:37 -0700 (PDT)
Message-ID: <7755fef1-1283-479d-8e15-022f06547e26@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 10:29:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Abort scan before removing link
 interface to prevent duplicate deletion
To: Lingbo Kong <quic_lingbok@quicinc.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20250226113118.7626-1-quic_lingbok@quicinc.com>
 <46030c46-a2ca-4d02-ab51-3581f7f3ddfe@lucifer.local>
 <21ef1321-b079-4749-a675-dcc814f9373d@quicinc.com>
 <4930255f-87d7-49c5-b53f-6fa565cd3a56@lucifer.local>
 <6438380f-ec71-4ef9-a737-99f4a45184d6@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6438380f-ec71-4ef9-a737-99f4a45184d6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rIvNsZn1FOzUbfs47_aRiFdR7MEzD5Af
X-Proofpoint-ORIG-GUID: rIvNsZn1FOzUbfs47_aRiFdR7MEzD5Af
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67fe9783 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=Zjz8bImEkSRBnUl0h_8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=722 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150122

On 4/14/2025 4:10 AM, Lingbo Kong wrote:
> i'll resent this patch rebasing the upstream code.:)
> 
> thx a lot! lorenzo.
> 
> /lingbo

Yes, it needs to be rebased...

Applying: wifi: ath12k: Abort scan before removing link interface to prevent duplicate deletion
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/mac.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.c
Recorded preimage for 'drivers/net/wireless/ath/ath12k/mac.c'
error: Failed to merge in the changes.
Patch failed at 0001 wifi: ath12k: Abort scan before removing link interface to prevent duplicate deletion


