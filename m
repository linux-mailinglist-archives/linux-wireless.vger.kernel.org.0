Return-Path: <linux-wireless+bounces-19624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FCFA4A341
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 20:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE74189D6F4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890927CCDF;
	Fri, 28 Feb 2025 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBsOG+NA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20531230BD8
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772614; cv=none; b=IVrQpXTPp2tI+57bGdj7bRDj5Mv74Ec0N0mh5aDEZr/mZfAzTaGuAJSt4ui0WhYk3mhz5WynwLRB18BtqY2McTIHTYGRCEHPB0dAUOivt7pP45eRVlnR8PY/PfAK0L04vhJ7jDzIaF/XRtke2JQF9S8Sk6fZ7QAx9qtTSjd3Kvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772614; c=relaxed/simple;
	bh=DOFeEJBsUIjHnkovG/KoU5SvDSEiVU99mP5RtiDKJa8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zphc89mLz9ACxcq2TAH3EGWm7OGqKLT+/POqscviQtDO18LdCriEDKm0RaTA74gyRLB8UuCddWLDTHtWBnJOEYtQARrGjoXPylTd3oo+lDDaW8EJqaqsWzRk2JrndFdlFzJJO9ak+9asLb2GXrMTWs04mfICly7pLTwGH6Gp0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBsOG+NA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXHMl001960
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ByesdkJdilz+ehzKjpueUt6R7NGEBY8xqZsdamzsj10=; b=RBsOG+NAEEmt62ql
	SK+o4FUPU6FgBRhO0uUxFRi6/ePQ5hXZMDu5891NMjnebPf8KzGe8u8RxMWW5YJg
	G5d8Lo/jG9mptJVGeWZgAZSVwQExtbttEN7+MEazoNtDcIm5LA8lw9BOfpUjkAWh
	Kf6JENwZSgkj9zhNJkk4+SdPO4c4XsDrUNmQSwc9w3faA5NrhZ/lDshSNwm/3529
	fyfBGq9jhQ2qXOx9Wt+fQlVDu11FQKwkWOWnYVjn717Ta9A0kq5MyqDo5ttgvT13
	JqbK1cGaaCtiFjdIo0pLFiJcSqj6bFZ84TYTIsAUednTBX2X5xUU5g3g8FqA1czN
	Un1VUw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452ynwud0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220cd43c75aso91836935ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 11:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740772609; x=1741377409;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByesdkJdilz+ehzKjpueUt6R7NGEBY8xqZsdamzsj10=;
        b=Lnu+RbtFHHGQ/SUazJ98qVxM5AFw7bSM3PWv2kCTkgKke52Cvt6P/4c2IC+iU8mWfn
         GV9IwpKmv7PN2Qf0zYIpNyMUsB/lcnJ6RGgGDkoOExx6JzAAGZxJn/GjLm2z8JmdYVDs
         l5ZtgmdMbh6BfW5k8JeIOFRtuo/UM+CPs+wGckL8y567QYKBH0gv5x2RQ4+Odw9XywbU
         3k0XghEi7sCK/izaQ19t4SYpI7fwDLaBQtZtAaG+6xf0EOSmDjZtPmou63ISMb582R8T
         mzF5pBCoiEkn3PQkRI8wDC6wlzXp+i1nqmwJHZSaqmbF4H4ZEoZhJEcB8y4KQXNtb7UZ
         wVdQ==
X-Gm-Message-State: AOJu0YwOfawjvaHDtFXBYttskSQ2sTPDt/emjU7CUjYNA2REs1acTcXP
	FBJtw7cE7w5k9fP6tM1n3mpg5WJV3aBHSayV5iKEgRavqy2zfS8rjoicb+m+Isz4WilyeHcXAKK
	wd4YxAkULKjuycOLIDQ7g9BCWjWlv1YCPsxjBnv548sS0l9ayfPfyaEqFeKpL6i/Rww==
X-Gm-Gg: ASbGnctKfFsz6ZkIE19LN0157pP2loNVyIiS9ME50YFiWkOimQDlTHore1g+89uCZap
	CIXVBIAJonRdtaioqNJ9AQA4LxYECmlnh7GVhEKegV0oFHuRmzik3d3lXvYtUPtG+IBJ9mRnxuF
	uIpnxhPyU2SrsV6AVUO9l8genkNVNRy2TQrwpNwf6drtWRMkF/yHlGNSpCk5LjIazJrRiamjGhi
	yULOF8PXjvOlr3RK+sZ0EpmLcw7JRWfFWWG/rBFcVpPyegKNZPZdzw0X6Brl9DbVYT/xowMuBiO
	hPFEND48M5329Gl0UyY2nHx9gjqru9ssxs+3yliDfQ8DG5HcUT2n
X-Received: by 2002:a17:902:d48f:b0:223:3b76:4e07 with SMTP id d9443c01a7336-22368f5fcfdmr79672955ad.4.1740772609293;
        Fri, 28 Feb 2025 11:56:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEoAEj81dI4u+5uZ5w7A+NLRFGQRCca7o6x5FFElmN0c302+N9hshe6ZIHkdpXqZ0wM/ISTA==
X-Received: by 2002:a17:902:d48f:b0:223:3b76:4e07 with SMTP id d9443c01a7336-22368f5fcfdmr79672715ad.4.1740772608970;
        Fri, 28 Feb 2025 11:56:48 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505336ecsm37140165ad.244.2025.02.28.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:56:48 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <20250211090302.4105141-1-tamizh.raja@oss.qualcomm.com>
References: <20250211090302.4105141-1-tamizh.raja@oss.qualcomm.com>
Subject: Re: [PATCHv2] wifi: ath12k: Fix invalid data access in
 ath12k_dp_rx_h_undecap_nwifi
Message-Id: <174077260831.4132177.17474173179510814849.b4-ty@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 11:56:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: FoPACWOZoFnhlbADbb6h6dcyLbJ-bawm
X-Proofpoint-GUID: FoPACWOZoFnhlbADbb6h6dcyLbJ-bawm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=787 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280144


On Tue, 11 Feb 2025 14:33:02 +0530, Tamizh Chelvam Raja wrote:
> In certain cases, hardware might provide packets with a
> length greater than the maximum native Wi-Fi header length.
> This can lead to accessing and modifying fields in the header
> within the ath12k_dp_rx_h_undecap_nwifi function for
> DP_RX_DECAP_TYPE_NATIVE_WIFI decap type and
> potentially resulting in invalid data access and memory corruption.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi
      commit: 9a0dddfb30f120db3851627935851d262e4e7acb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


