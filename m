Return-Path: <linux-wireless+bounces-16421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373529F36C4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 17:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38951892633
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F232E207A27;
	Mon, 16 Dec 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VW8FZkdu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18802207A3F
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367865; cv=none; b=W4HxbSq3vhfRPfVcE1JbMUqnOXa4TTq2m8brQOpQtSvPPh4AOYu21u+r8QSyGH26gq1V8dULy7YdZaISLIcxP7SV484O2C+1j88dZoprJkvg2QVoGcW2lxbViMyRgi0c4/c51ZA18oRdyM7yc4ESPx93mSYXQwagNjPw0LIwun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367865; c=relaxed/simple;
	bh=KNzsT8E3CnEkztxDIb3zovRGxYA3y7UefcmZ3Jrht5s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TFSX8uI+7NwPlyCqNVR03hSrVDrhp2cXyXHJGC9e3KDZSyamdRP0NJrZPg+zNf8oolMM8JZfryFeu9Fd8GdVAfKANSBsqgH+5SFp8ZrVQ6/aLyfc50+J8G6fjiwJ3HDhHnaJGmEwHVRRkZuXdGORk5zwmK+5FnQ4PhMmyQ91i4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VW8FZkdu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGBMlFB018166
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uXK+Gh7SxfMOD309LLK2VY3VlO6Qduz2Gj/cqU4r/rU=; b=VW8FZkdu5JETdDC5
	5Lrd5su2M4s2Z/EtMzz5cFnJfodVoZ/zS1sM/NLTiFJoifWVJxCK/pwD/eL3CBts
	nuTbSzSo00AhnMrKZm2FIhlN0UzL3j5L91UD4+i95943xAu3R34L5/I45DNfzO8Z
	8b/gKf9yO1LU0b78s7F5oErDyuW++zKTIBZ4M9jjwTyXuAv1Vxyi0fPYE9oBEIws
	cjFb4Al6LvvXTt6mrxZuEfaizLUN5OJ02WQvIxvLBIypFip5cnATR4eD9lwSmiuS
	IPTOvKnlmdJt/Zwb+YlIOGrbUpKEkEkGIrOVOKZmGmxHruX3MberACisQOoQQr6S
	NIa0JA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jk9e0vhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:51:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-725d8bdc634so3514118b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 08:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367861; x=1734972661;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXK+Gh7SxfMOD309LLK2VY3VlO6Qduz2Gj/cqU4r/rU=;
        b=EGEclNNekr1N3LjFuTHUl9INa9ilL/sQ66AYMp1AMP0vOrdc1CbdtAUpT9qOB9QvQy
         uW4zPuMW2cqSRP2MQis0Hzby398zA6o/5Q9vga4XytyF4q9GzA9J96A6epsGl6hVyQPx
         GEBjaapMHzi2LDXNBYTdGFfjR1sr1M1S6dZLcfoagG5ghciX6lKYa+X5AgGd3e/ZSRak
         /TtJk7L58Tcx6myUNpJ42tS0lsiH7xyfdvLbw5oQB+Y3AgaytTbeKhwYZmis4u/0ypV0
         YDLSNZanGUaLJt253bDhlb5NmkB21eIRf8KxOzqRH2Pf+M0GI6e5HoCZCsGfRyzT+xeD
         4iEw==
X-Gm-Message-State: AOJu0YxJK58Hhetbs81xVhxjne1jx8DAvdaOEMbOtieoA0uCmUn0qqoi
	xQQq8stRwhx3FO//oNY64JyQiZWka9OGZdWHxQ4oW+fMOwi0M8LSKmuFpe62qN4DDj157AH3q1P
	Qllgiu0JmkaI5rWRWnsys+sGfwO/v/rtj16fWpdVZb2hCODZKNnX5+ur0qVSgFRgJCA==
X-Gm-Gg: ASbGnctNwXILp9KSY5FlNrEg5U4c9K9T/OJPxqI8NL70apdHYvAoH6bglc3oVV182Ak
	HZNHqX3F3qpWBWdo5CfIkgvS7gzHG/QN9n3c19/3pxtT+KgH96puTL+txHl6qc0e4IdrXb2A4a2
	iWyqBvUGPIgf2Na9ErDRlD0tGE6pil/yeO2epdyXVELqWRZ0k7hP5LIPRrQHMlypG8Z7GcLeVHx
	JLS1ZNY9lROAxTawfObVjd0D/JQCwmle81guj6wUedFPlpTQhYz3UlrJzV7UAVN1tA1UauMWNf3
	StCtz/3HvX/cCAjYeQ==
X-Received: by 2002:a05:6a00:2e28:b0:728:927b:7de2 with SMTP id d2e1a72fcca58-7290c138279mr22515201b3a.8.1734367861367;
        Mon, 16 Dec 2024 08:51:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyXq+qauS5YjUavPseBZr2ZSchdvJvDLJVQPOOqYKIf8/TvfD82mWWIHgbs18NZ+XCQh4yMA==
X-Received: by 2002:a05:6a00:2e28:b0:728:927b:7de2 with SMTP id d2e1a72fcca58-7290c138279mr22515165b3a.8.1734367860962;
        Mon, 16 Dec 2024 08:51:00 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bcde43sm4937486b3a.194.2024.12.16.08.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:51:00 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241211154358.776279-1-kvalo@kernel.org>
References: <20241211154358.776279-1-kvalo@kernel.org>
Subject: Re: [PATCH 0/7] wifi: ath12k: MLO support part 9/9
Message-Id: <173436786045.3413746.17890152518880162351.b4-ty@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 08:51:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: MgmcT4aqzYJhLoIvm-l_YSBMD55nH5S5
X-Proofpoint-GUID: MgmcT4aqzYJhLoIvm-l_YSBMD55nH5S5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=914 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160140


On Wed, 11 Dec 2024 17:43:51 +0200, Kalle Valo wrote:
> The last patchset enabling MLO support in ath12k (only for QCN9274, for now).
> All are small patches adding the last minor features before we can enable MLO.
> 
> Please review.
> 
> Kalle
> 
> [...]

Applied, thanks!

[1/7] wifi: ath12k: symmetrize scan vdev creation and deletion during HW scan
      commit: 70f04d72fddfb86678b9786cb8427c1ceda351fb
[2/7] wifi: ath12k: add can_activate_links mac operation
      commit: 0f0a74bd44cb9e3507e357f0291a1acaa9c7fc68
[3/7] wifi: ath12k: add no-op without debug print in WMI Rx event
      commit: 08bcaa2ed6ba007a2ae6d1a1a2ca9d7e84e2f3ee
[4/7] wifi: ath12k: remove warning print in htt mlo offset event message
      commit: 288deb2f062409dc0586e693a378666a4812c7d7
[5/7] wifi: ath12k: add ATH12K_FW_FEATURE_MLO capability firmware feature
      commit: 13199dc5bc9da3dad796a215bdb2bb081de5b647
[6/7] wifi: ath12k: assign unique hardware link IDs during QMI host cap
      commit: 1c9877c9ff8c508fb80e49e63a5675e0b86d74da
[7/7] wifi: ath12k: advertise MLO support and capabilities
      commit: 37db0f45530292d5982368678241eb83f1a9bb83

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


