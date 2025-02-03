Return-Path: <linux-wireless+bounces-18325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E76A2671B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 23:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B142E188359C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF672101B5;
	Mon,  3 Feb 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TlsGb3O+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99E1D5CD4
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622953; cv=none; b=PfLZnOegEzkaC3URMxIJQN7oDPYNwNI9l29F9aCy5ZsV5LyeH4zRc6Un0RERt6nNrSdxDK9roEUGDB2/jWQKyUH+CN1N1SNkDqB2qmfKTD67kVs/rFUh5hRGV7nyIrUrkyeowII+JSSdySChxQ2cjU3vGIZSmxn6Gq5OmyjGsBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622953; c=relaxed/simple;
	bh=2yUs+IM5Pl1W55T4vQoTAtoqlF3k1yeqhi4aT/ur60M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GYxifdp+nC+4MHQYIyQw9tCo0ntm19byMZXTdwqATnUyH3wS2jDQLNNhid6dOOsyN+gnV7UI4p2M2x/wFnK0XuOUNIPXRztoXoudYH5YZaJ0XXmf7SUCLMSCext5+ZZV+jvkyhQcAOjZHnHa7K9nni8m3wXKdKSAV3yNvFeJbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TlsGb3O+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IbYgp013155
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 22:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hw7bNV05959ms6oss+YF+4qJZNr/KZytbXPLNUurobM=; b=TlsGb3O+0wCAGyyt
	TbjEp2XQVfuCz34of4l0mDy2Znw4AqVHPY0UkUC7Tq+ees+9ILfuCz5yfeiw9QjK
	pZZKErkqZF4RTHMVy/o8fRF0uur5V+hpGWXKHlBKbPX/pXI4wI+BpNmoTdeWwHvP
	sDlcIyGhOWXb6qKDAUD52/RYt1lZuYOZWPtceAL0yAxno5kjW8guhYKl9uGlmJAc
	ClTnYJGU94lE9MiUuxrKJfxqpOctKe0MxeRlJ5UqabeaUTE02x5LfAVulD6PSwvo
	bmQh9VWq3rhh5lgCLDEyqIrlzI8F4gvlyiMhOOlqzRxPhSbsM9V/ZBAb9cjIcqDp
	zaZJBQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k3890fjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 22:49:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so13950146a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 14:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622950; x=1739227750;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hw7bNV05959ms6oss+YF+4qJZNr/KZytbXPLNUurobM=;
        b=vNRDgXfbL/GVmBumhlGiCUgK8sFVm+Iy3x/LRnj1NkSsqCEqT4dTt/X/Up5q4nv4Jw
         OymNpS/g2vXvmaROzFnGYSSF8GKWegrl3NNNE4J2ZHDExgeE4wUeL3Lui9G11sOwD12O
         fUuj+KLS6slbYO5TfqJeFEbSlFqIRVjDN5l/FQHfUsWYwvADowij3wFs08Bwuk9kw79a
         v1sq3DmvXNYpkQ/QnULcNjYgq2LV2+8h3xF1VNfkLG8E2s8iRDuB+TzrgcpG2ERk2ciN
         JAsOR6Pv9ar7AJcEKSMMxSqCWf56mJ1/C3/54B6nlO/uOKc3j4RWJBWTbobz+9ntYxPk
         uQtg==
X-Gm-Message-State: AOJu0YwDnqDcLSKtmb5vrNetzSPinSNI7QZadZOiTPIrlh9DoHsxa4dp
	2qu3Tvfm9IM863XEN/JqRLXetm8YfHv9eAosmZ4ikq+mQfokQt0TKPseIFqVbQo8xxEAB9NRd4h
	ll54BGjRHRXwl5OKfA4FBdcPy9B9qwZL8K++dXP2aUMkhToae6tqueE0wmkKLv4u7j18pqZTTVg
	==
X-Gm-Gg: ASbGncvH0az1njy99LIgWHUeIx1s8OCyc5Fc/8ebM4McKlU4r0WmeFDwbDAqysFFFqr
	cLQQpiu1i9/WdWhtwSo4ywxn8ypMoUPzbStwH6nTHD49WzEARJYeIZYO/Q4rg8wnGbeMCoqborA
	7+vqvHO8UxhRfoIGDLkMGhKmBYyTJAk8Z+yHh4AfqtrnADGCKEUo/eq2/qDCEp6nYTgSTLz7FPr
	RKjlvHvZBCVbjCVJgJlLJe3+o21mpWqvKedxaEIYghPLft8E0zRwOMce2r/lYewr8LAhWV4opqc
	6wb5rPIS2FAItGnAniV4m6bVkk3ezOW/+eE7ofN3jQ==
X-Received: by 2002:a05:6300:8a03:b0:1ed:9abe:c663 with SMTP id adf61e73a8af0-1ed9abec6e5mr15242518637.10.1738622949685;
        Mon, 03 Feb 2025 14:49:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLgkO3wpYZ3B0nMiUJkb7E9OU7kLXT89O26RAqf3BGd34605SKsXiAulB5vO5cyrzb9LtnHg==
X-Received: by 2002:a05:6300:8a03:b0:1ed:9abe:c663 with SMTP id adf61e73a8af0-1ed9abec6e5mr15242499637.10.1738622949298;
        Mon, 03 Feb 2025 14:49:09 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba353sm8887444b3a.112.2025.02.03.14.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:49:08 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
References: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
Subject: Re: [PATCH v2 0/4] wifi: ath12k: add MLO CSA support
Message-Id: <173862294852.3734728.6340802985504252357.b4-ty@oss.qualcomm.com>
Date: Mon, 03 Feb 2025 14:49:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: PptM5OyoyD7FbspRC-nX-6VFO2urw-l7
X-Proofpoint-GUID: PptM5OyoyD7FbspRC-nX-6VFO2urw-l7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=882 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030166


On Fri, 24 Jan 2025 11:46:34 +0530, Aditya Kumar Singh wrote:
> Patch 1 and 2 are pre-req fixes (applies to non-MLO as well)
> 
> Patch 3 basically uses arvif->link_id to enable MLO for CSA while adding
> support to update counters throughout the CSA time.
> 
> Patch 4 fixes a potential problem seen when medium is busy. Again this
> applies to both MLO and non-MLO. But this is exposed only when Patch 3 is
> there.
> 
> [...]

Applied, thanks!

[1/4] wifi: ath12k: update beacon template function to use arvif structure
      commit: 4094445969740028f9b637977781b73b64c5bc7c
[2/4] wifi: ath12k: fix handling of CSA offsets in beacon template command
      commit: f9c88d65e805ca06f26806ac99f569a3dfac2229
[3/4] wifi: ath12k: update the latest CSA counter
      commit: e26a6989b10a3dfc97b8c206023a6bf3a3ccb94e
[4/4] wifi: ath12k: prevent CSA counter to reach 0 and hit WARN_ON_ONCE
      commit: 36f002a3e36efd3370f5b6abfc157e7481ecb1e0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


