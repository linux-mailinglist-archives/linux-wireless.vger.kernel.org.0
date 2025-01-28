Return-Path: <linux-wireless+bounces-18087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C46A211C3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1614E164DDF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC51AAA10;
	Tue, 28 Jan 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OABeqry1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB63BE40
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089867; cv=none; b=htVwelHRXWxIFCB7NGOoVjrE2088TgMqjOp+KEDFXUSC4AwcBhlswCTwzc58fPtYY3O5XEJFJsPds+aAxYAf8l+yu8pG8CXBpx0UXeKEY1owBDfem/Ah2t8+dA5QKWcoSyucn95QT4EyU6OjrBzMRoTyKba7rISm2tkjjBPAj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089867; c=relaxed/simple;
	bh=Vryms0MtBpfpYP9NAk8DXTaFuGwB2qF281uiyk6HVZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lC3u72nP73cB3puccpa2Nj2KpRGe90jZ8dB0uHf25IcFWddzlvPG2WVgxyO4GEkG6WHipXioeMFUU/TwlcDZAbzVLd3GB+QHFVr88ZnZyviquEi2Den4bnomQu7mVPdTUzbVCepvkZiOLu+tm2J3UqE9TPoP+66pCXqrDW/56oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OABeqry1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S8hdJZ015113;
	Tue, 28 Jan 2025 18:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gISoOuUG+dJBwBVgVJrUOWhOBwXlzKcp+WmiMBpGu4E=; b=OABeqry1mIih8luE
	82iEwIeEO5SKRdAKTYcvGlmwWej8lCElquT5dSEkwIr+zVxy+JK9UQXrePc6WNmU
	SWwO1RReXe3w7eqkZiosoLF8kajuhIXHkS7xvMCss5t8nhWtlbBOnucQIEuwTOqm
	itEfGA/rZY2sNkiMgJCxdLXqyDJdcs9XZ0i21yg0tvpLFRY39ozTbO9l6R2qjo8G
	9f2ysoDGaduKV6UTgw9vidAJblJuM+5dMXF3etgMaGqlq//IU0U6mFoLoJctTTnb
	GJxmmuTlTaNUZtmUShmlyL74MS9qdtSLKHPDQWgL6bqDLf89l0r2S7f6SH9/x2x+
	tfw9rQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44euyq9cvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 18:44:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50SIiNPb009086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 18:44:23 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 10:44:22 -0800
Message-ID: <238a5082-cfbd-4c2a-9ad8-ab4ae494b09c@quicinc.com>
Date: Tue, 28 Jan 2025 10:44:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
 <b9a81c89-70f0-453c-9619-5d1142bd91d4@oss.qualcomm.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <b9a81c89-70f0-453c-9619-5d1142bd91d4@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SKYl1RtW2LHATJlSnn2mGxuEoE_SViO9
X-Proofpoint-GUID: SKYl1RtW2LHATJlSnn2mGxuEoE_SViO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=956
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280137



On 1/26/2025 11:44 AM, Jeff Johnson wrote:
> On 1/13/2025 4:38 PM, Pradeep Kumar Chitrapu wrote:
> 
> ...
> 
>> +static int
>> +ath12k_mac_set_peer_he_fixed_rate(struct ath12k_link_vif *arvif,
>> +				  struct ath12k_link_sta *arsta,
>> +				  const struct cfg80211_bitrate_mask *mask,
>> +				  enum nl80211_band band)
>> +{
>> +	struct ath12k *ar = arvif->ar;
>> +	u8 he_rate, nss;
>> +	u32 rate_code;
>> +	int ret, i;
>> +	struct ath12k_sta *ahsta = arsta->ahsta;
>> +	struct ieee80211_sta *sta;
>> +
>> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>> +
>> +	sta = container_of((void *)ahsta, struct ieee80211_sta, drv_priv);
> 
> we have a helper for this so please use it:
> 
> 	sta = ath12k_ahsta_to_sta(ahsta);
> 
Sure..thanks Jeff, will address in next revision

