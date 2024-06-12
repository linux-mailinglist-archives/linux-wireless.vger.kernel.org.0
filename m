Return-Path: <linux-wireless+bounces-8846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F69904F7E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710B61F219A0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6816E870;
	Wed, 12 Jun 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J5Xpwh2F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD116DEDE;
	Wed, 12 Jun 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185443; cv=none; b=EDo4PaezyMwIgrqlqlxcB8N5CO57bHFuOSmK9bTKIeCF5GRK9dIyH4X7TRvVJ+9IYhh1ju/nALIMV/YdwHIQygEK+3y2V/M91cHR9tS7qFJm56Px8+khwUXavvmZRjg5McSVWWRuHaYtsk0gqodKBzm9xa1Qos7gTCTcZ7a8a6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185443; c=relaxed/simple;
	bh=HOEWpTbG2NqRO+k/zEHzp4vNTYwtb8eZrF3t6LNNOjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DsJHqRNWFPF+tNcnGdiAbJh525/M8GX97o8XV3SEvN0W2z7OBhlJtDTx/9ml/UdE0TF8D1gFTy0W14CsrcaIeVtUZKzLIlLHVFtWZ/+b54HZVU6vaIiT88AziszOHEKDXmjg1nTpOSSg+mwh+7rps+cG3T92Dt3V2ZTnWTtzacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J5Xpwh2F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C0eo2j001183;
	Wed, 12 Jun 2024 09:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	amN2dOS0M+PtUNmJnl74lKoGPzhfXh6/HhqRWs0tLvA=; b=J5Xpwh2FUwBgOpWt
	/3B+a56EZSzK4smnkOSxKHKHCjJKEUKfLZSTr4H6ztMuiEcZQaUJdYMBpQmomweq
	4GRqXb+6uE1L+0+zZhywjDoLeaa43f/H5wj+aQ40Wgcfp87wxh6sTmZF/0iDl67I
	BMJBYewmvsd4ON3bbNlYb8q00NghacKBs9fhBmjCx85C5Kh/g2W/YveM/eQb7DJu
	0Ajx1lBHaaNUBx/jp6PqQbllurtPKQrF78DAJqzGfceTMJtxMWzKktG8/sVy0kr9
	ble0HL6JaPRH2w05qNVwwzo61fIlP3frbcTT6kDILrfbezbpYC5YqKdFmi8ERqLi
	25fwkw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypp87tr6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:43:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C9hbIj010792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:43:37 GMT
Received: from [10.253.72.168] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 02:43:35 -0700
Message-ID: <b8610296-f8cf-4b61-9b64-ffb52b7ab251@quicinc.com>
Date: Wed, 12 Jun 2024 17:43:33 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] net: rfkill: Fix a logic error within
 rfkill_set_hw_state_reason()
To: Johannes Berg <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <emmanuel.grumbach@intel.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
 <1717771212-30723-3-git-send-email-quic_zijuhu@quicinc.com>
 <b3e0a55f0680b590537133bfb02cd1bbfd61a56e.camel@sipsolutions.net>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <b3e0a55f0680b590537133bfb02cd1bbfd61a56e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2AHeGtSqfRrq-5CdNCgtPP9EBLBkpQpv
X-Proofpoint-ORIG-GUID: 2AHeGtSqfRrq-5CdNCgtPP9EBLBkpQpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=959 priorityscore=1501 adultscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406120070

On 6/12/2024 4:18 PM, Johannes Berg wrote:
> On Fri, 2024-06-07 at 22:40 +0800, Zijun Hu wrote:
>> Kernel API rfkill_set_hw_state_reason() wrongly gets previous block state
>> by using its parameter @reason as reason mask.
> 
> Using reason as a mask is perfectly valid.
> 
> And checking that the bit changed also seems valid.
> 
i don't think so as explained below.
let us assume @rfkill->hard_block_reasons has value
RFKILL_HARD_BLOCK_SIGNAL which means block state before
__rfkill_set_sw_state(..., true, RFKILL_HARD_BLOCK_NOT_OWNER) is invoked.

@prev should mean previous block state, @prev will have false based on
current logic, it is wrong since rfkill have block state before the call.

> We might want to not schedule the worker if it's not needed, but that's
> a different issue, I don't see a real bug here?
> 
the worker will be unneccessarily scheduled for above example based on
current logic even if the rfkill always stay in block state.
> johannes
> 


