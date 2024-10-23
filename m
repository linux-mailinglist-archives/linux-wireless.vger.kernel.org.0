Return-Path: <linux-wireless+bounces-14430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1004E9AD265
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7981F221B7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0411CCEE1;
	Wed, 23 Oct 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Agi5dss/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AEA1CCB24
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704000; cv=none; b=HcM0ITHdirwxSCvXhOaFv7cnd+s1EK/QLhOyh/pKYtbgBAmZdbgcQ5ARVNWgSNDArbYhgIG3uxsxpU7cXsxBSkCKMhL9sMWWrQ7NmA94bU/3mpTuocAanqbPvT0o06QDRhRhfbHRy/Fh7r37sSJjFac3hWrUhuMgSuRbmpF0cDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704000; c=relaxed/simple;
	bh=Q2n7XqrhcwWvoScPxenO5mfT9cy6Jtt5mQIwbKkpZDY=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=lAIFNMncCKHCSE6/GgacdnE6hRqM0lyOCDl9A8HGbJeJuFSRUpny2IUYMsqbwOFoDX7TUTzciszhp0CmTi+RPATnMydJLFawboAbcRWrD3bENW+/oNbTO3BM6ofm9aIH6ylLQfoT8eXxGYLbH4xgM+YBI8LRKeeA9s4GOE4lgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Agi5dss/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9jcEB030928;
	Wed, 23 Oct 2024 17:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E9V9GMiOKYvOG8D9BTGYrGORbewbut1V45qDwNWe5lg=; b=Agi5dss/Pg3HrQC8
	UvN3m1p7HefGvdroOBZgnpRTlnbZeaOeU3IqKJGzsyC9JlpYjyJqO4BlsZJRQJzn
	2IfKi4IXcI7/9QUPdC1NU7F3Ydfr3ZzD1QxMX5xPWR5GQDZFJEQlS2pOJlL2BYGe
	oWXZudQUh4VncAn7WVGkvfMSA0P2eNQXXOuyu17emVO0yVG3P3a4ddMcNUv7fhU1
	RV267JAllZQChs19pOO/e/b32ez/70cX+zn365JlvXWuvD4UCWQflQNnEojkdKcC
	NflkXQnGYAK5XWBY8aQTpx/exaf54d/1NSMo7qcB2WVSHPMJg+13gp2ENOc+Uq7n
	gz566w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3w30vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:19:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NHJoCR018061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:19:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 10:19:50 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>, Kang Yang <quic_kangyang@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241022110831.974-1-quic_kangyang@quicinc.com>
References: <20241022110831.974-1-quic_kangyang@quicinc.com>
Subject: Re: [PATCH v6 0/8] wifi: ath12k: some fixes and clean up for
 monitor mode
Message-ID: <172970399023.4141877.14669488341667505907.b4-ty@quicinc.com>
Date: Wed, 23 Oct 2024 10:19:50 -0700
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
X-Proofpoint-ORIG-GUID: GwxJqJ8X9OCkz9VfiyAXgpG1XzR_Y2xJ
X-Proofpoint-GUID: GwxJqJ8X9OCkz9VfiyAXgpG1XzR_Y2xJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=862
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230109


On Tue, 22 Oct 2024 19:08:23 +0800, Kang Yang wrote:
> This patch set does some fixes and clean up for monitor mode.
> 
> v6:
>     1. mention the change is also needed by QCN9274 in patch 2-5.
>     2. mention the change is cleanup for patch 6.
> v5:
>     1. rebase on tag: ath/ath12k-mlo.
>     2. remove patches which have conflicts with MLO branch.
> v4: rebase on tag: ath/main(ath-202410161539).
> v3: rebase on tag: ath/main(ath-202410111606).
> v2: rebase on tag: ath-202410072115.
> 
> [...]

Applied, thanks!

[1/8] wifi: ath12k: remove unused variable monitor_present
      commit: 4d05ee786e32179ea462d632f717aa89d3b06b41
[2/8] wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
      commit: 68e6a80b36197a2be22fdee9077509d37515f0df
[3/8] wifi: ath12k: fix struct hal_rx_ppdu_start
      commit: 2298e37ac0586fb53697e53719f86ab7c68d1f25
[4/8] wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
      commit: 04f33114af00317dc3c494e60a7c42292e0ffd7e
[5/8] wifi: ath12k: fix struct hal_rx_mpdu_start
      commit: f76bbedf5bda1e45339f44bbb9ed6d8f3262f4b0
[6/8] wifi: ath12k: delete NSS and TX power setting for monitor vdev
      commit: 78d2405fd51b6919a5f645db41f3bc8b2267d426
[7/8] wifi: ath12k: use tail MSDU to get MSDU information
      commit: bba112e6ed9b65e8abf0e3f9ac65ee851b14a8cf
[8/8] wifi: ath12k: fix A-MSDU indication in monitor mode
      commit: f7b982d13df72dbf8c1f3f98fadc9d9155608ecc

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


