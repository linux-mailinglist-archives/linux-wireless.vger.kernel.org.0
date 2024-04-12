Return-Path: <linux-wireless+bounces-6238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBAA8A2B98
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE29A281E40
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7D524A6;
	Fri, 12 Apr 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oa8eDzOO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5251C54
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915468; cv=none; b=RLmI3s4g13066HdeaAYsHKszHZTMBrKe6e8RWkbE9/pEx7tN7XRTZjk29TvmydS7V8+ieuWTz7K71XljfMXkc1WzNcvEgMRBEVzbqOG7C31lFePMN0FUeK6bwzatSPqZ/u58DKvhdiOpuPkUjrFeeFA4ASfn81YpE4wEqfVK5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915468; c=relaxed/simple;
	bh=xS57L6jsqz/0EE7acOaCNTdlIbAArkDW4Y6TOb3yqLo=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=HLwHusfxJQiR6Iu+t8p/OqGSTgEGMsQ0hXS4V4R+k+CP+6lKrbEFNsJtOwmAgIR3k9S8oZ4MBvM4luexNpwvkV+Xb001V6dot7r/DciKX5RWNyHQftoW7M9Ar1yvI7P1g6M6/xEt4YNEF6VvfLM+kCppIp/hOdigDEpnQcerw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oa8eDzOO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C2KpJB019282;
	Fri, 12 Apr 2024 09:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=V71pmPwEjr6t7FcZi1qFO6GR9lqAj23LxFrUiCaykUQ=; b=oa
	8eDzOO9gT4Lrcy9QRPJEAWj7RWw39MP4PaAABhmvMhBu8gvuZa6n7Iwrm+FRXT2R
	6lXbsfg3WY3x8HGOYnjy2eJTsU3/23JNO9K/237WoHtXm5L1Q44kqZLs0m4Lrwbz
	p62rhhlLcn8MWwGMIrhknyTzVJdoi0Oq8NG7G12yA0ZSdOzaH4Dy6xunFlRpkUzK
	mqvWIMtNwOswEGgJXLNa6VcUYq6pwnM/iAf3BXJSlZ9U1suQWaq6veBfZcwLQTqQ
	6By+QwJ8g5D4RnP1ilbL6mfwSDiokV4FVRuiLk12O9c/ApT4viL7SBUV8oa86Fm9
	bqzkCGrIunWDTwD8F7AA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeskt13ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 09:51:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C9ox0v020949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 09:50:59 GMT
Received: from [10.253.34.41] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 02:50:58 -0700
Message-ID: <0b31dda9-f38a-4ac6-8583-96a16ac9cfcd@quicinc.com>
Date: Fri, 12 Apr 2024 17:50:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: <quic_kangyang@quicinc.com>
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: add support to handle beacon miss for
 WCN7850
References: <20240412025149.1211-1-quic_kangyang@quicinc.com>
 <D0HYXSPMY8JE.17YSACO3ROKKZ@gmail.com>
 <6ee5664b-997b-45eb-89f9-5f75708c268a@quicinc.com>
 <D0I19V0104BZ.IN8THB2XCFLV@gmail.com>
In-Reply-To: <D0I19V0104BZ.IN8THB2XCFLV@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: az3vQh4siK450cgzB7-_BwtgKFq-k0nX
X-Proofpoint-ORIG-GUID: az3vQh4siK450cgzB7-_BwtgKFq-k0nX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=892 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404120070



On 4/12/24 5:23 PM, "Nicolas Escande" <nico.escande@gmail.com> wrote:
> On Fri Apr 12, 2024 at 10:47 AM CEST, Kang Yang wrote:
> >
> >
> > On 4/12/2024 3:33 PM, Nicolas Escande wrote:
> >> On Fri Apr 12, 2024 at 4:51 AM CEST, kangyang wrote:
> >> [...]
> >>> @@ -5986,6 +6055,20 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
> >>>    	lockdep_assert_held(&ar->conf_mutex);
> >>>    
> >>>    	arvif->ar = ar;
> >>> +	arvif->vif = vif;
> >>> +
> >>> +	INIT_LIST_HEAD(&arvif->list);
> >>> +	INIT_DELAYED_WORK(&arvif->connection_loss_work,
> >>> +			  ath12k_mac_vif_sta_connection_loss_work);
> >>> +
> >> Is there a need to move the following part ?
> >> Isn't just adding the delay work enough ?
> >
> >
> > Just checked, you are right, but should add delay work in add_interface().
> >
> > Will change in v3.
> >
> >
> >>> +	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
> >>> +		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
> >>> +		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
> >>> +		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
> >>> +		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
> >>> +		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
> >>> +	}
> >>> +
> >>>    	vdev_id = __ffs64(ab->free_vdev_map);
> >>>    	arvif->vdev_id = vdev_id;
> >>>    	arvif->vdev_subtype = WMI_VDEV_SUBTYPE_NONE;
> >>> @@ -6316,16 +6399,6 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
> >>>    
> >>>    	arvif->vif = vif;
> >>>    
> >>> -	INIT_LIST_HEAD(&arvif->list);
> >>> -
> >>> -	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
> >>> -		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
> >>> -		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
> >>> -		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
> >>> -		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
> >>> -		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
> >>> -	}
> >>> -
> >>>    	/* Allocate Default Queue now and reassign during actual vdev create */
> >>>    	vif->cab_queue = ATH12K_HW_DEFAULT_QUEUE;
> >>>    	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
> >> [...]
> >>
> >> Thanks
> 
> Yeah, I wasn't clear enough, I meant adding the INIT_DELAY_WORK without moving
> the rest of the code around.
> 

I know what you mean --- Just add INIT_DELAY_WORK in ath12k_mac_vdev_create(). 

But i just checked with the person who just refactor the related code in patchset 'wifi: ath12k: Add single wiphy support'.
He also think add in ath12k_mac_op_add_interface() is better.



> Thanks
> 

