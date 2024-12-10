Return-Path: <linux-wireless+bounces-16177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E22539EB74C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 18:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DA71885226
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A222063FB;
	Tue, 10 Dec 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XaJqPbE6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF61AA1E5;
	Tue, 10 Dec 2024 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850088; cv=none; b=bb1G4BI9Mg4QzhwZoqKFYTiv3ym72FTN29SSgB1LKsjkduxPeaDIsORtn2bpMU0/8gAYePQrLIZmsNpqYCl7fL0RC/D9gyEFggdbDTGGYZDK/C2F2jFNLULW8lDHLshzA1cIfJf2/8iibWwBLSjdLjullAygo7HR9lW19LD7Opc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850088; c=relaxed/simple;
	bh=iK7Zs5gHKPMay3xJytYJL48O1gUK1sAV2LAgtfnopbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dXuUHPbWkUjPgvqXqK0I5wdG7QqgBgI0PkM8oVHfjHbje3AWHpXzSM3/Z6e4OoJqLprRh8RUthVq/7FPI37h/xIIhxpQI6vvDi3h7qWk9IsVw/mu8//UbUouCaFghgu8QpiZkNzwgpTAl3zjAD6HY1XbwmMmt/niGj4nG0bpKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XaJqPbE6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAC2YIO007505;
	Tue, 10 Dec 2024 17:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7k592LKv4ycZ6CD3fLqXfBOIulZOmseYrbaN//IVrc=; b=XaJqPbE63YYBdKS9
	kUVffvXf7cECNFZbVd2acWmn/xSRZMp3/XBulOJMG5XSim4Lsvrv8/hbyN8MPF5Y
	a2occZ7AOdCIl+Mx3VSvUOfLrA7/2P29+Ohfgn8mFaVN5BT9nEvAWACue76DMXSS
	U/hOFhC4QE/vm+01XGLRyfkxL0bbQAJ0WNiA/5P9tlHJcIhrZBm5BqA4pWE3fIo5
	kQ5+7CfoDmYc3PN0WA0ELyeYXS4S9QBfHYmIezoe2bZkq8AvQlj3Rlduz88oqKnP
	nZur0rf3GEzTwJKNxofCCQp42UHb4e+Ql7Sn77sN0APY+1jObIuHolqkS4PLIg7T
	TcyATw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e21bm521-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 17:01:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BAH11tM027891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 17:01:01 GMT
Received: from [10.216.1.219] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 09:00:57 -0800
Message-ID: <ab745c8c-421d-42de-aec7-54c2064cee58@quicinc.com>
Date: Tue, 10 Dec 2024 22:30:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] wifi: ath12k: add support for fixed QMI firmware
 memory
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
 <20241210074159.2637933-8-quic_rajkbhag@quicinc.com>
 <2d86b600-a7b1-4f7f-87ba-c167ec8c0405@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <2d86b600-a7b1-4f7f-87ba-c167ec8c0405@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Wzrd0FjgKTPeD15VkVnraTvLWM3MxeK
X-Proofpoint-ORIG-GUID: 6Wzrd0FjgKTPeD15VkVnraTvLWM3MxeK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=982 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100126

On 12/10/2024 8:13 PM, Krzysztof Kozlowski wrote:
> On 10/12/2024 08:41, Raj Kumar Bhagat wrote:
>> +		case CALDB_MEM_REGION_TYPE:
>> +			/* Cold boot calibration is not enabled in Ath12k. Hence,
>> +			 * assign paddr = 0.
>> +			 * Once cold boot calibration is enabled add support to
>> +			 * assign reserved memory from DT.
>> +			 */
>> +			ab->qmi.target_mem[idx].paddr = 0;
>> +			ab->qmi.target_mem[idx].v.ioaddr = NULL;
>> +			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
>> +			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
>> +			idx++;
>> +			break;
>> +		case M3_DUMP_REGION_TYPE:
>> +			dev_node = of_find_node_by_name(NULL, "m3_dump");
> 
> NAK
> 
> That's neither correct name nor documented in the bindings. You created
> now undocumented ABI. Even with incorrect name. :/
> 

Most of the Device Tree related concern in this series are from the
undocumented ABIs and wrong naming (use of '_' instead of '-'):
"m3_dump" and "mlo_global_mem_0".

To address the undocumented ABIs, "memory-region" and "memory-region-names"
should be used to reference all the reserved memory required. This should
include "m3_dump" and "mlo_global_mem_0" memory region.

If the above approach valid to address undocumented ABIs?

