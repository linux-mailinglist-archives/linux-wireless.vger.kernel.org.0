Return-Path: <linux-wireless+bounces-30880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD829D29984
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829BF3045DC7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA69533375A;
	Fri, 16 Jan 2026 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9He1gNQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rn6BeU1f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FB333434
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526819; cv=none; b=LOlsEvnOBJPM7dyIkXnyFDEftz/KSuTNY3zJSbYVT2kHgNZIXz5F9t/NemZWBSIVKPnR4aEtLVd0m4u5o/uLCPu9NWlkNWPN9gkMMRi+5y64u3PI53CXH/467LxGIo+Fgjr8J9x9QVxuL4b/JEz/R4TIoijfs6Oirf+NEAB/bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526819; c=relaxed/simple;
	bh=sMAy7zd1opS4aRD2kuBC1Ma54D/PCB2a7vbQKVzJk6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WChN/jzAegyeN+ltlV0+eWh3ULJKw/l8vsZvRemrjhqnWzzh98jUq6Mt9/reGZpKcFfm/OysALWvrf01xKluMxLkPVsVVqUm/wfYY/IY+X2sJjU4ehVQMg4WNTkvkeAp2SIlC95DbCyiP1rSv0a8PoAM0gin4zRrdx2po6yYpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9He1gNQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rn6BeU1f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMd20B4101603
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VrFT9VL98gSPuEHlJELHA6Ht46ZpQXK+BcHkeUKmXTI=; b=T9He1gNQPvr1SvtW
	weanQG2zWEbClhyd892rK626vUhoDmmmhUHG96ATZK0h+Y/Ku0CSqtI0GkMkk1lE
	4LPjGmSTmptb5LrMHyaeHsMtxAauNXL8XWgLbSVLjKZQgkS62VY4u76Wa3qmdPMr
	ebvMMrFa4ILHH3FItlIImQsK4GSRkWFmg3W3onH8fA2tgislmEMNkiDo85P0nQ1M
	rcXpOjx7gVwYltmm9dVJiWMceqwqbkkp2ue6n4a24vkANqbKuZNomVpD2d3m8c0v
	rY9FC2eM5nX4S/cLjUysL9V0cxJaWrJkqCTM6PNKUOcVGTigF9ANAmm3lYtFuNUM
	PGR3eQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9750atu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b6af3eb78dso3359394eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526808; x=1769131608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrFT9VL98gSPuEHlJELHA6Ht46ZpQXK+BcHkeUKmXTI=;
        b=Rn6BeU1f3trSbEdFY+1mubFWZQT4YvjibN90efq/DGQJFsR64fAoOo4g8QUAvbElTC
         1M0UvEHVFxsFcET8a17o/fYIb2XFXhx7MeIis/Ulvb/DmBHgyOiRY6o92iXXiLbAYRTe
         pXZ5pwV0/SVl3vRgVNXiPOnJIAI+PLXoy4zxdUZnvJQ6ldSXV4kvWPVOqKj40ETUHoL9
         l9hqUsZgYgXbkI5y22+3quIo8T2Apz83xY99H/vR9l0hlFCh09m2f3WIMJ4grxR+2R4i
         UmpKT/mrO9SMlhUM8dfFHdMADQ3Dmb8B9bqoKPUHAPP9VBUS5diBtTcknYyBhi7EA6jg
         dR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526808; x=1769131608;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrFT9VL98gSPuEHlJELHA6Ht46ZpQXK+BcHkeUKmXTI=;
        b=Nc2FPrUnPTWkujg78ALAG+UqEg+lKmPrCIy7Tm0Ds3MpLmP2XHaYpTTGBYPSRQc4yd
         Enbnma44eW561qiybkGBOu15wC3E82e62bOX7K7AYdif8BE934qUJ9Js1CxR5YKIH93x
         0JcBbUQMqjlWeW/66aLEfwkgK6ZitWbYKFfzzTEuvDll6Uuf2RJ6arOid140Mkry8itj
         EWKUOs2pPRtXxKQ/eibWn+rp9je9Lnaps0kiQrtHW8SyDFhsAmuaw0S1639SAUsij+i4
         0slotpwptFN6G+Toe2nZND3zSW4zuIs55570122gbNyzSjQMqdCRsSMca4xDdedDeMYr
         32LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUFZL3O7LnxlIAmezyDMcnvPCsCAGm+YtOpTOCYkgg9IQXSea66LFqx6z+zO3AJnFMA4Gqi4PM61Ck2y3Nnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjQ47+I67pfnktA3kfBkjJCxfx7ZGteVnOin5i6bshijdQboA
	hB9XcvxpFv7NdsBlfUi6vygI1sCBLKSlyEUPRnetKTgljqeg+pSQPvPA2NFhM/9hQm/OX3LLIOy
	XRnzhCuk45bA9k8w8X0a3/Dec0mXdtGrnnCJ5sIOk5aRfPlExu3jQ8Tpc8u2ZXb1Y6HYH6g==
X-Gm-Gg: AY/fxX584Iap9bCh9tsjviDCRUX7rA/Ivj7sB5lkWdTfYInNqqPbgxCSnFK7GEzwQuA
	nJpjmM4Ye+cEZyIKsRGULY7RZiWufiF3XNA45TJaWrdqf9Yiax+HC30C12wOQEHOGVhkz8GsYsd
	pkMW9qTmD0/QFUrzwNyNyREk95s8pVfyb5TDXPjQaYfeVgi+Z9iUN6uxhZJgqhSrtHq5T27F5U0
	IZ6+Fs1S31mPC+JLvj0PVMlXlQWa2MiSCa9slwLjVFvl0T2FO+uCxIX7pzJRamGncSKwihcsaM4
	O/VUfGfe10PI57pv1NV0223ff2ZYrrKAhMqVQvf0fr7Yoldi3Z9AQiVp9eDi0GzpaOKKZ7pLyDi
	XItOTnDlS0I1h6uGRqs5BUfQHKoBZo8MqW1UzzInSXaVw2CFavGZ52YiaFOlY2AIv
X-Received: by 2002:a05:7301:3e0b:b0:2ae:5fb4:c5f1 with SMTP id 5a478bee46e88-2b6b40d9e2emr1295869eec.22.1768526808232;
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
X-Received: by 2002:a05:7301:3e0b:b0:2ae:5fb4:c5f1 with SMTP id 5a478bee46e88-2b6b40d9e2emr1295853eec.22.1768526807595;
        Thu, 15 Jan 2026 17:26:47 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:47 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
In-Reply-To: <20251117020304.448687-1-rdunlap@infradead.org>
References: <20251117020304.448687-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ath9k: debug.h: fix kernel-doc bad lines and struct
 ath_tx_stats
Message-Id: <176852680689.1143034.18235546514980577388.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX1jAkt88GPcin
 tG5biEJ9qetAaa0BATmu0TXUehuoywHA4lur6RcXJGN1DE97CiKAJpHlLYiZuof5MB1OsZK55Gl
 vPc3qoewSPuLWvbN6/OZzs7c1FgU4NhupmvRgg+Azlf6UD5xXYQ5AKlWiIg+QO+OlywpBbaB4wc
 Y8Y7+g+0u4ufBT7mvdGJVrxsCnam43ai6f5TEfmITgZYIL8k5pPXdoP6WkYDCwoXnaE3YnOtQg+
 rTSpwDaKV1JlIJxMbBU727opA7P9cwnC+405fgoOcxD8wdfnlns6yheB9z0rRN4LjEv1Uembgam
 16vHNrSYy2Vl53kMnmlVfZv0ehWEl6NjZ5UWhXrFy3SqSAU0EzBI1voBVNCXnGOY5sRKlsZXFei
 4bQJicdA9z7Nw2GkVvfwFCIq6YKCFTNCYFFzsCDMr/xW7GnAxWqcfs3Zt3/M0PLZrRhN37m+59Z
 pjdf3OQBnrLBPb3nc/Q==
X-Authority-Analysis: v=2.4 cv=Sv6dKfO0 c=1 sm=1 tr=0 ts=696993d8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bN4pwD7rly7kb_o33PIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: GjZqwdeqMOHevAnWUT6tFAqdujiJkZ5x
X-Proofpoint-ORIG-GUID: GjZqwdeqMOHevAnWUT6tFAqdujiJkZ5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Sun, 16 Nov 2025 18:03:03 -0800, Randy Dunlap wrote:
> Repair "bad line" warnings by starting each line with " *".
> Add or correct kernel-doc entries for missing struct members in
> struct ath_tx_stats.
> 
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:144 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:146 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:156 bad line:
>   Valid only for:
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:157 bad line:
>   - non-aggregate condition.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:158 bad line:
>   - first packet of aggregate.
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'xretries' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'data_underrun' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'delim_underrun' not described in 'ath_tx_stats'
> 
> [...]

Applied, thanks!

[1/1] ath9k: debug.h: fix kernel-doc bad lines and struct ath_tx_stats
      commit: c6131765a2c0052b2c5a2310ff92191ff33aec8b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


