Return-Path: <linux-wireless+bounces-31356-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DHzgGOhifGmlMAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31356-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:51:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B137B80A7
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C57AE3002F76
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 07:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72772EC096;
	Fri, 30 Jan 2026 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nUiHslfQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PGNjcxMn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99082EB87E
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759459; cv=none; b=Y50wuJcgG8ITKNB1706o5pFnaJw/jBMoYwYMcCswfzO9aOTrZ2e0ooB2Rdk1HRhdmV4qm44Twidws7puoJobUaYOULb1SR2uRSTlXbxUficPFSnqg4qM/osKz3h13KePBUeKSgmw7OIW6/CwYadt9t++4sKXOQE0EH947P8Y3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759459; c=relaxed/simple;
	bh=Hr3auHqplVS/r/9+JmEy2SSQTj5dLTcasmfPgo6s2Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFcccLKGP8TeWYsoWJWZW0a7wIScHJcMkbRhZKAOcCHqnjrZ5WhSFzXX/6BHVQgZTzLSRdVbdyDBZwdUYQdpOOTfz/I0caZb8QEhhzfaMycf0hv4xT0dl6+t5g8RINZENAW0FKPsTHVJQL8pWY7omMBzdmmEW3YOeSGz7XXRHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nUiHslfQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PGNjcxMn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U3Vlii996202
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEhxEUxpF/NBMQhInmGK4G71CIrV6GX1rOHUdXYrZC4=; b=nUiHslfQ1YyyojXk
	25tvVEpl7npqnnV08Vw0tjwoH03/4Mxzb1h4r72WiebBRWRkwsMCRtDzMEpK/k7Y
	zatNmNrxIXc7qPYN0jOA4j7w7wrPhl5VXnowcOtUXwVTZxT0E9vHsXvKgNitZJi2
	zz+dTXdZBGMY/CK5+MN9EYekZjPeVOFuo6OnaiwQB9gnSHOrzonKkWoykhWEcMR+
	Pqj5iG1K7g4No10HKYq3s5Se8Xujm8xbsooBnmB2ByKCgQjPm5iuTJpafGGDi2XR
	OcUmtBT6Fn1c9C6Aog2l9OXTvqVHLvmUUBt2CCFixicCArkCKDOkkE2ttPZpSmdx
	yJOnDA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bvvj802-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:50:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c617e59845dso1302265a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 23:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769759455; x=1770364255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEhxEUxpF/NBMQhInmGK4G71CIrV6GX1rOHUdXYrZC4=;
        b=PGNjcxMnuzjt4Py44rhuuDd2ah4QnQKiClLkiPwspLJ+0ldqBQ1RyyNXcXn2bqnXlm
         FopqC0CRPVlkALPkYnArFGgysJYhbIsYeuxaSQ1toB2Cu1J1TmvPD/HalQG8AASmXQga
         D5lgmAJkYmH+luO+7I6FKnczJxenq1crU9vNJYuMNxFisjepqVFvtIm21ho7ucHlBHVQ
         prmJEctu/nNFqly43XU9TjFF2Y9sqDZSnCQoLr+ooVd/jPVemCTM+TN4qd0eRYhNledz
         3QjC5SVYP6VxMT2Qz5h2NI5dBNDsZWYiv9qpPT2iRoxPbyAeWa3+YVHlEb31hn23VBww
         ngmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769759455; x=1770364255;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEhxEUxpF/NBMQhInmGK4G71CIrV6GX1rOHUdXYrZC4=;
        b=JV84Jra1p1TsJY4gU/MUVod1nBfy+s6us+dDhMGBmpjrGInPOUBgXw7Qqe1TdIP4Yd
         7fC11/mII5ELdB3ru8MO3Fa1SteIa4GbmdXYtf/+whegr0I4lWiSrYNtqQkpxXTQL3FP
         H3H5FIXm5BWCAS+EvehO7ALmejhTLHUvSrUBTZogpbJG9K2nY/VdYRlo/CS4dsXWVKv/
         zkUuUJOJdezDFlC1c0oUEDWlYa7FJbJZifV/D1TvAmKfbL9rdnE8/Jnl2VtWxK4JQB80
         S92Ort7yPWyxlnUds5YKuI5uO3aaIaa8JLgJsUbY9n+dghMGUqTHjVTpDpQ/XoDshUPz
         ySjg==
X-Forwarded-Encrypted: i=1; AJvYcCU5i5pkw4qAP2W8ny+wsB50SnyK3p2OpUr7SDR4l2GOv5PBCZ7G6U6uot9O/6Gw1y4+SwvLmhk6c3qrgcEPUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfrz/vjCy+pHyKPvcMhoYHfpPR+TYxlFKWbPOum1s80Juu7ODG
	/HVWVAwS+Kp5hkU8vqRRbUrzSQEgNXVaX0L2n31SzAbVgVRlSNEg7N4TLqxwF2n/1zCnMHSmPEl
	DDunn2bThXYmNOVtZz+6IxlnPURtROAzLkhYuROx+WRR+Ux8KsMMvf/pO6YYkdnyLo8+hZieNXs
	30Tg==
X-Gm-Gg: AZuq6aLjigwAsBP9b4EZJ8KPCnl21s3++Vh9hBlsrYIvTga+haZfAORQ1EmU6gdeU4V
	F57GN6ez+qSYSttWXCSOszq8PumUwKez9ZS2XjKFZt4hCCDYA7xdpKTvZ0m2VWu3sDYHDNHq+hE
	2hfteIv1vMVEuKgGF8F0BGcTg4bnIGOvrW5lRijxgZTVTmgjcZsGD/4v1fWjDuhQFVCciYXQK84
	8QYP93dEasgVaq70+lTW8UvwIYqXVeuSlTXwNcbQOjFKZNuWfpcIh8zJrtFqiOPVrQmCEM8nDxN
	wv+A3LyJhNvspXTM3B2MV1LA8g7BOLfF+jBQ/wJN0qjfBA+rkEO4EAhLqgUd/0iSHsU5yBhkpjH
	dRKRc5OextLghihOP2B9gzxxtH7kXZ2/R+/d1lhswxyvglR3TJoVduwcKo86wd+EHE+SgnbgEmV
	aRuFZ0ig==
X-Received: by 2002:a05:6a00:2e82:b0:823:9c0:47a8 with SMTP id d2e1a72fcca58-823aa3fd374mr1857591b3a.9.1769759455444;
        Thu, 29 Jan 2026 23:50:55 -0800 (PST)
X-Received: by 2002:a05:6a00:2e82:b0:823:9c0:47a8 with SMTP id d2e1a72fcca58-823aa3fd374mr1857575b3a.9.1769759454848;
        Thu, 29 Jan 2026 23:50:54 -0800 (PST)
Received: from [10.133.33.47] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ef88sm6465051b3a.8.2026.01.29.23.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 23:50:54 -0800 (PST)
Message-ID: <49212251-acec-4c45-856e-8b28b0a56768@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 15:50:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Fix firmware stats leak when pdev
 list is empty
To: Saikiran B <bjsaikiran@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kvalo@kernel.org
References: <20260126095244.113301-1-bjsaikiran@gmail.com>
 <20260126095244.113301-3-bjsaikiran@gmail.com>
 <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com>
 <CAAFDt1sxWMb1xPaWGWGE1XVFxRKwjOuQPZ__fNTH2+ujXJ6d5A@mail.gmail.com>
 <CAAFDt1s8HPQWJpSiDDk8PmUAKqkQHELcJj_F0faZ1C9RfiYu6g@mail.gmail.com>
 <7fb6b431-58ea-47bc-b251-5144575db17d@oss.qualcomm.com>
 <CAAFDt1s_NtY1vXa5STRW7oQn9yDJBC0g7CPSZXn0tFhd+CSHrQ@mail.gmail.com>
 <fbcbeb0f-c073-4da5-9dbe-2518a1d31f20@oss.qualcomm.com>
 <CAAFDt1uSQce_9AG2488yaeeEjCwQwQubW51K51VHiJF8Rp6xRQ@mail.gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAFDt1uSQce_9AG2488yaeeEjCwQwQubW51K51VHiJF8Rp6xRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZdEQ98VA c=1 sm=1 tr=0 ts=697c62e0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=danhDmx_AAAA:8
 a=pGLkceISAAAA:8 a=J3Hy4y-j4yJuyjteYWcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: T7_1OES8zmZZbbeOpdL7At_OfdXv09gT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA2MCBTYWx0ZWRfX2Aao+v6xOS0F
 aN4Dwbgny//rc/04noBpSTxWSZJAKY07vZ5YoUK5nruflZ4uxFQDGbFkDJEl29582qSHM5csunr
 GoiiOhDQ8W9Jo/adFQpAN3cUqOs4CRFcXhxFXQOgfT0cBnGoUvb4nKaxCmxlJdihL6AVXK58tHv
 nFiH6165feWn4Sut6LHZxZcJ+lHxe+1VSGEZHKsFQrOHzqRdCAUgxNRPybxmJK/JXXQl97VlnUV
 A3oMhnclCs8TGAiLedBhxQRTKZNndooRy+skp3F0l7AE+5/yDstjzbiuhQ4+aykExySv8u5C49V
 kxnkl5n41qrQ+ks8ASzuaZoxaP8h0UroO5LEpVU4Hn9C04suRT+JOnuRUVVWDm7z1zFlhGDSKHU
 ZZwCWm0C100V7Wbih47vwUQP+Gbu8dJuoJX3EZNlzAUaoe/mAPnNnBEBScrHsHqE6bd8eD03+e7
 F5YmDE/K490jSpeo56A==
X-Proofpoint-ORIG-GUID: T7_1OES8zmZZbbeOpdL7At_OfdXv09gT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	HAS_FILE_URL(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31356-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,launchpad.net:url,home:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B137B80A7
X-Rspamd-Action: no action



On 1/30/2026 3:32 PM, Saikiran B wrote:
> On Fri, Jan 30, 2026 at 7:39 AM Baochen Qiang
> <baochen.qiang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 1/29/2026 10:06 PM, Saikiran B wrote:
>>> On Thu, Jan 29, 2026 at 7:57 AM Baochen Qiang
>>> <baochen.qiang@oss.qualcomm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/27/2026 12:40 PM, Saikiran B wrote:
>>>>> I have analyzed the logs and code flow in depth to provide more
>>>>> definitive answers for your questions.
>>>>>
>>>>> The log entries showing the failure are:
>>>>> [  563.574076] ath12k_pci 0004:01:00.0: failed to pull fw stats: -71
>>>>> [  564.575896] ath12k_pci 0004:01:00.0: time out while waiting for get fw stats
>>>>>
>>>>> 1. Why are other stats populated?
>>>>> The "failed to pull fw stats: -71" error is not the initial failure
>>>>> but a symptom that appears after repeated operations. The leak happens
>>>>> during *successful* calls prior to this error.
>>>>>
>>>>> Code flow proving the leak:
>>>>> - ath12k_mac_get_fw_stats() sends WMI_REQUEST_PDEV_STAT.
>>>>> - Firmware responds. ath12k_update_stats_event() parses the response.
>>>>> - ath12k_wmi_fw_stats_process() is called, which splices 'vdevs' and
>>>>> 'beacon' stats into ar->fw_stats.vdevs/bcn.
>>>>> - ath12k_mac_get_fw_stats() returns 0 (Success).
>>>>> - In ath12k_mac_op_get_txpower(), the check `if (!pdev)` fails if the
>>>>> pdev-specific list is empty (but vdev list is NOT empty).
>>>>> - The function exits via `err_fallback` WITHOUT calling ath12k_fw_stats_reset().
>>>>> - Result: The 'vdev' and 'beacon' stats that were spliced into
>>>>> ar->fw_stats remain there, leaking memory and accumulating with every
>>>>> call.
>>>>>
>>>>> 2. Exact place where -71 is printed:
>>>>> The error "failed to pull fw stats: -71" is printed in
>>>>> [ath12k_update_stats_event()](drivers/net/wireless/ath/ath12k/wmi.c).
>>>>> It corresponds to "ret = ath12k_wmi_pull_fw_stats()" returning -EPROTO.
>>>>> This propagates from
>>>>> [ath12k_wmi_tlv_fw_stats_data_parse()](drivers/net/wireless/ath/ath12k/wmi.c),
>>>>> when buffer validation checks (like `len < sizeof(*src)`) fail.
>>>>>
>>>>> Conclusion:
>>>>> The fix in my patch (resetting stats when `!pdev`) is critical because
>>>>> it ensures that the accumulated 'vdev' and 'beacon' stats are freed
>>>>> even when the 'pdev' list ends up empty.
>>>>>
>>>>> Let me know if you need anything else.
>>>>
>>>> can you please try below to see if it can fix your issue?
>>>>
>>>> https://lore.kernel.org/r/20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com
>>>>
>>>>>
>>>>> Thanks & Regards,
>>>>> Saikiran
>>>>>
>>>>> On Tue, Jan 27, 2026 at 9:47 AM Saikiran B <bjsaikiran@gmail.com> wrote:
>>>>>>
>>>>>> Hi Baochen,
>>>>>>
>>>>>> Regarding your questions:
>>>>>>
>>>>>> "Are other stats populated?"
>>>>>>
>>>>>> Yes. When ath12k_mac_get_fw_stats() returns success (0), it means the
>>>>>> firmware response was received and valid WMI events were processed.
>>>>>> The firmware response to WMI_REQUEST_PDEV_STAT typically includes
>>>>>> multiple stats TLVs (vdev stats, beacon stats, etc.). Even if the
>>>>>> "pdev stats" list ends up empty (e.g., due to specific filtering or
>>>>>> availability), the firmware should have populated other lists (like
>>>>>> vdevs or beacons) in the ar->fw_stats structure. If we don't reset,
>>>>>> these valid entries leak and accumulate.
>>>>>>
>>>>>> "Where exactly is -71 (EPROTO) printed?"
>>>>>>
>>>>>> The log "failed to pull fw stats: -71" is printed in
>>>>>> ath12k_update_stats_event() (wmi.c line 8500 in my tree). This error
>>>>>> code (-EPROTO) propagates from ath12k_wmi_tlv_fw_stats_data_parse(),
>>>>>> where it is returned when buffer validation checks fail (e.g., if (len
>>>>>> < sizeof(*src))). This failure suggests that the accumulated state or
>>>>>> memory corruption from the leak eventually causes the parser to fail
>>>>>> on subsequent events.
>>>>>>
>>>>>> So, fixing the leak is necessary for correctness regardless of the
>>>>>> specific side-effect error code.
>>>>>>
>>>>>> Thanks & Regards,
>>>>>> Saikiran
>>>>>>
>>>>>> On Tue, Jan 27, 2026 at 8:57 AM Baochen Qiang
>>>>>> <baochen.qiang@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 1/26/2026 5:52 PM, Saikiran wrote:
>>>>>>>> The commits bd6ec8111e65 and 2977567b244f changed firmware stats handling
>>>>>>>> to be caller-driven, requiring explicit ath12k_fw_stats_reset() calls
>>>>>>>> after using ath12k_mac_get_fw_stats().
>>>>>>>>
>>>>>>>> In ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats() succeeds
>>>>>>>> but the pdev stats list is empty, the function exits without calling
>>>>>>>> ath12k_fw_stats_reset(). Even though the pdev list is empty, the firmware
>>>>>>>> may have populated other stats lists (vdevs, beacons, etc.) in the
>>>>>>>
>>>>>>> 'may' is not enough, we need to be 100% sure whether other stats are populated. This is
>>>>>>> critical for us to find the root cause.
>>>>>>>
>>>>>>>> ar->fw_stats structure.
>>>>>>>>
>>>>>>>> Without resetting the stats buffer, this data accumulates across multiple
>>>>>>>> calls, eventually causing the stats buffer to overflow and leading to
>>>>>>>> firmware communication failures (error -71/EPROTO) during subsequent
>>>>>>>> operations.
>>>>>>>>
>>>>>>>> The issue manifests during 5GHz scanning which triggers multiple TX power
>>>>>>>> queries. Symptoms include:
>>>>>>>> - "failed to pull fw stats: -71" errors in dmesg
>>>>>>>
>>>>>>> still, can you please check the logs to see at which exact place is this printed?
>>>>>>>
>>>>>>>> - 5GHz networks not detected despite hardware support
>>>>>>>> - 2.4GHz networks work normally
>>>>>>>>
>>>>>>>> Fix by calling ath12k_fw_stats_reset() when the pdev list is empty,
>>>>>>>> ensuring the stats buffer is properly cleaned up even when only partial
>>>>>>>> stats data is received from firmware.
>>>>>>>>
>>>>>>>> Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller-driven")
>>>>>>>> Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
>>>>>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
>>>>>>>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
>>>>>>>> ---
>>>>>>>>  drivers/net/wireless/ath/ath12k/mac.c | 1 +
>>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>>>>>>>> index e0e49f782bf8..6e35c3ee9864 100644
>>>>>>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>>>>>>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>>>>>>>> @@ -5169,6 +5169,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
>>>>>>>>                                       struct ath12k_fw_stats_pdev, list);
>>>>>>>>       if (!pdev) {
>>>>>>>>               spin_unlock_bh(&ar->data_lock);
>>>>>>>> +             ath12k_fw_stats_reset(ar);
>>>>>>>>               goto err_fallback;
>>>>>>>>       }
>>>>>>>>
>>>>>>>
>>>>
>>>
>>> Hi Baochen,
>>>
>>> I tried applying your patches on top of v6.19-rc7 (which is the latest
>>> mainline release candidate I'm testing on), but I ran into build
>>> issues because some of the dependencies seem missing.
>>>
>>> Specifically:
>>> Patch 2 ("wifi: ath12k: fix station lookup failure when disconnecting
>>> from AP") uses `ath12k_link_sta_find_by_addr()`, which does not exist
>>> in my tree. It seems your patches are based on a different tree
>>> (ath-next?) that has newer changes not yet in the mainline.
>>>
>>> Could you please point me to the specific git repo/branch you are
>>> using? I can try to build and test on that baseline to be sure.
>>
>> My bad. Please try the latest ath tree:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/
>>
>> the base commit is ath-202601271544 tag.
>>
>>>
>>> Regarding the firmware stats issue:
>>> I verified the firmware files match the latest available (MD5 sums
>>> matched), yet the "-71" errors and memory leak persist on my device
>>> without fixes.
>>>
>>> I successfully applied the logic from your Patch 1 manually (since
>>> [ath12k_mac_get_target_pdev_id](cci:1://file:///home/saikiran/linux/kernel/x1e/x1e/drivers/net/wireless/ath/ath12k/mac.c:989:0-1008:1)
>>> exists), but I haven't fully validated if it alone resolves the leak
>>> in all scenarios.
>>>
>>> However, the fix I proposed in my v2 patch (resetting stats when pdev
>>> list is empty) definitely stops the leak mechanism by ensuring cleanup
>>> happens even when the firmware returns partial stats (which seems to
>>> be the trigger condition).
>>>
>>> I'll wait for your pointer to the base tree to do a proper test of your series.
>>>
>>> Thanks & Regards,
>>> Saikiran
>>
> 
> Hi,
> 
> I have merged the tag, applied your patches and I can confirm that the
> leak has been fixed.

Thank you Saikiran for the test!

> 
> Thanks & Regards,
> Saikiran


