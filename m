Return-Path: <linux-wireless+bounces-15333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8C9CF696
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 22:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47CF1F241C7
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCA18A93C;
	Fri, 15 Nov 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eJ0nA1UJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A123157A5C
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704818; cv=none; b=hYeJSBn1/TIm+Ika1V2dcRRwnze/o9tmiEgUW85vNazSlUOKoivexx9asMWZWg08hR1otUHS9cfuYO6beLu30/+AdDufncN1g0U9ina04DfCmUW+gUXwW6obbhWh1XyDpLxU3lRzaCA6zF84kevp7p31HHe165Zb66Ad+IKgEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704818; c=relaxed/simple;
	bh=3E3LChRNBnCnKb+iS9zO5qUyTS14n5jMksrEoO/5FFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FLGErQEDIG9QoSr/yavH6qEqVfBB0FeQ7LB1baTZ5+SZao/pJoUbQoIK3mtFHUhb4AorBfTlBAvhkCvMK+9D/WQn4KOE4XOQhbZYZZNNo1ph/12WWaDnnEThf+sb+5mnRkGHE6cALAR8J3OoiXkN1NGsGaCS115JXy38fPvlMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eJ0nA1UJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFHfOJh029684;
	Fri, 15 Nov 2024 21:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TXr4U+oDizqL6akLHE1U0Ed/zREhrqQPv3UoLc5BsmU=; b=eJ0nA1UJMQn7zK3d
	P7aHPuSWkZstFkNNk7O+syGsOTPFYLV3QJvRxWjHFtLeoXOQhie5eEcsGRp9aG36
	AgPPprZ4ZvO62rHtXeFR9CHIUdEVnPJ3VfZT7pIBtuxwUR5CKzkQdA4CdPgpcQWx
	Hcb+gTSytTORTTtDQR9U6PaRAr4InrqXPU7egkxYZgmh/FQNc8k9jAJvAvf/8SgR
	VpknaL60LbMfOl0OVd1gxlj5xV5i+nfYAsAEnAk4NZSYakv/TXMKsdSdK51ZR+et
	nwyhePwq4E80OtoynsXRbzuytlfSt5tzhGz1x3fvG1Re98/xXlqYFDr5WU8+AEwU
	BaiyMw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wjqammtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:06:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFL6pMa029416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:06:51 GMT
Received: from [10.111.176.23] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 13:06:50 -0800
Message-ID: <433031ef-37bb-4a98-9b98-9ea19c3d14d2@quicinc.com>
Date: Fri, 15 Nov 2024 13:06:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] wifi: ath12k: Support Downlink Pager Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241115062854.1919672-1-quic_rdevanat@quicinc.com>
 <20241115062854.1919672-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241115062854.1919672-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fjq-X7fxVoZqAZikRukR8BiC_G4zRWqg
X-Proofpoint-ORIG-GUID: Fjq-X7fxVoZqAZikRukR8BiC_G4zRWqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150177

On 11/14/2024 10:28 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request downlink pager stats from firmware through HTT
> stats type 36. These stats give paging information like number of pages,
> their timestamp, number of locked and free pages, synchronous and
> asynchronous locked pages.
> 
> Note: MCC firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 responds to
> the event requesting stats, but it does not give any data.
> 
> Sample output:
> -------------
> echo 36 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_DLPAGER_STATS_TLV:
> ASYNC locked pages = 2
> SYNC locked pages = 0
> Total locked pages = 2
> Total free pages = 127
> 
> LOCKED PAGES HISTORY
> last_locked_page_idx = 0
> Index - 0 ; Page Number - 8495 ; Num of pages - 1 ; Timestamp - 4031009360us
> Index - 1 ; Page Number - 7219 ; Num of pages - 2 ; Timestamp - 885379515us
> Index - 2 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> Index - 3 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> .....
> UNLOCKED PAGES HISTORY
> last_unlocked_page_idx = 0
> Index - 0 ; Page Number - 7144 ; Num of pages - 2 ; Timestamp - 4032070008us
> Index - 1 ; Page Number - 7214 ; Num of pages - 2 ; Timestamp - 885379512us
> Index - 2 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> Index - 3 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


