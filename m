Return-Path: <linux-wireless+bounces-25388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18EB0414A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 16:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CBA166CFA
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23324EF7F;
	Mon, 14 Jul 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bLYNq9Mz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363E19AD5C
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502673; cv=none; b=dbGDkySrUswDbdy+3emPy6huXRtzRRlixXbLswjk2dXUKYdYwNJakldrlRa4iL6GG2OaYEF1E5lHDAIBGBiiP3Zlncl9K3roWyA04D6ANqKve0T+1IswkaqZlRUOqenz7/f6l/HDRSM0dqIfQIOBMx7gOFjMrhUye4H1kjuqYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502673; c=relaxed/simple;
	bh=3zP8HdWjHfs49skI1Ps3g3l9eSaFMeZ+H1J5PPw7/zE=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=bYlwFjQ4yG9E4cxdgtYWqh1rGT6laN24PAjnTAP4mJRPxaLg8QcmgMJ1gffzDdCsarOqThxpt1GZfJP/re/sE+uUnORKUA/0jhpK6X37aq14q6kay4e/bCzBH0mo3vnW0w1xWnjrJDVIj2pLdp7tCrnQBdJK0R03PkYhK6C5q/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bLYNq9Mz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ECEPa7005596
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uYe5JEQ/NJBdGO052CLNtn
	qKAn42FRtb4sm7urxF55s=; b=bLYNq9MzOyM9dXurG4DhYAHNGDH1bJRR6TXm72
	BEFhSQQsLvNca2nzXu0l1OY06y/nS6AJz5wZyHRltNXGqRLM0bHNt+1yPT0HiFAb
	Yb1B0i3mf7R8Vt+BiizpO/7WaLhcCko1TSdqYMFP0fThmqNJQtlqBSAwM6wOmESr
	/LCniaT7GdG0RVhu9hRPx44sU5xFL/GHl59/Sc3ify+F42HDKiWM/ddwAALPEdfq
	2QhTH7R3c5hY7pwME5+qAZsBZsUEialXU3a1jMVeHJwC8fCNHVC0PKpKzX3Gv1Jp
	8winSY1KHLLlog7NtRRsLXPn+7Y2c/Xq9TALALu+5Iop2zSw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vvb0sfcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:17:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74928291bc3so3727622b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 07:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502670; x=1753107470;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uYe5JEQ/NJBdGO052CLNtnqKAn42FRtb4sm7urxF55s=;
        b=J03xWl6N0BYIRMTe/Yc16ypjOHehMl6eZA0SAjymUygK3LzCxBM9Pq0QMwOs+Qu8DH
         0r5dymRbvNo6vQGUwArohTRUUFT28rf1GA/v8dDXuniPRWntFP+bTJ7Os/5MXRH+KVV6
         nvUOQlaZ5SjkQ2+pwgM3B0WPku6WjAb5IhGIJ8NIXYBpy0erjDGqUYGAuHYF5xsewPhO
         2b7eX7GpOBq90d+REWyJQcmpRsV99t0O4j3/Ei++BRKY4pAaUuQ3Rb2FSqmWeWgeyemz
         S3LTz5junKMDGrZjQoHspTOzIP1ON2JqDnh71ARTC+p3oNxnZtLNHUtqNrPMN5UD1x60
         ZHLw==
X-Gm-Message-State: AOJu0YxulblKKcQ295BWmHLmfQu9urJBKPDXzNJ6JcAgZialoOOFnoUi
	Qjf96i5oxcngUKHThS5D02pnK9XmafyQC9IjnlfVh8RThhTO3iuGpqKt4G8Fo21bZbxsLpYXgCT
	ySuMXVfzgvaLMplZzbml36Ts26CIxTD7w5tJ7GxH0zH7/aNGplHFkOxOh1+lnoOp4kqfq6Mc3bw
	B6XA==
X-Gm-Gg: ASbGnctySoTeGcWlSVcUiopCj9EvFOad9QqKi0REfJs0IRqunnEa6IKd4L7TwdrOa6S
	WkO4rwgqWeufD/K2MDk2TItJRCmC1TaOg4/Ol60pDkTclc49KlmwR7EVlQBtz2dgnu/1zrc+8H1
	wFbcVnCbZbLG4q9hKnj2lyAjyz72NL9kWCk2Jh/rz6W7hQyYTwqRRAIkFRuxwY0BRC7uvNjIuzj
	vzhHbcgYO3vDRYQ/1OLFaJa3SDd6CNi1PAeMrkD9E2SLRuifmSJEET0Y8tETTIUPa1hrRN4+PUt
	InK1Rgsad8AF8y4tKVF37wwyEupMvG6V/KUwkfRFq+oMSAfJKrRA1YD2WxTYV+sIwIJQirSnCZo
	m
X-Received: by 2002:a05:6a00:2d15:b0:749:112:c172 with SMTP id d2e1a72fcca58-74f1ebccf03mr14544867b3a.16.1752502669692;
        Mon, 14 Jul 2025 07:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgfKx6sUk0FX4r+rgTdQmHFsfNOtS1CTSqL+Sp9TUZPq6HVE3canvzPacPiUNgm7i7hhR8cQ==
X-Received: by 2002:a05:6a00:2d15:b0:749:112:c172 with SMTP id d2e1a72fcca58-74f1ebccf03mr14544818b3a.16.1752502668996;
        Mon, 14 Jul 2025 07:17:48 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm8796236b3a.76.2025.07.14.07.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:17:48 -0700 (PDT)
Message-ID: <eb5bee18-e267-4fe8-9200-5a371a15539b@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 07:17:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20250714
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9fTi2y0EYUyvmgceeYfG-bjK8Weuia68
X-Authority-Analysis: v=2.4 cv=B8e50PtM c=1 sm=1 tr=0 ts=6875118e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Yt6yo0lQyOCnsUEz3GcA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 9fTi2y0EYUyvmgceeYfG-bjK8Weuia68
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NCBTYWx0ZWRfXzexm/4jgWjeB
 8Bh49hd6MS3p7q26YlycHqw1Vvm9fNmC8dgGm0Z4aUeRHmCApFy+E33iShwjainGsgpfXP+z4ic
 fRXC/NRd45PBVF6pAY+dSML8GG83E3EXq9mjD6x9BevPphSpcNFTp9op4anqGXP40mbn/63rsLr
 YsS7Suw7//2moHkRZVZGI6ACRZftJ5fqtdZKEyMzqeUmRG7is+XkOM5DLe8pgS4Qm+prs79mHxP
 aavoRSvoAlgGYT0kSVZy2ilO6QV9FmEJGWC3e1P9OQ6TP1FQZcnSMKapfR8lSBzgglz2tyWCfFD
 3Pe4tUkun9vjARWzpk3n9Rb5VwKEjiOxtdw4wMv/2PBP/1srBB4uZlHkETlPvGOadePioV1zTtA
 9kiMOS/eN85X7GPRmffN4ysdKDUXvgMx3TaStfs8KcKFjQWG0LguwD4VHMtkqtsrHms42uWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=968 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140084

The following changes since commit c07981af55d3ba3ec3be880cfe4a0cc10f1f7138:

  wifi: mac80211: add the virtual monitor after reconfig complete (2025-07-10 13:27:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20250714

for you to fetch changes up to afcefc58fdfd687e3a9a9bef0be5846b96f710b7:

  wifi: ath12k: Fix packets received in WBM error ring with REO LUT enabled (2025-07-11 07:35:02 -0700)

----------------------------------------------------------------
ath.git update for v6.16-rc7

Fix an ath12k performance regression introduce in v6.16-rc1

----------------------------------------------------------------
Nithyanantham Paramasivam (1):
      wifi: ath12k: Fix packets received in WBM error ring with REO LUT enabled

 drivers/net/wireless/ath/ath12k/dp_rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

