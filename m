Return-Path: <linux-wireless+bounces-30358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D31CF36B5
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 13:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37CFE31A53C6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57475339B3C;
	Mon,  5 Jan 2026 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLKwD+y5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OsUivQ4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852D339873
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613927; cv=none; b=MIjG3L2yrjlasYeVAiUrsoR6iw34HIpAp7VB4M7vnve0e8tQyEsbHKYk4+zqWTpEfyJSa2HjTNRc9Igkg5AoNHzmg9mvJTf5/rJl5wU6B1Qg3VNBO07ulCNi+k20WEVv/bbOAJPMj99Cqrb7p4DfF2LmGcqkKX4e3VSImm878AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613927; c=relaxed/simple;
	bh=RSlqlRqNUW+XxiAxGhnv5jyIyL6wWQMwlHAwYmV9Tmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2XBA46DqNMD+J5gHeRL6IUypFbTC4duCfew1lSqyeGXW/O6F6azeTHssijuWpn6TiGR8BXHOQRH4yVoP/4AcV1TUxDUpxF98s/mcGcgkaYarnbmjd32QOwLZzXj+ybh0PpgWcdxSxv8HdMVqPUOLtnnkISatLReGvAfGP/voCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XLKwD+y5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OsUivQ4L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058L8Td3874963
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 11:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MiPDhogBVlRkDz0ROS0zoSPWgbmWHu/ItTdRGriWUNw=; b=XLKwD+y5uP8gt9ki
	1b577exVz7B4Bpn22wSW4ONj8bBwzL12pGtfsi66Ojm1hX8ixVqrL2vpzMNOG96G
	PBt+04W+op2ls0q15jaynBNE3rW+RnrqFsmD/zfOEEUx45EgNpqgS7HeDxjX8NvJ
	NXrjgpFtDRSJBfyaki9lCMRZqRpcOVXk18s8q1DT9/Ijswzj6bZ/Cv+DFxFYtMv+
	uPlBruRdhPM7UKSeo4/oM2XZbfGoe7a8dIVsWQmR2wSMxE9bQQdyCuVD5+7uY5yf
	bG42uqlou4Qvp6ncDa0ij8fCFp3I0rS6z1lUUG9NbYW5roXzyWRyA54m9kvMrsrV
	wfTP5Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bfyx0hucf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 11:52:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b609c0f6522so24537826a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767613923; x=1768218723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiPDhogBVlRkDz0ROS0zoSPWgbmWHu/ItTdRGriWUNw=;
        b=OsUivQ4LCo7hXItL28K6uOFwjS/+Ad3in71283SXGfaA4487eFurXU22HSP+IA/CfW
         8tUsLXb/4oErofO5f8uDUVHq3YppuAVUWgcMqiE7t3oR9Whkmk6oYwMFNQh0m51SVDBe
         LVjXNP87eGbbpV5i4yU/nv5a98YsdhHvYAKCr4P2yMcfh9NOD420fPvV4OAXqdeDl9wc
         0oFqpkqaUtNFwk1dXKtRSzvzgweGDDM2NowIMrzzFZK65vJUuCNoAuuZWhJu5LWrT7Gb
         MZvJK7lMOQ6DzHaNV/JklCMejYXQeWLHFI43Bu5WOqqpTiLO2x6KnSG4xv4cXMbaJ++L
         smNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767613923; x=1768218723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiPDhogBVlRkDz0ROS0zoSPWgbmWHu/ItTdRGriWUNw=;
        b=AFpFbP6O/DpGySp2fca9OAEkvSxrcLhmOYMpjKvYLFZQjtpc/EiClB1T3gtUz3KgSw
         gQngZI00SPUiyUfIIaaqK/iBS4cRRxAFIP0zQQOzyZ0O04gnYETTcp8QIT/hOM7Lvc8s
         9hdVORrPpsv7phlkwjnRLBAbyYvsAa3np6+UVe1TAcW05jRx8xnrMKOwQ4GlPdJrgMjT
         P6sP/woRo7JMAxSuJFNoKyQbv2RS5FiI6rWUOSQMh12lglzFRibQWJYWH6U7Tqy6afuG
         zekbcKmFchpG//YyBlZK5dXHqEinz2KqJhMBZ3vBg9yzlwMofg//qU1lB24jjKOzyjFg
         /8bg==
X-Gm-Message-State: AOJu0Yz5AWEl3tafQXRdx5/To/0qJtuR6f7C4WOiJ8ZVinYglRFLxxUO
	HU/Kw48lb3Q7hYqLeZlet8mxw74yZ2Y3a/AtVgfgLs0WGLLIQvhK1kAwLj5X2eyN43QQPdETuCh
	dfHR4M6T09wiX5nHUILdiFcYdWxgUQ7qeXuOdPaH9JvZ/9g17iUyOnSq3Rqjh5u2a823oXQ==
X-Gm-Gg: AY/fxX6jGTysi/TwTc3lPKNpvB50+UOLW+Wryfj70SvBMQjfxi5asiXOdiQPxUJH4+H
	4Gek8WxYMJu+5PcKU/Iv13Gzt9MjnW/E3XHYgqkTnnNOlU8LcC0SwLFiS1cKxd9AIzhXQVaCTCw
	rUZDMAN4A2fZxYA13W0ZDfsiYEPVs+H8Vm6Kdx2VQEXUEbiI76ZILTqYRkX7Ksb4fXQbum1Z4lJ
	r4wt6049HwDWGjwbpR0yts2eNUHxfXV7bIzky5MhGNKdC7TxBDf4qpR+MGCq0jKhSVgb54IIv2l
	kcSeWs/LMo7R4/5tdVihWfaIFbLbeydgKi5hWCJglwcWMw3HbSyimIpnAaEgKT2SnKLBaGS13Hn
	Xv2dVIwjbglXNMijofDcqZgxOfSiaKMLR7MdUOGlj9JDqMuCvQ5ELmML6FnEMyAM=
X-Received: by 2002:a05:701b:2712:b0:11b:9386:8269 with SMTP id a92af1059eb24-1217230598emr30611808c88.46.1767613923085;
        Mon, 05 Jan 2026 03:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENVIeFd2yx1YhLwh0zFHgcGjWMsyu7GE4t5uCowL63t8BT+FBIcejwvTUdvOJqjnwzUf7K9A==
X-Received: by 2002:a05:701b:2712:b0:11b:9386:8269 with SMTP id a92af1059eb24-1217230598emr30611800c88.46.1767613922473;
        Mon, 05 Jan 2026 03:52:02 -0800 (PST)
Received: from [10.110.83.82] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm191732572c88.12.2026.01.05.03.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 03:52:02 -0800 (PST)
Message-ID: <a7a73ad1-0761-4abc-acc9-fc94a4e77348@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 19:51:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5 0/6] wifi: ath11k: Add single shot/periodic
 CFR capture support
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Yu Zhang <yu.zhang@oss.qualcomm.com>
References: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
 <717658b7-91da-4073-a746-a389319aac2d@oss.qualcomm.com>
Content-Language: en-US
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
In-Reply-To: <717658b7-91da-4073-a746-a389319aac2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZYFJbrl c=1 sm=1 tr=0 ts=695ba5e4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=t9aEVhzNtOWW9-RjAKIA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEwNCBTYWx0ZWRfXzNY6lEYw5GkY
 frVwEM7Ej2crIFhihit5d6Xp9hI1FXr0CQqaqbou2TV8khZVlLG1GcYDNID7+1IKP3fbmo5TXmE
 awKe5d939ML/lSagwSWvpG9xvvdrYpC9pnJVX/qtNXLOcnTLrXhwuOXF4OyW2rdnSHjmEmYwGAh
 bLsPxvDuA44c6VhSAoyw9TS/P8Y/ZfdRNRMUdNZuP1WUCbjKZEt2Wgx8nLGQLvzeFIqCJbZM6fy
 23dPKddVNMDXWeVwHN060eUgj/eDgp08gOzTl4+RVx790dUUrIAECQIN3UeXt1IcmH9dkuQgw4n
 4AfxoRjh2K58Hckp0nFd+n9Dq/n5Du+f57RklBneVq2hVsjd/ARNOu8RmHJBHBgO3Pyd9ePsUwb
 PirK6txIDpd9M4/q3p+sbODfY0TlJClaFdo6WF95fJZXUI+2KqZ81590UBBW1ctB9J5sfWhO2oM
 wyEsJT4qc0GgBlJrTAg==
X-Proofpoint-GUID: BHhtYpiZsbHxULOHWMWUrYSxX5mPhDZ0
X-Proofpoint-ORIG-GUID: BHhtYpiZsbHxULOHWMWUrYSxX5mPhDZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050104



On 1/5/2026 10:22 AM, Baochen Qiang wrote:
> 
> 
> On 12/30/2025 4:25 PM, Qian Zhang wrote:
>> To enable/disable cfr feature use command,
>>
>> echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr
>>
>> where, val: 0 to disable CFR and 1 to enable CFR.
>>
>> To enable CFR capture for associated peers,
>>
>> echo "<val> <bw> <periodicity> <method>"
>>   >
>> /sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture
>>
>> val: 0 - stop CFR capture
>>       1 - start CFR capture
>> bw: CFR capture bandwidth
>>       0 - 20MHZ
>>       1 - 40MHZ
>>       2 - 80MHZ
>> Periodicity: Periodicity at which hardware is expceted to collect CFR
>> dump.
>>       0 - single shot capture.
>>       non zero - for Periodic captures (value should be multiple of 10
>> ms)
>> method: Method used by hardware to collect the CFR dump.
>>       0 - from the ACKs of QOS NULL packets.
>>
>> To enable CFR capture for unassociated clients,
>>
>> echo "<mac address> <val> <periodicity>"
>>   > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc
>>
>> Mac address: mac address of the client.
>> Val: 0 - start CFR capture
>>       1 - stop CFR capture
>> Periodicity: Periodicity at which hardware is expceted to collect CFR
>> dump.
>>       0 - single shot capture.
>>       non zero - for Periodic captures (value should be multiple of 10
>> ms)
>>
>> To collect the cfr dump,
>> cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin
>>
>> Previous link:
>> https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/
>>
>> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
>> Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
>>
>> ---
>> Changes in v5:
>>   - Restore the author in all patch commit messages.
>>   - Update patch 6/6. Cache the phymode during association and
>>     use it to replace phymode reported by the firmware.
>> Changes in v4:
>>   - Update patch 2/6. Remove redundant bw parameter check in
>>     ath11k_dbg_sta_write_cfr_capture()
>> Changes in v3:
>>   - Update related comments.
>> Changes in v2:
>>   - Update related comments.
>> ---
>>
>> Venkateswara Naralasetty (6):
>>    wifi: ath11k: Add initialization and deinitialization sequence for CFR
>>      module
>>    wifi: ath11k: Register debugfs for CFR configuration
>>    wifi: ath11k: Add support unassociated client CFR
>>    wifi: ath11k: Register relayfs entries for CFR dump
>>    wifi: ath11k: Register DBR event handler for CFR data
>>    wifi: ath11k: Register handler for CFR capture event
>>
>>   drivers/net/wireless/ath/ath11k/Kconfig       |   11 +
>>   drivers/net/wireless/ath/ath11k/Makefile      |    1 +
>>   drivers/net/wireless/ath/ath11k/cfr.c         | 1022 +++++++++++++++++
>>   drivers/net/wireless/ath/ath11k/cfr.h         |  308 +++++
>>   drivers/net/wireless/ath/ath11k/core.c        |   41 +-
>>   drivers/net/wireless/ath/ath11k/core.h        |   19 +-
>>   drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
>>   drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
>>   drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
>>   drivers/net/wireless/ath/ath11k/debugfs_sta.c |  142 ++-
>>   drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
>>   drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
>>   drivers/net/wireless/ath/ath11k/mac.c         |   19 +-
>>   drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
>>   drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
>>   15 files changed, 1855 insertions(+), 26 deletions(-)
>>   create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
>>   create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
>>
>>
>> base-commit: 4465d808fda12fa47f83733a9f7b7dbc29d0ea54
>> prerequisite-patch-id: f44bdcbd36af0c3fd57b477848bf4699cade9389
>> prerequisite-patch-id: 76c61f8f00aac2a3b9ff31e0166bb12997c2b0cf
>> prerequisite-patch-id: 886b24b2496167c304e8ed42b5d879e0ecab111c
>> prerequisite-patch-id: 672baf608620c531b3765941c2719ad9d34b99c1
>> prerequisite-patch-id: 07c9ff6fcaf4ba464be993caa19eb49113eedbdf
> 
> what are these dependencies? They are not present in old revisions.
> 
> BTW, if you indeed has dependencies, in addition to these prerequisite-patch-id's, please
> also list them explicitly in the cover letter above.
> 

These dependency details were added by mistake, and I will remove them.

