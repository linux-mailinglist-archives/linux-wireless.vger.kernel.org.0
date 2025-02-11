Return-Path: <linux-wireless+bounces-18784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E08A31481
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 19:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9F53A46AB
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1267126215F;
	Tue, 11 Feb 2025 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eqZylgmf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328C253B43
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300263; cv=none; b=NkoYBublyc1nHkC6AbSEs9KQkRLpWfejnplQUentj32TkEyFknjwTuiiewgVELAcsHkIZCXd1RxaDnaFRCLI8hOIBna2VOwyamUVsCyFT9IesY6JJaW+CDYqsCW/XA4vOvVl1IYzhAZwCgVh3dyv3GV2zDjDPuVinr0zm7LMH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300263; c=relaxed/simple;
	bh=ZV1/pyjQiE2xeNMuC2//xkuthAsDajnRyYbDmhGyL2I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mprDM7xS1ZtJBCwrKKYXzmzf1QmaCcKnjwmUhhSTYHeLsCOZ0VCVNwWP39BtA8AemHynsGmO5o1kRgGAMigJgRGqYIYKaiAJq17eTtrW+J+f1MaFD8K++Ucdmkwe+OpeBmAJkwZ+Snfk1eRb9Y542Z3fqwXRmcDgydYECpn1jnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eqZylgmf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BDcnjL010521;
	Tue, 11 Feb 2025 18:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nIEDIdgIfhT4K1gwlpf3dzud8jN9DGP5PpGiNr3++Lc=; b=eqZylgmfia04Vqgu
	wXmHElaCFavwl1dcSUH/55WXoLGDV6G/5+A3hLo/OMvKBfzPWmWrW9DeJxNp1r+X
	6gqAmxq25zD7i6USpbWviZ5Kb4Y78Q08pvCVZ2xjAXpikIBVZaFWLHuJPttRyA/9
	5BZ/QSCYA0m5QxdR4jf6UcR53rUsp6RvoeWBkq1KNesnlHAlB9Wh4OtvSEuNtHGo
	gasjUTQIxZAokb5wHZG5jqq+f3REnwsDFfEimciWPz/8DceK0gPcsspVQXSgjZis
	E+xbCAdYXISFJPSr+Jqk5Y7TqaNwAMetRvA14nxfI3BnJoATBfT6dkJ5tpILG7HA
	47O2bA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qcs5degs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:57:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51BIvQVh010906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:57:26 GMT
Received: from [10.111.176.46] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Feb
 2025 10:57:25 -0800
Message-ID: <4ac25dfb-ab59-4909-a717-41a6e752295d@quicinc.com>
Date: Tue, 11 Feb 2025 10:57:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath10k: add support for QCA9379 hw1.0 SDIO
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Felix Kaechele <felix@kaechele.ca>, <ath10k@lists.infradead.org>,
        Kalle
 Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240908013244.496382-1-felix@kaechele.ca>
 <20240908013244.496382-3-felix@kaechele.ca>
 <c1385aa1-0d41-4ed7-a00c-e40c69bafeaa@kaechele.ca>
 <06bf90a5-db29-46b4-b983-439c2b32b143@quicinc.com>
Content-Language: en-US
In-Reply-To: <06bf90a5-db29-46b4-b983-439c2b32b143@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gzK_jaDptFkKWVuOMi1kJpgVSw2PYG4I
X-Proofpoint-GUID: gzK_jaDptFkKWVuOMi1kJpgVSw2PYG4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=907 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110122

On 11/5/2024 8:21 AM, Jeff Johnson wrote:
> On 11/5/2024 7:39 AM, Felix Kaechele wrote:
>> Gentle ping on this one.
>>
>> It still applies cleanly against the ath/master branch as of today.
>>
>> If there's no chance of this going in please let me know and I'll stop 
>> re-sending this patch.
>>
>> I understand that bandwidth for ath10k related requests is minimal these 
>> days and there may not be an interest in fixing what are possibly 
>> firmware related issues for this rather obscure IoT/Automotive (SDIO, no 
>> less!) chipset.
>> I unfortunately don't have the information, documentation and latest 
>> firmware images available on my side to help with this either.
>> I am, however, always willing to work with someone on fixing any of the 
>> outstanding issues.
>>
>> Thanks!
>> Felix
> 
> Kalle has this in his 'deferred' queue in patchwork which means it's still on
> his radar, but low priority.
> 
> https://patchwork.kernel.org/project/linux-wireless/list/?series=888058&state=*

Now that Kalle has stepped down, I've inherited this series.

I have one question: what firmware & board file does this use?

It seems strange to enable the driver unless there is also firmware and a
board file in linux-firmware.

/jeff

