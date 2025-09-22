Return-Path: <linux-wireless+bounces-27565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9D9B8F2F7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 08:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FE218971FC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E802F34BA39;
	Mon, 22 Sep 2025 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="acbcrgSX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B03208
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523481; cv=none; b=FhulsKJyRKCpytEIrqGyLHecL+ok1wkRHYRkbFC+jtyESYevEi8etr+EcpLF9bN6Xuff2XFSsLJSkWbuF1dXQgm6jaKNHTGuH0YjIE2O/Y5BMLwuCpsI0A1JYRkWB6hu8IQKPAaQ/UMMH2+Qx/FcVX70ggbt6B7rL9uA1u8Osmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523481; c=relaxed/simple;
	bh=OCAH7esiXELaThRmW5RNnTQIdTfSN1kxjbf1/+0nZVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AH4dVZQPETP9HCaJ/Vq82O1fYqCK42vNYsVIfOL1qCBuLPZFziN5EH4TY3iQ9EwFgf61SV8HRd+1A0iVyezPuOnb2GvBE5CNlEBq3zC2QtLgnyz++pZkhGWRbhilVgxhcaJay8Vf2sVxA+lvfgBKMIB7f5vSzB5weHiVM7eeSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=acbcrgSX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LKrMGB019316;
	Mon, 22 Sep 2025 06:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Cyp59fpc0haqfwWFkL0uRdGkyU1X4zyEhTIvXzVQ5M=; b=acbcrgSXELflI40Y
	5LeNllPGdIcwgzglGpkiXn0vwIqm9PnyLi5HFdaPqGUUNFM6edvihYlzccc1RqRF
	Bt4lkanTe6qPkCXEhROwA4JfMJbyk2ab1R6rfqViIcHOBXiLZzyasqBnUjZEN2ds
	a5oyIQNNM1nGz8DaY53JjnsWhmSLup5c9nhfnlwWt/0awNeYoj8uvHb9qkVxc7ux
	pXW3o7IukGS5wJQrx/UOsHGRudUpksUEfb2+j4hbYJnTBROpbjur/rT35y48QmQI
	TexUyrHyBPaxX29ArrfOGlZVzLl8PtbFiIGO7XkP/E6U8p7AH0be7B6dzr3uxMwD
	Hoyrig==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nj8uhdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 06:44:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58M6iZlv031326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 06:44:35 GMT
Received: from [10.50.2.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Sun, 21 Sep
 2025 23:44:33 -0700
Message-ID: <6e8eae56-54f7-4e90-a0a6-d5aed312b783@quicinc.com>
Date: Mon, 22 Sep 2025 12:14:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 2/3] wifi: mac80211: add support to
 handle incumbent signal detected event from driver
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
 <20250912032105.714949-3-quic_amitajit@quicinc.com>
 <42b9db0313d7b5448ca6103099b17e63c01300d3.camel@sipsolutions.net>
 <5115aba0-6a43-4122-a8ca-6fd993f21177@quicinc.com>
 <6f1f2a41ff0af4c6bff8199250397fd93ae983f2.camel@sipsolutions.net>
 <e2647512-82cd-44b1-9d1c-941e4df11bd4@quicinc.com>
 <a1ef1d78ab5c790d5fa3b6972a604949e210ccfe.camel@sipsolutions.net>
Content-Language: en-US
From: Amith A <quic_amitajit@quicinc.com>
In-Reply-To: <a1ef1d78ab5c790d5fa3b6972a604949e210ccfe.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=dZ6A3WXe c=1 sm=1 tr=0 ts=68d0f054 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=wwZjz-PVpWtaCckxqYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8FAdWxLScqOW32wURgioWdDaZ42DG81T
X-Proofpoint-GUID: 8FAdWxLScqOW32wURgioWdDaZ42DG81T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfX8StNqEVfFoNN
 m5NiBR+l5AlQ6NlUMdoAGiQnlJtpNJLbeS9CAEmLdN751YecJTgMG3NvPtRbrMw3rk3fdtsozUm
 5AAlL58w5W5f9ZdtFfVRfH3Oi8vO3dd5WatRot2rb75pklMxzLb4rGIuUMsJ76EVDSuarI67gbm
 xZPxEtQj9HrnmAqz0U1GaOnzwlfBLoD2cUc3DZfozoGyMwZih768j3bxo037Vdna45e2eNxIulQ
 UItRkPKrlpPzjzckFoL4Ul19K7z8F4qa9Y2QSIhP6dAtI6Evv7zqiE+YL200a0ZQe4Pi420Vm8X
 zid2gz/5W/uu23QyE4ZYfE6V0lZfeedNX/G7uUPoc5bGaHcNL6SMHYq2Ws7Yqp+5Z5+Yx2NRJac
 3STTWXhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043



On 9/22/2025 12:08 PM, Johannes Berg wrote:
> On Mon, 2025-09-22 at 12:07 +0530, Amith A wrote:
>> On 9/22/2025 11:47 AM, Johannes Berg wrote:
>>> On Mon, 2025-09-22 at 11:10 +0530, Amith A wrote:
>>>> The workqueue mechanism here can be removed as
>>>> ieee80211_incumbent_signal_detected() will be called from process context.
>>> That's fair, but somewhat besides the point - it should be OK to call
>>> the cfg80211 function from pretty much any context, so even if this
>>> weren't the case for your particular driver, there'd be no need?
>>>
>>> johannes
>> You are right. Ideally the cfg80211 API should be safe to call from any
>> context. However, in its current implementation, it uses nlmsg_new() and
>> genlmsg_multicast_netns() with GFP_KERNEL, which assumes process context
>> for memory allocation. That’s why I initially used a workqueue to
>> guarantee process context.
> Err, no? You actually gave it a gfp_t argument in the current form.
>
> johannes
I was referring to this call in 
ieee80211_incumbent_signal_detected_work() actually

+		cfg80211_incumbent_signal_detect_event(local->hw.wiphy,
+						       &conf->def,
+						       conf->incumbt_sig_intf_bmap,
+						       GFP_KERNEL);



