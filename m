Return-Path: <linux-wireless+bounces-24712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161B2AEF254
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 11:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FCF189FFFF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E20126E70F;
	Tue,  1 Jul 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DimU2Bcw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E626E708
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360556; cv=none; b=YWgm5Ay7/3s53dMHMw2TD7nWyKwCbjjwbGJKpAsBQTNQr9MvwlY0NzB3VtKbLBgT5gDzI2T+vJZPbZfraLqqvyTc/gX+vazgaKpYd91fBdQVMWkFmyqVka4Sz6Ql5p4fePeanNphrlxKryZxkCxogA/H1kV6aOzfXbSowxzcaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360556; c=relaxed/simple;
	bh=g/FdUHAiZQzK/VE6gYjD7Lp++jngAzjwpdCAFCAxfqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6k8jY8q7eux0FPTCqMgC8sc5Xg2KjjjRPGKpd1IwQA3tq+Lxg8BRq4SmCScyVlmugf9yUcLlygiswJiUnkpPHH0ohYjr+6lQNfhlAjaLjIUE3K/+yR/dzmWaFFE41QoDDapOG/VvCgnV+bXfZaM8pd45UUElfDz/C5Ev3ROqFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DimU2Bcw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5616tOAs029054
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 09:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvY40f/kbhY+V/H0eCSj2cTQBJ6utnYzy2Yfq17jbCA=; b=DimU2BcwXXwTmtl5
	XMHNfYLWpGEC8L2/pQEnmbsuZteFMMeMpPMyotsX+s1UXOv58dtzk1iZ67ualYhG
	wDdnvqDJjvFQky+gVY2ZhrdVDKekM8TNmiP81iswmwM6VReDLGaAVKQQ3bBaeXaT
	DR6yITir1TNB1c3/gE64t1We+2HkhSB9UUU/0jrYnb1eWJuPw8Jkdzey7aJ+S3uk
	6oylJDEzpNrrAlRPy8mWCxFlERak/LtfmJ5eXfntetfu7WRFL8zmOfnoGtI9LIxC
	vvEGF0JnK2fdRlKwGFegnGquW+mxBEFvtQy00UyV8dIqZ2ddaYxaHQawrC7dhWlR
	S1vuoQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47m02v24sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 09:02:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74927be2ec0so5064083b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 02:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751360553; x=1751965353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvY40f/kbhY+V/H0eCSj2cTQBJ6utnYzy2Yfq17jbCA=;
        b=MJ2vGmlxXRT+poj56lsaARzOLlTf0soIniVPupofM+XS5U72h12/ygMG62WdQuO3QW
         V8NOpV6HDp++3eGHNl/eYOHNobopk5mYkhFJVUc9TvLOEbebjX7BjHaFmMtKSbj1dlWy
         /FEjr4czo2gVd/xfLjYL1/159bgxHy6dQSOG8obNZ4JyUCkNZ9EVMQA6ndps6QIti8s7
         FKAli+EQSDFlSlFvjkegAPq9lSDPku//+UUP1l2aiwd+N7YxD1PRwMOjLYr9IqOKfh78
         E7xSzDNn537fkuq4TZrISiU2SLVcfrOb/YhbiCG06Ov2Ndq1Zaw2W3FZohF/IczwxD4Y
         AXDQ==
X-Gm-Message-State: AOJu0YwRg7CuKopn65/AQRenNNRcY42mi/2yqo3EJ9CQcng7/rNxvDki
	/lEvXolOwHNb8vGuXSFUZ5orbv8MjOYmHBoZ/b0+JB+0dtqu8MNd8NNcZ/pjTy68emtMUJq/A01
	DGU+BxVwKzCy9WVSiNofc+KG0DZz75TfJcOFvQIytppr7y3q6UV82ing4rEAE8ItLh5NEfQ==
X-Gm-Gg: ASbGnct5Rdd/IH1zlig8gyJdnPeg3vHYMSANvDaz+VDHb15RIrqopNgJFWItTYz+db7
	azBHObqygXNOkFwjxZiOySnQNHX09kX16KjOx1BOV1tHlJBoV8X4+dW8aPoOqrjwhve6CjArH1E
	23MOoBjKM0JGVK+Xz7yELwj+zTR7os3/LnNS+bf8wsZXOmByZilnHyD5cSIr02wjj/hRKEsvwgq
	eQQ5F6Fi5MyGxwq1mw8FgFK1S6HsMpmlRceaBCESIg9SAzQpXU4Fg2HWqTHTTr8dqoAPNmqAc4s
	u997wqMy2omt9f6T1BZlzp5DwoO79q9TqD3aP8K+eI4YqQwLcHtR7nL/MIyQI7cg
X-Received: by 2002:a05:6a00:997:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-74af6e3f46amr25138983b3a.3.1751360553219;
        Tue, 01 Jul 2025 02:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp8rvP4tU7MZFJ/uAQEVvM14DZnqv9iSk8Sdr08Vd7uprZRbxn4m78Otz7bqeh9TOF3PhWWw==
X-Received: by 2002:a05:6a00:997:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-74af6e3f46amr25138947b3a.3.1751360552793;
        Tue, 01 Jul 2025 02:02:32 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57e7290sm10795579b3a.146.2025.07.01.02.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:02:32 -0700 (PDT)
Message-ID: <54744546-1daf-71d7-5cbc-a18d25e309ff@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 14:32:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Block radio bring-up in FTM mode
Content-Language: en-US
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250630031502.8902-1-aaradhana.sahu@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250630031502.8902-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1MiBTYWx0ZWRfX8S8asEp/lFI+
 ZUt6Vr+qqmkXa0odQxkrNDnBuixWDM4n4FU3ELJd21hP2bu02GxNU6CvVaQmtOn+NNlOwd4vzWf
 vpA7/iZ+Kn1rL6F3ODirudckqLXUxY29sUxHEbCLOc3F/PP72oB7xfaAs2DnhikDmVU7Z0P8tc2
 53D4DSfl5NEqibguuGyc22c6qB1MZs8tIRM7Phg7ruy2ZZffZwRhpBzdF63kpIUkg0Lbs8lc8/5
 jdaNjXNtA4uxc6shZU6Vy30R8UdJ2jrhUKLbCp6WEj1uJAsmZORde/FGUOXUX2Yo9dd2ZlJtO1p
 trcX2yPbZcbmCbS6MsosyTSfcTrxgTU74zpfQLpAB43O1T1ibZeZnAK396eISXc8Gl1HMcToEd7
 wZHxhPkuSDLvnJ/eYmCrrXkGuvNSLS8UwnAJ9Ia3X8kusTr7pc1YPkmX+VfUWhISfuzYc/Rs
X-Authority-Analysis: v=2.4 cv=Y8L4sgeN c=1 sm=1 tr=0 ts=6863a42a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=wy0no3_6c23iQZEdgM8A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: o6edCN0v505fz-dtg3db1Bril6_a6V1l
X-Proofpoint-ORIG-GUID: o6edCN0v505fz-dtg3db1Bril6_a6V1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=762
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010052



On 6/30/2025 8:45 AM, Aaradhana Sahu wrote:
> Ensure that all radios remain down when the driver operates in Factory
> Test Mode (FTM). Reject any userspace attempts to bring up an
> interface in this mode.
> 
> Currently, the driver allows userspace to bring up the interface even
> though it operates in FTM mode, which violates FTM constraints and
> leads to FTM command failures.
> 
> Hence, block the radio start when the driver is in FTM mode. Also,
> remove ath12k_ftm_mode check from ath12k_drain_tx() because FTM mode
> check is already handled in the caller function
> (ath12k_mac_op_start()).
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 3bc374cbc49e ("wifi: ath12k: add factory test mode support")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

