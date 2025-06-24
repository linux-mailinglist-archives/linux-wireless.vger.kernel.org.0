Return-Path: <linux-wireless+bounces-24444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C7CAE6D7B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 19:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0D81BC60B4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C7F22B59D;
	Tue, 24 Jun 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EUlp7Ufw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569526CE20
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786219; cv=none; b=FTqvzdjEH2DI+OrHaDxCvVF8q97OcFORDbSTytj2m2qMYmutBT/nNrRyPi5RSMDU7v7g5iG6UKtNyQrvCsnmFZImltFSWp0Y5msKQ6rTEtlFSlZnTW3SaOCBrkjBToytGxQnkNRAASeecgLH+FLYOdA2H6LA2GTlo2JcHiY8zuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786219; c=relaxed/simple;
	bh=tyJRjp2BC+daF8rBAqDwQ0jizpuQHWR1yMahxWZ+7VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4DT9ND4tjkQuh2TMlxYsfFS8AfjlCplqAE60wTOhFxUVZjsW9vAxRqX4K59GSMx1X4VF7J4EwgSUUEsMggzV1iFV2CLovC1uKo5mrY1J82HVgM22K4rDNlTU5kBwhmu8cY/yjSrMidPaJbkePoi9ZVt1n1DBpivY6TuN8Y5zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EUlp7Ufw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OGjhw5008088
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 17:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tyJRjp2BC+daF8rBAqDwQ0jizpuQHWR1yMahxWZ+7VU=; b=EUlp7UfwxE9aREU9
	OtGgKAwrLHK/xXRfOyDYCJGAML8fR2XG8AjtOACJ2vOihqo3bRSBXh7H3WZXJJ6n
	5a3WHI2crNL85cK5AUAX4+L24h6arIPA7qM27V0ld9nmNhXX1vvkX0jR7FniPUGh
	BoybdN58JdHfEOaJCDHU/sIw7JmMV7dFMreXghVaHq0AcRFxYtLs4UqXBttNInYy
	DeajbIsjDLdUrPQkI6eRFOGU3zWlm2Wr+6uzMtu9ItupW6EXsEQbxBoF0RQqxrzm
	yVKJWVLXTvuGDF/w2UtRW24+7HMlz+W64p3HFHQr5cJ+DwxCEI5OEI6eWlF1eZaK
	fOhHmA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f7ttvbyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 17:30:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3208a7d2ebso2340628a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 10:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750786215; x=1751391015;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyJRjp2BC+daF8rBAqDwQ0jizpuQHWR1yMahxWZ+7VU=;
        b=Fak02lyM3yulsrg6dGeSV2/RZ6Jb3Vs8e8mIsYNKkwjp5CiwrATkMrHkoehdAj0OkF
         weIaa4itMBwr5jjNMxq6qD0+uHlXQrOKtYS+/d9F07GJE62A9YTU1k6c9tbslIVAwCkm
         4Yzd9l4NhmEPt7IUC9fQN5u8bKDqCvEiw6z/j15h7/PocUZDardnlqxzlCkCU5eTaad+
         qdUhjzPMVwejtVgAvHvle1mq3Yx3aoOi5nmhfsJfuYYlzZKLu7ZgO4t3OgFipxQjgK4t
         GsYS7wieY6JJT8OSiXRHQmfV2avD9uuNx0v7CIxO8tQ+c7ir0OyhpqVCUOygv1OoXoVv
         4oBw==
X-Gm-Message-State: AOJu0YxMKioXh4u7e6++YyLBKG0MYP4WScnt1P7xumAkkiTacfKjsccB
	RXpWoDgRTj19M2dn+lJ6KKOlj+biTGYt9Ip7M9N/2GpByCm3wwtoMa4RlZYLCTAtZksZ5Ore78P
	5habk1EkxGgmPmXveOLtNBJL1WlWNiz6UdHuCjERXHa17ofEXz3/8YmRGRApv5ZiIO6moXg==
X-Gm-Gg: ASbGncuQob8I/z8ZWuEplq3+Dg12SmSAvGo56SF/UzRjPXoY25W0QcwdvCsjqKOq7JI
	U+5ZiWoMO58la70aohoG8q6iB+jGGunnR3DuEMO/YJdjGyWVCCpnMRf8shHoJdy2XY1XchPQ95O
	qlgRspz/yXmjtVL3kV0+80J7WlV76djnXNLaOGnsbJF72k8mPHGk9BIleXbAZgLuvc/5egrNdsc
	H52Xr94t+84upKblUmGMLAApn5dmZ/3J06n6466pkkyPCEzjSbRph7dX+mUvTPT8rSoyjl4MA4M
	Tq8Jqfb1y6Ad8+bZDZyCUccC1in/mA92ghzviWV+WZKNxDd3i7aYznaJkAqspe3Ym0XgqRnWVoT
	NyMCpWfSNU3hyH5A=
X-Received: by 2002:a05:6a00:1817:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-7490d758681mr31303380b3a.3.1750786215215;
        Tue, 24 Jun 2025 10:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES7z9d8vjW9wocOUQHzjnQCbI9qB8j++QdFNu9+XZhCz61AqzxPaefqRHEfG8CpjKAP1LyRA==
X-Received: by 2002:a05:6a00:1817:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-7490d758681mr31303304b3a.3.1750786214605;
        Tue, 24 Jun 2025 10:30:14 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c882cc78sm2265801b3a.87.2025.06.24.10.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 10:30:14 -0700 (PDT)
Message-ID: <14928304-c4f3-49d1-8a9e-d018ac699e90@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 10:30:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath12k: add module param to control MSI mode and address
 width
To: Govind Singh <govind.sk85@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250624165031.58616-1-govind.sk85@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250624165031.58616-1-govind.sk85@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QINoRhLL c=1 sm=1 tr=0 ts=685ae0a8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=oBaBJG5FjUdcDCMQZ_8A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: nAn_Yd3irffJaCc_XKx8BHweKbe1adxi
X-Proofpoint-GUID: nAn_Yd3irffJaCc_XKx8BHweKbe1adxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE0MyBTYWx0ZWRfXwOHfM1n7oA0/
 l7jl6RnzoydC/PrVYGUkGNzEMVsxdLNIW3Wdwv80PIsr2X2eKTzctZqR/NprZklQx65XHc4tXf9
 HCVnGa9t2ZRJNq1YnQLnABdJx+zyOeuygzlEkcB2/vHq9zUZQhZhHaqjf6mOBIwR5ChMAYey83U
 HKFKOsPKzGOAMEUkrLlQKbJW/2ctoVWMi4Fj5LVX1cx/hF2n8pCxiWBT7jUIzbRgvUOtLruo27g
 xc+6oTMk6sYVMTnSy1fTi5NEQekqXkOzzFryHFgJ6JjytobPylbO6dagEnkbXICDIB35ikg2BpA
 op9YqNT0ts/c1WU8QE+q6PsXg5ccSygurGhbosepgbV3UlOnJDmShdGrfFvEKd6cxvVlH2pEa+k
 orgv77MYAFO81+XwlAvR2IGgYnvLWKrs75zVN8eX/l+h29lu45Gb3wa/oEVPkOBN3FM0NXeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=788 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240143

In addition to my previous comments I now see the Bugzilla record, so you
should add the tag Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220190

