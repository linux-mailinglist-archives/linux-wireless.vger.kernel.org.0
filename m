Return-Path: <linux-wireless+bounces-25248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC612B012B0
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 07:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A4F5A5D9F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 05:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E748B19CC11;
	Fri, 11 Jul 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HjNQfKPy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6511BD9D0
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211676; cv=none; b=LwahXf1HllrCeEK3YJSuGBTvOPeh6LoULqjbrT/ZsgyuafpQsn5vaFrn82E1/m+ZEy16QZNtWp2CtU7lHQNjxvdNxwMxaUY06gZW074UcRf/ZGH8I894Q5imX/UeLDLuHpCxrlK17g3tz3NTG6mww3ijl5MGzeLalBenZcoU21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211676; c=relaxed/simple;
	bh=ncUzR2a74nVNxw6/aJvFHkdKVXZsECBP04Y8QkzQHTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAmd/F39S1rydOmEW14VCVw5olMVODYaJ8wnlpcBs6P4+IXn/eLcV1gccljHv2WA2ROqvX83GxYM6WYlVGWYJ2x3iyKx5VIizWclGzm3sPFZIGL7WA8Ii7Zlq3Nr2YGtdulS1bv9sOVii1mfOP7J+1jcSmpHiN3RqaHZEvv7awE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HjNQfKPy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XKqp003223
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gkO0GYxkKlN95Jpg6S9fPel3lmdgttIodj03QRGIjyg=; b=HjNQfKPyTyP7eWqv
	2JW8tVJpaiyLS5lb5NXYMc+rQ7r8QWwe4naJjsOjdS566WjiS0Y2klZlQ+lqQ1u3
	J0N5bN5fKBX8Tm6G6ZM5q1u7ad+ryCRV51KfMYwCpQHxZCiHEcDH5V+H4bCJGR14
	G1RQgGwtRfIuxItob91WQQn5BQK8022I8f4mfM2BAKPGTiLyCOgoYFOyh/Z178Fu
	6hdFj9WMMq0G5Ny9GK0JzCCKw4nKRmooTC4GMr3aIW1r/E7NReUIWtFOWQipObdw
	eHGizk1c8gFxyEpUla3omtBbuYnSZPxuk9FJESqdMXa23Kb2trOri0WEjOIrNQY2
	n/o1eg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bjk3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:27:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3184712fd8so1376710a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 22:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752211672; x=1752816472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkO0GYxkKlN95Jpg6S9fPel3lmdgttIodj03QRGIjyg=;
        b=M17P0ur5mFpPNvGv1vnYN9Oreba8ZOS8ADh7ws1vPHHiV/5o4q3eHGafnyj4chwhsb
         l/Sb5Z8Da3XeUIXwS4GBfPf6WlVpX3p491n0MP6tzMRNDuRcc3DUvcQBNcgm+aIr6KcF
         99eMzdylbDJl0G5lkED4gNIHsCnhI5/JrX+qQSx+IsyFlDt/QxnK6xreb0xH6byxVsfy
         KajyzhBCRRr4vkwsc7hOUJ1d1nUYuu6hmshctNj6ccTlDM7bzb4sRcDBT6Hnbq1ivNno
         Bvhvpk1AdzAT8JmsNi7kWjiyyVkgZj9gQM34zsG+iXhv48UWjnFgMvn8aNGGeCGC99du
         caXQ==
X-Gm-Message-State: AOJu0YxZ40IUWJd1XqOE/SjzVZnDpTgk7TZ9dS963Uuqi24OR5WlkxMP
	vkmdMP1B6p50BhITQTBpUVIVuNdkoZtz3cvD7XFv2lDZWtlYzY/bok2OMx2x/GtYY4zga3w7CZL
	fSnaiTC13/SWnnBaZ2TQE1nYArMHSsQE4zPTOYT/y/EnnLxSQlQaYOKuHgmcteLnZHSg50h0VyZ
	WLVA==
X-Gm-Gg: ASbGncu8KuBfbgKjWkvlnOHN8zDGE69dBtRMtJWgInK9eA5AZRDiYiSxFBpHGKIroOL
	NMvJJg8VVSxsDb+NhOGf1w3cUGBFYfz6FnVCMLX4yc4yM5HYRPez1UhqtTAUFjOMhqDNR7O2gt8
	CZRFvSRKzk9A6lALaR/uU/4O/xnVdSpB3F1qNHjKN4vUxACQQku4NIRBD60vHTs19DwM/7jWesL
	JZI1hJo2QfCwpqw9JBZnV9ke8QNpRiHjDD91nyATI0V6rd7nNDDmL9jZn5wme/iv2kNHlMxt1HL
	bP7BqTKrCR2b3bJtQ7eSzKZfb9Ke7xgUJgw4W4zFI4GUU/Iwcf0fMftJ6S6P+nfCrScu0wTQeU/
	Ra2W2OLBlTXw=
X-Received: by 2002:a05:6a20:3d08:b0:230:f3f8:6708 with SMTP id adf61e73a8af0-23120afd939mr3772478637.34.1752211672069;
        Thu, 10 Jul 2025 22:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEaJAgXi80ygu92o6pPf++VPaum/eh82aa7liWDx41W+v5TkMIXzAZRRG37wFExe0VDFe96Q==
X-Received: by 2002:a05:6a20:3d08:b0:230:f3f8:6708 with SMTP id adf61e73a8af0-23120afd939mr3772444637.34.1752211671715;
        Thu, 10 Jul 2025 22:27:51 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.235.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd73c3sm4073965b3a.7.2025.07.10.22.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 22:27:51 -0700 (PDT)
Message-ID: <7579d920-9b0a-4b40-0578-58eab70236b0@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 10:57:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix packets received in WBM error
 ring with REO LUT enabled
Content-Language: en-US
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, tanguy@squaremind.io
References: <20250710011754.559817-1-nithyanantham.paramasivam@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250710011754.559817-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAzNiBTYWx0ZWRfX216jdgQuvYGs
 hFqPePIvwKMx2ERNkIOGtaLHseUl4UfB1IAKNtWYZgGS13oFZVFylAzBj5GV1aKGl1FnBLcyVpN
 gzpKBttreuiJZgUdBvSC25m6ixYBflumBjLP5C/aBm7pxC4qlgBwh6xQyUQeWCM0VYJh3ezmlK4
 fUjNPyq8N8EUnAMhv41tkfmkqHMK9VxA70+5Pa6T9tyUCl62Wu0RlLWJ4PTDLF06+XcHd722R8v
 qRJmqcoe3ZLfmfv1YiRj8n0ZgoGQhIy0rxNsEk5k7oXusNn40nT70AS3icCXwDaoW9bP89aFNAq
 al/8sILV+R7qRBEAoJcoByfS4C7A+JOEjrYLL6uZj8rYDGLNAwhGMku34v1vWmKseHYTF6gdeua
 /1vh817XI/1jfU0vHcJwmK3ZlX5H5LaSwk1rCFAa3jWuYfxeCENZzOAakVl28CzC6KwIuzlY
X-Proofpoint-ORIG-GUID: D1GamIPTS-EeSKA7BkUrarDxhsWyuEG4
X-Proofpoint-GUID: D1GamIPTS-EeSKA7BkUrarDxhsWyuEG4
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=6870a0d9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=qj7j/dCbgmX8y5u3oU6Y8g==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=p0o8ilPX4fJNFhDpVC0A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=899 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110036



On 7/10/2025 6:47 AM, Nithyanantham Paramasivam wrote:
> Currently, packets are being received into the WBM error ring when
> REO queue lookup is enabled, resulting in degraded RX performance.
> The issue arises because the REO queue LUT TID memory reference is
> set to zero-it's being assigned before the memory is allocated.
> Fix this by assigning the REO queue TID memory reference in the LUT
> immediately after memory allocation to ensure correct packet
> processing.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Reported-by: Tanguy Serrat <tanguy@squaremind.io>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220282
> Fixes: 3b9cbce6fdd3 ("wifi: ath12k: alloc REO queue per station")
> Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

