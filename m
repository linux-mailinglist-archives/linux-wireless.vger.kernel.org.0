Return-Path: <linux-wireless+bounces-24689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B4AEE97B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 23:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C017E3BBA7D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386C922333D;
	Mon, 30 Jun 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="irly4bCv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449851D7E41
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751319321; cv=none; b=agoKAbVabKnRoGKNSPQ7Vw2MmEcSz7szqIjt4W0eK4ojp1aggFqWEFjxed+bDh2VlGHbVeIBBZdI9bnEC4+93roVQAmPmB8peUJvQbJlcR6lyseimCAz1i7aSJ25CW2U4p9YmULOL+wgUgk7dj0SSKadYi5kt44JZ255zrkPCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751319321; c=relaxed/simple;
	bh=jzNWa+yqWYtlCKcHuBZ00/ZA0rWJS0+BuKPz7yaF5WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qLrNnZhDTOb49YsTNRTIlQzoIj3FKh9tDdOzkavp8Wt5qCa6nL/5kmjLzB8PUNrnes1Hmcy3eYXBJ9QZIv7VV4OdXA5QBDRdfYCshpMCl+bYVjAGS4e9Ty61fOL1c2TAGxIAOu/scEoA2TaAFMK2hXIwj0mi0lvdp/WZ3X2cfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=irly4bCv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UG41Vr007067;
	Mon, 30 Jun 2025 21:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5JJ7cmNf4QIGHrU0UT8sxK1hL+7x6e3GGoNHo7dpzi8=; b=irly4bCvtGRrW/TR
	tUw2H9u4wgpHbIrosZBvfx51RvaJBfXxK5icdAMDVwS5ZqPdrOzbK89MAZ4bjjbG
	X9uxvOb2cwXMqegZztoYx19qIZqPs+UO85tCkZDSW09XDZGjmihBActU+js7v1Dp
	ZPoo/Oji2+1B5ca22IamvMhyNz51RWVDNoKpjyEq5/Jo2zLXoTMk4A9RgOjtOb/S
	mT5xQ9SPJODFCNawDOlgVMRsXfQa8txtVt/+CNzNo8WM1IxzaRhzbfKsp8F9lcUl
	WKnUxLaPMwvT35IIU0YKc4gQWSqVU/DXIiTry/GQgKhXFUOXANlmeSZFjWTRAzGh
	3hNX3w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5jakn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 21:35:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55ULZDHw005926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 21:35:13 GMT
Received: from [10.227.105.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Jun
 2025 14:35:12 -0700
Message-ID: <16a73078-4bec-43fe-ba82-e160062bc449@quicinc.com>
Date: Mon, 30 Jun 2025 14:34:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V14 0/9] wifi: ath12k: add MU-MIMO and 160 MHz
 bandwidth support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250521224539.355985-1-quic_pradeepc@quicinc.com>
 <4521d120-422d-4dbc-9461-6bd0dc32d628@oss.qualcomm.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <4521d120-422d-4dbc-9461-6bd0dc32d628@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=68630311 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=D7CeFnMDRyunoCdJu4kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -u5qw8iS3ODDmtbdOki8vg92YMVtYVAc
X-Proofpoint-GUID: -u5qw8iS3ODDmtbdOki8vg92YMVtYVAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE3NyBTYWx0ZWRfX4bLJ9zWtv9kr
 z6r6y8yXeTN9smny0VumuYQ5myGrIDAqV8P0ZMwpRgEx1xZep3TWV64rlEblkNwOGWrGrjyh18s
 2y4fJpwxVrc+j+wSFmCAFy/19KWuq23eG1/9xm1O1/4vmJmCa75U7uyQPedf0w3DoR+PvyOhov+
 IEl1qVizNq10gbTWcu+DEDugFqL25ZJpezreKI4zFqv0WO+E1F0UWvHUHdGprwRRE+N0sBo2QVo
 /6uc9GvBgFh9mQMJ+hML6ygFWK0ZSQnqMsblWh+3ofwjMhBHXnkOlu627DN9qFQxu2LIFplk3Vc
 Wbg2UmkMfjymV+sTok1KNEcuoke3CiyKVXoksWt7L2Wdqs9nXIJQ/Fh8ML2SJSdpWfjov41O9Wa
 c+LSmd+StIxM6wkWerpZXmKjnjlRiTAhdJcdi+laup5jpw9+f9hyVaCGra1vzLXe+HrgVVqe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300177



On 6/23/2025 8:03 AM, Jeff Johnson wrote:
> On 5/21/2025 3:45 PM, Pradeep Kumar Chitrapu wrote:
>>   Add support for
>> 1. enabling MU-MIMO in HE and EHT modes from hardware
>> 2. setting fixed HE rate/GI/LTF
>> 3. 160 MHz bandwidth in HE mode
>> 4. extended NSS bandwidth support
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> changes in v14:
>>   patch 6/9:
>>   - cap max_nss using ar->num_tx_chains to fix interop issue caused due
>>     to sending nss value 4 when firmware only supports nss value 2.
>>   patch 8/9:
>>   - Set the default return value to MODE_11AC_VHT160 for 160 MHz
>>     to allow STA to connect to the AP even if it does not
>>     explicitly indicate 160 MHz bandwidth support.
>>
>> changes in v13:
>>   - rebase
>>
>> changes in v12:
>>   - rebase
>>
>> changes in v11:
>>   patch 1/9:
>>    - fix return values in ath12k_mac_set_he_txbf_conf() and
>>      ath12k_mac_vif_recalc_sta_he_txbf()
>>   patch 6/9:
>>    - fix missing he_mcs initialization in ath12k_mac_init_arvif()
>>
>> changes in v10:
>>   patch 6/9:
>>    - use ath12k_ahsta_to_sta()
>>    - fix rcu_dereference warning in ath12k_mac_set_bitrate_mask_iter()
>>    - change return type for ath12k_mac_validate_fixed_rate_settings()
>>    - improve readability by adhering to nl80211 definitions of GI
>>      NL80211_TXRATE_DEFAULT_GI. Introduce ath12k_mac_nlgi_to_wmigi()
>>      for conversion.
>>   patch 7/9:
>>    - do not change default MODE_11AC_VHT160 in
>>      ath12k_mac_get_phymode_vht() as it breaks clients which do not
>>      set VHT_CAP_SUPP_CHAN_WIDTH_160MHZ.
>>   patch 8/9:
>>    - Use IEEE80211_VHT_CAP_EXT_NSS_BW_MASK along with
>>      IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ for determining VHT160
>>      phymode.
>>
>> changes in v9: rebase on top of master branch with mlo changes
>>   patch 1/9 and 2/9:
>>    - fetch link_conf using ath12k_mac_get_link_bss_conf()
>>      instead of arvif->vif->bss_conf before mlo
>>   patch 6/9
>>    - fetch mcs/nss values from sta->link[] instead of sta->deflink
>>    - fix spelling of 'incompatibility'
>>   patch 8/9
>>    - replace sta->deflink.addr with arsta->addr in
>>      ath12k_peer_assoc_h_vht
>>   patch 9/9
>>    - replace sta->deflink.rx_nss with link_sta->rx_nss
>>
>> changes in v8:
>>   - rebase and resolve KASAN warnings reported by Jeff in v7, in patch 6/9.
>>
>> Pradeep Kumar Chitrapu (9):
>>    wifi: ath12k: push HE MU-MIMO params to hardware
>>    wifi: ath12k: push EHT MU-MIMO params to hardware
>>    wifi: ath12k: move HE MCS mapper to a separate function
>>    wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
>>    wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
>>    wifi: ath12k: add support for setting fixed HE rate/GI/LTF
>>    wifi: ath12k: clean up 80P80 support
>>    wifi: ath12k: add support for 160 MHz bandwidth
>>    wifi: ath12k: add extended NSS bandwidth support for 160 MHz
>>
>>   drivers/net/wireless/ath/ath12k/core.h |    2 +
>>   drivers/net/wireless/ath/ath12k/mac.c  | 1144 ++++++++++++++++++++----
>>   drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>>   drivers/net/wireless/ath/ath12k/wmi.c  |   13 +-
>>   drivers/net/wireless/ath/ath12k/wmi.h  |  107 ++-
>>   5 files changed, 1061 insertions(+), 222 deletions(-)
>>
>>
>> base-commit: 0d777aa2ca77584b339ce195db86fe0ee7dda5d5
> 
> This series no longer applies cleanly on ath/main, please rebase
> 
> Applying: wifi: ath12k: push HE MU-MIMO params to hardware
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/mac.c
> M       drivers/net/wireless/ath/ath12k/mac.h
> M       drivers/net/wireless/ath/ath12k/wmi.h
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
> Auto-merging drivers/net/wireless/ath/ath12k/mac.h
> Auto-merging drivers/net/wireless/ath/ath12k/mac.c
> Applying: wifi: ath12k: push EHT MU-MIMO params to hardware
> Applying: wifi: ath12k: move HE MCS mapper to a separate function
> Applying: wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
> Applying: wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
> Applying: wifi: ath12k: add support for setting fixed HE rate/GI/LTF
> Applying: wifi: ath12k: clean up 80P80 support
> Applying: wifi: ath12k: add support for 160 MHz bandwidth
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/core.h
> M       drivers/net/wireless/ath/ath12k/mac.c
> M       drivers/net/wireless/ath/ath12k/mac.h
> M       drivers/net/wireless/ath/ath12k/wmi.c
> M       drivers/net/wireless/ath/ath12k/wmi.h
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
> CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/wmi.h
> Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
> Auto-merging drivers/net/wireless/ath/ath12k/mac.h
> Auto-merging drivers/net/wireless/ath/ath12k/mac.c
> Auto-merging drivers/net/wireless/ath/ath12k/core.h
> Recorded preimage for 'drivers/net/wireless/ath/ath12k/wmi.h'
> error: Failed to merge in the changes.
> Patch failed at 0008 wifi: ath12k: add support for 160 MHz bandwidth
> 
Thanks Jeff..i waiting for discussion on "[PATCH ath-next] wifi: ath11k: 
fix peer HE MCS assignment" to close as this is related here..will post 
next revision today

