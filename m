Return-Path: <linux-wireless+bounces-24890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0399AFBE4C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 00:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9EEA4A796B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 22:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED828D83A;
	Mon,  7 Jul 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QtBukzoe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11CD28A407
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927788; cv=none; b=cqMssWu14cjjA423BEvUUaTr+S1tzd+S5y9L+tqwiFUSh7ngb9QcvNyTfVJQyR2xjQRMlB9e8sRNkX5AeWCW7Y+A1nBOJh19H+fog2KWLoK4mpeOi9XTNhPp2R0PqR4BCNBl+DcFrt76/G3s/pVL4Hf9jW2WIHRp/eWXJE6LQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927788; c=relaxed/simple;
	bh=ph7h/NrSH+g0jsgmevGFDuKWUIgVJoq60XkUnXJaP+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gSaxzhSpKR4kJqjdQjc+N+kk/Fyu/eoBc0S0y6xdMJw85e7L5580r4DwhoTJ789pKf0J0qwwVl8SwsCvDyMN9dd0n0uWGKE/2ZLrwQ9443uL1RXqknAkrd/OP85NYfak5UC9d0B6c9zO+5eS0oXC8QvFXDnV64cMhbgKgO/DwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QtBukzoe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567Jhoc6031519
	for <linux-wireless@vger.kernel.org>; Mon, 7 Jul 2025 22:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dg+Hw0ROdGKV4nVLMkPOMGgTA6Rwtxjku8ZqhgD0kE0=; b=QtBukzoe94hikFj7
	ukY/9Leu5iEb2NpBppi7efmrQmGJCvNK+vQxosyCFXj8U7iOF/mhGuGozyl0/T0p
	c+Ph+i/0sqIh2IM0alJgXVI2cHnAk0O0uvxov7NQ2FfI5iD0yqpVtcm/h/LY2P2g
	Hwb35w1enj9GQytWbYnGnf/WLlfnMRMR7pf8vc1gFFcfzuy7O37eGvmBRkGAMBbd
	7UQDdr1uAEUvArDRzLZhlssTs2vQJ02QQH3l8slf7WztvxkNoDky6x2PyQ4Dizwx
	gsX/NoDbe6PGpgWbciQYUy1T0F9yAaB0F92gUFCCQp7JcbHiGnngv3EQA+miXWR1
	p/VbDQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvtkgpce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 22:36:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748fd21468cso2914332b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 15:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751927785; x=1752532585;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dg+Hw0ROdGKV4nVLMkPOMGgTA6Rwtxjku8ZqhgD0kE0=;
        b=aQLeqirwL9VP9v4i0i/sAyMbrGKs5aetTd6qg5LexEZ96i52KzJiw5IJVcBvPH3naU
         0v7cmZOR5GMvBuXdeL12w6NMBJ1bolabo/YG1jn7mh8hQYOUMC/Mak8JCbcyp5XTSrik
         Y8YxSSDDO0OYYYUXQDZGIvtc6YlSSjCnCFFpAR1Y6skNJ+JFa68RflWBVX4grzIBRYj0
         V6nBBShwBv2dyffwN64bhbZ+fKuLA2eqkZwsBPfEi8ncqRJjCXIoIj2Jg+l9ISCmRM9a
         w10gAz9DRnENWFsB6Af4CV/I7JGW5RtEpChmAOoBiC6eIWUEYH4TuVDejNGAloiblCkr
         +iLw==
X-Gm-Message-State: AOJu0YwCXhKjNiNnaUPQSOm48iAxEU3NUeGOjbZdZJDWijkAYckq72XC
	6xdAs8HTlalx5aySEFy3HE3twbox7sDTt0yD77kbE3xabHbNeZuwzD2sNQS9zcIA4ciFGRmopsn
	GmgNw4p6A5TNt9tMNxeInASwWczMttJmBB+QRnk21L+bwxSyv7v6n2Rz8GIs5wkUNsYOO5A==
X-Gm-Gg: ASbGncuO9Y1F20/31UTk0voy2E7Z7T8aVd3AtgVEsYfSFqBBpAEM/BB6Kw49BoRex0Y
	67FSADcWiu60a7VOmjt+IZFYDaCx/jNwM4uC0TzoOnutNNb/Mqx9dTkYs65/NpWwuAE9tOA55CO
	6t1o4lQo6hw3fPlnZ1PjgpmqySv7j7+qh+RU/qf1G+Qb1ENNwInBJ9bE6s7ssrSx++cnuoMnbFP
	PusAJ6ipQSfh9kwCUb3xmQdYkqM6Wvpd0/4dt+clLRlt/ZZgRkmRkJcmlIgZxg2pGv/Q+XUm2xe
	PSn0BdFwQGLjC7G0vugnEoMfosxte8xjVy3JPdvCKh/+7BUoWpxMfq/LGiY=
X-Received: by 2002:a05:6a00:14d3:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-74d2650ae3bmr671455b3a.3.1751927785388;
        Mon, 07 Jul 2025 15:36:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3B/oTaQPCw3zDRRXcnaTveyZPduDXY+7E1ad66TFZ+VD8PffhYo7MAieTL/tkjAT7Cc/CZA==
X-Received: by 2002:a05:6a00:14d3:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-74d2650ae3bmr671430b3a.3.1751927784951;
        Mon, 07 Jul 2025 15:36:24 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee6358edsm9668064a12.58.2025.07.07.15.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:36:24 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250630044531.3490058-1-quic_rdevanat@quicinc.com>
References: <20250630044531.3490058-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Add num_stations counter for
 each interface
Message-Id: <175192778423.314276.14086433447381611503.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Jul 2025 15:36:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDE1NiBTYWx0ZWRfX3lvZ+ExEYe6/
 A1NQS9Sqy4sdK491VCUncMTsXeAaaPF06WUM0JgwCUQaAE85517RdP5/aAuxspiUEvTlBPnYNrN
 gbjXXfLtN24+yINOTNXua3OBZYcDjX7Xhfvo6lQ9Di/PWRNfgtV37/f5MuIW9dbbaHf4YLSCzhI
 QNmc0rx2MZ1azjeWsvY/lPg551lS+rRyWF97tpB30mncXlxBLiMN+t6Zq205XjWGcu1ziuYCV5M
 G/n71Nj128FPxmVmHhIPVn49K07IthL86mr0NmGN8KS6KwDPQS+SJjE/EyXa+feBKlYR0kbMovw
 OgwP1LpLR4Xfp/m7wM+GJsAkUUBICMM7pIFsnAmLJ4B5WE212E2R13g3RqUlEsuX2gciHSVwSP4
 Gw/+3tvuaeuqev1CTK1xFbDgjD2wrC0cKlHfBUXLvFBcS/L8Tay9GToVRAs+7pU5aORIIGbh
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=686c4bea cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=1wtqsGCssgQoBpRYdnoA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: zRyWCfWPH4AvoFfLfGX7fje5RzdLQSPj
X-Proofpoint-GUID: zRyWCfWPH4AvoFfLfGX7fje5RzdLQSPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=754 impostorscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507070156


On Mon, 30 Jun 2025 10:15:31 +0530, Roopni Devanathan wrote:
> Currently, ath12k driver maintains a counter to store the number of
> stations connected to each radio. However, at certain times like
> debugging, it is useful to know number of stations connected to any
> one of the interface in that radio.
> 
> Add support to maintain a counter for number of stations connected to
> each interface.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add num_stations counter for each interface
      commit: a1bff3d6cc454d65a3a654cd3fcd0c90f1fb45fb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


