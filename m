Return-Path: <linux-wireless+bounces-19918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B3A54F4B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 16:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412FF3B630E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535C2E634;
	Thu,  6 Mar 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aZ+0o67f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA05158858
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275277; cv=none; b=Z5n2aq5JLtcJY0AHTI69OqtDSoviXMT17qJTj2X7E8gukwP7+vG0tQ2RjNRu7fzEKofq1WgjXOM+rOhPrRDpHRXdfo5/Wq2ugkZ+jCbzPS9kru6EGegC5cDaiDnkNLTkQ3VpYTS///n43j5t/ZwVfiKRcrbO21BLZpcg+X8H/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275277; c=relaxed/simple;
	bh=7UxKdfd830+S7xc43srQpmsDPPb5LGF0XIl8PwoIybc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHaTWlJejDHhkQgwuPmkVSDIWAiJD/L48CePrq/OhFTCSAygsg7/BC+0g+u2+TxXBMAeGrLyqm1WZxGYZojEPW0x3LUeMGygOTJdF7t9DriTVesxQSFWfx59LmaNt9jRhOhbz+iCvFIFDFKpWf+Hw7qmIN0j/U1qSzlKjb4YiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aZ+0o67f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526915bY008332
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 15:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wi0plQcZm+1fh9ks3H/jeKjBrx0B27RUEbiO6ARz89M=; b=aZ+0o67fflAzpy74
	6c4i39T2zzvYFswJBnwBGDgJDoxGgntnAXBs3jPtYFyW9TkaJnoGSBoKBYNN4WEU
	Fxk/Ygvz+A0VpPPHC5noMmxTpjOV6wcdif7JK1+vjARF5qvHimvCgmjmeHX+HnsY
	npGLkIko6y/oOWvpOWW7ruY+jtp9X6tN6CZPEJZDHmnYC7V53QTesBio0dNuvFTS
	r2a8hMVM7oaM8abAHJ+IJf78AY5bPjfdRHmJsnOJprMPhQoFJk6gDb4+fee2w/G7
	1/yMiyOPWhAS8p3+OTYMZWhMjk1ZroSOMKkh05ZJI2QGDImKtu1M4ZqBxItCdJp1
	FXhBYA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tsj1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 15:34:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22403329f9eso14369375ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 07:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275273; x=1741880073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wi0plQcZm+1fh9ks3H/jeKjBrx0B27RUEbiO6ARz89M=;
        b=KHRUpr2hVhvCJAsVcAxXE5iBAwAqxSsHcraL6cAaf0uegvtqbFuO72/cTj+vrolkM7
         QXUeuyAP1TkmErU8c/6MF10RMLCwxW0fAEJUFqpSjH8b06U/C1w9QxOz8BJiJOjqWq3R
         NF2MtjkYzBSRfWd40ZBFLJKbWeVj8yd/bpZmTaiOD9SXo5/cVF0m5bYm92bcEMc9aP+R
         gM0C1ZJ1qjJ0GkzebHAugSXoPLVNuYLqSlJsawCmrvDCV9PPKOlYJgFgiYBJGQz9aTh8
         u2JwscyIPlhkr+umOlyv4zlQfxguz5BH9bgtQvVuTCFylL01EoqitXUgGvdz8B08z1AN
         YYoA==
X-Gm-Message-State: AOJu0YyiiK36vJMQKUgYWtDS9rD7lEYivXMRjgNpIV+xTkx7cV8cDr++
	3qQ63Sv3RioBCKzLUkfKN2izJlp8QbrsZtM20aqy4xmbrfDweNINp+7PL6bRcSqPirNWXZiLolv
	ZBfFO5PfTG8xo4HWbV+N8zTqwrXToSjPS2RkHEoobNKjmImlhEx/Gi7CyE6lMdAMNwkdyFn1RSQ
	==
X-Gm-Gg: ASbGncvIhVJxjQwGCh1tvfddHWzOctb2+EaoqjBA1E1pIDdA05OvcmZk6s1mOTHOeeb
	dbiLku3wSYkHt5N7LjRpTgGE/bkZd26y8dcBLWFzY9RIYTohdbn6ManX/tjTpEIOFo9T5SARFd8
	onlZQoSEQ4CFKnpFsw+zly+b+4j8ha52iifR/2pasIGputD0gIabS2FjKm4sf654fj5kW+yrjuo
	pHcRrGaXxHLkzxcynlXotB/Jzn0lHPqCrs74B5IQ5xOle18dNmxFqlncHbM4V7R1sdYRbJsAi1U
	qKOBXGuQze2pZJc/8gHCCnGsWlGEuvcHTGRReOE1Kc8qv1JUY1Cas4BtgOh1NBdhCWc6MmTVD4F
	aIFJdJITp
X-Received: by 2002:a17:902:c951:b0:220:cb1a:da5 with SMTP id d9443c01a7336-223f1d0fa09mr121526945ad.40.1741275273049;
        Thu, 06 Mar 2025 07:34:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5Q0DEldH66WOvtHkW2zLuNph0VjL8IdrDpkTpdqpAp6ndBWd63PrsG9ZbZoXtNCsxEAkoLw==
X-Received: by 2002:a17:902:c951:b0:220:cb1a:da5 with SMTP id d9443c01a7336-223f1d0fa09mr121526575ad.40.1741275272644;
        Thu, 06 Mar 2025 07:34:32 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f89dsm13727395ad.109.2025.03.06.07.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 07:34:32 -0800 (PST)
Message-ID: <151d1c74-a488-4c09-bae1-39e4588e19c6@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 07:34:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 06/15] wifi: cfg80211: improve
 supported_selector documentation
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Ilan Peer <ilan.peer@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
 <20250306124057.8ba33932cad6.I502b56111b62ea0be174ae76bd03684ae1d4aefb@changeid>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20250306124057.8ba33932cad6.I502b56111b62ea0be174ae76bd03684ae1d4aefb@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67c9c08a cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=DBGn_c5LbACXDqsZ6RMA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: K5AH-g1TcF82fHUXtTLuaadYAxcl014K
X-Proofpoint-ORIG-GUID: K5AH-g1TcF82fHUXtTLuaadYAxcl014K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=809 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060118

On 3/6/2025 2:43 AM, Miri Korenblit wrote:
> - * @NL80211_ATTR_SUPPORTED_SELECTORS: supported selectors, array of
> - *	supported selectors as defined by IEEE 802.11 7.3.2.2 but without the
> - *	length restriction (at most %NL80211_MAX_SUPP_SELECTORS).
> + * @NL80211_ATTR_SUPPORTED_SELECTORS: supported BSS Membership Selectors, array
> + *	of supported selectors as defined by IEEE 802.11 (9.4.2.3 in -2020) but

I've been trying to get my team to consistently use specification names as
they appear in the standard, in this case: IEEE Std 802.11-2020. So I would
rewrite as:
  ...as defined by IEEE Std 802.11-2020 9.4.2.3 ...




