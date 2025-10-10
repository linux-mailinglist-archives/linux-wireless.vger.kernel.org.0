Return-Path: <linux-wireless+bounces-27934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9729EBCE8CB
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 22:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F16545734
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF79425A2C2;
	Fri, 10 Oct 2025 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jQQOd46w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD508248F64
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129244; cv=none; b=K31Vm6N6HGpKZe+zIvGiSkmce6MHaE19nLkZOtVws+Hu9EpVR6LmUV49u9+nZz0oAhh0WEDroXKchYX+HhVzLBMHTn+aRuHNmHVINrboNYdnw1NteIRhHAUVrYeRA0MxV+rpCKzJOOINaQBTdVvN10tazv/xmGRov/dVRSjQeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129244; c=relaxed/simple;
	bh=PdXhByk1+NOB46va2uOzluP4tGcOJIJRRR8RfoQHrDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oHZNGnu8+tWpNA93ZXjfIWXaThBoXP6SLIau6eQqXhsCGtXBFpu98wcZzbap19j0SoReb0Np8O4y4zjE4EcLg8g1kMiW71nXF1QIN7LJwu99zhRiJozsiYVRsHGVXYfEd8zssloqwuNGAyYFRzTWdjafA3uW4hZyaZL2dkn56VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jQQOd46w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFCdRn002397;
	Fri, 10 Oct 2025 20:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	najEdkHdqjsVKeBFGTiQSWP3OgjzKyuYx9pDx1zXfd4=; b=jQQOd46w08o6uRU5
	Bt4Cb1Wb33rpcuIlBqF9AHdrD/+gYLkr1rjoBa1Py1IBRuFm0CdbKEMYLlPRIaC+
	a/1xko6dyeK8S2iqmKACRf7S3as43VdqZmDIBF8+QKIDi2iJpuIFAp+V9SVKVVVg
	8bxl469/QlMW4i3zC9TbVgKqhmUIOcrGHCJTyAHVjb+JCnu/uFsQSz3b20r8ZCZb
	X73ZPdY0t/nEvYStVp/H9EAO0+7h947wnsNA+fguUoz2vBSdVDdFoRwXwrnz+Fs/
	zfVXQ5UxOPQ+ZJmems1Y5A4VzOciWTndwIYJo5uBuzuq6JPEpaWSUOhrBcBNqPvJ
	ppGYtQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49pgdsv6ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 20:47:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59AKlImE010770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 20:47:18 GMT
Received: from [10.227.105.53] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Fri, 10 Oct
 2025 13:47:17 -0700
Message-ID: <316af676-bd6b-463e-96e7-fd848f0c9b7b@quicinc.com>
Date: Fri, 10 Oct 2025 13:47:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V16 2/2] wifi: ath12k: fix TX and RX MCS rate
 configurations in HE mode
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
References: <20251002000732.1916364-1-quic_pradeepc@quicinc.com>
 <20251002000732.1916364-3-quic_pradeepc@quicinc.com>
 <d2c0cc75-6ec3-4566-ab5c-1757d1a753de@oss.qualcomm.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <d2c0cc75-6ec3-4566-ab5c-1757d1a753de@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WSLz5Fs9lTbLysM5u7eYg0cukaNNLKkc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA5OCBTYWx0ZWRfX7OJGX/VvY4e0
 r5750a1qG4ZIZylfPjJlwt2S1cQJMVDvl56a7axbiYjxy4Jreluz2zGqKgL2Jr/xfRZCL6xZddW
 8PgAIL5OTEfqIkoKPaZ18XVswnJIIGx2SRe064shSfZ7swViAiq0bocnJ3wF2y4HoqfecNxkN7Q
 Gmj5DXGQmOa5uEJ8wspG4hH1M+lXVEUp/UJfCSXeSIVh/dffpjiaRwtKaOIvr3FvmkVejQAhdzZ
 J0IJzyAuzg/FcbHDh/xisK+p2FocAALkafse706ax0ziuhi2klk/EWyno41czJygh/NXwmDnQsN
 Yh2A9pv3zrnGRm6jXXJCUrw0nonNnasqafCEJ6UFb6hYrgT3SAJa41c932FNS2lWNsY0UMAvlaQ
 gm6T/nq1qV82xsYWKpmhaNeZmyatPA==
X-Authority-Analysis: v=2.4 cv=DISCIiNb c=1 sm=1 tr=0 ts=68e970d7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8
 a=RV7APKlVysKMHHnRL-wA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WSLz5Fs9lTbLysM5u7eYg0cukaNNLKkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510090098



On 10/9/2025 12:52 AM, Baochen Qiang wrote:
> 
> 
> On 10/2/2025 8:07 AM, Pradeep Kumar Chitrapu wrote:
>> Currently, the TX and RX MCS rate configurations per peer are
>> reversed when sent to the firmware. As a result, RX MCS rates
>> are configured for TX, and vice versa. This commit rectifies
>> the configuration to match what the firmware expects.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 0d425a1bc0ab..19be450b42ff 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -2624,9 +2624,8 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
>>   	switch (link_sta->bandwidth) {
>>   	case IEEE80211_STA_RX_BW_160:
>>   		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
>> -		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
>> -
>>   		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
>> +		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
> 
> missing recalculation of v for TX MCS 160 before assignment to
> arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160]:
Thanks Baochen

addressed in next revision

