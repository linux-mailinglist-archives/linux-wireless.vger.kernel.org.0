Return-Path: <linux-wireless+bounces-32051-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNh0J4IwmGkzCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-32051-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:59:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE841668F7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4DB130413B8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051C6331A66;
	Fri, 20 Feb 2026 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iSG57pz/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5763321B1
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581329; cv=none; b=hB/KLn9HCwn9S4gyls9IsD7z3T3dQkma01BIP2HP2/GELj3VfJstyzGzaqMHVRm5cquWORle7BtQMjbIQlk0drcrn/WGNCKZYsyDHgf4lfWOgNa6aQ31soHa/P/qg2yCfHtpIDUy/gdBEs4cnRgmhlQwXl4GS8klZS5niME65pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581329; c=relaxed/simple;
	bh=cX2LCR90B00mZLhrTMOcOqwJGyiigkkK2YYVMjvTluE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=idcPxxVH/rSzWecbAsuZC1kBV5ZlHpD4TroXYVshvyuM8zzJM3Wk/wtcwtmjbusPj6YEYQv00D4d6wVFooonXaeKb88ASzzSSTtT6eDeJTyAkVC6SsnvsaUpK+yQB/sXECxZMqYW94Wurclex3+SpjLd272MqJ+HFdmEsDq1gLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iSG57pz/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K5RmYH3697705;
	Fri, 20 Feb 2026 09:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFygskVWcOk/FNfbcnCRmtfmSQU7zntYpcO68PJi84k=; b=iSG57pz/HT0xOiKX
	HOETaPZfU/SS0ET13aa4g7ylQtJLtl1oiFpSR1dbLhpnpYh4YejRywPvddReuyOv
	RoJ0Zx0g+iM9H+nUxWtH8TauubaU2TVXCwWni/a0SJ9JvT7QIoYq5IjbyQZsi4NS
	coWQ2zQKPDnR+NndhrgQZ0hXvSan9XUIyQw8Xl4iH7Vnt/ylReejgwXL1vYi5VXS
	TW4Q7/LkERIwpKASkFRGZ49r9b2Z1kXptxqX8bBKryzJcZ+IUG/dj9OAUs8iQ9Ng
	p8ZucjZG4ltiQj9okHMsaMw9bE0mFXLB2uY2yfxaIiVURBkUDPVNGYTcQAAFjuqo
	Tvn31g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ceh5jgnp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 09:55:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 61K9tO3Y027491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 09:55:24 GMT
Received: from [10.152.205.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 01:55:22 -0800
Message-ID: <939f1f6a-ec52-4acf-8d8e-1ae81e2d9008@quicinc.com>
Date: Fri, 20 Feb 2026 15:25:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add basic hwmon temperature
 reporting
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Maharaja Kennadyrajan
	<maharaja.kennadyrajan@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aishwarya R
	<aishwarya.r@oss.qualcomm.com>
References: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <6d8849c2-a58c-4aea-863f-6e4c335ea4cc@oss.qualcomm.com>
Content-Language: en-US
From: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <6d8849c2-a58c-4aea-863f-6e4c335ea4cc@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Raedyltv c=1 sm=1 tr=0 ts=69982f8d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Mp5vFCwjDu8Sjic8cMYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA4NiBTYWx0ZWRfX1B7REW+zeAIo
 oAc0tK6QTelgoybMasalmhx6dkodDVqALRZqMh4QLNv8fRajX53Hs22WHZEXkKA16/VKs40IEUk
 3RBLly1zLoe661tUoTA+p284enzEyBr2qMhakO3BY5zoqVpZt65HriSmTD0eDMr+XAUskqWKXj3
 m5AY3KCGw7zfiI7q5SmF1yLZjDCO533cdZljQgWyDONKSJ2cbm4t0J9VuSluBWyItOcS0p7CmFj
 7VpkWeao9y16KQwF85HGhoxFLHcS+0NFOvSFRiBBA7S8f9XuZ5wb5U4xA6Tvjxfrfq4QiAtrk+N
 uivaxv9vrViTdEbq6A+KptYFpw9ftCYnxm1v3CT0hIl8kzvi+i6MDD6zniv7dkJ5KDPduHJyCkj
 rVNfMoSNeM6aMcthk4srbJEmJbuwy/QYwp57MtTp6n1uvceE2UY1+C2ELIxtuL8CIOtJUFyL8YU
 0uIcc+gNFzYlZwl3uQQ==
X-Proofpoint-GUID: 1vBHfxwsVif1HQ5bW1hl6LPvE3EyxOSP
X-Proofpoint-ORIG-GUID: 1vBHfxwsVif1HQ5bW1hl6LPvE3EyxOSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200086
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32051-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[quicinc.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:mid,quicinc.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[quic_mkenna@quicinc.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EEE841668F7
X-Rspamd-Action: no action


On 2/20/2026 3:14 AM, Jeff Johnson wrote:
> On 2/18/2026 11:34 PM, Maharaja Kennadyrajan wrote:
>> +int ath12k_thermal_register(struct ath12k_base *ab)
>> +{
>> +	struct ath12k *ar;
>> +	int i, j, ret;
>> +
>> +	if (!IS_REACHABLE(CONFIG_HWMON))
>> +		return 0;
>> +
>> +	for (i = 0; i < ab->num_radios; i++) {
>> +		ar = ab->pdevs[i].ar;
>> +		if (!ar)
>> +			continue;
>> +
>> +		ar->thermal.hwmon_dev =
>> +			hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
>> +							  "ath12k_hwmon", ar,
>> +							  ath12k_hwmon_groups);
> ath10k and ath11k use devm_hwmon_device_register_with_groups().
> why doesn't ath12k do the same?
> then the code below and in _unregister() that calls hwmon_device_unregister()
> would be unnecessary since the objects would be reclaimed when the dev is
> destroyed.


ath12k_thermal_register() loops all radios and devm-registers hwmon devices. If registration fails for radio N, it returns an error that bubbles up and 'ath12k_core_pdev_create()' unwinds only DP ('ath12k_dp_pdev_free()'),
while already-registered hwmon devices for earlier radios remain bound to `wiphy->dev` via devm. If bring-up aborts (pdev_create fails), those hwmon sysfs nodes may persist until the 'wiphy' device is finally destroyed,
which can be much later or never if the bring-up stops early. It will impact resource/sysfs leak window and possible user-visible stale hwmon entries in failure paths.

Given this, using hwmon_device_register_with_groups() plus explicit unregister keeps lifecycle handling predictable and aligned with ath12k’s recovery paths.


>> +		if (IS_ERR(ar->thermal.hwmon_dev)) {
>> +			ret = PTR_ERR(ar->thermal.hwmon_dev);
>> +			ar->thermal.hwmon_dev = NULL;
>> +			ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
>> +				   ret);
>> +			for (j = i - 1; j >= 0; j--) {
>> +				ar = ab->pdevs[i].ar;
>> +				if (!ar)
>> +					continue;
>> +
>> +				hwmon_device_unregister(ar->thermal.hwmon_dev);
>> +				ar->thermal.hwmon_dev = NULL;
>> +			}
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void ath12k_thermal_unregister(struct ath12k_base *ab)
>> +{
>> +	struct ath12k *ar;
>> +	int i;
>> +
>> +	if (!IS_REACHABLE(CONFIG_HWMON))
>> +		return;
>> +
>> +	for (i = 0; i < ab->num_radios; i++) {
>> +		ar = ab->pdevs[i].ar;
>> +		if (!ar)
>> +			continue;
>> +
>> +		if (ar->thermal.hwmon_dev) {
>> +			hwmon_device_unregister(ar->thermal.hwmon_dev);
>> +			ar->thermal.hwmon_dev = NULL;
>> +		}
>> +	}
>> +}

