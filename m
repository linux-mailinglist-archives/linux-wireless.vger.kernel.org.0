Return-Path: <linux-wireless+bounces-22652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC36AAB9DC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 09:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA767AD7D2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D127E1D7;
	Tue,  6 May 2025 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jk6s5/zG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D429AB1B
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746503803; cv=none; b=nufmuJSApiKZ9GBA9dITvbT49XehSMLNsFbcVwUpj7dMV5CtuxvLLszevXPu+brCUboqRMDcUT+esMnU96/j3X11lDw8KyBvzIPS2D3PXMAtqArNxIGkb9+Pftmp9xLYBw7GADhXnRgyNXEHCGM/Bxu7duu6V0eY/jL2IUcFd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746503803; c=relaxed/simple;
	bh=u7pRzJBbcRwGvzkiy84bVPWls9kocmRvIycSKA4alPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bt4ozCPb/bAktm4vFK/9cqV1ZK8c4LwhTbwWaC+TjBcKAC69N6Fk47+a/CSaH16ZSj7vqS+++19JByLPFCx15j27pblpmikLW/T4wXX7RNQhubTauv3d3Fw1Hgt34NcnbuKBrgCa5Jkvck/M9sl7t9kmkWR+w6cJJMM2WhRiVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jk6s5/zG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545KTjbc019196
	for <linux-wireless@vger.kernel.org>; Tue, 6 May 2025 03:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VssZjjWMJWPdqdH0IZ5tzinbZ36xyqX8Vl4pC5FcHbw=; b=Jk6s5/zGwEMAY4Wd
	QQk95+qYd61DbVhhjMhLFFLQkkWFtQC366KwcuIumU2MRBzuUYx7Kc8dZlptXhLo
	6siRUAWY3DGbR9whfyyu3qdgeKCHQyhLxU9qL0Rq8B6R1wv0jAlPLqOzjFAJ+Hns
	JNkPOnwGCjqyjNS9qEL4ImJDJ0IGKSUidDCCUxdUpSdbV8NBVnTNxSV8NXOULeKe
	G+JLPqZKkOOqfQivyncUWjN7cEQKKftsD2UVf00IL3OSkqfbEgXILu6frjl9jJYH
	i37D3bbOWmXG2XzdbdGTLrYanZ1cuewNDbdGjfrPeeI3UHfMw0Kwxyqu69vcoyep
	7qy2Hg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbwfp115-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 03:56:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736b5f9279cso4265986b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 20:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746503800; x=1747108600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VssZjjWMJWPdqdH0IZ5tzinbZ36xyqX8Vl4pC5FcHbw=;
        b=fic3qTAp64AeTYwhuMLWmdSV+/t+MCsSMagKKU61jojXgG1ZfhFYsmACmPIevaH+We
         8t4R7uiMaslRTFp+I4lEcONku+nICxsshMwSD13INh+r/sr34WGtPgimY9lkjERiX/fN
         SKo79UMFtoCum82T4xPdQsCY/0+5Pg3VwpAvuRiCu1yA9MzyqRsmK/hp3pbYmx5vYJzB
         NLUShOJeWoZM1c18GqbQOAt+y900dkkN7QoWGhHfGyLTfenWbZa/bKRCBnropyZ0A9xX
         W6X+YW0Vt5AmyPOxQZtVDlXerv2IXSdznxWyMMVSSs7aCs8aUDiYRSrQ1mZy1vm6NqQK
         GJKw==
X-Forwarded-Encrypted: i=1; AJvYcCWIc1qyzqdMoAQkOrF6K8YuPbg2ylAoX3oik6Z8CwcpqM/cBQ94G94jIcWz6r8nff5H37wPUNjywq9s9dwCRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUB/nv00jMLVVcJq1XA/hoAzvoHE8dMG2gw8g+VcOtAVl67FkL
	14OyPb8ihC9i4AT3YQGgjOLl9X1fl0eAq3LC/K8qViEg3hLMFfMqkXpmCyOGblkbgAGdf0QIP7r
	uVX3ZiiJ1Xlgbx78a5sTr4FrojDxKRytNjWDvj1EPfV3zWZIz+lJmtUeMpdzEB2vrKA==
X-Gm-Gg: ASbGnctG4XRhQZkWNFkVoy+Js60bDK7n8kf5zSC1xxeeBQ1k0XoJOwv1NGrS2IEI+YM
	ZERqFa97Js5FZy5ITF83584NAeTeWC5NDkQ38yKNz0s8+UEnDsMZRMF+gR0e7cF/LqrkMRqPaOU
	upc52TYostRBE2uyWxwW7TCLx6sQvBD5fqOexbvPpngJxCTJrYSAdHL/plUVFjQ4uWFF30S7jS4
	zZMc6zavWrvfw7TGQuy8AhKpinOPCrFwTlGvx3UctjM7tJPrq/zOiGXadUOQJTpWT3XRmoVSwS+
	2oNbFQrjM2+GeLVrNj3dI9axTGde484JVfpDXr+PrvZ6hbYLw8G0Rw==
X-Received: by 2002:a05:6a21:9203:b0:203:bac4:c6d4 with SMTP id adf61e73a8af0-211823a4329mr2315343637.29.1746503799833;
        Mon, 05 May 2025 20:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbSVcvrD6TYRv9+C6F5mpiHYvymOofSleVgeTUg/fKF5J3cksoI1+ZjlKYg+zGXKNK8MhJTQ==
X-Received: by 2002:a05:6a21:9203:b0:203:bac4:c6d4 with SMTP id adf61e73a8af0-211823a4329mr2315313637.29.1746503799526;
        Mon, 05 May 2025 20:56:39 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3920f6dsm6456022a12.10.2025.05.05.20.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 20:56:39 -0700 (PDT)
Message-ID: <c9187ce5-2ae3-fee6-8b94-19792a981130@oss.qualcomm.com>
Date: Tue, 6 May 2025 09:26:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND ath-next 2/2] wifi: ath12k: support usercase-specific
 firmware overrides
Content-Language: en-US
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250424005703.2479907-1-quic_miaoqing@quicinc.com>
 <20250424005703.2479907-3-quic_miaoqing@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250424005703.2479907-3-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OMtry0qYxVH5o8NiryvO0qIVgZpNnudn
X-Proofpoint-GUID: OMtry0qYxVH5o8NiryvO0qIVgZpNnudn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDAzNCBTYWx0ZWRfX9zpdAFpZNiZq
 5q2PyfaeLXtXJaV/QP89Rdo2tsui82A8iRxI3VL35o1pAzDRHvBcvVPXsnsxnmlc8F2aLxsmvPd
 FZiwz1///O0yoGWuMn/xC86ftaL46WYhriVLCopUMTfjLvyCZciMCJzSyrYdoE7GuqDULaOnm1H
 2H01dgavVS6/oe8j96Q5jjaVTwgqeR+UsurpLoUAbNfVceqkUZAkOPIXv6YZOyUtrHDKA7vaOOj
 1gu+Yp/HRqCG1dH3swfLUUxKZ63VUF57dMzbSHi5Zn2ul8KpWNAp2VSnFZLLqi9C/EJT0z5GLbF
 tEoyKs1g9qGdf7z41O4btO0dM7cRMa1xcO2C/lV6MMqhB8qDcIVVP6Ai9jRaZV6jaLedpm/NQ9j
 70Xm5VDZplVFW71rfkbiMJ90sNiK0S6YFDG3wLZpjQ+fFcJ2FvEo/LdnHXnmpG8/a304mdFs
X-Authority-Analysis: v=2.4 cv=AfqxH2XG c=1 sm=1 tr=0 ts=68198878 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=nnbtXsLSmtPlU79_SnMA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_02,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=711
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060034



On 4/24/2025 6:27 AM, Miaoqing Pan wrote:
> Introduce 'firmware-name' property to allow end-users and/or integrators to
> decide which usecase-specific firmware to run on the WCN7850 platform. This
> is necessary due to resource limitations such as memory capacity and CPU
> capability, or performance and power optimization for different application
> scenarios.
> 
> Currently, there are two firmwares, both files can be executed
> interchangeably.
> For example:
> 
> - ath12k/WCN7850/hw2.0/amss.bin,
>    ath12k/WCN7850/hw2.0/m3.bin
>    ath12k/WCN7850/hw2.0/board-2.bin
> 
> - ath12k/WCN7850/hw2.0/ncm825/amss.bin,
>    ath12k/WCN7850/hw2.0/ncm825/m3.bin
>    ath12k/WCN7850/hw2.0/board-2.bin
> 
> The former is the default firmware, suitable for most WiFi 7 STA functions.
> The latter adds support for commercial-quality SAP and optimizes power
> consumption for IoT applications. And both use the same BDF/regdb data
> within the main board-2.bin.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

