Return-Path: <linux-wireless+bounces-17828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EE4A18F88
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 11:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEA43A2D2F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00CF18CBFE;
	Wed, 22 Jan 2025 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDSOnMG4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3D145FE0
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541029; cv=none; b=oEAAScuU6OWkXPNzW+t/xbsXI+LbjOskGIYGVfvoICK0baU9q6svdzsiJr3XfwjQtJRpgzUq4s175aGr0bxNX07WMcCpfxeRzkimEKQIT+EIDnNxxm0xyAR0M+lf5atssGsSKLOGlOn+Gr/Vc5JhRdfvr7aCUSf3rsHSgtkMT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541029; c=relaxed/simple;
	bh=vrH63krZ7eNhOga4/NyfskF2ZXFF0l5DCAO5SdXg5cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcRG74VWortvrQObFUnUsNJ16HeXR36dite4TqkJFZFKko+go4gJuDWAI0KriL49K0kHwGDJMkGawQTSIl8j6clqCFUy9JtEiZjkAmbEZtf+5iCgQ6tOk3GeJ9YDlH1XRYX2zZMrDNoo9K6eifVfSjAIc1OL2Rjos0ZGjcZMxkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDSOnMG4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M3Rb89023746
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V/oUjLNTzQt+kt+cq0pXCT0A6dSRAMY5Cz1QkSnusyo=; b=FDSOnMG4yhuqvkMY
	uK6DOjcMyueGnOtNwwHXR5wSyCt4GzJx5ufTOhp0u2lhI+ysDcFaP1oXB9Qq+d4z
	b/oB1N+75UYxw8bcUz169k3KLo+7DAIXq4K4GllfhYDD6iUmQk4k+A3Yq4XBKOga
	+0nEW6ReSyv0Wf7CmyFEJ9CbvzzzXjARARS5hAkzBJyyMDlcONGVrkXXq2eatyUu
	uoSVUl2OCTl/ziXmvu7Lfzgo9beDJgNKgABdqOgTlOkC8q+4cZxAw/W6tj4sBaCo
	9kPfs24ref+IbrkWVq3FCeVArV8+6/xiEvvQWnUOTGOH9vzp8kCmmzRRoOIT/xA/
	3Gdb2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44arssgwg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:17:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216405eea1fso124149025ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 02:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737541026; x=1738145826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/oUjLNTzQt+kt+cq0pXCT0A6dSRAMY5Cz1QkSnusyo=;
        b=xNr4/GW/Kl55reejcWcwAgFHEMJHhpBZmHD9mq8EnQF8sDjJtFYIqKFa+7qlrvXiTf
         gFgwxBGbJZuiDibj5gNmjLelme/mA11Hw2Gd0lIuantlcBlQQBOKCAPgjBuDjsizHKbX
         q2pCNHWbfYWQTktIVVRfzj2sdtrOzRfybPlculX+xNoOFD7SPpHh7q0EMpbej7uEfOmo
         VIgsaEbLBl+a1TwQ02PVmDLcYP70BTOTWN0CoC+veWFXiImS9nv2iaNWcnvRsTFkbFlC
         lsuu6q8DPJD+i1kPNIYOYyxJhFNvi3A/o0DlteBG0xtTo0OCTsGag7HXW1PJEzURUM0f
         hpyA==
X-Gm-Message-State: AOJu0YzbperbFcizzaCpw4cbC4dDO9AD6XfPGQ1KKHKjsNi2avKVsw9n
	595b9fZ9N+5iiOE0vOKo2x+VkOvmBwDQp49r6u02puczmOe3dEDybfloDttfP5fucHFyQiHkiUf
	BAdnq8Jj7aTFEuYhI77/NScJVzmj2SgGxzoyUmjODrdBZUqbEC7eUzNowH6pxOXT5dQ==
X-Gm-Gg: ASbGnctEdTZJEI5e3zSPsre0wxsdWxyVt1VRMtk+c8yB/QlnlLgWnh+zJ/XOSPr0edS
	Cm52lpIsyIGdzrsTK4n2fJT0skb3V6HbzkyKsVloruLBzJYQV7gqSGmBwcT2z+mUujK+rk1U19z
	nsVubimwF5rP4Bg4x+nEJt1w6LcR/VWxhUlLdSZ1tA9QbY4XEyUU5MdEozH2iGtmxOCMWvBpprZ
	WylKX1Iu/I713nrZyaoHqjHMVokTok6agUsuRvOThVCvsCV1U1SI8k643p5Eag4ZKKWoZ4mxFOO
	tpsFD+CgJhCTEwraMBxgHuFV7o2H
X-Received: by 2002:a17:903:2d2:b0:216:2804:a241 with SMTP id d9443c01a7336-21c355bc154mr313959005ad.37.1737541026236;
        Wed, 22 Jan 2025 02:17:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEmXtURoe+Ng6d09jVMyegZJR+EK6+rHg3L49Dl1tYGgiNBdN3LUBKDKExgURvnWklmTb/vQ==
X-Received: by 2002:a17:903:2d2:b0:216:2804:a241 with SMTP id d9443c01a7336-21c355bc154mr313958635ad.37.1737541025845;
        Wed, 22 Jan 2025 02:17:05 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3acce3sm91808995ad.119.2025.01.22.02.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 02:17:05 -0800 (PST)
Message-ID: <1c25d032-894a-47d3-9d7c-a235e73af9ee@oss.qualcomm.com>
Date: Wed, 22 Jan 2025 15:47:02 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] wifi: ath12k: use correct WMI command to set
 country code for WCN7850
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250121104543.2053-1-quic_kangyang@quicinc.com>
 <20250121104543.2053-4-quic_kangyang@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250121104543.2053-4-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: F4cHO_4L-1txFsFd5Wo20nfrTr55SHEF
X-Proofpoint-ORIG-GUID: F4cHO_4L-1txFsFd5Wo20nfrTr55SHEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220075

On 1/21/25 16:15, Kang Yang wrote:
> From: Wen Gong<quic_wgong@quicinc.com>
> 
> When userspace try to set country code by NL80211_REGDOM_SET_BY_USER
> hint(like iw reg set XX), it will pass new country code to ath12k.
> Then ath12k will set this new country code to firmware by
> WMI_SET_INIT_COUNTRY_CMDID. But for WCN7850, this WMI command won't
> take effect.
> 
> For AP based chips(QCN92xx), WMI_SET_INIT_COUNTRY_CMDID is the correct
> command. However, for STATION based chips(WCN7850), it need to use
> WMI_SET_CURRENT_COUNTRY_CMDID.
> 
> Add flag current_cc_support in hardware parameters. It is used to
> distinguish AP/STA platform. After that, the firmware will work
> normal and the regulatory feature works well for WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong<quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang<quic_kangyang@quicinc.com>

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya


