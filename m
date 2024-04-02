Return-Path: <linux-wireless+bounces-5755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D971895AED
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 19:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48932280FA4
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9896C15AAC4;
	Tue,  2 Apr 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nPYOVy6A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61C15AAB2
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079730; cv=none; b=bXzRl3hQyyeF0F5DAi8Iah8Tn4lTlCfN/wY0hYEXPho45tZzCqKFAkEtIP0PsaPLWE0wyp2w/X1yQdCZ6bU0U/xoNx0ABaEhLZtCelW7i3pWwxX4TWUZ5Zbd6SEOrCzch6W/4+Muze8IT/9bLnV52Y/vjNi1RWesq/ZfLoQdJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079730; c=relaxed/simple;
	bh=lCJQDw5/Qay0TwOiLjEb1hBJpU2XiEJD1qoeP7EV5Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QHAVMdLQLw3n/iEdwbWh2YAawVIg14tz5rZHgctigBbml59TXXUkBeCZDaJo4sjesseGQn3/2vAwnrBMfRv3ckPWjKsj77tyMIbEoFOfoqi8vl3nbdW/wBh+FcZXQ2S1V/3DZ/nKsJTbOxI+Rx36oO41qoo1WnvW6K5SCPE2tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nPYOVy6A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432HDuGA014062;
	Tue, 2 Apr 2024 17:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=T3GWE1qSupUY20Y6R/rpg+vgPMIS2Hu0yYXwkiwEMCY=; b=nP
	YOVy6AizY52vVM7d9JjZIwQRZXnn9D7mMFxzuZDZAqXXPKxDamd7ltNDcoSXM9Zm
	iShusafuMIXLQofNdIkY2RU9EMYD6Ms1kWlW8xfIhN5efik1+s7zLqrGZ+Rm+m/E
	XKFEIeZcdHozVtT8IM9MAoOxD9B6r+uyqTi5PU/zLdMSnlL5o9NP79NQMrfpTIRn
	JZAhENt3g/hR4v5kIcPGj0+bMxZxfT1tkSynFu0ryBHZFKYamM0IBpNwdRpiRmMW
	s9EEvqRQ01fYkeiCxSb9VEd/cWxYw8w1jQ2w5p7cYaeO5FN3re1kWKwueQUvUlT7
	Xkoh+cS2zliYtflp9fdw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8h5es2e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 17:41:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432HfsM6017964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 17:41:54 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 10:41:53 -0700
Message-ID: <6dac32c7-a2b2-4ac3-9c1f-b02f612ee3ef@quicinc.com>
Date: Tue, 2 Apr 2024 10:41:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: extend the link capable flag
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240329012358.2242354-1-quic_periyasa@quicinc.com>
 <20240329012358.2242354-2-quic_periyasa@quicinc.com>
 <f17ab010-5874-495a-8bd8-3e18e85cc327@quicinc.com>
 <ebeb7fa3-f0d1-230a-80bc-0877fdab7e62@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ebeb7fa3-f0d1-230a-80bc-0877fdab7e62@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xGoqcFyAnJ3QbKhjaIMD9PzkJHpY7xb2
X-Proofpoint-ORIG-GUID: xGoqcFyAnJ3QbKhjaIMD9PzkJHpY7xb2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=697 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020131

On 4/2/2024 2:32 AM, Karthikeyan Periyasamy wrote:
> 
> 
> On 4/1/2024 10:24 PM, Jeff Johnson wrote:
>> On 3/28/2024 6:23 PM, Karthikeyan Periyasamy wrote:
>>> Link capability categorized as Single Link Operation (SLO) and Multi Link
>>> Operation (MLO).
>>>
>>> 	* Intra-chip SLO/MLO refers to links present within a chip
>>> 	* Inter-chip SLO/MLO refers to links present across multiple chips
>>
>> Is "chip" the correct term?
>>
>> I'm thinking that this should be called "device" since that is the unit of
>> hardware that is detected by a bus probe function and which is handled by a
>> *device* driver.
>>
>> Doesn't this make more sense if the references to chip and SoC are changed to
>> device?
>>
> 
> In the QMI, SLO/MLO parameter exposed as chip only not device. So 
> followed the same terminology to avoid confusion for code readability.
> 
> struct wlfw_host_mlo_chip_info_s_v01 {
>          u8 chip_id;
>          u8 num_local_links;
>          u8 hw_link_id[QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01];
>          u8 valid_mlo_link_id[QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01];
> };
> 
> struct qmi_wlanfw_host_cap_req_msg_v01 {
> 
> ...
> 
> u8 mlo_num_chips;
> 
> u8 mlo_chip_info_valid;
> 
> struct wlfw_host_mlo_chip_info_s_v01 
> mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
> 
> ...
> 
> }
> 

Please don't let firmware interface naming drive host driver code naming.
And push back on the firmware team when they've introduced poor naming.

As many Software Engineering experts stress, naming is probably the single
most important thing we do. So we need to make sure we are using the correct
names for all of the software objects that comprise the driver, especially
with this multi-device MLO feature where we now have to represent a multitude
of individual devices as a single logical wiphy.

Lack of a single common term for each object in the architecture makes the
code far less maintainable.

/jeff

