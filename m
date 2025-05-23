Return-Path: <linux-wireless+bounces-23364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8362AC22FB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B492DA257BD
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882323EA98;
	Fri, 23 May 2025 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+kiSQET"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6FE552
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004571; cv=none; b=d6UK2Xfp0/ZFjEwhRMSOlZbvWqvkis/NYbC8xd+olMT3eRt83aFlfw8Dj1qjJ8qq4qu77Nq4C0EEfy3RejeAcdGVETNJbh3veDoUvInQHqfLFmcNfKzFmwiT/cTdp3UJWfXX/fZzxL3N9U72XvnWsVwA4E8kAh7VN6rQZlIk/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004571; c=relaxed/simple;
	bh=kgFxOOp1Kvo22UysdNlp5gMubOZ8ViIW1KGQp4hqvrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovCamHNrm0N2jBgQQxIQY5CCds3Az7vcSaL83xdmi6zXCiFbgDWvBFXsXrFZyVxUzPVLw76D4UD279nZ97b/GKT/6MOW7EqPBWZQRHNNd2Zw5tHV16pcown1Jw33Xm0a803KYH+y+Uayp84UJk34pSng2DtxAbAYBBqtrmym920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+kiSQET; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9cM15021878
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 12:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kgFxOOp1Kvo22UysdNlp5gMubOZ8ViIW1KGQp4hqvrM=; b=k+kiSQETgwbIszXQ
	P2yUuAEOPMW3pX6aNqjRdMmSkaEAgD9p/AKj3CcpuMgpoYKJTCJCq1+yZ7axe+wG
	I4hCyEv5INYqcMFk/iOTunNDFH+kvNEU8qe1v202nO89BssvvuLtHonzOrtaup94
	j9lV01CZUTzTr5GJYjP2C0+5bnHYgcZRsOrKGsgj2bFcSJ7iDgYo89VNorIoRSiO
	V2rZgV2pPxCftZrp2o9AmJHEX4bipk2xIGfrjqUpFfUIiS7303okXLGxya4PQb1D
	sDBUREeBhFMwVzY8yLBWBZbu6DxFvRt6Rkh2Sq3hJYIChPqPU+hT54YxCGEH4hUH
	psSrkw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwfb9w94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 12:49:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47699e92ab0so166318531cf.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 05:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748004568; x=1748609368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgFxOOp1Kvo22UysdNlp5gMubOZ8ViIW1KGQp4hqvrM=;
        b=fChdGZKccEOwalfcyJT9glMtRivEvoFUvhWqa1uA1kI0TKoOGJj+Mk+KGxQT8fz8cu
         DH1DI7oe1CZ1fp1acOh87aVgsfcW8V8+16dQFechP3lHNNuNuXeqcAaarckWvaWPdHbl
         lSiBkgEzP0ErGbNO+BgiZblUk/ldxyCOx35ubu3wFjGLWlWm47HJsLa77K5FrXBbJFPo
         4tlgOIRdGc6f5QKuEAGsjEMlomNgWlvb2TyoehCVVAE47rSdDx6+7PiAZ7uSkhsLmi9E
         OoraqHsFBrycq/Es73jnDVZD42BWb/PfpsG0xARVKK1yiVFq68OXA7w/wCQxk7aHp2Sv
         xwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3m1EeL6bYBdUm+bBanF1SHdk+Rd/mCR7pYSxgLWterw+RhT/ApyOGL0fJjJbtuIx2hbF+UbiuYkml5rp88Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZliTEeVNUhbfN6Azw2HKsXSw3Dw7dNFK1jZw2vorNU3nBYGj
	+2n3H6hxWLi86Ynb50S0DDyF0yVdFo0qw7QwTrH62mOE3HbmRgu9EaqcqJE/WrLm2NplBaytqtW
	QYjrbcNWyS6PjeMlQGL4B+lYP9HzG6sS4PkpxkjOWY5t3F5XuryJdEuNsW0FbSom3IfbIL2roT0
	Xq0Rhp4zQhqZ3xLFMcM78QT29m2nqmx2wXs7JdwgqWP66i
X-Gm-Gg: ASbGncvo+eVCgCgvvmc31J1vyxbBf5zl0HmvHKPxHgi0u8t6BgRr4cLieqW1gv+GEKv
	ac2aD+744uecszcgsRta5pn2NF2ZFmYeq/KQNaSCZ28l+VScVAy1VvUweBVTwl16z/gmnLA==
X-Received: by 2002:a05:622a:4a17:b0:477:e78:5a14 with SMTP id d75a77b69052e-49e1dc36fddmr40528641cf.3.1748004567753;
        Fri, 23 May 2025 05:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOYfVGlPcg0kq1o0aMk0VZhsCjk7+njJSLhAj6B+WSC6XoeTnWcKWXbqKcZwH95XyV+O8GF6ttYKZgbiRb4jU=
X-Received: by 2002:a05:622a:4a17:b0:477:e78:5a14 with SMTP id
 d75a77b69052e-49e1dc36fddmr40528331cf.3.1748004567438; Fri, 23 May 2025
 05:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318205043.1043148-1-caleb.connolly@linaro.org>
In-Reply-To: <20250318205043.1043148-1-caleb.connolly@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 May 2025 14:49:15 +0200
X-Gm-Features: AX0GCFueYDukQWzrF388GReybur_0Qe2ipD7caCEPE6ktOPoIjHKF-T_UP6Rh2Q
Message-ID: <CAFEp6-3cF+Fj_f7+PqmPVy1oz0OHkpRMPQsKUTf2rhDRZrEwRg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: snoc: fix unbalanced IRQ enable in crash recovery
To: Caleb Connolly <caleb.connolly@linaro.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
        Rakesh Pillai <quic_pillair@quicinc.com>,
        Surabhi Vishnoi <quic_svishnoi@quicinc.com>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: JMWMk4sZVYVH22olUkQWYvCA8mjzvRwN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDExMyBTYWx0ZWRfX2Sp4R0MhcOxi
 slcrj8aKcixAxY02/fb/P3WdEpoNnwhys9FcLceVfCT6DwNR37WIDIBbw1dadWH0qAEuxAshqds
 NjybvE7b93mGr8kCy8ff60wYMp8Vg43ao04fqQxIzvGMPITnF3piOLDM4soQsqGFixFvyk/fftC
 UZxmhdWa3luUc/UDZlxs/5e6naWxDtlSjwtIuGktaTZheHVSxQP32corr83+VpK1GoOhORZmtgs
 nMJqMDF3ZFEtGBEDrYnkkwAgBLdI0DosZH24HD4sDGZSiBtWE8IQfcDgIHKVxCdbXgSIDsdQdZB
 iTYXeB0g0YGBmqtpZDycBdM2WdX3s6iTlBuEK0HqmScWf7NtZ2aDBMY4LuMcwg3hHiCtH3zaplX
 JM561vED159S8UD6NepfVcqMomrq7f4xA4qqOl4qPWWdzi2X9Surzv7ONT//SCigcJLU3qqh
X-Proofpoint-GUID: JMWMk4sZVYVH22olUkQWYvCA8mjzvRwN
X-Authority-Analysis: v=2.4 cv=dLCmmPZb c=1 sm=1 tr=0 ts=68306ed8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=CibMM-rouZFaIluxMbMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=516 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230113

On Tue, Mar 18, 2025 at 8:50=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> In ath10k_snoc_hif_stop() we skip disabling the IRQs in the crash
> recovery flow, but we still unconditionally call enable again in
> ath10k_snoc_hif_start().
>
> We can't check the ATH10K_FLAG_CRASH_FLUSH bit since it is cleared
> before hif_start() is called, so instead check the
> ATH10K_SNOC_FLAG_RECOVERY flag and skip enabling the IRQs during crash
> recovery.
>
> This fixes unbalanced IRQ enable splats that happen after recovering from
> a crash.
>
> Fixes: 0e622f67e041 ("ath10k: add support for WCN3990 firmware crash reco=
very")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Tested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

