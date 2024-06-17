Return-Path: <linux-wireless+bounces-9135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EDE90BCAD
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 23:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540D31F228AB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496918C356;
	Mon, 17 Jun 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UpQI+OHW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143918F2D9
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658840; cv=none; b=eHtF5gNurHGiGXhvd2Swh99HopP3xe9007tsndoq4HEStLk15HR3s0+qtD/X+n0xUXF2+/1o6nmmACQr/bpbPm9bYvwME6hrXRrCA/fOgBkNPGnIdbDPi/MUbuLh09p5G4nGYXr334J96O2tbauIVX3l6di3d/lXTK6syN4TB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658840; c=relaxed/simple;
	bh=Dgj8UN2Hufqrd9SHrpYek9G1o9aqYNkKKbnhhkkUZq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iBY3i9sKpoHpt9s0ySt+wEbd3vc2IisvOr5va8pffqn9zHypBJPDb9FRDLsRUS/Qd9FN2i7WGZ1y7WqFTnI4V22tA9OZ7qWhya7ohLPlr1vrbj+Jf5CI6s7uZa8bca3RqgfS/XuPN+WPeJ/ua+UqLMmC5WVFMboFhrL68yQ1nP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UpQI+OHW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HE3kPr030595;
	Mon, 17 Jun 2024 21:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QKIwOHoDa+PUmD+eRyKO9EF14yQJfKZDp0ZQumNDjbY=; b=UpQI+OHWslY+1FrV
	n6zvnHEKmKA96lB5SnZ0bM1GEZGrE50o7ONB0S6Rmtr/pVjyo9p+ZcVzLJGn4S7N
	kqKHX7t9nkIVV/PTlIOfVcjLsN8dgws3qhR4woUNoPizRr4zDofeNMmeBR/Z01i7
	wo93za4pbLFs0cgogD/KpIxgbJFNf7fcPwZVcxWvjrdRJyUgWZ+quYcb+VuhYYve
	AmJXsabbCHbm+gquSQP5ZjaSePLrdPtA4enFiAr3ylm0c3fDztkUeLlVy6tHHovg
	Fi6fRpnan/zkQU55z12FWa5yj1q0OZkn2vIVnxJN8nahysCMy2v4zFHznh0rqUuI
	xcBUMg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytfut2206-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 21:13:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HLDt6a011265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 21:13:55 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 14:13:55 -0700
Message-ID: <1f760727-6395-40a9-b817-3c05a5760a10@quicinc.com>
Date: Mon, 17 Jun 2024 14:13:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] wifi: ath12k: add factory test mode support
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240617052903.2720292-1-quic_aarasahu@quicinc.com>
 <20240617052903.2720292-4-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240617052903.2720292-4-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iQWVpRmOgzqw5AHj1rSGbwqjOCNgxkme
X-Proofpoint-GUID: iQWVpRmOgzqw5AHj1rSGbwqjOCNgxkme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170164

On 6/16/2024 10:29 PM, Aaradhana Sahu wrote:
> Add support to process factory test mode commands(FTM) for calibration.
> By default firmware start with MISSION mode and to process the FTM commands
> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
> The pre-request is all the radios should be down before starting the test.
> 
> All ath12k test mode interface related commands specified in enum
> ath_tm_cmd.
> 
> When start command ATH_TM_CMD_TESTMODE_START is received, ar state
> is set to test Mode and FTM daemon sends test mode command to wifi
> driver via cfg80211. Wifi driver sends these command to firmware as
> wmi events. If it is segmented commands it will be broken down into
> multiple segments and encoded with TLV header else it is sent to
> firmware as it is.
> 
> Firmware response via UTF events, wifi driver creates skb and send
> to cfg80211, cfg80211 sends firmware response to FTM daemon via
> netlink message.
> 
> Command to boot in ftm mode
> insmod ath12k ftm_mode=1
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> ---
...
>  11 files changed, 560 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
...
> +		ftm_cmd->seg_hdr.segmentinfo = le32_encode_bits(num_segments,
> +								ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS) |
> +					       le32_encode_bits(segnumber,
> +								ATH12K_FTM_SEGHDR_CURRENT_SEQ);

ath12k-check warns:
drivers/net/wireless/ath/ath12k/testmode.c:265: line length of 99 exceeds 90 columns
drivers/net/wireless/ath/ath12k/testmode.c:267: line length of 95 exceeds 90 columns

suggest splitting the first line at the =
		ftm_cmd->seg_hdr.segmentinfo =
			le32_encode_bits(num_segments,
					 ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS) |
			le32_encode_bits(segnumber,
					 ATH12K_FTM_SEGHDR_CURRENT_SEQ);


