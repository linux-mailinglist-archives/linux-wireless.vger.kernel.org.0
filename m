Return-Path: <linux-wireless+bounces-2743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D384183E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD091F231C2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 01:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CB82E40E;
	Tue, 30 Jan 2024 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HLkxBSya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2133CD0
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577828; cv=none; b=JFWXDQuTjruk7DLjcarTSdCaegEFqgvk/esPHlFNdMbi8Z+L6vh4GwI96wwsGIZD1v4QeCBVTIWL4/iFxttLzx0sxNNJC22ic0yFwcdhJg4OxmgshWI5IidYtq95Ljb/k5hdYexq9UYWdYS2gf8k8ZdsftM3jkBKlyVGeM6CoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577828; c=relaxed/simple;
	bh=69T7upjl8q/syVC1JYxudI/Tt53AAhLwCHn90WYrahQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e6OkG3edtU1jSmi4BLze3aL0hAjSXp3j3nikxKWQNwxVmh6PfB0NYxoD4PjjySy8paUyBk5pmvpKiYrlE7U/P72ee8BHK7hHZxqqO/+8opsUuvaFERJ5dYuh3RYdhs4L+Gto9IfxPCnm0fEwGxDSeo2pXJQvswC/jsqTbS9KLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HLkxBSya; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U0ZgcD011351;
	Tue, 30 Jan 2024 01:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lgq2ImR0x3Tq35ho8qhJVe0jOuvReC4fWQDO7tOuTS0=; b=HL
	kxBSyaxSiJj9jkYFFs5UwC5TX2AZwKxhmbLgvoqWTgumOZ5M8JNrdwgeChDMBZP8
	/MBlHZQb8QlbsFW62r0SIk+t6bG4lk+zi/UTQ4lQ99Ynrv62gMeQOKIuvjWvtFBh
	h0sFh4x9iBuyjUzNZpwKBbckzvSByL0rXoFRccg2VSmsqCi9NYhqrAcZD2FFzP0t
	bdQ3MqSU5lKjJMxXLNdYm1str6y2kwAsfunnlYBw8XGoscuXQCDKhL/ZVNI+WJ1Q
	vJQSCt2gT1UZU93z0GSuYSNVUiMvk/MEdyYGQ762nMmoMbqIWJ1rIE5WmmRVCmye
	7sNc485zzAye5n1HkwRA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxexr93e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:23:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U1NfwG024162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:23:41 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:23:41 -0800
Message-ID: <44350e13-7903-47ee-bae9-11b2072146be@quicinc.com>
Date: Mon, 29 Jan 2024 17:23:40 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] wifi: mac80211: update beacon counters per link
 basis
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
 <20240129052832.905113-3-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129052832.905113-3-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XAJX94ylweFGXp2lKKDOJi9mrdc5T7n0
X-Proofpoint-ORIG-GUID: XAJX94ylweFGXp2lKKDOJi9mrdc5T7n0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=836 bulkscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300007

On 1/28/2024 9:28 PM, Aditya Kumar Singh wrote:
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 68a48abc7287..504db497df06 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -5030,16 +5030,24 @@ static u8 __ieee80211_beacon_update_cntdwn(struct beacon_data *beacon)
>  	return beacon->cntdwn_current_counter;
>  }
>  
> -u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif)
> +u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif, unsigned int link_id)
>  {
>  	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
> +	struct ieee80211_link_data *link;
>  	struct beacon_data *beacon = NULL;
>  	u8 count = 0;
>  
> +	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))

shouldn't this be >= ?

aren't the arrays size [IEEE80211_MLD_MAX_NUM_LINKS] and hence indexes
must be 0..IEEE80211_MLD_MAX_NUM_LINKS-1?

> +		return 0;
> +
>  	rcu_read_lock();
>  
> +	link = rcu_dereference(sdata->link[link_id]);
> +	if (!link)
> +		goto unlock;
> +
>  	if (sdata->vif.type == NL80211_IFTYPE_AP)
> -		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
> +		beacon = rcu_dereference(link->u.ap.beacon);
>  	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
>  		beacon = rcu_dereference(sdata->u.ibss.presp);
>  	else if (ieee80211_vif_is_mesh(&sdata->vif))


