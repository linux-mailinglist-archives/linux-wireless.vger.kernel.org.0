Return-Path: <linux-wireless+bounces-9561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16372917148
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 21:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36F0288135
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5821417C228;
	Tue, 25 Jun 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QAD+nxaM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACF178399
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345213; cv=none; b=bW/7KjOSw0/2/g9drjvbyVlZ7Vb33Kce+VI+0WC0umWbxCcg+oUdY3IL/uZLpOII6ekx2mz4YNktytcCx2Fsmd1mM8yWOZn1Jyyx1QXi2piFDWqiqxiZK9qIdUGWUN7P0y64IilraWOzrMyzfVObQVMRG4k9urZ6Z84OYmIhdjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345213; c=relaxed/simple;
	bh=igO16uJYYwBITmL+GTiM8SSs0U1vXzWWLbI4VGL0dXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e1pnaXX/JpgTpclUugGLQk45CvJYmiBEIfSyo334XOL7dJDbzJFGlJFWIMF6dzO/+gYnU1e6gOEyLnhBY3dWIB3HmgFRDcKxD+jSebPpcmmypf0QS6TfD51Jc94CtLL4pyqcrnpzOBMwJp8I0a5ywGeerpa1UD0PsRyYYyhEYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QAD+nxaM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PHUZEL024767;
	Tue, 25 Jun 2024 19:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	69sDzaX7rCcOq1EA3vHdocLJuTsyaOcp5s6CbijiW0I=; b=QAD+nxaMKb95GyU3
	YouwbJCE4qn0r3/am8wIhiUc9bnivLtT4+FQWH4qbeRJWLEhITHCdRfOrFDYsodZ
	Uim64mSo/L6tdSwFAGB+K6QCfqU1OvqSXVNMsfLp+Jwiv/U1lCdQadHcG1xVI1rO
	l9JFAp7B4cvh6mcYKjd71HPGWvgcic+S3akf9aqH/CYKz0jPYw4LnIr94s9XcgZy
	Wm8ajxcfcjOqKXjxRfbj9xg2Ws9xtjeJYXz4CSObLa/1PzZnrfnBlnwaM/nnbwfB
	xWBGUD0vUlJ4CWbl3eKLtQtlaHyamE5jNvOy9t3U4hMKAH9clZGT9EyyKN8fJp4q
	2k8dNQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshqn51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 19:53:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PJrSoB006287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 19:53:28 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 12:53:28 -0700
Message-ID: <67c34e28-d763-4f63-9ee6-ccb5721c49a5@quicinc.com>
Date: Tue, 25 Jun 2024 12:53:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: Support TQM stats
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240625042217.1303332-1-quic_rdevanat@quicinc.com>
 <20240625042217.1303332-4-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240625042217.1303332-4-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1yL8Ur0BdTertmReGynhln_T7AENL8A7
X-Proofpoint-GUID: 1yL8Ur0BdTertmReGynhln_T7AENL8A7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_15,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406250146

On 6/24/2024 9:22 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request pdev TQM stats from firmware through HTT stats
> type 6. This stat type gives information such as TQM error, MPDU
> related information and TQM pdev stats.
> 
> Sample output:
> -------------
> echo 6 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> 
> HTT_TX_TQM_ERROR_STATS_TLV:
> q_empty_failure = 0
> q_not_empty_failure = 0
> add_msdu_failure = 0
> 
> TQM_ERROR_RESET_STATS:
> tqm_cache_ctl_err = 0
> tqm_soft_reset = 0
> tqm_reset_total_num_in_use_link_descs = 0
> .....
> 
> HTT_TX_TQM_GEN_MPDU_STATS_TLV:
> gen_mpdu_end_reason =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0
> 
> HTT_TX_TQM_LIST_MPDU_STATS_TLV:
> list_mpdu_end_reason =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> 10:0, 11:0, 12:0
> 
> HTT_TX_TQM_LIST_MPDU_CNT_TLV_V:
> list_mpdu_cnt_hist =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
> 
> HTT_TX_TQM_PDEV_STATS_TLV_V:
> msdu_count = 0
> mpdu_count = 0
> remove_msdu = 0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


