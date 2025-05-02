Return-Path: <linux-wireless+bounces-22358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E936AA76D5
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12BC463476
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033B25B1E2;
	Fri,  2 May 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fJ4Zdp84"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F152A25B66F
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202370; cv=none; b=JrX8BDTlNOU+EH9RxEDhkmEL0XE/7BiWtvL/sB2dtDya/Ig3Fxt0p0zf0mZW8VYJBbslpPwI4TxxV7Re/lPHyRylaEMot7XLnptsIrEIQ0Iee5CtEzM1zbHdf4OK6JITFaoq78cKuQDqwzZjblkkEqT1fphJygGt1fSLised+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202370; c=relaxed/simple;
	bh=vqlf+EGTxj1bxJml0150XPwafAzm/k8Tm/qHCzVg11s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aVwNuLCx7ueONytWNOX/ZvY8XfBFHrWajX4QcvkOfiTjBB4cEBOrZRHXhVGjAMnqJmYUG4h3HG0x8S3DvwAvTqaSQfXK0ZpKwyAd9sIot+SMz5WM/5ZcBu1Z8ncOItr4ffR7WFtAXHqOSJHwLyqk1+lLY4Urs5nXRUPyAzKx0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fJ4Zdp84; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542Df97x015024;
	Fri, 2 May 2025 16:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ih2dFglG25LGT4lDlax5ZQ7XQ02yUGxxjvl/fQ0VETs=; b=fJ4Zdp84HdbBA+3p
	vEuPiWUa9/UYDDspJ+EPvC9DtXi1avpPcTgiOHlFK5WPlRdcoY7BWbhkMi8VVdbv
	TtKxH2VAJCfOt+T2cp4nzTCso4KVKCQBt8kOjQptUMSTJxey5YvbreV5FM05bjJu
	dn+M6942WoKZO1sUbaPcj32DRhY0Z+E7lJREMzjr89iwesoyVlQXzGDYq+FpU4NM
	yFrXxHt0zYh+LFhit10faWUyqgt1pu7YbH6gc6rOj62kt/679RaSHRsD1gUOSvCT
	RXY7SFiJHweo+7VdCwx3WoVnsQyIJxsP5CtBwlHFgG+dP07pv6/WScV5gcVXhGSo
	jd4bog==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6ub0rh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 16:12:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 542GChw0016422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 16:12:43 GMT
Received: from [10.216.45.240] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 May 2025
 09:12:41 -0700
Message-ID: <051959f9-9ada-48f1-8835-949fb128face@quicinc.com>
Date: Fri, 2 May 2025 21:42:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: Update MCS15 support in
 link_conf
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Dhanavandhana Kannan
	<quic_dhanavan1@quicinc.com>
References: <20250424043256.2982345-1-quic_mkumarg@quicinc.com>
 <046188792efada343c12476e5bc00247a61c0fef.camel@sipsolutions.net>
Content-Language: en-US
From: Mohan Kumar G <quic_mkumarg@quicinc.com>
In-Reply-To: <046188792efada343c12476e5bc00247a61c0fef.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dTnb9WmYyzjBewUJz4Rb-imXKvTIPEi8
X-Authority-Analysis: v=2.4 cv=KtlN2XWN c=1 sm=1 tr=0 ts=6814eefc cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=J6AeBK6vHFpIzhD8hhEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dTnb9WmYyzjBewUJz4Rb-imXKvTIPEi8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDEyOSBTYWx0ZWRfX4wyhufVVAfDa SF5Mn6eIP+Tgs3Ra3h9vttKOcU7W5FQ7q7HmfuOJJgZfMRtDH3+z9KPHP903ZitGCUVC/9sW9Nk Eu9vtkdAr3Zl8BE4m42+yBAQ4zXdHeYLmXUfyqsnJHsh4+dUoB56hCpMBGstkF2JxrhEqcQVBY7
 2r51UPoZCKqrghUWgP84g8WR5VuLibnucHRAxHeMIQH0SXVtlnyWvcDXSeteYDImDxHbaOybfcF QsCv0b8n154SiBfN5XlkHrDULM2FtNoDZuXtbFb2h+h0IVgz6juXpUu7ZiL6SzTfycsUnjiSkvl 724SwwyoNnwmm5zZsTuGmX8+d7N4jvDs79tCKSw04wtq2a974PSwMCna/cV6HyBIBb8QVfK+6Bb
 Ugr0LR/iTiEd516hOtBCgfh1oy1QFyfGm2zqowpCuzVH5kL+u6plNy2EOBYupe6cR7NyLI1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020129


On 4/24/2025 6:31 PM, Johannes Berg wrote:
> On Thu, 2025-04-24 at 10:02 +0530, Mohan Kumar G wrote:
>> As per IEEE 802.11be-2024 - 9.4.2.321, EHT operation element
>> contains MCS15 Disable subfield as the sixth bit, which is set when
>> MCS15 support is not enabled.
>>
>> Get MCS15 support from EHT operation params and add it in link_conf
>> so that driver can use this value to know if EHT-MCS 15 reception
>> is enabled.
> I guess I'll take this (modulo the question below), but I think for UHR
> we should probably just pu whole fields there rather than splitting
> things out, that doesn't seem all that useful?

Yes, putting whole fields would be better. Will try to handle it as such 
for UHR.

>> @@ -830,6 +831,7 @@ struct ieee80211_bss_conf {
>>   	bool eht_support;
>>   	bool epcs_support;
>>   	bool csa_active;
>> +	bool disable_mcs15;
>>
> Perhaps we should group it with the other EHT ones like
> eht_80mhz_full_bw_ul_mumimo, and also use eht_ prefix?
>
> johannes

Sure. will make the change in next version.


