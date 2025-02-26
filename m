Return-Path: <linux-wireless+bounces-19501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D5FA46A17
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 19:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE07216D5E1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C57258CE8;
	Wed, 26 Feb 2025 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AsvBCora"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38C23372B
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595711; cv=none; b=O5dz5ttZETAi2xhgJ8meFtFe/ZFynrbCV0foZuXlIl7hdeqcpy/+NslKhTx7fEwDAgzd6BK2pjQDXzJLPtkO5ahJr7EjTkiFmdiBMAkuQCys9RhIwwqLfqLE+RiwVkmmw1+NRRaTVNUj1BOg15Ut42Xfd61lZzNjKfRuXg1SwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595711; c=relaxed/simple;
	bh=OoGOLMaGsNQszYB6jKm47ECCNClphzCGZMmBcwTAMHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BVv+hQWpRg+4s2NA8foNk9bqCsYyhBckdXw5BK1WE4/ZAKQtEI3IbbcSutLIxTMTCKJK9n6q2lilH5ptzhuFFkmOYpTT1t5tJChmtvH+PNTlHRMBpkIzG3Fd/Yljgqti9fKk+1CZVLgjbPu3dMpeiKg4lz5XCdWHHCpttbAnO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AsvBCora; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9aFSZ011847
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 18:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6MLX0Q2dEhZ9snK7anZeDvn6rpn475XVQphjBDwoTus=; b=AsvBCorau3gfAbbC
	8JLHXkXGZyh9uod1rSTe4VhpGCOhHOS+eVZ+g8UdYcodMPHN2NMcCNzG+jjCj3HA
	SoGcVdB8W4/ZSdHBKj+X+1fOkxRQDuAV011EWuCzD4O/PcmpojAEQ/zWXPCDCL3i
	BkeRNYGd2Nj+DYXWkDjNuqc0qF6Wyr35eMqvoEDnjtNCPf4ZXu0KuGX/HAeKm3M7
	vDFNhoo43mTmCHrdfrnVA7sQ+6jEORPwvFBOuyGfrlE9z98TzfETDcfCma2cVJBL
	YmYKN8W3teWVQt2A6mgSi+TnYrxHBELkd5ewB3Iba4ffp11Bi5HOnP2PqEyIfnNJ
	YEh2cQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkb02u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 18:48:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2234dddbd6fso63965ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 10:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595706; x=1741200506;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MLX0Q2dEhZ9snK7anZeDvn6rpn475XVQphjBDwoTus=;
        b=i6ti7jj17pHm8KmSZBGiN2FRFa4/2uU1ZJXrkZm81M9yWTHBjgSjgC5XbmjW+qORGv
         wbqf9/X/B+guL+n72YtinQZK1N5zDtJVhOaY0vy45fGqNzA3l0nASPgbDItHhvgl45x0
         94e5cxc2vhnpjWJevefxiGaiSPnyiiQmrI4lREGPmTSBJT9tn4Y0iQMMu9okrvBl7Nef
         r16C0T7HQ90DTtIjYfMyb81G56B8BpDsOItzXvV5DzU8vLshWU99+Oqep8noilAFc8Lf
         EOTqFqwwux3aaktyqC1EAM7ilzckinES3GCUu2Cb2d5N5Yi1xGgrtWDZqfG/GiqqkTjH
         ed3w==
X-Gm-Message-State: AOJu0YxGQ+urTXbcs/51vigmWGinnzJI56x9au1WdLFi0yD5uPPATx7F
	WCvERXtqhbqA/K2f/+UGTv1pr00EM9v/U/a6uPt6+E95cdSKP7j5tS10Yu0Y4afm647M/A/rdfM
	W7db1QCOBjzZ43C3k8l3Mrb1IfToJhIWWjDU8YsymVN31kE2T9ahnvwTbmtcrZaBl35HwCuKaoA
	==
X-Gm-Gg: ASbGncte9XAksWBs6PKZtDOLos7tA13BI0DpraZqldA82ueaEyAEtlT+R9Dg8Q+o5JY
	AGN0YS41NDjJnX9S336uB7jP75DfRMo2nbm/jdARDGzo1tDlLCanSDHk64Ta5KfSB1m7iVeR9Is
	l4mdZ3cKkpYsnGnKx1kL1pLXNj5hApAV1wus1NX1bZvbxIzsSx2uYhCMmft+oETy2FfVNPnAeJl
	z83BiMJEl4xZ+9XNBQkDYs/K1BEW4HMsrGIakFvP0dBmlhGLPh1v3f7uyd6x86YPco+DBcGl1JR
	lXw4ZtQ81nhNtyBa7YwnKUIrRaDd8biHLfGYBxwjbx90Ovs6gBMo
X-Received: by 2002:a17:902:d4d2:b0:223:3eed:f680 with SMTP id d9443c01a7336-2234b05ebcamr5375275ad.18.1740595706608;
        Wed, 26 Feb 2025 10:48:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ15Vf44+Aee27H94lto+wJ2ly/0QZaUFoOURT9xRzc3vn7iSFG3Y4N/butAeJ8iwsmZSAWw==
X-Received: by 2002:a17:902:d4d2:b0:223:3eed:f680 with SMTP id d9443c01a7336-2234b05ebcamr5374225ad.18.1740595704725;
        Wed, 26 Feb 2025 10:48:24 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a8393ffsm3932214b3a.170.2025.02.26.10.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:48:24 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
In-Reply-To: <20250207060005.153835-1-quic_rdevanat@quicinc.com>
References: <20250207060005.153835-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Improve BSS discovery with hidden SSID
 in 6 GHz band
Message-Id: <174059570392.3119794.15041194806483744481.b4-ty@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 10:48:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: X1ovbNx5IBmnusaARTaQsfopxy8cHVMg
X-Proofpoint-ORIG-GUID: X1ovbNx5IBmnusaARTaQsfopxy8cHVMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=695 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260148


On Fri, 07 Feb 2025 11:30:05 +0530, Roopni Devanathan wrote:
> Currently, sometimes, the station is unable to identify the configured
> AP SSID in its scan results when the AP is not broadcasting its name
> publicly and has a hidden SSID.
> 
> Currently, channel dwell time for an ath12k station is 30 ms. Sometimes,
> station can send broadcast probe request to AP close to the end of dwell
> time. In some of these cases, before AP sends a response to the received
> probe request, the dwell time on the station side would come to an end.
> So, the station will move to scan next channel and will not be able to
> acknowledge the unicast probe response.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Improve BSS discovery with hidden SSID in 6 GHz band
      commit: 27d38bdfd416f4db70e09c3bef3b030c86fd235a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


