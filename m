Return-Path: <linux-wireless+bounces-17610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E18A14105
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 18:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3252B16797D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C325A24A7C6;
	Thu, 16 Jan 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bcJOOyY0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452F137930
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049332; cv=none; b=AepAQOGGB8cNfq3sp4t/LFEI73U8vip02UOCi9211KoPwUEXBDlHkVqw5jugDzjbY7aJKIZ25zfFZ8gzgTaMB9LpywVB0AcbyooeiCcFG3K2YBqta1dfaCBn2kmzEa1WCVJm2v3iWA/JMat4EfS6CBLTMDZmeYwVl63p+GCFOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049332; c=relaxed/simple;
	bh=zhUXx4gEfGo2K52PCANgM4cTfeRaBUolS1xZn2oOKsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4EuF69sTrf+4D6PvAyJjSEukuMGPZqHbDYPpN9m4JHKocsSnEra6EjgXxp5azOc/DnB4wWXAcDhGY6yl5s3+RKyKVYW1DJgygzz3L8sg1+YMRfuX0xg1vF+YkruJ39HDjT66T0q/Sf5sRZhB7WPY0AGEPyru8+UxY/e7xxXCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bcJOOyY0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEKQVp022271
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 17:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Rtd3H7zwl4PHifGjlMJEfP9eYuxYGowXIigRP2aSXA=; b=bcJOOyY0n4R0hvFd
	Z+V9HFEDYssZYNMTk3h/BNLGLmMYLQHcdr8jf/r1G+cMwIW/TKdopIjIq/bZTgPm
	bSTKTMDcMD6kmxg0ZrOhbupub8hqhkGEANcvfAwUURoI9xBN6waB5YlA0LSg/cUX
	14t95TvAT6AWNliY19OxeG+n4c0oqKXbj9KER/rHoQtOsAxNdtxCis9uQ8qxcN9a
	8uZweRMJr+yqvpgJfRMoRjUCWsKxR587mRWdA5RC1F4SBzztZTGF7NcDY0vhvegp
	frzXMynTfmr6bhsWGrBgJVMNsFu9Uc348VMAmcVo868vDg2YDKv5o1C058sBb/gD
	EXdgGg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4473se0h52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 17:42:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2161d185f04so16655195ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 09:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737049328; x=1737654128;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Rtd3H7zwl4PHifGjlMJEfP9eYuxYGowXIigRP2aSXA=;
        b=Koe+nw8ram6V+3tz8uXkdU02U5qnrPrcXXK4HMB8XC0sjxQzw0hWkcsxwcd6/fkIBf
         TyFED9MGfzHz0MnSoKgngNgSb2+C1kkIiI85yXQjKX/DNeQXHngrrCD/3b9ID48KK48O
         tX7hSQZn0uTQUtkJ+nVSlZN49E/lRE+G/zrp7oZFl9TIp3ZyDbtj6T4L0U4JLNV8ENxZ
         i6rdMLDw4Aj1sB6rH+BRJGiao6Czx7EjE0K9KgVwmvh2egFjB1aodKxNWlvY1bTM2mMr
         p3OtXH8C/c6NiVm2aptSMjDd7Kq02b3uhD4x2VorsD/2t7VxnjBURpdy0KRmRfWVyWki
         mSwA==
X-Forwarded-Encrypted: i=1; AJvYcCXo1v40ZGIuVuYVyDY81byIwHNHI5gFjD7sFN9aExM0fUjGMz6Wz/Gi2inJ0V/hUDVPWaf6RbnMHd+RT3LlmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFilrrs4AUwbR10UAoBGl2pqlw1mBmIIzWe2hE6oyNocZXWTF
	xlSPUpkde4dD9DIHDvaXmncjqfgwn0lg6iIy4YdccJUnv9kwtLbqj93jrv64l2FHi62+TWo2DcT
	EBdowql+Y6DnpE88yxYeOXWaxqa4SYUasvXjG24DBYb77dC7cTVUdnJXDB+fAXhhOlQ==
X-Gm-Gg: ASbGncuFcyrsP4HvyMVlNa2kqQ/tunzla6/igwqZ7GzN9nfSqp5jdepMfaFs23NQxOg
	SGc0zOcKq7FwENWxQS9NsRvOEyMameysJxJvyWqbmzeO7fcd8JqRpDq6spkl9t5pfH2z7rVtswi
	iwWXrNKYB3lviqa9LUCQADmZ9piIa32gulu2Jw3nPfcFplGYLziRZGs3DJBf1za5/6zzfkL19Aw
	hclPJtwGSu46FJUFhnTK22kUzcegFw3ABT/Pm5PEuy+luhYaqyXTrryh0HRMJZHeQqXICEfwgzy
	dYjgAdHCPFTJvA03LXkOI3I6RycODNxL5iB26BO7xXYHTcmBSw==
X-Received: by 2002:a05:6a00:1bca:b0:725:a78c:6c31 with SMTP id d2e1a72fcca58-72d21f107f1mr48618160b3a.3.1737049328036;
        Thu, 16 Jan 2025 09:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqNuoeKH0RcFcycCEO91zE19PrVGiTgcBdAdU6UMAJ/wChcBQPxW3/kY9w5bc67TNoldqyhw==
X-Received: by 2002:a05:6a00:1bca:b0:725:a78c:6c31 with SMTP id d2e1a72fcca58-72d21f107f1mr48618128b3a.3.1737049327642;
        Thu, 16 Jan 2025 09:42:07 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bce3a7bbesm324090a12.42.2025.01.16.09.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 09:42:07 -0800 (PST)
Message-ID: <4e1b3008-97e8-4652-a07f-56983d989444@oss.qualcomm.com>
Date: Thu, 16 Jan 2025 09:42:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath9k: cleanup struct ath_tx_control and
 ath_tx_prepare()
To: Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org
References: <20250115171750.259917-1-dmantipov@yandex.ru>
 <87y0zbm2f8.fsf@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87y0zbm2f8.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: l0NnyQM3ldtz-X00kH9ChqyZ-saXrQT_
X-Proofpoint-ORIG-GUID: l0NnyQM3ldtz-X00kH9ChqyZ-saXrQT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_07,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=836 lowpriorityscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160132

On 1/16/2025 3:19 AM, Kalle Valo wrote:
> Dmitry Antipov <dmantipov@yandex.ru> writes:
> 
>> After switching to mac80211 software queues, pointer to 'struct ath_node'
>> in 'struct ath_tx_control' is still assigned but not actually used. So drop
>> it and cleanup related things in 'ath_tx_prepare()'. Compile tested only.
>>
>> Fixes: 50f08edf9809 ("ath9k: Switch to using mac80211 intermediate software queues.")
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> I don't think cleanup patches should have a Fixes tag. This is not
> fixing a user visible issue.
> 

ACK

