Return-Path: <linux-wireless+bounces-7609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FAD8C4876
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 22:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18541C20D18
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663061C69E;
	Mon, 13 May 2024 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OOqwVf7A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387782D6C
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633449; cv=none; b=b94nCBRv7gjp0ABd8mHkbhcN1MGvaecy29m342G06w22UXk5SIWGj1zQkVr6ultIbipNMg2SL91j8k/NiX7/CMF/s7h4Slkw3mVxsZXX73r5/B1HTDf1uaWijItkws1GGmJop7mAUEleXbXPnhIufKGnx4yfgVtOI2f7YKxguNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633449; c=relaxed/simple;
	bh=QdvjkzpaO/F+fCcXE7mS+nBD8iW72JEoF+deC+kfExU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M03eKreLjS8KWgSocX5rSWsdMHJxUVSTi/moza4pru01nNJMXHoWQ2g9pxbXVhVtcGvfDpZvaA9936ZEniaS+wdKmNXo5s0dfDLgWj8EY0qMK9Gj9id5yoFIE7MM3W7vRDgX9M/D+JQlcLgxpOLRzaoTaY32JtzgJDVLUQNN/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OOqwVf7A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8bS7018843;
	Mon, 13 May 2024 20:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9IBfPhxA1NrVwT7OSIInJXZ0zEe6Cgr+TkUZocMlJDE=; b=OO
	qwVf7A6kENzShqVZCCbbMW9bQCkh0dwouT6dOcml2Z+0LeSCOttFqvx24ErsDB4/
	4ZfcfaESPag7HfE2pJTqymqU+INtZQ3cw1sEzDLvajSe5h9OzaGeOGQ2TQ+ruK29
	0hIVqHRGfpga7vZVhOpQb4Xb+zuVMyzFv26GsYe+x5ehtmfIAxDJ0L9Qc9fsuZhL
	FJJlNuKxPRFCFudJwWd2LrSZ3VcwZu7WKZ+18wVh72GhaHovJRQeUtSjdAH1ct81
	kq3zvZn5sgOFeL8IMGm0RDN/6ybfSA1XH0FSCezaYGgvSKpERHJnJb/Ecl31RuQu
	qWl5ou/R4pfnJxEdwl5A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y20rtcgyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:50:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DKog3e028364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:50:42 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 13:50:41 -0700
Message-ID: <a376d378-ef0f-4d55-a8de-24d3ae40ece1@quicinc.com>
Date: Mon, 13 May 2024 13:50:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/10] wifi: ath12k: move HE MCS mapper to a separate
 function
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
 <20240508002055.17705-5-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508002055.17705-5-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5H13nZwGpmnT3kxu4UlUje0F5-ATOoMg
X-Proofpoint-GUID: 5H13nZwGpmnT3kxu4UlUje0F5-ATOoMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=879
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130143

On 5/7/2024 5:20 PM, Pradeep Kumar Chitrapu wrote:
> Refactor the HE MCS mapper functionality in
> ath12k_mac_copy_he_cap() into a new function.
> 
> This helps improve readability, extensibility and will be used
> when adding support for 160 MHz bandwidth in subsequent patches.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


