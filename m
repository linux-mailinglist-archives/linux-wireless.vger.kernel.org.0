Return-Path: <linux-wireless+bounces-15562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332649D5082
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7192821E8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D09158A36;
	Thu, 21 Nov 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kKMwvUPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCC41C79
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205565; cv=none; b=Awz/+4Jt9p4G2tvuQBKes45GnQTLlBYiSNIS7dW8FnelP62JgokEkgFcqIvFnxgosGzK4gsHGo5IBeG5rfyYNb0ac4VsipXrTVqlXKD4aYsCUJDbCV25wpy7geqXB8vaq19X8y9CEf0ADafh5JF3BGpbDwNPE7Uzk6Xm0/zD5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205565; c=relaxed/simple;
	bh=FmYbd6TvPEhaCkA5ERF7koIxrCVqOnZUQHZWG7dwW0A=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=DPDBGNLLFHnb0KxxL6MreFZbuufI4S9pUYk1GPUIrDkvBV8z5Jm+sx7cpLddtwcebwFZzukYo6vb+l0fYrp5agcYA4FkglyVkj9EKZGcJpWl2U0Fm9X4rseCg8xsa8gcegrK6422y4Yq7kO8GfMurMjpXMrTGORYfSmigaU5nxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kKMwvUPH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8l2P7003963;
	Thu, 21 Nov 2024 16:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sFE1vS2C4MDgqkSY3PyQ517jzL+WlYJmSJUizwjEEWo=; b=kKMwvUPHoOfZkDQP
	PVvVnWnDINvMCEREgSKe+SJjDB+XZdWCy+b4dQjgRrIvq3y0rbc2XI362pi74ZpF
	tcE44k2hsXAjXf15TunSJfgRFQW0aDSRI2qzck0HJ01gQVcAYsJo0k/rBct288AP
	0y1YeYDuKbirgLi9ma8ztLQhBotNJc94/+PAO7fAGS+fF+R/U8SH4AFdmnGjDX1r
	sqCSK/sDAWeXPmhTS2Z2oZVuY6vv8wjbb8S+7oHlmp2j4k0/pYYK89rWSsyPdWBv
	S4ZWFH8BURld+XN2mhqBMjWysgRQm1g6Yh8yT/axoWp1JPS3/E4isuAR24g22D48
	AtOV/w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ce3ckx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALGCdva031269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 08:12:38 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Jeff Johnson <jjohnson@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
In-Reply-To: <20241111070152.85140-1-dmantipov@yandex.ru>
References: <20241111070152.85140-1-dmantipov@yandex.ru>
Subject: Re: [PATCH v2 1/4] wifi: ath11k: cleanup struct ath11k_vif
Message-ID: <173220555875.3016923.14494576340432634558.b4-ty@quicinc.com>
Date: Thu, 21 Nov 2024 08:12:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4yzAnR0_L0-wGXfVM6-ap4NDTBqgytYr
X-Proofpoint-ORIG-GUID: 4yzAnR0_L0-wGXfVM6-ap4NDTBqgytYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=604
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210124


On Mon, 11 Nov 2024 10:01:49 +0300, Dmitry Antipov wrote:
> Remove set but otherwise unused 'tx_seq_no' member of 'struct ath11k_vif',
> adjust 'ath11k_control_beaconing()' accordingly. This field was actually
> unused since an initial commit of the driver. Compile tested only.
> 
> 

Applied, thanks!

[1/4] wifi: ath11k: cleanup struct ath11k_vif
      commit: 733a8c69ded704616b864d30d2531d090ee7a57e
[2/4] wifi: ath11k: cleanup struct ath11k_reg_tpc_power_info
      commit: 95e5de4aae8ca1af851fc922a854bbe822bf2dd4
[3/4] wifi: ath11k: cleanup struct ath11k_mon_data
      commit: 93962446ef907cb169b089d0ff3f356e7ce004ab
[4/4] wifi: ath11k: miscellaneous spelling fixes
      commit: 8f5e8e7efb135fc648abbb572bd86d0c96819eaf

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


