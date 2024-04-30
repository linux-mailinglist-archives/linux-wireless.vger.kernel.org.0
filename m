Return-Path: <linux-wireless+bounces-7074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4623F8B80AC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 21:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAFFB22FB5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF4A12C819;
	Tue, 30 Apr 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XBxKa+3b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67A1BC59
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505886; cv=none; b=J+xqa4l8EBt19LeYJepmnhteTEZHiNaDRMT3RVUucSPpXBIvOzi33QHscCMNXfEr/aK/c0IxkJQrJZ5FZMertkhjjBv7MLoJmWpbw+1duc5KiHQYEVEKOCuBe0BOlce1mm7hICtR6KTD7qoBb9aAOS6mbn9TUBQE+CAh3PHsUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505886; c=relaxed/simple;
	bh=ZkpRZMoYljzuO/ZitpzaO5lHGj7qTk/gDgW2GiwQBFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GkUjh1mEL3lCcJqhKo2BapZjflOJh9KVS/qnVEClk6orvOmzrxENTAa8Dq6d2h4VwV2OY9KLhPTEx3PX7wgguxiNpIhpMnF+o8VttHfZwrW4JUO3Y3Ncb9LzpRw7ncAkOKfGXhMqAo5tTNYcW0ReBCfDthu8WyiMpsJwqEi8t2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XBxKa+3b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UGMdHT028460;
	Tue, 30 Apr 2024 19:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CwttRdqjcJx1cGT3JSFgZLgJk0qdm1CgpZaFkSvuCTg=; b=XB
	xKa+3bjelfpqLFaiklQIgfyVmfrIKXl2jarOFAPPxiv2kjSsHpP460p86uT7z1fW
	eTRt8QpECKkonrfP/TAnd0hWhLAIFeFibkxg3DfIXYJrDHGugUGHNISHbVdjsRks
	HHZEGEbxN02DcJc5K/UT1Amit0DU2E5avkr2vy3pJ6r1tbOWYhKhhNnM5mt10WIe
	mc6hclBNa+THvvrH095+TTKqA+/lv4khE/z89V5iI2ydOUy3q/y0SPfaoJomeLGm
	FyBe2Tdqn69KOGMf2ZiUn0oQOd3PEVsarMEdhgkFEhElPXWeXHfdn+C6+1baL/DB
	wRiD16nGm8B2g0BI8ttA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtsnmabgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:38:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UJc0MW009400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:38:00 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 12:37:59 -0700
Message-ID: <20086e83-4288-4ce4-a88e-de8aced210c6@quicinc.com>
Date: Tue, 30 Apr 2024 12:37:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 3/3] wifi: ath12k: Remove unused tcl_*_ring
 configuration
Content-Language: en-US
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430091414.2486196-1-quic_tamizhr@quicinc.com>
 <20240430091414.2486196-4-quic_tamizhr@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430091414.2486196-4-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4lxJM519WfVfpTMSzkjo4rOAxQnqZos3
X-Proofpoint-ORIG-GUID: 4lxJM519WfVfpTMSzkjo4rOAxQnqZos3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=981 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300140

On 4/30/2024 2:14 AM, Tamizh Chelvam Raja wrote:
> Currently memory allocation for multiple hardware rings done
> in host as these memory will be used by firmware/hardware.
> But in case of tcl_cmd_ring and tcl_status_ring neither firmware
> nor hardware uses host allocated memory and it uses memory
> allocated by firmware itself. So avoid tcl_cmd_ring and
> tcl_status_ring setup in host.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


