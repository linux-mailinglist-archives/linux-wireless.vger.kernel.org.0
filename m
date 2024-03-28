Return-Path: <linux-wireless+bounces-5496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC4890C29
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 22:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129CC1C21988
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 21:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC9132805;
	Thu, 28 Mar 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TQj9pvw0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7017EF
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659770; cv=none; b=upw91mc4+QNB4yrh4c9d1rh8IQkbzX0hf1f02TXgOtUxLokUCwDZsQsjrJjFY4cHSQV/L4aYFOfyLiiYInDLVR71jXTqZBZTiSxmJ1U7dAZNsilrjmyMAaUt6xwYAHUMVz6ZRoFm9Il3Nc5UFDUmIb12h+ytPHeg+W1RCFRpyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659770; c=relaxed/simple;
	bh=etIe+lpRliCkSgjwWgp8+IWyjb2zd7b2vW5P3wuzjt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hknPitPLdXG6pKdkvkZrV8Ny9vEVbNVP26JX1OFALAh1Oxe9WOQ4wadjRw29bwxwgWnodDUraurXcJo3kLohLUM3sYkzKqX1BncHUpHQTEq0KsI+K4not9bjk3TKgFq6IePIZaGPRj3XVNPnsh+n9YONaMulF3haKB1kT2zPC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TQj9pvw0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SKfpOJ018047;
	Thu, 28 Mar 2024 21:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QuzCKRChsucWKyt9CBkTwrRwuAEit5UjoOtbyYfsFb0=; b=TQ
	j9pvw0xMIWmrS8tGmUX8tj4ewU090bxvCbcasLXPoHktWVIvSX7lq7kL4o6HPHN1
	m+M8z9NgI6/Ei7Ir5RotImuR54J2EmD2OTaLNp9kJegUd5N97NCVi+ARa1Kju1VU
	NViHz2sYpSBXL3lpE7IN0F2o0/qDjX/EtAi01fsZclcwrooYetTt7Ctuk876WgMZ
	u6vzM3WykgnNJ0yznCeZSFkZFLHlb2rjl8l6LABwhi1ktFdUcR5ctHGdMHCVfUVk
	7q9OEKttjWOoKPHmmEOT9iEgO9NQr/P3HxYp6PVh7G8VyfRB8BZ8wgb1gP2UIDZD
	BHvDnnFr7/Tom47tqjyg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x575m9jay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:02:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SL2cxU026418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:02:38 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 14:02:38 -0700
Message-ID: <ab738886-f7e3-43ab-8615-2164e8414786@quicinc.com>
Date: Thu, 28 Mar 2024 14:02:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] wifi: cfg80211/mac80211: Introduce nl80211 commands to
 support MLD link removal offload
Content-Language: en-US
To: Manish Dharanenthiran <quic_mdharane@quicinc.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
 <20240328055235.3034174-2-quic_mdharane@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240328055235.3034174-2-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: usTrshZOWoKk3sZgKzSGpl7Xn3Vi9Ypg
X-Proofpoint-GUID: usTrshZOWoKk3sZgKzSGpl7Xn3Vi9Ypg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=992 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280150

On 3/27/2024 10:52 PM, Manish Dharanenthiran wrote:
[...]
> +/**
> + * cfg80211_update_link_reconfig_remove_status - Inform userspace about
> + *	the removal status of link which is scheduled for removal
> + * @dev: the device on which the operation is requested
> + * @link_id: Link which is undergoing removal
> + * @tbtt_count: Current tbtt_count to be updated.
> + * @tsf: Beacon's timestamp value
> + * @status: Inform started or completed action to userspace based on the value

kernel-doc warns:

include/net/cfg80211.h:9573: warning: Function parameter or struct member 'action' not described in 'cfg80211_update_link_reconfig_remove_status'
include/net/cfg80211.h:9573: warning: Excess function parameter 'status' description in 'cfg80211_update_link_reconfig_remove_status'


> + *	received,
> + *	i) 0 (IEEE80211_LINK_RECONFIG_START) - Send
> + *		NL80211_CMD_LINK_REMOVAL_STARTED
> + *	ii) 1 (IEEE80211_LINK_RECONFIG_COMPLETE) - Send
> + *		NL80211_CMD_LINK_REMOVAL_COMPLETED
> + *
> + *
> + * This function is used to inform userspace about the ongoing link removal
> + * status. 'IEEE80211_LINK_RECONFIG_START' is issued when the first beacon with
> + * ML reconfigure IE is sent out. This event can be used by userspace to start
> + * the BTM in case of AP mode. And, IEEE80211_LINK_RECONFIG_COMPLETE is issued
> + * when the last beacon is sent with ML reconfigure IE. This is used to
> + * initiate the deletion of that link, also to trigger deauth/disassoc for the
> + * associated peer(s).
> + *
> + * Note: This API is currently used by drivers which supports offloaded
> + * Multi-Link reconfigure link removal. Returns failure if FEATURE FLAG is not
> + * set or success if NL message is sent.
> + */
> +int
> +cfg80211_update_link_reconfig_remove_status(struct net_device *dev,
> +					    unsigned int link_id,
> +					    u8 tbtt_count, u64 tsf,
> +					    enum ieee80211_link_reconfig_remove_state action);
> +
>  #endif /* __NET_CFG80211_H */
[...]

/jeff

