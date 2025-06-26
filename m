Return-Path: <linux-wireless+bounces-24517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA84AE964A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B975E189C55B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 06:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43C2264C3;
	Thu, 26 Jun 2025 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pN05xm4K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1192185AC
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919398; cv=none; b=q4Z7h1eDMTEIK2qaAlrxhsjwvuh8lGxZWtb0S+vclMR9iHr5yXrJHYZtB0IwV2iiqkJ5Ot3cHNuRETITbV4z2i8UJcoqI4YGmkItdpqg5RaTz9Mm+CyIyZVxBaPNJ8YqEw2ZzgteLtbTradOSyq9dadLd8RW76UKWqtjhvphcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919398; c=relaxed/simple;
	bh=d+4bdQHoXGfGA+AdIUP5UxPJthZK8k8wZkwHJ/yAEc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q809Ir1UlwHRGoNEuoIHOFV4ln+DhPGx1CC+EfYCOAxNPRIFSA04PWnuasKFiZNUtsHyRrEFBJKm4ncoZQFerC7ANR80CAqEet71GPlJ9O3P7aBnNgARX7JjIzaurregVBj/u2zcXIMn/illdKrryBuR9BTHRSx9N7AoP1CQA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pN05xm4K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q0DpQN018610;
	Thu, 26 Jun 2025 06:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q/+CtHRcg98aW8w++8LAQzxejFGcqjePmkI/jR4CZbU=; b=pN05xm4Kbzdylgw1
	8yHIDhgz7lyULsZoQcX5K8IduxI8UDZ6PhCrrfD0eKB15pXNU+Cre8vNQ5g7Mhe4
	nkDHeNqSDJmDPH5uBRTISFSwPYVzgfyCJIfqlaNNB6nEn12eakI8l0Rj2yT43BDt
	QDP7wLSun86fVen7Zosp7GdyeOr2tKvfgXtpLaysH3UrcVPYljTlWvH21K3yPilo
	GqO/AoxJKhKvBdNujRyA20DGgq2Xxjd7t/17Kktpw0Zksf/+VLwYgYBI/QA07Cwy
	GcR/6l7UUQ+gJl3tHYENbiWwTufz3hVP9bqwG4KvNxMrgyzCKNSt4gnLxGCNuBsx
	kymcfg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec26cg20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:29:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55Q6TnM9020357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:29:49 GMT
Received: from [10.152.194.132] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 25 Jun
 2025 23:29:47 -0700
Message-ID: <344daf44-525b-40c9-a570-fe659717d656@quicinc.com>
Date: Thu, 26 Jun 2025 11:59:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iw: add support to parse 6 GHz channel
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
References: <20250620073240.2770468-1-quic_surapk@quicinc.com>
 <220639a5bbf43c125ef114c6ca8e71d050125cd6.camel@sipsolutions.net>
Content-Language: en-US
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
In-Reply-To: <220639a5bbf43c125ef114c6ca8e71d050125cd6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA1MCBTYWx0ZWRfX8bD6aFjKlf6z
 b9+IeMOoE1+/VcYnQeA2AgwSOuoE/ec++zMwYfL1tGYqC8SbA4oOTmtRLykK1fOurscjPEwo+BY
 vsZDoQNbiZrciBUezfaJqNJw2VjDNV8y7VO0kCTSz24ByhfVsuSBc1xwiP89QYVigJWIFcDLifZ
 ZytoruNcQOOSekOwQA5agZ8DrwB3cXdJXXn/6hiqZs5cnURHJ9gRUuxTQDv/nkedDtZgutvRXOK
 RJOmc9FQQxkG6UZmBRDOIf/4Z49vRDrDbnPkFhXcjwLpAMXbG23LZYekFEWcVDlrocbmTt5/5FU
 3cvE1ghV+6OCuXkxvzULF5HIXT4BRHpgiLE1m8IGGz1BlUJC0fGQo765QLSMjglxAqN9YgdSICC
 JpUebDnoI6cgsuMSLsy/ygF66J5MwNbZ3wzcx+CvBpKZ0ZbdtoSzrs6Qj92tYot7GRKQ9F47
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=685ce8de cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=7xJHNXlQ_Yn2oDr9iNoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: igJv-wtQYgCuvCsAb1vyATaGson-t9OI
X-Proofpoint-ORIG-GUID: igJv-wtQYgCuvCsAb1vyATaGson-t9OI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=989 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260050



On 24-Jun-25 1:19 PM, Johannes Berg wrote:
> On Fri, 2025-06-20 at 13:02 +0530, Suraj P Kizhakkethil wrote:
>> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>>
>> Currently, 6 GHz band channel parsing is not supported for
>> set/switch channel commands. Channel numbers of 6 GHz band
>> overlaps with those of 2 GHz or 5 GHz bands and therefore needs
>> additional argument to indicate 6 GHz band. Add support to
>> parse 6 GHz channels for set/switch channel commands by an
>> optional argument "6GHz" in the set/switch channel commands.
>>
>> Examples:
>>
>> For 6 GHz band,
>> iw dev wlan0 set channel 49 6GHz 80MHz
> 
> Or just say
> 
> iw dev wlan0 set freq 6195 80 6225
> 
> 
> I'm not sure we need this at all.
> 
> johannes

Adding support for the 'set channel' command provides users with the 
flexibility to use channel numbers instead of frequencies.
If you think this change is not acceptable or needs modification, please 
let me know. I’ll either drop it or make the necessary adjustments.



