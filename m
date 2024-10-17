Return-Path: <linux-wireless+bounces-14182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9315D9A2FD0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 23:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB871F25D0A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7701D3185;
	Thu, 17 Oct 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KyMccSja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8B1D3182;
	Thu, 17 Oct 2024 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200342; cv=none; b=YTL18F6zev7Or4tfmNlULQb6fjNwEBxqOdEQARIjFeCqctZkw+F2tSrd9zHLHCF8ijRqg0MN/Lpf6GoLBwC0rmwbU07ezVwrhd+RF/qPbIhuBRFB1Cy48VSB4DXr1FO1g/zRkBXiJRxt8lDCgyBujkGlnf8D3FvYNRjXxdwX4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200342; c=relaxed/simple;
	bh=suDF/ADSxNICs9pQ/ec+TobPhgWJtyvEXu2OKVYrk+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mWGuvcMXWQE65Yg75yvnHH2hSr/7W2ZuIxGz9NTPxcOwTEej/djtOVu0LgkjW8Xwnyj2Zh4/1/0rbrPYklMc/7ne9R+CdvmZgCHBSjCo1BQEJ/ciHW8XXXp3E5oL6fQMKnwjeFHWrlUJ8WZ9Yq9lcQuAR9yZpU4J1kk3meqg7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KyMccSja; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HHEWT0000489;
	Thu, 17 Oct 2024 21:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nXiMqZVzQS5lxXD/YXvDV9jZB0iT+aslMiGaiQVmRdw=; b=KyMccSja+Jzpqf0M
	ShCjjsIrzEDTD+ouG+/2pJX+Cf4ZwcCBdWyFMhkcjcDvfp/LxqxsMB5gOMtgbOiU
	bJ92cxSmUKFUngondzCXl+XC2OWYkKRl++IBKLJbvJ7kgE+U3DP/iVEXQSjWVk/S
	SdsstywsV6LFLqyrJguSl0ymEGIhYihlOOy9NYqo0vLyRevqgbxfCBDYfLowCRUC
	SVgRjOFbMCXlG24b6p1zK9dpZeIZkyN153I4YvvaZ30V1xTHsqnGg4EE1w+k3eZp
	f5k8sYPvATTmpLAaWi/aeQ2FGQRnA3ChBHLfV61F0bRTPGCbzZOdmYlfWUQ25qUd
	tFCoWQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8nq6435-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 21:25:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HLPSVm007469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 21:25:28 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 14:25:28 -0700
Message-ID: <9e314a29-69a3-45b3-9d70-b86075582b23@quicinc.com>
Date: Thu, 17 Oct 2024 14:25:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Improve ath10k flush queue mechanism
To: Remi Pommarel <repk@triplefau.lt>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Cedric
 Veilleux <veilleux.cedric@gmail.com>
References: <cover.1728741827.git.repk@triplefau.lt>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <cover.1728741827.git.repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TJtxeNbv4Rpw6SF0azI50sDIvDG48nnn
X-Proofpoint-GUID: TJtxeNbv4Rpw6SF0azI50sDIvDG48nnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=278 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170144

On 10/12/2024 7:13 AM, Remi Pommarel wrote:
> It has been reported [0] that a 3-4 seconds (actually up to 5 sec) of
> radio silence could be observed followed by the error below on ath10k
> devices:
> 
>  ath10k_pci 0000:04:00.0: failed to flush transmit queue (skip 0 ar-state 1): 0
> 
> This is due to how the TX queues are flushed in ath10k. When a STA is
> removed, mac80211 need to flush queues [1], but because ath10k does not
> have a lightweight .flush_sta operation, ieee80211_flush_queues() is
> called instead effectively blocking the whole queue during the drain
> causing this radio silence. Also because ath10k_flush() waits for all
> queued to be emptied, not only the flushed ones it could more easily
> take up to 5 seconds to finish making the whole situation worst.
> 
> The first patch of this series adds a .flush_sta operation to flush only
> specific STA traffic avoiding the need to stop whole queues and should
> be enough in itself to fix the reported issue.
> 
> The second patch of this series is a proposal to improve ath10k_flush so
> that it will be less likely to timeout waiting for non related queues to
> drain.
> 
> The abose kernel warning could still be observed (e.g. flushing a dead
> STA) but should be now harmless.
> 
> [0]: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
> [1]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
> 
> Remi Pommarel (2):
>   wifi: ath10k: Implement ieee80211 flush_sta callback
>   wifi: ath10k: Flush only requested txq in ath10k_flush()
> 
>  drivers/net/wireless/ath/ath10k/core.h   |  4 ++
>  drivers/net/wireless/ath/ath10k/htt.h    | 11 +++-
>  drivers/net/wireless/ath/ath10k/htt_tx.c | 50 +++++++++++++++-
>  drivers/net/wireless/ath/ath10k/mac.c    | 76 ++++++++++++++++++++----
>  drivers/net/wireless/ath/ath10k/txrx.c   |  5 +-
>  5 files changed, 129 insertions(+), 17 deletions(-)
> 
LGTM wit a few nits.
Hope the Qualcomm ath10k folks review this.

/jeff

