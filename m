Return-Path: <linux-wireless+bounces-6735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD538AF6DD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50343B26402
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 18:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249713D503;
	Tue, 23 Apr 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T6Q3eF7W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4371CD39
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898018; cv=none; b=pPoRYQktVanT1Xx/5C0unIc3DNogoiCYha3fHrixSDMMT8DUU91bn1yt6AbfksW5eP+HPaIZXWDTvKueqF5Wn4K6g08G2uF2R7kE8Dfvj1xLNAsRjE5Y+UcOMgTZtdbZnNH5J7a9JNnYvfjO0OW5WbNHqqog6CDEOiW6POraEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898018; c=relaxed/simple;
	bh=y3HwEkhg1D1PdhKFPXXkpxqHK8o0rh7Vu+uFDNSicME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b7cvUHMTtSoeDRfbwc355p5NFQ888IVj0mGlN95RoghLi7+Vx0ggI5j9jjc7p/mnxyUknilLaTLl3MJIaO6v9I0UKPktv2KzUIkZR9NL/KNJUkqVHvy0bOencfd8KjEKS4qI2VBCo8GntKB9t960HWMmGEMt+yNIUHM5QA9RUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T6Q3eF7W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NGoUDA023698;
	Tue, 23 Apr 2024 18:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QDIJon++Dpjv8yD//gwa3U6PRLFus5Jvy2q5AMmf0eg=; b=T6
	Q3eF7Wc/A4DXeE8j9WhCj7iEs9C0C/WRrr5Lkwo+LdTEC391eqOx6AlsdnfgIDb3
	PxBV/l4mdAQrpW5A/cJbFaXdDwV5hyMFrf00jp+9RXVn0roM/mBVzp2BGcz13OHK
	Bmj7MZuzDtw7N4AKQop6BHswcFGPsKm6ak+tGZKCWY6XRtbK8HkD4eopeFlMD13t
	Ki/3cGO9C/MACXgrFX6/fl/EV3d3/BiglQZaA7KsOPyMwc5eFrofSMWsnTzGGvbV
	dH/tuZh55vFPLWydqwi+k4qkEPBsD1QqRqlB6K6XOmI1PEkeswvgVaf5HLhHC34h
	eUrU6AqbmIMFOkFeTgzA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp91fhv0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:46:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NIkpMT029171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:46:51 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 11:46:51 -0700
Message-ID: <ca17a2f0-eb18-487a-8c5d-811748f2ca00@quicinc.com>
Date: Tue, 23 Apr 2024 11:46:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] wifi: mac80211: add support to call color_change
 and OBSS collision on a link
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240422053412.2024075-1-quic_adisi@quicinc.com>
 <20240422053412.2024075-7-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240422053412.2024075-7-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3Y9dzn1kPgWSCFLtDkcHvaUiA4brJUTn
X-Proofpoint-ORIG-GUID: 3Y9dzn1kPgWSCFLtDkcHvaUiA4brJUTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_15,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=847
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230043

On 4/21/2024 10:34 PM, Aditya Kumar Singh wrote:
> Currently ieee80211_color_change_finish() function finalizes color change
> by scheduling a finalizing worker using the deflink. Similarly, function
> ieee80211_obss_color_collision_notify() notifies the mac80211 about color
> collision on deflink. With MLO, there is a need to do it on a given link
> basis.
> 
> Pass link ID of the link on which color change needs to be finalized or
> OBSS color collision is detected.
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> ---
[...]
>  void
>  ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
> -				      u64 color_bitmap)
> +				      u64 color_bitmap, u8 link_id)
>  {
>  	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
> -	struct ieee80211_link_data *link = &sdata->deflink;
> +	struct ieee80211_link_data *link;
>  
> -	if (sdata->vif.bss_conf.color_change_active || sdata->vif.bss_conf.csa_active)
> +	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
>  		return;
>  
> -	if (delayed_work_pending(&link->color_collision_detect_work))
> +	rcu_read_lock();

Johannes, how do you feel about the new cleanup.h functionality? I ask because
if we change this to just be:

	guard(rcu)();

then we can remove all of the explicit rcu_read_unlock() calls --
rcu_read_unlock() will be called automatically when the function goes out of
scope.

> +
> +	link = rcu_dereference(sdata->link[link_id]);
> +	if (WARN_ON(!link)) {
> +		rcu_read_unlock();
>  		return;
> +	}
> +
> +	if (link->conf->color_change_active || link->conf->csa_active) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	if (delayed_work_pending(&link->color_collision_detect_work)) {
> +		rcu_read_unlock();
> +		return;
> +	}
>  
>  	link->color_bitmap = color_bitmap;
>  	/* queue the color collision detection event every 500 ms in order to
> @@ -4853,6 +4882,8 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
>  	ieee80211_queue_delayed_work(&sdata->local->hw,
>  				     &link->color_collision_detect_work,
>  				     msecs_to_jiffies(500));
> +
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL_GPL(ieee80211_obss_color_collision_notify);


