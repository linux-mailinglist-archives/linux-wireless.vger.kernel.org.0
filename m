Return-Path: <linux-wireless+bounces-7924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1F8CB458
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73300282543
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD7148859;
	Tue, 21 May 2024 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W0xm7JCs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE17433AD;
	Tue, 21 May 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320436; cv=none; b=QlOUm20Sc04yP/yLueAYMYKJpka9Flk0zDf5V0BUmXfUPCAif8Xxhtr3Q4+FQo9Q/3+ENWzMe/xV4HoV0TcG4GUUa4mIQs2x5SwUOe8D4vJYiwtVEevaoZe5gIZmJsBoVCOfjpkw3gGk0KBwFSpp3vqVqPbJipTqGelX2+GQ8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320436; c=relaxed/simple;
	bh=PSJzz3wBgM4Nov61eoQKU/G3JLPzuVohtgY4OMFxi4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYl/YbwIuVFbJPjAKQzREoioNPQIVvP2PAr1ZZ/Y3SarWLShE4C7E8N6yW2wcMgY/MQrqhqKngT5eEVOh0upxpKUIXBM5vbU4imyh5C4BvbIebMVKo8I/enjSJNEQuQjBu3WuD007VQcjYWRbOvKgqxFO08LltRHJwiZJp3prFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W0xm7JCs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LF9oJu026154;
	Tue, 21 May 2024 19:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=nZuM5wFSsss4g1FMYAGG9
	HP332Eng3D3fi1g85v+vW8=; b=W0xm7JCs2OpfXRlrdSE/erqZ0i2Prsuk6I207
	mfU8vv8gNPFSyXzlFAiK7OVuESsQyBpzUA1vHP4oiINET1Aa4AX1Ce/HFQjhz4ia
	j0PNqNlTZRph5i25ytrmkzFTAkEz+sL1OMTJAWmQEPBZkdxvbw+X0iVLiM11E6Bm
	eS8pjubf/Rlc8HuK8bISK1wlDWEOZgHz9Cr7bgEu56IBveuNi5j9/VnvwWqq9TLO
	wCnIV3LZFOb9+QajBZUdpMvWtTRDjWrySlXUWCWMW8TB1ClDYwkgDqi6WQyZdY9O
	1YavNp3AAGm1F3t+Kkd75aLGDLOmtOQN43411FnPeoJqMkESg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqc74v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 19:40:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44LJeNvI013710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 19:40:23 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 May 2024 12:40:22 -0700
Date: Tue, 21 May 2024 12:40:21 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: <neil.armstrong@linaro.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic
 Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <wcn36xx@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/12] remoteproc: qcom_q6v5_pas: switch to mbn files by
 default
Message-ID: <Zkz4pf00lYCx185i@hu-bjorande-lv.qualcomm.com>
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
 <20240521-qcom-firmware-name-v1-6-99a6d32b1e5e@linaro.org>
 <a314906d-b297-474d-910c-6634c8c23042@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a314906d-b297-474d-910c-6634c8c23042@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3gCDzfA-TlFLM7-69lgS-CJjFqRAVhLw
X-Proofpoint-GUID: 3gCDzfA-TlFLM7-69lgS-CJjFqRAVhLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_12,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210148

On Tue, May 21, 2024 at 11:49:42AM +0200, neil.armstrong@linaro.org wrote:
> On 21/05/2024 11:45, Dmitry Baryshkov wrote:
> > We have been pushing userspace to use mbn files by default for ages.
> > As a preparation for making the firmware-name optional, make the driver
> > use .mbn instead of .mdt files by default.
> 
> I think we should have a mechanism to fallback to .mdt since downstream
> uses split mdt on the devices filesystem.
> 

Let's ignore and continue to move away from the split .mdt files.

Combining split files is trivial and removes a class of problems where
people mix and match their parts. (And worst case you can rename/symlink
your downstream firmware to match the requested filename)

Regards,
Bjorn

