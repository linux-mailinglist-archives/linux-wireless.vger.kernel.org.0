Return-Path: <linux-wireless+bounces-28801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1E2C47C56
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593DF4A2848
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5C279DC3;
	Mon, 10 Nov 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kAg4Twto";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gJuOdQh5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9327A107
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789925; cv=none; b=J7NrABqGmz7LZoOSYZFTelxMRx/2FWqzNx8ij3JFqJ1zDuDqYZldfJsD7kPK/xBBMtuUZKoJwNQVCG/VG0f4ZuHFo/INaIrz/TPrHVRNQLmEp3LfkCyRJaWdQ6LAinmnMMDI8l5sVkDx9pJTPfDuDLzughi/MXmmy/PNQXV66f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789925; c=relaxed/simple;
	bh=zrDzbfE42ci9l7A738ShCqn0qibMkCiFFfa6n/yGOU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nce7Ka1NVpaFSgS3XOHu+bWfycxW798mj4dN9R1syqockASNPW2rykDLklFUn28Wx66jleQDxpC4Kq5uhFPkRzOhWHArCG5mRkdrLZthyAzLjpGYGizh71ZSf4oN/KpUW4F6/HdbqRNXvBrYehA9/04tVeahgVGkHQ2wVNN8XAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kAg4Twto; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gJuOdQh5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACRjvk2408439
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 15:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NCoKBD4Qjvh74ye/aYs598WKJ3COZ2RaZcQENxaxf1M=; b=kAg4TwtoK+8hjeLl
	2ybeWk4qWEwF9c/WJA48VDUaH928bx3q2VWEa4pMSaHdP6pke93WbE09P9pw0X7v
	LzRE8zoWd4m8wSDzzOLIhoWZ2Nvg1yStv7b5XC+JCpNjSrO9/ofyqYq5ioVCygG7
	A8LHnkcC/CDYt1rbRCMlFNnnL0wxlRS94NOFbQJ5qP8qqOfzpb6+RJPUVU+KRpNP
	Aid2tcCX1dufltyf/WCGt8LVoc+28IkJwBjNQ23L3NQ9+ohmqHNH35Keuyvwd6/X
	sp/H9BG9P8WWIqqRVNrKyGcsJFT/U3cLRWLbfRGaXywwluRiQDvlw5yiCGDoQ8QH
	euwiBg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd9pg0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 15:52:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7aa9f595688so6185954b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 07:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762789922; x=1763394722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCoKBD4Qjvh74ye/aYs598WKJ3COZ2RaZcQENxaxf1M=;
        b=gJuOdQh5knqI4sUVrYEJx/zl3bkS7PTuequkcVuH4j/G34axhic6AlReD1C8bRxLsS
         5IUqa2rIX6C0nSvgXj2KBRNjb6btMKTEUS188XU2XitnLrSJGKY1IDdQBgdT8nHqmDni
         I8PJTRbvs9dffLP/W6vLlMaqbITgD337CeEuy7BM8wrogtrdCJ1Mxht8qdR9F/grA8D9
         3ynlR3hDK/CFa5cRmdul2pjGpsPkxMnG7l4hFD8bo2md7R837grPxaV3zo55TULc+iim
         Rdutj9jYN4lLxTnOsgJ2LWYk+zEM4rT1tt1gg5/FSyaj1l14QpwqhD+eRJ5M5i7PCcZf
         JgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789922; x=1763394722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCoKBD4Qjvh74ye/aYs598WKJ3COZ2RaZcQENxaxf1M=;
        b=pFg4SlCKuu989ThKicwFU9tQ0uPllcdM5g9jeWFIlSsLczoeWzgP7ma7zHEZ2JfNHg
         d3ACeeMEimN3iYfzrvG2zo01OL90uNJgYj7ekNdZgiMSXoM81rbVm9vtO0OaSQqIRT86
         Xq3hP5IMZWjYVMDnqHP/IWzlNo5irZ9yimOOaXPHPmYJZGEi190/rFAiBXzJiJe9kJtJ
         xIgYiohE1t3lc7yvsiP27SyEtKQiZBl9AYnpC33wn4uy7Z8uH+zqkU37w1ADvemxJ0O7
         Of4X2DEELY2eyXJfO2qIfyrNNG0y+fNZMejEIOfgNLejnqJVD1LxCLyKrxxU+MFRO3Wi
         8Vsg==
X-Gm-Message-State: AOJu0Yx29uqLLesMlbOYbcxNh7rh5B8mwgVhNMo0eNxxJPm91Co/rmC6
	Evrlf8uh8tSRmlJq2WKzxzDo0GU2ob4Y3Hozog1s+uFviRB1YIvOi4ebTta4YQ7DPAie3lYGgF1
	aXjEmcQJUniyA2CznpfCcdCIIx+rqMUw4/gtKFmDUrDt0WbNiBt/8asGP65EENsAKiGV8vX/+Mt
	bxSQ==
X-Gm-Gg: ASbGnctWvYiVNEVT175/FTkCTebYbEahYGWHVIT1rwNm/7W7x0bnOiHRo1nH41WuSFZ
	5hPk5i4xqViMF9NviOnpY0EgVZjYlJxvh+LY9L/zwYtvbf8GJhE5SizxrN+ioufloqewo3jv6iG
	aFQd3jxnWvbogP10avnU/isFHX7u9qK3jtDM8pltksmLsSLCKAV31Qmi4h7OppEZCuDU+t0SmKX
	/j+VTkbthbWLYwzd9jPQrzfEgH45pctR/wzJArU7pbqbRxREToIRbMQrL9WOrLXGs/ffuEnQSko
	vdn9ZZAULRNl6lh5C5dcaGWDGK5BEjTrFFRdYsUauNXhLuFLcFC4RfWNLY2BipzAKKoxgrSzuck
	KUMndbANfneuAq6gL8IILcU8xFLlKl6g2X+RomMAsZCWPLxNRukE=
X-Received: by 2002:a05:6a00:2d11:b0:792:5db2:73ac with SMTP id d2e1a72fcca58-7b225ae08a9mr10984487b3a.7.1762789921763;
        Mon, 10 Nov 2025 07:52:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEeakJN5Qfs3AlzxqMzv75PYWCOMZd5H380WTJ4OIK5FYGQM/w4T/reySFWpmIYE3VS6Dd5w==
X-Received: by 2002:a05:6a00:2d11:b0:792:5db2:73ac with SMTP id d2e1a72fcca58-7b225ae08a9mr10984445b3a.7.1762789921168;
        Mon, 10 Nov 2025 07:52:01 -0800 (PST)
Received: from [192.168.225.142] ([157.49.194.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953e791sm12561248b3a.7.2025.11.10.07.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:52:00 -0800 (PST)
Message-ID: <a97adb16-8599-89b8-9739-d0266ea16233@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 21:21:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath12k-ng 00/12] wifi: ath12k: Remove the Wi-Fi 7 header
 inclusions in common code
To: Alok Singh <quic_aloksing@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SJY4YQll95whQHP9mEu3f2xdDTOQN9DV
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=69120a22 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JZB7jehsBYXywv9cSu3mwQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rApeeKJKgo9SdP4gWbgA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: SJY4YQll95whQHP9mEu3f2xdDTOQN9DV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzNCBTYWx0ZWRfX7vZdEcQhTuJf
 UWrjh6/H8hLwlOlOljWau/fNaMYSBrmSYQcBkM5iv81rzi9jz6dSUKCfZE/5C1TYp3r5Q+grm6A
 dch3MDoLJ555TaAWY+e5UXSEjEmLVeWs5ioFg475EkGeh81qvngOOsZPcjJziKOA4PuxAM0AzvG
 ugPIoKCzhRJ+PdzT7QL5sZ9wEihnLWXMD9bLyMf4r+hZ0DG2jFmZuPy/omx/9DA7k10p9RePoKg
 spph3hR5aXO4CdD0oy1l6OU7E+GW7s97/f3yHozhpmUL5j1ndVlEB8nO3E04NK6fXdRawdTnPPn
 hgys+VtmmG1yFq80ynqKQUOK9ajFYEvhsmf6qPxP/dsxrLjlfWjfiAkfaedog+mAvxIE98zwhug
 k99B7s1Dn2UaklSTobDNggMwPWqmkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100134



On 11/10/2025 4:07 PM, Alok Singh wrote:
> Idea here is to Remove the Wi-Fi 7 header inclusions in common code
> As a precursor to the movement of Wi-Fi 7 specific .c files to
> ath12k_wifi7.ko module, Remove all Wi-Fi 7 header inclusions (`wifi7/*.h`)
> from the common `drivers/net/wireless/ath/ath12k/dp_mon.c`.
> The common monitor functions now compile solely against the core
> ath12k headers and remain part of the `ath12k.ko` module.
> Move Wi-Fi 7 specific monitor implementations to a new
> `drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c`.
> This file is built into the `ath12k_wifi7.ko` module.
> 
> This patch series refactors the ath12k monitor functionalities
> into common and Wi-Fi 7 specific code.
> 
> The series includes the following changes:
> 
> - Patches 1-11 move various monitor mode processing functions from the
>    common ath12k driver to the Wi-Fi 7.
> 
> - Patch 12 removes the Wi-Fi 7 header dependencies from the main driver,
>    completing the separation of concerns.
> 
> Alok Singh (12):
>    wifi: ath12k: Move monitor ring processing to Wi-Fi 7 module
>    wifi: ath12k: Move monitor status processing to Wi-Fi 7 module
>    wifi: ath12k: Move MPDU pop functionality to Wi-Fi 7 module
>    wifi: ath12k: Move RX status TLV parsing to Wi-Fi 7 module
>    wifi: ath12k: Move TX monitor functionality to Wi-Fi 7 module
>    wifi: ath12k: Move HT/VHT SIG processing to Wi-Fi 7 module
>    wifi: ath12k: Move HE SIG processing to Wi-Fi 7 module
>    wifi: ath12k: Move EHT SIG processing to Wi-Fi 7 module
>    wifi: ath12k: Move remaining SIG TLV parsing to Wi-Fi 7 module
>    wifi: ath12k: Move MU user processing to Wi-Fi 7 module
>    wifi: ath12k: Move MSDU END TLV processing to Wi-Fi 7 module
>    wifi: ath12k: Remove Wi-Fi 7 header dependencies from common ath12k
>      module
> 
>   drivers/net/wireless/ath/ath12k/dp_mon.c      | 3474 +----------------
>   drivers/net/wireless/ath/ath12k/dp_mon.h      |   62 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.h       |    9 +
>   drivers/net/wireless/ath/ath12k/hal.c         |    2 +
>   drivers/net/wireless/ath/ath12k/hal.h         |   33 +
>   .../net/wireless/ath/ath12k/wifi7/Makefile    |    1 +
>   drivers/net/wireless/ath/ath12k/wifi7/dp.c    |   16 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp.h    |    1 +
>   .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 3354 ++++++++++++++++
>   .../net/wireless/ath/ath12k/wifi7/dp_mon.h    |   23 +
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |   19 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   11 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |   19 -
>   .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   15 -
>   14 files changed, 3570 insertions(+), 3469 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

