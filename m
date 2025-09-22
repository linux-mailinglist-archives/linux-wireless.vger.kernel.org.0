Return-Path: <linux-wireless+bounces-27585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D680B91B21
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E585D3B12D9
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF927219A8E;
	Mon, 22 Sep 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EEqJ3DlJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156491EDA02
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551250; cv=none; b=pU7/B8ufwINnIl4Ttbo5FAAGSpY29DpMOpjX7V8rkbt3SJ+hjFp3A+1e/o7EBikOw5CEUUd6MBEyHhLzhynHFFi7W0O2Qew6/UuGbbLptRiT4eqTgQUNBk4hEIyngdYhHNXTl5nAjkcpMhVZTUYu+oh4SlY/0BfkavHuS9XfsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551250; c=relaxed/simple;
	bh=p+DYY/6fj+Fdp+4xx5oswz4SUhx09sEWuzlwt6GtrJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJqPaCC7bwiHAx0cyT96gxEZ5lUJ/AJYei81BjCPMwnoD3ZoudbaU1gcWnaVEEdTFMbkwN/J+ZFoXXUmA/WQQ+SJdD3PShxnldQ03GHPXHovb/gSVXBrak8REPqiDbBBtNepGxbA1EQPDiDrYa1+WCN93UTQKjH+u+5eiMQzL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EEqJ3DlJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7p4Y6005685
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 14:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fV5JuK1sD/lvBGjG3DhYlCxsRUd3KN7L4n0TphxwgvQ=; b=EEqJ3DlJuMsljbE1
	YLXjX47wCX+El+d/HSKQxOLSkPOYRuaqpzvOuVz8mRWZ+RLpgJZQJFOqlBuPfU2X
	5dRIrbwPztFlDC0cJJblgahYbpL5n4g4mCF7xOKmSTafjbUf55ZSCM7yCzvqJYan
	FweKwrJv1fUeiKmebEfrV5lw9jqcuYG97xIASa3qqJPv9AxzvFPbOr+8WbWCg8C/
	Pvyg5ctx7HPBexcWxI7BAeVzWVUZHDOucn31MtUvylLAfeRGK8pfDkuKJAdVjsfC
	ptudtJD4/oXnGG+V3WAd0HBrrIFqfMI9KXU6LOj78RwbYhnJeo7xXmrx4zFRqz23
	/ea1WQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b2e117ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 14:27:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269939bfccbso59198695ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 07:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551247; x=1759156047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fV5JuK1sD/lvBGjG3DhYlCxsRUd3KN7L4n0TphxwgvQ=;
        b=Fc9T9WCTk0rUU1eI2v0wnAFQdubeKTQwdF99yZ2iMWGAI6Hi6bRKqqpAAf5GPH6HhK
         S6WpcuLn9jFysp9arUZUlxRi4JhC0/7imYcehuYaTI88jwhoKC8FOsst9bhdvyCB4V61
         buZWWhMYZgQ14Xl/nnWlioOwxjSrUuGHO3tr5NH/BVQrZP8j2uRJE0uECsjfCqub6yTV
         MSFnyTcC8Bxt7rJYsQqT9tfveWYW4yDvzmV48CArTOK1ZRo/6MGflQJfbg+ZigU1O1qw
         jg/ANz6EqL5Hq6PTkc0VC5WBC6lDww7oSAC6MVhwDblqmm4NCx9imbG9Xr5PX8mBGIxA
         2ATg==
X-Gm-Message-State: AOJu0YyWGWm5umDlMnDplFY3365Iu1+jFPBtBS5chAfD7WJeV2ayTDTp
	vFJEye6FiRdMdtylCZVQZHbsWYtqsA2AVi9cvzuINT96UZQLy8FGsiKjtVWsVHtg0rurhkdyagL
	nhlVebvEuTXrT4hD7lw5mjzfMxgaJY06IbA3cHAIWNtWznprZ1oVyQwPp10bL4OO1dyyW6pZNxd
	42DA==
X-Gm-Gg: ASbGncsdUqUzk3C5pZWvyvJlCIQxVvQuztLAzO/AAX3XOzz3fsaEJ8CXyNT2fmkEIin
	sJP5OYotc2qM1HYsjvPfrc+T75EDsafwPoS3Fds4QwjMG+RFHMA+cXP85xKkZUKRTbytQPRAUUG
	9LYlTbGkZWbwzEOog0lIIm/1dmSKq1RPZ87XvV9UcNGaWpEI4kNshnoTeCW2dWquwSk97yVVDz2
	Sl8mhHrxUJmzTprQHjcfBVtUZMALitmg2Oh8pPqArYfzf4xMLyYwMFy1RtkIMMOCdtWi0pT+/7I
	xRUsTf8uft3lfe++0K1M3Gk+dfsGolOPT+qGT8p4oU8w2De2d28m0e/BJAs3wM4c4MA/KhWD5TO
	B+ZHzItMD1tEaJz8=
X-Received: by 2002:a17:902:e550:b0:272:2bf1:6a21 with SMTP id d9443c01a7336-2722bf16e99mr115069835ad.14.1758551247071;
        Mon, 22 Sep 2025 07:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnurI6wavqww/i4EDVMJujj3eWajrXl8/5g/qerXs7rQNtYufXniembA5tMmTfhGRq5eJXgg==
X-Received: by 2002:a17:902:e550:b0:272:2bf1:6a21 with SMTP id d9443c01a7336-2722bf16e99mr115069495ad.14.1758551246652;
        Mon, 22 Sep 2025 07:27:26 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.98.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053248sm135186355ad.15.2025.09.22.07.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:27:26 -0700 (PDT)
Message-ID: <2b16c982-90b5-0eb5-df93-465a8c2f4d60@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:57:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: enforce CPU endian format for all QMI data
Content-Language: en-US
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250922061607.11543-1-alexander.wilhelm@westermo.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250922061607.11543-1-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA3NiBTYWx0ZWRfX3pXmYagscTmG
 OWYCHNKgu9tOpoOpTiQRB5clpRyq1C/v+1+GaM8CnDNM87/DFA8EeilerE5HR05i8jdfPqlpLLF
 //zPw2yTfrBsnmwZwASVlXQKyz4WEdmF+0gP631wjkm2lflhMDqM/LOwS8kFKBu7xNl6WyMs1St
 RAkpY5A345WsksAKPOR5Tteek4rRAU26ruvVOmY2Gx8uOroWdvzIAfngD7yNxktgtZi8HgjjX8z
 NJKmTyJWmMfGGWqP+AU3GPiJ/KAkDEmGQ0xjNfRnh7BIZh/A0XNFSu9ExgcU0A3Z4bY+N4znj6Z
 SlTdc1z1tPUv8Jn+7kPoiW0fPQumYAqvM8Gm92TygKCbOof29LS6/y+SLHSMU7v565rFDjcZN4I
 XCVPojcL
X-Proofpoint-ORIG-GUID: -Mju6Rras7QsEU-1_519IlChRwV15dcR
X-Authority-Analysis: v=2.4 cv=HM7DFptv c=1 sm=1 tr=0 ts=68d15cd0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=jURWspusQOjhl1xubyy6/g==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8
 a=iy7eNMHqqS-0pUZEvd4A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: -Mju6Rras7QsEU-1_519IlChRwV15dcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220076



On 9/22/2025 11:46 AM, Alexander Wilhelm wrote:
> Currently, the QMI interface only works on little endian systems due to how
> it encodes and decodes data. Most QMI related data structures do not use
> endian specific types and are already defined in CPU native order. The
> ath12k specific QMI structs are an exception: they use partially endian
> specific types, which prevents the QMI interface from being extended to
> support big endian systems.
> 
> Update the two affected ath12k QMI structs to use CPU order types instead.
> This is required because the QMI interface is being extended to support big
> endian system, and that support depends on QMI data structures being
> defined in CPU native order.
> 
> This change:
> * preserves compatibility with existing kernels, which only support little
>    endian system
> * enables future support for big endian systems
> * aligns ath12k QMI handling with the general QMI design
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

