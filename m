Return-Path: <linux-wireless+bounces-24581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E901AEAA55
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E641C23634
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70922B8D9;
	Thu, 26 Jun 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mkrdwtVa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80A22655B
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979721; cv=none; b=G2f18lV5pCIqW7+oSK0QMnTZmYUBWICjJiDvKbz/cgIWhAhTLTKRv5tIToCm4mKoZUbeUVf73dqPNa3DUoxnONJA29Pn290Rf5idrS2wDNiamuELxBx3nWAK4JZJhhOLzFqS4fBI5MCrazlR+fi+SzgY+0loPbr97kJpb5cfSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979721; c=relaxed/simple;
	bh=aGM5LD1qa5NLe49bCzF9kzF/NbFh3X7BtIIyFuheF58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cd9nJHVsPV44uQRqS97pNfxjTlCI8aGFZYM8sw/4khZSoFPLUy0WoOaz5LM2J6iDvE7nBM32ZiVtpY/JDNDz4I7kYkWK4SHlONOQKFZi3XQV7LKr85m8Pf6WSmpYo2ysUVRMhqfKeMq3e/AiNffoj3GCbtiWbF79NxQS/nxH1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mkrdwtVa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QIpxIl000444
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R8iy5nJ8Pnes9S9XA4npBQfdAf4WRx02426yZk6TbNM=; b=mkrdwtVaiPknV3+X
	FFiqPwvd8QLZm2M+bLgRTREF2Pnt815jPvjSwuEHzqC84waFThfweavNJUCp/9Fw
	Q57xrZ0f8WzFyJh0HoXDwRwRbl+68Yn0NyodmMRSMtSAWNpXbKBiqY+UVJk1if2h
	QzGGmUp2KlOnF+gJhiCozRT/BPslFLaGcs/G9/ijA4h+vCBMtfXfjeTyFrq2ehoC
	1XF7LxQ7iG097e8Vx52W11j86IfdUTieptQqdnFX2cpFrbnLPAicqEhFzgGvMDCO
	/j1jtqyBED89dQ4pJP/yOof/QnMV4HzUWAFZE5rX8tzzac/2386fJsfxPDfmwGA+
	qiyLRg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rq51wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2349fe994a9so10387105ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979716; x=1751584516;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8iy5nJ8Pnes9S9XA4npBQfdAf4WRx02426yZk6TbNM=;
        b=ait751TzOpZhEd4Qof6sBLMoOk0c6MhZrYW6CYeI4wAq+TCiOuV+B3s2IXrJCh1gje
         To4FXjfLYAfbznqX2buE/r+MIovSy0FuknaqEjeihzo8zfhTrsfcJNS9LMiof5uz9ooA
         RRJMq8cYcvqZqdPVReai3QhgiMu+sDI/N50Eaiz1/B/Uz7SCUu6EluIe+rerNJhxg7mk
         8wVdvGlmJjQgtFLbQD6OT3BQBhfwIfn5or4ax0m0Gb4t8m0+ZRpvtJIpqlcp56kvdGhp
         bdZCzlNvmDskHBN6/vijXbeGF2sKeHGbhVSmr+ZqrbAXZkcATHeebC19FWzmwVgW4h4G
         wneA==
X-Gm-Message-State: AOJu0YyFDN8qBFXgS8gs0gsKmmeS/WyWfC0Syd2s+5rSZXOUVhes3CKQ
	A3dUxd9y+hHSvyGOc7GcnE4BDAn2+bskYuFLZG9VCr2/9Oj2lCitolN3/S7I+5Q38AjWvHQTuFV
	wuy1mAcyD0Bu91tj51bKtW3kMEAXfddWsJzjS8r6y18fDrnIcW+SiCeuF5Jn1+AnjNglZC/fb6m
	6fPg==
X-Gm-Gg: ASbGncuV3EZiXsreo0y2Jwa4rsmJl7j1AsYK0zA5IcoRTKpd9EpRlbgin5XcNM7VUWs
	Hjgm7M6ZV/GBtrJ/L+/N57a8KpqI8Mf0APcG5XNDEHMF4e2udhBA3iucMzICqOJVBXiuCEiiR6e
	bt0Dchb2IWQkzU8BUg2nOP/RyEs80dYXkluWvgAyWA8oZsnHvKLiN7jW6v3VnTXwEDKf0Zi3Xgk
	ceTj3tsRbXbqQly3/jrUARfook8XlUuJhCkvte2SNGDJ2qy6VUnaEud6lUjqdpbMSArz6m3Az2g
	aJQEmApUSDgxi7LEyJyvZ+rWDmKM9vVPKgt4xxmwuaFVg5nJi3+prpPmPbs=
X-Received: by 2002:a17:902:fc8f:b0:234:ed31:fc96 with SMTP id d9443c01a7336-23ac4634852mr15520595ad.26.1750979716086;
        Thu, 26 Jun 2025 16:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlvBXIkNOMO3iFy3WYgD3KgP3YPNJIi5PrYQUcqlYCEBUKPNLcyptk0nUdQ/isj9MUjVbPJQ==
X-Received: by 2002:a17:902:fc8f:b0:234:ed31:fc96 with SMTP id d9443c01a7336-23ac4634852mr15520245ad.26.1750979715701;
        Thu, 26 Jun 2025 16:15:15 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:15 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250530035615.3178480-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250530035615.3178480-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Fix station association
 with Non-TX BSS
Message-Id: <175097971513.153431.7594369522919447345.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685dd486 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=5MRXV6a3SOdtvRoyAP8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMCBTYWx0ZWRfX2zgU/HYuKR8E
 D80EhlrqnEJDUXsflhWR3p7iCjf8AG6QuyBMRIyP0LIjRrP5YL433BH7vgEp+novhAF5dzypCIo
 Z9aDJdxkJ8zH8pwDm84KGP2Sz7T/8zxZmBZYbgSgDmRYqp4kXuaDJILpvo4emtICeu9FAeH3biH
 QpOtehUGTupc/3hiFCz/qc/MvGZPPIDMRv9ynzZ+iR7+g5P65Jzt6RZA9rCKvecVzUUKSHORrS5
 zCxM6ZMvhhrCekYwYMPFjw0xmhE5WKwisS7TZisSkSf+D0OYK41XOgAqp//XrCt68bexgyIBE2n
 AR6afZizoErl+HfIWbhep3T+EZ6HuwuMA0YH2jh9gNK235vNfcK7O0qUIPgJW0Xtv/1C2Xz0bD0
 FGa+RPKaPCACL1k1gbedQDbK3tpDuyDaioMUPNBndjMJL6OOUkk4MhfBQvJuyEidD1RQD//g
X-Proofpoint-ORIG-GUID: 0n4yiu-Pjcjx41jN0KZWy_KwiteK8GHB
X-Proofpoint-GUID: 0n4yiu-Pjcjx41jN0KZWy_KwiteK8GHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=807 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260200


On Fri, 30 May 2025 09:26:13 +0530, Rameshkumar Sundaram wrote:
> Currently, ath12k Station fails to associate to non-transmitting BSS of a
> Multiple BSS set as the scan results from mac80211 does not have
> information about the non-transmitting BSSes. Fix this by advertising
> driver's MBSSID capability.
> Also once STA associates to a Non-Transmitted BSS, instruct the firmware
> to keep track the Non-Tx Profile's presence in the MBSSID beacon
> transmitted by the Transmitting BSS.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Fix station association with MBSSID Non-TX BSS
      commit: 70eeacc1a92a444f4b5777ab19e1c378a5edc8dd
[2/2] wifi: ath12k: Fix beacon reception for sta associated to Non-TX AP
      commit: ce7c93d196bfd2190dc4a0b86deee04e82042ed1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


