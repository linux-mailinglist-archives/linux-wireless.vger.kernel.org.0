Return-Path: <linux-wireless+bounces-7484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB618C2968
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 19:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A241C223D1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B218C1A;
	Fri, 10 May 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kvb1A8oC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1C18E25
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362781; cv=none; b=cXUOzY1To+8wunabslCp/yXkqHPFKNt3NhU5uA3XeljKcDvj40TSzdiW0anjesKMST6Ae00eANfFiG1BcLp+yu1/2pWxGXceSu044L8vXoyKEQEYg/1KPnh+oGsqdBeO6szmdO+xTCoBzL995l9WkoLTrk5dAsCY1YfLGBC55qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362781; c=relaxed/simple;
	bh=pXeRygPcNXBVLfZvWUSwh3kBEgs0gcBi3Pm35XLihw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OZEcz+sRgJGHHsmeoDSZyz9KnZt6cH0huO0qACwO//BBfWVubpFYdewL6dAEtg558KVcS1vGwaRU1/yS/fRO90MaF0iZQfm0Xq5i2wrl265lE2f4SdfoGuQovN+qG+RfcjeVF5hPtprvr9e41jGkUcksXiLYgvsNg1JP6OvM1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kvb1A8oC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44ADKuR3028302;
	Fri, 10 May 2024 17:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HfsASH9W3Gd6gUFNPUXbS5SvzZrdpLyqdk4tfmMP+5A=; b=kv
	b1A8oCJ1e38u9dNkThRakJxplHdfiomB72Ep+vvWvBZUWaHY9emiS42yF9e0iNJN
	A+8KE7XCBXSO+dBgfNKRylM1L5MlcShgTJTY4TR9CpY75mVjvDXsMHUkz+iHNwta
	GHENM3W1YAY458IACPwanMJOlfiP0GXGx6qNN73fmdTKoIV9NMn7b00KYyQznK0R
	+1GsQ8X/HchN5/oAXkH3D130yDAJ88xLGw0NDZbuATILSpRIYvWY+uf3GxaIMo4B
	sKMIBwkW8YRkQUXW6GVBdZOqu444Ey8vEvfrO3EgnGPBdT22pprCHSR2In1Soant
	DhZljICwVYE4LzbF2dUA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w0t68h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AHdbuF014024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:37 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 10:39:36 -0700
Message-ID: <3fd54cdd-d0f1-4f3e-81b4-1898400039e1@quicinc.com>
Date: Fri, 10 May 2024 10:39:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] wifi: ath12k: add basic WoW functionalities
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240510064748.369452-1-quic_bqiang@quicinc.com>
 <20240510064748.369452-3-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510064748.369452-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F1JefLF-9BfDPA_GoWCW7KL9_3yLS-VP
X-Proofpoint-ORIG-GUID: F1JefLF-9BfDPA_GoWCW7KL9_3yLS-VP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100127

On 5/9/2024 11:47 PM, Baochen Qiang wrote:
> Implement basic WoW functionalities such as magic-packet, disconnect
> and pattern. The logic is very similar to ath11k.
> 
> When WoW is configured, ath12k_core_suspend and ath12k_core_resume
> are skipped (by checking ar->state) as we are not allowed to power
> cycle firmware.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



