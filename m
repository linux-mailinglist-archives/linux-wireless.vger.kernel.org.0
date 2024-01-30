Return-Path: <linux-wireless+bounces-2745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB33841853
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40D1B22C25
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 01:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CEF36B1B;
	Tue, 30 Jan 2024 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nK3KfdBG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83AC36AF1
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578275; cv=none; b=BYOdFO705udpeB7nHh3XLO82hKeI6DcMIo7pffyrquFvZKYwGfAtPByKkB1q7ANh3kTGbGsyUTn5tedgnqlYwzIEkvgDAQW4JwF94NpUpSjf5/iNTGQVtjbFU2JsEyBDmXhW0pzrthxqDisf+V927yMPYqyBhilmzNYx9sKjRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578275; c=relaxed/simple;
	bh=Rht+C4VjzmqUV8Y787OWacrLg9mh4XUEtSOIrAcn8dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U+DRHCHca7v+ofoAKds7jnxEmjDbym5/d5LiWc1osf3I1X+VNYaAqRClWJKI/9HoMIH+GI1ksfeGhivZPis/EzAkaqCOF5b59QXCcG7LlWpmX73pOUzc5InraefmHr+bnkj/hWT99Y7RZiRbhGYUdydmy6CFrqNohDW7ggt2y9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nK3KfdBG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U0eUhH018679;
	Tue, 30 Jan 2024 01:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GDlw/gkGl3R5OVi7kN5/GUczuDr35Cf9ZLqtxFqQJ3g=; b=nK
	3KfdBGuBinWSuB77hrSIuSaNmNJeXN01Qf7hy1jv8EVaFvQEKf6XyeUpP8X4hh64
	vp9W1OenDA8m+4xdhBBEWzYE3Mki6CeGdwt7LPkD6hB7DU0JmQzQPgv/KUS4XRJ/
	j8h7yTW8+Vnnb4yRn3nwFO/QkjH6e5Sr30FsbCU7JYrJjlQ/Xz/m1HpoMWU69cqe
	Evf9ukPNi5DQ6FFmV5pWKXKdd3p5WdtuegUI1I9IeSiJYHeSH6gDxuBHDALKeZJ5
	sySRSD0Zp4x25pWUbDfx0ExHEXPnpgWu2VruwRWFO3uqjtwstnq8IGjno+TIgTIf
	5E7g0h2E9+G+QTJQ2u+g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxhjrrp9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:31:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U1V8ww007861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:31:08 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:31:08 -0800
Message-ID: <a20310f8-bf6a-4823-8302-e45944f06f74@quicinc.com>
Date: Mon, 29 Jan 2024 17:31:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] wifi: mac80211: add support to call csa_finish on
 a link
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
 <20240129052832.905113-6-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129052832.905113-6-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sitfopseLr2n5HCM8fyjI3QnS4tsbqxV
X-Proofpoint-ORIG-GUID: sitfopseLr2n5HCM8fyjI3QnS4tsbqxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=885 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300008

On 1/28/2024 9:28 PM, Aditya Kumar Singh wrote:
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 4427259154e2..a1a4f100d128 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -3543,13 +3543,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
>  	return new_beacon;
>  }
>  
> -void ieee80211_csa_finish(struct ieee80211_vif *vif)
> +void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
>  {
>  	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>  	struct ieee80211_local *local = sdata->local;
> +	struct ieee80211_link_data *link_data;
> +
> +	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))

>= ??

> +		return;
>  
>  	rcu_read_lock();
>  
> +	link_data = rcu_dereference(sdata->link[link_id]);
> +	if (WARN_ON(!link_data)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	/* TODO: MBSSID with MLO changes */
>  	if (vif->mbssid_tx_vif == vif) {
>  		/* Trigger ieee80211_csa_finish() on the non-transmitting
>  		 * interfaces when channel switch is received on


