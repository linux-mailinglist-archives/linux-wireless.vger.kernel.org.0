Return-Path: <linux-wireless+bounces-24341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40680AE351D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 07:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FD27A2505
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 05:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B641C84CD;
	Mon, 23 Jun 2025 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzSpZJu1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27251C5D7A
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750657453; cv=none; b=eR6snzFlofnptR6saDifarCellqFYtBzykVK2bkVCeH8OAcATM911TnUOiyYVUeMyI/6cuS/RH+00oxPgwvCxGWtDaCzEw2cACjGijfkBGgSreF8VSCCjxcn3PbvfK5eUV0/i2wwnmznxsEbBe7ss8nuMQR1PI+HuF83H/d8+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750657453; c=relaxed/simple;
	bh=fbkogLp9uZr5f//hXhJ5Gtx3cE3QJe4HM7LwsfeOrf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MefBNLckRzkB/gZKB08rgouHVOBzD+pG8gRSaRy/q0oYJZ1NlLIggCJKbv3gZhhtcPefiNYuGyVsz11gM5vUCsV+rR1uhOFZ2VZvt4bNXknx8/KvL5zQic5WFlMgYdvNgh+N0+jjkO/3kOt6mUlWgHomGm0ZK8j79nLllZZPvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzSpZJu1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MNJEHL012665
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZE1jK+fran5zJP4vF84ura1eqbV0f9kchFGUeeWMxCU=; b=MzSpZJu1ChJfEvGI
	lrYDQfCXjPueYbV1RiTsVUn3XUkd2Iau+NvDIRO4n1cpwO/vaGLSFdjdRDDPP62Z
	aFHaPF+WD8VwbScs8jhrG/mVxrdLGLWu0epyxrGJ8zdmjo/o0c0cxMugpchgELvH
	o1YLS2R96K1DlpOyKeFISS/3RRgdscPmF5NRhc9SjYpl8FSZZ5xWewmYELa5E7E+
	CfjaAsWZqElGFbbgBDk2r4wQ7bMZDfXZs+6eguPoQkUfFbMUEtJvFAiqbyWPxD/t
	Oxkao5la791MVc5xo46kQhm0wWhC1cL1YRq9TcJVC/QQ9zSFMPIx63zGA5FbfMIL
	X9vZwg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47eud08kq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:44:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31bd4c3359so2354510a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750657449; x=1751262249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE1jK+fran5zJP4vF84ura1eqbV0f9kchFGUeeWMxCU=;
        b=agdlYw5bOZHmxNk8u81buHFpHQSB5WHysLLRxIo8NSDzJhoZr4OAKmPPULQS9u+RoU
         5opEUWZ+XAQ7E9+ZdLYRHoTDlSTrFMIJQGA5xY/xAzzK9UHEfTjt2sO/a7g42/zoT/KW
         hTFtYj2RevteIOnPf4FcPwDUXBrM0THiUzRXVwPBtisY1KeUCJfDhhrBPuiYSbNBAcGw
         w0Wec7SjmznuyQp9/F/IpmwI/yhJJeORKd0t7lnTlDTN8TYuNDtrfQxkmCiaAJEdUcXt
         hwel+csDwecQ0j4d5CY2t8Z13oMa62xZHsyYIkeidrARFlskEyr9BDv52isr0QTzKA1/
         NLAw==
X-Gm-Message-State: AOJu0YxY7ju3lJhM5Q+ppPlBS4jo+vvSlmrBBm97Q3q9YLUnHEEQ4ec9
	x7CYDTiwH1QZJkaSpF+jQnKcaO6TnbZ3xaBTerJpITxDntu7tK+OqD3VxjfPAC3OaNH2EaFkOma
	3WMW1HlGfvpdO1aowRH8W7aaOvl6DVoNdQjPipB4K9nE+fkBNmPZMrNP9ZZSnAmkppBRweA==
X-Gm-Gg: ASbGncv0dFHYAE6B5P7D93AVSTilapQh3+2x/sA3Nrx2oqRgWSKxIdCwR2I9N8BGDE9
	cvuD9QnJju8ewm+IPT5qk+a97a+x8sGzQGl5Ul4733QjfKx4Pa4FfwFoI9DsS8LUCAyiaIaGf1R
	dRiRwOplDD03xYc2i20EkDaDhgoibdPx1I4T86jZmLBV5U25CJ4szYiV3Iw+llJvVGgsq+vdhgC
	EN7GhqVhwUvRMgf0dBy+wlto8fCfhGQWAbFAX8zSI56A69cgPwxG65BOU4yKVBSCo04SV8rtdAG
	iTOUmjulUwaop78COW+t5ExI2byvl85PMrtDhk05NGWT+R/fxNJDbjASm1FoIACG
X-Received: by 2002:a17:903:98c:b0:235:5d1:e366 with SMTP id d9443c01a7336-237d977557amr211329605ad.10.1750657449536;
        Sun, 22 Jun 2025 22:44:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2fjA6yXvbrte46QeaUhRGDd0j4oR6dZsEFJZhHK+trgT9ehHcZxq+DgkT0YeTB9qXSCO0cQ==
X-Received: by 2002:a17:903:98c:b0:235:5d1:e366 with SMTP id d9443c01a7336-237d977557amr211329365ad.10.1750657449125;
        Sun, 22 Jun 2025 22:44:09 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86c49d4sm75260425ad.200.2025.06.22.22.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 22:44:08 -0700 (PDT)
Message-ID: <ed04a28a-3fe1-0f25-0f0c-d5b61f894c25@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 11:14:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: N0MwtVfkF4kibsPKcbyUbENufjyjneXr
X-Proofpoint-ORIG-GUID: N0MwtVfkF4kibsPKcbyUbENufjyjneXr
X-Authority-Analysis: v=2.4 cv=eco9f6EH c=1 sm=1 tr=0 ts=6858e9aa cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_9NqMhxDF2Aqya9w-eoA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAzMiBTYWx0ZWRfX1APUcieTe3JE
 kVV4nT1vFdndEKVoiXa/zehOhJ4XZ4dXk/BSL1EG2NFe5zyeKtDyGRrXvo3O5uc3ZaXeMPzczAj
 qd2M+MgDf23alUWeQ8kcNUhwjqH+OSbdEKqJFPPxTWIjc/WoyD9byqMHLaePjHWM9LpIFMmBNTd
 8hbBteHIDQfGxQk4j1/u3Zjm1zE739NccL6Xo8M/EQC5nt21crGZKMqhyXNJgP5+YGp9BAOSnNJ
 phDSRVMwYMVR4CiFFnV1uH02qxk5QTNnFhQK8e5KEfcP+JInKdq+CbZ0tRIvda9N47/QotfEoiH
 iVHMc1JA0myixkd3ftdTYi+yiSiUpafILyW4huhOJtLr5cB8WOby9B9xho7mYUiJFWku42DcmH2
 zKtmT+p5e5pMI22THHclpMd9Zrpqs2OiXpzh5wW/sJ8SEYn33hvt9vtcflF+Q1FLO6AQW6yu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=894
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230032



On 5/23/2025 9:19 AM, Baochen Qiang wrote:
> We got report that WCN7850 is not working with IWD [1][2]. Debug
> shows the reason is that IWD installs group key before pairwise
> key, which goes against WCN7850's firmware.
> 
> Reorder key install to workaround this.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218733
> [2] https://lore.kernel.org/all/AS8P190MB12051DDBD84CD88E71C40AD7873F2@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> ---
> Baochen Qiang (2):
>        wifi: ath12k: avoid bit operation on key flags
>        wifi: ath12k: install pairwise key first
> 
>   drivers/net/wireless/ath/ath12k/core.h |  4 ++
>   drivers/net/wireless/ath/ath12k/mac.c  | 80 ++++++++++++++++++++++++++++++----
>   drivers/net/wireless/ath/ath12k/wmi.h  |  1 +
>   3 files changed, 76 insertions(+), 9 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

