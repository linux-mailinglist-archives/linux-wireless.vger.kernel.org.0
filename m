Return-Path: <linux-wireless+bounces-5775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC004896039
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 01:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7097F1F22B55
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 23:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC5F47A53;
	Tue,  2 Apr 2024 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AbymXxdW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B89446B4;
	Tue,  2 Apr 2024 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100794; cv=none; b=frmipbX3PQKf8xi6nD3y0f6rls8ekr0RjdMPkTF2aHxo6/pAaGEthqcVN+L9oo1g14ugaREqOwESyw7DQiycggIzpESCguQFsdlXG8aToAA0xtXvZqCvUMw9YCEa7VQTSL4GIk7hpdJLyNj26AWlo/8+9pZ0mRTaKrGK5SZZs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100794; c=relaxed/simple;
	bh=dmMF4p+71YZrfutNuzYmJB/lRK2vYnsYZ3KaWK3lPw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mWF3y4jPVgBdoWe2QGlaP0qtlj0ucmH+02riPonUSDgdsXxtMMB83TUXJwuuy96bc2lW90KfOkUKnOacTV6QzqSlp9ZIrcGGhGpcPmDUIFPpmGFSFT6xpirgua0E83nHxDsl8sFHqTZz8ZqbD+yAcE8AlI/4/6HrEv6PoLSBxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AbymXxdW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432M5f11017738;
	Tue, 2 Apr 2024 23:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Dq/2zyRgNp7agCJe7ciPi9uTcrRLuLxBc90vyXjgJHU=; b=Ab
	ymXxdWVu068MRS5cyLxm/WTIsojYqJ/QEDV2yZTibnWOWgacU4cCVT8W0AJ8n8mu
	QpHGvDThOXaDzKH7Z4rA3RweRgxjAvEPJJfqx+6B57vZgwtLykZUuFluoiWmbqwQ
	y3aE0tf6PiVJNUzuFQqQIeJVSLpkRHL/epFEErSgYYYzDDmxoVCTJbw9hN5VtWef
	vcJWwadJD6fhL1YAJqoUxKkvhydYHmW8/o/Nk0A3Gt28hlEwtMHFzl69cMMPOna3
	Kw6ryY/DbwoDDyBJ+A4gc5JzZufhx2pn3hTiPd+4xG24p1K4AWtTL09ww2m6jMg0
	GA5PapynXWGn2WQDWjUA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8fm1t1fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 23:32:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432NWitc010795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 23:32:44 GMT
Received: from [10.110.49.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 16:32:42 -0700
Message-ID: <ad88712a-e4dd-4a2b-ba9d-a42ebb39ad4d@quicinc.com>
Date: Tue, 2 Apr 2024 16:32:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
Content-Language: en-US
To: Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Marc Gonzalez <mgonzalez@freebox.fr>, Kalle
 Valo <kvalo@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        ath10k <ath10k@lists.infradead.org>,
        wireless <linux-wireless@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Arnaud
 Vrac <avrac@freebox.fr>,
        Bjorn Andersson <andersson@kernel.org>,
        Jami
 Kettunen <jamipkettunen@gmail.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
 <252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
 <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
 <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
 <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
 <8ef4f56c-83a3-4b26-877e-f1c7a0307e98@postmarketos.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <8ef4f56c-83a3-4b26-877e-f1c7a0307e98@postmarketos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5v8_kRfp8Tj9RdvM-4QMKiVK_hdZiaff
X-Proofpoint-ORIG-GUID: 5v8_kRfp8Tj9RdvM-4QMKiVK_hdZiaff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020173

On 4/2/2024 11:25 AM, Alexey Minnekhanov wrote:
> 
> 
> On 02.04.2024 18:55, Dmitry Baryshkov wrote:
>> I'd say, we should take a step back and actually verify how this was
>> handled in the vendor kernel.
> 
> 
> AFAIK there is no such thing in vendor kernel driver for this, as
> this startup procedure is likely handled entirely in userspace in
> cnss_daemon.
> 

So now I'm looking at the cnss-daemon, and there it appears that MSA READY is
always expected to be received.

There is target-specific logic to set the flags sent to firmware:
	if (gdata->instance_id == ADRASTEA_ID) {
		req.msa_ready_enable_valid = 1;
		req.msa_ready_enable = 1;
	} else { /* All targets other than Adrastea */
		req.fw_mem_ready_enable_valid = 1;
		req.fw_mem_ready_enable = 1;
	}

Logic to set an internal flag if the message is received:
	case QMI_WLFW_MSA_READY_IND_V01:
		gdata->state |= CNSS_MSA_READY;

And Adrastea-specific logic to set that flag if it is set in a separate status
indicator:
static int wlfw_adrastea_init(struct wlfw_client_data *gdata)
[...]
	if (fw_status & QMI_WLFW_MSA_READY_V01) {
		wsvc_printf_dbg("MSA is ready");
		gdata->state |= CNSS_MSA_READY;
	}

So that flag is only set by receiving the QMI_WLFW_MSA_READY_IND_V01 message
or, only for Adrastea, if the response to wlfw_send_ind_register_req()
indicates MSA_READY

Later there is a wait for MSA_READY that has no conditions:
	while (!CNSS_IS_MSA_READY(gdata->state))

Truthfully this is code I've never had to deal with before, and I've struggled
to find developers who have the necessary background. The least disruptive
paths seem to either be the DT item or adding a new item for this in struct
ath10k_hw_params.

Kalle, do you have any different guidance?

