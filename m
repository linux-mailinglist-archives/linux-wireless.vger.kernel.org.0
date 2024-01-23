Return-Path: <linux-wireless+bounces-2391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C5A839590
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 17:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B971F31C42
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7781AD9;
	Tue, 23 Jan 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kAC60Yhg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9C581AD4;
	Tue, 23 Jan 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028829; cv=none; b=qyTtmOtiApUpGU2eL9B2322q4SHs+aod1kIcsdqMopPBmeFqh1SwGzMj9RHqtBdHNFfPP0QE83KlfyxO7OMS3NJN4DT8fHwygNFSJtcOh8EK8DRBYX2J2DGOYfR2sRwhsSMsxEcXTJGnHjY5NTEy1kPPlpJBFp8fbLXPwYyER2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028829; c=relaxed/simple;
	bh=nrFTxMUB2bI50Dwj0nkgMcSptKIe5V6oRGCTPryS704=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JYyFdf4dioK4vS8q/x4fyBAyPD7wbnYat0qMt12V2aUDlXbwfG7rsMldlIblMh2QY7rZlvRij9xWDDSC5n6Nnieahn9Q/r+jTFSpA+Z0wIwAb4lNZOPu6+NvsymBiLdppKKHouSte/K5uHU5Ms5tKp06WMXCUIiaXsFb0Ix0m0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kAC60Yhg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NDvQuD004069;
	Tue, 23 Jan 2024 16:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GreLNUIAVyM/WMfHOEbJ1CagnoQ3D+JZVRjfaso49a4=; b=kA
	C60YhgUxuzb74Ybcy7BWpnQEJDnHLj2gU3UHKYNp6ywHpD6TOsGu26tgpgiTSWHP
	GmKlYVFnJhHJ9jEmFKXZmk5bFO9arC1Vl7d+mTG3LqutcLygPhumCvBNd38NzPFa
	6alVS8mWk1vqAYGoxRiziVB73dSNAIPQ8UAquz0c0D0+tRxu+LIBOXlwUCt7eyW8
	KWXWPkaS87wGr88TrR6yv2YZNWtWqQHWbIBhIj6jkIImYxEZSnLMq8smNvqcLzZN
	U3VZThy+/wX0j0Dp7OBa5t/bcDyx/n1JQ9mhPjFyfwCJhPED2S3V5nb5fo/8MIwY
	3x6cr1Gughmhda67dKrg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtescghm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:53:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NGrb8D002860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:53:37 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 08:53:37 -0800
Message-ID: <e4eeefc3-58bd-4986-af1c-ceadbddcaa93@quicinc.com>
Date: Tue, 23 Jan 2024 08:53:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/8] bus: mhi: host: add
 mhi_power_down_no_destroy()
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>,
        Baochen Qiang
	<quic_bqiang@quicinc.com>
CC: Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_qianyu@quicinc.com>
References: <20231130054250.GC3043@thinkpad> <87v89cq1ci.fsf@kernel.org>
 <20231220163209.GJ3544@thinkpad> <20231220165113.GK3544@thinkpad>
 <7a31696b-cf2b-48c0-bad3-327e9ce47172@quicinc.com>
 <20240104060904.GB3031@thinkpad> <20240122062411.GA3176@thinkpad>
 <9ac258d7-8a57-4071-af8d-5b07d776135b@quicinc.com>
 <20240122130947.GD3176@thinkpad>
 <1d9b8bc6-b1ef-4568-a265-b4e69bf90aa9@quicinc.com>
 <20240123153658.GF19029@thinkpad>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240123153658.GF19029@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eCllR30zNzo_rif4ilcY1wiLz309yY1t
X-Proofpoint-ORIG-GUID: eCllR30zNzo_rif4ilcY1wiLz309yY1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=440
 impostorscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230124

On 1/23/2024 7:36 AM, Manivannan Sadhasivam wrote:
> Ok. So I am getting the feeling that we need to talk to the PM people to get a
> proper solution. Clearly fixing the MHI code is not the right thing to do. We
> might need a separate callback that gets registered by the drivers like ath11k
> to wait for the dependency drivers to get probed.
> 
> Can you initiate such a discussion? You can write to linux-pm@vger.kernel.org,
> "Rafael J. Wysocki" <rafael@kernel.org> and Pavel Machek <pavel@ucw.cz>.

Please also include kernel@quicinc.com since this topic may have
ramifications across other Qualcomm technologies that use MHI.

/jeff


