Return-Path: <linux-wireless+bounces-5169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40588A101
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 14:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AC22C67D6
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489105A7BB;
	Mon, 25 Mar 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GFWVn9Pm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0D16EC14
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711349204; cv=none; b=g9i109hbSbglLkH0R8G3ESKnVxK95jwJkS1BbHqgNHowIJeOOMCqQ+5OJsrTN0zFKPFmYTHs2pqohUFjMr7EkvZDtFfnHzJBh3bIrLpc6yOq2xJ6jp8ilxzhwbYO7rjSZPoGJryJR+VN/Z70OZFbtkHtiJzplTNu/KjuPaD2qXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711349204; c=relaxed/simple;
	bh=0LQo1aUUh9qdhFZ+OjV8fKHoE4MHF58KG3dPysliM/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CR55be96PO9sPYM0vNh7XZOSaE7nGqb/VkayfzjGrVsWuhgfMuWVQ8os6onatjjmtegfJzUTLHSF9Q2PaPfZDp5EB3dg9dA8Z6eyXOjR47aGq/zGM11AsoucKo3NU+U5zylIckoCL7S0pi6IWfihMZmzbz7ErWalWj3v4Wwl4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GFWVn9Pm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P4mBwV002573;
	Mon, 25 Mar 2024 06:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2EYumqlekwyAdfKYURdX7fvN766C9NTacYDM6UQB2/g=; b=GF
	WVn9PmkTTBNMHzCcEuWohwr4kG2W6ekeV2fjdpJC7zS3gZ5gcX19MmgUc41i7pZS
	QQ9bQaFB7UI0s6a12z4Z4h98AxpUKtTLL9FgEsdSguzRbPDNou02b9hBDkUjkvuO
	J/h6QVaDFMJN+6NoDe/z2S8ef7epstJuQxutl3oq5uKKSEPiwU/L+CPjlKjgf2o2
	dFV1GBO6kOJRW25jNLoNC3Qfhm1+fWnOJX1IRfXM0qC0aLIU4GFEjNLBfyqVS9jx
	zgKrR/DeAmYIzyusOl8ygWh/eDlm45ZPTYUXpA6xZAweQyKzorvz4Hn6/Nt2brol
	lTv9I8OrnjFjU5tv1HJQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x1qfbpb6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:46:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42P6kYgB006669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:46:34 GMT
Received: from [10.201.211.55] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 24 Mar
 2024 23:46:32 -0700
Message-ID: <aaa08078-70c5-e8b0-bda0-f31f7d908710@quicinc.com>
Date: Mon, 25 Mar 2024 12:16:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2]wifi: ath12k: Add firmware coredump collection support
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240322054231.467152-1-quic_ssreeela@quicinc.com>
 <c4332e24-6e17-4a14-999e-71340873f67a@quicinc.com>
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
In-Reply-To: <c4332e24-6e17-4a14-999e-71340873f67a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sYgvpORXyzKP4rur6ogYCDPIl-6VdyUC
X-Proofpoint-ORIG-GUID: sYgvpORXyzKP4rur6ogYCDPIl-6VdyUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=936
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250035

On 3/22/2024 9:14 PM, Jeff Johnson wrote:
> On 3/21/2024 10:42 PM, Sowmiya Sree Elavalagan wrote:
>> In case of firmware assert snapshot of firmware memory is essential for
>> debugging. Add firmware coredump collection support for PCI bus.
>> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
>> format and also pack various memory shared during QMI phase in separate
>> TLVs.  Add necessary header and share the dumps to user space using dev
>> coredump framework. Coredump collection is disabled by default and can
>> be enabled using menuconfig. Dump collected for a radio is 55 MB
>> approximately.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> ---
>> v2:
>>   - Fixed errors shown by ath12k-check
> 
> But introduced a new one:
> 
> drivers/net/wireless/ath/ath12k/coredump.c:1: Improper SPDX comment style for 'drivers/net/wireless/ath/ath12k/coredump.c', please use '//' instead
> drivers/net/wireless/ath/ath12k/coredump.c:1: Missing or malformed SPDX-License-Identifier tag in line 1
> 
> Note that .h use /* */ and .c use // for SPDX comments
> 
> Also note that although this applies cleanly to ath-next, it does not apply cleanly to the pending branch, so it will eventually need to be rebased.
> 

Hi Jeff,

Sure, will update it in next version.

Thanks,
Sowmiya Sree

