Return-Path: <linux-wireless+bounces-27749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A2BACFCA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DF27A9F30
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8413524E00F;
	Tue, 30 Sep 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="omkCt99W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD6156F45
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237953; cv=none; b=huITI+pHt95Kay+K0grHOh45v24i93+MwAw/0G1MPrOyoTgjYLmVDQerhIH13Ln35sxnt89f6vYXrV/EvdFKhLPmbIEg8aGmsbqpA5YWBGIJHUS2oG8EDfhOk2yNHWbl7Mygu1Mai93nLjdOYk5AKPhyhNYjA4zenMBdylQVIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237953; c=relaxed/simple;
	bh=BlL8nCF1bJeQh2PZ6VzMA/HOuOxBT7IHb7fO0Z4OELI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a1UK8A9wBgn/ufOg+yWIP9Kxx/qtQTue+AJjKudyA9AXZw575m8Pz7PVnJnFWD0AGnRtS5i0K2cSJW0LfJq5KHhgpuMRoB9KbxSQJBt6Tfngq4IJkY4qE8/Dr934N5USPl3Ws1ZKJZq+MJtUaxLusq4MsDinemWp7sGm8eSOkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=omkCt99W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBnM3u014639;
	Tue, 30 Sep 2025 13:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IlUwWJDfckEuvqk5pG1t9MrAPhZFXCfatpDAZlAI/LQ=; b=omkCt99WVciRehG8
	BDg7DPZ4oKFYzv4HqwLSQfGMXfDlihDScOFtuEb5FL5WxqVKU35fkIhveo4ZfqCM
	h1r/NFH83jeLyuYjhfRm/bPrd+PHdbeojI6Ygaq8km6Ou4gs1vRnHDJqobm3Vk7k
	Z1hzuAIBQZ+vRYxQEl88+vtLCMZMGWCDlpHalZQrySiNJT6QbK0dZK4jjG4BoyWk
	oTotXPZ/3+CCeJW5Qj176kkwzVlIi/wkA4PHCKCd8rn/ZTfSD5pN2BPS7imSd57f
	Dh5FQlErBdhFtWGNyC7v7o3sxBLqa5H5JPxOYWO1PM1K66x1Qlm23LogroHOZrlC
	0GOUxw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr110e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 13:12:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58UDCTX5005510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 13:12:29 GMT
Received: from [10.79.124.128] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 30 Sep
 2025 06:12:28 -0700
Message-ID: <4b530795-3508-4179-b33c-05e58869ca09@quicinc.com>
Date: Tue, 30 Sep 2025 18:42:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng v3 6/6] wifi: ath12k: Refactor ath12k_vif
 structure
Content-Language: en-GB
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250929115102.512719-1-quic_rdeuri@quicinc.com>
 <20250929115102.512719-7-quic_rdeuri@quicinc.com>
 <39facf12-c452-4fa4-9b76-3da6a0ce3230@oss.qualcomm.com>
From: Ripan Deuri <quic_rdeuri@quicinc.com>
In-Reply-To: <39facf12-c452-4fa4-9b76-3da6a0ce3230@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FnNrCSqTg4Foq0c0V385hU1VnigS-eja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX3kkhi4jDaHcy
 xmyy/edD2Oxw4+p29wqdB/8XmPC7l4NV/zlrNkOqup1kyKClYAXWW5EV3bRDbDx8Dw3sJ15PFnS
 h5bTU0l9qoCQF1lAL8ilz44uaRg8M1iTwEC1zPIyBOTMJAA14Z0hGRshsoNr/hL7ykCyuTLKGeo
 C0sidJPDy/J9jRkYII/XXbMH2xJHhXZMm5wd6uoZQkTGGlDBMHj6kKpBbON2HCoEJqN4OimVUnJ
 f7Gb2+HgYkmg2SXYcMFtLgGP6M19j57+qdXq92vUBC8JbgafFJmfLFVWRWbsA3RXX7+UTfw6WYG
 U5dOamm7AeIdVCL5aTNXX7+K0cpDgAS5HEZyFbVdifDOdpG2/ZfRYY2n7jldenBHcn0QZP4zLnM
 s7vNbEb3fgO03gA4rM+Z2ZLlz+2u5w==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dbd73e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=4MtMu4i2hCYbHh_dtokA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FnNrCSqTg4Foq0c0V385hU1VnigS-eja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017



On 9/30/2025 9:00 AM, Baochen Qiang wrote:
> 
> 
> On 9/29/2025 7:51 PM, Ripan Deuri wrote:
> 
>> @@ -938,15 +944,19 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
>>  
>>  static void ath12k_dp_update_vdev_search(struct ath12k_link_vif *arvif)
>>  {
>> +	u8 link_id = arvif->link_id;
>> +	struct ath12k_vif *ahvif = arvif->ahvif;
>> +	struct ath12k_dp_link_vif *dp_link_vif = &ahvif->dp_vif.dp_link_vif[link_id];
> 
> nit: consistently use ath12k_dp_vif_to_dp_link_vif()

Addressed in v4.

>> +
>>  	switch (arvif->ahvif->vdev_type) {
>>  	case WMI_VDEV_TYPE_STA:
>> -		arvif->hal_addr_search_flags = HAL_TX_ADDRY_EN;
>> -		arvif->search_type = HAL_TX_ADDR_SEARCH_INDEX;
>> +		dp_link_vif->hal_addr_search_flags = HAL_TX_ADDRY_EN;
>> +		dp_link_vif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
>>  		break;
>>  	case WMI_VDEV_TYPE_AP:
>>  	case WMI_VDEV_TYPE_IBSS:
>> -		arvif->hal_addr_search_flags = HAL_TX_ADDRX_EN;
>> -		arvif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
>> +		dp_link_vif->hal_addr_search_flags = HAL_TX_ADDRX_EN;
>> +		dp_link_vif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
>>  		break;
>>  	case WMI_VDEV_TYPE_MONITOR:
>>  	default:
> 
> [...]
> 
>> @@ -318,12 +318,14 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
>>  		       struct ath12k_wmi_peer_create_arg *arg)
>>  {
>>  	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
>> +	struct ath12k_vif *ahvif = arvif->ahvif;
>>  	struct ath12k_link_sta *arsta;
>>  	u8 link_id = arvif->link_id;
>>  	struct ath12k_peer *peer;
>>  	struct ath12k_sta *ahsta;
>>  	u16 ml_peer_id;
>>  	int ret;
>> +	struct ath12k_dp_link_vif *dp_link_vif = &ahvif->dp_vif.dp_link_vif[link_id];
> 
> same here, use ath12k_dp_vif_to_dp_link_vif()

Addressed in v4.


