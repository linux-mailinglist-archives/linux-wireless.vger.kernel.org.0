Return-Path: <linux-wireless+bounces-7478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189A58C26F8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B2028683D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A64172BB9;
	Fri, 10 May 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f9WGmv9p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE8172BAA
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351737; cv=none; b=Pl9LUwq8sPfa1hFWymB0X3rg9heNxx4+ysb3CCvYhsNJLMAxArysFx22UtntgIEA05EFlvZUagsn1/ebk21HVmIYtSH19Urs5ev3C5/IKEGVHHZDNWkZdRv6YnGTIU6fPu+N5CHsQ1bJFgo9dTRg4YqgU5pJOA627nbf2VbOqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351737; c=relaxed/simple;
	bh=HlrG+zDp11NH1IZClOubDTkAZ5keP+QCm2DQupKUv8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hGrim8jieOlwmlDYfjwyhlsD7+9sNyzfX7peygv89BmtvAvYSlSIsFE1Fk4zeexKL6cl8m8M/EZbqYAAxm7/vBoYrGSzp2SFWXXuVlTkmABxuQwUb5v0VnhjFn6V28JvWrjKdyICcyjnpfPiBPZqKwc+iqjAKoWfE/D43H1MoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f9WGmv9p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AEPR2b029759;
	Fri, 10 May 2024 14:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Y+0xBc/eDPjXUV1VOPKm7svDHFTOgoJbqPcgXjfFUOY=; b=f9
	WGmv9pOWJX7MW5rFDO1vFyPZ1Wz0r5AnScXd2Em6Fcw0E0ZX9gtoY91Q+osurjQR
	BluqXa3f6TYYW7dl12/Yidi9yvGd8Tmk//8VCUwvlI28xKMHMfB5Co2JDCE18BEg
	4FtOYLRAu+EWyPd5aLCT65shU449Sq0VK5VLP7Q5oByZ7iwrjs/Ti4vReHQu1KZ7
	+6oLcXQ08Ijz3Fg8dgdtvD0YMNdh1PGEIhY7Kw41593p6kguAmOHrozBSz/NdkS0
	E0jm2bwMWAXXnLoSuJNYEnJPhGKVd3+cor0tERQdLDgLZpt7o0WdMGD2POkyASqL
	Fo/kAzCqhZzdnjdMwgyg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w19s4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 14:35:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AEZTTM028056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 14:35:29 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 07:35:28 -0700
Message-ID: <e9765b8d-b8c4-46e7-b713-6fb8464b04c0@quicinc.com>
Date: Fri, 10 May 2024 07:35:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: remove redundant peer delete for WCN7850
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240510111238.1113-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510111238.1113-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mNwn-P-ecroa5w7nKIbk336YUXX6XveR
X-Proofpoint-ORIG-GUID: mNwn-P-ecroa5w7nKIbk336YUXX6XveR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_10,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=886
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100104

On 5/10/2024 4:12 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> ath12k_mac_op_unassign_vif_chanctx() will do peer delete for WCN7850's
> monitor interface.
> 
> But for host no need to do peer create/delete for monitor interface
> because firmware doesn't require it, QCN9274 is the same.
> 
> Also, the first judgement is true only for WCN7850, so this logic won't
> affect QCN9274 at any time.
> 
> So remove this peer delete.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


