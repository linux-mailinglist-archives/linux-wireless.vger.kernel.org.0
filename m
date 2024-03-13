Return-Path: <linux-wireless+bounces-4694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1E087B262
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 20:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED060B3593E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EEF524DD;
	Wed, 13 Mar 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jTKiTusy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8451C59
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358362; cv=none; b=gvsbZD2IUDZzQeDDrwHvCqGHuyIOwB1wde+nABeSMX4kCNj5iuJ3dklj4gePmZ7hP3LvhzieaaSCeBhKRP2OP2onTD5Un12p9Vw4RZB9h6++mv7Leh1I8x2laC7GJsFTETzaz/zBcCgT0qiZJDwz7ZU9hgq3FgYANvfDgvrrjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358362; c=relaxed/simple;
	bh=dz2qUhYwqZlLBNAXo9ISbibTdCv8OLaCNGW5h0a+dy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HZB9agJJRfC2oOMBxMfuEpbbABqLtzNJX8Xqk7qKW7mC7gqhhoxtZDXOrYH0tW3YuS7c5C6wyzi/HKCRK1esTHxzGke2/3lfJBTmG/caC7WIiPVWf8YU3qnzhoS0JZ5qzVNHyKAcA3natZh8wMhQhXJaFk2/uvvAs7bpuLMBp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jTKiTusy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DHbiiu007534;
	Wed, 13 Mar 2024 19:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CdpApk3S4HSr0CiXYnW6tPkH4TA5GMk3//SIt+Nkpgw=; b=jT
	KiTusy1bseVrSEeBryccPpfUHWFiW+wGluyOTj8dTHj6Jhw8vUqIbkTqlHRtCDV+
	pXrhC8fAui3I0PX+JadDnn8DnG8qxY7U16LvkRpA2xxu8URCocwrrdl3vdviFUXu
	ygBz6TUMk0Seugn5Db5w49gCz6x1aWk9urMqbJCNbhUu0NtDifEgsyBHWjnL1lSn
	d77hz7ZYs30W7abD5RYwsoiiNK9y8r+p5JD4EcDAkOkK8YMnj2xlemn5o59BMHI5
	TubTlg4ggwibVM9Ex3JvDIpijwTSECEpejKhclSum/0gX9BlZlxVecDq1Jw5NOaB
	EHKWCkXc3u4YqOP9V8qA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wugq18bhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 19:32:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DJWNIK014930
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 19:32:23 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 12:32:22 -0700
Message-ID: <e1c3ba7e-b358-42a3-a8db-f9c098132350@quicinc.com>
Date: Wed, 13 Mar 2024 12:32:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New staging repos for ath1*k firmware
Content-Language: en-US
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Kalle Valo
	<kvalo@kernel.org>, Robert Marko <robert.marko@sartura.hr>
CC: ath10k <ath10k@lists.infradead.org>, ath11k <ath11k@lists.infradead.org>,
        ath12k <ath12k@lists.infradead.org>,
        linux-wireless
	<linux-wireless@vger.kernel.org>
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
 <CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
 <874jdigf76.fsf@kernel.org> <3b57d932-0848-40f4-ab2d-a8d4afe11df1@dd-wrt.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <3b57d932-0848-40f4-ab2d-a8d4afe11df1@dd-wrt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LFvmZHV3EDeKWzJ-DWG_dWLH8e1zC7UF
X-Proofpoint-GUID: LFvmZHV3EDeKWzJ-DWG_dWLH8e1zC7UF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130149

On 3/9/2024 9:58 AM, Sebastian Gottschall wrote:
> 
> Am 07.03.2024 um 17:49 schrieb Kalle Valo:
>> Robert Marko <robert.marko@sartura.hr> writes:
>>
>>> On Wed, Mar 6, 2024 at 8:23 PM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>>
>>>> Historically, prior to being incorporated into the linux-firmware
>>>> project, firmware for kernel.org ath1*k drivers has been first published
>>>> to Kalle's GitHub:
>>>> https://github.com/kvalo/ath10k-firmware
>>>> https://github.com/kvalo/ath11k-firmware
>>>> (ath12k firmware was pushed to the ath11k-firmware repo on a temporary
>>>> basis in anticipation of this move)
>>>>
>>>> But in order to have repos with multiple maintainers, as well as to have
>>>> a hosting platform with more control, we have moved to CodeLinaro:
>>>> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware
>>>> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware
>>>> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware
>>>>
>>>> Note that most people should not care about this -- normally you should
>>>> use the firmware that is in the official linux-firmware repo:
>>>> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/
>>>>
>>>> You should only need to access the staging repos if you need a previous
>>>> version to work around an issue, or if you are testing new firmware that
>>>> is supposed to fix a problem that you've reported.
>>>>
>>>> Please let Kalle & I know if you have any issues with these new repos!
>>> Can I please ask for IPQ6018 firmware to be updated to 2.9.0.1 as well?
>>>
>>> We have added IPQ6018 support to OpenWrt but we are forced to use the old 2.4
>>> firmware since anything newer is crashing on IPQ6018, we had the same issue on
>>> IPQ8074 but it was fixed with 2.9.0.1 firmware.
>>>
>>> Even for IPQ8074, there is newer 2.9.0.1 firmware that is only
>>> available as part of
>>> QSDK and the community would benefit from being able to use it.
>> We are working on getting the AP chipset firmwares updated but
>> unfortunately no news yet.
> why isnt qca releasing the latest firmwares at all. i mean we all know 
> that the qca networking tree contains way newer firmwares for all 
> chipsets since a long time

Kalle & I are just the conduit, but I've relayed this thread to the folks
responsible for feeding us the firmware releases.

/jeff



