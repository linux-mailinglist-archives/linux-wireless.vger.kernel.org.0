Return-Path: <linux-wireless+bounces-3656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71D8573F4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 04:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61851F21B07
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15853DF46;
	Fri, 16 Feb 2024 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QeC5Pg+x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E336149E0D
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708053359; cv=none; b=FMYc/EBVoRvb6lmbxQviIjSZB1T/PbqAoI1sNOnC/3ICYc+V0yA4Axs5QhuIvqKhaIRBpVNpnrQrrtVsdp7OcHXJAYqYRqhiGYhuQNA0nN4MJCeglIUmfLcpfbKI8O5xegYvyBgbvjD7op5tVUdCN2FnpMCIZg9cZavRcyPqls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708053359; c=relaxed/simple;
	bh=QVVbUbn6x0IxQUGRgG2JiMxCAPHPhUdQRYCuFJxn3W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BL5KSoiRgA25n/JH0741OQc+bWU/x1Kkud7PYwIdzKUwnCoThQYLXUf4UBlzMp44Iq2IsZPtc6px/xXNatVMp/i2iqeHQU3E6EQqZpQpFmEdBO3qkPFQEhTy+gmQt6/JMlpK6XT+GNyd7vUFPEAV2lS6uirhHTxmGqbhi3jdxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QeC5Pg+x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G1qOwl014679;
	Fri, 16 Feb 2024 03:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fRB8wrqdNc3BjrFC2rHVbANyR565iOBXBrCwJ091Vhg=; b=Qe
	C5Pg+x1+UPYrVPvag80lhb6o44YOmYrzJe1HkttUwU/bt5fUAmssSwAU/9VVpakh
	K0MCugpCE00/9PhAroAactbQWeD6iLaWW6v24D8U3kjsN9NViZu4/58G1Y3TWepF
	x7zfw+/5JLUSLO+MHi+BM35jJNKtABjRXKLlHK6lyppTPQo5DAOJI2STXM3acOJF
	4oJ08msni8nXMSe3oMUaLkSvj3fklVIvm+iR2rIK74LtlhKvuDbyzz+q5nzZJp5v
	V4XE5Sh8I/by9pfE7rz4jTyGEJKBiEAMPdxAKZ6+xMc1Kiro78CxYvhIpNlN1bN4
	C+N+5dmwP/0PeEn0p0MA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkfamah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:15:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3Fqcw018054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:15:52 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 15 Feb
 2024 19:15:51 -0800
Message-ID: <78c51497-dd6b-4d7a-b789-e3823e89a96a@quicinc.com>
Date: Fri, 16 Feb 2024 08:45:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: mac80211_hwsim: add support for
 switch_vif_chanctx callback
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240215162811.506065-1-quic_adisi@quicinc.com>
 <20240215162811.506065-3-quic_adisi@quicinc.com>
 <de92380b3ec6d4e6bf854479fb3eca5ae88cf1fc.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <de92380b3ec6d4e6bf854479fb3eca5ae88cf1fc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kmTbP1NBh9TOAVlGB_PaAn6WBm1ONnfn
X-Proofpoint-GUID: kmTbP1NBh9TOAVlGB_PaAn6WBm1ONnfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_02,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=639
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160024

On 2/16/24 01:20, Johannes Berg wrote:
> On Thu, 2024-02-15 at 21:58 +0530, Aditya Kumar Singh wrote:
>> +static int mac80211_hwsim_switch_vif_chanctx(struct ieee80211_hw *hw,
>> +					     struct ieee80211_vif_chanctx_switch *vifs,
>> +					     int n_vifs,
>> +					     enum ieee80211_chanctx_switch_mode mode)
>> +{
>> +	int i;
>> +
>> +	if (n_vifs <= 0)
>> +		return -EINVAL;
>> +
>> +	wiphy_dbg(hw->wiphy,
>> +		  "switch vif channel context mode: %u\n", mode);
>> +
>> +	for (i = 0; i < n_vifs; i++) {
>> +		hwsim_check_chanctx_magic(vifs[i].old_ctx);
>> +		wiphy_dbg(hw->wiphy,
>> +			  "switch vif channel context: %d MHz/width: %d/cfreqs:%d/%d MHz -> %d MHz/width: %d/cfreqs:%d/%d MHz\n",
>> +			  vifs[i].old_ctx->def.chan->center_freq,
>> +			  vifs[i].old_ctx->def.width,
>> +			  vifs[i].old_ctx->def.center_freq1,
>> +			  vifs[i].old_ctx->def.center_freq2,
>> +			  vifs[i].new_ctx->def.chan->center_freq,
>> +			  vifs[i].new_ctx->def.width,
>> +			  vifs[i].new_ctx->def.center_freq1,
>> +			  vifs[i].new_ctx->def.center_freq2);
>> +		hwsim_set_chanctx_magic(vifs[i].new_ctx);
> 
> 
> hwsim_set_chanctx_magic() is only partially correct, I think, this
> depends on the mode? For CHANCTX_SWMODE_REASSIGN_VIF the chanctx should
> already exist as well, so should also be hwsim_check_chanctx_magic() in
> that case?
> 

Oh yeah missed the mode dependency here. Thanks for pointing it out. So 
it should be something like -

...

/* old already exist so check magic */
hwsim_check_chanctx_magic(vifs[i].old_ctx);

if (mode == CHANCTX_SWMODE_REASSIGN_VIF) {
	/* Reassign then new would also exist, just interface is
	 * switching
	 */
	hwsim_check_chanctx_magic(vifs[i].new_ctx);
} else {
	/* SWAP_* then new context does not exist hence set magic.
	 * Also old will no longer exist so clear the magic
	 */
	hwsim_set_chanctx_magic(vifs[i].new_ctx);
	hwsim_clear_chanctx_magic(vifs[i].old_ctx);
}

...

One thing, in patch should I keep those comments or those are noisy? 
Seems noisy to me (if at least mode documentation is referred then 
things are clear already)?

