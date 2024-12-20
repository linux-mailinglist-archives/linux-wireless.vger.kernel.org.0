Return-Path: <linux-wireless+bounces-16638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46FF9F88F7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 01:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBCF189278B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 00:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512C817C2;
	Fri, 20 Dec 2024 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pT1BZCwf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6DA50
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734654412; cv=none; b=nq1EsFp8UZLi41QXMn/EZlRWQELQZIcvykZCdE/9MpYb30V2PqQTg+kKckx5D1UsIv73Ic8e10ooHURRO7JwECI7GMIcG2HxCmKSgDK14/Qi9SMkq1XGU2x+67/CPwPtM/aVOH3o7tcQvfG6uFCIqIJOy/BBIrsykLTBccXDePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734654412; c=relaxed/simple;
	bh=osFUgx8CuOuNhPX+feRvGDly4Bhu+Q6eXjrU01U14pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MDuFUtDzu70v/t4ye+xdi8FQ0Ydrr701A7NoaU9BrdNXrO88XrhylWrvEV9UMhagowKy2SE107v+X8NbH/HN2fj72VNQPvgEaFF3AmEmUwEMLm40xmdkAeibaDG2rASqkQNSL5JP7pUZ7l3eKVPsdZsdk9O+oMuuXpGPCuo1IUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pT1BZCwf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJF4WM9028800;
	Fri, 20 Dec 2024 00:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rrUDHRiJqEvt0TTWtLWXntm3iPCzAJ27Jpur0qArd6w=; b=pT1BZCwfTwPMwXyR
	LGCNm6Xwb4cFnq2TXhngdv1uBOj1IYc7F+h1Zt4J2/ePQqKQK0TDxf2/pXPm9K4M
	kFZYZy9WGKfi/f5veB7R0Pfa0SyPXoDbs/jkIdidKtWKtIQJDlzp0agQA0UNJPBh
	xUHhYk/FQXAcD+kvDqm59HW31tnTKoocfvTfz5GDDyJn9tWpG7D5BcL3BHk5jUag
	iItnPMEqQ1dx+2KiGZlLpY/eoLJuyPyovS1oIrY7QMCjju9WcDaPRsTLgs162XGf
	ohuyL/ThKFI/Q3fnmkxgTupXcTIxMbxlAiVIQjBYVlGBcM7lJZ42kEYLlMRIblOt
	JvhoeA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mntf17na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 00:26:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BK0Qitc016465
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 00:26:44 GMT
Received: from [10.50.43.89] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Dec
 2024 16:26:42 -0800
Message-ID: <fe0b1e1f-97eb-acf4-816a-bf3093c8bdaa@quicinc.com>
Date: Fri, 20 Dec 2024 05:56:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] wifi: ath12k: Refactor Rx status TLV parsing
 procedure argument
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
 <20241219001006.1036495-4-quic_periyasa@quicinc.com>
 <87seqjj48p.fsf@kernel.org>
 <44bfd319-caf2-7459-f62e-0f61de452a84@quicinc.com>
 <87wmfvfqq9.fsf@kernel.org>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87wmfvfqq9.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i8cJ_uRg4SDQBwXTRLBokH5-5Bp8v8ae
X-Proofpoint-ORIG-GUID: i8cJ_uRg4SDQBwXTRLBokH5-5Bp8v8ae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=330
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200002



On 12/20/2024 12:24 AM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> On 12/19/2024 5:04 PM, Kalle Valo wrote:
>>> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>>>
>>>> Currently, ath12k_dp_mon_rx_parse_status_tlv() takes the TLV tag, TLV data
>>>> and TLV userid as separate arguments from the caller. These argument can
>>>> be fetched from the TLV header itself. Therefore, pass the TLV header and
>>>> retrieve the necessary fields from the header instead of passing them from
>>>> the caller.
>>> The commit message doesn't reply to "why?". Is there a clear benefit
>>> in
>>> the future or are you just doing random code cleanup?
>>>
>>
>> It benefit in the future for supporting EHT monitor functionality.
> 
> How does it help exactly? Having even just one sentence explaining the
> motivation in the commit message would help a lot. Otherwise these just
> look random changes.
> 


Currently, ath12k_dp_mon_rx_parse_status_tlv() takes the TLV tag, TLV 
data and TLV user ID as separate arguments from the caller. In the 
future, the TLV length will be needed for the EHT monitor TLV tags. 
These arguments can be fetched from the TLV header itself. Therefore, 
instead of increasing the arguments, pass the TLV header and retrieve 
the necessary fields from the TLV header instead of passing them from 
the caller.

Above commit is ok ?


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

