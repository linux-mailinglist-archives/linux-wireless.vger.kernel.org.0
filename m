Return-Path: <linux-wireless+bounces-2845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD3842AD6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 18:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87321F24F3A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329651292DC;
	Tue, 30 Jan 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IAfngjHf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4A1292D0
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635494; cv=none; b=DzdrHN9bxgEtt0HwXWyxxg5ig0njlSkoos2AR1RAiHFS+iPgjIRsG/A4dPBfxnSgPNVvAeKYRyoswOjAHwyC6qPioLmFx9yp2CkzAgpgfE0twHhvwltjkhncGCO88+XXLnn5j3cAxgsW0VBmx9//VR/ffq3LGKXmRRMDqjhSwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635494; c=relaxed/simple;
	bh=BtlY0d2G5cO0qoxmILeJ8rGa5uubpqLAzCDKeQXqKck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BRI9blQBjnqyZxr548GTdgFu/2puYoNHbtEMORv5PVU8ktO4oPzLAgZP/nK/SVpA9Fma7OOTWGK/HnKi4aQUAupJ3CoI8HdxHe3VgcjFGl6xRR6y9Zod1mJ3wCA4YMst6Vv4Ax2yne0dM7+nXBCfqx+RFVqRrp82F1wDo4q+xAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IAfngjHf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UHCVvP008528;
	Tue, 30 Jan 2024 17:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=djy+cM0Fs1lCYDxiono/XFC8TF4kpNBMh9BYZqFz4uY=; b=IA
	fngjHfEKGdc08dav2SfxW0rrgjA18m6168MIlEdMnbIA4OnOvAIU4NR2S1E4TZgu
	vcfePiqQU79FA2eL++4QpXbyUBl7cgToFXyl5b/HVMpA0eXztqYQ/sqcWNE0o5m6
	kaVCIvszWyurKeeP8jeCI2UmWNnvzRRsmmQffxMc8RETLei0ldiWo/jBoTZcYHjE
	s7xaA61hBFzeGsA2qwVuA71M+CCWsrmTZxfxD9ttrvneayGRK5UuC3DSap9crP+n
	4qEDR7u3PpEK3Quz7uV3nZR69mh8KukFbhVP4QOHdEdijyWASuaLd9S6xhPn5Jys
	2s9X0jGDvbEDIZtonh1Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxwwv9672-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:24:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UHOnCx021772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:24:49 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 09:24:48 -0800
Message-ID: <0a1e65bf-d673-463c-ba24-850b212fc1f2@quicinc.com>
Date: Tue, 30 Jan 2024 09:24:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/11] wifi: ath12k: designating channel frequency for
 ROC scan
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-11-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130040303.370590-11-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _DKuX26a-j2zytSkU6c_kkEXPiO4M8Sr
X-Proofpoint-ORIG-GUID: _DKuX26a-j2zytSkU6c_kkEXPiO4M8Sr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_08,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxlogscore=852 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300129

On 1/29/2024 8:03 PM, Kang Yang wrote:
> For P2P mode, the WLAN interface may be requested to remain on a
> specific channel and then to send some management frames on that
> channel. Now chananel frequency of wmi_mgmt_send_cmd is set as 0. As
> a result, firmware may choose a default but wrong channel.
> 
> Fix it by assigning chanfreq field with the ROC channel frequency.
> 
> This change only applies to WCN7850, other chips are not affected.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


