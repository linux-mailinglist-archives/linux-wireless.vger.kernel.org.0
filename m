Return-Path: <linux-wireless+bounces-15568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B59D5132
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 18:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AD628ACA6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61DC157490;
	Thu, 21 Nov 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f2AHhKKv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9113F43B
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208506; cv=none; b=ABg96QMzz1Kwi4duVvDllJyaJAegUwmvKwRn+z4RCEGJn8XKprfdKjn+T+QbzSee6pXjml5d//ifMIu3OGyF4xrT9xa2juC48snpOUaklcXEgSW5dIeBjDhP7AlZY0hRXBiWlWWxQ1tdXszmXW3lnPisBFK8MJ6fzIrKZUCVM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208506; c=relaxed/simple;
	bh=ErgiNabBoMj1x1tAaQXvUQ8Ctvar1pWlAnBNZGK0oRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r4HZfZnJ+ZuPl8q+JneJRhN17PVhIJbRyb75iW+uuPzWszD8OkAndHI2JxVLChHOfeJqDqsPPK0uSRGhpDVdNbkOp8e+CqUvfdL7NZ7yxF0qwupBymGZzbGdoYnr9qtCCuJ8uX4OhDFvLnBO5GiZ8iaGIfzEHbZTt/0OjKg/Nw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f2AHhKKv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALGcE8D020888;
	Thu, 21 Nov 2024 17:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WOsQw/isK5Gq94pZWcM8QifvJN+tvzJYJuNI1tyaojs=; b=f2AHhKKvR0o7V/zL
	jo6P3fYcGFeAXrzmCutezOpVrTcTT7EGsSv/E0kHcqxKKlfMaHveGejrhU1NoFYp
	y4aRNuDGcHATdQyd/ZuBcviMTApGxWqg/bMN0OuBHXlLpYSiq/zAwJIkiNsrmsvC
	5L1YscTe/vj56/ljlTUWBMP42Ehaqa6z19MbsI0uC6/iYmk3zRczk/C7vnief44u
	gppNiENJ93D7PBdIUYxSarNGpAHBnPcIKPOKAYbcMV7yPfGxYiT3N1+hJZ4XNt8f
	53VQrjDvIVPi2tHLGAasblq1jqAXLvXB1KOCNFbvq2ULRXC77yF8up81MvI8xK53
	BvATtw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4320wk1ju3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:01:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALH1X2o030685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:01:34 GMT
Received: from [10.111.176.168] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 09:01:33 -0800
Message-ID: <43157125-9cc4-4312-8005-05bcc670b89c@quicinc.com>
Date: Thu, 21 Nov 2024 09:01:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] [0/8] wifi: ath12k: MLO support part 3
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241121155806.1862733-1-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241121155806.1862733-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t3eftc6TwQCIuQFVnqZt9gNUT69AdjoH
X-Proofpoint-GUID: t3eftc6TwQCIuQFVnqZt9gNUT69AdjoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=843
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210129

On 11/21/2024 7:57 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> We continue refactoring ath12k in preparation for supporting Multi-Link
> Operation. For example, in this patchset we modify station state handling and
> start to use more link level configuration.
> 
> Please review.
> 
> v2:

FYI "v2" wasn't captured in the subject, but please don't resend due to this :)


