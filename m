Return-Path: <linux-wireless+bounces-21951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 855CEA9A039
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 06:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E9219460CF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 04:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450019DFA7;
	Thu, 24 Apr 2025 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IgcKTvyw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20F4A23
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 04:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745469973; cv=none; b=I8C4jAs+iHd9UdUFWsFCieJBOrOcL1osYkDe1cQu6yFqP3TEsXVcLzM3d6KcCxZus8PjPLThrybLh4hsqZkBt4oeWrLzOV0gm39pGkX++JZgZZ4GwdN+HkrpsLzcUs1Xl3AsYGcFlc0EWosqxCBdD6npSP6Ev897CYX/JebArIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745469973; c=relaxed/simple;
	bh=ZVTjvcAOfBho5LntO9IYCxYMfTBVefDw78nsj4+bbnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KaquVuxUxaBZRk2nSO4UVd2bqhZ/WF9jmob5c4QEU5LGTb5rRejkXWoP/rik3z4l+F4QeEAKXyjw2ropGcIJf5qtW5CIm4GEFfVd6KkmvSuViA/2qI7aHPaP5jzgChGxGi81Ue79guz3WB1AL3y/tvevbDR0jnvXBC9jAnwbSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IgcKTvyw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0F6P0010223;
	Thu, 24 Apr 2025 04:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+h66oghW3HomQFGX1dAUJreHijRpmjNos1nJ+hoc6vg=; b=IgcKTvywkt3dOwfH
	Xh09O1NO/w2RvmeI8WZ4brrjPpt3bAVeRO6+C6kW2w7iCMDYqPhE726HfKGLSezZ
	40Nh4M+OTrjlrpGLWpST3I4fq10KhwPv1UwSQK5HkmMTP3BAsJ4h4CeQ2QODlIdY
	mumck0ZIzsxNwcrCpFdX7h4w+JTYoS4shd79jaRi8ST2KSDDpgCiVNMJgt0x8oLd
	D0CiUlm6R+l36TXOCIwvGonBEN0rLtzS7UnZkiYoKn8M7OL8ZkxPlYWsYAh4jedt
	RtUpQqXleti+mw3E3dXAIeQXNjP1YvFyrjPoj0qOIvwUeVaXLJt9XyPq0M7yHP8j
	BB5svQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3m75y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 04:46:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O4k4XN025958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 04:46:04 GMT
Received: from [10.152.205.125] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 21:46:03 -0700
Message-ID: <e9a8d9e0-7b5f-49be-996d-f61651561992@quicinc.com>
Date: Thu, 24 Apr 2025 10:16:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: Update MCS15 support in
 link_conf
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Dhanavandhana Kannan
	<quic_dhanavan1@quicinc.com>
References: <20250424043256.2982345-1-quic_mkumarg@quicinc.com>
Content-Language: en-US
From: Mohan Kumar G <quic_mkumarg@quicinc.com>
In-Reply-To: <20250424043256.2982345-1-quic_mkumarg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FGbYUr9Lnwe_g1BYRZe4zEsAp9vrUOaL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAyOCBTYWx0ZWRfX8MIzEXTthjkV hfvLtY7FOwGQjf4ue9AZQslXOz2cGWi/x6truSDxErMpYNGWG09enVxHDczOR/zLiZOt6gskTUW oo3rIKqyumOe5w6OB+Nqn3v/gHm3LmxAiWMV9G0cvwO7KZWNdQyX8nmdleGrKsrksgx5t5gbIV+
 uTa69ofnDuSEXPgV/MzRoi2DHuqWqypvoqLBm/OLg/lvjDG51WL9HwEDLI7SaLBBgXlzqhrNkM7 EVKvxbSsqpRAX+E5Q4TE6nBTud9RBELRpwiJvVvNHgBRCZK7gUXXPC0JMHhNp4JJwmlXygU/vsF SjHjxr35u+kOC/u1lVul6KX/IO1+hwwAFAg3yy6jVAj7x5DkRLoxomSgG/iRpXpl4pqd+tIFX/J
 zxBh/fYeKiRVL4/H4vHXgsu+xy7Kt7rxWdmqNxUDBNH3BHQ90MgPcNs1e31etZitW6YFrSwq
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=6809c20d cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KWIm60pxQzOdfeBkbBsA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FGbYUr9Lnwe_g1BYRZe4zEsAp9vrUOaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=699 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240028


On 4/24/2025 10:02 AM, Mohan Kumar G wrote:
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
https://lore.kernel.org/linux-wireless/20250424044000.2983913-1-quic_mkumarg@quicinc.com/


