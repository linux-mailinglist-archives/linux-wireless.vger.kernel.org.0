Return-Path: <linux-wireless+bounces-14098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92699A0DE7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F53C1F2379D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4320E03D;
	Wed, 16 Oct 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U3CHARyd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3DC207A2E
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091883; cv=none; b=dvTBweWl4RaRSTH5cevaY6cryrATD0CZJvIRlpCArOr4oTGVnnVQE2CkbY29xNUZfmi/PdfCLOqvysqL6adcfvFu+yladsGhfZ6KxHRYbV7BA2Bd2RHpyJGLiD/SCN1BCA1eHT9lSh7OT6hTm3YykOAi/jlig0qYJ6loUhQW3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091883; c=relaxed/simple;
	bh=14Vh0kNPAPp9ON9wBb0TdjzF6zSxH0QOL/8aVdr+vak=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=csVa5of4q3/oW2B6VFVFtvN3OqCVa7E2GcMnXUTKXvdNT2WwD/V490Yd2Md/yw7J+nMfFhBHhIG2TuMvvYW0khi6fer6B+e4pwAe4CNi8xtoSZsrvJBcdVPk4QASlgApP28QCqlfND80sp7VlQjTEd1K5vId1Hpm1U5aleNsoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U3CHARyd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8Q3S7016952;
	Wed, 16 Oct 2024 15:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZYFc1ODUKx6ucEPKgLerQSsyZ6FJIiJ/q582DMLb4UQ=; b=U3CHARydp98OxhYz
	hzdcDW7e0YOo3UNMF0lE/CIcmitSzXR5xlduR9WlqUB1kJA/9+/trfyCdf8VP8VW
	DUC+hajpXQY7GUXRV8/WfPgk6fiNve/eqEKzMj6nEc8dNJdvuyEahTUHhnhxxWL/
	FNUMo6wI+mqCyqHjnAczGdhwNoud7bLdTqVh2GX2ifirQD0NCgdQTbM6WscD6o99
	Cc0kbxjm4W+SZawIQCAIGKw6OyXq5PhZdS1eZ4WH4cjsYrAQcOPCE57Q+9ilvHSr
	gpyNZKHuh64vwqvbON6uSgID5BWDq6lZwmynkWb5EFaq9/35uz9utwLysADm9/Au
	suudfw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mh555pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GFHv3x006349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:57 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 08:17:57 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
In-Reply-To: <20241014065259.3968727-1-quic_rdevanat@quicinc.com>
References: <20241014065259.3968727-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v3] wifi: ath12k: Support DMAC Reset Stats
Message-ID: <172909187709.412681.433183812432332038.b4-ty@quicinc.com>
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
X-Proofpoint-GUID: _Nn7PjQmRoUWQIgoqk75t6YhHvZ9DIsi
X-Proofpoint-ORIG-GUID: _Nn7PjQmRoUWQIgoqk75t6YhHvZ9DIsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=911
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160096


On Mon, 14 Oct 2024 12:22:59 +0530, Roopni Devanathan wrote:
> Add support to request DMAC reset stats from firmware through HTT stats
> type 45. These stats give debug SoC error stats such as reset count, reset
> time, engage time and count, disengage time and count and destination
> ring mask.
> 
> Sample output:
> -------------
> echo 45 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_DMAC_RESET_STATS_TLV:
> reset_count = 1
> reset_time_ms = 3013430342
> disengage_time_ms = 3013430342
> engage_time_ms = 3013430342
> disengage_count = 1
> engage_count = 1
> drain_dest_ring_mask = 0x0
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Support DMAC Reset Stats
      commit: 6c3bd9c31aadbfb97936276c14dc9aa41485a6f3

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


