Return-Path: <linux-wireless+bounces-12556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C185296E28E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 21:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC651F2808F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB53317BBF;
	Thu,  5 Sep 2024 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vzc3Yw1i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD048821
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725562800; cv=none; b=fK3yPQAr+IFEkXy+KhMaMUyYB4P8PehFK2zM8552MlEDXYgPafBGVW/PMfTnWpvT3kGIqas8Tp5PHZOJHUl8gQNXu1NccRsgFbXQi3tUE8AbV8O0Y8GMT5g00JD+9eANkvGEtwUDYwd6bNaNj/XqQBG8Gpf0zwE5iFuZRG0ta0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725562800; c=relaxed/simple;
	bh=Gsb/m+8G+8kb9Q7+ZC8KJs8SbKMmK/QXUDN1DzVxzN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ba49xjVuVg9LkJhdDev/Qc4N7H5dRHqaZ6IAJwDlEuDPP3PlPIZ6lTeHiC0OHedtPSLWchK5X08X3VQkaEslbuht0QxJMYn4TSzEZmMZ6TXEzjHLSazKzj+jHeSoPcLVfKM4o27IiEuo7iRYVzudcnNOm6kgmg20GZtZWH5GNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vzc3Yw1i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IVGPV025101;
	Thu, 5 Sep 2024 18:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MreSWIopOkGn6EXsT68UNWvpiaoIjbL8rbO9kYe3e4c=; b=Vzc3Yw1iD53cKG0W
	11VCMvwCji5YI2ecD9F7ck41VVXZJdPe2GlBbT2uxBhYvXTiKrCLa0/o38H1PpIh
	sUDPtC7PfiJnqwivN5uptwJPMgOH2umFfxXgN72vSQAyYQg3sEElNjHCDjG4dvI1
	kfEFHTat8MbPWOyOg5vkjYezYNg7t5Ql9yPwuxL56D44J4+1AdutnBGB/eMG4UiE
	2Dk/vtWlXwmtaRORF0uyGIlg+qWLgUY0tEg4y3Lycs7p67DjBjBZeWHQo1OHm7qc
	sSSMwHoHfO7ooC/JNcp1+rKLvq6+73FCL/sA8JtufoG2nPpGboWp/ZmB5fMi6z2P
	5WWHlQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fj09r1n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 18:59:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 485IxprK005524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 18:59:51 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 11:59:51 -0700
Message-ID: <1e53e441-7539-4db3-89f2-3563667e2cff@quicinc.com>
Date: Thu, 5 Sep 2024 11:59:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: support DBS and DFS compatibility
To: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240829064420.3074140-1-quic_yuzha@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240829064420.3074140-1-quic_yuzha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cRTdCG9qOlVR3JOeJ3QwPRnDkvVojV2r
X-Proofpoint-ORIG-GUID: cRTdCG9qOlVR3JOeJ3QwPRnDkvVojV2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_13,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=530
 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409050141

On 8/28/2024 11:44 PM, Yu Zhang(Yuriy) wrote:
> Now some chips which support 'support_dual_stations' will enable DBS,
> but will disable DFS. Restructure the ath11k_mac_setup_iface_combinations
> function to support DBS and DFS compatibility.
> 
> About 'support_dual_station' feature can refer:
> https://msgid.link/20230714023801.2621802-2-quic_cjhuang@quicinc.com
> 
> Add a ieee80211_iface_combination to support DBS and DFS compatibility,
> one combination can support DFS(same with non dual sta), another
> combination can support DBS. When running different scenarios that will
> use different ieee80211_iface_combination due to mac80211 will go through
> all of possible interface combinations.
> 
> In addition, maximum number of interfaces of these types should be total
> allowed in this group.
> 
> The chips affected are:
> 
>  QCA6390 hw2.0
>  WCN6855 hw2.0
>  WCN6855 hw2.1
> 
> Other chips are not affected.
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1.

nit: should include the hw type tested on, see:
<https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag>

if you can reply with that, Kalle can update the patch in the pending branch

> 
> Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


