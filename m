Return-Path: <linux-wireless+bounces-30887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A880D29993
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D68230A2E6D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC701334C39;
	Fri, 16 Jan 2026 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXblFprq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D9zmC/JT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985F330B04
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526825; cv=none; b=a5PMWvxW4+uEXX9wyodNOa6476VPYE4j7y8ublFLLSlVNcGQsLFrhl4Oxo2IXpuvANOFA7urVsGT5Zkxkl1f9IzicL5oOLV3JoQE9NNejCKTCyqFJ3u6sOQYIrJTn7NCg6MSD2ZdZOkU38EIP4K3BlKyqhiVZsd5xwqXRDQbAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526825; c=relaxed/simple;
	bh=dFgkWO2Dm0IeNrWSYnaSz8S8ZeooSUicEd/1NlGeIn4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SNlFfCIJnQKFujE8idXQjQu2tB/ogQDQYg2MPrmzoeHGW3PLCgDkMXIT7OdMjIxLR/aCaK3PrIeAdCGHTbABy/ea81bsDEJAOQRStFQFgEdfGekYwERhrvNjSiypFVjZlhrH87El9yn/NTdYAU2eFd/zpFETyka0ZDyYpfaKb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aXblFprq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D9zmC/JT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMchBs4100638
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u0/7TgnXglvXHpjdE+gHZmCF1bpUq+ROebyvEVwJOBI=; b=aXblFprq4XNaMmu1
	Cq7iHkjmOHA8vEIhqypMZx9zOY9yac9ZNZ+mGrbng6gYtsDHRGOeS1dg6iFki9+c
	5GIyLorKt2V+5VU6LkxIV/v4/CTiwm0FVlutLbcHWZxfriYnEg0hoDg74HVl0ptu
	OO1afqk07NXEVampZeBNNiS9N6FeeH43oomgRd31NTmR5rtt6ZhEGPPtGo/6RmYF
	MNnWs5kFvP326F/0J+OGu4py9tn6Gc0iUbdcVcKXu8SIX9MIdAZAKxfUHgcb43Ol
	ljR9MlXm79hu0dPBSdeThQE+s3KsbqYVJH5mNEKxUVVoa/MUVtBBOzcp1wxDuLOH
	oG4ZBA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9750au3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ae32686ed0so9646828eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526812; x=1769131612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0/7TgnXglvXHpjdE+gHZmCF1bpUq+ROebyvEVwJOBI=;
        b=D9zmC/JT4rgd2HmVM2oe8iBsdAIjlRcIFWp8yzkaXiyDxMVDVhqe7DTBElnBihWnqo
         xfnPU3VfwS/EXfBF8V0yRhnd+bKVwFHOEcFqOFrll5dI+lzYzFv0/ETPXXEABPzNHaJh
         rknAk7Wx7qYiySat60on0kV0vo+YuJc8jhRBF59EmcHuv7UhJIfHYPavGHCgZnxhd6NR
         OsrkHMCd0fFAD3r5YlHjTsV5BrtChuxuqx582Xuc4adlRIjmcCp601mXp5j7BaqQKgfQ
         Z/amERa3N7v6VxN+K7lkwfsLbdkVrTL4OoWtFcZjH95z1tolCN4NgFCkf6WZiU4+F071
         RR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526812; x=1769131612;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0/7TgnXglvXHpjdE+gHZmCF1bpUq+ROebyvEVwJOBI=;
        b=m0Bd0yKUKRxbcIFG4UteDaBc4kZmJGHFmJ8jnCRfUpBmKcQtE4QdyLPASnZAac7K5w
         ZTHqaGtsyW7JnAB0OWuQIIQCqu456StiVgcYTsbCiRC7/JyUux+lULxiGhSrjujs+cHZ
         +2tWWUgrHh/D/aF1OHhHL570kAac4eMNU3C81Cqk3a55LjaQg9pVQR7ctwU9p2AeTHrL
         ICyqIEcqh84ezjiSjWqt4Sz0jlZfaumqbIXGAiv8XqGGOjGt4h4guFROoReE3TVqKn6m
         YYtILKEJ1bAwlDb/C/p12EkMKCDpbeEnCMD6m/ushkpg4Z46P+NssJ2rGKCs+kZl7rQH
         qJFA==
X-Gm-Message-State: AOJu0YxQq5fNtm7AXbqww8xapp1LHpuODtm5AGNLPOHnzsB3agcmOcl1
	4HAFGDk1Pb9kSv01TrhgJPvYlKjd+wRId/MwA9m4KrIZhRSGT9dGm6QKrvAc5RF7sxGpqycNwUt
	s84ugjba9AZLcutGPCi6TsJcrPiN4b1yifnTUXdZL7SYtJ6djFzMrV52mLpBK+r2W7Ci88WuYNY
	6I6w==
X-Gm-Gg: AY/fxX4oG+oxjjZl+4J+GFamu/U4h2R4IrnTFzZW1PDfiHzmto1bblysu+9zp5rRCoo
	4eJrPBziKsx+tlT2Vr8qTEeiwXg6GCcWXSGFE9QW6FWNtJlvtHYFGL+932H/+ZHQPPL+h4ZuInK
	85xUIp6214cNTgTaKJLuPtR5io6/Gmr5FH+JVmvy4AsM4Z5qC6oIXulccYZHYYG48W1w5Elsr54
	QD6uDt58rjWJ1bxfJ7cnfwWPoEVV0S7vlycruhVsKInQsUKeeYZH3TSO7gkkRqH+0OOVQrXXG8A
	D/qgYltsvzFZkrN6IJB+D9OnOoWaXEVNfbSkchgxPh9E5mQZqkfI+DUp3Gwn4X/oQFaDuCxI5U6
	5/Uf1oWoZxIuYnaaaJ/MXV9V87M4KyfhxSFtJeevpNePwq/0vdYQ2LfZqIOPGGegb
X-Received: by 2002:a05:693c:2c8d:b0:2b6:ab62:ae74 with SMTP id 5a478bee46e88-2b6b414a149mr1122180eec.35.1768526812001;
        Thu, 15 Jan 2026 17:26:52 -0800 (PST)
X-Received: by 2002:a05:693c:2c8d:b0:2b6:ab62:ae74 with SMTP id 5a478bee46e88-2b6b414a149mr1122168eec.35.1768526811361;
        Thu, 15 Jan 2026 17:26:51 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:50 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251030143041.12027-1-m@xv97.com>
References: <20251030143041.12027-1-m@xv97.com>
Subject: Re: [PATCH] wifi: ath: fix comment typo in monitor mode handling
Message-Id: <176852681078.1143034.12947197593422605136.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfXwFSjVnpH+Ash
 3oJ+cYR5Dxf956pVBgCI0fGPR3WDmRcGGhEvXZb4WjHgITihp1uBZOKENR/e+ri1RB9hPD/urfl
 jGb0M27CLeiU/lXiqRbarLMyAOd697TrBG8JMzRhD+i3P7cWYSi7NwYHMENhrWpsFJLdBNf+fh/
 mVOXhVfWJCcMGgX3BSLzCNec/Otk3f6gf/tqZxNB9bl9TfF+KI11OO64uJ4k7HGoRmQ9EZzrl2h
 XeNQQRUEbDM81iBbiJfrMvyqzTkE3WO9bh3JaGypbFDWz9Cusx9FIQwsv1vR1npjeRq8QUbA4Px
 adiT23vhP/spJVGIBfM1gcgbRVYfD9XG3uWXn4I3MaACI3AHBumDmhDkR8pqcbwcr5aiaBZ28A8
 w6rYuxogKll1BPyrrG/uHSAw5WyGEPeOLgJetoejb3HfccmX8AFFNdChcvlcDC/919bi2CBEqfm
 zu6EiE2pZVV+LAEoUDA==
X-Authority-Analysis: v=2.4 cv=Sv6dKfO0 c=1 sm=1 tr=0 ts=696993dc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: Dgx5h2QobC5Ej1FtiEVfz2YLSRnb5FFW
X-Proofpoint-ORIG-GUID: Dgx5h2QobC5Ej1FtiEVfz2YLSRnb5FFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Thu, 30 Oct 2025 22:30:41 +0800, Chien Wong wrote:
> Correct a typo in the monitor mode comment where "it make" was mistakenly
> used instead of "it doesn't make". The comment explains that the brief
> period where monitor mode appears enabled before being removed is harmless
> in practice.
> Also, use more common phrase "in practice" instead of "in practise".
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath: fix comment typo in monitor mode handling
      commit: 9269caf5a7ff2c0b1f37e06f10eee68d5bf1049e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


