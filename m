Return-Path: <linux-wireless+bounces-30891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B77D299C6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7382301B5AF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5238D3321B1;
	Fri, 16 Jan 2026 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X01cMpR5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ASJDoV2n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1390332915
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526833; cv=none; b=hepQMGSxBmz03YAymVtOXh38udo66FJ1mBr5b/alWl6SYYyWGLJkit3yhx5aYFd+pCjbzbpqrBOimvHN6kxcNwa9OC9QenjpXHOArNsb1hk7mR8HyCa0U9XAG50V5uxFVVImo/CZMDC4XiHeWYSiRSc88JhDm7Pel3kLoWqlQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526833; c=relaxed/simple;
	bh=djlMe+ssnORUYemVaaH7CxYRQnul6TTxiWn6wvvD/5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C5aH7lPsXuXXVYAJe2JLNT7gg9lIJpnjlGm5xwy/RuggqlOs+DtF2URFePVrhOJYXorwBUTJJBaZPmUbSacriKLUBe0UqV30rbM38dBRDtN4f7Baurj9HckkiHyYn5ycmkzFY36kMsZJZKZHE1de9PaxvgkxVrfdlmptXYn5iWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X01cMpR5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ASJDoV2n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbOB03714330
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iuLJNLpxrpKRcQQOT12hSAWbkuI06W11486MDDYJ4E8=; b=X01cMpR5TThEyvbB
	xvGpt/JXRW6sY10c/kFCc4v2yvMMRKten/ac/Y6oVtgexWG40/8H3wNuVUQ2sY2j
	an4STo0Ykvd9lqgavveM3xn6mQh3KxdWwyeoEYrDKtC9zSSUNs+p9njoFb9d5Fzz
	IY3plKLzXLqTx82eOcrWaa9gM19q0yR9080prPUPfCQZkEz3gytSd1ZBcH9HJ84c
	t8yCXV99Lbn/EeHbxCPqF0j+AQ/Dy9mTYlN5rg8t7fNimdyPU7tyKN5ySmML032S
	fozWq5R/zbzDWMa2fiOP5dvaqrCuO9Eull01lf9Z+Ss2r0iRSMXpaP+eUikDO5p0
	zcnZHg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96p8b55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b6ad399cd8so3108084eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526814; x=1769131614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuLJNLpxrpKRcQQOT12hSAWbkuI06W11486MDDYJ4E8=;
        b=ASJDoV2n8iLYgG/DzIotxCCg5Pqg7HlKg9bbTD11hPMPBR90kog5K8kszj97zkV4Yk
         8TsoRfNtQfs0dzFTJ5EjfF/ILYA1iP5me5qcB70yVmI9Znod8+I4/WJKpbZjkcy8PYt0
         zzL8zgSRoc3w8/RiYIRUCs4GlJe3YqRDTthX/RrVmfwdXR0+oyfaOlu/x8qlmtx1dr1s
         G16+zjJbjtEalwRCYAvvbuxmB35puTuArcarnWRwJ4eCrDJMecvI8YKeeKuhUJSBcTBP
         AS53mpTa/jGATi+KcImDczpHwthhtqtygK79DWwvUDOMjWZ5Ya7ITjBUKma+hOBabNb6
         6/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526814; x=1769131614;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iuLJNLpxrpKRcQQOT12hSAWbkuI06W11486MDDYJ4E8=;
        b=mf0UJwouFYECkisJJnJqFVDLQh1aL8z7r8WyTgPO85rtkA5h8gknusdPc1KIh6S2qz
         hdewiORvznUq2gDmPSzXHD5ERjjZl01hyagaaxAmdbzpFMi/UWiJVhST/MKT9LYIde4K
         OX9J0SCoO4T33avSCWslpj7z386UTw0m6flEfhTLm2YQFWhkZzjmcEUIyYUgHaqBwf4R
         wkRt0Rt01UwHgEcCA2pJVcvo5myM2vkaLbo5TGnOpUKZOGLfAgnl25/qdgOMn3coTaKn
         4RNTYv22XYeJnk92MyzFhW+JYe2J4sLuvLi8OInGLLAhqHZAk0HfzcsfeYF+AnrZL5ap
         lTRg==
X-Gm-Message-State: AOJu0YzpzfoBa7MeUAhXalRfGjZzbnagDAAKn3bcoBvQKtjtPs760Gvk
	xlWxEdvuqAMLEqYyQHA+y+zl0NgcoX3aTUORIGe2CRWCyR8fVLsN1e96oF1QqqS0YSDX/wSTl9T
	vwMGo0Hmf3M+hvylLSuihn7ZwDZszgnFx0WbvHcVghXb2JZos7AKE8fxgBMVpMwrXApoWKBLjH5
	FOJw==
X-Gm-Gg: AY/fxX6apWtkZPOTgKHYf1fIcMxvyKrzYTUQYTWsfLKB5FuHxlfLhmWEXAh3H1orn/N
	aCKfQJOuPtQi/5cYt6imbVqIzJpkOqval6OIOg54jOtoVzSN2Te9NYCeNkMqj5vSIVud1oYZXRM
	JgfiKZOe6UPUNT8v9xTx9KjLAy4pg5TIwON39qKFPnW98G0udWi/MnXsfFIivVEPMMoQ1hdPPJF
	ncxdTk7fghmQTQgxhIamjGF9ASCVUuR/vcPFWKgIq7YVtdXQp83el3zI3lzDMvv10pa9xSHQEEu
	eUZW5O3LoHNZR5UQnKPBv9merK+6g87UdrCIhgyHyv9TEpRbToqZqXD0/3uI5y4eOmxZbt04BNY
	ncZ+e+Y+J7p6zmyMxBHHTAxjPmOmFVTw1vzLYBD9HKY/xI4Gmo3Z25D2aawn/FflQ
X-Received: by 2002:a05:7301:7c0b:b0:2b0:5bbd:eab9 with SMTP id 5a478bee46e88-2b6b50024b1mr1315915eec.24.1768526813498;
        Thu, 15 Jan 2026 17:26:53 -0800 (PST)
X-Received: by 2002:a05:7301:7c0b:b0:2b0:5bbd:eab9 with SMTP id 5a478bee46e88-2b6b50024b1mr1315900eec.24.1768526812988;
        Thu, 15 Jan 2026 17:26:52 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:52 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20251103-ath12-primary-link-wow-v1-1-3cf523dc09f0@oss.qualcomm.com>
References: <20251103-ath12-primary-link-wow-v1-1-3cf523dc09f0@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: do WoW offloads only on primary
 link
Message-Id: <176852681226.1143034.9662809226271076709.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX0+uSAi2rtXsa
 uquDH1vnEQbUpuJ8idBcVMhNxaa6Yc9Svu5RX43O8RmczxTydyeX9WtFgXRX+2RFlBZAkEx/9pH
 gT4lIImxuTlIGy0drafGIE0NjnnE+Tzx+h9aj9GfMv2YjBXN4alRV6vh/xR8TpMnOoWveEFQeb1
 XBXepfbdTMQzDsucz0eVHN2P7zIaUaMPXwRP2PmVXX9TAvpBVOb/+e1WYvS2Cr1wySFlp6GzDDI
 Ex+Tmo/CAU+jy9z80xGbtgJ1haLTpbaAZeLl/IVNyNgP0l7vpLBD31uxkJCzcub3SQkIom7bqN9
 N0lOZ56nv/ZaToUCkt1GTr+Mz7ecsHzqHNZuOz+ens39e5l38Xg96FmnYIithzfj5phLVz3h3kz
 bzaGywt51u2d+dL9EHHvjeh/WABIxDI/6S+ELJRFpz+HIIqqukVVbT1yKWOrSrf1reQPtf1MNFn
 lWT3FWFUMzJtchjo4VQ==
X-Authority-Analysis: v=2.4 cv=M7ZA6iws c=1 sm=1 tr=0 ts=696993de cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4lmNr4T_BIov7qbIXHMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 77G6tigq_8CKGmieWTjwZneszC9M-FOj
X-Proofpoint-ORIG-GUID: 77G6tigq_8CKGmieWTjwZneszC9M-FOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Mon, 03 Nov 2025 10:44:49 +0800, Baochen Qiang wrote:
> In case of multi-link connection, WCN7850 firmware crashes due to WoW
> offloads enabled on both primary and secondary links.
> 
> Change to do it only on primary link to fix it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: do WoW offloads only on primary link
      commit: e62102ac9b773bdb08475aa9ca24dea61ae98708

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


