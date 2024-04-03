Return-Path: <linux-wireless+bounces-5847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51E897800
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8891C23496
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF53F152DEE;
	Wed,  3 Apr 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WDqfR3rq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664BA153572
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168249; cv=none; b=QD1m1faqpixZqDUCZuqGcPGmsW2nmRKdQ9CihlrmTPSYGSXbYvJd9uQFP8ubi2AOhn0DUNBc+AaimgXVk0V7J+FyyjEexBb7sX8BQZ+qPka6omaMuizfq0Zy/HpKN+iCmE/7am4FSayRd9gHZr5f2lO85N1TPFSucYN42zOq/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168249; c=relaxed/simple;
	bh=YF+pnGkGvwYarjyPSg6bStjOAr3UCuNnKZbwKd9/utQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ED6tQeGzp3L4/HqNlyhof1qNiCkLeLIeWSEzZF8oGTbzz9R/yjJj6CCdgppl6It2z9MkQ8GT3Qwf1M1V1LOjqSVzmbCD7lSnsvfviWxzB2qbq+5yTGybUpqH9wUGMLXJXrx13Ag8uga63cvsTpDVA9x28P/ez2XF6UD5BU2+d+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WDqfR3rq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433Fd5KS010152;
	Wed, 3 Apr 2024 18:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6JVR9Am/YAc4h52RJU+UpM+ZSLJJJ0x+GMEQGCwWOt8=; b=WD
	qfR3rq/B7Lg2+kAzFFs0/H47Iu55RtwF/vlDLJyiInocuP+dabLnazxmLwDY7DcF
	W1ZS6YjdPLbxZ2K/EzZR1YkDUxsWslvvRZlyllwgzKLb0KfRIg0Wckr5D5K0+F3n
	RI+AKxU6sxYrhpgO9QCpPW+iHYs64PMCjUCqCTCi7slUs6SIlkBDMf8IYXflZaHH
	dL8TtRICBl47m86wecvdYDsDVVqXeUKy6XKrkbATJ56lE5ryF5HfwK9Zi6/pkPb5
	kIsDj1S2CVQNTyH0LQyX0oTpqtdby6TGWZNhSJsM5V4dm7tcZA/ReIvr4Ln3mBL1
	GsGu6rRFA/kWLH04F++A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x99xm8ce3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 18:17:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433IHOG8023440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 18:17:24 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 11:17:24 -0700
Message-ID: <9ef48dfd-60b6-432d-abd3-8e45c4892310@quicinc.com>
Date: Wed, 3 Apr 2024 11:17:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] wifi: ath12k: add EMA beacon support
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
 <20240402210538.7308-9-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240402210538.7308-9-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mCB1j1075g0HKJv_khPKS1MLiKlFjzeG
X-Proofpoint-ORIG-GUID: mCB1j1075g0HKJv_khPKS1MLiKlFjzeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_19,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=775 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030122

On 4/2/2024 2:05 PM, Aloka Dixit wrote:
> Add new function ath12k_mac_setup_bcn_tmpl_ema() which retrieves
> a list of EMA (Enhanced Multi-BSSID Advertisements) beacon templates
> from mac80211 and sends all to firmware. Add support to send EMA
> configurations to firmware by adding a new parameter 'ema_params' in
> struct wmi_bcn_tmpl_cmd.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


