Return-Path: <linux-wireless+bounces-17346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F58BA09E43
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 23:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD40D188D479
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E64212B18;
	Fri, 10 Jan 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rf19zEIL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605BD205E2E
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549060; cv=none; b=hAiOxLCTwuU08Q5vDL2/79RR/zmiLP+A7LSEDJgneHVCDGV13Cp3xjE/MXuAaeOhAtu6FGNEG4kaVrwo0kM4VqXoM4LV/mJbvSozBcFh54mZSfdybQHFRC3G8cNf1dUIgxTeaf6BV+1uiTEl8nDgE2ko1jG75nYmjenHzG5eBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549060; c=relaxed/simple;
	bh=TGlEwKCgh98Mopo+D6DDrpT6IKs87FzicO8uVAltlKs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ljv1LCnuCMNgs4cAmBUjw8A0NCsF0jfaEqvc/qqVbm2arEjMlJyY58uF3IAZvFiU7P9Ihs04/iZzUwdDcZaH4ipNaD2QXmAh6hPPEjmbfLGQHhG9WLo9OXGsswBgsPEGgKZ4g4ACoJ8IXoJbPv6g0YCTooUAPE4Tgo8Ek1un25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rf19zEIL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ABEda6029463
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 22:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1aIVorOEu6q19MR1eqK0oeznCCuKHOywOLuSonQwZNo=; b=Rf19zEIL8WMtkrYN
	srIOnNaer9snxCkumqYKOnAYEURki++URNDSh9S9vDdEKKGdZUt8YckFLrwoxTxN
	XAxWUW+odH7um3r2eFDloxnjaO7uLrgUEhtJmLr+9FJ2nYHArB4szis7/2Qtx7iw
	uQKfLv2ZRmlu4gFiunPxe8jQJsBLyoxoSisIXegHy1KmyuUsc/s/KtRr+KeQVNvC
	vjriWHUE7kEbDx+zmjzlp3Ehf/K44T38RXlp1VHUlJIr4a6JHLJJykOkgtcoJxzZ
	EJMPP8WMqFQ2AHhVtupLa/OCtOsuvIFkOYjmFwIpoAQ0XtjtwFAmuA6/p9H65vls
	5Z3xPQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4432gq1mvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 22:44:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee6dccd3c9so4509359a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 14:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549056; x=1737153856;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aIVorOEu6q19MR1eqK0oeznCCuKHOywOLuSonQwZNo=;
        b=hEfk1PjlxwQ0qXvu8asFOdZ/+xeNhZvP0C16BmOOocl7emTnZy2VOulR6GEjtMfwR/
         nL0doYc1HpZo0gyrTGp+MWXIjI8j0HVIoftU6cUGnWnuL2Y0034oPN9AKjvH1EvfTg1s
         5PtjcIrYhKv4/sL9+A4AgTSaLeNUpKNQRkFhx+8VvY0lI+/LEym0utpF223pxvH4xg3K
         27LsCyZcGrKCEySWRKxNUG/DG5SKCJg/IdREk2WeYsXQsQKhAvL9zWsy2c38oF6mc97K
         aGT/mVz8sGRs2IgFeysNOq0AfJ0DKN55yGFB0zNZnhGB9U7jwuYzeo193Z2QMFq/ggIe
         oA8A==
X-Forwarded-Encrypted: i=1; AJvYcCUGy/nxrJt+RT4BL96NrCKf1DsUAtDNQC9oHvT0qOgVJkiIq9G9e6pgBYxo1oxRd7df18Nj7DibH+Pr1586EA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEy/Kf/sj4C8wpPfV6YLu/ehYUSK0lzi4/pDtznBlqByqh2mOx
	gjH4Edep5qQcsjUlTGf/dfRCNV2fhy8Hnx3Csijyj/78+2LhJ0E/FA3rKQsX6qHqSnOIihyW+FU
	Sr5GYrMlIX+KxwdJdkTzN+M62HyU8IirpG/uc4oR94j8oNB1R0yituMGT7o4BAjUdOQ==
X-Gm-Gg: ASbGncuKvF9Os/D5jPT5bAgqhvPnaf46tJTebiabj/aOP81/7avJ3IAXC/VLoXQjR6d
	G76D3urnfQXdQHvfq9lv/LVFX4rjnjJzWVRhghnhh0nAkmnQJaGX0U8krgBBV0C6exfViukcbdk
	R9ySr8pMpMJYY4LheQwgi5b7ZA1fIigg0L9hZVP5JIXACIaK87ZX1J4BRkbWY/FJa0Y6tjRL3kx
	Nl6rf3NodRtW1nU1W0rzEvZGEYR9zS2+QMA7hg45nU/t3bFMjPIbjSwNxDSEaZvWxhK8eY+u6gi
	nEEOjxWWEaAc2jOQ/Q==
X-Received: by 2002:a17:90b:2b87:b0:2ee:ba0c:1726 with SMTP id 98e67ed59e1d1-2f5490ed997mr15974216a91.34.1736549055838;
        Fri, 10 Jan 2025 14:44:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgzq3B58u2nTRTcOthNaD1A8J8fmyTnmqqUFw8buY2/lkYoaPST0VIMfPUfk2Gv/rFLShwfg==
X-Received: by 2002:a17:90b:2b87:b0:2ee:ba0c:1726 with SMTP id 98e67ed59e1d1-2f5490ed997mr15974194a91.34.1736549055444;
        Fri, 10 Jan 2025 14:44:15 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a34e456sm6474276a91.35.2025.01.10.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:44:15 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
In-Reply-To: <20250109080703.106692-1-dmantipov@yandex.ru>
References: <87bjwp8ax0.fsf@toke.dk>
 <20250109080703.106692-1-dmantipov@yandex.ru>
Subject: Re: [PATCH v2] wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()
Message-Id: <173654905469.3181612.6356487402379736010.b4-ty@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 14:44:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: 6zc0TknQByrefd65-ixjCkaGZCPJph6B
X-Proofpoint-ORIG-GUID: 6zc0TknQByrefd65-ixjCkaGZCPJph6B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=592 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100175


On Thu, 09 Jan 2025 11:07:03 +0300, Dmitry Antipov wrote:
> In 'ath9k_hw_get_nf_hist_mid()', prefer 'memcpy()' and 'sort()'
> over an ad-hoc things. Briefly tested as a separate module.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied, thanks!

[1/1] wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()
      commit: a72eaa175656836a32e94004ea05598409e2f2fd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


