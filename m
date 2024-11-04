Return-Path: <linux-wireless+bounces-14886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338589BB93B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 16:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717E3B23407
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90881C07EC;
	Mon,  4 Nov 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B48UBxn8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF791C07D7;
	Mon,  4 Nov 2024 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734993; cv=none; b=KNksEqZ9K0ouoZjWylxhJpN0eeQ1jqc88Qzow4Mz2ipIq6lnvJyJ5uXA9b6oNjXZQSB0p7Iepg5vB4kT35r5kdKyAU77Uf8IGQBnIapR9cvO73jSx6to/uIwx6OtL0hyZOs4LLrY2QWSfxN0XfDIYnhqcOSgf4lEWPwOYKzy9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734993; c=relaxed/simple;
	bh=Se1F6MgZpmXOAauCRrSlWdimqdGEP7AiETjcgYOBfHQ=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=kD4EM3xfnXS6JWiAkrp8RWm8MQAGWbWwDkjvHe4jBU4oMgsVOnEuIFVmHt8JUAUSfW78Buq/FcruAtWV9eceWyXEUeapbhF1PFgoafyqJSsRexxamc62ER2hu1w0FDi+01YRMo0TzkgFBPd6ns9q8z7B1Njf61NvP6h/R7JFZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B48UBxn8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Bu4sG028042;
	Mon, 4 Nov 2024 15:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9gzKW2w6+lRVDrV6jRlI+WcrN4vRWHQhDRGxfD3GANQ=; b=B48UBxn8aIn6lTv6
	43V170guUdvTYyE0xoHReFldTwMQzEaH2eJGsL8e7kiSbDpG90CDpnpJQ29SLdnv
	RftV6PbwWApiSqJlH4HAqGPE4qv419F1OvcuoMjVDyiHtt6em6mEQFP/19tR51ft
	kU8eNODOwzpgaKD9oKO0foqr2xtSBvzEsB81C0Stu89d5YPgDIMMj9pXHIkGRZll
	8FDX/Zb6ZRqyvjUi8bWo1mWTwsFrS62LpzuUM50ANQRLD10Og0OVVNg6pA72+mh9
	xJ1NYHJ9ShNLo9Y5EoNXylZ9PFTy1sjFEumSU9UPEwzQNxvcINV7aHIIVkIT2NlW
	W4yYTQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42p5ye2tmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 15:43:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4Fh4sH011730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 15:43:04 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 07:43:03 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k-devel-internal@qti.qualcomm.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, Arnd Bergmann <arnd@kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
In-Reply-To: <20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com>
References: <20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: mark QMI driver event helpers as
 noinline
Message-ID: <173073498362.2435998.11227075604686826531.b4-ty@quicinc.com>
Date: Mon, 4 Nov 2024 07:43:03 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dx6AFyszWS8nBwhUKUyivxqrNZZ1WWdv
X-Proofpoint-GUID: Dx6AFyszWS8nBwhUKUyivxqrNZZ1WWdv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040135


On Mon, 28 Oct 2024 07:08:40 -0700, Jeff Johnson wrote:
> As described in [1], compiling the ath12k driver using clang with
> KASAN enabled warns about some functions with excessive stack usage,
> with the worst case being:
> 
> drivers/net/wireless/ath/ath12k/qmi.c:3546:13: warning: stack frame size (2456) exceeds limit (1024) in 'ath12k_qmi_driver_event_work' [-Wframe-larger-than]
> 
> Nathan [2] highlighted work done by Arnd [3] to address similar
> issues in other portions of the kernel.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: mark QMI driver event helpers as noinline
      commit: 07826419700d4e7429523bbb4e936df6bca19c5e

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


