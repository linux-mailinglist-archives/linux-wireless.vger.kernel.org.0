Return-Path: <linux-wireless+bounces-30229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02ECEBE76
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 13:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA3FE302219A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA1321420;
	Wed, 31 Dec 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYYetMHs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrKX4M3N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3BF21C17D
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182887; cv=none; b=JjOa5Odmu+fHru/4kfqbd8mUpK2QFsBxtQwliJ0qECVGtzCV6HtCYGS3UUXMeFJyaKOcus/9uP0nelPAXrPyPZ4vM8XjuNeTxIrgG8FL3/dcWjP8P92HRDRBUzPK+q00NGaI7d9/zOxizQdcYIcAbft0JTUn5TZJI0oNOJjp9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182887; c=relaxed/simple;
	bh=UmgVRndD2m6Wy75Clz1eg4Rh120+PEWhxXfNEPFzvJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJx7s+ToHxPQofY0r4xCkBcpsgCdd4KFh4/+5IN47j3sfjYrru62vnn/L1S9R7pOBUAapNE7z9ZXzf6EFkpgHly1W5QuRhFL9B4uJloghuC170vd0J30jOkLh/+58N1SCGKVZmY0tWIwdzoFFBLMJwuspCnBuIvz/Y1hwMe2jPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYYetMHs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZrKX4M3N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV78S8f2733277
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UiJtaHWpT52Ir4SAEeA1tuRYvR+ztp79Uz63Q9MOA7o=; b=JYYetMHsA9nLPALh
	XQ8f+wUf9nxQMuIwnd38JtG7hDZLzN4o4+TD/ckycxr+7gQaMLh50EIYQKZ6oATk
	qcll+ywSq6o0u/AHb9VB99ttFSGI3DUhoa8R31nuG4UeSmyecQ4+sHfamSDb2oh7
	LIjvbTcCuZTBVs6wArIevnxz2V03nrzDOuG8pddkbTUTiq7OfvnjZ6EAroF9TAMw
	XdYPvKFGP7jWjy8WS7i8AGO9p1sHEpzj14B6PcjsKtB0hXURCwzqKuXTcoJAOXXm
	psWe8wkK+kOx394c7HiWsu5MF1nkkvBcWBg1ArsyrKiYAAibjHW0/kZdckgMsM/Q
	TWuPbQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcy6agfwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:08:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee23b6b6fdso27737611cf.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767182884; x=1767787684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiJtaHWpT52Ir4SAEeA1tuRYvR+ztp79Uz63Q9MOA7o=;
        b=ZrKX4M3NP/+XZkHQ43VEno7s4099ReUYleOwtEVL4R0+sZVH+JSt1Igb13nbsvYtsV
         y00VuPZNa7rJOgPMTQl1jq6LA44aXkh2VQ/AS2cwHCaBgVdgzyoEe5/EZYtb+CbIpHOm
         aPIzcfBY9xCTQwcSIgCHAs6iDw+0m8xqzNDzd8v5XYmxknWyww6MvzPiSU0lC3e9DpDe
         fK5lhHA7z5KmDeLCQ2ff31vfrpUqI4YBBghiy4tQ92azyjLx2C1XGdzXGhuQ97wRhwzK
         AC+SfXbjn3dNsJoJmkSLlOuUAKuaBGZNwqfr6rd/E8zz6/gurORPDL8SZuUR8g09JYll
         QBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767182884; x=1767787684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiJtaHWpT52Ir4SAEeA1tuRYvR+ztp79Uz63Q9MOA7o=;
        b=mw2XXRPlpi/rhTUZEmbmIvlLgiUse5QIOoFX5pssZJET+f4TnRX1OefJ3BNpX5403q
         gRGpkrNJ9iOKs/2jtS2Zc8bTRWTWFooXCgd/5uWo8sK6OoyRjvUYMlYtwi/yWm+VzjWI
         7qW1K+nsHlMQTmRIArLNiWCDXCTP12YHJLR/WcWgR1xfL0c+4FThVQ2A3bQOp4K1yGnV
         fnDkNg++w0T1d+exfrDynUa7253LO+IIq3zVNHuYJxlXjnDFS80cy1hcnCx6MXdVCLXp
         /zn2tKuFw+pA8kRpCwNZc9VRjxgLF2NkgYhqN/lYVQ58LC6WzlOOM2OxUlZT9I4mnJoC
         bjNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqwqd+aXV+bFJolDg2Lu/4N4tP84ZwdJmNW0+L9Tr63QBd/dNpD/ZLhqrhkKFnXWwc1UFk0iUMkj8lcOSV5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoBxLP8KCjsWkmkBN59cMwOLTmigq1GvMmYHX4mqQtJeuJIFsg
	89788ZPZPlqoJtZb8mEgXIZ+yKGkGlHa7P5ZR2VWNy52duVtODoCIqhJJ8us+X8bK8aE944reLZ
	6N8kQO99z9gs35pCnf14+8SA3C4Gv/Q2DDk/m3bxXkG04dF02BIxvwQW07qjseI5i6h+Q5A==
X-Gm-Gg: AY/fxX6BnK/OtjAP0OUilrnv9RJ1EyRzzBphUdps86bd+OdtkqhBc7Ovp3cRq4NhUxM
	U9/XpiAuwEXfPkGg8lcU3sz9uYnpZT6lR0PwCJXwrrAI7T0zUuvYcgnrd8Zq2FOF/18VlCw9m/a
	U9vW8BF26kDsk0NpeXl6v/W2yWJ9mlmCzhUaTZOzaGrbc9bTtDEDOQEIWTYVtnwYkytsfHUTLIF
	nuxyU2wZq2yQgQvt+kkZolK1RWKQ2iTGlY/E/U049fLT9SSJk3J5XDfK97SOVcSkSaQpdisJzTp
	z4geEsVrcG5fEovpdXpHvnFIYh0WZc9MmjnzkEIcA0vemqMw1gMi+jAp12WXUmebmO0uWXef07+
	mM3Uz2VKrxt8SQOisysiUWLF2QKw/9R5TrsrJ2HFlPfonAu6x5uJF1kGQaONB3Ay1qA==
X-Received: by 2002:ac8:7c49:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-4f4abddcae9mr410146851cf.8.1767182884082;
        Wed, 31 Dec 2025 04:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiPNC0oH8EFPcBv3otDppGjXcWFCcR/VT+vF4VQNNWa4RvyRS8nRSCSTA96lyQ4NSKnYSHFw==
X-Received: by 2002:ac8:7c49:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-4f4abddcae9mr410146421cf.8.1767182883666;
        Wed, 31 Dec 2025 04:08:03 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6ebsm37604637a12.27.2025.12.31.04.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:08:03 -0800 (PST)
Message-ID: <83bae671-3174-48e3-b9f8-412d21f8f18c@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-7-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-7-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: P3AchpEIdMwenmYX7Yr6rxTDKbaiwlXA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNiBTYWx0ZWRfX6hDz2I/J8bb1
 lI2H8Ek+LHb3F9XxSSkgn+YjdEDfFSJKkFsqwuKSK3pYv6SW1JYht/pF85uKddDyJy2SLgUhNXv
 gWLJDrHoakLLIdljbEsv8/lxmw9blchNbd9JXbShPMeDpj9pkYSFdFgo+6DEOUXsm8C/E7W7jJ+
 z3fc4CzMKDPpZwqsQXVxUHInjWMsB3vbAcpOMmI/xPZHil6SmMvzA9ALYxOxEK0mVqP+/ELIgaa
 uZZr2fRduZuGniYhz5P3vCI5TGrAguvFykxdofosqayjK0a+lll2eA3r7fdiydq63fasDKWlNVC
 2edohiVZDZjyOAWBv9mgem4Hi3HQu5AxKSf8L5EaWXOwB62x0b4/7yM4d/2n3giJaEpiEh5IFWH
 n177+jdKlCazr+0GpGpF7LT+IgXmWIqQFcJS/27xYeaeb72PBSuRwTbcz5kktKsRrkqIYCwTGWe
 NKfOe/IyqQjz6sjoORA==
X-Proofpoint-GUID: P3AchpEIdMwenmYX7Yr6rxTDKbaiwlXA
X-Authority-Analysis: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=69551224 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wl_8aIJEU-qjyxFuvXQA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310106

On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> On SDM845 SPI uses hardware-provided chip select, while specifying
> cs-gpio makes the driver request GPIO pin, which on DB845c conflicts
> with the normal host controllers pinctrl entry.
> 
> Drop the cs-gpios property to restore SPI functionality.
> 
> Fixes: cb29e7106d4e ("arm64: dts: qcom: db845c: Add support for MCP2517FD")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

