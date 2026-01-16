Return-Path: <linux-wireless+bounces-30884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD45D29996
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4215430A9F57
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D7E334C25;
	Fri, 16 Jan 2026 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XsSt1uPO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PaCIV0gM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD2334370
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526824; cv=none; b=WpUci3R4iAPSTZyAlO4lLz9OfERt8msS0WAHLPOb0N/tqXJqmLhygzfI4NfwET57N5J8n2uAdSJe9Pm/OEN/ORfIOjUTY7mxdGkC4b/GzTqHbPkTcw7tyzWbRhuZ/M7nEHc0EyiXxDNRxsF7W/bPYCjly6a3MbFzcnZlyQcEhPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526824; c=relaxed/simple;
	bh=c18PT218zlbEm4Uf1EIJ/xM7Xc5fuBgFc6eIL0xSpqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b39uBaBu8LZxImt4eAgnWY5Zvzw/91rasI6Foxel+F+PIVhZUjKdLnlXLZd18+1Xlrv9lCb+YWq6QAesY5+wlu7wA9lnvKeGR5MfpsMBgFPhw5U1DBb80fSdLCkeMYlwkoEYTPLIKn1grAx619X7eC9T5xoExftVu/2ib2Vtws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XsSt1uPO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PaCIV0gM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMcgBV4100630
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q5r+1ARJQu5gUlQETHqn0rU/JGMzmWYJZbk5E4xekuY=; b=XsSt1uPOQw2ivXsq
	UcWvAaOioKUkcgXE2WO5k5ule/8Clt6Eh+tzjEPfwmqb5pCLOZuQIanr80kuNztg
	NHNZqCS697eXAGXnZZLrmzgZdD6jBY9KZ/kIMc11zPtLlCIV19og8eN3qEKM6+kC
	T3wxrp0yBY7WbTIcETh0/nJR4wiDUDNT9zAi2gwE+dHTkfLPzoMb3A9+K27dUWGs
	WGt1lmTLSqIYT+bwG0+f8IVHd7lXdAyl3Ck1dGMbPmWsM5UyAPObU0apAj7/izV/
	ANO0gVDaBb1p1Purre1xJQjex3mSOtHRZ7rq8+ROYr5n4vT/QeiB/TERvXDW3sZn
	Vtidvg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9750aub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b21d136010so2548883eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526815; x=1769131615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5r+1ARJQu5gUlQETHqn0rU/JGMzmWYJZbk5E4xekuY=;
        b=PaCIV0gMZz3HXLdXKYdabKC/iiqaExWliI5Jp0YZByeMN/O9jB9K3MkqzjiB0JZhpq
         Qh82iuErHk+VcW3upvYqHShvSQTG8hzr+8nxkUu719nqMPdZzhIQFsuKkojc/GIlcaNg
         ZG4KIBVi/9LyeaxHWklxkI7jDwk2BLGPhWGovwMlTjmG0HHnvcCeSp1cOw4msbYs1tEP
         S4cDuhIMPg05GEToExaDfe3W/0Ntf+EaURwSMbBwrc+r3EsxfiFvWb2IUslWsF/0rcjD
         CfVEiIBAJ7bhCwLqvUXhYqE2A+y7OiVSaESlG4CcS8yv3XlHG2EhJfKPmlfEm+UIPKYw
         BfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526815; x=1769131615;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5r+1ARJQu5gUlQETHqn0rU/JGMzmWYJZbk5E4xekuY=;
        b=D64UxEuIZ2mMJpcCwdIzu3Vhb75kMod2PGbD1s3jjs/JvKkNM9ViERCC22INBvH6AD
         oi9XRY1+er8Yq2XocB5jw550uVdJFCqSy0IG4e4vIcbI1K3Tj0BqdrPIEk0+MNoRyK2O
         1jCVAqk/JO4pPcxUkB8hCmdJyaHmI8okYvlDuh6f61yX36R7UPT2DB9rlnCmK4yYClrA
         ROKGvx9TlJLul2r/WepGFG8+ORc3ZzloM+pvvA84EBpf8KXM0EcOZrHIM2z3BvL89hmC
         PSeT5C4fKzjyPRvFsKD+yVJ9rwSTFUAHs+KhaIt4K7Uad9Uun7iyOQoivWYNGZ6BZFX2
         D4vw==
X-Forwarded-Encrypted: i=1; AJvYcCW2u/cKcS41XaiQZDhO+xUNAasZjBMrV5m309mqjVLEn4TXghK3R7p4H5JydKDu54GZSn2fhLCWtJxyEt9vaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoooiJgGWD03vqL7aW2P/6xZbGJ+A3+jiAwWfTrhW0yk7y1zl+
	JNGxUwdO7C0nz0wNDVmMErNx8lox4CCSCT2MKuQheFNzySe4fuVbCMCvGscphOC0YoYEpBn/HnM
	bRoXrgRk+EulqB3MORhoXDdZzqRGVCWnYSTYWhngnvF44+NztqV9lP2zZBoYmMIpzVqb3nA==
X-Gm-Gg: AY/fxX4C8E7/MvL9Ehzh0zLCjKv3Xm5I8VjHFrgrrQj5b+wYnEpTsGAWuqhYJ0Cohli
	7QqPbg5Rdg03r93RTUdOg+lYTdWo5L4xlGHUwHISZuYfKpKO0ogptR1szvkrSumNk0C9gWYNNVZ
	etQ5kJL0X91tz3v4YfGEdXVFovB+KuAAJe6Am5TQLsdFWWAhNGw54QCxhyoJlD4Ar/0PncI5zlQ
	xKURc25SIX/gJtY42cwGqXICozGSntQoZtZOkWNOV+YD8UqIpH1MCH/75dz0xh4V8xYHA4wImHN
	DA0JnBu+zlZyAqOGvnBQLWOpdd5FvIkhffFdQeUxzQSEehwApLxbUqgUTiYSV0k0jibzUrxmKb/
	AvyIOUGXIv6pFxVf0jPtOe0b8B0CA1XLGL/js/K285xFu6sbHpnBlh207GZLJh/+B
X-Received: by 2002:a05:7300:3246:b0:2b4:700b:3d8b with SMTP id 5a478bee46e88-2b6b40f4c86mr1458962eec.37.1768526814928;
        Thu, 15 Jan 2026 17:26:54 -0800 (PST)
X-Received: by 2002:a05:7300:3246:b0:2b4:700b:3d8b with SMTP id 5a478bee46e88-2b6b40f4c86mr1458936eec.37.1768526814405;
        Thu, 15 Jan 2026 17:26:54 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:54 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org
In-Reply-To: <20251128010401.546506-1-rdunlap@infradead.org>
References: <20251128010401.546506-1-rdunlap@infradead.org>
Subject: Re: [PATCH net-next] ath5k: debug.h: fix enum ath5k_debug_level
 kernel-doc
Message-Id: <176852681382.1143034.6647397811619355969.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX6RYoJKxekCdy
 VYM+bCoulNSPKgE+PfExkvjTE3pXPODaVmEzWMndYWdH0yK8lNL+yUWWtGX3e4I0B7JAP323eN0
 VMc5HSA7E+9RKfhrslyAzzxqU1+WIV8aiMVCb388lG91MK9Zr8xeqhSP2SyHbO0MiSZfljbbvkD
 6nVVWgirKIQrDNVFpMII7Yl8jlgp0ch6MoLNQgK4g0YTxpXNRIDqJjmBIwOcE8WJjkfGlR+YkC5
 I9d6mROUzdi7X1j8bUdSNNNZtqLv54HDGKJFgRwEXPJ0qPHVXUOXf3JZ1F+WG42vwsBvuhz8A+0
 zNxD0+4ovCxRo1q7bVVwYgRxaUqmX1wl3MlOOfYvqUPTvysE5YOh632U+PR1QntmvXNuhANIjWo
 0iQvXJ83GMa3B121WhIA6fHeRFOXIu/HjAXwMulwPDcTdhjraPM+0rw5tk7dTrG1CHzTA5ll2ek
 Bq+7l44V8eoXlxqmrMA==
X-Authority-Analysis: v=2.4 cv=Sv6dKfO0 c=1 sm=1 tr=0 ts=696993df cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nC4M4cfXRv_Zwgs_cF8A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: _d29aP-3vlb0uFCo-5RXO9jzbCIfGCe9
X-Proofpoint-ORIG-GUID: _d29aP-3vlb0uFCo-5RXO9jzbCIfGCe9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Thu, 27 Nov 2025 17:04:01 -0800, Randy Dunlap wrote:
> Add a description for ATH5K_DEBUG_ANI and delete the descriptions for
> 3 undefined enum descriptions to prevent these warnings:
> 
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Enum value
>  'ATH5K_DEBUG_ANI' not described in enum 'ath5k_debug_level'
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
>  '%ATH5K_DEBUG_DUMP_RX' description in 'ath5k_debug_level'
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
>  '%ATH5K_DEBUG_DUMP_TX' description in 'ath5k_debug_level'
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
>  '%ATH5K_DEBUG_TRACE' description in 'ath5k_debug_level'
> 
> [...]

Applied, thanks!

[1/1] ath5k: debug.h: fix enum ath5k_debug_level kernel-doc
      commit: b1e542b6f0775d35bf546f3de33644b4f761fc3c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


