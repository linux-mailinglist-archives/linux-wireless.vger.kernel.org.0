Return-Path: <linux-wireless+bounces-9147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150390C947
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EBE1C2310A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5B13D8B8;
	Tue, 18 Jun 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YVVXpPgi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3F13D61E
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706211; cv=none; b=pxpULb/PxpP+CdPkGOHJ9IGOWYK/ACtRWCcsYN2W6q/0qea+8d7FUMFEFafqE6OX8QisYL/P+NfR8SZSc8WOgw/uBrwVqBncHygr1chGZOFseVm+CuXetIH2EG3t1OY28WyTzhgDaSvl8/f/abZp7B6xHJQnOruWH2jC4u4WgFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706211; c=relaxed/simple;
	bh=O9jMP2M4AFFgsXFiQHp0MBBdzawZplHjenoXJOwOGxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cEy9/BZSSZrSvDOTy15F2K8kn0zAN/Qk3vjcfDSjK8ChveTCMLputSInbhVChGHtc2sDFvKxsjEdNYqhb7Wwg5Ywrf9sJ+7uhUd2F0louObho/PKOGNfvM3wrnVAqcjTIjIN5Ed645Av8PK0wE0bTnJDjOXv9fRUQUlMuG/NMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YVVXpPgi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7Rh9C027454;
	Tue, 18 Jun 2024 10:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wfkYRWLpwrmj1akdvRqXCoaaWZ8G2kQWq2bWxnuP6rc=; b=YVVXpPgiFHc3N2M0
	ajzLBqucMYoYZsKnVekYmHLcteieIPLi8stlsu+NwlLY4CSjOeoIQCS1XAACgf/t
	GwLaQ5tR7w0H3BD+x+ORpG+IyVegkEpTr7NeJXEqi/6ix57/8oYo0PlkXcGkmI9w
	INYeELcYQrKuiBSBHugBQh+4xWnOY493MtH+Ybfg7EJQCFl7ZkDU92vfEMpuyao0
	gWPzcANbAqpViwH9mI2u/htUaFHVItuWJbKHVF9maWuv/f1iPlFizo+t9Anf/nV+
	mwv4ARySnBfV5JC8f5fpVtD/KIdqs7VAkaKM14XEHMUMmoD/hqXY47ESgbBkVqfy
	KHOqZA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3qf68fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 10:23:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IANPZq021198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 10:23:25 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 03:23:23 -0700
Message-ID: <b27c93c1-4f16-4989-b06c-9c00e9086372@quicinc.com>
Date: Tue, 18 Jun 2024 18:23:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath12k: prepare sta data structure for MLO
 handling
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20240617131650.3288118-1-quic_ramess@quicinc.com>
 <20240617131650.3288118-4-quic_ramess@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240617131650.3288118-4-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pG3Ye47YmsvkUbzx5129U4oJ6yI33Ov3
X-Proofpoint-ORIG-GUID: pG3Ye47YmsvkUbzx5129U4oJ6yI33Ov3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxlogscore=776 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180076



On 6/17/2024 9:16 PM, Rameshkumar Sundaram wrote:
> @@ -4748,6 +4804,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
>  	}
>  
>  	rcu_read_lock();
> +	arsta = &ahsta->deflink;
same as in patch [1/3], do we really need rcu to protect ath12k_sta::deflink?

>  	arvif = &ahvif->deflink;
>  	spin_lock_bh(&ar->ab->base_lock);

