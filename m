Return-Path: <linux-wireless+bounces-22673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BEAACD88
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 20:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B691BA78F2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F965286438;
	Tue,  6 May 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZrI/ro4k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC22882AF
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557547; cv=none; b=tpV0g/xo+gB65MFurkHbz/8eqJk3K2nuhnJhGg/wUecFSrJV/fkOEq6g7aYkt+3PR18Avwh4XhXtPrTvO+1TmFKvF8Emuh/IhVQKxn3aVD9PYIE8sYoI4za68GuIRr79xLZXTvZn1F2DkYHEezckuTCnB8wjShYxsaTMXCxxl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557547; c=relaxed/simple;
	bh=OWYwlllW31vlFZQnjSaKf3pmrCjOPTlYYcLqJVMI4p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ts+LnNtQ1TZgB1G6x+anYoTkGGZ5cH8diUTQmFpGXDbd7UpYxyLvxcbyzfb4EzOn1mH77zObtwIdKslwECnAMzHF6RFxWuyw5BtY+hgVZVTblTTuH329n4UrQJ/SLZ9iW1loTyMup/bDzdtvv+F04PDWs2bZvfIvUmJRGgd/nB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZrI/ro4k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546964cI002574
	for <linux-wireless@vger.kernel.org>; Tue, 6 May 2025 18:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kvf6wWhtHxqg6MIN1ZuRftKcLX8kqJYFgLZnWRbjayo=; b=ZrI/ro4k7lKCZbao
	Kp4dk99FhZxAGniNZbbePR5RDkO9PV+V1euWxf/I1R5Kuj4wXnIewhvDZRMc/1k1
	5dI38hn/+3vdyf0Nwe4LrxEL0pNzQIa8XzWsN1i85bLHo0qivSTh/UhoGMqggyBm
	8ba7qbCYbFxZKjmRVXmcdfCU9uaHlr/Heh8LQ1/efpgrrgdWeYnpW8BDlr/UBE1p
	2Z5JmxS2DAR5897UVGe//Mf7EB9la9U7nFf72JfzJmvd+qW6qibsOnV17P0P3uOE
	hw0V12fPrXEG0bOryvh7o0E4L6wQEn2e/o2nqV4+6qnRR9HMFee9XCfXLNfpSoda
	Zrr7NA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5w3b92x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 18:52:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22e540fa2d0so5993825ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 11:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746557544; x=1747162344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvf6wWhtHxqg6MIN1ZuRftKcLX8kqJYFgLZnWRbjayo=;
        b=HztlEMkPoMM+TIhvRH6pQ0sZliE9UgXxTckudXGyTK0o0Ibr6s138ilt/wOJlm8dD1
         4bmIPIWclH+VDXiPPoG4zrGA74zMZhKhG5MSQDZ/1q7qnU2buhw+wrvTIc1eXpG69Uki
         fWU7lzTLuTWfZCiMGD5625Nk73O38M27jHeKrsH0EuSgA/2Sake8K9eRrh7eavHVur9l
         xQmMpa0VRkC3p3b+LCLb1mXhVZBLez+MFJivT5uXFeZVnc7gNGvmdKPMwSRiCSmxgvQw
         3Tng7h+oh16DZaB1gNQwe1Nf0X4ohSL8C22aTejKktUSBdReEZE0a/FEs1pCOQnwrvUk
         b4Ow==
X-Gm-Message-State: AOJu0YxeSvnss0I7QwWYDaLXTXCXrGGGpXHavwm+UnyJiMIQgdZZ2iTd
	tVllqR9MWVJ2/yjKl2Jj/4xZGTW0wDodz6J4iSe6DDcauWEqHOoKOIQTDXO02AnQUWCbX4TIoNz
	kEd5RviarmMGAFxRBjnDou4MMY+7NnVvtkLTyJpWJ7NpUyPVL9kCKjwXIEZA132lw2Q==
X-Gm-Gg: ASbGncvILM2SK1Lte/4A7w2UEP9BnG6bphpDy9F6hkjyEzRTH93TXvsA2PhTW+NKfIT
	YP16W4xY7ItIsBkbt0iJzBgsDHsG4bUdSOjbrreoZfEDdojH3v6v1X5rpavB65mSctVHdmKgmSN
	d/Mls9uC7z3awG0jv33GTW5pZGVKpjulcUPbALjnbqWwEdwD5EEvrnhGFwT1/CJNBGoorS8Gczr
	O0Dw+To7bGb2DMpVtB0HSoo4O27fEepqOR0WCzOHjT2mdkJ/AjOVI4yekIskKV+OELryjIzX9Zw
	KI0NYuFz8zGUtKroMGmTLXuZbeahfdG7u9Tk4eH8zIiQBzI896ascHaf29nBizuB
X-Received: by 2002:a17:902:db0c:b0:224:912:153 with SMTP id d9443c01a7336-22e5ea28001mr5838725ad.5.1746557544160;
        Tue, 06 May 2025 11:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAeM302AG/fjm1ZK0SjS80F8vGb9oK5vmojLHOaYdA0jvxCLEcImHl7uo9z+QubhHm7POP2g==
X-Received: by 2002:a17:902:db0c:b0:224:912:153 with SMTP id d9443c01a7336-22e5ea28001mr5838335ad.5.1746557543747;
        Tue, 06 May 2025 11:52:23 -0700 (PDT)
Received: from [10.227.106.66] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522054esm77587675ad.118.2025.05.06.11.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 11:52:23 -0700 (PDT)
Message-ID: <b3e1fbdf-a254-41ba-8560-3fec858ba0ce@oss.qualcomm.com>
Date: Tue, 6 May 2025 11:52:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: disable pdev for non supported
 country
Content-Language: en-GB
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>
References: <20250502230240.3692678-1-muna.sinada@oss.qualcomm.com>
 <5fcbf500-8005-403c-a9db-597fb8a54bc1@oss.qualcomm.com>
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
In-Reply-To: <5fcbf500-8005-403c-a9db-597fb8a54bc1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE3NyBTYWx0ZWRfX3/1tGxZKDlOX
 31p3mK+0ZayVmLZvKqQhUr8UbZ98Fki+mrzUwn3BssS/2tmCoX+ilusL3AEED+ddVJZOacvZd2z
 Un07suY9zYIr7uW9ytAqW3qXRwJn1Exwbw5yP6E7FAGY10KM8DbHS9RTwHwGjKEIjyGePxfaJH1
 5gAVF3o/fhfV2KvhqJs1ZF1M/WwdS2NJabdA6U2ZYEpT5Dee0HU5/Ksd4eiOdU6F5mMfJto5sKD
 af+aN2COJ+t4FdS3zYRO3CvYkK4J1F7IRtUoLdpQIwOdfH+VFHz8QKOEOresp8AK/UsC7fnvCc2
 y/2DVHojqUktrulhoIKb32lhsFdJeBBzF17KLN/4Jt/LnpvHdltAhGeoVdL2En9qR+y7/+mXjZK
 ETjs1CRWm839op4xTKw0y1Mma0rO2wzsFMYZIy1Xun31xPkB0nMxfVpA55NKAvTGGMlZmBta
X-Proofpoint-GUID: 9wLMUnpcPR3jsF-eyHBdV-BKZdira7-V
X-Proofpoint-ORIG-GUID: 9wLMUnpcPR3jsF-eyHBdV-BKZdira7-V
X-Authority-Analysis: v=2.4 cv=W+s4VQWk c=1 sm=1 tr=0 ts=681a5a69 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=wjPqW5DQ7UYj3S7x5DEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_08,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxlogscore=608 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060177



On 5/5/2025 10:46 AM, Jeff Johnson wrote:
> On 5/2/2025 4:02 PM, Muna Sinada wrote:
>> From: Karthik M <quic_karm@quicinc.com>
>>
>> In MLO configuration, ath12k_mac_radio_start() iterates through all
>> the radios and makes the ar state 'ON'. Even though some bands are
>> not supported in certain countries, ath12k_reg_update_chan_list()
>> tries to update the channel list for all the active pdevs and ends
>> up in the warn_on for non-supported band.
>>
>> To prevent this, disable the pdev when the num of channels in a band
> 
> s/num/number/
> 
>> for a particular country is zero.
> 
> Can you explain what is meant by disabling the pdev? There are plenty of
> countries where not all bands are supported, but I'd expect the pdev to be
> active on the bands that are supported.
> 
> Or is it more accurate to say:
> disable the pdev when the number of channels across all bands supported by the
> pdev is zero for a particular country?
> 
> I just want to make sure the description is accurate.
> 
> /jeff
You are correct that it is more accurate to specify that we are
disabling the pdev when the number of channels across all bands
supported by the pdev is zero for a particular country.

I will update commit message in new patchset

