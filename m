Return-Path: <linux-wireless+bounces-31344-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKnzIssSfGnKKQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31344-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 03:09:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D3B6569
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 03:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED8663016295
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE472EB85E;
	Fri, 30 Jan 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EeATYrMk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AU/Z10m4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F52E9EBB
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769738952; cv=none; b=BOm340RW0cIlYjsCTjBZdRIoK0x7MgrD4ywsgjiAeiDoLdjdzUpRGVArjAS1OXFefRitrVpcaeZXHOPVbeh4x0UJC/IwyF5OHwpba+s96UV6Wo614BmOqJCsfVLqw5mpFWJkcgWBqMmfjgHGJFd0j+4t+TUkZ9+WhEW9eiSOMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769738952; c=relaxed/simple;
	bh=ZkhVGJQkb/NT2jz4/taJYytw9EzXgCX8satHcaZyWnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9rKCAHkzCZyM6UGuGoASoMI+mF5u/lFOqiVEXiJjJe4krbU2lSp8G1ADXZGBAegwoE9zuJTJnUdQXLVwB+jbjKyPY2OUnMX6do86UzrSgkhBCL0v6Iyyn3HIQMV68DGgpszDaTcjau8zMNkX5T7bcridROKT5CWn6U7Ob2CP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EeATYrMk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AU/Z10m4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TMtWDf325578
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 02:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qm2TVjtgCsnXke5ZAfLie6EgMEjIODsMKg2ruWeDJXQ=; b=EeATYrMkAJJfamdl
	RPMbaLLsttMiASFbVtyFaMEeJR/9HJ2uaWtOgOlkPakfI95hKxt+dJ1gAXOkPaAI
	Kk0CT6Z0Ut3rOdQySK5N9IfUdSQ8qFuFY8ulPAg4mtTlRvhG50Ah6Nnrn4YaOnd4
	4a3Iw+gGVVn4gF4BOeMw/RHXQPQbm7yKSteoC+zQ1/22TILH2PxLf3ky2v9JIHNh
	NCCNNAhMhrod/leIS+yJlWDfNJD+8NqK5rOoc+oasGDajDdWc26TIEF/mlB/ra4b
	1DDSjqgMWL+xnLmKTrTkt1RAMW5iPSc6etul5+z+XrdXaPM+l8qBTHrB8AmOS4QN
	D9lpfw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gs7rdd7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 02:09:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c549aaa796dso2861279a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 18:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769738950; x=1770343750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qm2TVjtgCsnXke5ZAfLie6EgMEjIODsMKg2ruWeDJXQ=;
        b=AU/Z10m4AzkykquTeI3VuZtHqTTiM4uhCPUoIWof4v6/uahPcu+Y9lgga5KG1A53fX
         tCyaQEbpJGaZYWoYLSnVpLo08XvlZ81sc8uPt1RhXORHA7tAbZPP9fvMh4OoOwfojo2p
         tBQK0OrmjsVQusQVs6y092iBu0ff7G20qAIo7foZi6yWdT7sZIaf8vGiIBUpphmZ3cvV
         qEpA38fIyesJwlInUNKsXzveNq/gy7YU6C0zJPt4uukVrh3Ix58f/0b5U1ajnjJmMKCS
         bnfrd+iyqIsG4h4dnfGT+jGPaPqs82i3oaU7MMjiJeLsbMGpMUHyUss/jyM1ztldW1CQ
         5FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769738950; x=1770343750;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm2TVjtgCsnXke5ZAfLie6EgMEjIODsMKg2ruWeDJXQ=;
        b=dX4y9vceU8SXVPvhtgkaR76fNffVEV6yvtHjKPxOvWzL1V8RyMp68nBlDgVFlUdqV6
         ZAX0JlLud+JIw6SKocMoeAivRckvcm3n9NvT7SA7Ujm01lS/fGghHIU2rFMcTeN0jU7d
         8FYTdtZTsleAGqA2pXRBEGBCveIn6qAZmL+4Ykkx1uNRpo4ShGyjm3j8mfdLoqA1aiij
         14ZSbfhlQW6q4sgvK8DgAyOV+kanjiUIeU2TZi/1kWW2/HIg0HX/YIJ0JWlFLK4VUeZm
         5PwOed4fgxUBKxg9z11D63/wfwvwMIMGF2O+cUx3ORUmUn5m2hk+5IEtjzwZuyrraexc
         lHwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpU4XatE7ue7d/RJaxi6CXWVm+hYquNGhZAtPocRiHRDFlHY1ATaGP2v5BrtNFaHZOTSvLGpkp2BZthWqrHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzhHbxS03OaSECASN2s4DOnhNz7smaLk7B6qhAc0F+7ZHYtuI
	NbNQ9RE4mnc3vF9fY7AlZbZD7GlfzvvainQtVpayhUcbe05CwugvE9Dvj2fRxZ2XBX+L8GSd0uc
	tclepDfA285fXzbe4HkHzWibls3kL3TUGKP4tzXcdyIu+cCquRNy8oSP/7gQfyocFYDJWbQ==
X-Gm-Gg: AZuq6aL6Z4nDJXVZ3wu/u4L5Ga9Z/ecLwjT1Zh/9DrUPkLG2iSV3AbSB8VZkAsEpKfr
	hAcDquuljq86O7GxQ36zxh1kqwUtVHgq49hoGCV6F4xBmQ3VwxqwnfHAjvaadgq6Wfy7m6JTILw
	TqnTRLC68ifzAGMbZDyNpERVCHJH8WaoWuD25YF9YmEaUR3xvKlvehyjuxBMDklIi/H6VqzYuuv
	ell3J8RXgxELpmmvqxCMVrQIPL0rXrZmCiT18amNm3UhBlCrsxWSFSQa/bSVOZZwPtyROSE/yd5
	kCR+idzr5ZhzTNfiCkRn+PTS4UT+SQlerBybPLzJA+D+L0Qn0ffpbXgI2E+u4RiToAnhA5x+sd0
	ZpTJdbNKG6aQCBGqK8KHyryK8cvXdsLER42eoowLaQ7m+MCsKlZEULXm8kPvSuLJj/1AFfTrN3R
	6Djv6rJh0=
X-Received: by 2002:a05:6a21:134b:b0:334:a523:abe7 with SMTP id adf61e73a8af0-392e00526e9mr1024496637.27.1769738949586;
        Thu, 29 Jan 2026 18:09:09 -0800 (PST)
X-Received: by 2002:a05:6a21:134b:b0:334:a523:abe7 with SMTP id adf61e73a8af0-392e00526e9mr1024467637.27.1769738948942;
        Thu, 29 Jan 2026 18:09:08 -0800 (PST)
Received: from [10.133.33.202] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6103e9fsm9247034a91.2.2026.01.29.18.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 18:09:08 -0800 (PST)
Message-ID: <fbcbeb0f-c073-4da5-9dbe-2518a1d31f20@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 10:09:03 +0800
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
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAFDt1s_NtY1vXa5STRW7oQn9yDJBC0g7CPSZXn0tFhd+CSHrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAxNSBTYWx0ZWRfX6EhVYSszbZX4
 +rzrkHEE3qSKmRfMUvh0HlGdlZOKe3dOuegj0KzKAQOIlxIb5FIJmUmVjVli3/kUFfbTGD8PnpS
 gVpjGnoLo3rje8+77XGXNi6B6Gb/cATrcc8jQfLXuHZN30pqMtXmOezlRiF4IPqtLgDBNfTM1cy
 N8ia2bXzxX2WFmhRNcTc0EnT/QUm4UfyD2cH67EkoNjV9CQKNqT3e9pPPUfTd3v0vl9ZZj729eu
 zsQ0sHDJvQjwCtjVmi0q6vaRv0hpSLnHr9rRrht89mKO8D3CqeYyapQQDgRZKtqS9rKwNTsXoOX
 rXWZFnI4PKJJSC0eoDDQ+3MKiaxTzTnyAeGL+90Wg21PzpYlTY3OannVrJd1KKnfeO6S4OR2Mq1
 430kMd7nWU9HHkbF0mQF9NvdJJttw3x8x/0qeXpbirNbug1H25cOo/bzzimXsPSKFz+kmzCzDb6
 PYw2p8FC0mBVDdUILyw==
X-Proofpoint-ORIG-GUID: tNknElGMsOq9GkuLpd3DAzxK0D40L9VM
X-Proofpoint-GUID: tNknElGMsOq9GkuLpd3DAzxK0D40L9VM
X-Authority-Analysis: v=2.4 cv=UPLQ3Sfy c=1 sm=1 tr=0 ts=697c12c6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=danhDmx_AAAA:8
 a=pGLkceISAAAA:8 a=zHTTzEKRCOz4Nm9c7lgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300015
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	HAS_FILE_URL(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31344-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[home:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,launchpad.net:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 038D3B6569
X-Rspamd-Action: no action



On 1/29/2026 10:06 PM, Saikiran B wrote:
> On Thu, Jan 29, 2026 at 7:57 AM Baochen Qiang
> <baochen.qiang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 1/27/2026 12:40 PM, Saikiran B wrote:
>>> I have analyzed the logs and code flow in depth to provide more
>>> definitive answers for your questions.
>>>
>>> The log entries showing the failure are:
>>> [  563.574076] ath12k_pci 0004:01:00.0: failed to pull fw stats: -71
>>> [  564.575896] ath12k_pci 0004:01:00.0: time out while waiting for get fw stats
>>>
>>> 1. Why are other stats populated?
>>> The "failed to pull fw stats: -71" error is not the initial failure
>>> but a symptom that appears after repeated operations. The leak happens
>>> during *successful* calls prior to this error.
>>>
>>> Code flow proving the leak:
>>> - ath12k_mac_get_fw_stats() sends WMI_REQUEST_PDEV_STAT.
>>> - Firmware responds. ath12k_update_stats_event() parses the response.
>>> - ath12k_wmi_fw_stats_process() is called, which splices 'vdevs' and
>>> 'beacon' stats into ar->fw_stats.vdevs/bcn.
>>> - ath12k_mac_get_fw_stats() returns 0 (Success).
>>> - In ath12k_mac_op_get_txpower(), the check `if (!pdev)` fails if the
>>> pdev-specific list is empty (but vdev list is NOT empty).
>>> - The function exits via `err_fallback` WITHOUT calling ath12k_fw_stats_reset().
>>> - Result: The 'vdev' and 'beacon' stats that were spliced into
>>> ar->fw_stats remain there, leaking memory and accumulating with every
>>> call.
>>>
>>> 2. Exact place where -71 is printed:
>>> The error "failed to pull fw stats: -71" is printed in
>>> [ath12k_update_stats_event()](drivers/net/wireless/ath/ath12k/wmi.c).
>>> It corresponds to "ret = ath12k_wmi_pull_fw_stats()" returning -EPROTO.
>>> This propagates from
>>> [ath12k_wmi_tlv_fw_stats_data_parse()](drivers/net/wireless/ath/ath12k/wmi.c),
>>> when buffer validation checks (like `len < sizeof(*src)`) fail.
>>>
>>> Conclusion:
>>> The fix in my patch (resetting stats when `!pdev`) is critical because
>>> it ensures that the accumulated 'vdev' and 'beacon' stats are freed
>>> even when the 'pdev' list ends up empty.
>>>
>>> Let me know if you need anything else.
>>
>> can you please try below to see if it can fix your issue?
>>
>> https://lore.kernel.org/r/20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com
>>
>>>
>>> Thanks & Regards,
>>> Saikiran
>>>
>>> On Tue, Jan 27, 2026 at 9:47 AM Saikiran B <bjsaikiran@gmail.com> wrote:
>>>>
>>>> Hi Baochen,
>>>>
>>>> Regarding your questions:
>>>>
>>>> "Are other stats populated?"
>>>>
>>>> Yes. When ath12k_mac_get_fw_stats() returns success (0), it means the
>>>> firmware response was received and valid WMI events were processed.
>>>> The firmware response to WMI_REQUEST_PDEV_STAT typically includes
>>>> multiple stats TLVs (vdev stats, beacon stats, etc.). Even if the
>>>> "pdev stats" list ends up empty (e.g., due to specific filtering or
>>>> availability), the firmware should have populated other lists (like
>>>> vdevs or beacons) in the ar->fw_stats structure. If we don't reset,
>>>> these valid entries leak and accumulate.
>>>>
>>>> "Where exactly is -71 (EPROTO) printed?"
>>>>
>>>> The log "failed to pull fw stats: -71" is printed in
>>>> ath12k_update_stats_event() (wmi.c line 8500 in my tree). This error
>>>> code (-EPROTO) propagates from ath12k_wmi_tlv_fw_stats_data_parse(),
>>>> where it is returned when buffer validation checks fail (e.g., if (len
>>>> < sizeof(*src))). This failure suggests that the accumulated state or
>>>> memory corruption from the leak eventually causes the parser to fail
>>>> on subsequent events.
>>>>
>>>> So, fixing the leak is necessary for correctness regardless of the
>>>> specific side-effect error code.
>>>>
>>>> Thanks & Regards,
>>>> Saikiran
>>>>
>>>> On Tue, Jan 27, 2026 at 8:57 AM Baochen Qiang
>>>> <baochen.qiang@oss.qualcomm.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 1/26/2026 5:52 PM, Saikiran wrote:
>>>>>> The commits bd6ec8111e65 and 2977567b244f changed firmware stats handling
>>>>>> to be caller-driven, requiring explicit ath12k_fw_stats_reset() calls
>>>>>> after using ath12k_mac_get_fw_stats().
>>>>>>
>>>>>> In ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats() succeeds
>>>>>> but the pdev stats list is empty, the function exits without calling
>>>>>> ath12k_fw_stats_reset(). Even though the pdev list is empty, the firmware
>>>>>> may have populated other stats lists (vdevs, beacons, etc.) in the
>>>>>
>>>>> 'may' is not enough, we need to be 100% sure whether other stats are populated. This is
>>>>> critical for us to find the root cause.
>>>>>
>>>>>> ar->fw_stats structure.
>>>>>>
>>>>>> Without resetting the stats buffer, this data accumulates across multiple
>>>>>> calls, eventually causing the stats buffer to overflow and leading to
>>>>>> firmware communication failures (error -71/EPROTO) during subsequent
>>>>>> operations.
>>>>>>
>>>>>> The issue manifests during 5GHz scanning which triggers multiple TX power
>>>>>> queries. Symptoms include:
>>>>>> - "failed to pull fw stats: -71" errors in dmesg
>>>>>
>>>>> still, can you please check the logs to see at which exact place is this printed?
>>>>>
>>>>>> - 5GHz networks not detected despite hardware support
>>>>>> - 2.4GHz networks work normally
>>>>>>
>>>>>> Fix by calling ath12k_fw_stats_reset() when the pdev list is empty,
>>>>>> ensuring the stats buffer is properly cleaned up even when only partial
>>>>>> stats data is received from firmware.
>>>>>>
>>>>>> Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller-driven")
>>>>>> Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
>>>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
>>>>>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
>>>>>> ---
>>>>>>  drivers/net/wireless/ath/ath12k/mac.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>>>>>> index e0e49f782bf8..6e35c3ee9864 100644
>>>>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>>>>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>>>>>> @@ -5169,6 +5169,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
>>>>>>                                       struct ath12k_fw_stats_pdev, list);
>>>>>>       if (!pdev) {
>>>>>>               spin_unlock_bh(&ar->data_lock);
>>>>>> +             ath12k_fw_stats_reset(ar);
>>>>>>               goto err_fallback;
>>>>>>       }
>>>>>>
>>>>>
>>
> 
> Hi Baochen,
> 
> I tried applying your patches on top of v6.19-rc7 (which is the latest
> mainline release candidate I'm testing on), but I ran into build
> issues because some of the dependencies seem missing.
> 
> Specifically:
> Patch 2 ("wifi: ath12k: fix station lookup failure when disconnecting
> from AP") uses `ath12k_link_sta_find_by_addr()`, which does not exist
> in my tree. It seems your patches are based on a different tree
> (ath-next?) that has newer changes not yet in the mainline.
> 
> Could you please point me to the specific git repo/branch you are
> using? I can try to build and test on that baseline to be sure.

My bad. Please try the latest ath tree:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/

the base commit is ath-202601271544 tag.

> 
> Regarding the firmware stats issue:
> I verified the firmware files match the latest available (MD5 sums
> matched), yet the "-71" errors and memory leak persist on my device
> without fixes.
> 
> I successfully applied the logic from your Patch 1 manually (since
> [ath12k_mac_get_target_pdev_id](cci:1://file:///home/saikiran/linux/kernel/x1e/x1e/drivers/net/wireless/ath/ath12k/mac.c:989:0-1008:1)
> exists), but I haven't fully validated if it alone resolves the leak
> in all scenarios.
> 
> However, the fix I proposed in my v2 patch (resetting stats when pdev
> list is empty) definitely stops the leak mechanism by ensuring cleanup
> happens even when the firmware returns partial stats (which seems to
> be the trigger condition).
> 
> I'll wait for your pointer to the base tree to do a proper test of your series.
> 
> Thanks & Regards,
> Saikiran


