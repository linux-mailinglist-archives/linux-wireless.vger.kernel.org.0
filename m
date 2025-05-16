Return-Path: <linux-wireless+bounces-23090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CA5ABA305
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 20:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25541C03A77
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399127FD47;
	Fri, 16 May 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjhXfSGw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6C27FD4E
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420449; cv=none; b=X9bzCHgZAUHxailp29KhGrhoaCsRf7q9unijfDBJL4pJ195V5oUeI3X7Lh5PNSQ3nfzxHRS9JmizIzGMx7jeILwBQ1dezY9Fr+mU1m8qdCFGBqJoCNzyjG80TQ4KduhqPf44CA7twMY9U5yyItMN1+9y/TRhDEIj6NcDeKoHCyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420449; c=relaxed/simple;
	bh=UYZqON+ZFLEFPV8xXlqzXYZdSo6MtDW3hfKSgxkGcq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kRB7c4yRuPXCNKQk6r/7kkVMn38u4DrPWxbC4K6+oShEGLT/fdJeAyDbeHPG8kd4bnxXpK0eiAgzsRQKJbu0pB9oKNqdWECST5r6NJGy5vzZv2DnQIVDJh17D+7Cr1MlRvUMNciZIaXCNGrWLdTC9wlYkvt9qFNXwTnrJvaeipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjhXfSGw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBaj9O014558
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 18:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ep3GVkZ4Eolm/Nd+NWY05dh9tPS7F/FgWegfzyDT6Xw=; b=YjhXfSGwOXSVU8SN
	QXzWuY8kKT06vZJHHqm9AessV+QGtpkVYTHMTHOZqyVHFQ91lBsg6l0xsJKnowk7
	sU/flYvBOMt5mfN1o/6gS35ebrr85vOU2gnnLHo9wSEZvv4+ya+Xq/cUKgHDwM7J
	3FiO3bnHrGciCqjckbO8rR+11lfxYsA9nvlmdG+Y6ShUsPD42YZBSGScArll7P/4
	sqt5GpdOrzoifNV7eG3iLRuSjg4fqf0JCYix5XVO/45GEbeZwhtpJ+ye0xi6g7G6
	YkCj/aegEW6V/+dhH6TrRW2Jo5kgIqkcsNcY4MVQhV/Fu0w29tA4cgZFCXysdCz3
	YBaUZw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpk1cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 18:34:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30e78145dc4so1733758a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 11:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747420446; x=1748025246;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep3GVkZ4Eolm/Nd+NWY05dh9tPS7F/FgWegfzyDT6Xw=;
        b=qdIlcpjVYOSiNDYv9q+ZRBAXmPpbxCBkGYKOsVQn710mxFUFUlvheFs+p3Igsz5bFu
         xxsCXjHQ9mwB81OD0J6V8hD5DJJ/tWA5FDIKL3lvrydP34Seqa3jT148kvqJWkVeV4XZ
         G4oDbH5WhjvGRsIgfvb5lk58XdxgVZFrXj5GiiMmfjbd/IlAQUeSBz3gNTrCRb5XkXbJ
         rtT2UM6SvfIRs3pektUzjyo/m68BUbHJ7UqeaWlxMB3Tb+WoAgLwfV5xNoJrwjx6vZAf
         NqEOdrmhrQYzqTmqZoYnIrActY7GkcD4kti9ZlBMPNmHVOt2nvfsrE4nl5UaGoGA9mNm
         Xg4w==
X-Forwarded-Encrypted: i=1; AJvYcCUF3D97TUl7FL5IiDcRihyxGUpfIlazF5zaIVlZDYWRCYNRSq2g1IDRodymratk1yBPOXZcABXYDp0Rx/SNvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygoVe6reYf9tewHiTiCGVD68Sah5rxnf7pagBWA3TuOG2PXwjl
	8IpK422wj+wi2Uwmvw/yqOgb4GlYE51xS8i43RgVTPzZbNI9ZR1X4L4m6lkPG1C8BwgHObjsRTx
	FQYpFb7ekI+f5R0jDw8FZPY+qi5mtCo/IweZYufRf94z5xwU5R/U0ao1/JGWX1nv/1izOKfGBvC
	eB/Q==
X-Gm-Gg: ASbGncuOcPKpEBy7e8egfg6PFhT5/VW+PDoCc2HdvVnbzRB1ty+O3tGxlE6uTWfvqMh
	Cl0o5wuOMciwjVj012rGT5rKVsWsqPKoA/A7CZKPvV8OkXoR8uVZQglqRTt5TWxIhkGVus27o/6
	QXoj0iHWu1H+BghdpWzx5IMtq4HlFPCjuEVkGTLS2qoS8OGkJLfYSmK+WuVokm9ogiJM/NO2w2c
	k9LUHJU8VQo/bTuzNif504BiznI4JOPCX0kmXneeF+JvSElZbx0FE8+vi32XgjhAVF8lAgpGSDy
	9Er/bBIlRmCE0yG9/9ubP7Y+T0yqfKqBNEwfzWkm6KumKclS
X-Received: by 2002:a17:90b:4cca:b0:30e:8c5d:8ed with SMTP id 98e67ed59e1d1-30e8c5d09a8mr3472352a91.19.1747420445671;
        Fri, 16 May 2025 11:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmwxsYFanrjNojESxjOjstpNSKMOyUoQ43sxObOWZovIg1oLpCDHjqkqvVd1CCMDR5DP9LfA==
X-Received: by 2002:a17:90b:4cca:b0:30e:8c5d:8ed with SMTP id 98e67ed59e1d1-30e8c5d09a8mr3472317a91.19.1747420445236;
        Fri, 16 May 2025 11:34:05 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d576babsm1886299a91.33.2025.05.16.11.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:34:04 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: kvalo@kernel.org, "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Mihai Moldovan <ionic@ionic.de>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20241127022742.4016870-1-quic_yuzha@quicinc.com>
References: <20241127022742.4016870-1-quic_yuzha@quicinc.com>
Subject: Re: [PATCH v3] wifi: ath11k: support DBS and DFS compatibility
Message-Id: <174742044400.3092151.5988875334107442165.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 11:34:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: d7Cg3_ddFi0NLwKhno0zBjczEeUmfKVJ
X-Proofpoint-ORIG-GUID: d7Cg3_ddFi0NLwKhno0zBjczEeUmfKVJ
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=6827851e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=bC-a23v3AAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Fa9wrM33oQaVqebvgmIA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE4MiBTYWx0ZWRfX0L4hHm+cpjOk
 Yn2HWGax9pNwJeCmJtYuIx7qLqA9C4/VKPNf9NtVBM4SWimw/99RSaiNrLwojipqeagVFRsSmvn
 1SYgicVkqT7o0po3KmO5JAUrQGeRyEdqfzyCqrDy3a70W2yrWcvNBApOvCFMtWGFPtFVrAl9+Jw
 oaXo+H55CL673v/i8ySVDljT76TGUq9lcVDwjnCUQTT3A0Aj8quZP7otE6oJiHwAOf7bLIVz7hM
 RgxdFeionU9JMF0aCNZkfXOgf113kYViReI6L6pK6FK4k22j5ZKl1xCiYWUNkdrZI21heOXfFt5
 tD4GRdFKwdrti8xU1AfhmItPSbt5DzB2dc0PU2zysloCo89rlXi1qoEmhO4n9D+Gtf50NRQeQTy
 zIdPADoioYqGLJf3O81m2qj5wlvzUiPgvq3YSpEOAnI0WohnbnlLGESHsHvLTUSJMYZXgKNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=618 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160182


On Wed, 27 Nov 2024 10:27:42 +0800, Yu Zhang(Yuriy) wrote:
> Now some chips which support 'support_dual_stations' will enable DBS,
> but will disable DFS. Restructure the ath11k_mac_setup_iface_combinations
> function to support DBS and DFS compatibility.
> 
> About 'support_dual_station' feature can refer:
> https://msgid.link/20230714023801.2621802-2-quic_cjhuang@quicinc.com
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: support DBS and DFS compatibility
      commit: 6fe9b60f3504c7047451c5b8df14308dad440ff1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


