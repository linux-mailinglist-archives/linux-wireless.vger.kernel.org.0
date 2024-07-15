Return-Path: <linux-wireless+bounces-10229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989293195D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 19:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E7F1F228A8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30C52F74;
	Mon, 15 Jul 2024 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p12Jbe1Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4332350A63
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064730; cv=none; b=W7Zea+ru8dL62wVtiX3XO45If+Ur9XeYkKMK0czIKhF4moQdC0PR6SGuaW/Xb+dMiC7R8GLQUVNZ18xX8/KCNBHueIL9HntIvR+6qe3jJLeb81OyxZhcVLtHvyQ/x7RmEM7/PO3iYoe4Fxd+NkDkMiwYjwtC7uO3KQQ8lDynxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064730; c=relaxed/simple;
	bh=rSAYiJVhN7ts5cjIRTZf2D+6y9s7u1fSwJmnJ9xUxuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=odLmF75CMkEzZyYQr9Hn3jZkFoP5bR7MdqyEf8TMpyvnr8sA7BX9IlLs3nKO1X1BxCuNWfIqww49GHDqHLW4UAqSledwckXszL2bABledIPq56gtYazK2Y6Umcgjl4jVPiJQ9Q774Iv3d+VDg2FBNIVeyOgDoUm61Hyg42L9qEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p12Jbe1Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH93wS032057;
	Mon, 15 Jul 2024 17:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rSAYiJVhN7ts5cjIRTZf2D+6y9s7u1fSwJmnJ9xUxuo=; b=p12Jbe1ZNk7Y5xQN
	bhkgichgU/kdivtNJ3dGJeVL3OZr1ve3nWIXMXO6App604UVT/ZZBHuANPAUJKVB
	EUSSyczepHcoE7AAUnf5m46G5UmQs/kN1yOI79jygbYwlmv6LSxdUYhkLho1NAbl
	ZR8UMJ1zSZDoGIAWi/O6e5QjT9i67KXQY+Onf+dmMeElWMZ9PbCRyUTU0MGVq5mO
	MEKmaqDOu7IzeU+b6DJ5d9ghl3/7Z6itPngeOFG/5dxeEqNMggroPRDpR23gC2xu
	brOF8NyaLUltzFXXtPHtLY0gYu+ppNsYCmUbWrALds7hG/LOkgOmje+0b53jJd6n
	Pxf3Xw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjrjcsgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 17:31:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FHVTa1032734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 17:31:29 GMT
Received: from [10.48.247.129] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 10:31:28 -0700
Message-ID: <47d0d6f2-ca36-4e56-8019-ace2304d40bf@quicinc.com>
Date: Mon, 15 Jul 2024 10:31:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix invalid AMPDU factor calculation in
 ath12k_peer_assoc_h_he()
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240710021819.87216-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240710021819.87216-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KPoEqgOtw_4zeWuoGstG-vCaX33iNKny
X-Proofpoint-ORIG-GUID: KPoEqgOtw_4zeWuoGstG-vCaX33iNKny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150136

On 7/9/2024 7:18 PM, Baochen Qiang wrote:
> Currently ampdu_factor is wrongly calculated in
> ath12k_peer_assoc_h_he(), fix it.

You have 70+ columns for commit text, use them

What are the user-visible ramifications of this error? Just curious if this
needs to go into 6.11 via ath-current or can wait for 6.12.

/jeff

