Return-Path: <linux-wireless+bounces-19115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737F9A3B063
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 05:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CF47A5B21
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 04:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235F918BB8E;
	Wed, 19 Feb 2025 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L3k+VLRw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441931D554
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739939737; cv=none; b=XrGvB1oFqQ1ufgFvhANZzwNbu+9PGv3l6PAqh76izYFKNo319vfz00NT5QVSj4GXGzo07ChVMCieaYhDAvc/ZitZQD8rW8JvVTrt3XJ6Orv1WK+63orbuyWe7gKMsjww6PnyX59epUENmhHKdnX17AyjpON93gCtxTQzqu9vMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739939737; c=relaxed/simple;
	bh=/qUGeuWEclObwvuYjxX8fHwdsa3RztdEZoXKhT0/mho=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ahBslpxgGm0ICI3XjUsx4ySNVC/sRrI2IuQb2N0l4LvUw5Pg5ENmoSoCY5cv08e7ZXYeiEN2ASVIJnnla8JhOC9ECJ83tj+3kAJaMiHCWM/SutoUE9dPFUXsf/lNAAgjfKfbY5IV/kpKtdXGJs+88zkObd7LqXUvbzmGjrb19GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L3k+VLRw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIwKUA001823;
	Wed, 19 Feb 2025 04:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2+axHVtw8+p5ZiJOCuUgfISioBAVecAvHKnQHKMNiOs=; b=L3k+VLRwO/zSyRjp
	6U6Hng2xoifRnmTO5oq+itLHgzW25fB0nYqou7QQbnSdZT1fIcFj1dl37YKwPWmZ
	528qbn4ja13wpdbFygw+zcoHYDnQ4XhAt780aWLowLiNfSH+lJaGvIRsmdif4HMb
	yetbMdBjTdG06ZMrgZcOtT0QYjxZzcO/FrcNM4RT4YBYjGJ0oTpEeObqXFeFHEi6
	rGPNZB4fzxbqk1JzAjgb5uZjtyuglr7pfWHGy1hUMbvzjoSzNL2H0zhew09070BL
	etJKJBPixzBdO8MT9yRB1+FCA2Lv2bwYuaxnulbNnkJLrRuCyiSLZwZ1V5sci3iH
	RNMIfQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy296sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 04:35:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51J4ZU7P023322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 04:35:30 GMT
Received: from [10.216.26.155] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Feb
 2025 20:35:28 -0800
Message-ID: <c7a422b9-55b9-3f03-a89b-6b5e82d8e3c5@quicinc.com>
Date: Wed, 19 Feb 2025 10:05:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 3/4] wifi: ath12k: use correct WMI command to set
 country code for WCN7850
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250212063200.1631-1-quic_kangyang@quicinc.com>
 <20250212063200.1631-4-quic_kangyang@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250212063200.1631-4-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: okI0jSAQeMIB4k0eIG-kPL6FPfZ9fiZZ
X-Proofpoint-GUID: okI0jSAQeMIB4k0eIG-kPL6FPfZ9fiZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_01,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=829
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190032



On 2/12/2025 12:01 PM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> When userspace try to set country code by NL80211_REGDOM_SET_BY_USER
> hint(like iw reg set XX), it will pass new country code to ath12k.
> Then ath12k will set this new country code to firmware by
> WMI_SET_INIT_COUNTRY_CMDID. But for WCN7850, this WMI command won't
> take effect.
> 
> For AP based chips(QCN92xx), WMI_SET_INIT_COUNTRY_CMDID is the correct
> command. However, for STATION based chips(WCN7850), it need to use
> WMI_SET_CURRENT_COUNTRY_CMDID.
> 
> Add flag current_cc_support in hardware parameters. It is used to
> distinguish AP/STA platform. After that, the firmware will work
> normal and the regulatory feature works well for WCN7850.
> 

Should this patch be the next in the series right after the patch
(patch 1/4) that adds WMI command implementation for
WMI_SET_CURRENT_COUNTRY_CMDID?

Vasanth

