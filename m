Return-Path: <linux-wireless+bounces-14887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247109BB93C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 16:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CFD1C21022
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE831C07FC;
	Mon,  4 Nov 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oGx/DLS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B61C07CF
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734994; cv=none; b=SYPnhRAHVAUx2h6S/5JTy54Ndz0QfQrIZCeyK6XqUrkhPTWd2ArD9sUI/+z7n/expcxM9vj4uqR7UPlmwfATcSjXN0EMcYubX38fWAu/7Y5xXF63RcXWMzJlO9M37yDIF7N3g2ersp8ENtt3RkJDnjHboGMvfEAPl1+avbJwsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734994; c=relaxed/simple;
	bh=nJ34rux8zMI2oy9odaPJsjqo6fFP0fbrKjI2mVCJlh8=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=DIXbm5hSlguNx1Py0kOLNpFUWu6AGCC6dws8QrutS4XJ0XP6vpAnLbiD4O69WKMnT1/QFCCG5x78KbTVP423LioPOPDJj0ESSI71eqEJUjYwWMuz5ZS7bT57Br27uvFIX//5BzYCf8IgrozIBp5tG5EtN/FcZVwoZm/Iuil39Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oGx/DLS6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BRFHk003006;
	Mon, 4 Nov 2024 15:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kPI0iAdhtoOom6RjX2x9CdraLwySyEOx+cns+4xR+hA=; b=oGx/DLS6HGZr3uL0
	N0E/OCxkt0sKe4k3TkvDGv0hqoXwPxMgfjnvC2rg8YRkA5ww20sbxl+KQ1sLqeA0
	p7YaKiXPsN7VT++aqM3vPKUP6ZvtunLt4EHleXIBoX0UV2WNBJIIaqW/3j33o2nM
	bAjK6e/65eAMuK0DHhJfb50UNbDJui3gXx4/V3J+0AaSby4b3xUNpc1AUk19lIDB
	xnGEpQVgx1a/p9AOBKtOTxaQ/wDhgP2aJehs25vPK4CRi1mc9jWDVMda6dmKiGZn
	YfsMk4iAHNi4nSfUj+8QGYbksMUZchqCBlZ1PYXs2aBcMdathc3tDyqxIAWBQ5Pf
	BNIYeQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4umq3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 15:43:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4Fh4O8023584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 15:43:04 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 07:43:03 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241101151705.165987-1-kvalo@kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
Subject: Re: [PATCH v2 0/8] wifi: ath12k: MLO support part 2
Message-ID: <173073498389.2435998.13463784355335607514.b4-ty@quicinc.com>
Date: Mon, 4 Nov 2024 07:43:03 -0800
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
X-Proofpoint-GUID: cuG3X7FG-MFoWOEBHKJ5iM1QgutZprgW
X-Proofpoint-ORIG-GUID: cuG3X7FG-MFoWOEBHKJ5iM1QgutZprgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=665 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040135


On Fri, 1 Nov 2024 17:16:57 +0200, Kalle Valo wrote:
> Here we continue to refactor mac.c to support multiple links and extend peer
> assoc WMI command to support MLO.
> 
> Please review.
> 
> v2:
> 
> [...]

Applied, thanks!

[1/8] wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
      commit: 09b99c10ddcb4ce6ea8410057ce99e5ab8e21f84
[2/8] wifi: ath12k: MLO vdev bringup changes
      commit: 60dcd3ce43104d774962c63cd21e93853449f2b0
[3/8] wifi: ath12k: Refactor sta state machine
      commit: edecb91a4f808ae48885e69479aa1b8e0d8e23e0
[4/8] wifi: ath12k: introduce ath12k_hw_warn()
      commit: 0b532c7a3d7f6dfb44796df12afa0823338453dc
[5/8] wifi: ath12k: Add helpers for multi link peer creation and deletion
      commit: 2496a67fee5a1d08fa1dd193057ae16d35e656da
[6/8] wifi: ath12k: add multi-link flag in peer create command
      commit: 9ef82da375f8991a6006a36e4b00f87adbffb67e
[7/8] wifi: ath12k: add helper to find multi-link station
      commit: 08a171207b407c5c8e187ab0dd137cbb0394294c
[8/8] wifi: ath12k: Add MLO peer assoc command support
      commit: c33f9c2728d0ccc7472e6239346c0fb3de556e0f

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


