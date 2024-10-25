Return-Path: <linux-wireless+bounces-14556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B5C9B0EF1
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 21:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DD8284E0F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 19:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02651212199;
	Fri, 25 Oct 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EgbbVWLU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F0212194
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884339; cv=none; b=VcReC74+YIiDOK7K/NwmVm/Qez8iKyn4WEYAwWF0oC02q0l3rH7Gwyd5Nf7wvpuIhu9Ft+70QsZm9e3YGjsPT4ZKBT2T71wtwA7qZNFyag6BhwQ7j6bbACiEuAmhy/8SenMZ5Bx5f/6A3wAGie9B7FseNYisvfFlmrofW7zzUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884339; c=relaxed/simple;
	bh=mcDHXDmFRSw56yNlDvWTZgSmxvS9EjTKsajGXViqmnM=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Ajc24vLZmxxtCkxgLQhHa3/KF8ufcmQzpkayGUa3hinDAAsMPGSF/rLu0+0Qf5JlmyoANT1FURjtUaGYLc1UmJigIGI2OEiiF1pK6z2zq3NzLc61DfvS+q60QesE3p51zmltYbX1PXzOXHo8VcBDf2nCyChTyv01vQ4nO2m/mcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EgbbVWLU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PB2H54001156;
	Fri, 25 Oct 2024 19:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p8x3WVkVoyIe5L83o8I4+/CGXpddJbCkokvyFk5WPck=; b=EgbbVWLUkIDjOyPA
	+8vTJRYSMNd1thxy66cj9XgQHt/0q6jIkbCPJEwAP3M1tYoE0CJ/z5ypJfuF2/c3
	X97HNHZF7iv2VeWjNkkqE1Dj1CK8Fz8CRYU0DqWNbzRZb13q5ki2jJt6leyMtoPm
	VoKiic6aNi9nDyLWZY+ZaRumM1cc8HohJMxujJO7ewBfROtQmpEWJ1DCXp6x1rLu
	DAhYKiEuq7HL3Pr5nhj4CRLaLCzF+b3YcCcGuWXATSTmaN3uBC8dGvf/Q6tLasJD
	xouvnW/fhW88WjhQ5wHD85WXL9MU+09w5JO1JKm4K8kohxU8G5yZL/i/2AKtXdzg
	tmtndQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ga3s1e8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 19:25:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PJPZYh010762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 19:25:35 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 12:25:34 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>, Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241022072406.3231450-1-quic_rajkbhag@quicinc.com>
References: <20241022072406.3231450-1-quic_rajkbhag@quicinc.com>
Subject: Re: [PATCH v3] wifi: ath12k: convert tasklet to BH workqueue for
 CE interrupts
Message-ID: <172988433462.1407878.10004847719683728035.b4-ty@quicinc.com>
Date: Fri, 25 Oct 2024 12:25:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GReO3n0zVMpT1VOt8qmknqIyHPZWSUQx
X-Proofpoint-GUID: GReO3n0zVMpT1VOt8qmknqIyHPZWSUQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=645 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250149


On Tue, 22 Oct 2024 12:54:06 +0530, Raj Kumar Bhagat wrote:
> Currently in Ath12k, tasklet is used to handle the BH context of CE
> interrupts. However the tasklet is marked deprecated and has some
> design flaws. To replace tasklets, BH workqueue support has been
> added. BH workqueue behaves similarly to regular workqueues except
> that the queued work items are executed in the BH context.
> 
> Hence, convert the tasklet to BH workqueue for handling CE interrupts
> in the BH context.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: convert tasklet to BH workqueue for CE interrupts
      commit: cdad737160571a98cc4933a62c9f2728e965ab27

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


