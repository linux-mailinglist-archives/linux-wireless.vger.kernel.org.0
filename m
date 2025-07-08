Return-Path: <linux-wireless+bounces-24941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9417AFCAB0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF347B4CE7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672302DC35E;
	Tue,  8 Jul 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UFBz7uKL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17992DCF54
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978592; cv=none; b=keqWhoF7p0bSpwQjF9wz02TulFnMgcBWg6kxQ80kVqjVzVbX/d68Ybo9XU0oyIq179RbRUTxnTry4ZUddy3PNdh5J0W+Ue64pARkIUqeFJPC95348wh0h3VQONKlvPKMN3oFxf5ZPlfQpKzlo0EkCk7KW05NlyLhWp+Ymb/34uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978592; c=relaxed/simple;
	bh=w13zHX3qjToFXbIHdkM4bGQdNHa7gGq79JPDHGz9KZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Udupdxp4zUcmJPlhXfxTovKKOzCbGiK0BD8bcwzveL/mqWtNiNB3NCNDv1OmWF/kFedWLp3Gin+PCTzXFdn0UC/l5T2oMd1IqjOIcIFLk2KtMefk30eTPeKBmIHcRXAMrEpqMjBMOYzUxKq3WfQEsRFojA7/1ltYwsfKZRifMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UFBz7uKL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAGcD008288;
	Tue, 8 Jul 2025 12:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iIGO7z6GU35SGTJG3x/0lyK3vvg1SoiP4h8D7wGGZrw=; b=UFBz7uKLnTvn4g0V
	Qrpwry/FrItAZCPJICXDsD9oQdgqKHYazMOZpYfss6eO+/RzbGznNQO8dC2GZy+B
	sdYqqatCxmaIhfrEk1ojZk35xLMpQImW04ip7IZQoEltYjYYxr5EwH5g3Aih21R2
	sJ/QlsqvArFCY9GE4td8ZJrjL6UMe8h50GTN0/hA1F8XDF4yTWaaiXdkF8uu/awb
	/AAyee0BgnOuZ0q5526b4wiQimMVGv9F8SssQor1WLwNCT+G2HIiG3dYBqVfsr2C
	tOoZbsQY5t43rOc5LvAn9EQaPzjeBp3lsMqjOVVqpUWLlGCtQ7KPHWPmAbgROkjp
	UL3k5g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucmwrdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 12:43:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 568Ch2U8010603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Jul 2025 12:43:03 GMT
Received: from [10.206.97.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
 2025 05:43:01 -0700
Message-ID: <44be02ad-3196-422d-9f75-ec89b478149f@quicinc.com>
Date: Tue, 8 Jul 2025 18:12:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] wifi: nl80211: Extend NAN APIs to allow more flexible
 implementations
To: Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
Content-Language: en-US
From: Vinay Gannevaram <quic_vganneva@quicinc.com>
In-Reply-To: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686d1257 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=yGvjlSR8lgh1hHM4jjMA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: ei5vqWbXvR5CQZUJY_8k5gRKzPU_8Z4f
X-Proofpoint-ORIG-GUID: ei5vqWbXvR5CQZUJY_8k5gRKzPU_8Z4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwNSBTYWx0ZWRfX5bNRTpXGMsxm
 pZqGaRRsS2qV7Jp7L3+mATphJGrw5gB8KLxAFcT81R9yQ+yT3MkaJWOk3lR76ZI9kVdoGpdeQZE
 WSKAO07T6uJ5c756/kNc5DqYJUOGhzD3wNHvoNrZs0AHD2z9G1z4DLDIBhbhcWWiWrAiVFHzwiE
 F97g6ysLBVb64XSwDdQtZgNyWdjIyZmQ5tT1mGmfDhZo0lzGE46CbdZnICT1U17SIWirq1YaVTV
 2AGZxUHNuDsNyc3xi1hGcXUJepQoRIGcYpBesgTEbrV+nzNQDY4xToeg1U8Y1J8DXlQ+AB0RpND
 83TzAKGWl62DhyR3XerwSbLVd6R/m4pPXLeBnT6iiYT51uMhTUI1to9aflc1B+JHyUUYsaq+l7H
 GJrfH1d8PZRHHvKERuaN9vRfxVEfnoEOfmZwdwVoZWYX/81zgOl+PegRF9ZZiRE+JE/9tf4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=486 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080105


On 6/23/2025 3:54 AM, Andrei Otcheretianski wrote:
> To support user space oriented NAN Discovery Engine, the device will
> notify user space with %NL80211_CMD_NAN_NEXT_DW_NOTIFICATION about the
> upcoming Discovery Window (DW). This notification should be used as a
> trigger for transmission of uncsolicited multicast SDF's (i.e.
s/uncsolicited/unsolicited
> unsolicited publish and active subscribe). Once SDF transmission is
> requested with %NL80211_CMD_FRAME, the device shall take care of the
> actual frame transmission during the upcoming DW.
Any specific reason for not carrying the untransmitted frames to next 
DW? Any scenarios that this could cause failures?

