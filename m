Return-Path: <linux-wireless+bounces-6468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30108A8F5A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 01:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979D81F219D8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 23:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD1D8004A;
	Wed, 17 Apr 2024 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HjpJzUD6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23385642
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396775; cv=none; b=L+/TxcQw9Va4SS2VSZJUe/EFKW7Q1jQbiAhSCy66wi8T345hdymrN+wMvyKncKGiI3IsdgqXKRFv3qquaJ4+w80jVdBCtHnMFdkZd9evKkgmPgNYhjBW11aAA9/8G9OC2PJstzUuXcCH5qpUvJdTDE5Q1k9PWofulkaUbyin7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396775; c=relaxed/simple;
	bh=6hHyEhjfXxyayN55S/5FCvTGEZdpflwA8jVR7TtX7ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q/XQqsP7VhePHRUHBtaC+BsqNbGMfUoQPBEWAVrd6MXRy6C+p0zb0HKdkTe+eKBMNx4qaNqQR4jbjt0oqIark3teBBrz6/yLnOUdL9sIHYVtskX3IoONbnBhuZ8jk/rTipHB7x12/TsyJNCj2HPwVXStyyDSgHbs96CIXkgR3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HjpJzUD6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HNO2Hg000700;
	Wed, 17 Apr 2024 23:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=x02ZDWx5MN0ifScQ0Ni8CJ8JzOiftRVCoF5P62HLbD4=; b=Hj
	pJzUD61eu/iqA1ITbfJqokpNtdCgkvYP1ACowKWFeY+hv0K0AMlTKw7GUTq6ofRx
	5VKaRbbebc7ZgZUpuqEpBHBFnv22C1XBjC7C2R5eSR20JTcZWtuftFWCk0BX709h
	ydKf15+LfPrJQt3/oiRauwmeb7fOojucmdho+Oa4PZUbp24AvqVHnxqfPn/5qMfv
	6MKbL89e8lg3oGTKwMLQKIlFUzohQM173stpltMmuPKZUaDvgckKclYS/5zOc3Z/
	WBjAYidLcRwJn2HsC2k/Rg2iPim6bYmuAGeR7IL79g7vi7BSqLwCxfg7H3rWClOG
	OI+VknJLcziD1E5x2MwA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjm0s0hbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 23:32:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HNWlW9017008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 23:32:47 GMT
Received: from [10.110.20.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 16:32:46 -0700
Message-ID: <b428c741-adbe-41c2-b353-a74b574d12d4@quicinc.com>
Date: Wed, 17 Apr 2024 16:32:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] wifi: ath12k: support suspend/resume
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com>
 <87r0f4vzkc.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87r0f4vzkc.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qMg67F_-5CYebpAY4RBMLUOBF1aAT_UK
X-Proofpoint-ORIG-GUID: qMg67F_-5CYebpAY4RBMLUOBF1aAT_UK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=617
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170168

On 4/17/2024 7:22 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> My Qualcomm Innovation Center copyright checker reports:
>> drivers/net/wireless/ath/ath12k/dp_rx.h copyright missing 2024
> 
> I fixed this in the pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6b928df55a671d2c9a15edc746f6b42ef544928e
> 
> Jeff, what do you think of the patchset? Is it ready to take?

My laptop didn't boot with this patchset in place, let me debug.


