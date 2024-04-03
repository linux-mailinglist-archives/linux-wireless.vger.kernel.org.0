Return-Path: <linux-wireless+bounces-5781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02293896309
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 05:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF33282206
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 03:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD71BC58;
	Wed,  3 Apr 2024 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MY/AL7d9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DE91CD10
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115456; cv=none; b=cATHNZ70W2qI7/WQQjS+YYoEUSNqZZqewU4fvMiDB0dD8/IuKDnNe3FgtkrCEd0JNc3rW3Wilzej3PUOgum4Ak7HM2uO4dieHN7H44JveCRUFxYwCj8FgWOpFDb+4/YIHW4eSphFF1N8TtjpkkELYczUKe0yY/GOh/2+jlOWFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115456; c=relaxed/simple;
	bh=hOHCbZmgPqsvvqEJ+2PdXtcH5sVLrejgi8+dGr/JRmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cZfUb+LvCqtxA1pGEWwxoKp13wu7SAwVc3J7qUFGeaABj2qVrrOmpIaiShkx/Kis1H+utsOhB5Q8le7wpoZmeZGGGuJ9ax2KRHeZJrs5CL0DDOVu52F9hOXGUYAf2LaNtVbDu39Vn+F+h6b9FIbqLI8U6RZ/PKS5RLdVaGHXzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MY/AL7d9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432MolCN007114;
	Wed, 3 Apr 2024 03:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sIZO+JM0tRzuRXMFjzVNmKdCZ2orh2fS0O/Ew36WWZw=; b=MY
	/AL7d9nz8FAv0D4fRk2pJboneoUwJH4O8hqOLo3Eu+eFUCf7EWC+399aY6zueA6+
	Us4lLoS5pAtyVpcboal9r0D9+xNib9vOYWTJKZ02BmrY2KBqbRJXSPZ0cDkcXfgw
	7oQ4Eh1w9LOPqy57IOBp6cSl7A1ZtE0nqRus3Tk9a2UGGVhn9EC5gkju6/k4C0Wu
	egaYcK5TjHwy3unQ11ZVyPUlgeYnXon1kMU5dBEZz86xWolmLyDzj8+QsPKP0+Ax
	/qOtY6g8wh/QUO30ySsjotYUv5n+tYmhQtH9DD4j2SbNz1EuJUXKjwjqr8Yd+ACb
	6RhSRszqRag8IKYMZv8A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8gn5j5sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 03:37:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4333bTqc012325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 03:37:29 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 20:37:27 -0700
Message-ID: <31f9de9c-ee20-404c-c645-b7ce8b2fff99@quicinc.com>
Date: Wed, 3 Apr 2024 09:07:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] wifi: ath12k: extend the link capable flag
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240329012358.2242354-1-quic_periyasa@quicinc.com>
 <20240329012358.2242354-2-quic_periyasa@quicinc.com>
 <f17ab010-5874-495a-8bd8-3e18e85cc327@quicinc.com>
 <ebeb7fa3-f0d1-230a-80bc-0877fdab7e62@quicinc.com>
 <6dac32c7-a2b2-4ac3-9c1f-b02f612ee3ef@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <6dac32c7-a2b2-4ac3-9c1f-b02f612ee3ef@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Aw_DdDv781l7bsdtaw7Go1mtgBIPSWWr
X-Proofpoint-ORIG-GUID: Aw_DdDv781l7bsdtaw7Go1mtgBIPSWWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_02,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=733
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030023



On 4/2/2024 11:11 PM, Jeff Johnson wrote:
> On 4/2/2024 2:32 AM, Karthikeyan Periyasamy wrote:
>>
>>
>> On 4/1/2024 10:24 PM, Jeff Johnson wrote:
>>> On 3/28/2024 6:23 PM, Karthikeyan Periyasamy wrote:
>>>> Link capability categorized as Single Link Operation (SLO) and Multi Link
>>>> Operation (MLO).
>>>>
>>>> 	* Intra-chip SLO/MLO refers to links present within a chip
>>>> 	* Inter-chip SLO/MLO refers to links present across multiple chips
>>>
>>> Is "chip" the correct term?
>>>
>>> I'm thinking that this should be called "device" since that is the unit of
>>> hardware that is detected by a bus probe function and which is handled by a
>>> *device* driver.
>>>
>>> Doesn't this make more sense if the references to chip and SoC are changed to
>>> device?
>>>
>>
>> In the QMI, SLO/MLO parameter exposed as chip only not device. So
>> followed the same terminology to avoid confusion for code readability.
>>
>> struct wlfw_host_mlo_chip_info_s_v01 {
>>           u8 chip_id;
>>           u8 num_local_links;
>>           u8 hw_link_id[QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01];
>>           u8 valid_mlo_link_id[QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01];
>> };
>>
>> struct qmi_wlanfw_host_cap_req_msg_v01 {
>>
>> ...
>>
>> u8 mlo_num_chips;
>>
>> u8 mlo_chip_info_valid;
>>
>> struct wlfw_host_mlo_chip_info_s_v01
>> mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
>>
>> ...
>>
>> }
>>
> 
> Please don't let firmware interface naming drive host driver code naming.
> And push back on the firmware team when they've introduced poor naming.
> 
> As many Software Engineering experts stress, naming is probably the single
> most important thing we do. So we need to make sure we are using the correct
> names for all of the software objects that comprise the driver, especially
> with this multi-device MLO feature where we now have to represent a multitude
> of individual devices as a single logical wiphy.
> 
> Lack of a single common term for each object in the architecture makes the
> code far less maintainable.
> 

Sure, will address this comment in the next version of the patch.


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

