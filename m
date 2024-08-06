Return-Path: <linux-wireless+bounces-11009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6719948E09
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 13:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E031F2346F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34491BBBFE;
	Tue,  6 Aug 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p7LLklAs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A71C2335
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944671; cv=none; b=PVxw521A/FvgJAtsGlrtRrm5yUA8XfhHVNPxhFivJHWgMEhNBJ2hwfWUbdltAyn6/jtKnv5VYwAQdaWOa7EXW198dd3s41h1D8G2nLu8T5OlFmsPk1X2FKdivrTP35ljOIU+A3WGfCtOBgq5fZP5MZbhawg7hR8b1YcpTidVKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944671; c=relaxed/simple;
	bh=QoMihQnDTNaBkeH9BQeTdb3hGog0XjDVhPwsByCT/WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nDiBw8uwTT+MehowHCeLgyOO+kBUWRtZuiiPc18D4hREjdNrU+PZKAvZfBPTIHUEpnLGvTaa6uVe4gjVZtiLmh96LvYHYhQIJq3pWQiLZGKxw9tDI/smvlWQKbNMb/R4K3JCRlgAVQf5cGJVAghCrIuzz73l2nOELE27NpWDseo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p7LLklAs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476BOd9x014249;
	Tue, 6 Aug 2024 11:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WmLcSkLFCG1BhCumOi1Mmi74vgBmmeesT3B0kaLQ/Qk=; b=p7LLklAspT/3msir
	+qOYisqTmQAfYJBZc0ligmdgTA3B4UJxfrdGvnG20OVf7uaUsW10stpugPpWu1TD
	njG5qQgfXaOz8QL/h0DbyniWr/e83KpsNSVBtZ9Qi1uIoiS4OLmKwpO9AQilJBAm
	5b51geLHWMzsLrO2GOH1P+jimd9jQiCDMXIhBIkpaSE6Mj567GLPmAmja7YH67dv
	srxzMHw0daFAp+S6farOvlqDZzRc3TxerIx6RLkeQcDv1zG7PhQ0kw2/Q8xMIVZ1
	y6jKGBaRc34lk+xTnCFf1bO/Xiw/6lukAy9J26oK67iJ7tlB8XLsmQ8F7dZFz8vM
	gOAecg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sdu971ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 11:43:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 476Bhwkb004145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Aug 2024 11:43:58 GMT
Received: from [10.152.206.169] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 Aug 2024
 04:43:56 -0700
Message-ID: <b2e9ea45-f043-ed40-f03b-af4b25929e16@quicinc.com>
Date: Tue, 6 Aug 2024 17:13:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v8 7/8] wifi: ath12k: refactor core start based on
 hardware group
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
 <20240531180411.1149605-8-quic_hprem@quicinc.com> <87plsuql2y.fsf@kernel.org>
 <dd2488bb-43f9-d546-7617-2a54ca3d1a1d@quicinc.com>
 <87ed8ae8ye.fsf@kernel.org>
 <4f0963ff-a822-49b8-3d45-5d90e2c2d511@quicinc.com>
 <8734ni6vdg.fsf@kernel.org>
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <8734ni6vdg.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AWm1PmNvVOH0ONeZuXsWPaIcrk3quDkb
X-Proofpoint-GUID: AWm1PmNvVOH0ONeZuXsWPaIcrk3quDkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_08,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1011 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408060081



On 8/6/2024 11:33 AM, Kalle Valo wrote:
> Harshitha Prem <quic_hprem@quicinc.com> writes:
> 
>> On 7/3/2024 9:58 PM, Kalle Valo wrote:
>>> Harshitha Prem <quic_hprem@quicinc.com> writes:
>>>
>>>>>>     +static void ath12k_core_device_cleanup(struct ath12k_base *ab)
>>>>>> +{
>>>>>> +	mutex_lock(&ab->core_lock);
>>>>>> +
>>>>>> +	if (test_and_clear_bit(ATH12K_FLAG_CORE_HIF_IRQ_ENABLED, &ab->dev_flags))
>>>>>> +		ath12k_hif_irq_disable(ab);
>>>>>> +
>>>>>> +	if (test_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags))
>>>>>> +		ath12k_core_pdev_destroy(ab);
>>>>>> +
>>>>>> +	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
>>>>>> +		ath12k_mac_unregister(ab);
>>>>>> +		ath12k_mac_destroy(ab);
>>>>>> +	}
>>>>>> +
>>>>>> +	mutex_unlock(&ab->core_lock);
>>>>>> +}
>>>>> This patch is just abusing flags and because of that we have
>>>>> spaghetti
>>>>> code. I have been disliking use of enum ath12k_dev_flags before but this
>>>>> is just looks too much. I am wondering do we need to cleanup the ath12k
>>>>> architecture first, reduce the usage of flags and then revisit this
>>>>> patchset?
>>>>>
>>>> yeah., more dev flags :( but flags were needed for the race conditions
>>>> when multiple devices where involved in a group, some devices would
>>>> have completed till pdev create some might not. Some crashes were seen
>>>> because hif_irq_disable was called for a device in a group but that
>>>> device was not even at the stage of core register. Will check the
>>>> possibility to  reduce the flag usage but it seemed necessary for
>>>> multiple device group clean up.
>>> I think the core problem here is of mixing enum ath12k_hw_state and
>>> enum
>>> ath12k_dev_flags, it's just a mess even before this patchset. For
>>> example, these flags look like they should be part enum ath12k_hw_state
>>> instead:
>>> 	ATH12K_FLAG_RECOVERY,
>>> 	ATH12K_FLAG_UNREGISTERING,
>>> 	ATH12K_FLAG_REGISTERED,
>>> 	ATH12K_FLAG_QMI_FAIL,
>>> If we have an enum plus set of flags to handle the actual state then
>>> it
>>> will become difficult to manage it all. Instead we should just have the
>>> enum for tracking the state of the driver.
>>>
>>
>> ath12k_hw_state is the driver state representation which is used to
>> indicate whether driver has started or in restarting from mac80211
>> prespective where as ath12k_dev_flags closely related to devices and
>> its q6 states.
>>
>> So, ATH12K_FLAG_RECOVERY, ATH12K_FLAG_QMI_FAIL should be in
>> ath12k_dev_flags because these are specific to Q6 crashes and failure.
>> ATH12K_FLAG_UNREGISTERING is actually used to indicate pci_remove is
>> initiated and we should not process any QMI events but may be naming
>> is creating the confusion. ATH12K_FLAG_REGISTERED flag is used whether
>> to recover or not with the information available in mac80211 to
>> reconfig.
>>
>> With hardware abstraction, it can be like 3 devices (ath12k_base) in
>> one ath12k_hw and with ath12k_hw_states alone we might not be able to
>> handle. Because, say device1 is in recovery, device2 is already till
>> QMI firmware ready after device probing and these two devices are not
>> registered to  mac80211 then we cannot set the ath12k_hw_state as
>> ON/OFF or anything else.
>>
>> Hence, we may require two distinct flags, where one holds the driver
>> abstraction state and other is device states. With grouping complexity
>> would increases as we have to sync between the devices and we require
>> two flags. Please let me know your thoughts.
> 
> Can you elaborate, for example provide exact state machine description
> for all these states? I just can't understand how using several flags in
> addition of an enum as different states makes anything easier to manage.
> To me that sounds just like spaghetti code.
> 
No new flags are introduced in this patchset, I have revisited and 
removed it any new flags. But, there are some existing flags which seems 
to be necessary in case of firmware crash or QMI handshake failure 
scenario.

Please find the details of how each flags/state in device 
(ath12k_dev_flags) is used currently :

  1. ATH12K_CAC_RUNNING - This is used to indicate whether any ongoing 
CAC is in progress for the radio in device, if yes, then we should not 
handle any data packets or management packets that are received over dp 
rx or wmi event respectively during this state.
The state is set during vdev start that is initiated via 
assign_vif_chanctx or switch_vif_chanctx. here, the vif_chanctx is from 
mac80211 but the data rx or wmi event is from the device which are both 
different context. We cannot sync between them, so this flag helps in 
avoiding processing the packets.

  2. ATH12K_FLAG_CRASH_FLUSH - this is used to indicate that the QMI 
connection between the host driver and Q6 is lost. This is set as soon 
as driver receives an QMI server exit event. So, once this is set we 
have to ensure that no data packets to be queued for hardware and no WMI 
commands are posted to firmware. All the calls to send any WMI command 
or data packet would be from mac80211.

3. ATH12K_FLAG_RAW_MODE - this flag indicates that the firmware or 
hardware operates in RAW mode. Based on this we have to set the rx/tx 
decap type to indicate firmware how to handle packets from this type of 
vif. (Do we necessary need to keep in dev_flags? may be dev_mode)

4. ATH12K_FLAG_HW_CRYPTO_DISABLED - this indicates whether software 
encryption is set or not in raw mode.

5. ATH12K_FLAG_RECOVERY - This is set during QMI server exit but not 
used anywhere. (Unused. Remove?)

6. ATH12K_FLAG_UNREGISTERING - this is set during pci remove. if this 
flag is set driver should avoid handling any mhi events/QMI events 
received from the target/hardware. (May be rename to pci shutdown?)

7. ATH12K_FLAG_REGISTERED - this is set once the device is successfully 
registered to mac80211. So, later if this device encounters any firmware 
crash, it can be recovered smoothly without registering. Also, this flag 
is used during pci_suspend scenario. If device crashes even before 
registering to mac80211 we have to avoid recovering it and this flags 
helps the same.

Once firmware crash is occurred, after collecting the dumps again the 
QMI handshake for that device will start from QMI server arrive to 
ATH12K_QMI_EVENT_FW_READY and in firmware ready we should not start the 
core again rather init only few and try to reconfigure the device with 
available data from mac80211.

8. ATH12K_FLAG_QMI_FAIL - this is set when any of the QMI handshakes 
fail and tested in rmmod case to skip the cleanup process.

The following flags are added by MCC team, I am not so clear on the use 
case seems like there are few cases in suspend use case where they need 
these states.

9. ATH12K_FLAG_HTC_SUSPEND_COMPLETE - Used for htc suspend case.
10. ATH12K_FLAG_CE_IRQ_ENABLED
11. ATH12K_FLAG_EXT_IRQ_ENABLED


So, these device states are more closely related to the 
hardware/firmware in which state it is whether firmware crashed after 
mac80211 register or before and based on it whether driver can process 
the dp tx/rx or wmi tx/rx as these would be from different context. Not 
sure, how we will be able to sync among various contexts/threads without 
these flags, please let me know your thoughts?


Now, on the otherhand, we have ath12k_hw_state which is used by mac80211 
during recovery or driver start or stop.


In multiple device grouping, say if we have 3 pci devices connected  and 
grouped, each of them will be probed separately and core_init would be 
done for each. During core_init, QMI init would be called. So, now 
device1, device2 and device3 would have invoked the QMI init. Since the 
QMI handshake happens between host and Q6 processor separately for each 
device (QMI handshake would be in order for that particular device but 
is asynchronous between the devices in group), driver would not have 
control on which device (whether device1/device2/device3) will receive 
the QMI server arrive event first. Hence, we are using mutex as well as 
defer mechanism to sync the devices as some of the MLO partner device 
params has to be filled in QMI host cap. Kindly refer below patchset.

https://patchwork.kernel.org/project/linux-wireless/patch/20240520131409.676931-1-quic_hprem@quicinc.com/

> What I'm thinking is we should cleanup ath12k_core_start(). Now it's
> basically asynchronous (ie. qmi.c calls
> ath12k_core_qmi_firmware_ready()) but if we change it to be synchronous
> (using completions etc.) I believe we could get rid of lots of these
> annoying flags. In other words, if ath12k_core_start() returns with zero
> then the firmware has booted succesfully.
> 
Sorry, I could not get your question, because already 
ath12k_core_start() is called from ath12k_core_qmi_firmware_ready() 
which means firmware has booted successfully and in core_start we 
register to mac80211 and enable the irqs.

Thanks,
Harshitha

