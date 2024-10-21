Return-Path: <linux-wireless+bounces-14258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC19A619B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58071C25A2E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC8D1E47A0;
	Mon, 21 Oct 2024 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ixmP3xlk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03D1E3DD8
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505282; cv=none; b=VMBOap6+knGdYzl2ijddm7xUWJiSsnWCHHDOMHH/hHbxZtJkySXgm2ztQZnH+jbSgm6f2Y6DkZlFHuDeDfWrPfcUcYqiPCFCIVKiXHm4WozZ34asXkxUky867Sxq0Ol2HsSOD0s9ASOghe5vpT8lAA3q5QVYQDZZWjCvgP8Z23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505282; c=relaxed/simple;
	bh=5iyCNliyA2rC7V73dM2qJZVUZtDJa6m5er8LRE6n+Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OWLHZwtewmL0ne9HDgoftm+257ged2XjlhvTA8juQFOFVpCyvSvDmfoMIT8EhBxl4K43/wN+T4g9lyWKlGwU2kULhTo8qFkXN9cZHKWoJPpBuevVkEmKSelrDnWA6LbgB3q50thWsgb6EMOfYEfKuDRYstKN5vC+rC/5zpV+94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ixmP3xlk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8JuEm009761;
	Mon, 21 Oct 2024 10:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iWo8Pym4EV7M/2JcewfNDXLy8188h0O/asmvPBrpBpg=; b=ixmP3xlkbq0tMF4p
	CLBuy5AGuDQgELAZk0QGw3Vbwi3AmOFv6cZFWVjbfnN9X8hFibZFgV48e3aRIUIh
	nxHdMzpq4AkPdNM/3WSg3pj1Lr8ACtdPeSNDj3N6bN5Z/OykBpKLHlvrhRygE14S
	79HZCrDHZQtkJdIQYv9ds05v3QfT3+GIxbjvqn1eMtWyRbNDEon0eMABtoEt+qVU
	gawijUPoRhbrxXoklM+qJf9TPGb0RXi7p2R3XuupnBRlINcEaxuasZcD87NEBznF
	pfl5khR0jXHgxKuInpvnHXgTjUt3RjPUW8QHkJwfWqCX+rL1UnQWVa3YAStdMIqO
	zd+CWA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkbt0eyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:07:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LA7sVD023973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:07:54 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 03:07:53 -0700
Message-ID: <3fd7b2d2-21d1-4326-a104-5865b49a0600@quicinc.com>
Date: Mon, 21 Oct 2024 18:07:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi GTK rekey is not working with WPA3 SAE encryption
To: Kalle Valo <kvalo@kernel.org>
CC: <johannes.berg@intel.com>, linux-wireless <linux-wireless@vger.kernel.org>
References: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
 <874j55531n.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <874j55531n.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MLAIoy2MswNeDp24ISnyow3-pk-NW7xM
X-Proofpoint-GUID: MLAIoy2MswNeDp24ISnyow3-pk-NW7xM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=568 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410210073



On 10/21/2024 3:27 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> Hi Johannes,
>>
>> My AP is configured as WPA3 SAE encrytption, and GTK rekey interval 30s. After enable WoWLan:
>>
>> 	iw phy0 wowlan enable disconnect
>>
>> and put system to s2idle state:
>>
>> 	echo mem > /sys/power/state
>>
>> I see in sniffer there is M1 frame from AP to station but didn;t see
>> M2 response. AP retries for some times but finally kicked out station.
>>
>> such issue is not seen after changing AP encryption to WPA2.
>>
>> HW in use:
>>
>> 00:14.3 Network controller: Intel Corporation Ice Lake-LP PCH CNVi WiFi (rev 30)
>>         Subsystem: Rivet Networks Ice Lake-LP PCH CNVi WiFi
>>         Flags: bus master, fast devsel, latency 0, IRQ 16
>>         Memory at 603ebb4000 (64-bit, non-prefetchable) [size=16K]
>>         Capabilities: <access denied>
>>         Kernel driver in use: iwlwifi
>>         Kernel modules: iwlwifi
>>
>> kernel is from https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/ and with version:
>>
>> Linux xps13 5.19.0-rc8-wt-ath+ #4 SMP PREEMPT_DYNAMIC Tue Dec 26 17:02:03 CST 2023 x86_64 x86_64 x86_64 GNU/Linux
>>
>> is this an known issue? or am I missing something?
> 
> That kernel is over two years old, have your tried a recent kernel
> version?
previously I just used an existing kernel and tried. just upgraded to the latest Linus's tree, but same issue.

Linux xps13 6.12.0-rc4 #3 SMP PREEMPT_DYNAMIC Mon Oct 21 17:43:05 CST 2024 x86_64 x86_64 x86_64 GNU/Linux

> 


