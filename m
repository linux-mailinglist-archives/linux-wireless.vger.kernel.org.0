Return-Path: <linux-wireless+bounces-1677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2677C829E65
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 17:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA991F22672
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9B4C3AA;
	Wed, 10 Jan 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="chQaU9jx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3D48785
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AE0nmR000806;
	Wed, 10 Jan 2024 16:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hmUcomUAFN0uAnfvzkXpoc1svcrrGLxqjY4x2TQVtpE=; b=ch
	QaU9jxf40Ubk2bMYhb+QrI9YIB93xyCdhYxUiQLTgn3ANovODpeeZf0TyLKKkkWZ
	cf16LbFbobWOYwc4TQLNU4hDYIi9ZKFTYSgZ3Bgvc6chTJf/OvpSB1eeRRQvDKK4
	Nqoorvg5w5jplZkL2rk1jElkGJBpQenYw5Mq+RxUtLz5mRuv4nivgA7pwWiG/7jJ
	3ApENMdf+yEbbtcQHSPjJT9918w1axDuFcMf4vkcKEbk+sx7wqYzoLvq8G2VXzm9
	XbjRmCMAnY/wsiSYJxCpaRViGqhruIb/7MbxorCB/vYtqWX9uvSTTj+ZDvw9U1L4
	uMvt6C3rCpub6Y8HXijQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhvhp0bf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 16:20:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40AGKlGu032738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 16:20:47 GMT
Received: from [10.110.103.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 08:20:46 -0800
Message-ID: <da6ff953-07a4-4226-a7dc-b816f8dc5724@quicinc.com>
Date: Wed, 10 Jan 2024 08:20:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath11k: add support for QCA2066
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240109021336.4143-1-quic_bqiang@quicinc.com>
 <20240109021336.4143-3-quic_bqiang@quicinc.com>
 <e19baf59-c17b-4e2b-96d7-f4fc9812c99a@quicinc.com>
 <56282bad-b59d-4572-a6f1-1b905bf0edbd@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <56282bad-b59d-4572-a6f1-1b905bf0edbd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZSaIGInvrtTOQIOAtsQlVpZq_hK23hGY
X-Proofpoint-ORIG-GUID: ZSaIGInvrtTOQIOAtsQlVpZq_hK23hGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100132

On 1/9/2024 6:16 PM, Baochen Qiang wrote:
> On 1/10/2024 1:41 AM, Jeff Johnson wrote:
>> On 1/8/2024 6:13 PM, Baochen Qiang wrote:
>>> QCA2066 is a PCI based DBS device. It is very similar to WCN6855
>>> overall: they share the same PCI device ID, the same major and
>>> minor version numbers, the same register address, and same HAL
>>> descriptors etc. The most significant difference is that QCA2066
>>> supports 3-antenna configuration while WCN6855 does not. To differentiate
>>> them, subversion numbers are used. Currently four numbers are used
>>> by QCA2066: 0x1019A0E1, 0x1019B0E1, 0x1019C0E1 and 0x1019D0E1.
>>>
>>> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03737-QCAHSPSWPL_V2_SILICONZ_CE-1
>>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>>
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>> ---
>>> v2:
>>>   - Rebased on ToT.
>>
>> hmmm, fails to apply using b4 shazam
>>
>> Checking attestation on all messages, may take a moment...
>> ---
>>    ✓ [PATCH v2 1/2] wifi: ath11k: move pci.ops registration ahead
>>    ✓ [PATCH v2 2/2] wifi: ath11k: add support for QCA2066
>>    ---
>>    ✓ Signed: DKIM/quicinc.com
>> ---
>> Total patches: 2
>> ---
>>   Base: using specified base-commit 2cd4e3f91f264926a6b11df948417b74d52ca9b9
>> Applying: wifi: ath11k: move pci.ops registration ahead
>> Applying: wifi: ath11k: add support for QCA2066
>> Patch failed at 0002 wifi: ath11k: add support for QCA2066
>> error: patch failed: drivers/net/wireless/ath/ath11k/core.c:711
>> error: drivers/net/wireless/ath/ath11k/core.c: patch does not apply
>>
>> And sure enough the code at drivers/net/wireless/ath/ath11k/core.c:711
>> doesn't match the code in the 2nd patch so something is amiss here.
>>
>> note your patch has reference to .support_dual_stations that is not
>> present in ath11k -- perhaps there are other prerequisites?
>> <https://patchwork.kernel.org/project/linux-wireless/patch/20230714023801.2621802-2-quic_cjhuang@quicinc.com/>
> Yes, as said in the cover letter, this patch set depends on the above patch.

Unfortunately automated tasks don't parse cover letters. But it looks
like b4 doesn't handle or warn about:
prerequisite-patch-id: 640366721125b1adea0eeabd5cdfca5e91476e7c

And not quite sure how it would handle that.

Kalle, that prerequisite series is set to Deferred and predates my
transition to the ath11k maintainer role. What action is needed from the
developers?
<https://patchwork.kernel.org/project/linux-wireless/list/?series=765506&state=*>

/jeff


