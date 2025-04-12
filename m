Return-Path: <linux-wireless+bounces-21461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EAAA86AC3
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 06:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDFD1B841AC
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 04:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C3117084F;
	Sat, 12 Apr 2025 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RV4dFO4K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA661132111
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431853; cv=none; b=XiT6r2H/kTtKIfsbMZD8xnRQOJPRjDGX3YN3uHg8VYnmTQCMMOXS0jDzXu7LVaVdCbTvqJ+6zKFAlw78kiqlV3f1y0Dfn0O7zNoFPcNdQoX/YP8XoYCVozcAna+3veaEuWbrN1WLLYopdI2UeTVbBEhCwcY7jcnvzBySob/T9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431853; c=relaxed/simple;
	bh=pc3QLyGRS3WeJa2O8oRhdEoc8MmaxBb+lN6USlBmKEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oiVx5W7aSjG5WG4COCmkODPP5QdRr+JnLGbuDojETS0yznp6C+cGsz8y73Wx0BbrqntlTsRiDOnK0Q1aWPdDuxjLpxS9NxHpjk9uj4yQjpuEC7U9NJksJI2sVj6S2C+k6CVLf/snFknCuAf+PPwgR7AT4Y7pXexWpAJbFJ27ckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RV4dFO4K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C4LIEk004346
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MHhxVnAGB9Zoh9+suD3lVtuipknXqR2QPNNThDAj9x0=; b=RV4dFO4K3N3xTXXi
	o4PUK1M+Hy47iUB7rHTx1Ye5e9UZRI57KH1Tpd2bQXFCbtelyeiZqM922ZzKPtzb
	daGhZfrg9scNWaBAAjK7bSlZ5KQB5agq45vT84VgE4JuCpT4Ve98LbzMtdp3w3Tx
	P72x82i95vT6yCXZFhnBI2RccX+mJdgu1CH3vp9G4FY/ttc6opG2Ee3pkX2GldWX
	soo9eUubImqiNy48D7S2py79VlmOAQQGl8KQ4zUCQabrIz7Y/nNaL+vNHexjRe3M
	8o078f9BP3M7/PdoULlnKhBk3TOkwkoUNB8yyDE7xZZ6v3TBpHPSln0o1VyEXW60
	NjXuMQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtbcd1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so2477786a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 21:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431850; x=1745036650;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHhxVnAGB9Zoh9+suD3lVtuipknXqR2QPNNThDAj9x0=;
        b=tHyQCbPbOv5E7Bb7EkWQLy4G56bxzMhORjtQfeYEyFuaQqNsLQtigTjGvnBA83tQTU
         8LitpIs9mcFSrLpaa/5ctxIPHZotnWTFAxAFB0OWthv/0QctrR/DC5AZcJ7R30bkDzkb
         Q97J8snyIeXbqNubIslSRlRhp/I49Axesh58VytVn4jbHuHz5fiG72kqLJZy+CzSTTi3
         T41+qdaYb+3fs7YYKmS0LRHx+Y511SuoyhVaZIwqUyucuz6gzLbvAJSBTW3mmsGxvzVn
         iqoJ/yY01RJZ5liR6c1HbbaLk1Ynfueiu58BaPIYtElvxbq7ng3B0F0XkIzxNOxnvSg/
         rlwg==
X-Gm-Message-State: AOJu0Yyuj4DHxwBw2t20zYzQODDTMxbJ+9m0aUyGpMT7v/aZAICakxGX
	AzvJtDXBDzUFY+SQXzCjS0dD+606mIejDh3GHs7GQHsSnwj+nu8sTAFnWyC1S1hAmgN16tiKcYy
	eUh+lLQquPj0jMTM2DEILIcaF9lbJxIL9p/XtxW+jwQTiNY/DHOjuQkHB1XIQJQ1DWQ==
X-Gm-Gg: ASbGncudJHvEmNwZpuzDkjyp1hL+R/dxAkeiJiJdRewrXXO4hv74roZKzhnsNp527gt
	6gdR2ETqzpeT3zuOPhqAaJJ1X2EUHbdpqFXBGgHryO75zlFrlB8Cze2v9v5EzVh+oNXXS1KDlr5
	EfCM4009EEiiPlH9PYUfos0dwhMTvrG7sk/2xaRJIqPu0rpIGytitoZspyelJ8stRBi9bccXn2s
	UhS6TKVewibq9tQ+XHPQ7RmXssk3NgO2sPxJRff+LRAMD10qCo2tkZZQDBXzo97mNHpCu6PkXjn
	1BxB385wBi9M1apr1vU4xwJAY5OTjfTlPf0+tTb4sORg0q1+
X-Received: by 2002:a17:90b:5687:b0:2f1:3355:4a8f with SMTP id 98e67ed59e1d1-3082365a323mr8373951a91.4.1744431849848;
        Fri, 11 Apr 2025 21:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpLTEg2vWkUaoeaii00C38pjWMEPsiGj3v+UFlZWzDpgVqMQsxb8I9hd2bX5qPwxKfrzYZsw==
X-Received: by 2002:a17:90b:5687:b0:2f1:3355:4a8f with SMTP id 98e67ed59e1d1-3082365a323mr8373917a91.4.1744431849298;
        Fri, 11 Apr 2025 21:24:09 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm6829912a91.12.2025.04.11.21.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:24:08 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Kang Yang <quic_kangyang@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250403-ath12k-cleanup-v1-1-ad8f67b0e9cf@quicinc.com>
References: <20250403-ath12k-cleanup-v1-1-ad8f67b0e9cf@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix cleanup path after mhi init
Message-Id: <174443184853.2972989.14317890740141451684.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 21:24:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: lDoF-Q09oYA8Je-40DfnOOx178rwjzQs
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f9eaea cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=9DHkI-QYbg47g42TtbkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: lDoF-Q09oYA8Je-40DfnOOx178rwjzQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=978 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120029


On Thu, 03 Apr 2025 15:34:29 +0530, Raj Kumar Bhagat wrote:
> Currently, the 'err_pci_msi_free' label is misplaced, causing the cleanup
> sequence to be incorrect. Fix this by moving the 'err_pci_msi_free' label
> to the correct position after 'err_irq_affinity_cleanup'.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix cleanup path after mhi init
      commit: 6177c97fb6f05bf0473a2806e3bece7e77693209

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


