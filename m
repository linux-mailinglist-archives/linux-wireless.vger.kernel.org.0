Return-Path: <linux-wireless+bounces-24337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBE0AE349D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 07:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8E13B0681
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 05:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD40D1C84D3;
	Mon, 23 Jun 2025 05:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AqYwlgEa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5017DA6C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750655580; cv=none; b=U1JpL+omqLRvHZTZejGweSlei27GWB8JjjVxfueCZD2U51G13E1KKeXw9nja7SLoZIKjkMoneY03Rb9HMk+SNqg/rd4/G5rPX5WzfIplp5a9CMgEQorwWgolblQ1K3MNt7dPhzJNB+p3zzRB1N7by0wlQEKFSsOuMTkpPRv7ynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750655580; c=relaxed/simple;
	bh=A46gpwSEP4kUMzfPWhuitAJbntm/7Pb0F+mQqwos5qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5sVLifPpuhmRslYEXBKLI2IjFbutcPStvdXcwYkotfCnCI28MKNrNgp7BAej6F4XIcRk48Kw4f+1IQ6668kTvZa+yVlTzVEATvFfEVdHa5pgg74/VPgWXmlE6t8ovspmYc+RfLmIJ55aWONw8DDgUuE7hlhU6lxiipcUfMhtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AqYwlgEa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MNamiE024087
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wbAJSs7e+W6DSkxYogWtOVipiGhEsI4VPHyrkWooCW0=; b=AqYwlgEayfWvPnUZ
	d6x5x6d0DcKHTZ7Yakl1X4ScboyOOiAUIHo5U95rJiRPB884V5iCZ8xWiFwuQ944
	ehhEOPgqjdsFzEnKgTdkD6/Ao21w5JPFWbTGm9wAo75N3uOAG7zmm5Q/CdQn4OWe
	bfmkixb3nw0ZUfibCkcmiaqLmAEa5Iq3Q5S4MC8Ps4WGlO8CBkNcIHEgff8h8B75
	jMtKJPwXF6MeVWggcsf6XUXcQRoYotNP+X/Q9bLO8QD7Jp9DxVB5UzTrRCaUBl7h
	SRBREGmbT/qUJ437HGjmjYBVoUqynBp3gj418BiAmOKJGvct9lwXH/z63FclSfCX
	TMOHmQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47eh1fs6jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 05:12:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2356ce66d7cso48631175ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750655576; x=1751260376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbAJSs7e+W6DSkxYogWtOVipiGhEsI4VPHyrkWooCW0=;
        b=QzxXa9b+DYsNWjHctWKYdWwR7aqu4WZEgyyjHmt4aWJiZpv7Xj1aGfeBxx+CWKYLDL
         9iTRIFyUbHL78sDvEKbZ/Z449N4Q64iyAwnxyrNStD+Qtygxn1gCa3Wr5EwZavWuYnrR
         CUOgu/RR3h8jH8y6Qk/lO1crI/ToywrJEzYpTfA3fZlB2wItpzSsX33Uwa0Jf+0azdRL
         Vg9J2jU80AaY8bvQ1FVCtr0PV4lEd7h9xO1arB0L00ZamJyFkQPe9Cz/43o6AD2X9dJb
         Q8TZPsEImed9wfVu7Jnmhx1kgltQ9EYMy+CU59hLRX+DGCzfWUAaUBFsoASwio/ySMRP
         xadg==
X-Gm-Message-State: AOJu0Yz66DE46C4A8bRL4xTVAYzvq2H7zXkMAjXqU+j3xzw4bYKFEY5b
	Dlxqw3+OAbnB3Clrb0tBbZRI6Yzt1LFVU70YgROfTfZf1c15/TyifZbEOuAeRlTPkUMHLz464vd
	CB7mPhO8sYd5kycjJQRPNt+r1Ai4/oq9oDo1yRzYwP8Gu9d2jNKYUorNjYsOeljK4Zcc7cC7mgR
	XR6w==
X-Gm-Gg: ASbGncsVrR2IFyjzTKrFQ8NKUBe+yra24HPRpvX685mFpCIrFGK6+Brm6Vu8nwowKUu
	J2klkF4STVdnCS+PKo5cMQZBlDWdcbxgrliSs2FUw/Rfw4iX7J5CMX/fPXlI5jfzs4ffjdg4rld
	PS8EzyTPLwhmwW2WnUvmjFYIbRH/UVwzTODmWkYa7cqhEzuOCiXsx/BkthIZssg8aNHwnvpHuq6
	nChy+SO92KY9hTod9KJf7Ltrxloxe1SFRrE2W6YYz4zaCtgAU7cDDe9uwBi1H1XDvddeRAQ2xq9
	PeaQV+WXXm7mtplO/7dv/lJBD51WhMdIOm2xrbbdPG9XmmYhiD2ZMcoQfK/k0S4N
X-Received: by 2002:a17:903:4b27:b0:235:1706:1fe7 with SMTP id d9443c01a7336-237d9779a73mr171741445ad.4.1750655576480;
        Sun, 22 Jun 2025 22:12:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwMZ1SQmGpw1GCwWrne92h5uRBiJ7YyYVhZ6BaiiirHUJCGrrpZsIAOqwQA0NjRo2sQWgAsw==
X-Received: by 2002:a17:903:4b27:b0:235:1706:1fe7 with SMTP id d9443c01a7336-237d9779a73mr171741235ad.4.1750655576107;
        Sun, 22 Jun 2025 22:12:56 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393275sm74674125ad.39.2025.06.22.22.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 22:12:55 -0700 (PDT)
Message-ID: <954d3235-0fba-6208-011b-79cebeecc0bd@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 10:42:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Enable REO queue lookup table
 feature on QCN9274 hw2.0
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250609-qcn9274-reoq-v1-1-a92c91abc9b9@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250609-qcn9274-reoq-v1-1-a92c91abc9b9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aflhnQot c=1 sm=1 tr=0 ts=6858e259 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=hk8jstzJOELweJxXsYQA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyOCBTYWx0ZWRfX5iqsyKOXg1F6
 i8R7vNR6sDOKNlrIrCv3bQu65cy6UqcqFASw1Eh+IYYTFIiwphUc3EpiBYJQBfHj+cegrnWuhye
 xm11PNGiWThnmKvAmPpf2pezHmquGxtOJ8guEaRH1qcWu93wVy4t9JvPRYM2011VFuWp8CTgzTv
 CdyN+0d+HyzNpBmsKeNpnPUSZW+KSTWTX0Pxw95xsebPesslHQdLjH/3k6MGnX6sixCOhLtFPxD
 3emThja/PNGBDF3u3MmA/Gi5N8eotBXa7N/DaF5hqqFMyXujCmwJF2yVhSIR+ClZGcRAFuqSdNM
 /JGhoySqhJ+VT64rJfidj2L7Stn0aiv8yCFbJvIeD1l7iOUBrDUyk54X0eUFXffW9siVsDCQqOk
 rGh/rCwK/r2TlfVieRY1nPbfiVBqDq0Z4fL1eoJOPqMRYDR1IYKdXIPPJ8ByAjIGrFOBKvU4
X-Proofpoint-GUID: VOaBTDoPHfdKGEVCNmhcQ6Ml9-HXbIaV
X-Proofpoint-ORIG-GUID: VOaBTDoPHfdKGEVCNmhcQ6Ml9-HXbIaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=876 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230028



On 6/9/2025 8:48 AM, Raj Kumar Bhagat wrote:
> The commit 89ac53e96217 ("wifi: ath12k: Enable REO queue lookup table
> feature on QCN9274") originally intended to enable the reoq_lut_support
> hardware parameter flag for both QCN9274 hw1.0 and hw2.0. However,
> it enabled it only for QCN9274 hw1.0.
> 
> Hence, enable REO queue lookup table feature on QCN9274 hw2.0.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

