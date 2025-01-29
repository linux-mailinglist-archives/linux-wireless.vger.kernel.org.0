Return-Path: <linux-wireless+bounces-18159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A845EA22277
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 18:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5A01638FD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576D15666D;
	Wed, 29 Jan 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QRtBsHpt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04B17A5A4
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170239; cv=none; b=jF9x5UaKB13n5Bw53qCG5QAEppqmoFM86wbedMiP1tXnnOabNEz5iBs1UMirUTAMZuBZbuhdBZ5yEfU3xYdje1Am02MRzALvyaprf+DZN9+KrmitC0FUtNYdbGUAbPzRRv7KN7yw9ID45RO3Up+g6nzS5tLsbKiNRrxWZy6l3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170239; c=relaxed/simple;
	bh=V9crMbVIP8+vinbtlmt+HlQD0N5QnM5Jyt/th8QNvIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KJ2SSpMs8LezJabQSveeeC5K1S1TEOxZznqQRNL7a/MYDjHLi5dmkeGDO2BX/Ex/CU/y5Yw8H9N4iITHfy6hpw4X2fj7eEtw1MBjLUnUd1KAOzVJHA9LpG7eqqwHmPkr87MeBtt8AtICLoMOt+3Tmv6duO5zAvR+g61tpGO6/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QRtBsHpt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T6OcwR004260
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cCYxhKn4B4q2UzXNaKibV8fc0rPbgSiq2cv6hbxdtdo=; b=QRtBsHptoKTvmVGi
	uVsXVo6pAu3mxOeC8ThgGvf4mIUNB3DXAkS6l8P/ELivSHxldVEUVOPyEPLhwIz0
	FXxIUYKEy9ZzXl47mZra+RtKspygzEGa7HwbQikLjNyrkQUH36Ei5+MZopuxouAg
	7qqilGHWziLoUSgMryr6h7P35nYgjH+eRtpba88gI+0MI52CIyk31tO/5kzJqpj0
	CVUuCZtoD1R2vR7RmiDfjFaqYpyb5ULcWoz7KartSFLTdasqEHg0kbpe4cixTfjK
	Tflyma79gcR0UBQURhZgKSpc58/OZt/OohgO2NHvL2sKfTLuOTRPk6OZQNC0UlOh
	/mVx6Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ff1q16h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:03:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso13602753a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738170236; x=1738775036;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCYxhKn4B4q2UzXNaKibV8fc0rPbgSiq2cv6hbxdtdo=;
        b=PwdBAO3SDMs+AuLQEm7A8SJ8xWYzFQQb81euqm1ElWH6mqolAJXPHQ6R8tTiyzR7Us
         sI+kj1GfK8DQuVR4Jo3Y/W+UfNjISpUByJK5vOdREfM5mGFpq9t2xNlpjnl5KGA/nDTZ
         NnD24S19pgQOv3qFCAkYKvuafiTHwkPvniH4f7xKAfJPjLF3r4HbkSnrYc3gOvgWEJPQ
         7rZmux7w0p0/N7Ymk7OoTHANkv6dgJ4+MS+32CXry1exSnyaSCHBN3fyw0fih79uIV16
         uAr6xuLCzBodB8EK2iP8Rvjk32LQp0g9Kd3spuPvqox+leoCxrXcoFEbZqPGbqCUK+eV
         zKoA==
X-Gm-Message-State: AOJu0Yz2Z1/mgN/loPFPd0s4L1XFdYOhWZ514XdEPGKpA3QGr3APk3aP
	s7T3gOyUM8DPgiX0VuqwU4NDKQbSxIUSW5YnPmfRaMFpZsgncHyazSX2wUVNOwX5xWdR5lcE61r
	7CiBZXTDalZdE5X2olYMvCY3PuN5Zwb3dhQjxJNzrnNHipkVGCjbJrOhTFhRaAVirwy0dheK7Fw
	==
X-Gm-Gg: ASbGncsfyhDmsYoDMDBNjOwitQ8OuDN/sj9wW96Fl2DE79n6hkiJoGnZZhjSwJwdqd8
	F8EsHqVZxwlxPG+IWET7Q3Qot/dnfJFonJpwK4vYxqzlHVXT3BEYRnzXYTe2xLUrIrq75Iz2KsC
	hNY38kC+rEayvAWGeiuRbDzwOKYlIqOEixWxW6vbV2FGie/229avdnVwaXV2uOE/iOtX+/zlt3j
	vOrmQDOSIOkf1VrBMJCl1xw/gJY72kF03LUNWUKjrADjb8kSSR+00dLesTLNSyONMkYXwYPBDSs
	o766dFF9MRBSPpS8fGt/TklnaSRbs6sGXXVkQHhSyQ==
X-Received: by 2002:a17:90b:2585:b0:2ee:accf:9685 with SMTP id 98e67ed59e1d1-2f83abac617mr5297413a91.4.1738170235860;
        Wed, 29 Jan 2025 09:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrCpglI/oFl5t78dPoQSEwQUu3I5D99R137n8Ay4Pl8j1UVbu6nUQdGuNOrFSDImafbQPXMg==
X-Received: by 2002:a17:90b:2585:b0:2ee:accf:9685 with SMTP id 98e67ed59e1d1-2f83abac617mr5297381a91.4.1738170235484;
        Wed, 29 Jan 2025 09:03:55 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83be3622bsm1988366a91.46.2025.01.29.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:03:55 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250116032835.118397-1-quic_aarasahu@quicinc.com>
References: <20250116032835.118397-1-quic_aarasahu@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Fetch regdb.bin file from board-2.bin
Message-Id: <173817023483.726123.2294052678769953649.b4-ty@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 09:03:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: 46gTbhmRoP46pIQFnyfjkiZfrRoxbTqn
X-Proofpoint-ORIG-GUID: 46gTbhmRoP46pIQFnyfjkiZfrRoxbTqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=822
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501290136


On Thu, 16 Jan 2025 08:58:35 +0530, Aaradhana Sahu wrote:
> Currently, ath12k_core_fetch_regdb() finds regdb.bin file through
> board id's but in board-2.bin file regdb.bin file is present with
> default board id because of which regdb.bin is not fetched.
> 
> Add support to fetch regdb.bin file from board-2.bin through
> default board id.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fetch regdb.bin file from board-2.bin
      commit: 24f587572acf7509127dbdfcbf1b681ef84eeba0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


