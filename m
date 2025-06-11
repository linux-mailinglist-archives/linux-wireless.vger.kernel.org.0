Return-Path: <linux-wireless+bounces-23984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB5AD4A0A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 06:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8844D1887E91
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 04:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B221D5BB;
	Wed, 11 Jun 2025 04:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3N25xs9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207620ADEE
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749616203; cv=none; b=LpzYMWbcQdz2sMjpycClvGdqFUUsmJa2u+TDNDXM8GE+m8Ba7cfKMYtAhGL9uMRlNU0FC4qjGdav5duDO5ZXJ2jJN0INk6Bx8/WEI8zqG7bZvrzqpKU609+XucXW7DgYjLUFrTUgM7VRq0YzVrw+A25kJ2aR7hsmwkD56UnKWAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749616203; c=relaxed/simple;
	bh=/cy3cFGZQrjA8kUJrsv7x4uO8fAlZn2KKOd1+tSPS+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nn2kyP9E1SwsaNcvsCiL9lMfksJ4P9u5XR87r3aSpFH/iUP6PXM1BtwepHK9XhHHXZkIX2G33zgPg8emw7ouLuWB+UFAbjbI+CTDvS1r3Zm2aDbZMywEYTWXTuzH+o7aSs17QlgR6Asq8MnSmoGBvrwDvvP36FddQV0X45ab23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3N25xs9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIPujV010099
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 04:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aFtARDOP2AlDHyuZq6XRlZ+tQo7WrRT1O5JCBIwlig8=; b=M3N25xs95oaCrwoq
	PKSiCcT2wyMeg47WP2g+naJamr8j+hqSS7PEF/iyTZDTQcTH49xTd58Iy3q1yio2
	sBWupxBUR8OHuP+sjm9OnWft6B7ofpy8leMcsVB9cHvVIvVsIuhd3j8CGAq/DfLu
	zatgIuAuF6PGu7Zc4Jkh1NITgNNl9+kA3NzXMBRPbWaBkGXVU6zt4kn4/mqE55p9
	IuWJAacXQ0Da7DsQ4QoJShzeJFg5xe3t4we/K+S1hq3ZTd6vFw49x0iG+f4GyKou
	heoQCnwJ7iJPsCdI/QdgwBKNlJ6DJ3KT8ABcMfoCx1ea8sYFyd1VfwmNuI0js7AK
	kI2YsA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474d123q46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 04:30:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2fb347b3e4so1411414a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749616199; x=1750220999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFtARDOP2AlDHyuZq6XRlZ+tQo7WrRT1O5JCBIwlig8=;
        b=qOjFmnWE4+K9EH/hGAehiQxtxjSWVVss5jhMmJ8yvw53KnVim4X/2A89NMdFP5YByt
         fgDt1kngHNxGm2en2tZtZGq5su6gerx1VMYdDIkBduAbLarNrwcCV/mQvhggt8hBlpSM
         J+k7//DayAanuqsQU5teb3EdNn531u56Z9qRKbhSTr0dY1hbFFksUdBUhGMEPFk0EbX+
         pa2HwhLbjbROqgtrenKlWb9kMAdYqmvV6ctU5kHlNPpT0yttchyozSLPbq6g6Bpoy9xf
         pE0yAda/xSybUCmXodNlKkuyoQhJnsTkOcMsbNczPke19o1I0FkwA+oHzNbwGkzD7KV7
         hOSQ==
X-Gm-Message-State: AOJu0YztjdUo0Og6fB28d2b3dNa9Sw2r+3AJ9J3w1MiW5lQkONLD0GIQ
	Uffo5wxaS8MAmNNvP7OhC5p64iHKvFtFr7T6Hz6KSUjBsl89AZDFFCpRxT9V9/DkjhFC8hOp0Zl
	KYQqRRa/BSbUMRon+qwNXMFOyp7Hna0pt/YWlLZy9/qFZTDiJio0BNTOF3vi77/jYFP9UKg==
X-Gm-Gg: ASbGnctLuMRZtp2ZGZpsSfK9xKX/8CmX0/fXfPZivj9pwLbEPueBhAMBERiLLQ8sPqP
	mzOL/ZPYNrG+04Yzg8BI5ptHUTK2WeIMjrki+0y/f4f3ZXbl9BfkruzQpnKDYik6dVtRDpsF655
	Bfg2299lqYw3JwEzvw9sw3/n5zFBSBJOwc5fGA60v/PTK/ABng+Jlv9mj9B5FQYRgNp3+Kz3BEB
	8zln7r142zo09Q7Yse29nGCeYw3mitwelmnYsBGPtiGWHhLbOHBsP5JvTTHSePoWUKwhgxpY+X5
	rgQVBbYdvMlGziA/YZKt2qBrb9elwx3TLgbYvqbOe3dBMIjlscOI7NOEN00Ah2I=
X-Received: by 2002:a05:6a20:258e:b0:21f:508b:1a19 with SMTP id adf61e73a8af0-21f89012d34mr1861298637.14.1749616199136;
        Tue, 10 Jun 2025 21:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3RXR0rE5nurbG9xnt62DUdmYGYdiyWZaxOB+T7XFNV+DgSA+/mJHyeeM29fVAS1b89LKKCA==
X-Received: by 2002:a05:6a20:258e:b0:21f:508b:1a19 with SMTP id adf61e73a8af0-21f89012d34mr1861270637.14.1749616198746;
        Tue, 10 Jun 2025 21:29:58 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083b03sm8208802b3a.83.2025.06.10.21.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 21:29:58 -0700 (PDT)
Message-ID: <92a6a3b6-397d-4cf3-95d6-01b50f827183@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 09:59:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band capabilities
 element advertisement in lower bands
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
References: <20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com>
 <4ab522796b91ed3421991799d3a7831a3c0ffb53.camel@sipsolutions.net>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <4ab522796b91ed3421991799d3a7831a3c0ffb53.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: adyMWOkW0HG_pGYoDKpwhnZnT4HcEAnQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDAzOCBTYWx0ZWRfX8Jdq2eSVbOMn
 C4WW2geLcDCq5eHW+uiXo+7v0harRFuzThhT/pLfeyBgYoIviJpH4EkbT4n51TeSnhc+Rz5hzNB
 teqOW4aRrvEvcYsfPU7kIPZH+kzk81PdKj5Tn9pU3NT6aki0PKjZVWtwZ+xWyRJX+IGMCj+bp2B
 T3U4gyHphxk4ShHxL/huCbb04KS4oe4Wk+qwaX4SmWh1l+PRrWRbKzqbUo0kVukGNngHDjNL/6P
 NHocMgKHSnTj4OMuNL0fYtRxJYJ72N/qadobQpXF7C9wdz+WU6yQib0DnfHrrmIPCBsequc4we2
 2ATquEaahOg5WTik+IkbpwCyN1yZuocZwIeURE6JQJnLOCorhR28SGVPKekiaMsENEgt2kyA9Yh
 tZQrxPz156wfX4XXxzRUBMj2nRxeAttYqbHMTcB2BDM9k2vVuj4NA1a9DfdBTMjEw023a/0c
X-Authority-Analysis: v=2.4 cv=GYkXnRXL c=1 sm=1 tr=0 ts=68490648 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=r92t2ldJ_5HJaPd4Q2EA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: adyMWOkW0HG_pGYoDKpwhnZnT4HcEAnQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110038



On 6/6/2025 4:24 PM, Johannes Berg wrote:
> On Fri, 2025-06-06 at 16:14 +0530, Rameshkumar Sundaram wrote:
>> From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
>>
>> Currently, when adding the 6 GHz Band Capabilities element, the channel
>> list of the wiphy is checked to determine if 6 GHz is supported for a given
>> virtual interface. However, in a multi-radio wiphy (e.g., one that has
>> both lower bands and 6 GHz combined), the wiphy advertises support for
>> all bands. As a result, the 6 GHz Band Capabilities element is incorrectly
>> included in mesh beacon and station's association request frames of
>> interfaces operating in lower bands, without verifying whether the
>> interface is actually operating in a 6 GHz channel.
>>
> 
> This is not incorrect.
> 


While this might be appropriate for a multi-band wiphy (i.e., a single 
radio capable of operating on both 5 GHz and 6 GHz), it may not be 
suitable for a multi-radio wiphy where each band is handled by a 
separate radio. In such cases, the Mesh BSS could be running on the 5 
GHz radio, which does not inherently support 6 GHz capabilities.

Should we change this specific to multi-radio wiphy ?

-- 
--
Ramesh


