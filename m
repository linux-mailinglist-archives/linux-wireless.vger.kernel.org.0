Return-Path: <linux-wireless+bounces-12919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6621597B19C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989AC1C21608
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594C178CDF;
	Tue, 17 Sep 2024 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kxZfToqx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A3176AD8
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584677; cv=none; b=mw3YvInGdCv5pSiOfwkTNdKZHmXJDwQDn3N0+D0Bdup7rDOuPeS0KEw1BMWC8VYEN5Yz2dvGxVy/Q+RDBFN4MOFOpO2YrZ0a35RXTMvE1n7DBxVBThg9KccWwYGv6P5TwOqgncr2o5ejdQ/eR/jiRGWp8rvuavV6EWLazvRi42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584677; c=relaxed/simple;
	bh=fMj/h4LCoHd4KmqB4QSntxhhDkQGGrWUhTzHUM/w2sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kkw5/dW8cuqcKsjz5ddJmSLd9vCmSWDoPSKFywvexKNFk7Bf6+xsjzIo7OgY7YKPW6ZDkjPQNguv0v4LARXlsJ29gsAqgswvWrGbgpEg1guhrJ3VFSB/tO2Le/vmbMe6zsMGqtuRKuM3ngqSInaVQAcqiGAH7HZv5LDRCWySwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kxZfToqx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H7ab3x000930;
	Tue, 17 Sep 2024 14:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bHWI+rUKYnUBsy4BzvhTEP1okF8ZjrZVvjZntr3p3WQ=; b=kxZfToqx5Hp4zhdm
	hxRRuseIWbg3u4HIBjDi9udYmz4qb8uHMzb7h4e4linRyefhFBzduP9MtOqiDRiM
	Goy8kEqE+/kQ8oTX4PfFhCFu/AhtFUlllL60qU37eI3YGhSboqEufT4F7abFDEro
	33HD/fGZcJk03LFN2ViJm09X5Nkadre0za+hUjQaHIeCf2sJ8QxKAUYSXiRA00TP
	298on30E0W+DSUeZwXH1B/6kJ5i9fbkXMm+JzzG18YZnUXUc2clriz+M03fvTHgS
	YI5kYSPwRWVRPPq085N7BDBcoNQOTFMPUTQTxGEYALdSHgq35VuGat7giqXbumw0
	p0q5ig==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jeq33x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 14:51:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48HEpBIJ001460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 14:51:11 GMT
Received: from [10.111.182.118] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Sep
 2024 07:51:10 -0700
Message-ID: <747fa057-947c-456b-b31f-530e8a748f5b@quicinc.com>
Date: Tue, 17 Sep 2024 07:51:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath11k: move update channel list to worker
 for wait flag
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240906033200.472-1-quic_kangyang@quicinc.com>
 <20240906033200.472-3-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240906033200.472-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F3MR9OMiMztPRZjNDtpjA97Iq4YsyaDC
X-Proofpoint-GUID: F3MR9OMiMztPRZjNDtpjA97Iq4YsyaDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=921 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409170106

On 9/5/2024 8:32 PM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> When wait flag is set for ath11k_reg_update_chan_list(), it will wait
> the completion of 11d/hw scan if 11d/hw scan is running.
> 
> With the previous patch "wifi: ath11k: move update channel list from
> update reg worker to reg notifier", ath11k_reg_update_chan_list() will
> be called when reg_work is running. The global lock rtnl_lock will be
> held by reg_work in the meantime. If the wait_for_completion_timeout()
> is called due to 11d/hw scan is running, the occupation time of
> rtnl_lock will increase. This will increase blocking time for other
> threads if they want to use rtnl_lock.
> 
> Move update channel list operation in ath11k_reg_update_chan_list() to
> a new worker, then the wait of completion of 11d/hw scan will not
> happen in reg_work and not increase the occupation time of the rtnl_lock.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Co-developed-by: Kang Yang <quic_kangyang@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



