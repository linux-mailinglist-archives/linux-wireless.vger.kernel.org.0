Return-Path: <linux-wireless+bounces-30894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A759BD299D2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2DEC30F06EC
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1E337B97;
	Fri, 16 Jan 2026 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aBdaibP/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EkRr+v2p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F50332903
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526843; cv=none; b=mVN08nfC4ICqb7kg5BI1e4if+HKCUkKT9SVwuEHKL76wlMsr+yI5Tf6QycCbsGUrxKQTuQiQxxo5q9196aOwq45rNdj2rkReN+6FoBk5tmaE499IhUKvksVMeEnruIjMNYshlhgQQdTYURCfGpqHX5ye+kNL+HKFXXGChIEZ5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526843; c=relaxed/simple;
	bh=4ZqNmNPmm7g2PTRWy1h2QPPnCScnhxBfFIFhR8xSzN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JmIuc+SH/fEWT/aK6Jh1XHLmRKWTawguzyabeXrEtZOQyDK4uMs1Yc5nptYrijgX9aQYGs5ebCh0z0DVjTGMbcXwe0N25yaOUUdDnaBa2PonR1Y7KjLO+PXVnfvrx0i5SLq3GWChKYsxiavXz2iqUEiSABoqzlua78o3KZOMKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aBdaibP/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EkRr+v2p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMkug93892921
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mjdVPJuaJGcqmM8YwD5XEL9JXuE48op3hE1XiLG5Jqw=; b=aBdaibP/+zzQCVZs
	od1PsCLsvnGT0Lrw7avsj/rBvEzgNH5TVcSbnT1mue5LcfmexcGR1b+cYKcsmhZa
	Y9pWm1OTQLuxivPA9ti5B98asUzM3Y72LyR0x6gcy2yaynGbWX/Jjms62lmNB/jt
	oJv+IaRmTb8yzfA8JicsuxGZIEAQ7bOgPCPChu2qph3mnLhYWmZhrbRmic0VSCVM
	yiFFXzPARX660zWi5vpg01x0qWRPx1ojpgZ3s5/O4aqFM6+iNUo0hihYbck9JHc/
	D6NLaysEFlYYw8GJZgmpq5da5Ho4Myf6AG/uW6gYTcZtKS42834BDZrIvkE1sFn+
	kAZ+6w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9b08ajq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b6b823d819so786070eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526815; x=1769131615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjdVPJuaJGcqmM8YwD5XEL9JXuE48op3hE1XiLG5Jqw=;
        b=EkRr+v2p/AlxIkmPyMYpl0H6GL3kmD+bZEczW13jFigp9nXg4uv73T9CtvuuH9Pe4k
         KlWLSA77+hD/1k3Ck0jckB5nK+BSdwf3BjBz1LMjtZncQUXW74HMLkyomWaNxCRPzEw9
         R72pDcfANGyYG9NrMk5rh8pH/pUZghCSKxeW2x5+2HNv5CdMR7dSS3qTW28P3SxEXTBd
         xzT9kghR3Sa+kfRKfy16h+gWSz0ZPSOhcY641Eba09korkcb6FFX4Kcse6Uu1P9gL+Jp
         TZVYp/Xy2FNRZ2kYLkkp/qibuvIs9Qpp6EkXS9RLQD2fJchg7udFwI/v51i+9dDhPUJL
         3u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526815; x=1769131615;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mjdVPJuaJGcqmM8YwD5XEL9JXuE48op3hE1XiLG5Jqw=;
        b=eWXAztExrhTmNELWjbjpaseBT/uqddbT63bi9zV0Aq3EOLnrLMFDImq5TvX/MlQPNN
         m8jZ1YQdaHIL0yVdHnHNG/b4+OCaVDeI50ahhsjmU5WA8mCqXsTQMaljviVJAscwVsF7
         gU4EQ7XsuWqx85FLvhypbB09jXJj5Try0MEkUNmuMW0DsXcPlX5wMI4wF28LxGMVYnX+
         vnJOGTSoPNLVj4c5wMxxkTMsuPPqZZmAEftNadD7ck0P5iwSwvsW7GM9KEUmfVg44spG
         aA2Kifh4oI/Pe8q/Eu0CqD9l5elSBI6f64aq1hK7wlVrR6qpZPPvjmPwoS4mhD7QytKf
         Kd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKbfDvxjeqizruTOJW5h2Sa7+LzqyIzEBw2PS86qLpUTWiz09PzNbN11UvaVSxCJ9qpdAveqV4DXqWRbspZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJo2tyNl35V+o1xBuVVjx2iJCkMKKiWC1jTw3oXQLjTIpXl9Y
	h0GEAi6QJthNJkHBtaOSy1KmT2Ig+dhAZH8r2dNbL3ycXNRpd4ku+HurR2tvx4OKqs8kWIKUepE
	MGMa4Pugj08qJmgjt9SO/A6jScmCra1JUSOSD/t/1BcXkLc7X+zm2h2Ow7tnYQiJAGUuOmg==
X-Gm-Gg: AY/fxX7t5H8flEnX8XHk3IhE58QxbOS+/wI7Cs2dsyJxSrg2/w/dR2TFgBgoRiXP5vz
	ijoJxKkwmUfrkJWhT42w8lvHNj0FaDDOWm5Yb74WkLVxyd5PXytCaPFeWhGgo6p7TNug5mIhghH
	hHwk7AqKHnocgAf7QR5AudxE4+SpNaXXWdoXLVVFPsJh7UwtyE8NvIpx+iLK7ThKjAsOWx27kyX
	ZH8+zlEgs4FcEkSZ5s1dwKxM+tvWebYG4ualv5e4dR0o6j9agAuMB0bUb7jyaQkMkyFZkqI8RYd
	mWDVuSavEFtTvb5CdUsKm224ZMx7Wh+C4nYIY1t4PY0bTlraVtELkSxwi0L29DzMPdLsxjfBWF/
	/SpUTuY2L4II/kVHo7+HN/R/OTyV2haZ4mtRwYxZ4LpLaFhrDTVGDoPb2mvYMln0l
X-Received: by 2002:a05:7301:678e:b0:2a4:3593:968d with SMTP id 5a478bee46e88-2b6b3f2ee49mr921372eec.10.1768526814707;
        Thu, 15 Jan 2026 17:26:54 -0800 (PST)
X-Received: by 2002:a05:7301:678e:b0:2a4:3593:968d with SMTP id 5a478bee46e88-2b6b3f2ee49mr921354eec.10.1768526813646;
        Thu, 15 Jan 2026 17:26:53 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:53 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, ath11k@lists.infradead.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: baochen.qiang@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251228151408.2116108-1-mr.nuke.me@gmail.com>
References: <20251228151408.2116108-1-mr.nuke.me@gmail.com>
Subject: Re: [PATCH v3] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
Message-Id: <176852681315.1143034.3902851959710218802.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: eXSNtysD0hbyXV1goS469VqfYPOm_7TY
X-Proofpoint-ORIG-GUID: eXSNtysD0hbyXV1goS469VqfYPOm_7TY
X-Authority-Analysis: v=2.4 cv=TcmbdBQh c=1 sm=1 tr=0 ts=696993e0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=uJMSx7lhC2BmJES397YA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfXwo2d1V/DkP0G
 v6SO0+M9MpMpmkMHPtNAh7NfKK384z9qiSNyE+W++SRya5xYhQlhj0DlQEWmwxCFrMMBF5d1EXL
 sQjLfE8fYZ7xLpisq+xeEeczS96yrtAQPSFMrLKv+vzfhE/BspWLM0ZhFnlsNZ2OSW8plMgp1l9
 8GwjdRUIMpJ3WeXJUSWCKgqwPjui5y1HjOsCaFFQZp/uh9U1PEVkz9jBML3bYylJH5JOuDVXHFG
 kYRdV3HqBS3fD3eBbCo68ThPiRHWtAqWj0X+BR8BXXUMJBoZq7d85M6qBgkfs1BcpUSFQkNha9p
 XCiOl9AwPrDsjzac0SonfbY40fu4RF9/rTb2lMSJ/jRPN3t85U0B/9Fti7K6VniZ435xy7DJY2t
 y8bs0SHT66gUSaHJ2JHKVx6azwuG8b4aNMjrH/AIIlQOt0P6ndCxU8BEI+89T2t6Ze99hWsFb+c
 /Cyg8QxTiqR8xh90eWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Sun, 28 Dec 2025 09:14:05 -0600, Alexandru Gagniuc wrote:
> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
> is initialized in, core.c, a different file than the array. This
> spaghetti-like relation is fragile and not obvious. Accidentally
> setting ".max_tx_ring" too high leads to a hard to track out-of-
> bounds access and memory corruption.
> 
> There is a small ambiguity on the meaning of "max_tx_ring":
>  - The highest ring, max=3 implies there are 4 rings (0, 1, 2, 3)
>  - The highest number to use for array indexing (there are 3 rings)
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params
      commit: b515730ec3d231aa36b6177524532fc7d94f1750

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


