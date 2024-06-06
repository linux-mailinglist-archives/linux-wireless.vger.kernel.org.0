Return-Path: <linux-wireless+bounces-8641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B828FF48B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 20:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3AA1F271F2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9819938A;
	Thu,  6 Jun 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pjaFbB1H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF392110E;
	Thu,  6 Jun 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697999; cv=none; b=lQ95uQ5cyePO4eZqE5J2ghPK2F61r104YDOunMlUYvVKymXhvnRgLGDgSvQccLnJYP8/ote1txvaGG7XCzNR09SBndl9X8jXMKzWsRey7RElup2EyXkw3dgzJvYlTCHNpx8NGOZld9d8yJTpQSPccEjHPosTg0D0Y5TUdUlFPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697999; c=relaxed/simple;
	bh=69zQpjAYtvwRFnrv/J4UIrzjMDYCSMX8xFrTmgQ3yHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NxCxor63HmiPUjY6CZQAYzXCfFEYlIU7YXlJoaMo5v0TVqRoeGly5hRIxndm4p+M89bkghw+BSbI26sgQ1lMs600Im/UqhkYqfyvrsIWsvxFwvtCLJJdvaalFmRV4PJKy+PnQRTNi3Ms99egZAwj3X5oC5T6DwZb2vDVFG7/dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pjaFbB1H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456GHpB3013966;
	Thu, 6 Jun 2024 18:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jgHHZLFc42AkrFsoO0x+siraOmLlalkQoI+WyMiSkbk=; b=pjaFbB1HSFFdGluU
	LroCspppBFTMZvnU9gjOxlmSoCkcOMha6/eXcgY9awr077xH6kYRioXUiGW7qYsT
	lJoEA/DNv8NDgox+oLBYUjdLbzFucxNUlwXlOwtpGykqRN5wXocL7Sb/U4I7NXcO
	CLw/fP+dpykYgGIvDEBQIc1XxsSVtS0JOxRnaI7fnGZvoWXwBKCDdxADt84S1IMX
	wQ9FdVJ26bQzo42rJ04iKSK2BT71zWXfaaJklVduAapv3NawGZWrRrciCNLAg4ou
	y0kHzWUCq5kZUFSAAIKMRBdg6Dx6qTRRY7jHeDTrQLpqIMenY6p8ojIKPQOJKLOb
	AEOaPg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjvxyax98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 18:19:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 456IJjUv023792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 18:19:45 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 11:19:44 -0700
Message-ID: <08b18db2-63f2-4eb9-ad7a-318cd7a207ee@quicinc.com>
Date: Thu, 6 Jun 2024 11:19:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] dt-bindings: describe the ath1X modules on QCom
 BT/WLAN chipsets
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <ath12k@lists.infradead.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240605122106.23818-1-brgl@bgdev.pl> <878qziqjn5.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <878qziqjn5.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FEhgh-xv4AfcdpCcpXYjCI7RdTDSgPn2
X-Proofpoint-GUID: FEhgh-xv4AfcdpCcpXYjCI7RdTDSgPn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=703 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060127

On 6/6/2024 6:35 AM, Kalle Valo wrote:
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
> 
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Here are the two dt-binding patches from the power-sequencing series
>> targeting the wireless subsystem. To keep the cover-letter short, I
>> won't repeat all the details, they can be found in the cover-letter for
>> v8. Please consider picking them up into your tree, they were reviewed
>> by Krzysztof earlier.
> 
> Is it ok for everyone that I'll take these to our ath.git tree?
> 

Kalle, if you take through your tree can you:
s/quic_jjohnson@quicinc.com/jjohnson@kernel.org/


