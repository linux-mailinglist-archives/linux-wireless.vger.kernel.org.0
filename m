Return-Path: <linux-wireless+bounces-14425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1089ACF1E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF664B27854
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B891BD004;
	Wed, 23 Oct 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GLxbEkD0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F53A1DA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698232; cv=none; b=gIGHtBkmoBYctV6ZXgoQPu6HI5OBHi0GYkYl9M3leE24aQJfYa2yJ5bftB020BKxxpvlwuD3SfTb8P0ZHdZmMebteURJsENBoBspEuTYnHZRsM3GsgWGCIROBADyo+MTm2PpfV4vPoMsxDA1kCqeP2FopBeJ5830oPV7wBIOGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698232; c=relaxed/simple;
	bh=15uzMxtQJ+lmcwRGIL+T3TXmL2jsfT0yvaom5RZXqTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BhwGJB2joJWcdJfMP82Vsbs1e4w3f3fziovT4idpRkGWhWE0k+le+98ehwAsnxZbEoa98Z9+T8chtpzSjbE4h2HjB1ymlFxsHs3/MKCg68ps1TLbBevyMDXkuChZKI/EJ+zcTF6bjwcA1LVkJ7V6dW8++2QMU/wI92GQlXIc+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GLxbEkD0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9ZvLf020289;
	Wed, 23 Oct 2024 15:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2zhejthaWhbXqB426b9N8nIOC4cpp7IMVjThBR+aVJY=; b=GLxbEkD0U77Vz4o4
	vHAw0/ddrPWKUqLz28SKnlGlim4hI/gS3uPl1USKNLqABaZFdukmXURtn5nPL9+H
	C7beFaUTYB4OMXEKuybWw5yNsS6EbonGkepnM82FTNALWk7qGmAfX/fX6xiZOMAQ
	xZ3pXoaQIkJ2Eb2uRC5TFoYbZT6F/11sYM8JHoib29OBHvv2kZQSHg+TcbzOCRcY
	/cETMlMWqNq0DiYGfrQXnLl3dsS4ojNd0Q2FyOR3rhYIGCzJXG4biNZUdwooirGi
	n0Z5uEMPvsDxwxlLXfw3FZ4FwBpwAEzlMbND7GIHkyKS7T53iHTmM+TCEAEl6OlK
	93sREA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em66ar2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:43:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NFhk8K006358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:43:46 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 08:43:45 -0700
Message-ID: <fdcc379d-b5ac-4554-8963-55653337db61@quicinc.com>
Date: Wed, 23 Oct 2024 08:43:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] wifi: ath12k: Add helpers for multi link peer
 creation and deletion
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-6-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241023133004.2253830-6-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vNa4EARM-F-Uq8JBdScOjNyD7nsav3rX
X-Proofpoint-GUID: vNa4EARM-F-Uq8JBdScOjNyD7nsav3rX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=612
 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230097

On 10/23/2024 6:30 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Add helper functions for multi link peer addition and deletion. And add address
> validation to ensure we are not creating link peers (belonging to different
> clients) with same MLD address. To aid in this validation for faster lookup,
> add a new list of ML peers to struct ath12k_hw::ml_peers and use the same for
> parsing for the above address validation use cases.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
...
> +int ath12k_peer_mlo_create(struct ath12k_hw *ah, struct ieee80211_sta *sta)
> +{
> +	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
> +	struct ath12k_ml_peer *ml_peer;
> +
> +	lockdep_assert_wiphy(ah->hw->wiphy);
> +
> +	if (!sta->mlo)
> +		return -EINVAL;
> +
> +	ml_peer = ath12k_ml_peer_find(ah, sta->addr);
> +	if (ml_peer) {
> +		ath12k_hw_warn(ah, "ML peer (%d) exists already, unable to add new entry for %pM",

The Linux coding style says:
Printing numbers in parentheses (%d) adds no value and should be avoided.

> +			       ml_peer->id, sta->addr);
> +		return -EEXIST;
> +	}


