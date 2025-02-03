Return-Path: <linux-wireless+bounces-18328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E9CA26720
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 23:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB7C3A3E53
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17882116F7;
	Mon,  3 Feb 2025 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HKz6lE4p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75037211472
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622955; cv=none; b=rhBElF9JtDFvyule+5eTBm2ARRUySC99VHyzl6VUYgfB+qzXuKszhTBHsuz27kRxbV34yvcM1YKqYcsi1dgDWE/tznE60pe950FNeaPTwdkxDgirTb2VerFa9pLNRzVWQvGpDkayRZ85u/9xWSYLSBF+FABQT3MEbRjFQaiRiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622955; c=relaxed/simple;
	bh=NLEVXhnAzmUim5Ah5aBo0pKirspfu0j+3vbXH79mUDo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MqOHOe29CN2xhq4QNeoL3HWcJhl0AEy/NobvKISYwIdvwzOgMcIn/yilqr4NZOv9Mzq4Oy2cPTsYOxzvCdsL17o1ktWeBCso3b43mlB28lwS+fnQ6jKWyGENwm+SjoInSQu2JyFB8OtRHEA2tN6LxPS7+2Y7ql2D28rvcMrGAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HKz6lE4p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JlURb028499
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 22:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CfNHhPZmaubfMHhcVyjBDXbxt6ao6aTaeG9ns+8w5Ck=; b=HKz6lE4p3Fx1Q7gg
	+q2dXT+rWaiVwwesvuEC5DpYIY1GSzUavcgiA1pcn7If/pTtFtznYWI4B4NdedXz
	DiQ9/dE0S4SZ+6s/B8kHX/bWKSikAjZyXIfT4Kmsbz4BQMRMXkYbEwXjDHr/SdK1
	rKdsbhAPvo0ptdlrn4iuoSlP+w49MxYJCYLsj5TSUnBiw8QBuEaNmR51DgJS1Umc
	BGink3qipWI3jz3S4GCOdqnC1A3wtnVTBRh0wC3Y/aPUG6xrwttGmCiWSMaSok2d
	sBy8ldfj/1RKWY8j0CLQ+whv/NwFkHrrywBjO23uFTBG59DQqUF4cmQEb5sd5Re2
	evQHwQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k492gapa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 22:49:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so9456820a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 14:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622952; x=1739227752;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfNHhPZmaubfMHhcVyjBDXbxt6ao6aTaeG9ns+8w5Ck=;
        b=KPFLUk1WiR/tpasdlWGzPjf5H6RdniWydT49bTUL7G8d+UuPhxslxqpmQ64vFtffcz
         Omh+LUh1AmYfskwXjXcQa3KbPAr+6bxU5Whxki+JeKbr93n7R8mKi/bEkv20mISx1d1q
         S/7GkHlLfNdcLZIgcvoUQweUT/tSV8u8ctPqAAgOOzHW/cXpQHIjjzN0cTGsmKpFLVhF
         003lK8JQc3tKkdo/gDWpVl+vMS+K1hkJ4rW+Si1mWO4V/RHsv96EEP3jPlih5neeajH6
         D5OiWaC0j/ZdEDs3Y6yidWyGQJ7+C793QjKoRJJnrekDpPYo/E4DuHeJ+Kg3qW1JyqlL
         hAYw==
X-Gm-Message-State: AOJu0Yy4JUcrVJd1OniAN7SZ5dtK6nooEnpNjZhEhYJCZeoOSoqx1Y8n
	oUxs6/lOIs1tpDxd6cJfhUQnnE2bHpd/kT4mkjdaWL9NLzJAYwhGmilyJzxJo4wJ+WQ3WPhaYp0
	ftv31wYX/fiOK6+p3uuAMAzzdH2/wfba5yeoPeE277dfbJupYwQtLfMH9yUmfvJY2dIdsi9PwKQ
	==
X-Gm-Gg: ASbGncu5BrBUgYQO5KNI6v3FcLkuIXMuaRCsorkdSzfsOSAjJVrj8CrUCTgK38BLQpm
	AQ7qZj85iGAhP/QCk63+rl+xuXbCgjcWRSyS0OTk2PQ9tWzFvYhnZQfwHnilSdF7Sg0RtdtRXFt
	XSvaEWL+oXdPJbgAQMEK+kf92UZGHacg/sTts9DfOasEZBVOYpS9z48Crk0iiHMHZzfv+MiPN5I
	N1R0Vbri66XEK9YYmowWb1jlXezQmrXzksxMGJzm64y1bFnIN4UVRwBgV2Z8yavoJKrtLHF5SB9
	OZetfU9audInA+erWN6qNp1f9XTuQDvN3VJotGPqgA==
X-Received: by 2002:a05:6a00:391f:b0:72a:8461:d179 with SMTP id d2e1a72fcca58-72fd0bc838cmr32181674b3a.1.1738622952564;
        Mon, 03 Feb 2025 14:49:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhHz0zbLpxUVjcBazXmNhIdeCVd0SdNR94jZYmImaahbZ2YuMremEgLdAuEl6+pyW6jPGl6w==
X-Received: by 2002:a05:6a00:391f:b0:72a:8461:d179 with SMTP id d2e1a72fcca58-72fd0bc838cmr32181647b3a.1.1738622952097;
        Mon, 03 Feb 2025 14:49:12 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba353sm8887444b3a.112.2025.02.03.14.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:49:11 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Lingbo Kong <quic_lingbok@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250113074810.29729-1-quic_lingbok@quicinc.com>
References: <20250113074810.29729-1-quic_lingbok@quicinc.com>
Subject: Re: [PATCH v4 0/4] wifi: ath12k: Add new features to ACPI
Message-Id: <173862295146.3734728.7169166499686289961.b4-ty@oss.qualcomm.com>
Date: Mon, 03 Feb 2025 14:49:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: f5p17uiSMUb5OFZiI-8ZGl4gSrjH18tI
X-Proofpoint-ORIG-GUID: f5p17uiSMUb5OFZiI-8ZGl4gSrjH18tI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=770 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030166


On Mon, 13 Jan 2025 15:48:06 +0800, Lingbo Kong wrote:
> By reading ACPI tables, implement a method to obtain the ACPI functions
> Bitmap, enable or disable specific features based on ACPI Bitflags and
> download board data files based on ACPI board data filename extensions.
> 
> v4:
> 1.rebase to 0c5fcd9069dd
> 
> [...]

Applied, thanks!

[1/4] wifi: ath12k: Add support for obtaining the buffer type ACPI function bitmap
      commit: b59d1f8207de4e2ec763a5e58f95811d0eb2272c
[2/4] wifi: ath12k: Add Support for enabling or disabling specific features based on ACPI bitflag
      commit: c6a7c0b09d5f430c36f860af1032e9dfa2dfcdc5
[3/4] wifi: ath12k: Adjust the timing to access ACPI table
      commit: 33fdeb544ea5966abe247b9eb96a8017f7b9b2f2
[4/4] wifi: ath12k: Add support for reading variant from ACPI to download board data file
      commit: 0a43c3a520e96d086d0aee492bbcf73ba737a637

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


