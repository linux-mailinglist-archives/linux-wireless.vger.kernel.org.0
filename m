Return-Path: <linux-wireless+bounces-23161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBDFABC5D5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 19:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24081171AF9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 17:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C4288C9B;
	Mon, 19 May 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KtHHa4CR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466DC288C3A
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676893; cv=none; b=bg2wGeLIHtv8cZOPvSb1CHkItvCL5brCTwYTb0orRYijwi7KGgpcTCLHQDWkd1Y6GdRZWqBGJOpTB4Tv7l9K+I4sFEPoUWvuH1BXijBWSmHFNpn+4BAcmBb7THPEZMLUjyqAR0/+I34GU9gJgeS7KlrKf0R38lpHVrCtF67tmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676893; c=relaxed/simple;
	bh=m0hkJuL36ikol2X6TVKitP5XRuHeBdEHsBtcWqONzzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HY2SlMyGhg8l8LRGs8UWzDjPjSPJUQuAIMDh0bdhZq7LaFrwjAWabBqLo7k/SOzKE+gCmWyv1Tq3zreiv9ME2hY38NOMoTuewIKBwalNOfQPkAVfNtmbWK6ACzaF5LoJ1FVG2+jM1w97mQgx3Kh7QFotx6QAu9Z5miXsIBmi1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KtHHa4CR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9Swel014865
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lu9IvRz0vgh0VPf2mVMC3ARfT8ah5nL2M6eYMOzKR9U=; b=KtHHa4CRzSgltpAb
	dIOh1BPsaoJ6GB6U4kgkVjdrQFCDSLSxXPAPayXQ9sR+ykW8Gp41NEee7UW+zXYL
	YsnRwPjWa68ur3xQN7fWabYJQ5ahCqcqSQJ4TtRPJeO8R+1HgT47T2pWodjpv1Uv
	DysDaG4dmlGyZ5iAYQ3/2302p0x7jgraIuZAD5EaiEu9YHKUMmobAz9Zznj9eNmQ
	EplUqnVSHS2ibnwJ3i4WgfvD2W/045MqL+DEs34GBwWtP5gndRevHxxJO5q7DQk/
	/8RPjkiacYt93XUu6jYtLj9E/YUfjCmzIfnZid6sIEkn1FCuecmU/jdelyEyLQMk
	aPhQAQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjjsw4hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-231d7f590ffso24132695ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 10:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676889; x=1748281689;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lu9IvRz0vgh0VPf2mVMC3ARfT8ah5nL2M6eYMOzKR9U=;
        b=L0nlpc0HayQ+IhQFcR2cB6PAMXwGiFu3+Gjsi2N1aW4A+tgSNyWtkxB/SlXDgUknaF
         svBgydkiF/XL4cjpVu64BS2Tx3IozqR/s1Z/Ffuo2ZVRVA9Vg5Oze9ir//8mTm016+el
         bVUkV9MMll+au9eAk7meFWzyuWBRy5OcO2Orb/GpzslXv/L9Fycsl72Iw02MUJaiJY1Q
         3Lz32ggKkuIjCeukoIeL6rf1JhKL54G1Zi7T16otoqqH/2M4XpotF0SOupBSEKxav8Ep
         jBU9COtpdvDmbuYV/uc6OEsgORlpeVZTqvmOCMYfaWDzj/XfIZ4CTDaKQwfsR4/bf4mF
         PNBw==
X-Forwarded-Encrypted: i=1; AJvYcCUb82YZAFABCzXKtcbCI5QB1icxJOja094nuJNYXt05VC5KbSWO+sMx9jTwxD80EBZIIwhkv4ySfZLmB3QNOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxer9gzU8PFZJ+gvbpR6Jw4AYhQqsBFnBWCHJ3LrEDXzMJeUxnE
	96xobd4Y5FXRXHVz0jEYByB8DSbfjYKiZ7bcGiOSSV0buJ6SHA2m1Q9/rQDyz4jcbkqcloIMaAn
	yy/JIQ22ufRUyZ7PT4vf6BYZUsvFqoAuSoTt3GGSQsxv05pMjYsdCWcF3btGaKxMQgMyqOg==
X-Gm-Gg: ASbGncuJ/5oM6NAlHonGCP5xbJ3XfmWkSljIyQl5lifpBO35UjfBo2LFK3Y4dQTq5JH
	V8lJoAmuwhhAkH6gxnw/CHtLFm2oY8pkh0hh2CTpKEgxx1sh36XcIPRnZyFROeSYTWkgvS+9kw0
	GSFQneK/KTONFEOJ/tzQIbOApM2NzSYL5AwloRWCD55jhuwy8B0nViuGQcxP/1s6Rfj02pcFAz4
	hR4cHStypDpt7hR7m8eTrmOPcxnQ1LPEFNtspNEQnZzhJUZQk74lMo0vgR+k1P+nfegHxoT9zz+
	bsBe+ys/jLiRxoUhDsnnEDPHrvvqXmv2kOPMhl17Keh386IY
X-Received: by 2002:a17:902:f648:b0:224:f12:3735 with SMTP id d9443c01a7336-231de34468fmr203643055ad.31.1747676888748;
        Mon, 19 May 2025 10:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWucOxXROLeNBzWIWs0QhMZ/i9p54oWNrg+8F7yqrejxyn/eAwE0eL0qCwSOlf9U/ucIR5/Q==
X-Received: by 2002:a17:902:f648:b0:224:f12:3735 with SMTP id d9443c01a7336-231de34468fmr203642695ad.31.1747676888342;
        Mon, 19 May 2025 10:48:08 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe8b0sm62651425ad.89.2025.05.19.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:48:07 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20250424005703.2479907-1-quic_miaoqing@quicinc.com>
References: <20250424005703.2479907-1-quic_miaoqing@quicinc.com>
Subject: Re: [RESEND ath-next 0/2] wifi: ath12k: support usercase-specific
 firmware overrides
Message-Id: <174767688738.2567051.17814529820458546404.b4-ty@oss.qualcomm.com>
Date: Mon, 19 May 2025 10:48:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: CnUz0qi7xq45o-UDBWFWudw3tyWHbx7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2NCBTYWx0ZWRfXzgp2lITkj1rb
 AR29g0RsTQ+GheOanB7t+k2IaTk2+c4hqLuaXAp5wGf7fi4/v0Dl0hs2bL41SbCp73IGc++kFFy
 r+Or/o5MvMUgPm3YiN7fb0CxHfyUO6RQsbvuwYqcU4ZDFtY295e/6qCKjegyhEOgeOzL7C6Q6GN
 /mltf63V4fIcMMWYoLbKQIJwUnTpHJXWjNsz3RhSucU7nkCi4Je2CZVY+QwQ2BPGusykZT3MEP1
 9dyLYC5UQQI8x7WSA/4cLmCBMmIB0i93krLvfuRMaCzo3lChlSOUy4WukbnB9rXDWtlk+oDPLX5
 TVPGEaeHctrz/rQRBGmE5+XO9fkoQbCF2LfOnvaMFFzGRCiRr9GPfigj6vJPSmQfthXTgDNRBsc
 4jtHZ4MENfS6sDvBFuPmOYOE2srco4BiHczi7L+Gb3kB+c+cEEEiFHOTVf/F4WTGYUukJYrs
X-Authority-Analysis: v=2.4 cv=K4giHzWI c=1 sm=1 tr=0 ts=682b6ed9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=ZHLDmf7C8hvfDcYlofMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: CnUz0qi7xq45o-UDBWFWudw3tyWHbx7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 mlxlogscore=885 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190164


On Thu, 24 Apr 2025 08:57:01 +0800, Miaoqing Pan wrote:
> Introduce 'firmware-name' property to allow end-users and/or integrators to
> decide which usecase-specific firmware to run on the WCN7850 platform.
> 
> Miaoqing Pan (2):
>   dt-bindings: net: wireless: ath12k: describe firmware-name property
>   wifi: ath12k: support usercase-specific firmware overrides
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: net: wireless: ath12k: describe firmware-name property
      commit: 607d6e49dae5336bd9f7356b0e227d8571450bd1
[2/2] wifi: ath12k: support usercase-specific firmware overrides
      commit: a9610bc482ef9c77ee0f3b7c077e0b49732769b8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


