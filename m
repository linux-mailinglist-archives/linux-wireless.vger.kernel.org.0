Return-Path: <linux-wireless+bounces-27860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C4CBC17F4
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF622188BCAF
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323BC225785;
	Tue,  7 Oct 2025 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PPEtf7kt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A21E32D3
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843873; cv=none; b=qY5ggWCz9RK3V3aS6tyF5tMoVJ9fJdoCXJnLQVlgQ1LWyPWloqoe3at1U6oSneQ3MwWNqmMWjsl/kEJV/5mW98HX/0NEALltRDMMUI/QlYKq9k8j0dRzuSFs+ji398I7ynmPy/89tPyuS9R9wbMHNGjPtcdtsgzs0Xo9wvg4zig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843873; c=relaxed/simple;
	bh=4deyOB2L6dqto1XiXR6qCw+93oIrxZdYhpy+WxMuTq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lal8ugwRS3L7B3Mmvqa4wMT5ZQAqzHEJa9Y5yfVAUWX87MplcQ0iexjkI+UwGB+J6oYaGuxPABH/S1HqeNua6fDl2/Z//TuzzhhjTp2XVpaQeR+zNIJIB9xDh3YSjJRG2kRs91H/Olon8gNJE2iPtl2cRVbavM17h09Gja6aBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PPEtf7kt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597C9o2U029299
	for <linux-wireless@vger.kernel.org>; Tue, 7 Oct 2025 13:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ntyqc3cfFdL0+zciHAWHrYx64d7Wo2ITIj39j+9BU1A=; b=PPEtf7ktZZv8VKC8
	YUTgicsLYTLA2ABfArxbCHtU8DjF6Z8EVy67FMhsaPrnwx6/e6RzJuJGPZKErGTq
	il9+f1DYjS2MonG37PHQ/oUTaKNp0qlaOaI0ob0SxD5M+cwWaa633zm9iuVz8kV6
	FszkhPjGwpE8lWKrIWXiTNX6L6NiYGqBQKG85cw6gPc9ZTnFS88SxvLEWaCnSwpf
	RlolBHO9EwstyEbuPZJiHqpU1AcPaWjX00ebr49abgq+10NWLShqDH6eBsSmKJlk
	vZjXlhqHdORBw8PPslniIJWb0uYrValFqNKeU5DvdAgBzhaOFw2Ff+v9u10ZfjAp
	ieq69Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1q8x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 13:31:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b56ae0c8226so4252531a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 06:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843870; x=1760448670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ntyqc3cfFdL0+zciHAWHrYx64d7Wo2ITIj39j+9BU1A=;
        b=U9+jZrsbkz6AJtGPJ909GEVkCpoDC/UiQlSG73CjluRFPJe6ptQTPjltn3hLXqbOZh
         q8u99b7aW71CxtAQBaL5wrk3oU+2rjlqBRDWvd7RjQqb2ek7CoHACuW8SOEidWQBKrie
         DD71M57IH9clRIFg9PZ6qDIZcBjN0jdZqTm81ICoX8gXKiIMTYKPwxMiRrEWgRtLFjtg
         FlDcL5B9xUadMkJ2a8ZeSFaA4+Akkjz6QvnDm19LHBC7icJcvrwG09CLWMcKl774LAFc
         Mz14IXlbj8dBl/T5tEFighKlMoVzRJEAjFAGQbpx93j4nHXD1J/giGdREFLXwL3jetZI
         uo8Q==
X-Gm-Message-State: AOJu0YwcdNpTLwWbWYqWhcZwy/TVi3q/bLrzTdjzcJsLAHqZA0dgpVGs
	xPVVVooWg8xnRa791AzTiCc1ZEV5psYTxbhgw+ypCPZVqpzuRPyehw6CCgCOMmZOEi+XcBz6Jw6
	HRIY/FR4t8FXuZKHfPI8PP/pfSs9hvr9DAc/bSY9ChPMGQuecQ0hvpPr9SFvn/597RUgzDQ==
X-Gm-Gg: ASbGnctHbjmtcqLhj9Vo3Dt08z3EEvNCUBXtd9JSzPYMOjKZWx0Ziyv8GT8wlY799gl
	sDrOSSJ/oFu4IjbfrVXA4b0qraZumIlQwDzJHlQVQrw+iX0uHXJLHwRKq4zmLDLk4DoLYltsEKw
	8GUIWH+XL6VEwTm/3vHVPHnVz6pblQI2YdUs5hhDRqHcNxC+l0yJ9Rzbb9eT+obac2palws4U6P
	1SXixsmx3C1Ki49uJwBZnMXEuVRqFyEUx4lRfP51qJ8geUoYAj1Y/9Rn5UyUveRKnR31Dlgki6o
	70Oty7CX/3Ko/nqgXlA6zZegsz8LlNVBtvc9vH/1j2RpfO/czrju9sCIlspTmHJ7vf1QZKhiDG6
	e3JMTeH2V
X-Received: by 2002:a17:90b:1d0a:b0:32e:1188:147f with SMTP id 98e67ed59e1d1-339c276e95emr21898799a91.19.1759843869417;
        Tue, 07 Oct 2025 06:31:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWkR3NMZmKO8TBoV/tq1VuPyh74ytxa3HIkPi4GrzXtS7xG0vWtr49AExNmovoi+H2e/nfYg==
X-Received: by 2002:a17:90b:1d0a:b0:32e:1188:147f with SMTP id 98e67ed59e1d1-339c276e95emr21898752a91.19.1759843868848;
        Tue, 07 Oct 2025 06:31:08 -0700 (PDT)
Received: from [192.168.1.6] ([115.96.2.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339f09bdf1fsm1224456a91.2.2025.10.07.06.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:31:08 -0700 (PDT)
Message-ID: <8e8b06f0-e654-44da-91a9-9731cb92516e@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 19:01:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix NSS value update in
 ext_rx_stats
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250725084426.3989966-1-thiraviyam.mariyappan@oss.qualcomm.com>
 <4e204f93-b964-40fb-8eb5-f723f309a2c1@oss.qualcomm.com>
Content-Language: en-US
From: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
In-Reply-To: <4e204f93-b964-40fb-8eb5-f723f309a2c1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kyUj4rVUHVxAckZxiYmtJ3iNKQsEiQxR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX2sRZVeHdAlvl
 hadLtzd3U3oR/G63KZqo0qn8cy3IozsKO0/W/2gi/vTjEE8TUl73aAH5wm/de0WA0yMfH0L2Lwo
 tucfJfyKY21XZeBbtFVzD12wGm+LURgVZcpFFaRIe8wHx/0pguVGIa6mXF9cs+Ro6ZuZ/lTpiIx
 Hme8l36cHo33A7unyxiaBmPaWXm4nY6sh7FV08M8orr6UuJ3iLdUaGce4327edxvM2iPXlZMm1k
 tKGRv/0VNSg2u+DmsIrcRhdK/eb1TLnu5qzL8QTJKxmzvrf4HkvW+XJ0xiB0gGZZZVnCi8vTk+B
 yGc7bmE/a9OEkEnckC7yjpocfQgmTvArY4hYC/mVWpEdmaKIdOtaLJcAjhMpMWTURwEmb3Rl19Q
 jrwfqA5WI9xB8pnIeWl/cPTuGfoR4w==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e5161e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=P8EKGVp7AHIUQAkkfTWdsA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=myYG0hIH-BHpDLZ92UcA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: kyUj4rVUHVxAckZxiYmtJ3iNKQsEiQxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027



On 9/20/2025 9:25 PM, Jeff Johnson wrote:
> On 7/25/2025 1:44 AM, Thiraviyam Mariyappan wrote:
>> Currently, in ext_rx_stats, the NSS value is taken directly from
>> the firmware, which results in incorrect mapping:
>>         4x4, 3x3, 2x2, 1x1 SS are incorrectly updated as 3x3, 2x2,
>> 1x1, 0x0 SS respectively.
>>
>> Fix the issue by incrementing the NSS value by 1 while updating
>> the PPDU info to ensure accurate spatial stream statistics.
>>
>> Remove the redundant +1 increment in the radiotap header when monitor
>> mode is enabled to prevent double counting.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/dp_mon.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> This patch no longer cleanly applies to ath/main:
> Applying: wifi: ath12k: Fix NSS value update in ext_rx_stats
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/dp_mon.c
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/dp_mon.c
> CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/dp_mon.c
> 
> Please rebase. And when you do so, please follow current legal guidance and
> replace the existing QUIC copyright with the new QTI one.

WIll rebase and update the copyright in the next version.
> 
> /jeff

Thanks,
Thiraviyam M


