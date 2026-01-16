Return-Path: <linux-wireless+bounces-30889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAABD299B1
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C58C3088866
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1C3346B2;
	Fri, 16 Jan 2026 01:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdAgnLc9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nf3G+Y6D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B1332901
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526827; cv=none; b=kqjHNiNwTxcx1LkQNose87sWpvGGvUYrRILKnJfMgtscIcvcr0zEfhphKSs5573qCvFsbFHO3htcDr6wp9+6OLarTG6Fsns4dpEMYszo4W6ckn58iKsoYPXNRV5e6fuw/fx2AVvcXV1JlrDerQCUuMN4zlr7ROQa0xya33mU1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526827; c=relaxed/simple;
	bh=weLV4S1JNlA0Bpx7zQILsNWg2M7k2nPqf+NA0UlIqFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qG0JMhrOLl8+qDcVzKBRNqOcltTpaLg6oHUw0Gg/rSsVFcEEMpMfoUdT+Zj2Dt9gG7RUtjZXbVXFwrRSLJLobUBFHENckLzX6aeoxSuYUjBHqdDwMmkg8xkdOifwVRQRcdap5EKjKwoDGhkp88bcxkWQ1ZEPvPXatKon3A46BoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdAgnLc9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nf3G+Y6D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbMNr3714202
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LpQvFuAlM6RvgG7r1OildI3WSwOslhvFGZrVKlP0tNQ=; b=EdAgnLc9cXPTwcN7
	yUAkxvGN+RqljO+l471gjGeaiiIuh0XR0mg+gs9fIykR+e6SHWSi1sPTlv889AC7
	tW/phnGwJwW629MJ2sflFH6qlTnsFJbyman2lz6PhUUeDjF53WCYW4PX8Tn2A849
	u1UyvLCDh9lzJLrvGkWaxrk41tfiTtq4LiYH8EI8n1AQ0tUrFJ4IyvXz0y90Sl1o
	GF4+opSo4gjtC5vrhpjrSQCAe4dKFhHXNkdoi2BaaUmqdwm5cg0P4QXpW2Qte0/d
	wXl8SMoXE5VHfECJmMiK3m05VQw4dXFQlf+VmfVbbcIvypnHBoA6pj2Mv3uFjt7e
	KB9SsQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96p8b4y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b0531e07e3so1730690eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526809; x=1769131609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpQvFuAlM6RvgG7r1OildI3WSwOslhvFGZrVKlP0tNQ=;
        b=Nf3G+Y6Dw5DpuTC6+Bqt/20rTWz9omLFAJY5lGDmWDd2c3uIlRT0QDhInOeOSfpynn
         yEtD4UAtZWFckHDnIRa2ST4Au9drBmEquh26o4OLIv7ErGJWRkwfbb7gKXkEbatQhfha
         RcijNtOCPh7ffuCFjuYVjgJvXmp0bngHGIDSBQoOrer04EF1kYekaUsnIC2arLAdofKU
         lL12DPOpvbT2ujtQJ59RO6jIctHJNiQrB+aGgp2V6oe1of+8nGS4ddKH5Nvitct0LuKr
         3ZKp1cebMrA8HwIlkjjVZyfhS0a1K805kc6uBmO6bSACbs2MDHYgqXWqdyE5/u5H/1sK
         IpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526809; x=1769131609;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LpQvFuAlM6RvgG7r1OildI3WSwOslhvFGZrVKlP0tNQ=;
        b=Kq9uQeqO9aNL/G3HXqPW/RFQq8pR1u/9BLXf4pNAt/Dw6P6bnq9KPPve0tPgulUoO/
         FWK3aglNq+PT/wu40eKRLIENZN7p6ylgZt3JAktfYH4wirTfAT3XF22XPa3f90wBmaUE
         QNDaQda3hDDMpV5+xwqGehBdoH8/pPKTgbKkWq1f8QpVaawZT5thDnyPC5zKPYdJ0QpF
         0w2hPFM5xZ3OEdLQbm41XTtlNgBWSGCUF+eJqeYPwO2WtDnp51eBvf2nOMynCR/vSbtO
         ghTeotr24b7sydUFj9TsI9Lp3IrbO8M3AVd97uRvcHVOiJsp8cENpAZCCQZUkW4IESrT
         2AEA==
X-Forwarded-Encrypted: i=1; AJvYcCWIUNXhuoDT4GOfHI85j0GRRUE6zOT91RoCXC5PPRoLfFvzYKKdZxSLNBf+PjTNDIQHCDUQUSjhq6jdMUIJjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAWW1Od1OWIdkqDxi5wx8hX7GsehJrn/GazGFxKYvoG6YcGja
	TV0NX0eGEL3A8EBtJC3avXo2F1v0hEbyvrBIZq4nCtX3ho7HI3aoPIECmDa0q5s/SPIKIC0aKAQ
	D/wLaHOZnH5si0VKB0ecYCa+O1B/eAELPzQQ9WA5EM3bNbqv07/Ind/of3oSo3DTyJ5l4Iw==
X-Gm-Gg: AY/fxX5qabvQfW7/vy3IpaogR1Isw4QLCw0h9NLKcq+vZc63Jwj96IQ9hX/HUogAarY
	zemrG3DmvcpqQMFLfvo7jyh1/OO814s+Ea7TBaUz79hudcXdzhkFZSDcS5LvHo/rZT4zq3M8x2B
	+zLRhNzqjBwHvas7//jynRiVSBeaWxuDHCiuP1CMOjRxLQ7+vKxW98DM/tq0uvqE3U+w9kytD7A
	Vz2ys00FNRjWJJZVgSrCRF2zdTmUuuhbSsxDxDXrM0Q/CuJ9w7MRganYmJHfYE/Y39I+5xF41hK
	oc3jsuUJgmsKJ6832RWb1G69PiEZd34PK5uI+xkEB7H1i5zjtxTL3pCHrT8s0CkCLzJRzp5JsNU
	Ua+hABFyeUubtfOGZ2w3fTiEL38JYmFYWN2gUd+/pvIc6vHWo8M+QQqP73Y2gdBBp
X-Received: by 2002:a05:7301:6007:b0:2ae:5d9c:9548 with SMTP id 5a478bee46e88-2b6b40f0736mr1603743eec.32.1768526809359;
        Thu, 15 Jan 2026 17:26:49 -0800 (PST)
X-Received: by 2002:a05:7301:6007:b0:2ae:5d9c:9548 with SMTP id 5a478bee46e88-2b6b40f0736mr1603726eec.32.1768526808841;
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
In-Reply-To: <20251117020213.443126-1-rdunlap@infradead.org>
References: <20251117020213.443126-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ath: wil6210: fix a bunch of kernel-doc warnings
Message-Id: <176852680841.1143034.6879269716030726256.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX/muj/fEMsixn
 k1GjjgRYieh/MAdYZ5BZ2DfySgC8wTi4YKgzJd20gOzCiTrinFAYnt2ThvPbJl/kzlfTq9XqYrS
 0pKN9o58EjHuxPcyS5CUubrcIcQV6tgFHQ1BXzeJxWrnN3OesNZA0DQYy0QIeZyypIN021FqLTC
 leSHAVTs/uNsbNgjCCHSDDpURCfQ860RcFDS2LiubZFAcm6g8ZCMOSdipu3ffNwLiOAI3bxhP5f
 uicaivYJVNfrf59D8Uk67n7xDwnH4Cx84CVQ0VBc8CU9s1pTXeosW2gSVw5HcYxGXFPdwK4nt/I
 U5HFW3dcxBNKOiMEcKgXEcG4j+nOKb7DvkNiPw3++gfOX/pQFdFHRsG9MyyBGqpiX9qx+knKfG6
 0+s1PsnP30KfTeEB0QtNM10jOByRlzFF1Aycr4XSTnOe3YKcVECU0aRsG+2q57ylUY10EQncpod
 ZmMj7OYjrufHwkjQvkA==
X-Authority-Analysis: v=2.4 cv=M7ZA6iws c=1 sm=1 tr=0 ts=696993da cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=asl5HiX3r-lTlHJPCLIA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: zwNCT4terKAFeHfw5bcTCkmHyL6Bmhd1
X-Proofpoint-ORIG-GUID: zwNCT4terKAFeHfw5bcTCkmHyL6Bmhd1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Sun, 16 Nov 2025 18:02:13 -0800, Randy Dunlap wrote:
> scripts/kernel-doc.py reports 51 kernel-doc warnings in wil6210.h.
> Fix all kernel-doc warnings reported in wil6210.h.
> 
> Several comments are changed from "/**" to "/*" since it appears that
> "/**" was used for many non-kernel-doc comments.
> 
> - add kernel-doc for missing function parameters
> - add one function "Returns:"
> - correct kernel-doc struct name to match actual struct name in 2 places
> 
> [...]

Applied, thanks!

[1/1] ath: wil6210: fix a bunch of kernel-doc warnings
      commit: dec6a3c6d6dfc6402118529de230e76e65df9a9b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


