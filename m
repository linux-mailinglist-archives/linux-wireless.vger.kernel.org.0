Return-Path: <linux-wireless+bounces-22459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92E5AA97A4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23436171CAA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A225D91B;
	Mon,  5 May 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZOaOSYCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD7125D203
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459601; cv=none; b=MyO2AlT6CKBFQNFSL3fEGCyANHKXhV34442rPKBwv+gDca+HqNgfEaXj27b9Z+ogtweTgE9yRFlUxs7upHl25vCgPl0RD0yplmuu66/7/GWJ/7AYqvBgA2cR0FVyo+qOz4UBJTbDrsZOm3By6u5AzbDsIB/WekOme9F8zStY8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459601; c=relaxed/simple;
	bh=GCjVRhJedbBQ5nKr2sMqAoyX7GEfSsAhJqn8wg9Fp/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bTCwUqDbGE9wKp+8KUKHNLf4hmNballFfNOaNiLy/WwdXOmSOtp6Gdh+nl3YvW8DyoLiWuJZbDrPWEW8FIzmP4D9D9+yz2nM/FIvxpFRbwO87KjnLhk0Yf/aKvmLNQn6E4SXkdoNJfJP0hARutzqVkHqnliM1snxHrhKra+XMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZOaOSYCa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545BbtPD017230;
	Mon, 5 May 2025 15:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nDb9ZFmDUYAMKLFSvUF+qoNmfJc+FlNKpdHG1oUOfxY=; b=ZOaOSYCa/aDlQbGW
	5QQOEPbxnkCMcj7uJvo+Lb7OHlYgVfC4EYfppTV1KzJbMh1NEJNSJlya+HPn+3uC
	j+vHCaB6gpLOHFag8brm8wwXOxDqU67PCwDNldpvRwvGzNkM2A0ry/LLujSIsMKC
	VEJ72g5knrAp/IguDaC+8XSYIX43M8x82JNP+4RbY30kUjeni5g0puTWUREe2IMx
	d5GNMcsDSx/cJewa1sejYiQ4l3lauIDr2d6caP93x6lx6YVt5wCl2hcVTIuWhRMu
	Kf63XyiK/6TaQVk0/gBSs72ORh2mVId6GeDfKjXgBfwVdoFKx0FDNmOIe9LhDcOQ
	toKh9Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dd3n4cy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 15:39:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 545Fds4F005191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 May 2025 15:39:54 GMT
Received: from [10.216.3.116] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 May 2025
 08:39:52 -0700
Message-ID: <d4450ef8-5463-4f5a-a5e8-15cad2349883@quicinc.com>
Date: Mon, 5 May 2025 21:09:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: Update MCS15 support in
 link_conf
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Dhanavandhana Kannan
	<quic_dhanavan1@quicinc.com>
References: <20250505152836.3266829-1-quic_mkumarg@quicinc.com>
Content-Language: en-US
From: Mohan Kumar G <quic_mkumarg@quicinc.com>
In-Reply-To: <20250505152836.3266829-1-quic_mkumarg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE0OSBTYWx0ZWRfX/Kzb9zLFzee1
 wfyWebCklgYLzLTLtVVt8k5/Xw/4zkQOpt10GrHAGHOFOpSNeCj36XQp1UryzecqceAsJrf9QYK
 G/h0mRhUuZzY3wU2MSIHWbYKLUJ13mAtLt9RmNLkpwexydt9DzkKR4RgKK1cxqFxJfaeDdiPqpA
 KYfvYKqB8+4hViE88TpPP4YsQZQS0JXgu4+w46oaCGe5oAq5Asn/KPtjBs7h5SzpPPbJN4kVUzB
 dIGEoSQmnV3FeytTpamJpcMOsNdmSZDPQUgJR0/GvM83/6rrhjCYIWVWo+ywOUC0e0yK0J7vnb8
 xgFFk3jOUWofneSZ64mFBxTqTirIVNT+GMjgtm443vvTsQwpzHaWdqT0ldQZgaNIX1JleOaVfiM
 L6W+qc+B34wRC2m3DQXRNgCR8w9Liimj7MwPOTHMb3aDnvrnS9hedBHncJ8r464e1D1bRRMH
X-Proofpoint-GUID: al6i1JXAxKv_9Q7cgAQJKZu7cDCkjqf3
X-Proofpoint-ORIG-GUID: al6i1JXAxKv_9Q7cgAQJKZu7cDCkjqf3
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6818dbcb cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=KWIm60pxQzOdfeBkbBsA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=703 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050149


On 5/5/2025 8:58 PM, Mohan Kumar G wrote:
> As per IEEE 802.11be-2024 - 9.4.2.321, EHT operation element
> contains MCS15 Disable subfield as the sixth bit, which is set when
> MCS15 support is not enabled.
>
> Get MCS15 support from EHT operation params and add it in link_conf
> so that driver can use this value to know if EHT-MCS 15 reception
> is enabled.
>
> Co-developed-by: Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
> Signed-off-by: Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
> Signed-off-by: Mohan Kumar G <quic_mkumarg@quicinc.com>
> ---
>
> NOTE: An upcoming ath12k patch will utilize this change.

The following ath12k patch will be utilizing this change
Link: 
https://lore.kernel.org/linux-wireless/20250505153536.3275145-1-quic_mkumarg@quicinc.com/

