Return-Path: <linux-wireless+bounces-5982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A57789CE62
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 00:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603FE1C23791
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F4149DE5;
	Mon,  8 Apr 2024 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Whmex3t6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670171494B8
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614650; cv=none; b=rzdhB4C/R5/WAdd/9RIfFvYPL+WbOGu8/a5TfmDoHGPli70mO4wBjxXfZ43Gr0TT3jmWWYTCN69VRGNi8s2lCfm4wf8rKgi+PaQemmK3GUnNCLweLDyQAlx9sHweiGv6sg3L4lDfLS1BRsB2cgmlDG+tmUDcWiBJ1mdMBE9ZZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614650; c=relaxed/simple;
	bh=tyLtBwyFPETtuKnr89mb3QYYfcZJyAxHtSJckffPXCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sxVTLqMh5N+BbSX6mJMiT5xvKTjEFkns5yBbnT6ESsDCvEqZkKC3x9AY6/Drt8DT/6dtrx1oo0/6cdBpu9B85KPFrgvODXv0ozE78pWb7182xPVtygUuEnuaSorI26AbT7Qp8JG+MTDDCs8TeWbFGa3TzV7dJg7k4GU6rSJTL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Whmex3t6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438M9xhT003684;
	Mon, 8 Apr 2024 22:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ge1a1RUicUKVwlP7aTZXkx/xiVpMFuGvFfxzp6eETdk=; b=Wh
	mex3t6w+kYbzTKx68I1xGQ4e1WJIqGUrS6VxHAzxDyGe0j7S7XfyWHKxihAVnbuH
	ZfC7foHDQYO1cXSmIIXJBC9IM/lBOdVUWOpJZIhm1dDw668RsQRLjmG6ohGiBxIK
	HjxNaM6k5z/uSXuGNjlkF9VRAjXBbU51agrXxMuZwNXibmW12OPmOqMBaiEK9hu9
	hq77f1Z0SkJKSIyrivlwlvV9+SMbsk9BgOQSRvLDiMuDlipJWNr6fRHChnf4DdCW
	Mn15d6RrHvWYM2N4ShDWFUgTuWR8eibwQMf8PQUGafC3lwQhxCNAiKMORvYuUS44
	JFuuZNS3WOEUYWOHf/cA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbfyhyn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 22:17:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438MHQFq027107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 22:17:26 GMT
Received: from [10.110.80.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 15:17:26 -0700
Message-ID: <7c57c1f4-13ab-4216-9283-3290fca44a83@quicinc.com>
Date: Mon, 8 Apr 2024 15:17:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] wifi: ath12k: Refactor the hardware cookie conversion
 init
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240408040547.837639-1-quic_periyasa@quicinc.com>
 <20240408040547.837639-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240408040547.837639-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rcq5TURkOjAqYgjozOwfRACLvUg_jAwY
X-Proofpoint-GUID: rcq5TURkOjAqYgjozOwfRACLvUg_jAwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=992
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080170

On 4/7/2024 9:05 PM, Karthikeyan Periyasamy wrote:
> Currently, the Rx descriptor is placed before the Tx descriptor in the
> primary page table of the hardware cookie conversion configuration. The
> Tx and Rx descriptor offsets are implicitly hardcoded. To allow for easy
> displacement of Tx and Rx descriptors, introduce Tx and Rx offset based
> cookie conversion initializationi. Additionally, should consider
> validating the respective offset ranges while retrieving the Tx and Rx
> descriptors. This change will be utilize by the next patch in the series.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


