Return-Path: <linux-wireless+bounces-15004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811C29BF348
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 17:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09863B246A4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5856D202F6A;
	Wed,  6 Nov 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B/BtWv9t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB91DE3DC
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910817; cv=none; b=Bl9RW94ZQLqhd1RgZmxYv5/Ji4V+u6HYHJr0jBAUR++6/9xhvIuyr3UwZiy96df6veTgm9cSmeBJ+fBl1Ls5hg+A5E4Hh+igEF3ZFr7zJW6YuL0cobocQFj/y6Cc5AROQ/Deo9Vwd3m19Xs6/tD6ttT4xlOOqXKujk6d9lT9PEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910817; c=relaxed/simple;
	bh=AxyKYaqMd5P7/eyF8R/zBY7RRT0dmlZPYVWQi7cKLew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ars9eCgXqYujK9bdlhaK4Zg5jw9fRfPtjUF7ibSPRRAc7BkoFsUdS+zpPyRKUekzd6pfJUkuwmDne/KawrOdmsV6rDw3YajHp2+yP5BA06ZLA2bI0KlSHmKlAHPvMr37Qb6YJmCDmsjgYejCx1Hbf09Kv3WPMClgAjVn66cpxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B/BtWv9t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6GDdv9010715;
	Wed, 6 Nov 2024 16:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yMOePaAHl4oSF5HDSSYsZ7ALL7+g/tu5mqHBdwudZco=; b=B/BtWv9tJUpCL6iZ
	UCPJaqZdPPM2yCZbWK4gRATOHPndufgASy5ZvaDr8vzk3hpA689r29i2MY6/90Gg
	KxPWzMtgIkSSrXOJRAGavte/oH0PzmIWvxShbEreRMng7KlHdqE2ZWRoUwQnhx3h
	eDN7DGhD0wwMZM1R/VNiNfQ5PMqeaXl5MqvArx0VC6XOOXZmVxn2Rpf0LhIbaVvI
	4JdY0sKeroXr7cI3/AUzIDnR1pK6jUs3JDSn4THm08QscLV5STf6f8lD/e5idzRK
	AYFmg+cvMYMYxMIqlD26ADSR6BcelSQqbggnhqvqtWQzzS+wtrQT0yu3RACCKZ7C
	nIDYMQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qn73bnd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 16:33:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6GXUIg007942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 16:33:30 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 08:33:29 -0800
Message-ID: <37265dcc-643a-4879-8d08-bf6bf30e8042@quicinc.com>
Date: Wed, 6 Nov 2024 08:33:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] wifi: ath12k: use arsta instead of sta
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
 <20241106142617.660901-5-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241106142617.660901-5-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l9va_C101pryWwUWXGYNb_K_EFo4Wttv
X-Proofpoint-GUID: l9va_C101pryWwUWXGYNb_K_EFo4Wttv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=901 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060129

On 11/6/2024 6:26 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Currently, struct ieee80211_sta (sta) is used for many WMI and mac80211 ops but
> for multi link station, driver should use struct ath12k_link_sta (arsta)
> instead of sta. Add changes to use arsta object for WMI commands and other
> mac80211 ops.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



