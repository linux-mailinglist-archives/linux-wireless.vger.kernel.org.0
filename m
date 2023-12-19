Return-Path: <linux-wireless+bounces-1047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86908193BC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 23:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6474A2874AE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE27C3D0AE;
	Tue, 19 Dec 2023 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iX27QeEy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9E3D0A4
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJLVVog017316;
	Tue, 19 Dec 2023 22:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RPDHjtJ2sl0RFcPYoG1uSS3dsn5gF81j2kc4fdkn1Ns=; b=iX
	27QeEy5xgDPPewsTQwwgHYvROv5Wh2bNLm18dHSu/pbnUtmXYuaTj0m/H3dxcdk+
	IDrQpDTBJ+fQq6CmZ08a+W+rdI8w2ol1GBkDEAEHOEHTlPpltbK36XX20gP+Y9ys
	VFST9lj2KIjohwZTGo+/ZozbKPReuzcc5Zmo+tHnou40DeshdFVF3KOxF9oYHya5
	ThdxwpHquj+nfIXbgAA+P+8mvrOgdP9BDBPIMGMKjpwGYE7uAohXCXl3voHYf6Ya
	uPaabbTVij2H0Hu9XHjRQJzfyGQEiE1hLrlP7VurPy97aD9M48phCDAyF2s49hMq
	OQhZqm63+D90CVowbRaQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v35x7jbe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 22:41:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJMfYEs023921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 22:41:34 GMT
Received: from [10.110.4.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 14:41:34 -0800
Message-ID: <69e18f8e-0157-43db-bd11-78ee945d9912@quicinc.com>
Date: Tue, 19 Dec 2023 14:41:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] wifi: mac80211: rework RX timestamp flags
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Benjamin Berg
	<benjamin.berg@intel.com>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
 <20231220133549.d0e664832d14.I20c8900106f9bf81316bed778b1e3ce145785274@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231220133549.d0e664832d14.I20c8900106f9bf81316bed778b1e3ce145785274@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CeURJX85zRPrkxIVyGx1FOLb0HqF28tM
X-Proofpoint-ORIG-GUID: CeURJX85zRPrkxIVyGx1FOLb0HqF28tM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=598
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190168

On 12/20/2023 3:41 AM, Miri Korenblit wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> We only have a single flag free, and before using that for
> another mactime flag, instead refactor the mactime flags
> to use a 2-bit field.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
> Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
> v2: Fix wrong email addresses and fix ath code
> ---
>  drivers/net/wireless/ath/ath10k/htt_rx.c |  2 +-
>  include/net/mac80211.h                   | 13 +++++++++----
>  net/mac80211/ieee80211_i.h               |  5 +----
>  net/mac80211/util.c                      | 16 ++++++++++------
>  4 files changed, 21 insertions(+), 15 deletions(-)
..snip..
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 29312f6638a1..938f4d255668 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1775,10 +1775,7 @@ static inline bool txq_has_queue(struct ieee80211_txq *txq)
>  static inline bool
>  ieee80211_have_rx_timestamp(struct ieee80211_rx_status *status)
>  {
> -	WARN_ON_ONCE(status->flag & RX_FLAG_MACTIME_START &&
> -		     status->flag & RX_FLAG_MACTIME_END);
> -	return !!(status->flag & (RX_FLAG_MACTIME_START | RX_FLAG_MACTIME_END |
> -				  RX_FLAG_MACTIME_PLCP_START));
> +	return status->flag & RX_FLAG_MACTIME;

curious why you dropped the !!
now the code can return a value that doesn't map to the true/false bool
enums


