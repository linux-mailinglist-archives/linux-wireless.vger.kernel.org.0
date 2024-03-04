Return-Path: <linux-wireless+bounces-4340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB987061F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 16:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F821F228CD
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55B45BF6;
	Mon,  4 Mar 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Le1nvCTF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672847793
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567204; cv=none; b=NQBWLu3m9gw/rb3NrVnEWiTixhM5WDOYsMSXLJuId6Ht6dNRwtUahVVfeW//bFq8y4LMDqr+5dDmOoU84GI+VRd5Ncq5poC7BHqCCBdyl8kXaW4ildXKdu2UI0FHn3rGtWHuJSuNeMF929ZzkBRtlENHRs3pCT6QMPWBDptTFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567204; c=relaxed/simple;
	bh=6DGnrCPkz8qVsMl9m/E4SNRrZaVjzdgqAl1F9/iWfUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MBtabBxK7oEnK7IOrfyrVewc3kVt6VQ62rK8WRouGPysnEOD1AQ/RWd14EOWKvsK4wsqr87XVMoqgYaqvd3whrYvdOi8+eTKfQSWf9EkFlSA/KBEUlRYRB+1HpXrQBpuxG3SbbMcorb5K6uXN+BceibmY3t4eNEl4TxZs40xqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Le1nvCTF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424DLlq8008602;
	Mon, 4 Mar 2024 15:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/d3O2flMmIfwl8AcHFH2F11T5Q0WP2/Z4oV+r+V5GkE=; b=Le
	1nvCTFU9L9ZULmC3QVtDBJbUkhuR0o+/qnPGJK8A+R0Sf1G1tLUTqDI8TftjJnp2
	81T+JDQQuwuE5paTRl1Gqz8SJ0N1PEcxTGw1uMRlgqoOWh/cKGOoETq/pV0vz6iF
	0g+K4E1BT/SJE77XQxApYpB66odk7xxQ/E9YIxFI8kTNFL+m96fMduJF0AfJMt9i
	a18JY37cq8BfuM4Ov3QdkW6kinBDN67kYeXAhuY3zpBbZchHIaWcb0RMPAGghLYJ
	8jVPHchJRF1yEVUzVo0S3HwlKaurtajNzknTp0ikrnQ5V6MO2H/xkZHrviofN+uQ
	WZT3QdGlxbdlM3s7br3w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnarj0v6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 15:46:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424FkZQo031536
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 15:46:35 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 07:46:34 -0800
Message-ID: <7d1800b1-276f-4426-b8d8-f6cef4545913@quicinc.com>
Date: Mon, 4 Mar 2024 07:46:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: adjust a comment to reflect reality
Content-Language: en-US
To: Kevin Lo <kevlo@kevlo.org>, <ath11k@lists.infradead.org>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
References: <ZeWEqGVibkMg2APi@ns.kevlo.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZeWEqGVibkMg2APi@ns.kevlo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LsQmatgkR3UfJg280viOPmi-FFU6oOnL
X-Proofpoint-GUID: LsQmatgkR3UfJg280viOPmi-FFU6oOnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_11,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=815 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040120

On 3/4/2024 12:22 AM, Kevin Lo wrote:
> On QCA6390/QCN9074/WCN6855, MHISTATUS may still have SYSERR bit set
> after SOC_GLOBAL_RESET.
> 
> changes for v2:
> - update comment about resetting MHICTRL to clear SYSERR

for future reference the version log should not be part of the commit text
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> --- 

the version log goes here, after the --- ("after the cut")

but no need to send another version -- Kalle can fix this when he pulls
into the pending branch.

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


