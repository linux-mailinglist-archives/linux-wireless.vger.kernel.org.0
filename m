Return-Path: <linux-wireless+bounces-23016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6210AB8C6F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995311BC03F1
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4222DFA6;
	Thu, 15 May 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hz4T6vED"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CFD22CBE6
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326480; cv=none; b=qPol2Sb+Bo3+sAhgD1/jhvnG5bKAEjMG1MSNcRMl0P6OTZsFfyvLwaFVvoeRRA69s9dd5EyLEdaeoNl80rfH7UAEsnDUx15fJQUcwy/0Lis0oJCXxWB9BPEdAKLHP3XC76YAXjcmrq0swljFCnkdMy1qehFIxotoIkQJMjq70fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326480; c=relaxed/simple;
	bh=8ffIgTCpff9z3CABIbTJiuGLPgmv0s4yHXE3EAKQGmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C7eEoaXh5lmINdX5Yem4dS7xUH6GMDRjvoi5qEq0P3q/u024Mv3Bs5PB9KkUDqNHX+UWM+WBYgqAkDwt7XEV0aO11VpeL4UFuwx+vt1fyZfzX8b2dQxUrGLJBOpqnxsziQ+I50o9zBdz3AIl461DdsNUqZnavGD94LsucVEhKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hz4T6vED; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFNBw031647;
	Thu, 15 May 2025 16:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EzfVsgWkMOAukQ/7EBMV6xkpd7XfVlJIa4k62EdLdrU=; b=hz4T6vEDUcxwbwCP
	MYhwW1SZ6dXqd2MJRSptZj6ktOR9hNtB+2TOEEVwMaiDfX9uy0Ksj7o5XzdqZyHh
	0eB++tXQYHFq/Kbr1R94VWpPHpHOmQgcrNhBmlscVnlZNfyilGIQzod7p9u+zu4a
	BmcyvLCy0oqCCZj0Zoza9rCzh+Oy/pCrJV5GHbMag0xjaSEvlMv7CYvovwD6Uswf
	+N9yYO2dBrzgoVhk6+QdiRr6J3Q6Trqk3qSuzv2Fi7cS1WMLtBDAZI0UkrpAO5Zo
	19eQEXkcLQmCH9RWQRsrdkmQNfezOsSH8cggLnD4XOduKqFQI7GWK996SiwQ+DWo
	v/FxBQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr6qdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:27:55 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FGRscZ017017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:27:54 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 09:27:52 -0700
Message-ID: <e54abbd6-38b0-4c25-921a-a5bc7e93a89b@quicinc.com>
Date: Thu, 15 May 2025 21:57:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 00/10] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <e0c26227b8023ab046606597ecddffe1c3aea307.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <e0c26227b8023ab046606597ecddffe1c3aea307.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8iYrn_STE-6cEk5-2hr193nzy9UEunHs
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=6826160b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=eUjCFOs7kr1z7d3O7SIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8iYrn_STE-6cEk5-2hr193nzy9UEunHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MyBTYWx0ZWRfX7AVhOqrXo6gI
 BsBUTlcqZdUFxP1/OMzhzpC7wKJDtSossVCJmYj7ECxu7fBujjNenJY7ENX1KCIfe4g77odzj4C
 UZ+psKxsYdx+IFx56Ymio+/F0X3HcoSwQPsRZsiMc6YwlsP75QR2RVP/b49RxP1wxYu3Up+lpb4
 TRKiMpFqcojgaUjhLVd61aRHGwVvK1PuDhCAAso0m96lc/1s3wfW9XN3JVyg845j2Oy163PmE1+
 L4owgH7/2lyPR9KYPqhb90rs1tLmv6nhdUCDMol6VrT6MLVGq1yzxNF7zDe1hTCwuQpzpJ4vVdE
 xggwXet1xpuPG0tWTfXp0SeY123xXtVOYJ60gsRPUPb36eCjJf28Me01hEU3Oq6wL6Ii4nNDR42
 lPdC8JdxPE7rq6mqr+SEALg2pV6PHifpdaOIjKbuuIjBxMwjW80XHhWpLN4Qp+QRhJpNAN9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=799
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150163

On 5/15/2025 4:49 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>> Current implementation of NL80211_CMD_GET_STATION does not work
>> for multi-link operation(MLO) since in case of MLO only deflink
>> (or one of the links) is considered and not all links.
>>
>> Hence, add the link_sinfo structure to provide infrastructure
>> for link-level station statistics for multi-link operation(MLO).
>>
>> Additionally, accumulated stats for MLO are included in a concise
>> manner to provide a comprehensive overview of the ML stations.
>>
> 
> Uh. So I really wanted to apply this now, and also started making fixes
> to it, but no, it's not really working for me at this stage.
> 
> I've pushed what I had to wireless-next link-sta-stats branch so you can
> see what fixes I already made (and pick them up), but I have further
> comments.

Sure, let me go through them and fix others.
Thankyou!

> 
> Jeff, I think you should probably get stuff that doesn't depend on this
> out soon, from your pending branch, we'd have to have really quick
> turnaround on all of this to get it all in place for 6.16 still.
> 
> johannes


