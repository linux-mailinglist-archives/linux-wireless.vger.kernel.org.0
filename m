Return-Path: <linux-wireless+bounces-13892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0A699A68E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D967C1C2267E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93199194123;
	Fri, 11 Oct 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tc6N1DK/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2D19341D
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657580; cv=none; b=r4yBPx1l40QA3c8qtIIiz0XC4FN1uWN3lfShldqYLSn9QDe1rJ4SXIMyK8U4e8DoVUwrkh50g4fFV1F65niyraban/tdwSvGfsCcdZRYpAT/6v6/GKhdtrTWYra0nvmFyVpC6NXkdmUHhmMjdLNZk66Sd8Mo4Lc3zhW4PVjufqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657580; c=relaxed/simple;
	bh=nP+Hd4j2nXLy3eSdJNV14mzQg7u6VJNx4l7m1GtiqZo=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mNNKEqganMLiGupEb/PiyhUJiAPH4mcC6rffqUqS6+kkLllqgCDNjb1Tr48wogi02SPHR/u471ol/DIN1sMTPB2NHl4xAuq1X5wboNzk6zPgSMfccJkkhpwufQSnDOUR7lbvw+F2vA6NMGPv7BB04CRXmJL4KnTObgtRjP4UJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tc6N1DK/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BAAOPn021189;
	Fri, 11 Oct 2024 14:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ERzIHVwlFdvmnBtVbHkaunW1nq8U/lMqB4r+fegQNMY=; b=Tc6N1DK/ErQSo0pa
	ldMWd1zT4R99wUAmlq0qb/d/KCUyTlMsXLuru947gg8PkB2+68vfJ9WBRhX8Ya3X
	N7x3jZi4QeBGQqi1KQUanp+4goXsT0LZxe9sQQmFKVv25D+GsxJm3RlDP6XAiQt7
	5PnpQQLW8tHEVOw2ITyFXli0KAaUTSrfqAvMjYyKo36sKHTzwVM9QGu4bzdT6khf
	SkcshTtdpoUjrawo5Kkam0rYzB9XNKbjNmbquaQMd3yY+zFS27kGGNrDPg064oC+
	on6uuMBRs3FpaTyfKKs5jguHS/155bGL1gUSO+XiShqKD9MERkta+6CKFakmortW
	rJIHhg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42721c8qkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 14:39:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BEdXAc003076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 14:39:33 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 07:39:33 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241005101816.3314728-1-quic_rdevanat@quicinc.com>
References: <20241005101816.3314728-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v2 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU,
 SelfGen stats, CCA stats
Message-ID: <172865757344.243911.3525384221862153735.b4-ty@quicinc.com>
Date: Fri, 11 Oct 2024 07:39:33 -0700
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
X-Proofpoint-ORIG-GUID: mb-_OD79XK_67gjFvoJpC_5fegHG8y1B
X-Proofpoint-GUID: mb-_OD79XK_67gjFvoJpC_5fegHG8y1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=604 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110101


On Sat, 5 Oct 2024 15:48:12 +0530, Roopni Devanathan wrote:
> Add support to request HTT stats type 12, 15, 16, 17 and 19 from
> firmware. These stats give self-generated transmit stats, ring stats,
> SFM stats, transmit multi-user stats and CCA stats, respectively.
> 
> v2:
>  - Modified the API print_array_to_buf_v2() to print_array_to_buf_index().
> 
> [...]

Applied, thanks!

[1/4] wifi: ath12k: Support Self-Generated Transmit stats
      commit: 44cfb7c58eb84e5f721a8950a4fbe3e5b3b28c27
[2/4] wifi: ath12k: Support Ring and SFM stats
      commit: 7e4eed987d5d5a988056496eebdf55202511f270
[3/4] wifi: ath12k: Support pdev Transmit Multi-user stats
      commit: 6f27b59af173ca03961d33970cfd2635f0ddb3d3
[4/4] wifi: ath12k: Support pdev CCA Stats
      commit: 3f5ecfc4503a9eb0e3cecbc580bd0f10332214bb

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


