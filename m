Return-Path: <linux-wireless+bounces-27985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F10BE10AC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2F919C1E77
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 23:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F88318129;
	Wed, 15 Oct 2025 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0DqI0ja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2233161BC
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571630; cv=none; b=iTOvKTih2eDG27zPe32NmSamsQeyHduvSe6fEsK/HWpBKRBG99Te1XY5ZiRMcyf+t6mOHpJ9OuiWNMzWQYYZlPmXEy2hjtOdqEzM57jezIz653RZZYZ9eMDCYCHfPuWaJZHduheR1YnSiwR8iJhiuaj9swVSI+GcuLYrGT8x9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571630; c=relaxed/simple;
	bh=WyFOYOvbmHYUnwTSNXaEf0uvVOV58ilDJGCX48Q5FS0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bMcAeYirGr55gLYTwFPXOiBr9xcEsFDKW5pe19K3sHlGByArCdP311Bxq8WgP2V74BC7OXojO1hsfvEY66l/W1IoLTflE9hnoI7MjmDAfdWI9NOwQHFyMA6KNC7w/rovkdLQqMwNNZ69m2OWYzQAy1Uo7vlSfBGWNZRphFNy6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0DqI0ja; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FIFN6H003404
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M2y7DvilVSsIpj1n+xs4x4u18Kici2xqROvNnjvsjBE=; b=T0DqI0jarZ1dLMzQ
	+w7OfiAM6p7N9ipl6ZzVwpd0QR5h7j6c0FQZc9zDShol0a5F+vDK1Rc2Og2i193F
	oQBqBteRiTAzJkLiwdO9xIU1SY7QDHHtE7+H1a73L6O2IdI4ATzMVqq8vbN0+DRy
	Q521YaInCg3o9LJwlX4/IVxdsJKV9tvUKcImzUkHVNOZBy0n0cVRNwHNgYHJDBBU
	HeoZHBiKz9uFLKwgw9TP4yOrwawqMpCgmZHts4PEC4WyV2Vvg87wGUrwaIbKKDkO
	mknLuWNQc9Ya9Cm4xUUeLAgiUQVqnla4Nr0PxaB5nvHVoQD2/tn5JPvSyz5ctu4Y
	uSxPZA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8mwm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26985173d8eso2668525ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 16:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571626; x=1761176426;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2y7DvilVSsIpj1n+xs4x4u18Kici2xqROvNnjvsjBE=;
        b=JoEoq5E/fh6uy8dAinuz/wSLogQN+Jwt+/pTBhTHBnw8hq3Lf02Kl+YI9uE4hW41s9
         /lFbVsUJQ/4U3UvlDr4hl4XKB6Yt+7lsmnIUWGKsg0Xwa+yBSYfTk58pMCqzlWkAkwRk
         il3ZFjAsOZOVPFHtWcIdmJ6Hck5A9PjA1b8blzB1AWF/hPpf6wN7aHa7eySfMu6yW4Io
         /xvwVRADt1QznsqmMZUYeDc0GQ1Tk9Z2mGtiO/Q5Qb11sCzXeIrtdZplRqQ1wY6mrxkX
         ckur+St7u42yagljnDsGbqC/pqXbwcRTXWnN/USTFJkzaILU9glYwvuJX5RZ82JuF+AS
         d5AA==
X-Gm-Message-State: AOJu0YxWz2KzTEaQZYiMvtm796UOD2jwGPOTXCLTrZ6z1pwsw61xnC6u
	KbUXaSNVZg0/qkxFAcEQKY6mU/DRWF+zR1k2vFliDsMFMEHZUkVZVn/RasekmadSV/wL2+PrwjN
	XUt1feNEK4O3Ox45nyyUuGD915USqLXZtA/PkhPe0StBlk2arjt0PqvvAVbB2R8W4eBnde1i7ff
	gu2Q==
X-Gm-Gg: ASbGnctQEIRWGJejsBhX35q/R2QJlAP2c7c6Ym5dpb3oxDNd95SFVa5+DKyjauF1euP
	xBZ/ts9bmNak285KFYgLBGzlhSOEx8Q/6APG2OycexiIq50cgULan5KKnsKGKnTP6RNbG0w1bcb
	ZqwjIHrKWuj+9+ql5U3YIdCPGqt/Q9rVCUC2GXeiJrGShpZRYB3JzLaGRdvCuASGH4Idi2IC1zl
	YfLUGx8tv6Bd5OOyValpFib9kO8fyZVWAYwo47QoLP6NzsvJzpNgRtssUCksWe+bXjeVlu6iJS/
	Vn+gr+fk320QwC7tKu3Myjd8ijZ+AIAHVaPxg3kTiZo3T//8NnAdstlBew2YnMxITcN9S2sl2c6
	SkKiuXOnLn0s4VjmxiiUyuurYm9AlIIq8xs4=
X-Received: by 2002:a17:903:3c30:b0:270:ea84:324a with SMTP id d9443c01a7336-290272c1898mr387722005ad.38.1760571625754;
        Wed, 15 Oct 2025 16:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH/RtVbZvlZEuWFJGvIgQ26gYvjD+I1WmAco+magWc/UkmUXCHWYCnn1m7pgJPkBEYE1/vRw==
X-Received: by 2002:a17:903:3c30:b0:270:ea84:324a with SMTP id d9443c01a7336-290272c1898mr387721885ad.38.1760571625355;
        Wed, 15 Oct 2025 16:40:25 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath10k@lists.infradead.org, Kang Yang <kang.yang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251014110757.155-1-kang.yang@oss.qualcomm.com>
References: <20251014110757.155-1-kang.yang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v3] wifi: ath10k: move recovery check logic
 into a new work
Message-Id: <176057162473.260563.11516806197165920162.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 58c_mgTt3mcG8MQsXiNYBhfcpQuqiwMd
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f030eb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3obmPjyOJz7ZQHQ8r5gA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX5/Plyf8pbyAW
 DMBCV+CjpWuU+NxdMSJqEm/E18hX9yJXaXRoIe/VdtxjidqWYezN086u445y/nZ8Sf2/rt7dCi1
 lDElog1ExBAjLJEaltMy9Cze/bA3uRdOhqFXvX4m5ZyTund/+JqM9PUBxNwzu3YH+S5taqSrgch
 YELFmz7V/bY5kAtXUXlNtRktzuEF6bS33P/Eprc1eHYyjf0ZjR/Tg3LtUKBmsSV3QL8kriqgFTq
 xPdhIhOnFA4kaNognVBCpeXy/qvW3/R0uw6qfLBjBqjSXILMNz1hXV/BAF+/iyrt4XEa0JaQGIm
 z2HjA8QxCKi8KirpD/EP6G+U0hRxnxq80qygGnZXucjybdoeZB0QiVN8qF3igl2l5fgd/aicQqs
 E4VTzCxvYmYCYLtI4totOROaqReepQ==
X-Proofpoint-ORIG-GUID: 58c_mgTt3mcG8MQsXiNYBhfcpQuqiwMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134


On Tue, 14 Oct 2025 19:07:57 +0800, Kang Yang wrote:
> Currently, ath10k has a recovery check logic. It will wait for the
> last recovery to finish by wait_for_completion_timeout();
> 
> But in SDIO scenarios, the recovery function may be invoked from
> interrupt context, where long blocking waits are undesirable and can
> lead to system instability.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: move recovery check logic into a new work
      commit: f35a07a4842a88801d9182b1a76d178bfa616978

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


