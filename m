Return-Path: <linux-wireless+bounces-12931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D697B704
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 05:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852871F226AF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD027711;
	Wed, 18 Sep 2024 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JMHZyn18"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08075EEB2
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726628791; cv=none; b=RNNS4yew9ghOkGtCJyzOtbMgj9IPYl45lvrVEHtAAX+djQ0uYngPM1zhROLdCwdHMZY87lYnS6jQWfEArmv7ZOmWvG8AUXWlLdU2T7/3M4AglLvf1b1Vwe0b+/Ue8guEaWDp5UF08cQ1A6dMyWc3AXp9hpiDuBDGx9ga7/MQ9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726628791; c=relaxed/simple;
	bh=zqo9QrGQ3hwH+0RJ9L5f+lXkjtFH32jspte01IWV+Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uVb4jKuRUvVV0RVtCgxvG8Ul8CcKnmiFEyio8ftcNWDSHMuXV0Y0R3f6jVQ8fRBaAh3QCHb37uA5Zg9d2FFw1d+ruZztZcoK/F/9SpPwmfMtfgLgk/UqzZorBJlnOhn9IJpnp180O9x4z6AkpNQSSSJOfy04hYHPnB29l6X8wKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JMHZyn18; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HHk45S022323;
	Wed, 18 Sep 2024 03:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ji+S/8uP1cN9CTE92uVBGjy7oW7DWsdrd2yCNoOMh8c=; b=JMHZyn18gma0wICA
	/lZuuMmndravjAGOjqeNnj3Cft4Y9HdAwRVJ/ol7qVeIK+kPs6T0yaOBhilIySvs
	aXcUOVK1kgPfgUv4Jwzr2YxLv272NbOTUbpTQPVpN14VESzASwTKaduLJi1bwEhN
	icEEgJWFgGCZInGvOQ52kGr/LdHVL+fnlkrhDALlHvmi86mh+He5xZR/RXOZR+2E
	ToI1Ro4d8lWLvewQ0gLXhTUbZSQaBQxghpsLHN1+gSH6FxtzxvmP+p/4S5qe9XCN
	S83JTzp2EpQR07C42IwlAPjTGDijzIfLHduXsijfpij88TtXItBzora2WEUYbXqp
	R1thZQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gd0jqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 03:06:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48I36Ltq015028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 03:06:21 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Sep
 2024 20:06:19 -0700
Message-ID: <2e42483d-39b2-4042-b2b2-4c6be8e5ca60@quicinc.com>
Date: Wed, 18 Sep 2024 11:06:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k firmware regression with update 82318c966fd1
To: Takashi Iwai <tiwai@suse.de>, Kalle Valo <kvalo@qca.qualcomm.com>,
        <maxwang@qti.qualcomm.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <87bk0nc1yb.wl-tiwai@suse.de>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87bk0nc1yb.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JAo1wBWUTnY6TC2IilUT__dvxGJ5W8oL
X-Proofpoint-GUID: JAo1wBWUTnY6TC2IilUT__dvxGJ5W8oL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=849 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409180017



On 9/16/2024 6:44 PM, Takashi Iwai wrote:
> Hi,
> 
> it seems that the recent update of ath12k WCN7850 board-2.bin update
> broke WiFi on Lenovo Thinkpad 14 Gen 5 AMD.  Reverting to the older
> firmware seems fixing the issue.
> 
> The report for openSUSE Tumbleweed is found at
>   https://bugzilla.suse.com/show_bug.cgi?id=1230596
> and for Arch
>   https://bbs.archlinux.org/viewtopic.php?id=299286
> 
> Let me know if it's already handled in Qualcomm and the fix is
> expected shortly.  Otherwise I'll try to revert the change locally for
> TW as a temporary solution.
> 
This is a known issue and has been root caused. 

+Max to be aware of.

Kalle, will also Cc you in the internal thread.


> 
> thanks,
> 
> Takashi
> 

