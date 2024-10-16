Return-Path: <linux-wireless+bounces-14099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C039A0DEA
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 17:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6081F232D1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CF2207A3E;
	Wed, 16 Oct 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P8p1ig9x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB6E207A2E
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091886; cv=none; b=NCm2OrPjPzGUApxoJFtZjUp1y4pAd+ZJqG+sVj2nCvYazW2iLctSOWno0EWLu5ptzvmF2LoEpScS0QMJGbg/Tp5UqTFx1chlkSG4EnnEYOcu2p/dJM+nr5TL0bl472kKdxnOByJg+XYEiIDR+BbO9fZzEloeLjeRIiAPF56A0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091886; c=relaxed/simple;
	bh=AP2tiSGNy7GrRqWNzVS3ffSvI8iOG0LXTCir3NF0p1c=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=UIdOMWRmlFzcfUSv/i6iHhlLI6igAGYBvky8eJLei9J2THmU2ATlUoS+ark9Poybzw2M66gl+9TRwvObKswJKEMgcnzHfweMmdM8BX/K6Pp3HOxBPzUSGD6tCpGbp4zVScJKs57XRmOggobhPJnzlvTE2u2wIJcVo6pu/Th99n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P8p1ig9x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8Q2TT016921;
	Wed, 16 Oct 2024 15:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9nDg3GtNfDTM7i61AFxwO1Y2ktiYpG3Ez8Nu3giBiPU=; b=P8p1ig9xahqA+h+s
	lXUND2GKaRCQ96eBLjqwQSg8/d5x87Fvg8H+31tcMfzOwgEjbxsiUjMZH+qLSGd4
	KIDDQgTnsJ5mzZkuu67C3uvavx+GsD38V1EQKLD8r6c0+luNtuxoSpCf3xU84pgJ
	96uokuGZ6RR/x+HFUFalgW1JRC2IcOUWFxFeSOGs3yW4ZmHGhbRiLA/ssZKY3XU7
	wX+GKIzvv1jGQYwIG/5apgZWw0TaZ4XHKxTRSjASSDfq54xCha0bASTqsm1ZCWoK
	7TFieEz6GMxUmWFjHyxFHRtaVo607ls2T8846h7WYH+/SE/bJjuRQU+gPbLH7hN2
	IANMdg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mh555ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GFHvtN006354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:57 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 08:17:57 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241011173323.924473-1-kvalo@kernel.org>
References: <20241011173323.924473-1-kvalo@kernel.org>
Subject: Re: [PATCH] wifi: ath12k: add missing lockdep_assert_wiphy() for
 ath12k_mac_op_ functions
Message-ID: <172909187769.412681.9881544527970265650.b4-ty@quicinc.com>
Date: Wed, 16 Oct 2024 08:17:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aGFJCk5uUixlfpEo5GblVvYZPsu_ZxG8
X-Proofpoint-ORIG-GUID: aGFJCk5uUixlfpEo5GblVvYZPsu_ZxG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=582
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160096


On Fri, 11 Oct 2024 20:33:23 +0300, Kalle Valo wrote:
> Use lockdep_assert_wiphy() to document the ath12k_mac_op_ functions which are
> called under wiphy_lock(). And make sure that the functions which already have
> that is in the beginning of the function.
> 
> No functional changes.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: add missing lockdep_assert_wiphy() for ath12k_mac_op_ functions
      commit: c347f18160219ac75b0c79be983e500b5959fb88

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


