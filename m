Return-Path: <linux-wireless+bounces-24587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB478AEAA64
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43FD1C27C0A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35E257AF0;
	Thu, 26 Jun 2025 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ktnzspxm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F225394B
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979727; cv=none; b=D8tbYEIUwqy7rp2Cv6yGGlDqpZVNyQiK9yrhO0Suj3NWVdh4ZrbQZZ3ChQBcWxvkA89/qomxHVkfgBYz9QBvS1Vnn1haK/kX/e+DsiP3HkS+a6xSuX2Gla+N9OGe0bAWy3EXQJhorVPHPT0vwy8I+w3g/DIhE1RqQgqLeuJ4cUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979727; c=relaxed/simple;
	bh=vW15Jg4ggX9gIZnwDizIV0mWZcRQyLuyRNHdO55b2Kg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QkZy3LOwlPYEIpIgOZDzjGnvrz54PjYboN6Q70dQNfyXvQLlC5e8WNPhr5b53/K3wury3ZGQSLWRLQbLXeQZdEl5/WhOpEUwPMJG4JrW+xkRK/KIjcQBIqtBvkgH09+o2aYp5AU7Sk5gxPgX3Rk6tWSGUDxYtmp6Qd9Be2+5GgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ktnzspxm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QKBWM5031338
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S/H0Qgqe8Ttzr2u9kRhRfs75EuPnlrJgM/cVTTvn1kM=; b=ktnzspxmAA6ZEndD
	OGt5QqK6dizC9ot5Yo2VIBXMQnNmkWOqulXMADMg3YQvVOBcsE8iqPzynOU1P4a2
	EHQZgV+yKf+0cvFa7cxPZ40cK5CnFJNLoR4Ng5ra2ROqM03TeXtDytopLLHfeUr7
	SMXq6+f1HISuM0SEG0mazodDIlGpGdaOQlRSNiuTPAKL1o30OBpj5Vp3TJGYDgyL
	cn9gXJMqP8n421Thmm34Q9+EhyNS0LECXmVYOuhFvjdGrAlSVIF0m+ZcYw7zhBy+
	R0SvmkGE6lzLrrTX9XEIeX1a05niQTJKGUYXWJAL36qe9EfRPyxrL+K/ECdfhtjY
	/DuvQA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b44r1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b0e0c573531so911459a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979710; x=1751584510;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/H0Qgqe8Ttzr2u9kRhRfs75EuPnlrJgM/cVTTvn1kM=;
        b=uJElKQ+e8x2aUQZyymFUJxd968lL43kcXyW5Zx/9WnzL1p2mgtw2cyDT3NEz2lBlf9
         10WxQzUNMkkXl3aJY9nKcqizNgERFEt9HDt/2l7CuujDf2NBaY8ioBbAxMfsC18MEagG
         9JlnfEOguHhDuSKTwRMdfk4WDR2vXOOKKcN01bD2eUmnHvXWSMZc75SSw8u6KskOgic8
         BCLHDBrjklLZ03UHZt55Mybxu/HFM7zatuv6BB5Lio+aQl/jM7RVfd+NHezVyefaNcIN
         TAWe2pGQSq+QLdQU65cCs7MKzJj2LI+1xCAlIwxdpR4o1xqzFqEEVe0Y8tBPfSSwT1Vf
         Aspg==
X-Gm-Message-State: AOJu0YyLOhRtP2q632Wpr4d/uH0a4tF+LwKdrp8ibtCp7EJZ33lWM/Uj
	qN4aI2zRU9GnwvwevqFHao5FfeqvumS+6vYRaDZx281WeIb4lhyN34WwrUyB9W1x9cLhYQVX9mY
	31wmfedFljgE1BlFuZmVXcjvA6GByC2SjX9dwPTqH/sjpSNGqESvDVbl9h0IiuOqzyEAHTg==
X-Gm-Gg: ASbGncvnY7tW+8E2R1DVciddbvzLckGnjzdq5JTsY7nRYG4eE+DZrqz3hFB7irLLzKp
	7/FwHXz4igOVwIRV7TO1Ol6RB3f73IUT5w/dA0d8zmf4mPfbiIyFjpxSh1usN2rNdXIBTP6tLE4
	ZqbhUVcveIEqUAaFh6KRCkuJh8JpWwSX9j/HISdZZ2gd8/r7idhYpUk96c/CfUSeNvFdniqhQ+f
	QuXZn5084y54dAURFcDdnR8VzHW/BLGcZPcFDPSFPMZhu/NDAU6Jtn9ZjFQBrybJGl1qgW12BOl
	4ha3899Yc8VpTwvQdwiKMR6z2RuB9fBeDxxKht0AnoIC7hBiDWjsluXaWfY=
X-Received: by 2002:a17:902:c950:b0:22e:6cc6:cf77 with SMTP id d9443c01a7336-23ac4892b49mr13020615ad.53.1750979710306;
        Thu, 26 Jun 2025 16:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkESQ640EkWWC8nNRcJBp88S/Bs4Yykcr1wceJ0RysJiVGp4qVVD1GJLszezOxPjlkSG5Fnw==
X-Received: by 2002:a17:902:c950:b0:22e:6cc6:cf77 with SMTP id d9443c01a7336-23ac4892b49mr13020155ad.53.1750979709822;
        Thu, 26 Jun 2025 16:15:09 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:09 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, nbd@nbd.name,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
In-Reply-To: <20250609030851.17739-1-rosenp@gmail.com>
References: <20250609030851.17739-1-rosenp@gmail.com>
Subject: Re: (subset) [PATCHv5 0/5] wifi: ath9k: add ahb OF support
Message-Id: <175097970896.153431.14153254117038791906.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMCBTYWx0ZWRfX22GGryPzP2Nw
 AJJti1hGI6FYfo2wn788EZ0o0Ea0cIRCFt+ugA+eT8nnVBNmk+luQM/Xyai5Q6PFeYZAgP11DtY
 0B0Egd9yN88ZjNiOsvCtqj48YPH37h0Swix7ohGbnsW/QfRvzgt8k/7ad1W5NYww09VmHs8RwDp
 8tsWuWOrdeUScxp+T347Bh6hh2ojnX8f0nL4NqZ/FPEIq67s1My9xwgkROk3GTf+sh+/39233md
 jx3TVDYnbyRfiOUDnKRRICdzaWPKGJizfnfi7WmarTOjJmTVXuEBsKOfDoy7uYYW1SblsOJLPQC
 tvAoEKGrGe5Vczms3LgC67GjFaeqTyIWt/OBfgsWBj/mo/0KXhZdnNO9ebwst1wz88XpVVMxWuY
 pNYqibK1SlMZZRdgmeWlPVSl4vVxbajmgYiGisnFwgk65vH4TOxvQ49WcRHEY7MtB59Rq6zO
X-Proofpoint-ORIG-GUID: Uf71ZROaSLG1QMFgFh4WlnyDSCyoZ_Ik
X-Proofpoint-GUID: Uf71ZROaSLG1QMFgFh4WlnyDSCyoZ_Ik
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685dd48c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=aMoWnUFRsw3tUzfFL3sA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=724 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260200


On Sun, 08 Jun 2025 20:08:46 -0700, Rosen Penev wrote:
> First two commits are small cleanups to make the changes of the third
> simpler. The fourth actually adds dts definitions to use ahb.
> 
> v2: Add documentation, use kernel_ulong_t, and of_device_get_match_data
> v3: Use qcom prefix and wifi suffix as in other ath drivers.
> v4: fix up dts example in Documentation
> v5: move back to using qca prefix. It makes no sense to diverge between
> all the other drivers for MIPS based qualcomm devices. qcom as a prefix
> is used for Quallcomm's ARM(64) stuff.
> 
> [...]

Applied, thanks!

[1/5] wifi: ath9k: ahb: reorder declarations
      commit: 5cbfef9039f61691c87f522f8761d628033bc392
[2/5] wifi: ath9k: ahb: reorder includes
      commit: c8123302c01936d297e22adbd75cad38c5049f92
[3/5] dt-bindings: net: wireless: ath9k: add WIFI bindings
      commit: f902f2c39a807382353b4c6b8d8d4ac1f03aade9
[4/5] wifi: ath9k: ahb: replace id_table with of
      commit: 2fa490c0d7591918bed267059700f1c9e505e881

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


