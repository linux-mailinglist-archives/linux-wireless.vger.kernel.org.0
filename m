Return-Path: <linux-wireless+bounces-18160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BDDA22279
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 18:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506613A2590
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1151DFDBB;
	Wed, 29 Jan 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JUpki9Vf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9B1DEFD6
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170241; cv=none; b=rNRXprejP9qBRyqbhYwZEj/DjEo3tmJ8QuPhVBFq6MCC/Ke1Yb4RWGFpCDOgWkcHKJVVtgiZUckiIHOfwpXDO9yigZHRa4ZLZXeN99m+s6a0HGliWTwjCYaMkbytR4kRTYj3ZcATKgyQKYI87Crn77G/kUeYEew2Qw+1K6mfAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170241; c=relaxed/simple;
	bh=MZuZCks0IZYZ5+lZgNCGkFxxn8EqleDidIR+bW5CRso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r3D+VwsnI4r8r90qX4x2fWFszDlqafN9EsDLDijchA7f9bIPZuYSMofwSoj/IiypgS+jYA2yZHWdCXjcn42OP6Ijxv0QQmF4Q2ei9qe+kwl3gHqrnhO8ltgjUIovtUHi0CqYA8Ib1UOjmRBjfmUo20htk3QyupmzZ7cPymviOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JUpki9Vf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8SmaY027001
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5GS8C/l5/wwrkw6B3GkGnPJCN4dZFeJL9KrG+RtKX8s=; b=JUpki9VfErC0dwOj
	b1vL6VwA11gGmpZ8edYDa6CjOMgtPPj9GbxQFfhxdFyxPl5ZJ/tKkP1ZynheosYT
	qhvxeGKkRifrpKfZPGCGKg5uuohBNKgl7BOHGwgqaiJxGkAaJWzQm0MObT8tg0yB
	UIYtwNR/TL6tDuc9lnbQ5l3C/5uFcPwf1QR1GmAykRP4R5/GpxRw7Y64tas1Iqwl
	Rq9ZaVJTy3jmh/2CYxtXhcNeKIkbsMDB5XJBBFCsGu1ARq1+jo+C2y1guJ8GT3CC
	lL3AIHBuygyPDZIS/zpQDo0SIAsVV9Psv/66mDYrmea0b6QutklO/XnMHWvqKXJd
	O77PbA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fguxh0g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:03:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9dbeb848so13130084a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738170238; x=1738775038;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GS8C/l5/wwrkw6B3GkGnPJCN4dZFeJL9KrG+RtKX8s=;
        b=bncAgA4b5Ppwv1c1nIO8YTTJxdys+NDeuOvAvZyW758f92k7AttqbaB7o1ZK7Ufqt1
         M7EBv239XcNjszHVWDhSrltfI7HrlzMYUPfBUXKwxmAckzvSHHr+/46uGxyDygjLhHdz
         9yWfVfUZrAmfLRdeHiqV94whgPVtphGpQ8pEW1e/G7do9cOfJiQg4hsaVcpWQJg10C2m
         /DHpUZAn4S0/yEmO6/KxNtbps4SskIP8Co2zfA+QmdJdczYCi3pOOkU+Ah62JMehK6/t
         LiJ4GepmwUmH80ESmUxtDMxY4UnRSHxLIj4cmdXY/5+iHd91z2SSMkR8Q00Fcw4GVIVu
         RxWw==
X-Forwarded-Encrypted: i=1; AJvYcCV8YLN0k+vFCDHmUteoH/S86is9vIFaUaiZVgYeNVmXXFqmB5KD6RuUhgrAtI8yY/rkyIWQShk5/yqg2SghSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnqUZjI52kaZOQjhvxo4tQK2we0U4iNI+Lwmj+vJxhBn1NKVK
	2RvOSb+D/lFEcD8PpISlPSljGxsjXzYsf75F0j+mMVYCt+KQd5tC+X7X1HrYyAayWlyJccVPZWw
	1yFw3xkvLXbzogM9rcCkooDxYejf8IcK23afVlFHyNHVBSDrZgeu5b3vVF2CQnmeDbs2r39z7uA
	==
X-Gm-Gg: ASbGncvgS4XsAQuE5OJledCQI/p5u1ghQO8NwPFYwFxNbI44V67qiUQwPl7VsDeDcJ1
	dTSkHkPLRwRqsnuovGZvW5HGLy2WTTNAqGa3oy0IPEOKKBe6f35daSvOrTAwXBwoL0EXe9UpC6h
	epWXnUyaHQpZRIQGlQZr6xdm6BReAGSiN2SrPQ9yF9hiW3eXqIMr221Xb70+dQ/y/IgcsLObCey
	kbiznvhe2Mkfa5xy2/Y82JvZRLlmALD+N77m8LFGOqRbMj3mEKw1YK1GH3y7I7bxyr33sTmsAAV
	pLjsc4uhHedxf0wfWMDL3ktgr8Hj5lCJwFd288/BFw==
X-Received: by 2002:a17:90b:3d45:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2f83ab8c3f8mr5395535a91.4.1738170237598;
        Wed, 29 Jan 2025 09:03:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdCO492qTpddo07p8btxvjV9/feV5yXAvX8CTzKY6hAv0CCYAnCkCuh05ay5YVIeSEP7b4CA==
X-Received: by 2002:a17:90b:3d45:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2f83ab8c3f8mr5395489a91.4.1738170237205;
        Wed, 29 Jan 2025 09:03:57 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83be3622bsm1988366a91.46.2025.01.29.09.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:03:56 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
In-Reply-To: <20250123141058.1696502-1-dmantipov@yandex.ru>
References: <20250123141058.1696502-1-dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: do not submit zero bytes to the entropy
 pool
Message-Id: <173817023642.726123.319803870006404621.b4-ty@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 09:03:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: mBDFbnUG3yPekhMaqco9cqrl3p-zY4of
X-Proofpoint-GUID: mBDFbnUG3yPekhMaqco9cqrl3p-zY4of
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=673 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290136


On Thu, 23 Jan 2025 17:10:58 +0300, Dmitry Antipov wrote:
> In 'ath_cmn_process_fft()', it doesn't make too much sense to
> add zero bytes in attempt to improve randomness. So swap calls
> to 'memset()' and 'add_device_randomness()' to feed the pool
> with actual FFT results rather than zeroes. Compile tested only.
> 
> 

Applied, thanks!

[1/1] wifi: ath9k: do not submit zero bytes to the entropy pool
      commit: 0f2b59a98027a781eee1cbd48c7c8fdf87cb73f6

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


