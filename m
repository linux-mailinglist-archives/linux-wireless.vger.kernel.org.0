Return-Path: <linux-wireless+bounces-20255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B2A5E2C1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 18:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C367AD9C5
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84A1C860E;
	Wed, 12 Mar 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDxQswvD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18A2512EC
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800213; cv=none; b=pf/UynAEkvOeQs6fi29JMc/5FjJHoKSE0cLZR1oY84VLNI2fCttT9610JrdMZv0L59dStKYcK9/69nbcmbC8WSHLrARq/Ne06c+58zPZklG5yk9BviUIZ65He6502Dj0YLzrqW9F2aLYDSq4qu0CyenX1hYOPaGvE4zMvQeNPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800213; c=relaxed/simple;
	bh=hJ/IhzeDscDjIuTf3lMXiUNiNQBG+FSk/Db88Fb+YP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q259THRZstPlIFumaKBjRoSbQsaTnsBZwo1ttHo83qE5J/Xj9AA9ER8JIt3POyz77qoVpxhCay1MCs/q3hLdmAd4are7wCpSYVbZ1cp4McaPhDnmoCqR43TiwAjQ6oa/zEqD55Wf6YX6AaMa755dZ5n4MaNKSAgsI9nk4btztFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDxQswvD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CBDCb0003494
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 17:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hJ/IhzeDscDjIuTf3lMXiUNiNQBG+FSk/Db88Fb+YP4=; b=DDxQswvD4r73fsCz
	gWJFcaHPk68ZfPYPJpAKjCRXmbUELuuZA5fy+Y29dYgESgn608+iY931q2ein2Ea
	+g4LPikJbww+sGlA79vXGxgRbL2iRNe/BLiogKoUg1Hrh7szU8CWruzrMRKyHUK7
	xOfdLZ1SKQZPSNdiFuKUv/+mK07Tu+a6d9rsUMjwc8aFvctzmd76SUBZ9hN9fr+G
	yOZW6Am6f5ooRuJlKhAlxmx2u0iZG/CbHAjijUdIQJbKTIol8uLK00q117IP5Ts+
	YQEf5Od8dFwqJr42f7E5Boj/saoq0GvtM8V/+d8jklaiQwQ9nbLh4o3l7F/+JedJ
	hk5upA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45b96y90uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 17:23:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2242ca2a4a5so1049225ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 10:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800210; x=1742405010;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJ/IhzeDscDjIuTf3lMXiUNiNQBG+FSk/Db88Fb+YP4=;
        b=sb+aXCG3V/AOItolRiKl9iqeid+HK0hzvTf1l0hVHAawqy+fQoXsHe2s0R/tVnOThp
         CgNgNIVFPcQo0TWzM4BkH7yyZ+g+njoNrt+o73BT99+XEsdDTCfrefq19RxtM9Fc+es1
         xGKNeIOYqUPS3d3jWSUK6xYGy7Ushc0FBW7yS4ccotyCnxlW2Ute/B+qvq6KDtGNgOLk
         PWEd9S5WzGXelnGBVsUXP6EnL9wV5jPjmD8s73FOJH90K7ijmInAbS6cLBOxCuN3eOXh
         CJ22zpnvBoMrsUbkWoPPyPdJsSbTNXwZi909adcYQPtwFrVCT4Yr5lCD0wIrN5aXLT+t
         BqKQ==
X-Gm-Message-State: AOJu0YwR8pjp/tiZlDuRygCOahtqprUQnVlORW+WZ2nxEPT/+D+DEHSS
	eaYDEgi4D9rdwcObwnJfq7ueovXJqlhD6pR2a0AbLRO0VAsXBalWmnmh/xghXI0wTSE2LDLYZht
	EqAi+wFZRBDhWsoz4Rqvt7dA7LobjhOU83HTLf+FdFUAmNH/ADFWiSMU59pX6FAZADEsC6Y1Mgg
	==
X-Gm-Gg: ASbGncvdhfPMECZW3CreF27Vn5MVd+kjH4nuJUWSXDpuSh8BJBwagZL0nLoGWTNr3TS
	OmJCCUmMyPTpaid7SnFEBWdvEf2N2f1LvHLNxA0Kd9RgZzvrYJpCxUZXFAtGLz2SjHnjLLFCJiK
	Cr9k9MAqvUdjBEb5yw+LCoZT9aXagkqyWAPNTXAMWX4jn0+nvw/oQgZC2CQhZG0ZMJH8KC5pAbo
	qX17a2osLATjEaFw9+ygvc5foNh0dRvvxuRBCeGg40LU42lsGdfC9RoBQJTniOZJlWIcyT+hwsd
	jqyI0MxGwNuswNQSgrw3V8KXmHz7apEbHzEwjug1BgC92fuzoC5qvv3HrAZxGiOAIac51Kg=
X-Received: by 2002:a17:903:1a05:b0:224:1294:1d26 with SMTP id d9443c01a7336-2242888bf0fmr300099505ad.13.1741800209648;
        Wed, 12 Mar 2025 10:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGaOIUwQ/J7fe0OQ29XjrjDMCFmd44TdM97YWtn5T2A6X2SVq7vthnlda6O5u3rLxb/P005Q==
X-Received: by 2002:a17:903:1a05:b0:224:1294:1d26 with SMTP id d9443c01a7336-2242888bf0fmr300099255ad.13.1741800209247;
        Wed, 12 Mar 2025 10:23:29 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410ac0794sm118675905ad.259.2025.03.12.10.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:23:28 -0700 (PDT)
Message-ID: <ff2b021b-61c4-40a2-806b-50a67324a7d8@oss.qualcomm.com>
Date: Wed, 12 Mar 2025 10:23:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v5 00/11] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
To: Johannes Berg <johannes@sipsolutions.net>,
        Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20250312065132.3397726-1-quic_sarishar@quicinc.com>
 <56274f96c44f476e9ac0fabe75e89a43e79c9a58.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <56274f96c44f476e9ac0fabe75e89a43e79c9a58.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5aeQApKBlKKMMuHZhJ3Eo1eZ1CIrSLh2
X-Authority-Analysis: v=2.4 cv=I+llRMgg c=1 sm=1 tr=0 ts=67d1c312 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=w1r9lfwRZFAnMvHqIqAA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 5aeQApKBlKKMMuHZhJ3Eo1eZ1CIrSLh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=904
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120120

On 3/12/2025 1:44 AM, Johannes Berg wrote:
> It's getting _really_ annoying that you keep sending patches that either
> don't apply or don't build cleanly ... Please be more careful in the
> future.

Let me apologize for that. As we discussed when you were in Santa Clara, we
are still trying to get good automation in place. But for now most of our
processes are still manual, and I let this through our internal gate. I run a
lot of builds on the patches I'm taking through ath.git, but haven't been
running the full suite on those going through wireless. That was a mistake on
my part. Hopefully we'll improve on the patch quality going forward.

/jeff

