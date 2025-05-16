Return-Path: <linux-wireless+bounces-23086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83ABABA1FF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176AA4A833E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC98278756;
	Fri, 16 May 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XqQUiNS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FA2777E3
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417251; cv=none; b=dmAzj6topWKGEongJ5aX6vsT4DgyTf+643Y+Ieolpspow4KG/hyVjR7/B46oeAYg7BU5krew9KZOe6OXglCRJEek3LGhnu1BWHk8TbEWM9EKtgKu60vRW1l5KBsJEqd8rL/VXCEmLbrYIZF1fCQc3MQLPUD+3snBnJMxjF2bQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417251; c=relaxed/simple;
	bh=jG/ckrkV16bWaO/MxjZ0wfaCqOg/mK5Z0V22ANGyr7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nJ3y81OkrAQjyTvM6vYckSkGB40SkTMGiH4lTf9gJtgh79vKzI+Uw4SVmxCF/ZUJdv+ilQvWG5xuTaE3hHXP58C0bTTLe64m6qvC0Mj1Io+KAhWVNds92OUy/A0X4kHUagedGBdfni6GRDd2C3dceoCKiPX1CHLfr4yFSTr6Rtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XqQUiNS0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBkFK7025111
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OYYYIkhOgZCks7bf2vlFMUbm63VtKXu7vPL0cGHE8hg=; b=XqQUiNS0PL0F4tWT
	ev4lcrBfAfaoNNCV+nyE97NkM94NNKYAZF383UlOOqGDmpHX28gqzskGeKOKOxDi
	VC5+SFmHQxlE/nRnM+QwIEdVmr8dR0ussP3bJ6OEIeaWh3nFzZIxwme2g65gDVUe
	oHPI+aq7pdtmQCa8mxzTjT2sOB/gW34y2M33Wl+joEPhepTevtf+NHeTOf+e5TKX
	TNKaiwXLsv9v0/quVgdQJKMCL1JpKYDegj2EpQMaMVwIkK5ZXiJhhZVpYXmxGTPG
	IyXsZI7N6AzpOKNziDglX6l/5LJbwvTb+kvYkW/xQFpPkRST7mBUgFl5c5q2n0m7
	D5g8ng==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcn2y16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b1ffd144867so1124737a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417248; x=1748022048;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYYYIkhOgZCks7bf2vlFMUbm63VtKXu7vPL0cGHE8hg=;
        b=sRDgNTfsgrjBepWaNzL+PJZIeK2t0qyY1vtAR9uoXtNyOWb3g4L6sYcEPi/hGmItV8
         rNfhRDwGZESgcn0vyLBSc+pYDqy+HU8sptgOEC1UZVja4mzIAsHjvYKEg9wtbRwnC+bs
         N/0oCvWGrcCqnBoRoKPmPZANDgmaOGV39WAJZ7LIQi+Slkr9Ar5hFYuADLzVkdJGFxRR
         qribq8hwSirJf6izsBZ+u/UNu/s3G2IdElpbfsLrxn4zp/wOkhSXux2CT9dUqFfRAIzg
         1nRA3CkRMgUOh00Qvt+c7gqamDzsRem7VA1es6TPJFf4pSIATizvmeZ1A3hHyeCWaNyp
         tYrg==
X-Gm-Message-State: AOJu0Yyzj8GWGWb9RuGgOcP/4brFKN6qbUFFqm8GY8AhAwbtj2ADvmE6
	hL2RGPjAqaS9z7rzS1+G7ZFC5NTj0f61D8pkoaNi+37/ovAjGnDEypfvW4hngNUJCbDxnPG13li
	v7uaD1/1JLe1KzgdlgG1whVIiF8N74Sg6jclfI/Qz3z9ye7Gawg5YNP/sfvSu2CzxsnEwhQ==
X-Gm-Gg: ASbGnctgjA5Bvnl5EGfy0sKof2aDvIQXCng0vSCSQniusLi+6vE5kNRLiBHaCs2NJpO
	GFtnoSV0nbA4DO4RrTQLSuwaT+uH1J2VLq8IfTqbdOYCUicZ+6HN32zZuveabkpWYAzgpAAbDpO
	Z2cjVWYVwsr/MVFyvhQWYH26MzosKTu2EcKwEUJwW3OxR07jvrVHhw9UVYWWlRxOH3panbH9Rec
	3BqdXW9E/Gf4jnAvoNpWqq+VulLoQfk28lNh0FTXHoYLNVHK9tl7Nwa9XPe9FtENQq2B/U+Rk4T
	MvmVINERFQI3KLUdQ8brWeUtmHvr5Tgv7K9cItgsqz82mg4X
X-Received: by 2002:a17:903:11c6:b0:216:6283:5a8c with SMTP id d9443c01a7336-231de370f04mr40949035ad.39.1747417248449;
        Fri, 16 May 2025 10:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbOhxGp/5Y26jPBRYigTgBT2fqhDZibBzzCDxwoOF3qU7F17OUCBtbwUaLfsqf/k9ZfuCzEA==
X-Received: by 2002:a17:903:11c6:b0:216:6283:5a8c with SMTP id d9443c01a7336-231de370f04mr40948725ad.39.1747417248028;
        Fri, 16 May 2025 10:40:48 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ade573sm16994125ad.80.2025.05.16.10.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:40:47 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250421040044.44887-1-rosenp@gmail.com>
References: <20250421040044.44887-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] wifi: ath9k: ahb: do ioremap resource in one step
Message-Id: <174741724683.2935573.9349928860978714588.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 10:40:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: EKo4dBNnw2wUvyohdbwNeknWgvafk8VP
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=682778a1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=CHUqY5kqh3KTGWwiF1UA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: EKo4dBNnw2wUvyohdbwNeknWgvafk8VP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3MiBTYWx0ZWRfX7c5mUI2/RZnT
 sBrjewAMy2FbAH1Jd4pUFqb+1eDauVi+akCiobAL8HrXNoC5gZcDwYsJbqA8tbKc7FzqLvDisXV
 ujsrlO2nZNjozlKHD4LXY/FTFkbLBj4Ga3Hmq2Q23TnuGKgpGZJTeF8XIvFMYL1adaq3PosRfDL
 Xv+sSvDYjcx9uMSqa6SvE+H1QBhOoE37mlgoUeurM2eGEjS6TdOF2pe9sAh90g13ZjG9Ls2wh+f
 XGHHB6uuRXPw9YjH3CeDlPa3cUYLik5tmZBMgOvuMnYOr8AHCvqA7TffpRzBRl009UUk+zgF3AW
 4VlhjxmNjW1lc8uvyeJgeR6MKh8K4uiMRReFw1iN5wdHMgqJJ9jyTC7JvMD62lCMHfrqmO+SCS6
 1YcrM2L25i/Nj4NgkN4bbC1iiLW59K2X0D9cgPVqInNvWz63kJRFk/mLj/odXa+pNBwJvqG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=874 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160172


On Sun, 20 Apr 2025 21:00:44 -0700, Rosen Penev wrote:
> Simplifies probe slightly and adds extra error codes.
> 
> Switching from devm_ioremap to the platform variant ends up calling
> devm_request_mem_region, which reserves the memory region for the
> various wmacs. Per board, there is only one wmac and after some fairly
> thorough analysis, there are no overlapping memory regions between wmacs
> and other devices on the ahb.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k: ahb: do ioremap resource in one step
      commit: b4206774fe8231187e5863ff861160db77d4960b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


