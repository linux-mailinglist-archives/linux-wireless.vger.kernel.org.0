Return-Path: <linux-wireless+bounces-7608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0183B8C4870
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 22:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315B21C20CE9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04178283;
	Mon, 13 May 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bXXFh0Yr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D01C69E
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633430; cv=none; b=YZT5/hCQsojgY0yIhuMIPzgXy2GfafSsr82IJppeKSi+XhhtXAlnG/RgBkhNporK7QqYBTCoNyOYtsb2l3bq8mIxSieYPGfQP0hgALy8ushjorvdcak9u5w91M8bW8HLGEw+VBivfFjdEk29pfH+yCrOMh65vP+Fgt3xFVT3icI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633430; c=relaxed/simple;
	bh=6OGUPiHdFRT+/WmTKh3Li/EY6Pd+dXpdykfh5YBnCic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HDgi/V/5yitL+DUK/VmblprOjqTbq7zS2r0tZXuIcEjBDMdcivCcraW+1OcsfP+8ENFVfbiH5NO775y90MnFrtVCvmc0QLIH3uA9qKQ13JKaNW2Mot6fNymM5op4vNCjrXqm6SOCfyRX6CVlRU3oT4PJbETo8rz2l5U4Bi1AtGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bXXFh0Yr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8cQh027283;
	Mon, 13 May 2024 20:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rwxgJ7hH6nUNQAAX+fiFfxdP69xhCHORfAhQDTmzVuA=; b=bX
	XFh0YroLWTE2EQ8HQ7JgOwXOnVq42ld/bfjP8UZWSo991WEOqDU5whfdv8SuTAl3
	wIcG5NSCnl08x+GvsF2lE5xMVmVIiTI5Wb77xK9hU8WzRm8VxWQKTZUs3/bm8qJe
	cvi3UC0NNpBAkND1j+kVA6TOPOS63ptkJmbpTw1/kw8nqpBW0dhMztStRoPOCJxp
	kdQmp54rZcSMbWsXau7Ud7F69to8ggjHn0Fii95vuOwPsSTzcNhyarKymTQvePXZ
	a7jgrB6WshGiAddsdGphJJtiucrS8hq6YaCN+uwC4V6dYt9tNLemZI7UFR4JTtVz
	a86iat85O2pnuLFhuM3A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y208vvh4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:50:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DKoOEO019632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:50:24 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 13:50:23 -0700
Message-ID: <eff1f89a-9ff6-4d79-9cb0-1c0058c47115@quicinc.com>
Date: Mon, 13 May 2024 13:50:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 03/10] wifi: ath12k: push EHT MU-MIMO params to
 hardware
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
 <20240508002055.17705-4-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508002055.17705-4-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DqdctsrbMRdCi46CI41MNF6bCJZNpoHv
X-Proofpoint-GUID: DqdctsrbMRdCi46CI41MNF6bCJZNpoHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=805
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130143

On 5/7/2024 5:20 PM, Pradeep Kumar Chitrapu wrote:
> Currently, only the EHT IE in management frames is updated with
> respect to MU-MIMO configurations, but this change is not
> reflected in the hardware. Add support to propagate MU-MIMO
> configurations to the hardware as well for AP mode. Similar
> support for STA mode will be added in future.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


