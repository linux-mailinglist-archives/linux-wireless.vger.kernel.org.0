Return-Path: <linux-wireless+bounces-12557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A0696E2C1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 21:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A72B1C2157B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 19:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6618A6B0;
	Thu,  5 Sep 2024 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lnVzNyls"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C65817C9B5
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563393; cv=none; b=KS2iWsFCUZCYkEOhG5X7fda9vFiHTAGh3RSVBTD0PF7RIxfC6uICtChRucflsdThgahbWGpJ+yIz/8HhLFkWPROJ4RRAzA+1VhqxaViZaWt2pPwMSDhvXrOHrl4LmUsgYEOk2cryBTav3twdBrfcxhVc95VwEUYLG61lflu7umg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563393; c=relaxed/simple;
	bh=jd8DRoxkyZZ+DQaSj5DmCr+h8lhKdL8oDznB6ecExrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LRIv3/RYVDz3YpFkOCGWgJYjgJSijNVba3aTJOMtdiQvNJn0TI4txfWDKjMOOiul2pZl0eZzQ+2KUxMDgoOhmCl24HwjjVh7VlkwjyIZpw36qOuL72Ha86i6GV6rUoMYWvAjTy76O/jXjqWIQN7oAxvqPnC4f6Pi+j3UWZCYU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lnVzNyls; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQGHo001232;
	Thu, 5 Sep 2024 19:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A2CNT/QmIpCkJQq/GecEyJBDYeCGIgBSihLWMhsKSZI=; b=lnVzNylsC1yPtZJk
	Cw7FGXiIdpT90SBowwcSSI5Wxhg+nUWNlSc40dVs1puxhaQpJ3+DYgR7JyfLyzAv
	Kt3kTvFl6RPQ7T12eq9kL1wajxTWR4O2bxKK6rug0BUtY4BIpUdes+fbN8wUD61T
	Rnz+Jbb51+HuVlIqx2R7PcU//XFSxxxJ1C7ICDx42fsZSaa+qhpQfvwIjqU1ULXO
	1MsgOtiwVKEw1W9T6MkEJNoAQTiQbiQXbveetnqOiQ8RBsm2aHv4lvXBbpwsJBFW
	XQkuxQGEfXtssg5mv+m0/5UrUeJgyXequzLJsB5eIQVygHCFSS6gBSViqNxeWMFO
	QtTbZw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwt82ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 19:09:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 485J9iaI016548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 19:09:44 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 12:09:43 -0700
Message-ID: <ce020663-4314-488e-a73f-55a09369d730@quicinc.com>
Date: Thu, 5 Sep 2024 12:09:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix the stack frame size warning in
 ath11k_vif_wow_set_wakeups
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240829075253.657667-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240829075253.657667-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: httPf6ynvTt1pwOdmR6T6lxQrB-vOmPG
X-Proofpoint-ORIG-GUID: httPf6ynvTt1pwOdmR6T6lxQrB-vOmPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_13,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=844
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409050142

On 8/29/2024 12:52 AM, Miaoqing Pan wrote:
> Fix the following W=1 kernel build warning:
> 
> drivers/net/wireless/ath/ath11k/wow.c: In function ‘ath11k_vif_wow_set_wakeups’:
> drivers/net/wireless/ath/ath11k/wow.c:461:1: warning: the frame size of 1352 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Remove the nonessential variable 'struct cfg80211_pkt_pattern
> old_pattern' by relocating bitmask to bytemask conversion into
> ath11k_wow_convert_8023_to_80211().
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


