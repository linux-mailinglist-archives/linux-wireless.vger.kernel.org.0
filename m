Return-Path: <linux-wireless+bounces-5613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B176892302
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DA22840D3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D00130E2D;
	Fri, 29 Mar 2024 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ai1q2lC+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FD13777B
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734493; cv=none; b=oM33IJhiD4sHVPV8AsCqYVzdpxZLTKPpTjR3qmpTqgXDk1tVB75gCRQbkX2M0San6LKJ7NY6AjwIBPl7iIpjLjROaoLnzq9PkH5Fpq+wqgHT98boRaps3eEOlHMwlLBpeO3/t/3HksFuDYQnsnq7Yt95deOwuLGblx96+1J5aIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734493; c=relaxed/simple;
	bh=fcq2d/UGjvZUMOuWSnymzxf/Ay7HoN+LUH4VL/n3TH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vp3g8wBhjrTdjh3fzLl9QmtM8enFe4kZZEkg7yN5eNZ+e5kmhMihNffpl77yLdWPYQIKjrkWkvvxxNKp+KP21ELqnv99X5Q4NguWEFphwENG7F8pN8IFdpKsBLRR37W58WtrLWGO+DzXLzA2wfq3WX543hXX/BJ5FEKv1tsNCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ai1q2lC+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THepxM013533;
	Fri, 29 Mar 2024 17:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jjirybAYx099J6c+03Z5FYGXIF51WLWQui7hWRJscAg=; b=ai
	1q2lC+RPsw0rc+KqNk9ZvLIuna2Vl8Vf6Vu70z4YjxSsmrcMYi+SJDKmssWotHLR
	VBu3lsIX3XmOEo2oYP54JnpD0Xk5bSI7I+AYSsRsLMpsmYp7YKe34LGihROsCsXe
	dzZg08wY/cOjW630hGTfJUpCHl9a9GBotsI9qPzVa4/SzQks4R6ChmOpbzF7tJoo
	JZeqNUBxhCiL+RdOZeO3wr0WN+z1nb2drkVkzvBl08DriRsHA8xEFeXHJME+4ikL
	Zp2yH7keDBW5eQh224a71Jlg+HjEiuBdCPI6JDlzM5MdhjFH4C55Y+AmoZ5mK9c2
	nKR4Jl6DhQ9HORioN/dw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5vn98u5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:48:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THm8tk022230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:48:08 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 10:48:08 -0700
Message-ID: <feeaf733-e592-4f9e-b91e-0812bfb0bce9@quicinc.com>
Date: Fri, 29 Mar 2024 10:48:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath12k: add 6 GHz params in peer assoc command
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Avula Sri Charan
	<quic_asrichar@quicinc.com>
References: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
 <20240325212304.28241-5-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240325212304.28241-5-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z4zBReJq_r5BSPLGq8RD5QNJHZa3G4QT
X-Proofpoint-GUID: z4zBReJq_r5BSPLGq8RD5QNJHZa3G4QT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290157

On 3/25/2024 2:23 PM, Pradeep Kumar Chitrapu wrote:
> Currently A-MPDU aggregation parameters are not being configured
> during peer association for 6 GHz band. Hence, extract these
> parameters from station's capabilities received in association
> request and send to firmware. Without this, A-MPDU aggregation
> is not happening in 6 GHz band.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Avula Sri Charan <quic_asrichar@quicinc.com>
> Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 56 ++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 6d7df18ec424..7e296140439a 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1910,6 +1910,59 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
>  	}
>  }
>  
> +static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
> +					struct ieee80211_vif *vif,
> +					struct ieee80211_sta *sta,
> +					struct ath12k_wmi_peer_assoc_arg *arg)
> +{
> +	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
> +	struct cfg80211_chan_def def;
> +	enum nl80211_band band;
> +	u8  ampdu_factor;
> +
> +	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
> +		return;
> +
> +	band = def.chan->band;
> +
> +	if (!arg->he_flag || band != NL80211_BAND_6GHZ || !sta->deflink.he_6ghz_capa.capa)
> +		return;
> +
> +	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
> +		arg->bw_40 = true;
> +
> +	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
> +		arg->bw_80 = true;
> +
> +	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
> +		arg->bw_160 = true;
> +
> +	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320)
> +		arg->bw_320 = true;
> +
> +	arg->peer_he_caps_6ghz = le16_to_cpu(sta->deflink.he_6ghz_capa.capa);
> +	arg->peer_mpdu_density =
> +		ath12k_parse_mpdudensity(u32_get_bits(arg->peer_he_caps_6ghz,
> +						      IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START));

ath12k-check complains:
drivers/net/wireless/ath/ath12k/mac.c:1946: line length of 93 exceeds 90 columns

git blame flags:
b2b50e659028d (Pradeep Kumar Chitrapu 2024-03-25 14:23:02 -0700 1946)                IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START));

perhaps use a local variable to hold the u32_get_bits() value?


