Return-Path: <linux-wireless+bounces-18293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08D0A25631
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 10:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C43A94BE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2601FF7C9;
	Mon,  3 Feb 2025 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mMpiZKc1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBE1FF7C3;
	Mon,  3 Feb 2025 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575884; cv=none; b=HodDk3+gHniMlpwvb2rAzxyGU3x12ntPlU738VUqeBws+UxQcaGdNpWPQgbhVblxPoA+ESnRmmMgcoF9tYcTzasBOsz6kLwVXPlxD8BagVcju1mY4euSr/LZAlGmHlC+ILpHEaQx2cxPV/OYkUbT4D2kT6GQotJHFkt+bE+BmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575884; c=relaxed/simple;
	bh=gxdfI5WrcRHDD2llHshM5Duzx8/HXQUlsmDY2FonnOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RbYWB5S8xKTo2WtJ8v89w0FxG3su2fDaFWe7Ec7oGJQaOFol75McHFwvfZYsHF4Bgcmd4pL99SfMWq5OhLzo2eMjzo8tlfwhuyCIk68Qn7TdhvAYY1S4v+/rU4bnrV8HhwTe+K9hfrEZk+XI3k+eTPpnL/Spf9cBYPQFaCpB3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mMpiZKc1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5138CVjD031453;
	Mon, 3 Feb 2025 09:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g2DFr8O0VMaWPwK0ueg3lGyqTuoLafEqVtZgKNF8Qq4=; b=mMpiZKc1ctumbGZH
	hhITUglLt+Sl5PWErTTybucNccie1DuSJqcK3NzyhyJiypI2EULfqbs4lytxYMRP
	HSUEdcQ7ZAo8p1NVRlYes0Bc6L7I5hTkckAHbHUV93PQPXPO+dFiAiMThYij6kf8
	xwSQ+ok5Jqf9PpRlD90V6CYRCuxwdlymSAVHOtArYTkUE0LwNtUvOy2BJX3L6v/T
	HkOPuyxjBS9tMNpAiOAh7eryTRQqDdzskKr0cslzyEOMMuCtfxavldNL8Ch9vkvl
	vZ5v6cspbxOHQOlKo2NsBhtixP++6iVEz5u3CQniSQiMg+mX46+JXBbZ12t7nMf/
	UAIm5A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jt3ar672-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 09:44:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5139iYLN001103
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 09:44:34 GMT
Received: from [10.216.42.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 01:44:31 -0800
Message-ID: <7d5f7b4c-2a55-41c7-b85c-cb4cd76d553f@quicinc.com>
Date: Mon, 3 Feb 2025 15:14:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/13] wifi: ath12k: add support for fixed QMI firmware
 memory
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-8-quic_rajkbhag@quicinc.com>
 <4c9b512f-59d2-4d96-a899-5af4de2c823e@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <4c9b512f-59d2-4d96-a899-5af4de2c823e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lw-e8y6ZMt4lsEKxF5uTHuk6yG7IqSW9
X-Proofpoint-ORIG-GUID: lw-e8y6ZMt4lsEKxF5uTHuk6yG7IqSW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=986
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030076

On 1/30/2025 1:16 PM, Krzysztof Kozlowski wrote:
> On 30/01/2025 05:35, Raj Kumar Bhagat wrote:
>> @@ -2646,6 +2663,136 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
>>  	return ret;
>>  }
>>  
>> +static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
>> +{
>> +	struct device_node *mem_node;
>> +	struct resource res, m3_res;
>> +	u32 bdf_start_addr;
>> +	int i, idx, ret;
>> +
>> +	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
>> +		switch (ab->qmi.target_mem[i].type) {
>> +		case HOST_DDR_REGION_TYPE:
>> +			mem_node = ath12k_core_get_reserved_mem_by_name(ab, "q6-region");
> 
> 
> Why cannot you use existing API for reserved memory -
> of_reserved_mem_lookup()?
> 

The of_reserved_mem_lookup() requires reserved memory node to read the memory and
return in the structure "struct reserved_mem".

The of_reserved_mem_lookup() would be used after we get the reserved memory node
using the API - ath12k_core_get_reserved_mem_by_name(ab, "q6-region");

In next version we would use of_reserved_mem_lookup(), Something like below:
    mem_node = ath12k_core_get_reserved_mem_by_name(ab, "q6-region");
    struct reserved_mem res = of_reserved_mem_lookup(mem_node)

