Return-Path: <linux-wireless+bounces-30885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B966D2998D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7A9C30146EB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382B933123B;
	Fri, 16 Jan 2026 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WHXo+u3s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g+NIIg65"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D43331A52
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526825; cv=none; b=Upe0V4tKxGmH65oRFtjQYcPix44xbGNsEuELV63n7S1KwQRuiO6V7o31z1s8kiPWcpQub1Xr5CLo+98jVNhikheSCQNctDb8wd0YxCr0/eqaqwt9j0xFHKjMcV0ugnoBegEiRD79yzo1Km4Sqv7JzSYu0uADnBvffPwdZTvK+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526825; c=relaxed/simple;
	bh=cEYKNT9cB+fnWe/b/mV6Waz/brbrtVea/mApF4NuDvA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l+TxxBtbpkK6Pdp7YqIUutFIb31oYcCVLOwR6foRFFdXAnWO5tRT2NAvddehfCravxedXlz/FjY4YGWPL8y6vU1/6kSxRQUgx78Z6UBcypzK3wWAuLMqfM93zQfWc/6Svw45gBbckbiuACPaDrhBRaZVvUWOcH4Z3aorPMOCqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WHXo+u3s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g+NIIg65; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbdkl3596641
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pInbWTsP4EKynCkZ4ua4GCkDrJVRCSkgQMRc4Ub5/0w=; b=WHXo+u3sFj+6MFln
	Ack01R+prYlZYoqf7466SiGuXU8rQZZ4KqMKuwtIFh0doeDGv5WmTTPgrR20Ohlv
	Ia85CLSzD5ZawSlZHB57DwjQY/ClzaPILUiAysuPAXR20Q87l53FrWI3SZ6Aie2A
	juJ7pyQJNDrbDiq3/irEtDfM8/Q40PfiQA4h5D70JiaxBNqYxhzi4OzNZwmKIhc4
	kuWyIsJQaD2mDfjqESyl4FyEof0hDr44vrCO/QgRmMXxub8aNzZpx2BAYZfkhkG7
	a5EuTL1fYHbIgEBUZuxJk5MCsA6E/hZxqA4s5u/GKQ8RLJBzoQTjeq0x6BdpfkN5
	3ZBlbg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96rrb6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ac39bd5501so1559291eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526813; x=1769131613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pInbWTsP4EKynCkZ4ua4GCkDrJVRCSkgQMRc4Ub5/0w=;
        b=g+NIIg652swr3FAzykSlyGy6I9D4eADiwSvJBGTojEJwY/NOamS8cFBDUyXiI87N0L
         FNuX0Vt20VZfwMZaw2RNUMGUdyR6H+uAMmE6Ast+ucnB+kzODtcCpGcR3MayP8n52JXY
         MPGEXGwyLWKgI1h9G1YpT5mFnu6bXXCpd3F6fZ/gSt5gWiyA+MxDL+tQLrWzEt7O4Iw6
         CXhK8ggiVko6djlKzl+5N+jQrVsEFdP3Y3jRsAzc28vo4u0C8MKxyj0TdFLzxqg2Dmg8
         lK6UUsKRnOGD9DtEtQ/jhFq+Ti8l7lAVo5MfgBjxBMHyJ5KqCVT7m9IwtD5NNGJhCgCf
         ZuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526813; x=1769131613;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pInbWTsP4EKynCkZ4ua4GCkDrJVRCSkgQMRc4Ub5/0w=;
        b=p1iepkg1qSVZdGinIZVVi+FtHWkYUy0wAAHprtuTxLgtAo7xNy3Ti9OIaQ0K1Gwvgv
         +ByV5QXmZpR4c+w4J/B28Utz8tykX9gg0tOSw15wYlzbNilGECz0S9jvEy+PG8dTV8XP
         oTXbxyItPe95KWGnYpHAtJBYZ+ZMQL6JUmLMhcWQrvMLhBI+6aiOOOLgK9RlJboOLHhd
         8+KftL8ZFEYkMtJKgZ26hVJlm1i43yVWL4/toV5GiEc5NoyAL0RCYw+FEhIvYz0PTVAs
         vjo+iFsVRmpIclKpzd5MXsCo0EOp7CJcKmIXowdw+OFDmTORRNV0r+m4bdr3xN280kz3
         +pMA==
X-Gm-Message-State: AOJu0YxKs8GnW2DszIxwzSZMUIYisnlKKITal2/ozv4mrc2SY19Vb6Hp
	AAFa9A0NwmEgvqpzoX6SU8WTPdpfMHDSC8X1UIvJSXe30sHI4pM52QRHveS0PS2E7NMQtkzmURF
	2Kvu557Zeo7Qt4THogF47gy4aAeRcEVNObjAoeRO/Sje+iZ2Vwe5vO3QD6XDN/NUo2Vay9FdO7g
	9Yog==
X-Gm-Gg: AY/fxX6hPsEk4m5RzAIs4kj/37J+Tibb+68wEsOB2EVcCmn3UmLdigGaMrxButpWm5G
	8Flv1QYIW3mQJ+PB+Dov9OOOaxa4Nj+V5JZyJc94EvEtHj4FYvXwpLK1LG7IhbcueIMk6wx4oSB
	IGKObkLBn+LyIUHq0SLtF4pEwBYw5+X9GOvBv/zAG7r5y3G8xv6xS+oKeXcjebdHznngBpsY2UZ
	PgqaYjIyP4EH8mC3GUgaRR37/nkMnYzsA0rMZ0TG8oPsmUTAYS74Jm9vWNvWS3kXXX4GeF61Ovv
	1UA8QbSH8t+DJ2rUGKLEHAT1M5nDXMAhjmaRTj7pw+HElO2lq4HHAsPUJxeeOWE2aY0+I+yg9Vq
	YmYYqVGQU89e0Ll6ROqXWiEN/iJqf4QZoA8CpMaxJragA6D5eY4PaL5nCo6UkM+6C
X-Received: by 2002:a05:7301:3f16:b0:2ae:55f2:ad57 with SMTP id 5a478bee46e88-2b6b40f01e5mr1237267eec.29.1768526812607;
        Thu, 15 Jan 2026 17:26:52 -0800 (PST)
X-Received: by 2002:a05:7301:3f16:b0:2ae:55f2:ad57 with SMTP id 5a478bee46e88-2b6b40f01e5mr1237253eec.29.1768526812114;
        Thu, 15 Jan 2026 17:26:52 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:51 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, Qian Zhang <qian.zhang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Yu Zhang <yu.zhang@oss.qualcomm.com>
In-Reply-To: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
References: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v5 0/6] wifi: ath11k: Add single shot/periodic
 CFR capture support
Message-Id: <176852681153.1143034.7918446745386883985.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX8psLRClsq7mi
 emnB7VTXauN8nTyU5uHGPwE+ejts45oaX7XpwkA0d7pQlD6109tpOW9SgfVAFXNthUXUsZOTey6
 LS4uUi1fcgvs7MiC2s0z7SQLQ8dOY0ab5/aosFAmJ3fl59y+F2aX4t6sTV3oUvVn2V9caAh4Bxz
 K/MlYsDOpD3UJDcj7pHqfrxOCc1bEi+604tPqPFgV9Xj71jdq8uzuVXji6V68dum7K0nX8cCBVC
 6khrquaKG6SeU6zVicfHFXnDuFLExJrCb1A35BRIFQCs6nzXELUe6LKp003YPgDiSZHYIXLgvEB
 d+HlW/u/CXx17LPVsqlefzaZ/aO4irxFcAXp1sss/Hkxo/PxrtCclDSAicnEwc3mkf2hb6PQetn
 3xilelWZmIz2xOizTrUKU7oc+EcjKfCi8m3DiiZKev2zt7i9fDwKd8ahCMLh1QIjEUhwUGBVzoI
 a4OQhDRwGM60xBn06OA==
X-Proofpoint-ORIG-GUID: -eLBme8cFQwDtlGNXaNDUrh4w-pwVgJa
X-Proofpoint-GUID: -eLBme8cFQwDtlGNXaNDUrh4w-pwVgJa
X-Authority-Analysis: v=2.4 cv=TsTrRTXh c=1 sm=1 tr=0 ts=696993dd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=koAdh5fa1qAw9u3C0PIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601160010


On Tue, 30 Dec 2025 13:55:14 +0530, Qian Zhang wrote:
> To enable/disable cfr feature use command,
> 
> echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr
> 
> where, val: 0 to disable CFR and 1 to enable CFR.
> 
> To enable CFR capture for associated peers,
> 
> [...]

Applied, thanks!

[1/6] wifi: ath11k: Add initialization and deinitialization sequence for CFR module
      commit: 9b2e3b4ebec7f23a552de4ee6f2e5da8028a2920
[2/6] wifi: ath11k: Register debugfs for CFR configuration
      commit: 9754d4ba4df7e63ab271abb8190008c3a4dfcd26
[3/6] wifi: ath11k: Add support unassociated client CFR
      commit: b3d43d890399e4f49f31d90083bfe9b349cce6dc
[4/6] wifi: ath11k: Register relayfs entries for CFR dump
      commit: c1bf6959dd81949ebcdeef53fbc9bfff91ec241a
[5/6] wifi: ath11k: Register DBR event handler for CFR data
      commit: 99cf756831d203fcdd3f9a8833355fb86611a1f2
[6/6] wifi: ath11k: Register handler for CFR capture event
      commit: ca765beda7084ebad7630bc403bc0b2598d34e98

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


