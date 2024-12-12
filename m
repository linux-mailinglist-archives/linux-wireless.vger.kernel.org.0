Return-Path: <linux-wireless+bounces-16338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ACE9EFD14
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 21:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D19128A9D2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BA1B3942;
	Thu, 12 Dec 2024 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euQmEP8S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5AC1AF0C8
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034330; cv=none; b=tY8B1HllB44y2rs8ngu6znbeE5qh49s7znUobBGI2g1/SBQqGecZH+iVk96izv7Do5PUfbLFEHS53DI2rzF2enS93xe+QSVhmRfvYg7y9lNTKysl8tvdaM1RSvfrUSfDCvBMn1jJFJR89nnhdLLbvgVTI7JRDQ2kwMziJ0Yv4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034330; c=relaxed/simple;
	bh=Gn8LXgpHJ7J4ykqP4qWw1kr83wxu++0ImTRJMyjaBXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJiWviWCZSuhqXE80uqIDptgkC7FqxWwcaOiMNQgUOnEYMcwEebPenJYWkpZCDX1rVLODDQNeyh3PSVbX0rVHs8ALT+zrZfZH6T72lgHE8CDt99A1sxrXGzxSFzKDr1EEmysexR+r6qwR8VEahKKkYxVLu+2sH+zl9quxyRM6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euQmEP8S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCBM023028125
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 20:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cn60/1VALbVSHyxZswztHQTAh6tMGf69Zd26GEOzv2Y=; b=euQmEP8SgwLi6gXb
	7ah+4x7z6Yof1gNodNdEdPHtXTfHRlT8ksysw1bBm9TIG8NuycmufO9uU7anuPhX
	RYTKUFc9ssxPsi2yP5lgX/b6ju8xEJ54PybTohuOpJ7+/LSzm7ONIOz18O9QXMcG
	JT2MyhRVM0DsidpC5qG+F/9pIGO84RPCb87LDPrt0DY3hy4PuecVCP7VMc66tsDp
	GdD9+bDqHJD3TbUOR9F3hhte4ZtFvcauNcmtMUDCuGYUihk0ykL+aRo/tsAVavT6
	YSuxc1MzHosZ0XFNcwiwwjWDm6Ik2dhTngov/mTU6vewIlGEe7HWqk3twGZyfIZs
	iRV1nw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fxw4se1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 20:12:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216717543b7so15549795ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 12:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034327; x=1734639127;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn60/1VALbVSHyxZswztHQTAh6tMGf69Zd26GEOzv2Y=;
        b=tdkPpzPK9iAzyTktm0LkcjuGWsfLC+vhZEel4wDUguFfaOuo3ECp2vkymisXtl67eL
         bbRA0sE9IRURPxKFMbOaQGeDyrsIB1/xfVR2NiubiBMQZ6xAZWrWvSteujqsDvLetcmf
         4oHFK8SBAVjYEMsnysYmtHtJEBSBOABjEgLWTrKX/lwZKghNburVl8sWiSLI7AJiKYxq
         KOPyR/MKXDjuQtTTr1OM6Fef8OzWpuBlRHnsm6Q/rth2P0n2lhJYJ4e3x46AY5+MLDjI
         iYs7XJLshHalG1xtTVVRHNm+7zPgY3a6AKDFBNb06inNGaD0hGJM3mJqMgs2ujp3Xth1
         izRA==
X-Forwarded-Encrypted: i=1; AJvYcCWc4xenwvHZ7CTtP0kCytDJpXJ0DQvyU6x+3ECsv3XM9sKPyvITKEnxJtiAM4SPyc27y/vvTjqPiCb844n8iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XdZcxcg0f7b8CmdIr+ZBosuSV4XDb1S9CEZRw878SRf/hYe4
	p7cfsAqu20JZSfAY/8REPUNHkSoYTv+wULmXv6ILl65k2MUeXDjeYBUDTn5KXs0jQygzV1jJCaq
	h8jDlGun2oIfMtUobS1UrYRj0sXUUV/y9BRq6dP6dwzAa6y1p6M0Jo8gntHOOqc51eQ==
X-Gm-Gg: ASbGncsZbMLay8DLBwsPce8AlmsVNZPVDrHXWwC/sHdKcpM53+e4yD3pbhP1wnju2zD
	hrsmLwx9mJvaJbwwccFSD09DAHon+cyiXqqVBQzTT7xy9zEKf60jdd1i44rB04PKCJjq2TtV27c
	sm8IF4btVP0OyonVpRQH8LFa5MRg12qSIZMliIdd6ER9QM/Lm8ycekOrlV2P3WxOZnWC1a+zo5R
	u7ih2yfM+mIvTOfDceJKqtDXrjbfZL9AAThxMhiQ0zBxaEmFD3atcxcRR3vXXk0ks+y+NIAMI5I
	FoT9/lVKmdOLtrajTlg7LQLn41AcTxJ9/pQ9W9c7P151Uqe+2Q==
X-Received: by 2002:a17:902:cf0a:b0:216:56c7:98a7 with SMTP id d9443c01a7336-21892a53c03mr320035ad.53.1734034327001;
        Thu, 12 Dec 2024 12:12:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQnkV60nuXYwfd4uSDUWCeLS7eRkdx9f0zXNnaVtas+WKnSX7+ic35la0rrPuCP3CL3PVXbQ==
X-Received: by 2002:a17:902:cf0a:b0:216:56c7:98a7 with SMTP id d9443c01a7336-21892a53c03mr319665ad.53.1734034326636;
        Thu, 12 Dec 2024 12:12:06 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc305dsm1696109a91.52.2024.12.12.12.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:12:06 -0800 (PST)
Message-ID: <e9552968-64c2-4e98-bbcd-37a7498422ab@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 12:12:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] wifi: ath11k: Convert timeouts to
 secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
 <20241212-netdev-converge-secs-to-jiffies-v4-2-6dac97a6d6ab@linux.microsoft.com>
 <27cc63e7-1a63-4ba5-8c7a-12a78ad6d9fa@oss.qualcomm.com>
 <cc1d5e08-92e0-46d8-badb-2a61482200cf@linux.microsoft.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cc1d5e08-92e0-46d8-badb-2a61482200cf@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JtAj5IcgdEueafrU4PmpAvLNNAMgFKBj
X-Proofpoint-GUID: JtAj5IcgdEueafrU4PmpAvLNNAMgFKBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=859
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120146

On 12/12/2024 11:17 AM, Easwar Hariharan wrote:
> This is some sort of weird interaction between b4 and git send-email. I
> used git send-email to send the patches after writing them out with b4
> send so as to edit "net-next" into the subject line. It's good to know
> to not mix the tools in the future.
> 
> I can resend from the branch with git send-email directly to avoid this
> if preferred.
Note that if you have a recent version, b4 prep --set-prefixes can add the
tags to the subject (and keep track of them in the cover letter metadata)


