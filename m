Return-Path: <linux-wireless+bounces-24505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E18AE913D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 00:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE166A04FC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA952877DC;
	Wed, 25 Jun 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DzZsVX6T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97C139E
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891777; cv=none; b=BvfdvlEI0CaMaR+cGDCEvViodq/6Wj0LYYru9yFcGS4YTrOsxuXkrjwTmhe8gouqcz/MDj4dbJ59bbTib+O6fYMq3/AZJJTNT0fnBBN22rcHYVCIG7qYgIfQ5UV+0hf2XxBQcfpodOYNSh6e3zlI35sItuCKfEgeVOTvAIyPLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891777; c=relaxed/simple;
	bh=HF8iVUJz1QzUsQNgUHUXzFhHWT0/wyLsFN060cIC5nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDWjVdO3UV44EMj+P/0tNxRFc/gJV4sOiA2DYargRaF0wmo36zArQ9fgrI33Jx2uPHQ58ApYh+GngvdSFqto9BXJ70Idk2HkmwL6fZnP8jJoJQ/ujgZKlLBxkqiIzadqYWiHOqmsl/OGN1rDAseQ+awPspTSSUyettRrVAg6onM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DzZsVX6T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PDBIUT015686
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 22:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NYXaxidIb6o34oiQEyhpZSqVGpMdSHiutGvzRB5jGiM=; b=DzZsVX6TzJQRs/HR
	bRX/HFFcsIPrDi8G2aPlQdk1nt9qCoJe05Es2nCus5/Um0EoFURMIo22C5Hlpu2k
	JjzyLKchDYcRwLAxE6c6DQTtl8ZCSr8AS6QLlNid6jfiwgtykTfmOLGzoN3XNWuL
	S5rSugxhg92L83UPGKtrNOli0npseIdqyv/S7C/G869I5pgrj0MjWOeGWUCyMBgl
	Xb8F3i2td6retMw8ySDsjiwXv5ciBGAkctZLGy7dH0czNCfucf6CZNnT/8k+SSqt
	WW8cp3leiwDnPCcgB8oz9ctPxwba3ZTE2p1OC3nj0uaqvy0H27YlGXIwVEVm6gGX
	DSIC1g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rq1j6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 22:49:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74913a4f606so371971b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 15:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750891773; x=1751496573;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYXaxidIb6o34oiQEyhpZSqVGpMdSHiutGvzRB5jGiM=;
        b=GxEPpBN6pFGZKVRJ5eptkHQ/QVOcDDv2w7t7PziteCkvoWKT3nt25u5//1eHwA2YJf
         p+Y4x+3ZAVPNiDdhBnEGobCJqzVBLQrGOt6gR7L4fmrJCWSeg2PHWHZtk3Xru76DYBcK
         tlGvPpkyrAiZUPRwXfKa8PKyvTnNqCSDASfXt3yZkbb7THPVxw13XF6k1sAthWcEIvU0
         B9oV6/rb+PK1H5oHbDOsb7/CQ8rBRDQ3meCU05kHa3S5JqvqSXlC2f8JLcKkrWGeNgwZ
         AeAn1TLDo22Rgxwv07pXG++EXAGN8v+Vw32WRQDMp/plZU4eyCj9W4Km3qvsug5SNwdC
         cOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3X9acfnhuDX/H3FRe54BVis5E/wjrlCO87cQcVmRwD3Zq2ZaAm9Ea66CmsC+JuIrHTkwWF90RqO8Wmwa1qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFMgU4CElhziXl1Dvsz05KPrI5qRNmY+0Dmtz1f8DooXryn3E
	dLDSXXMFVs1H/+eAvqhw88xBaci0P67qj3/sXkwKl+2g8YCepc2h7Plzsq+EN+W2LQzPISgjaPY
	QLMw3qwI5bDyQJObfkSaxzOnYm27BhNqLtMkyOV7/eEBFcy9OiU/kSiP+v6HCvOPD2FH2TA==
X-Gm-Gg: ASbGncu8IuM2n/Q30q7p3+fgUSXuOTkELAdCPCnbfA0zXNzvkOg8+YHREt8qQOjlE52
	1qD1/vEu2zL+182lojMlqnRyEiz89u2YbDYJ1I+MhKDzhnAT9O27vr4yblEigLFX+Q2zjYiBZYc
	orS+gpwsP/pI1iuR95SBsdutiaVarlzWEK4UX6pVIk4XpqlTgRDEYiKVmIBOiX34bcPyM9SAODW
	TzHoofQl8Ae/O/BBa24Mkdv+MrX4gl4dSaF9vT5sINR6irOdCIhG9Xe9iLYtbX+6EWpmIY0EiPI
	amkTDNdlciyfzPjGMlvpyO96TI2lJWXX22EyI8bZwcd9zgBh3nrBQHsPUYgHxJFIS3tK4OURm0c
	htZBcacRNg6dDVuw=
X-Received: by 2002:a05:6a00:3d16:b0:748:e1e4:71d9 with SMTP id d2e1a72fcca58-74ad45e6addmr6632844b3a.22.1750891773221;
        Wed, 25 Jun 2025 15:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE54s5I4oNaz+6DdNq5r5PUAHS80ExntzXwuXQWgZDeiN9B9Uwzx03BnRvYfw/dYhBnX/LtMA==
X-Received: by 2002:a05:6a00:3d16:b0:748:e1e4:71d9 with SMTP id d2e1a72fcca58-74ad45e6addmr6632818b3a.22.1750891772820;
        Wed, 25 Jun 2025 15:49:32 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8872c7fsm5252175b3a.167.2025.06.25.15.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 15:49:32 -0700 (PDT)
Message-ID: <35619c11-71e8-4372-b38f-7f1754c777aa@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 15:49:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
To: Johan Hovold <johan@kernel.org>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gregoire <gregoire.s93@live.fr>,
        Sebastian Reichel <sre@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
 <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
 <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
 <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
 <aFwOVGGHOHbko9So@hovoldconsulting.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aFwOVGGHOHbko9So@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685c7cfe cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=LVwp3io0g4xlkmLrWVgA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE3NyBTYWx0ZWRfX77DRMKFToiOl
 cVMg+MyTbrv110r8u34zkUrr2TM5X7FuRbsoYDbyXpksV7U/6UHwqyXMDChQURj6ZtOpjOIomBL
 KRg5PFPsh3cVcaVK/jnDywrdPZCKKss1LR6V4cHHnhdc4TxCbqZ/uU7GhWgqDUJ/ysgsgUXUihR
 f3Jqb0EbrqVhX5O9YSovXG9Mj5WcmAPZgC74L9XGm52sDUV8NZ5aVPuDNJLfcakzYAyap1vt8u3
 DLtvmT2STPPpNjePNnyJl8/OyqVFUsDsN++VGGl/7sMCQWxJMlmD1D3AcyZpI8R19nRa0V3Fz3M
 /CyLP3xSqIypQsqqXnv2tkcw22LP9KAo1m3nsWZ1A0OWpb5LKphO8j54f7xFsOn8fXeHePtQoku
 J2M83RmTAx+ZC+wCknWl9vT7p20jxrZGpM2bBtirKJ/zfJTOe54Y9TJC2uyLN6fs65ccgtaB
X-Proofpoint-ORIG-GUID: GIzpsIdr8xKEUklVNo0ZtxxnW-NXTsha
X-Proofpoint-GUID: GIzpsIdr8xKEUklVNo0ZtxxnW-NXTsha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_08,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=828 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250177

On 6/25/2025 7:57 AM, Johan Hovold wrote:
> On Wed, Jun 25, 2025 at 07:48:54AM -0700, Jeff Johnson wrote:
>> This is a 0-day issue so ideally this should be backported from 6.6+
> 
> By "0-day" you mean it has been there since the driver was added, right
> (and not that it's exploitable or similar)?

correct

