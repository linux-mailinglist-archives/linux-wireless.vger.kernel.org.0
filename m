Return-Path: <linux-wireless+bounces-15029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BDC9BFCB7
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 03:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7112B1F2231E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 02:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2723D36D;
	Thu,  7 Nov 2024 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jUShNrkq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3C621
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947517; cv=none; b=L4wkb1WwqPOOvAaUSEatfkKy+t7tEoqY37ekrW6bDAy7NlA/ugn7DGB53JwJZRxlTEITWtcHhgftlRPqaoYzot3tAvb6rkE4VAO4MtFf+9YAFbU5BgSLKheRMvjOok/k7guFI7kc4qX1vFmiPZ1BKgclRhDHs3YM4EYqe1MNVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947517; c=relaxed/simple;
	bh=/uiRMKHjnt8qrvgNlMOO0Km8uZP6eVnT3K+W0R99YbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EymUYvVK5JNdPopUuFPp+4z37XxiIqDfG1kqi7NstjjUlqxETmcDUOPLTOkFT5QqTMhHKbGIvx+xhb3sbhUaDhntszLl/MLSB4tf7yplQgfk6QUlX5vjEkoZ5zr1jpBzEO+LfmFlkYFyuT/FaDlDa706wBboU6MTI157OUEC6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jUShNrkq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71ikge004555;
	Thu, 7 Nov 2024 02:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0PR2J7v/OxwipS01XjyfQuTVgZ/1b3olAMop2jUT0OA=; b=jUShNrkqjxpROvBX
	+P3/0ZNhOos9e+y8fhqi8wmxPAwdy5mwv366V6snbSoVs7v0jxN8NJ6VtS09pj+4
	thkZAkrayL+h59Af+vnIJA+J5m89j4MamiJ1J33orxMWnUssmkboM91lKbABa/Bc
	Sn7Hj9nTCeMRpulJyb3khT278SCzvqbzaVcVLS2Cj/XIM83CJPnuiGXycHYxBYTD
	rH/k3fpYEz/vd/1btYpFHUWIDehIFjKPLpOHVTOgCgYqp0Slg/djVwyDBUK0+LBA
	fej+Xd6U9TgYks8vflQfK1H7jHsvs4QTBcNANZF2uyAJPDh5qOTGFwjmfiAplULa
	ySgmdg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qvg3us4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 02:45:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A72jAav010295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 02:45:10 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 18:45:08 -0800
Message-ID: <2e706d58-5d83-4867-9963-c62441cdd4da@quicinc.com>
Date: Thu, 7 Nov 2024 10:45:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
 <20241106142617.660901-2-kvalo@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20241106142617.660901-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lf_sc1RU-SYbUnrWMsGXS1y5UkbwtCzg
X-Proofpoint-GUID: lf_sc1RU-SYbUnrWMsGXS1y5UkbwtCzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=896
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070019



On 11/6/2024 10:26 PM, Kalle Valo wrote:
> +static void ath12k_mac_unassign_link_sta(struct ath12k_hw *ah,
> +					 struct ath12k_sta *ahsta,
> +					 u8 link_id)
> +{
> +	lockdep_assert_wiphy(ah->hw->wiphy);
> +
> +	ahsta->links_map &= ~BIT(link_id);
> +	rcu_assign_pointer(ahsta->link[link_id], NULL);
> +
> +	synchronize_rcu();
this looks strange: generally we call synchronize_rcu() to wait for any RCU readers to finish, such that we can then safely free something. but here we do nothing ...

> +}
> +
> +static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
> +					      struct ath12k_sta *ahsta,
> +					      u8 link_id)
> +{
> +	struct ath12k_link_sta *arsta;
> +
> +	lockdep_assert_wiphy(ah->hw->wiphy);
> +
> +	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
> +		return;
> +
> +	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
> +
> +	if (WARN_ON(!arsta))
> +		return;
> +
> +	ath12k_mac_unassign_link_sta(ah, ahsta, link_id);
> +
> +	arsta->link_id = ATH12K_INVALID_LINK_ID;
> +	arsta->ahsta = NULL;
> +	arsta->arvif = NULL;
if arsta is not deflink and would be freed, can we avoid these cleanup?

> +
> +	if (arsta != &ahsta->deflink)
> +		kfree(arsta);
I know the actual free happens here, but why split them?

these two hunks give me the impression that we may (in the future?) have cases to call ath12k_mac_unassign_link_sta() alone somewhere else rather than directly calling ath12k_mac_free_unassign_link_sta(). am I feeling right? what are those cases?

> +}
> +


