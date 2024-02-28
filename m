Return-Path: <linux-wireless+bounces-4201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B2E86B28C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 16:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053771F27EE2
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8515B112;
	Wed, 28 Feb 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="az5Z+rvC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78515B10D;
	Wed, 28 Feb 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132406; cv=none; b=MTLo6h2Qjm4GH/lmu2wndNV9biJ/TSvRJdC5d/lyu3B3u//lG85Ccdt064nSZ+MOR0OrEn2VnAYfU4mvQhT5Tjqg+OlS9UbUDzD9sZRWCtrkx10qLQDYoq1bh0csb1IWIDbKtRExp1ppET9Tg1iDrWxXHhcqN8Rs/NFiLoSLO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132406; c=relaxed/simple;
	bh=LolsVB0Zf2W7CZjOv+Yh7zbYkWss1NhXLWb8MwxRpDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hm+Rm5uw4I9Z9IGOr1RlpZPFuh6+O4p57oBFLRFWRXvCaPuXe4q14SY/3yYQ7ic+OlnwbW9KTqc6giRNU4q0YRuFDFetS3sXHTZCRlCUuLXHdF2nVF0sy8EkMCpUjBdzYgJQH09HB8GZGRlvPsRKyHnT6kTU1CYr57CPTa6Fg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=az5Z+rvC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S6uAST011443;
	Wed, 28 Feb 2024 14:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LolsVB0Zf2W7CZjOv+Yh7zbYkWss1NhXLWb8MwxRpDI=; b=az
	5Z+rvCYSDxZUoUJ1smPh5SJxULsMYpVAg4QzAlRejJx7guKxaTEFISZJWQaNWZgm
	vqdnsRf+M5gQugBhX9U19wpocIlLlOjZ0kXMWcemCS91oyGfLCk3oo0ospIbJrDA
	3n41ywyq9cFM1d/oPTe7JU+5Uo7JU9/nNc+TK7bbQMHQbGy5tW5vXS4UGdpCf9LV
	OQnwZLNBhAAHMp4vEIjzod9hiWVuOxV/mdk35r+LTqaw9K7zIoXQ+RdCsq/VYvHB
	jT1KLo50qLt6769dQtlMSlxQURxIpmVwD8OiFypEcxg0yhKDJRcfjTwjXj0ynSE2
	8LNouOZlXNdqLkjgTcag==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whw3f1dyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:59:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SExuIa018876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:59:56 GMT
Received: from [10.110.113.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 06:59:56 -0800
Message-ID: <d8c90f33-d0ab-4d73-9580-2547446671a0@quicinc.com>
Date: Wed, 28 Feb 2024 06:59:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
To: Marc Gonzalez <mgonzalez@freebox.fr>, Kalle Valo <kvalo@kernel.org>,
        ath10k <ath10k@lists.infradead.org>
CC: wireless <linux-wireless@vger.kernel.org>,
        DT
	<devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Pierre-Hugues Husson <phhusson@freebox.fr>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eQA6F6l0b66UTTMGn5Y3RbOoHFn92Bkk
X-Proofpoint-GUID: eQA6F6l0b66UTTMGn5Y3RbOoHFn92Bkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=789 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 clxscore=1011 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280118

On 2/28/2024 5:24 AM, Marc Gonzalez wrote:
> The driver waits for this indicator before proceeding,
> yet some WCNSS firmwares apparently do not send it.
> On those devices, it seems safe to ignore the indicator,
> and continue loading the firmware.

Can you list the product/hardware/firmware where this is observed?
Would prefer to fix the firmware if the issue is there


