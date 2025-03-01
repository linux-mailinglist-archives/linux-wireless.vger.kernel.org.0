Return-Path: <linux-wireless+bounces-19632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EDDA4A8BD
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 06:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6505818915AB
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 05:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FC01A841F;
	Sat,  1 Mar 2025 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3caN278"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD3E2F22
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740806157; cv=none; b=loiYAde06lvMWTEdyEXATTrGvKdUSqBXN5ztu/ANMYmaOyNJtPxpZdWaXd4J+Zzq378Ld+6rQVdfk4aaGBrhhScx6VYf7Mtg1SEUAtEh0jTkTat9/XqLYtLD4jz0peM7+ioLBVTaIVrf+GXusy/8o5vQH/neHYDYYrBjh5BJUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740806157; c=relaxed/simple;
	bh=w3JPTo1X7xuDHLlZ8a/6rNzRq60vonQcCBdiCGgJoG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWhg863Mn92pYTMnnOZUJCGu8hnmIFSR5JqFtiqGYyOaRpBq2w/e7Phyb6A1dRRVBZ0NbCvVawqSlPhG6fapnHTZA0ujnP6gtHnBRT1Bca5xinfQpm0QZsCFV6WEOxT0J6uABO9RVVhkYlPLzFbGeVoDUxzfN3gDbW75bhm9hqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3caN278; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214ld8N019801
	for <linux-wireless@vger.kernel.org>; Sat, 1 Mar 2025 05:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BQ7oIoj1Kqr5z8/bVwYBJwuROLD7SBJp1FOO5JjySAQ=; b=k3caN278fJqtyWJw
	/SbNTrIzDEX42EAMR7UDpohxyiVtiByi8MXHTehpLWHBl/dMGNXeCSIPNzccB0WN
	CgL4cOvrGdF9UwyWKTijOvPVl796APgmuHgelEdcauIyq3nnw5+sxYWg3z50PkSf
	Hi95ph3Yi8DRXR5Sh0PyZydtZShlBjNLCM5ZqlaRAWWWEfsAHydZ8W5LpvQu5Dbc
	cjqHs1u2Blz7215PHPxYddPk4EOMwXiK5n7EQVLZSAvNOYdPZ+0Znfzal2wXljGO
	C5bWe7uJChe7hWl2kgKhiwyuEeYKhvkp/rXG2tpq3U8DvshhxltrSQBko+edZoc8
	bdh/fQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh701ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 01 Mar 2025 05:15:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2feda472a4aso451803a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 21:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740806154; x=1741410954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ7oIoj1Kqr5z8/bVwYBJwuROLD7SBJp1FOO5JjySAQ=;
        b=aF2M3ey0r4QUwUFI/r2u/68geZ2yhzRV4jfsuTt1VpmGFmX36qbXuU5UDocg3w4okX
         nWJfD7OP0cvvt5NkUSS/LQ92a1b8/SQZ5x2PygtJ8dfNB+9xkHpL29mYl51yqnAMgAL5
         pSRdJGBWaWr74cZCr1DggHkc6q7YW5AumC23sxWLnSaI786A+UkKdnWXGkvIDjQx3y3s
         7F3hHf80NLey/GVcsakdSRSgsOpIgTeQR0tPN1BSrvN1QJlORpCezLHOx1T1Hjtvzc0d
         jOz4n8Mkf0vX7fpS3OVeRcsiuRfhsTGtcYmiNPKhN5MZAFdivHflMnsPH5Dx043HVKfV
         Z94A==
X-Forwarded-Encrypted: i=1; AJvYcCU7+biMEPMiIZ/QeiE7xN7UYWywMQgacO05jJbiun2BV2qeJAH8mXEeydcKiaKrf+iVzIfHP7EqBIpD9O3l9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02Q1O9XOVXdk473FIrDHcM4MdEFsk3S4GHXyP/8xPm/WdfGEL
	ORskxyM7HETN4hFG6cZ780hkOviFx0YOXLkwItMPbm+JJydNu34FEUntoNY8lBXLBX9rTCx6IcB
	wngQtE5uqd5HDNhh+9ZUwvU8ckc/Bm70lBwQTiwXDsBJXDYhMaSFCsUKoqrnsqEDirQ==
X-Gm-Gg: ASbGnctVGeEtvNq0Hj++6wGcj+CTXPD3rpBfI3q4jLsMY3qcRR1Zm8J2WurBF3Ojl0X
	lsguRAg7up1jmJkG6rIjPlCw1WtUodeiAxyoSK9VEQ12k9dZD2uQvM+g6dEGdNgi7q/iFfgvK7Z
	FX1M098EI6Cn4tYzdDDGnjhymUId7WIKHAPz3Kuz3m/IpqIhN2uSy09PW2IVv+gjp/VYhIcDTah
	oVbPS2JXA6yl6IIBkh9ZzTxXCori1K5+R4RsGd75UdQ6H0m693ec+dYaTgVJHFnU9c0cJH1Zy7w
	JWg8tfJIfHpNCTotAjcQJTPG/f3KTPRBY/dRkDuXVu/+ePyFP46fTileMwEQCJQ=
X-Received: by 2002:a17:90b:4ac8:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-2febab70682mr10656997a91.15.1740806154548;
        Fri, 28 Feb 2025 21:15:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOxcKKcRuFeIE4LwnVNuO3M5Y/CqCenqjMe0/49M1rib5aLtbWxJGNDdDM518EtbC6COo0Fw==
X-Received: by 2002:a17:90b:4ac8:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-2febab70682mr10656971a91.15.1740806154218;
        Fri, 28 Feb 2025 21:15:54 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea696e39csm4719697a91.38.2025.02.28.21.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:15:53 -0800 (PST)
Message-ID: <88f8e029-72e6-06de-34a3-beed36a57451@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:45:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 09/13] wifi: ath12k: Power up root PD
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-10-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-10-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1kOg_0vWWBniTTecFm0BayerZYWH_L8j
X-Proofpoint-ORIG-GUID: 1kOg_0vWWBniTTecFm0BayerZYWH_L8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=754 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> 
> Q6 processor acts as rootPD, other hardware like IPQ5332 which are
> attached to Q6 act as userPDs. WCSS driver handles loading and booting
> of rootPD, while the ath12k driver boots the userPD.
> Get the rproc handle from the DTS entry and boot the rootPD if it
> is not already powered on. Register to the rproc notifier to monitor
> the rproc state, this allows ath12k driver to know power up/down
> sequence of the rootPD. Power up the rootPD and wait for a power-up
> notification from the notifier callback before powering up the userPDs.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

