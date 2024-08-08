Return-Path: <linux-wireless+bounces-11130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0039494C2ED
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958571F238E0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0FB190055;
	Thu,  8 Aug 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JAgvpV9s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D437646
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135362; cv=none; b=kg1CfM/z9hiwNZou4uGaE+oBgljeSu7L055ByDWvAJgdEJsG9qSt0NSspv0p4cIYX6LONdomj5JSShdZADr9m/c58oO2jPEpdPxCqvCz2yjdQ9ivZEMgVTgQ5DGAqRpVC7y5ZzHBCutD2yu8uNYBDd4z1HQduvs8enXc3QZASQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135362; c=relaxed/simple;
	bh=gF6+2Uncz1vLgIteEZKracOzmek0A7mf9i/eywJ1gyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T4DH9Ly2cfbnUloc3HECCH1MZOoNvagxC2aaKGc+z2hkKYWCeQiQVxy8NiWLhc1FSY+ExFPIcyrXNpmtwIriFObJ0m+ZBZV4Ehfpf7SLJnud0JQRof3WwQ/Kee6yWnMrTo2iVik9bH1vtUfqIUlPPthvmkcanhP3qbh/7x8WMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JAgvpV9s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4788LI45015951;
	Thu, 8 Aug 2024 16:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TErOO3BhCJh/V9NoDcPUFKZgt/FunBQixzxy79apBUo=; b=JAgvpV9s/zuiUI/m
	/W8J/gWD4Z2OhGuLeD6k6pZohlQdQlsfPIcGOX9UZLnlgWxNlPtLIOK2Hw6j1LLE
	breUKcBKEdGuZFlAsKAfrhIbt7cqC/f7NlUC/mcpPQrHvMaGVYVQxASQVYCXGMLw
	vMfQTXbdU8sSjbsAGOxqfSlx7cnkNPm1wvMf4apK9hbpvDIGllATu/v1VJbCbd3z
	abeH/4l5/fSOFW3yQfcXL/n9LfhD0GOE+fSpjKdeLUWEKx9XqMw09gwQ3c3jypY7
	4q1ONqjB74PpNZBWhEoUxVpqxMrBIpH5wirUIsU3hBxMLf6SC+IrpFFX/0ZjhNAo
	A0p7jQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vdupk2g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 16:42:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 478GgXkD006968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Aug 2024 16:42:33 GMT
Received: from [10.216.6.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 Aug 2024
 09:42:31 -0700
Message-ID: <2b78c227-ef2e-4d98-baf3-762e4f5bd155@quicinc.com>
Date: Thu, 8 Aug 2024 22:12:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R
	<quic_srirrama@quicinc.com>
References: <20240711165511.3100433-1-quic_ramess@quicinc.com>
 <20240711165511.3100433-2-quic_ramess@quicinc.com>
 <87frrj70nz.fsf@kernel.org> <87sevf2seg.fsf@kernel.org>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <87sevf2seg.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fOLUs39lLBhegDJIMfjyyRBqBiFVXVp4
X-Proofpoint-GUID: fOLUs39lLBhegDJIMfjyyRBqBiFVXVp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_17,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408080119



On 8/8/2024 4:27 PM, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
>>
>>> Locking:
>>>   Currently modifications to members of arvif and arsta are protected by ar->conf_mutex
>>>   and it stays as such.
>>>   Now with these hw level structure (ahvif) being introduced, any modifications
>>>   to its members and link objects (i.e., arvifs[] which are dynamically allocated)
>>>   needs to be protected for writing and ah->conf_mutex is used for the same.
>>>   Also, atomic contexts(say WMI events and certain mac_ops) that we currently have in driver
>>>   will not(shouldn't be allowed) do any modifications but can read them and
>>>   rcu_read_lock() is used for the same.
>>
>> Please elaborate more about your locking design. Because of past bad
>> contributions from Qualcomm the bar is really high for adding any new
>> locks. I'm doing the locking analysis right now but it would help a lot
>> if you could provide your own analysis.
>>
The new ah->conf_mutex is particularly introduced to protect the members 
and dynamically allocated link objects of ahvif and ahsta 
(ahvif/sta->links[]) in process context (i.e. between call backs from 
mac80211 and ath12k's workers)
The same is protected by rcu in case of atomic contexts(tasklets of WMI 
and in datapath)

The usage ar->conf_mutex remains as such, and replacing ar->conf_mutex 
with ah->conf_mutex was not considered, as few of the workers(e.g, 
ath12k_sta_rc_update_wk) rely only on ar lock and wouldn't really need 
to wait for other ar's to complete the same task.

>> My first impressions:
>>
>> It's really confusing to have two locks with the same name (conf_mutex
>> in struct ath12k_hw and struct ath12k).
>>
Makes sense we could rename the new lock to distinguish.
>> struct ath12k_hw already has hw_mutex so I'm even more suspicious about
>> this locking design. That's not explained at all in commit messages.
> 
Ah yes, by the time i wrote initial version of the patch hw_mutex wasn't 
there so missed it, Seems we can use the same lock for this too, will 
check the feasibility further and update/send v7.

> I didn't get any replies, and my own analysis is still ongoing,
Sorry, was off for last couple of days and didn't get a chance to check 
this out.
  but the
> more I look at this, the more I feel using two overlapping mutexes is
> overkill. I'm starting to wonder if we would convert to using
> wiphy_lock()? That might simplify things significantly. I should have an
> old patchset doing that stored somewhere.
> 
Hmm, i remember usage of wiphy lock globally had lockup situations in 
ath12k last time around, if we could think of a solution for that i 
guess we could try to replace ah->conf_mutex with combination for 
wiphy_lock and rcu.

