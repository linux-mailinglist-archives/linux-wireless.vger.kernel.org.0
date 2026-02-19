Return-Path: <linux-wireless+bounces-32030-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILcrKvb3lmn4swIAu9opvQ
	(envelope-from <linux-wireless+bounces-32030-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:45:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F3115E669
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D76D930136A4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 11:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2232BE02B;
	Thu, 19 Feb 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nsH6XnKc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C912D193F
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501556; cv=none; b=Dllfkf5edQ/aOoLlrt1Td2DcoP3MPrimSPNempCTRx/95gTAKlnqeu2ZB1oCTBaYewEpY4J8v4GQFNR5aUs8VJIv1bb+G2vGu0V1jsVDlUuxylkFdEh88MgvZmhXgbAJ2OFYsCMiFSy5fRca2y6ti8mxPKKQetrlIpXYdUWiJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501556; c=relaxed/simple;
	bh=sq7/stbwd5kWOX2wsRlVD1tyV+ojmfiB/4cNwsTZ1Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IElR4uZFHeSQgTcOqme9dFjF6Ilu4e8xBKtzSOR8P9RGTSwGCaDkCGkkHpEr7mpqheI39ZQGwOaRNZuwUC8Qtev90nzalGfIA7bWOa0iGzDLqUTi9lmCQ4lSlxmkz8cFOwgtxESfMxoIu/ry6BC52UbSFWa13xJ6XV+ASvKk8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nsH6XnKc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61INlev51924876;
	Thu, 19 Feb 2026 11:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	maJkr9ep7JNaVi/sSOzihD4kMWcMBlhIY3X+65w5DYE=; b=nsH6XnKc6GTj3YDU
	cKSAyFPm/WFzRB66nM6yKXs3Tx0sHK/HsKjn5SupQdhkdyzLaW+BG5xB6ubcq5fw
	r7TWNaShFl1XHQmydEa/OcpdH9MRAbfYBs+pjUUjQGbpBHWkZua5g1BzGMVwwK+I
	Rw1bm0PtQCf1baGwM4VSPpQoGJbsPW1Who+nFASGmA5cqLiFDQNhGH5qjwzeDiS3
	mJF48MkaAH652/PjAwDmCqezxbIhlwI5SzKlA15Lvas3Skf0jk6TINqCvr8RMUUK
	sDpYpcn7R4KsqKNgrVXxv2bUIn+DSNLum7FVm/I0a9gymcnfWDFi2PTvfFlRMv7f
	4GDyyA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdqdg9gr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:45:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 61JBjneO009925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 11:45:49 GMT
Received: from [10.50.44.70] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 03:45:47 -0800
Message-ID: <ca1f467a-b0bb-4c3e-bda6-5f3d89451abb@quicinc.com>
Date: Thu, 19 Feb 2026 17:15:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add basic hwmon temperature
 reporting
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>,
        Maharaja Kennadyrajan
	<maharaja.kennadyrajan@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aishwarya R
	<aishwarya.r@oss.qualcomm.com>
References: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <541218f7-0256-4cae-9cb1-40a1a2da2bfb@freebox.fr>
Content-Language: en-US
From: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <541218f7-0256-4cae-9cb1-40a1a2da2bfb@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r29MFGfKjaYwhn3YUf_3O7hDs09PdIwI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEwOCBTYWx0ZWRfX3VctyHTYpNxs
 lqorG97isfWzsKtvKnUAIYdHniTQnjiUSXX625DWEux0zQU7N5haguqJ8AjadNgWWF/K8nXvfTI
 EfytpE47P6zhtfluTNWdOenzekB9rk9BOTg2J3ZLXmIwlnO196dTngeqH1TTa1KXGzX9sheoB66
 NtrmoEGlQ332KLm6riT2AF+Fc2tN+UK/GQ4UIKnztBDNCQKpX3mWyO5BVt57jsff2a+WuzPdtw6
 YjfBUJaW91ky+FS+tCxAoa3m3iffgL16L5Ul1JsTPkeFX0tiNp8fq1JR0pBvny1qdGYF9y1rGUe
 55UaMAQK4LPhwRCRnRw3uTgcQOzM4iRo7fSxK4pgQ6MzOla4NK438e/9tiOCTvzbaDxl1hIoY+B
 OycWD7YsSuhZKFerQAY9GBPGo3eqiN8GlTkWZo8AnaZSiN0ctDAvYXJwMStaQ3nANT56dyGHh9N
 XCOzo2rN833u0IPNkwg==
X-Proofpoint-GUID: r29MFGfKjaYwhn3YUf_3O7hDs09PdIwI
X-Authority-Analysis: v=2.4 cv=W/M1lBWk c=1 sm=1 tr=0 ts=6996f7ed cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=7YIXymX5L9svCjQrblEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32030-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[quicinc.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:mid,quicinc.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[quic_mkenna@quicinc.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 24F3115E669
X-Rspamd-Action: no action


On 2/19/2026 5:01 PM, Pablo MARTIN-GOMEZ wrote:
> Hello,
>
> On 19/02/2026 08:34, Maharaja Kennadyrajan wrote:
>> Add initial thermal support by wiring up a per-radio (pdev) hwmon 
>> temperature
>> sensor backed by the existing WMI pdev temperature command and event.
>> When userspace reads the sysfs file temp1_input, the driver sends
>> WMI_PDEV_GET_TEMPERATURE_CMDID (tag WMI_TAG_PDEV_GET_TEMPERATURE_CMD) 
>> and waits
>> for the corresponding WMI_PDEV_TEMPERATURE_EVENTID
>> (tag WMI_TAG_PDEV_TEMPERATURE_EVENT) to get the temperature and pdev_id.
>>
>> Export the reported value in millidegrees Celsius as required by hwmon.
>> The temperature reported is per-radio (pdev). In a multi-radio wiphy 
>> under a
>> single phy, a separate hwmon device is created for each radio.
>>
>> Sample command and output:
>> $ cat /sys/devices/pci0000:00/.../ieee80211/phyX/hwmonY/temp1_input
>> $ 50000
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI 
>> WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: 
>> https://lore.kernel.org/oe-kbuild-all/202602160145.YQdvbqYY-lkp@intel.com/
>> Co-developed-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
>> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
>> Signed-off-by: Maharaja Kennadyrajan 
>> <maharaja.kennadyrajan@oss.qualcomm.com>
>> ---
>>
>> v2: Fixed the kernel test robot reported build test error.
>>
>>   drivers/net/wireless/ath/ath12k/Makefile  |   1 +
>>   drivers/net/wireless/ath/ath12k/core.c    |  13 +++
>>   drivers/net/wireless/ath/ath12k/core.h    |   3 +
>>   drivers/net/wireless/ath/ath12k/mac.c     |   5 +
>>   drivers/net/wireless/ath/ath12k/thermal.c | 125 ++++++++++++++++++++++
>>   drivers/net/wireless/ath/ath12k/thermal.h |  44 ++++++++
>>   drivers/net/wireless/ath/ath12k/wmi.c     |  57 +++++-----
>>   7 files changed, 217 insertions(+), 31 deletions(-)
>>   create mode 100644 drivers/net/wireless/ath/ath12k/thermal.c
>>   create mode 100644 drivers/net/wireless/ath/ath12k/thermal.h
>>
> [...]
>> +
>> +int ath12k_thermal_register(struct ath12k_base *ab)
>> +{
>> +    struct ath12k *ar;
>> +    int i, j, ret;
>> +
>> +    if (!IS_REACHABLE(CONFIG_HWMON))
>> +        return 0;
>> +
>> +    for (i = 0; i < ab->num_radios; i++) {
>> +        ar = ab->pdevs[i].ar;
>> +        if (!ar)
>> +            continue;
>> +
>> +        ar->thermal.hwmon_dev =
>> + hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
>> +                              "ath12k_hwmon", ar,
>> +                              ath12k_hwmon_groups);
>> +        if (IS_ERR(ar->thermal.hwmon_dev)) {
>> +            ret = PTR_ERR(ar->thermal.hwmon_dev);
>> +            ar->thermal.hwmon_dev = NULL;
>> +            ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
>> +                   ret);
>> +            for (j = i - 1; j >= 0; j--) {
>> +                ar = ab->pdevs[i].ar;
> Shouldn't it be `ar = ab->pdevs[j].ar;`?


My bad. It should by ab->pdev[j] not ab->pdev[i]. Will be addressed in 
the next version.


>> +                if (!ar)
>> +                    continue;
>> +
>> + hwmon_device_unregister(ar->thermal.hwmon_dev);
>> +                ar->thermal.hwmon_dev = NULL;
>> +            }
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>
> [...]
>
> Best regards,
>
> Pablo MG
>
>

