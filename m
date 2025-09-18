Return-Path: <linux-wireless+bounces-27497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAF1B87676
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9207D1CC0A02
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480D2F3614;
	Thu, 18 Sep 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oaA/ldx0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3E258ED5
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239248; cv=none; b=m+utzmRBR4aOGxNZDKUCPAhLF/hhZh55E3hX+RZZodqY4/sH88Fh7vFLWwkdgjPssCWj61GnUqIdZtst4f4bs03fWPuYY4HAPt2CjXmMNhWO4VFwuaKADlBsXfPMKstuh5WuJBPociqiznw2nRhFeegTHJQnwx0Ggz/uzSprbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239248; c=relaxed/simple;
	bh=R8puX3U9XJYMyTcO+xR97ZV0SpZpIpc9hjqEwLgQV7c=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e7KwmA/CP0H/8O8c2Olh0Z3aUfWrJelj/CsHOijaIsYGlFm5SktwvnlwA6BU5HemDdJA1RezfO7r6/8N2gDJ02ez/o528G4+uqiRJoui6UYDA6qANoShkQODaVeIn3kPsZBU2V+YltLrW6XdQEQ9E6PalN5Jnr7+strTQPKiLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oaA/ldx0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIE9l4026833
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EIYv1Q/LS+olihYR4J7ufgWOIgKK4Xs4qTjeAv901I0=; b=oaA/ldx0xd0MuzT6
	6zafpzrGhymRgMeZJkkx/jvy6HRqfzz7p4ogRULjignh5z8GcwE7Yuda7N/vYtIy
	89fWVwsow45fHKMVP7Ac2js+wXp/yoXXGPt/dA5Bi5lxZ12sR1ZvXfrPseyyzelP
	iZD4tT1KbVEKxJrYu8UVHmMLT7p9mwPjAsSIX/i5McZWwr4uh8KKhIvsETc3pBXX
	TWFFK/JCM41dFeYhuyOcD6a5txnNWF5RcLcy7MQhvyaAXqzNbmw+WeEFNqsU6Nrq
	o4WIWSGxO3gapWokN9WZT5QCdhA2vTtEe3Fd+3mg1WxscDGn2QX4xeAV22YIc/4Q
	V1N+mA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt8ead-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2699ebc0319so9233035ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239245; x=1758844045;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIYv1Q/LS+olihYR4J7ufgWOIgKK4Xs4qTjeAv901I0=;
        b=RWaRVhalq6GyP4xkIevNZFpSNyJ4QI8yYEuIqIekLC4xTxMeJTxVmQzL5pQczEzSId
         t0UJurKObAdIEy7/oDiKlhAl1dDfZY0IF88NOtvlMDPyU8iFGzdkqdx9DmZkr/DKB9/r
         A0AJtAxTcNm4WZxZaW1xohWKDVvAz3Bq2s/s+KMmVeKNlejKhtFVJSUximqtz+zAt5cI
         wUYZghiksSqUPS5NgIcWXJLRxR++HDsN4zl6XIeeqHnkF8epCbnVZOSIQyHbfagrCLdh
         eyG/GO2dLH7NCQ6IlGU5B9YmiitgJd67JrfeeBvNnh2h4+Xk3Nc5yVM4JBKYj+OCAxoy
         SZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWV6vpyiHEwCkn9wdTvs/CUJQ2AiCTuY8ZmkTAdd1y23Sqxt9p9TC3xVez5VYaIFl4+LGUXc3sDaDXD5Y7cA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTwl6j6L5JpRJl7P3jS1hVjkuXavtILJLKCxPaokt1hPB+DLth
	o6Uhpl9sFnvNKkP03/1t9fOqqCWVpOvR/lzoQekIGzHwL9k6k830/R5cPppVXu5HlZU8bt8NduZ
	DczTVmuRMP1fAtj0Sagk0EPrNY8MJPac9wPxdr8JPstkjXV2cbS0owW1ngxKSqnzfhTgipA==
X-Gm-Gg: ASbGncsfj8vffWBUkDC/Z+AsePDiBcoNeJdeeWNxREk3c6QjPWc4HLFpOjWfMxZ3LE/
	7vBfAtmD4kz/5V/Q4NBSCD69euIa11G9cI/lWnGo3CdDaX9SodbYNlaPj4OyPOAdjqKkg4acmHG
	rPU6pIGmDsMfmWIs4jakGnEoDk+cMPQIiZERNFXhBwyZPMwkISdkL6F/BzkWu6X2/1ynkMUVpbp
	wMCz8As9VGnAsoa9Ofc5lxaIPIMFwrUxMP8GP+jybnuUNHWbVP4SadebImDmae+sgdBCNEgx13Q
	clrJ8s1s2EXoVUeGZBFPYRwdeeItelhEGfa1USxrbXSH/FXKnIsL8Ku2hjA//Uw+nVdtftDd3YT
	X
X-Received: by 2002:a17:903:1aa7:b0:25a:24f2:af00 with SMTP id d9443c01a7336-269ba3f713dmr17871275ad.12.1758239244910;
        Thu, 18 Sep 2025 16:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBHBmTbENww6k5cyImZxHZGIMiaWZFVHZNL2EGbASC3C+jWBqojatumStFjNNCRCnzlogXaA==
X-Received: by 2002:a17:903:1aa7:b0:25a:24f2:af00 with SMTP id d9443c01a7336-269ba3f713dmr17871035ad.12.1758239244444;
        Thu, 18 Sep 2025 16:47:24 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:23 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Anilkumar Kolli <quic_akolli@quicinc.com>,
        Ganesh Sesetti <gseset@codeaurora.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Muna Sinada <quic_msinada@quicinc.com>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <20250812075259.6921-1-liaoyuanhong@vivo.com>
References: <20250812075259.6921-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] wifi: ath11k: Remove redundant semicolons
Message-Id: <175823924328.3217488.17396807847892387535.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: ue3fxDDvP_8XcbBMHbf-w-PwPzBn0gTJ
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cc9a0d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=kxkDnzsp24BEM6lp86oA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXx4kjCEcOE9Wr
 SKAqLXwup2LZK3Eamq2te58MDQrGSRoKz2BFwlK1RFtLLIrvuG1x+br2FwqK8CTBDx8uEz9cDBu
 dNWJqIObwjCKluVkfpaCDts3Hw4j7JYlKtVqXQAHSlnm/HvOTcp9DJyKrZqWnCjBwsjaLGzCIt/
 KKm3/5aT239ELzljnazuzU6O1NVJHc5yUlwmzRLJZCG5TDXCqo/W2g5sIjhgrxyqd4bknhdHZUt
 BcBbJ3qoJnfVqYTWwC1qbEj/ylTo0y3ukDD8H4wzD4Lz/H6zRsElddGvqAOyj/rIxo8QwbFrSGa
 8W4rkb29NR2vK3lzy4oU8fTqqok++W1k9yhR7aDDbdJgQ7t463+Q2peT3m2fIfSPcAiumQxh+KB
 boMNybfX
X-Proofpoint-ORIG-GUID: ue3fxDDvP_8XcbBMHbf-w-PwPzBn0gTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202


On Tue, 12 Aug 2025 15:52:58 +0800, Liao Yuanhong wrote:
> Remove unnecessary semicolons.
> 
> 

Applied, thanks!

[1/1] wifi: ath11k: Remove redundant semicolons
      commit: 2418fcf2006804425c12d85479b9ad17c4db5e90

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


