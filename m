Return-Path: <linux-wireless+bounces-21463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FABA86AC5
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 06:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F641B84232
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 04:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0718A6B6;
	Sat, 12 Apr 2025 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="on7bo2z6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E49A17C208
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431855; cv=none; b=Su2U/kcSszVNuTNaMueaff6guTa1WX2Ur/QGYUQXCw470QPYD5N21MJdjaCmZkWfZJo4rGPFAoDTkD7i0u+tHK6y3TLFCxBIPm4Q1ppu2JAWe2JQaC2nIjKWimrSOuww314fGlSyKNYfVTbQGp+txfmdOIi8KgausGT7WT+SN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431855; c=relaxed/simple;
	bh=PFvh4pive3e09ePw5Oyegr7GcTOUtwqaOjnGbiV0UXY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sIIc0DtcmMjE9KeMHDmarMIrKKDCz81bT7fU1Qx1u59P6cjNFKdvZaB/ordXqEhvfhEvYIaQ7GQZvl+vvQMeYBEwAlD2y67aV+ZL6eH8WBq4ZS/VcsYBHkQBVoQCtYvLFiBgp90C5N68kim7HZCtO63Q3d8SYhZCGhgc7ApnRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=on7bo2z6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C3julQ016412
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	spgQavvN18V0dYsI38aehqIq/Bq+44upIzeuFErbrYs=; b=on7bo2z6YMbf3s6k
	l5Uiy2UIoOA115bzRo6/qKQ+0eSWtmgWPJBjWTiIw1VyvvgJRhOSktTJGJZBq13d
	p84xLN0JAdBIyRH/NfGoykWGWAr85pVtXpSVSrCmlylR0ggUXa9Jt2+XSJ1j1ntO
	T9DbtKRKkuAevPXOn/RNPX8d5NToHADWALgEMxypwKc7UAjTLZy0Yess2rL0Eb2B
	squMoMvJm314hPZPTSygj1avUXvtWVxajxyzUT8C7XvPplUK6nA+xehv05EOwQHQ
	mdEqXbOYPkzD3GeUuMC5A6KRTFMqHxg0D/hrmFc5fgXEt0kvG9vRZO4B+hkEzVA/
	TWMdCg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtbcd1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso4023851a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 21:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431851; x=1745036651;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spgQavvN18V0dYsI38aehqIq/Bq+44upIzeuFErbrYs=;
        b=aSC0EmvqwbnA2zWNPCimpBvEvVYzHANUKGS/VdPwKFwdn2OIGk0B/wLHlZnL9UyUKx
         Tj71pO66u5mCjVVMUGv4gQrG/MglhzRvo68/CvdPdiQ4ziHawb1twMZMFiG9EOicBTt0
         OM5zJe2rBUTZRuNX42ZnSpyw50UsIowDxdNB07IeOwofSKej2vaNrObNXdbUIG86TjiV
         nfSmnX6U/NXkYKMjwbmjiAkPIT/Vcf5pDlSB/mwDnr1uzn51yM/H9aJy+0ITbyLr23+J
         LSfSp3u1MTCW+jIMo6jpl8vmT3z6adfWXxHAi2eMDCwXyJ8i5RZ1+/9SdMm5GcHgoO7c
         JM1Q==
X-Gm-Message-State: AOJu0YwTxgNfyMKR7eDOmKhcPeuXYrwT1sZB1xp4l/WR3FAqKp434puR
	x1lUjJuqP1Vc0rrK0Y/DSwt/XBj6YdF2a3iBbKvG/OBi149mf2/6Lxf+XkoCdaN1KZ6jWoGYZP/
	/4VU8ImMu5E9XBGjb3LM2A/ee4XP6tPYDpaUV32Ms8vaCGqOSYGTz6SQWiAuKREWkLnrpRTwoGQ
	==
X-Gm-Gg: ASbGncu7w6Lma4/J2rclvcTZTRXBE4cO1KARqN/1CkGuvc1H5XvuuwTvFz2eeYwwtH5
	ME9MV80uBtyrSDkS5kkfgUIYbrGwM3V51bWJ5WK2/PgpBx57wJS+PAiVKJiZHI6ZupkAcMrfx5G
	thHyjxGU59AabddPqYfrOHQn+95uhpTkCQH1oQJWVWuiOgDsVd/3zy9IeiruztIOLHHU+QHhK7O
	2NSvKM7I5977jnTip0AHuRlG7w272dkvsTayDeFm7LsD1LTJkC6Zag+we1brFZ1/t9eNd9YRBbw
	ew5ZIiU7kg7WNU2PfMZkK0tH8EchN4lcO6AYmBr261RZa47Z
X-Received: by 2002:a17:90b:5246:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-3082364973fmr9752785a91.18.1744431851553;
        Fri, 11 Apr 2025 21:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+ExO9uJV9mn3ySOMN0Z/YJ1z38Veu0tv7RzvCmngbt+TKVU6ZXe1nGADd4G0S/sz8JqyvHQ==
X-Received: by 2002:a17:90b:5246:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-3082364973fmr9752750a91.18.1744431851042;
        Fri, 11 Apr 2025 21:24:11 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm6829912a91.12.2025.04.11.21.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:24:10 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Thomas Wu <quic_wthomas@quicinc.com>
In-Reply-To: <20250409053830.4039467-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250409053830.4039467-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Disable broadcast TWT
 feature in HE MAC capabilities
Message-Id: <174443185037.2972989.6697785457699340604.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 21:24:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: DXpB9CSH5jTqkr70gFgH6vsMHPF3sKh4
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f9eaec cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=uXoGulTGKWFQ220xZdsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: DXpB9CSH5jTqkr70gFgH6vsMHPF3sKh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=732 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120029


On Wed, 09 Apr 2025 11:08:30 +0530, Aaradhana Sahu wrote:
> Currently, the AP does not support the broadcast target wake time (TWT)
> feature. Therefore, disable the broadcast TWT feature in the HE MAC
> capabilities element field.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Disable broadcast TWT feature in HE MAC capabilities
      commit: cfe8af4b5626354f20794f1d54c9b9069638ccd3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


