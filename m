Return-Path: <linux-wireless+bounces-5980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC689CC8C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 21:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674721F229EB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D2145B1B;
	Mon,  8 Apr 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J5hEsaiV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978AF1EA73
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605368; cv=none; b=LDDXglm5wUQe90A9jEGJtWVaWoXYEEIREzRE9paCxGu04Hgh9QzXORIiSSrv27PYgHudytVsnn7ZRRY2u6+ynSsMQeBJ7z0ZOws83Cf/aqQclUZdqu8+5uZGMkYX5E0SdNYmKBzYvABTrDZyHrsYL7ZVFTM96awmem/UgamoTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605368; c=relaxed/simple;
	bh=Ql/y3xGFD8R2h4utuEOH7zmluwvbyMMUTpx3DOuyZy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MD8Tiw0Kw0gmxFmtMiGPVUs7MJhJPOF0+neq/dvQrHaytv9fVla8WtaSV8LYJXxcGJq21Ac3QyG4WXP8+99sT6m2A8jBWzcmWa30EfMRuHtZ+hHX4Z+saV2bi9jLhDuWrJA/AnLJUTZYDVA7EMvKooxPJajYj525/JojN7YNkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J5hEsaiV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438IxGmr009106;
	Mon, 8 Apr 2024 19:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2DOc43ENOSYzL745L66G4N3iRCacHDFhiFHWbvRmax4=; b=J5
	hEsaiV0TZYnc97LSwFQR4AOTwjZxZ1vKn9cW8kGoBfKlgsPA4UJkcvZkNR0hOIar
	+QWGPS6aAKkkrK0dmCe5xepAryhVBNY1YD1TL0c0iNXDgtFI79jPUb4WTxbCGj7Q
	fLWv69fGarXxwSTQRF9qIaEaAx+srKKoWXQAXjGJCeE1mqk7ixukssqtyaIf+71h
	l0hDCbHEBVAbnSyGdOIJdnnHwg8KhjT2Jf9DZuW9n24X4S1Bzz78jScwj+o4gbfy
	YzVwwOKjlaTGvgvttP2XXXqlDoqn++Wjf+ieaHidYF07EOsoXpnlfbzvhAqXcg/C
	3/mtptVWdKNPvtOcTCnw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg0hrq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 19:42:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438JgZJA002558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 19:42:35 GMT
Received: from [10.110.80.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 12:42:34 -0700
Message-ID: <4987737e-df85-452c-85a6-9032fb620dd5@quicinc.com>
Date: Mon, 8 Apr 2024 12:42:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: Clear mlo_links info when STA disconnect
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Xin Deng
	<quic_deng@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240327032448.15098-1-quic_deng@quicinc.com>
 <e599d1b1c7c6e32856eb5374cfaa20965b49b44c.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <e599d1b1c7c6e32856eb5374cfaa20965b49b44c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zxj-cKJSY_TBDvTso3m0_mAocGSkxNVw
X-Proofpoint-ORIG-GUID: zxj-cKJSY_TBDvTso3m0_mAocGSkxNVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080152

On 4/8/2024 11:41 AM, Johannes Berg wrote:
> On Tue, 2024-03-26 at 20:24 -0700, Xin Deng wrote:
>> wdev->valid_links is not cleared when upper layer disconnect from a
>> wdev->AP MLD. It has been observed that this would prevent offchannel
>> operations like remain-on-channel which would be needed for user space
>> operations with Public Action frame.
> 
> I agree that's a problem, we shouldn't leave the valid_links set.
> 
>> Signed-off-by: Xin Deng <quic_deng@quicinc.com>
>> ---
>>  net/wireless/sme.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/wireless/sme.c b/net/wireless/sme.c
>> index 82e3ce42206c..86e837f37f8c 100644
>> --- a/net/wireless/sme.c
>> +++ b/net/wireless/sme.c
>> @@ -492,6 +492,7 @@ void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask)
>>  				 &wdev->links[link].client.current_bss->pub);
>>  		wdev->links[link].client.current_bss = NULL;
>>  	}
>> +	wdev->valid_links = 0;
>>
> 
> But this is (very obviously, even with only the limited context shown!)
> in the completely wrong place.

Concur, so NAK my Reviewed-by:

That function is potentially only removing a subset of links, so it should not
be setting the valid_links to 0 since not all of the links may have been removed.

/jeff


