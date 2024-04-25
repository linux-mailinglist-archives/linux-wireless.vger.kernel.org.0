Return-Path: <linux-wireless+bounces-6903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C50908B2DA1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 01:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8481F22094
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9501F78C86;
	Thu, 25 Apr 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dmGFWFqV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34F01DFF2
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088251; cv=none; b=Dor97Fi/szkzlIp3z5bCXPVhqFgiNyvnRFpmvFoQyIexSWyqPnVJyUCcc8uc7DpxAZOKQ38mGUJrvNEdTdmkZ2O7+Dx6IU63dG7hKsPlOuyAaiWnQSgoBXI1DxTH84UOtDcplCf4myOG81R+QkzwrLlBzF6b7t1OebYxXr+sE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088251; c=relaxed/simple;
	bh=Cu/OREzDoDWGEBryTbPC7umEBdYQJ1SWnCdZRcOvRi8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=kPmvdaSZA+AT9wxtC8k6fDc94HJ+josUE0n4PHsI///JpezKr//761AC7d6OTt5AtGZJ8s1OsXtuIL7aOSRIdcVflntlijZfse44YY4FMdSwHivi7ExnzwlUbiFrQsWlfwCeyWu3X0YNLr6n2aa+7DD7BmUnJ9U4a9Dd7CtAMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dmGFWFqV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PKjKxh009289;
	Thu, 25 Apr 2024 23:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AgXTrurLzJRdosDMBnlpwll5gIJabJB9pAmfi6ml8HQ=; b=dm
	GFWFqV09NyJnIzHC2v/JLTFmxVLP171dNFY2zlGKwBG6SUZrHinn7+Epqqpoty90
	c+KGhdSdRlt1cXVWDIzACSOseUdlV38wHRLOhtrDzsJJKKhQ7M/xr1fw4VMxSrIj
	pUpSr6tI33ihzeO/uqdV/nAW0gXhbWnESR1A/JneoAZsDJ3b28UAjkNvkY3uX/PK
	8ojFNsp7fnbn1MqVae1etEFOIaa1AnUmxO8bQAq2J1xTcuXj/POYH7Sp98n2vQSt
	xTUltSLPTKjbQCycAjXZ3tJzp+dQzCRFDYZywHHHIA4QTSUz/Y/rXp7GmNK5Rlke
	SJVbzrxZDw2eXSxlMBgQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenkkxb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:37:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PNbLn8019598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:37:21 GMT
Received: from [10.110.19.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 16:37:21 -0700
Message-ID: <e44b6394-f2ba-4291-8683-b37ab634047b@quicinc.com>
Date: Thu, 25 Apr 2024 16:37:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
 <20240424201959.935-8-quic_pradeepc@quicinc.com>
 <72bc6772-8bf7-427d-8f03-01e8dbf30d0c@quicinc.com>
In-Reply-To: <72bc6772-8bf7-427d-8f03-01e8dbf30d0c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o0XFEIJgjQMrHdoiExbd7fX1WvZVGSEB
X-Proofpoint-GUID: o0XFEIJgjQMrHdoiExbd7fX1WvZVGSEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250173

On 4/25/2024 3:32 PM, Jeff Johnson wrote:
> On 4/24/2024 1:19 PM, Pradeep Kumar Chitrapu wrote:
>> Add support to set fixed HE rate/GI/LTF values using nl80211.
>> Reuse parts of the existing code path already used for HT/VHT
>> to implement the new helpers symmetrically, similar to how
>> HT/VHT is handled.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> ---
> 
> [...]
> 
>> @@ -7753,7 +8034,20 @@ ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
>>  			return false;
>>  	}
>>  
>> -	if (ht_nss_mask != vht_nss_mask)
>> +	he_mcs_map = le16_to_cpu(ath12k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
> 
> drivers/net/wireless/ath/ath12k/mac.c:8041:22: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    expected struct ieee80211_sta_he_cap const *he_cap
> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    got struct ieee80211_sta_he_cap const [noderef] __iftype_data *

for this issue you need to use ieee80211_get_he_iftype_cap() (may return NULL)


