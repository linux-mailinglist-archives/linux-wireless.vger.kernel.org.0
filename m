Return-Path: <linux-wireless+bounces-19546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274EAA48651
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 18:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028811882484
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31261DB951;
	Thu, 27 Feb 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BERq+M6+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F01BD000
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676224; cv=none; b=R1+T3PjRBiy2bQ44sMNgqbps6Qi+j8YmxWEPTMc1M4FuUnFjzF/BVqY6RKJIOHZQ7E0bcO5D/BeeZgUzlUwrk9C7q3iuziVxyRp4nS/VtMhej6v4DpRLq/lXGxAMbgNUoSLmRmdx0gm9QPK/JGMm65ghgvnv7mNhTmJh8B56zTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676224; c=relaxed/simple;
	bh=1g9zGpMtV/3hFLrkn0fT/XCmZn80mQtN2HY9mqPIfMI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nuFM3Vv7AA6LJXEQuVMNkHjMEPwZRvET3HKtuuM6/FXgGZDthKywzxp9TOS0yPe1tmAKYegDcDfHfcq6kmDn/UjUOd8jlj86f/ZmdM9NKUFqBOPJt3wRulGJZmEIQXkDONNir5sCoAEacU5+VEjXaVgNoUvLcinq8YFeDKUJdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BERq+M6+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R9SCMM012246
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 17:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TBqpguxGGsbuHVyIoyeYvAcOEVkUt7dp6bLQG0fntUQ=; b=BERq+M6+nBauRddH
	EEW4jz44O3mA6RP8mXiK0q7+x58Wp91sL6LI2Ywy42Y7jSQyzKBAAQlE/z/ibh+w
	UwY0z9dJLNhY+75yX1jU0O0r/4w/hWAnhWiF0dOvnxlhbRkMJ7HT1eFLyltvw5RX
	2f6iw3TSrJrlr5WXauV5NABby1uXa6Oxcl8JuuluDFlAgm+0h4LT5CMN5u0hJMAp
	O7SymVQHZuP/1tSUDlvV9tM4sCgh6zw7gXkd3WxYBOYoCzRVrCIXsuy8dsQ11c0T
	IBKTbtWIXEiFXao3g81e2abtsAvDVdZ9xZMi5TGDkHMr4A45Pfegx8RmFtj9ns9G
	BOnCog==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prk6g95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 17:10:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22366901375so2865555ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 09:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740676220; x=1741281020;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBqpguxGGsbuHVyIoyeYvAcOEVkUt7dp6bLQG0fntUQ=;
        b=JhLsR53yfZh0kFVdcSjMw49049Y9j1a4j5Nc4ifpEQDMAYamUXSBhA950v3CnCoRaX
         7J6MpspPFrFBfMYs/zNd4OT028F8taMKKkwRKBbICG28TdIMHPDxQITEyE6dmIisNFxu
         F96VqkRrcHfZSQ0o9FhcZRtd0W6L3+p0E1f/68SLgmvnDqb1eEqGkZPbkq8JQl1ZGAkx
         Kk/wyUehv/XNco7UKOEXnmSZ55kipc5CWgTKTey/mSavkymatf+7TlP0byZtFiG1hSrN
         cQxtq5SfGaT7uEbL+4V/iZm25q+cdBEqcLClnuq3CpCoP3atTgmWdSzllq0ZJTR2mvlc
         BTyg==
X-Gm-Message-State: AOJu0YwbffGJwMv+wPlWbqYd1yXIwbuVgmaQmEezbdy9vZzme+CZUrQb
	SmPm2u3OWLN+qLi5T3uQVldM7hNkn9DB8l14SadEZIhd44dM3O1p9qTbToj2ERM4Hut4Wdvz9Yl
	uohyNCesuoYLEys3ftM2pPCIQgs++sl9T4ZyVBGuFWnB992ZRfMD38o1dCVvGaaEfYTt9/DXhIg
	==
X-Gm-Gg: ASbGncvl6fFqVHnZ92tumml7ARfgBONZXZNEV6aaZcbQLCjxeFVQzOM8jSWaWS71O18
	8Rllumt1zGYcQZ5Jj8BGkJ9eVtditxCmZxxgjKWwJUkWE9/mS+ivgnnP92lp77Xqw7LIfbeu7tP
	p/n81g0p8/xFn/irIw75B9PeN3U6WBx3beOA00EIdcyG4RwBoIrcoF0xou8TiejTJctiPK59ffZ
	P9TgLSUd2AIyOmhr7b9KVCCSHKfgLmjIsjualvmVdHgcfVBKZfU3V//M1GbGDR85Z3IJwkTbmwp
	2UUDvlvVMJkYE6DEU2AMXomprW0fhKRWy78zrHnm2rsJ6oCfmUxH
X-Received: by 2002:a05:6a00:4c8e:b0:725:f1e9:5334 with SMTP id d2e1a72fcca58-7349d2f3d9emr8293952b3a.8.1740676220212;
        Thu, 27 Feb 2025 09:10:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAgr/wxwNt0KZqGBy+I7l36MHGLD404qGwiZ4rO8yQRGGh2MVohZXLl3ovVhLQ8DhfSndYDw==
X-Received: by 2002:a05:6a00:4c8e:b0:725:f1e9:5334 with SMTP id d2e1a72fcca58-7349d2f3d9emr8293899b3a.8.1740676219808;
        Thu, 27 Feb 2025 09:10:19 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a61fsm1896855b3a.8.2025.02.27.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:10:19 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
In-Reply-To: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
References: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 0/3] wifi: ath11k/ath12k: IRQ affinity fixes
Message-Id: <174067621913.3801911.12667754541994215143.b4-ty@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 09:10:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: 4w09KgJDcBfDhXu-i2ZbX7zrXbjUlAY1
X-Proofpoint-ORIG-GUID: 4w09KgJDcBfDhXu-i2ZbX7zrXbjUlAY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=782 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270128


On Tue, 25 Feb 2025 11:04:44 +0530, Manivannan Sadhasivam wrote:
> This series fixes a warning from kernel IRQ core that gets triggered in the
> error path of QCA6390 probe. While fixing that I also noticed the same issue in
> the ath12k driver, so added an untested patch for the same.
> 
> Finally, updated the irq_set_affinity_hint() API in both drivers as it was
> deprecated.
> 
> [...]

Applied, thanks!

[1/3] wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path
      commit: 68410c5bd381a81bcc92b808e7dc4e6b9ed25d11
[2/3] wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
      commit: b43b1e2c52db77c872bd60d30cdcc72c47df70c7
[3/3] wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with irq_set_affinity_and_hint()
      commit: 6f2d839d11b36c630dbcad2c68613f15409de392

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


