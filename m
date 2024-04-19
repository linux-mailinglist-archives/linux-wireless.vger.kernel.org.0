Return-Path: <linux-wireless+bounces-6577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3BE8AB110
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A48283638
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAD47D07F;
	Fri, 19 Apr 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mk5W5+bs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE87E11E
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538315; cv=none; b=K65uFU2nT5OJAxSzMnzThN5r5hB8pPupEFgbzcTM9cymTFAhK+S5ktfW+3/IKo9dCJc9JSsT/RS9YhcgQhVBW3cLRg6jjCzcVTqK5luxUyi219c0bzr6gD5PTSfDvzjYDlje3WoLB02FkFHIRW0An7ruUMGSRyQbhY2e0RcAE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538315; c=relaxed/simple;
	bh=fKnpEC5CsMMS89ZrpWDT+EstdUdYsbzsBQXtD+0g0ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G3ipd6iK473CnSIzXbXSXKt79TfUl5DRvKsDE30b2yFU5UN7EW9SneNWCf/ChksSSlrtAzI6Uf8iDmqRahYpmXud3xXN6yMzpuiE8QmYHIHRc/l8Jl2pf+Mcc6yRViZX8sxKFZERGYNWv1INwg7fDAQDVDXs4jZCrCgiWOQZ+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mk5W5+bs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JCFOfN004540;
	Fri, 19 Apr 2024 14:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BazMf+2/JmjsYTkqSzbPsMJcHIkKqVSEwsvdxK82s+U=; b=mk
	5W5+bsjfEtRfJvtWgJRRnKmioIXrH6oynQ8nfUnk+JnUziX86hmbb/ksmtOaiMLM
	XI2xykWl8tVbjYbN1RXTZDWGO1hgdzW8p41sle2/c7boBVKGZ6ZZuY9/fuwUp3fV
	9paFR+zM9S5knVuVphgVMHR5XyXCjui7pYBfbdDJFIulPMqCxcqvsB4AA+tgrud4
	VcKdBa8FyBF+t5Q0oIyXIGG/9guWTPVqYCgIkpPxx5oAIVz91ItAuGwtIMAWw8mD
	KHuljhIBGMHAalCLkhiH50BPYyrch+mkF/hBtrZMTPNdyxJvfzZvDCAnIFKCRk6+
	0OE8B3CFVdcpkSfGVOSQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xkgrmh860-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:51:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JEpd41016097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 14:51:39 GMT
Received: from [10.110.56.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 07:51:39 -0700
Message-ID: <a24666f5-503e-46fa-9232-df4748f824bf@quicinc.com>
Date: Fri, 19 Apr 2024 07:51:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] wifi: ath12k: ACPI support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240418162019.1246749-1-kvalo@kernel.org>
 <71414c51-26b2-4ce7-898c-5df0e8e31825@quicinc.com>
 <87h6fyhtrs.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87h6fyhtrs.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8xlBxQNLy5FWszig2-Rmi-uRJ_L6uQch
X-Proofpoint-ORIG-GUID: 8xlBxQNLy5FWszig2-Rmi-uRJ_L6uQch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=583
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190110

On 4/18/2024 9:16 PM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> I can verify this doesn't crash my system, but apparently my ACPI doesn't have
>> the underlying settings, so cannot verify actual functionality
> 
> Thanks for testing. I hope Lingbo has a device with proper ACPI settings.
> 
>> Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi_evaluate_dsm() failed
>> Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: failed to get ACPI DSM data: -2
>> Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi failed: -2
> 
> I just want to verify that these are debug messages, right? Normal users
> shouldn't see any ACPI errors if there are no ACPI settings in the system.

Yes, those were debug messages (I've added ath12k.debug_mask=0xffffeffa to my
boot command)

Also note my Qualcomm Innovation Center copyright checker reports that the two
new files are missing 2024 copyright, so please update

/jeff


