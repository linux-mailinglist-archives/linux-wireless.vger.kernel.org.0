Return-Path: <linux-wireless+bounces-28469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE63C28C82
	for <lists+linux-wireless@lfdr.de>; Sun, 02 Nov 2025 10:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2941883E17
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Nov 2025 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3D725A623;
	Sun,  2 Nov 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAfF+9CW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qa7tX9HC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7871E834B
	for <linux-wireless@vger.kernel.org>; Sun,  2 Nov 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762075316; cv=none; b=nn7frYVdbko8Kc03gaM/zuXneYtC0SOBR8KeG5PZOKLCKew47PJXsPn5ZmlyvKf1Vc3GSJgs/nh8a83JFLaXeMeuOTxAFv0vac8LnyENtiK6Y79Sdg43rH/6rOebm7j349rcVV+wIMhLHtuFOSEGhDmwCEepZ7JUEMXDRDy2S9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762075316; c=relaxed/simple;
	bh=17mp+J9b9ZRdNDDB5GHhXpTZDLvIrOjlqc19XX6LDoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7Uuk+HvXyzQRk58ZQ3RNg3mfFaYO8W8jsYaPLxdcnQqsi4kcTeyv/C4Z0UD0p8GmXJ8KinV6T79iwfM47k6ReCl9fSYw6xwksbeEe8kv0lWQHukNzBpNafDpvu/h7aQFNNQ5DgR/BtU8cbot+cBzy3gBb1YI2EtMA6yuVVhSdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAfF+9CW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qa7tX9HC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A25U1JY3684623
	for <linux-wireless@vger.kernel.org>; Sun, 2 Nov 2025 09:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pAk65/6oxj1521SvgSULDG1z7UA2kHEPOczJdwu/uSw=; b=RAfF+9CWZNC17iOv
	nqBHywMnDHORhhei9L/R2XqBT2VUNligWR3myLxbxcOmto/7T7ZMtrtvHllilCDd
	fVOVNNnv0kGpnfgjgB5aQ3xbWhleyrUGUrO39Am+ASuZbnZhfbsAk+oWR+0R1oWP
	ueQLys7RyuNx6pdtLmtaMQhU+K0Pab4lSsheheVZxX6kEAxFPmgVOVQTnUSQGJdQ
	bdQGVNHmkJ28RlC0vN1x+NEu0CCE191Tv30tsj1zOMZ++wFa76sg4zwQJ6D0Wn3K
	avGIJnraARoixUbIfKzAtkseD0CSsHltKotmNDIjAEuYYgVoopLIN79YHinvGDVQ
	21O9Bg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5977a0pd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 02 Nov 2025 09:21:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-783c3400b5dso2360522b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Nov 2025 01:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762075312; x=1762680112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAk65/6oxj1521SvgSULDG1z7UA2kHEPOczJdwu/uSw=;
        b=Qa7tX9HCAOvObkHKBrKINyXTo8HjPGo1CXWM6bMim9jQwVEBkZvjxC69iEqBr5fp/X
         8XbJ0UqUdGZpx2cik5V5lELguirOLCy6sR1hPEbcpuN8MZDZM1BreZbxr7nQ/BchMLQ+
         Xkw8mlX5Q6hgr9p9jskKIF0oGkaz8d0lHaGsjGrTC6gMZGawsqg3208Yb0Y+WwMTmk/Z
         QAEgcYCm3nozjtu82vzBEAX72FA2ji6F60mnz19fy+6xmjdETphPrsxaPTLDfODukOL7
         q5f528Y3Yiad2JPiyl+/jqqheFxMO9Ls2saVOcEtVwmQ3/e8N7VvE/6gewkLF/AM920p
         Tsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762075312; x=1762680112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAk65/6oxj1521SvgSULDG1z7UA2kHEPOczJdwu/uSw=;
        b=gvSjSVq6YfAsiOlIyl7Losxc/nogtSXKTRedle/9HywWZu7FdQCTOLiTsNcNnaO/t+
         SytYEpU/OzCLvmrEtkSl/iBXY92WW47J6+SpwQXXt2i1ttKJO7UPmTg4N9wwaj3diEzq
         Qnd3i27q1zpb4GMC6yFgt9TLyZe+OXdeDxkJ6MgtXJOah5KGfJ5gIebhB2mw8FSIa3Y4
         OSS3dGdY56Z53eXzhQuZHUxxXEQcfTcDE5RI8ijQlgG41mTMXSOWqX71X49PS8F6Ns8r
         GHAsYIyMput+2P/G7kcqlgNfZ926RXd275omXIBE339DQYWJk6z/FKWHp85e6gc2PgTK
         eE7A==
X-Forwarded-Encrypted: i=1; AJvYcCWsKorNVsxCUWbaF00pjiD0Qa7fmwrxgQMk9+icXpOYkkKoRUcxpdsjVQm+dR08TsAgtDGcSBJoS+32u83gvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrO101AVgWTIdj12A+hawMaQuPb3wIUQW6lcwolTheXF/MU70B
	xJG7CjdpcEoiA4lrN4u+7ZQkYYJfl85iyMtTg1ao34Lw3QmneBugGpKXeW6qf+8ew5SgNcgbb17
	n31LyqkschxQHv1DMc9x93fq/cdJ9y/gzgKhbtUJTSMNkcdmPsxdWP5ILaXRkqtwCKjl7yA==
X-Gm-Gg: ASbGncsS/mE70S3O/UZ/EHcUrBPLgF1ki7Z47QAlkBJo0l160X3sEtOTRvgSyfMDC1C
	F319E5bppvVJZTzD17DI1Hb9nfc3yQ14SKil+o1TB/kChUBJqkQfKod8W3la+Lgdy1qlvbyEv0v
	COiZerGdnIQG18INLm5lM7E0F0hXx7Ysg9mojLUIAryPbV2qOpWDgzYQ5vXIPYlN0ehmiDjGd3/
	9Oo82FugUCplPIILT9ra7mlzwG+qXgaffp4qrKsbUeueTOwK+c5Ci81ZXzVeTHkqDyT6nWB8/xN
	tt5RjHDeeUadWJqHKMXzwtOGqbuTPsRyjX30RFeB/fIMfzJjUfv2IP1xZtisLvAGuh6x8Zp6vgd
	BXMqDL/3yoF28QeSJAMXFFmuf+smrlP9zSoV/z41rG8Fs3pczWpp5xVXJIjHijRKs
X-Received: by 2002:a05:6a00:4b4c:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7a779eefde4mr13299235b3a.32.1762075312396;
        Sun, 02 Nov 2025 01:21:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcmjVi+40dr9p6o/3hoFcMaPlDSC/vKfYhfoR5jnlpypTGY/GIWuBn/J1+Vo8ouKI8w+WRrw==
X-Received: by 2002:a05:6a00:4b4c:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7a779eefde4mr13299221b3a.32.1762075311827;
        Sun, 02 Nov 2025 01:21:51 -0800 (PST)
Received: from [10.133.33.28] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897e862sm7580857b3a.8.2025.11.02.01.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 01:21:51 -0800 (PST)
Message-ID: <0a05ccf8-8850-430c-b008-52b3bc2df431@oss.qualcomm.com>
Date: Sun, 2 Nov 2025 17:21:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/6] wifi: ath11k: Register debugfs for CFR
 configuration
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
 <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
Content-Language: en-US
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
In-Reply-To: <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XwwD_NMtPxTHLjqqfLZp3eI_x6jc4_yL
X-Proofpoint-ORIG-GUID: XwwD_NMtPxTHLjqqfLZp3eI_x6jc4_yL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDA4NiBTYWx0ZWRfX7Km26uiN8G4A
 j60QCcjeB3C2ypeKR2pEICNYP/jBjy1RBLEt3fETMZpfJ1vjcQTMe4wxphHqo5gCBjwAtF8tJk3
 8VX3Z7AmMFnTxomAqGaglAFSrFX9+BrHea1kymhI9narjTgazHRqB+oeiiImbk5ODGU+6OR2LmK
 b6Eeh6mbaLxF2blrKbqdljx3Gn7SFgKSxiPd+DQk4xFoPXijplRBcZi51gkNg58zcoangtIe3Yl
 wmIxNOCThFK+cGkeeU7vBEQ8leTk6u+DD5E2ZjUnDFWg+aGkQZXsIsMHIg0F00McJDdmkLVoVcD
 LbKdqmXMtHTVpcpwN8Qhe6tg3Ajs5323/68IeIxCWrlJgRBBdV9b3larLel/E9WQk1sNoY+r7kz
 ixUr9Ftqi7Jun5AmYk42RLYOhjX6uw==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=690722b1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RlJQG4Jwgf-QiIBLNHQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511020086



On 10/31/2025 10:43 AM, Baochen Qiang wrote:
> 
> 
> On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:
> 
>> @@ -88,6 +275,7 @@ void ath11k_cfr_deinit(struct ath11k_base *ab)
>>   			ar = ab->pdevs[i].ar;
>>   			cfr = &ar->cfr;
>>   
>> +			ath11k_cfr_debug_unregister(ar);
>>   			ath11k_cfr_ring_free(ar);
>>   
>>   			spin_lock_bh(&cfr->lut_lock);
>> @@ -140,6 +328,8 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>>   		}
>>   
>>   		cfr->lut_num = num_lut_entries;
>> +
>> +		ath11k_cfr_debug_register(ar);
>>   	}
>>   
>>   	return 0;
> 
> miss _debug_unregister() in the error handling?
> 
> 
The documention for debugfs_create_file() tells us:
  * NOTE: it's expected that most callers should _ignore_ the errors 
returned
  * by this function. Other debugfs functions handle the fact that the 
"dentry"
  * passed to them could be an error and they don't crash in that case.
  * Drivers should generally work fine even if debugfs fails to init anyway.

So IMO any failure to create the file should be ignored.


