Return-Path: <linux-wireless+bounces-15962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22F9E6B39
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 11:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04C6281053
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8303A1EC013;
	Fri,  6 Dec 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k+S5l4Cl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34A18C932;
	Fri,  6 Dec 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479225; cv=none; b=shOIEd80eOEx7FVbM2ilmzn2NZnXlC/Ap3LzDp11U7WGNg5iRIwZQb8Ot58enleCdJs7AsCXgqvPvoSTgjgSAFKVAqSbOHzxudxop84LlkV1GENDmdh2xbtrqTpYm4Y6pVu2v1IPreu1nTVHPlRpqf1V9tKiavCKGZvRxYDT7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479225; c=relaxed/simple;
	bh=x7Q73Aku/afgJ3QD5BhoJeaye8+RH6YqQVtIYOObhvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OEfCPpTxZ0uk1vFF3qvxGZTC0vtRQUPB0qGxR59XzqC0tehAYalSEDosf0Rz0KJSun41KPBO/80e/O8iCNWbIxSNX8AImxSCG7pqSAe8Vs+fOdiuMLkypyz2jqISpKUae+CA8LbqM5+XiBwrvtRbrhyXVzhTu/mKbX2F7bmpE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k+S5l4Cl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B69SWEv016321;
	Fri, 6 Dec 2024 10:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/6SfTzBF4ioa1KXYZxhAGGE+Q7GnLFbiH24b6nL2Vh0=; b=k+S5l4Clh3nk8mVI
	AZz7QyKC4WlFI8aLx8ZVi9X+wYCSI6wMzYUGyHVcu3836aiRui3G+mIhWygRnddH
	DSxA00nMQAYqmWNGcogxMY3roxkFKqw2RazpjthO0GTmg8ZNlHSaUXi4XEFnjGBk
	R+jIF8jjWdAY3isjqfe1ImPJv8JVcyBLnI97vG1uEUPLbwdTV2qw0KxxihLL4h4l
	9SaqEdBG3g3q6qFRCfIeO2llb2BT/owQMdLPzO8VDdSHqf+pR0uvcA0Y3K/M45l7
	fXelvJBXvuVdYfeewC3EXjgS4vFLBNhq44Io+IOnnXcx4clR52ts4rWAc3u4gO/b
	Ookx2A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bxny8318-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:00:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6A0FdX029894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 10:00:15 GMT
Received: from [10.151.41.184] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Dec 2024
 02:00:10 -0800
Message-ID: <9f8b86fa-65d1-45ef-b363-54772e2c48ba@quicinc.com>
Date: Fri, 6 Dec 2024 15:30:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/22] wifi: ath12k: add AHB driver support for IPQ5332
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        "P Praneesh" <quic_ppranees@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-18-quic_rajkbhag@quicinc.com>
 <243cd21d-6a35-4ff0-9b38-ec519a804670@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <243cd21d-6a35-4ff0-9b38-ec519a804670@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J_6rJBf7e5pZnwX8FryHlP9jpdrd-0P1
X-Proofpoint-ORIG-GUID: J_6rJBf7e5pZnwX8FryHlP9jpdrd-0P1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=916 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060072

On 10/19/2024 1:59 AM, Konrad Dybcio wrote:
>> +static int ath12k_ahb_start(struct ath12k_base *ab)
>> +{
>> +	ath12k_ahb_ce_irqs_enable(ab);
>> +	ath12k_ce_rx_post_buf(ab);
>> +
>> +	return 0;
>> +}
> Neither this nor ath12k_pci returns anything useful - perhaps make this void?

Thanks for the comment, this requires changes to be done also in ath12k pci and
hif_ops, hence, will take is up separately.

