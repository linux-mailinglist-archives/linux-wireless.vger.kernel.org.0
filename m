Return-Path: <linux-wireless+bounces-20307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C472DA5F21F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1219017D6B9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 11:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BCF2661A4;
	Thu, 13 Mar 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JWWdOsYO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFC266B5E;
	Thu, 13 Mar 2025 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864474; cv=none; b=VXraKhkP5RBsmP9c3UnBPQFDKyN/OSTUvFayxdocYr/LMGFEVb2mkPRDXg+tgO8tO2pU/J3mct2hiMEk5+dBieL00NQz30W4gsxyrtHscfkEedI/dg3hXbJPt020neBRoodbSRCK03ypsIJk6XY550KUjYAdDXtcAs+hO7KHxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864474; c=relaxed/simple;
	bh=NxVG45wTpdPZ/Obv3Kr2Se1EVcNx/LZU2Sydvgf2/6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gBIAyjk/nyY6nJJFzhNYcnli4R0wy8mOJ82BSAcBSKsS8XT2qtFRLKXG4Xo6K2dmgVEK0kQmrpromlFzRA6usToSrc6YjqLD2AVvP6S7bL5yDlIOsD17qFxHtEb9S/Ttx/TfH3MdHs8GQqd5JmCO5SC/K9QraVzpIk38LN6inng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JWWdOsYO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D8gsSL018627;
	Thu, 13 Mar 2025 11:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8H+J0BFpbMXoJ7F6ridgaVy2HeTxs9EwAQi0GNwJ2xg=; b=JWWdOsYOkzEmXeDv
	bK+PhAzgerILG8cJQHvu1YpZFkqGUmI2WsvU7MyZmN1XVB/mtyzB6grqJIAM6R/c
	xGjVUBrpwKpGS11pA0mksqoKjGa7aqRNbFJr1LdHDXFWIYypFHkzD0uAvPZIulCx
	jhYGm9dXzdUXk2rfokSG5T5tL9ICW85+wMBl+taHQmBsfjmHk40or9JIdWWaJToW
	a40g+IPoG3xgbS9ddSIKCiBqyLxIDvZsnrUqUQb0E4u+iWqLthP66AU1wsKIRlGb
	MAK6d4Va1bHeg+9t+lUYgIlqHZOW83HXRZNXgn96bNHOk5riXpIe6JkebdZi8CFo
	Mpqamw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nwp0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:14:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52DBEMwR026259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:14:22 GMT
Received: from [10.152.204.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Mar
 2025 04:14:19 -0700
Message-ID: <165b479b-a3ec-7176-52bb-a5fcf4398c4b@quicinc.com>
Date: Thu, 13 Mar 2025 16:44:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: limit WMI_SCAN_CHAN_LIST_CMDID
 argument size
Content-Language: en-US
To: Mantas <mantas@8devices.com>, <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250310-limit-wmi-chanlist-v1-1-8f0fb45459a7@8devices.com>
 <a44f064f-19fd-16ea-222f-058486698951@quicinc.com>
 <187c8be7-23ef-4bcb-9ac1-cf1882fe3e62@8devices.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <187c8be7-23ef-4bcb-9ac1-cf1882fe3e62@8devices.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: trRjhveMuRcEl85R3bKieOlGvGyLwJLd
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d2be0f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=qC_FGOx9AAAA:8 a=ltzDYh-tZQuVNFrIBZYA:9 a=QEXdDO2ut3YA:10
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: trRjhveMuRcEl85R3bKieOlGvGyLwJLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130089



On 3/13/2025 3:40 PM, Mantas wrote:
> On 2025-03-13 11:45, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 3/10/2025 6:58 PM, Mantas Pucka wrote:
>>> When using BDF with both 5GHz and 6GHz bands enabled on QCN9274, interface
>>> fails to start. It happens because FW fails to process
>>> WMI_SCAN_CHAN_LIST_CMDID with argument size >2048, resulting in a command
>>> timeout. The current code allows splitting channel list across multiple WMI
>>> commands but uses WMI max_msg_len (4096) as chunk size, which is still too
>>
>> Did you have any private changes to increase the message_len from current
>> 2048 ot 4096 bytes? As mentioned in a reply for your other patch, multi-band
>> in qcn9274 requires additional changes in driver, only scan mode is supported
>> even with those changes.
>>
> No private changes, using unmodified FW from:
> 
> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/tree/main/QCN9274/hw2.0/1.4.1/WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> max_msg_len comes from FW initialization message:
> 
> ath12k_htc_connect_service max_msg_len=0 flags_len=0x0 assigned_eid=0
> boot htc service 'Control' ul pipe 0 dl pipe 1 eid 0 ready
> ath12k_htc_connect_service max_msg_len=2040 flags_len=0x7f80100 assigned_eid=1
> boot htc service 'HTT Data' ul pipe 4 dl pipe 1 eid 1 ready
> ath12k_htc_connect_service max_msg_len=4088 flags_len=0xff80200 assigned_eid=2
> boot htc service 'WMI' ul pipe 3 dl pipe 2 eid 2 ready
> 

Ah, I see. It looks like firmware does not strictly honor the host configuration
in some cases.

> 
> Is support for multi-band AP/STA limited by FW? AFAIK it works with proprietary driver.
> 

There are no validations done with multi-band AP/STA mode configurations.
So we can not really claim the support.

Vasanth

