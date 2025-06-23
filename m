Return-Path: <linux-wireless+bounces-24366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3861FAE47CD
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 17:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC941883DF8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D47D26D4E7;
	Mon, 23 Jun 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+ShHQbs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506D2192F8
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690993; cv=none; b=SkEKIOstjWQqTaiICHc7lBcc1NM19eWbFuO+bxLenOsXWmsdsvIouzMaMtz4qB+yeZXtAqdX0i2cGDIFYFddJ+t9I3LZxbRL8HZmiZVUwcWQFcfFArtJEvi7+wz0xh5EwuHwAaogW+U8E0qyqi1Ue/zh+Vikc0Yy8WDW1ibriHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690993; c=relaxed/simple;
	bh=kj2vit4ULQDNg/xWvdli3lSrm+UIS209GlENiy2LTnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXqWg/FwB/qPS27oQBfOjoyH0T6NmcH5VlPS6UUynxtwG8+crjpBOCkI0/wNo+u2814wPjF5STzsaYkopO2fxPThbz7IRCdicKnxsth2JH0S2WtiqL5nIkvWm4q4TByvrfKbUasQTGL/zOco5ShdzuPUcnjbwthhbs4AKEOpA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A+ShHQbs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9ZeHF019573
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 15:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ACu+Ugoc+fmjjc65HLikxPSEZ4wRcHUDOKbnH+1uLps=; b=A+ShHQbsJjOrz3s2
	9Z/Plg0bKxg1oEMZ5FNLwGstZORMWILp+gfXq/Zje/ePad3uWhLCoopqoz0jv6BM
	iUvoc5YBenfaJe0BHfaMMVkfiQ5mD+aLxL6ZLXYxg21ciOYZkelvT47v8T9zHM9w
	iXWh2lDDd04IynJsGsyabXcXFIsLRIJ8IyyzepoAk7cQSoe/V52aGi9cqgIFwudC
	fFFUF1EoJlygd10U63wGLctLzx60S+XDFctM7H0PoURmFvCcwcgNxjGhw1KwoGnI
	r+WlgdoAIeVlu4PRzaXEuCtEAR3QG1RUnYMPtAaHmWOwv/HU5+jdfnPwpIhG32/Q
	oZGpRg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4jc1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 15:03:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso1782332b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 08:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690988; x=1751295788;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACu+Ugoc+fmjjc65HLikxPSEZ4wRcHUDOKbnH+1uLps=;
        b=HrihWStbdpEE5SXahYSU50X5ry28QmQv5Xoh3xvHdfMRBwUatX6z5SY/j+RiCm9gIx
         0jlvo1izawJItgfzz5cA2HjXXwtTnpayUNkXcEQNLpKeneXmhyV8UnNN9BrsSDULIETs
         9Kf13JdiozvttGyRohDjfQfW8c3QydBWQeK1w+JzgwNg0x7C4cesKm52pz+fqJeC657n
         k85oI2xuKj9Uj+v8X9S0bC6aNeImpTs7F8lFvGP0NNb6qYG0EZM1vbrs7nlSpDWlHyU9
         liuaAdcYisIZCPmhu2mSR0Vo5hBZnQ3gYlM9wrK277/63AXtWGmqWO5txrbkd5sUpriw
         yRcw==
X-Gm-Message-State: AOJu0Yw36gPmn0ejcHFubE8qk9gi5vZAZWwZY3cf0WXk+w4BVYQTjfWq
	Z62i5RDxVO5KEd1ka0Hr28ZEWY4ldQHEMSde6Ax76Qv2OUdRSYkgZPrxfK+RhkOUQEzqKOKgh4S
	ZO3grvmSbcsmhMbSvb4YSw5sHhKtp6CUY3Qn15TzO56xHjVuGWV/OiGlkBjrcGKC9IvqAzQ==
X-Gm-Gg: ASbGncvHY6VdcN3XqoyzlwCM2qJA2k9S5YBL8uPU7Pp78ptiGzgZliL2QhArWEXcdUV
	Bzjmb0uVRdGa2Wji4qbWteGGqKTCR4bcC/yHtjfa3yqyKWfH8Z3roTv2AJx2kF5JsevntDJ1mnP
	5sCTIZwOj89gHz+WMOs3LQOHLlY0UJd3lqrLFFohwydYMD0dL6S+h68xX0HP1WFQFUrol65ScVN
	QgRSJxf2AWMO9gEtEWwAep77NryD67M4z49Lv4OdM483voo5ZZFN+8SlGcMKLfFv9qrEzljmJef
	+9YHm6FNAb0JBHkIO/wE6SrutjjILEnn3O9CJl0brWpeu7weyfdOsrXP8RqbyPzcMs3nSMIH5Sl
	4sQ==
X-Received: by 2002:a05:6a20:72a7:b0:215:ead1:b867 with SMTP id adf61e73a8af0-22026d8c81bmr22088500637.14.1750690988255;
        Mon, 23 Jun 2025 08:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG74WojNJSxdTzppMSfsKAjS02fehU849MkaHH5rLr8CDvVCCJUz/6i6k/1xBO9Cr/2SAoM7g==
X-Received: by 2002:a05:6a20:72a7:b0:215:ead1:b867 with SMTP id adf61e73a8af0-22026d8c81bmr22088433637.14.1750690987654;
        Mon, 23 Jun 2025 08:03:07 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f125d668sm7015916a12.54.2025.06.23.08.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:03:07 -0700 (PDT)
Message-ID: <4521d120-422d-4dbc-9461-6bd0dc32d628@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 08:03:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V14 0/9] wifi: ath12k: add MU-MIMO and 160 MHz
 bandwidth support
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250521224539.355985-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250521224539.355985-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=68596cae cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=ewB7IA-g4tuOwMp8HOQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: wZ4oN3-w9HEYKLEEMr4Tqy9tIb9_GlqO
X-Proofpoint-ORIG-GUID: wZ4oN3-w9HEYKLEEMr4Tqy9tIb9_GlqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5MCBTYWx0ZWRfX0faVNt/UpFlG
 z4OUX7Bc7rhv7nLZDtZPbVQiaUYY6TKCc0I/oduvdR2Dv/bxvZqUWlJmh5PaqluZIZm2BqKxul+
 vAoV85MkmHPPZV62TE/dBA+XBeOWoG/b0xauHeZfIHFjjz5ZAAKWzCvKafEmpawTrt+uIioxEd9
 Fua2xH9adEoOhBLoZ6tbKmXQ7zhASM/mKOWhGu/WVmxkKRkTK4NTEUUg6tiorI4GsXHok+ZNjwl
 CN/tJyqPSDkmY+gBBxBT1nq+ZQlLbTLtw329xHlurD/pDDC5M+oNfnZVZRLZy/p5+0Gq5maG0xm
 0epnN4UfmE7k+jpojfqO6ywBjHMa8zecDce0WbEu9ZELI+mW01JWyQJex/FX0pKh8w/6RtFpN6T
 dusyitfOrKe++5acMUQxFNCfZFsD3pQJ5aKMad+eMmcJ4aAzKifzx/yAWKbsdv5oCqmo5COG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230090

On 5/21/2025 3:45 PM, Pradeep Kumar Chitrapu wrote:
>  Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v14:
>  patch 6/9:
>  - cap max_nss using ar->num_tx_chains to fix interop issue caused due
>    to sending nss value 4 when firmware only supports nss value 2.
>  patch 8/9:
>  - Set the default return value to MODE_11AC_VHT160 for 160 MHz
>    to allow STA to connect to the AP even if it does not
>    explicitly indicate 160 MHz bandwidth support.
> 
> changes in v13:
>  - rebase
> 
> changes in v12:
>  - rebase
> 
> changes in v11:
>  patch 1/9:
>   - fix return values in ath12k_mac_set_he_txbf_conf() and
>     ath12k_mac_vif_recalc_sta_he_txbf()
>  patch 6/9:
>   - fix missing he_mcs initialization in ath12k_mac_init_arvif()
> 
> changes in v10:
>  patch 6/9:
>   - use ath12k_ahsta_to_sta()
>   - fix rcu_dereference warning in ath12k_mac_set_bitrate_mask_iter()
>   - change return type for ath12k_mac_validate_fixed_rate_settings()
>   - improve readability by adhering to nl80211 definitions of GI
>     NL80211_TXRATE_DEFAULT_GI. Introduce ath12k_mac_nlgi_to_wmigi()
>     for conversion.
>  patch 7/9:
>   - do not change default MODE_11AC_VHT160 in
>     ath12k_mac_get_phymode_vht() as it breaks clients which do not
>     set VHT_CAP_SUPP_CHAN_WIDTH_160MHZ.
>  patch 8/9:
>   - Use IEEE80211_VHT_CAP_EXT_NSS_BW_MASK along with
>     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ for determining VHT160
>     phymode.
> 
> changes in v9: rebase on top of master branch with mlo changes
>  patch 1/9 and 2/9:
>   - fetch link_conf using ath12k_mac_get_link_bss_conf()
>     instead of arvif->vif->bss_conf before mlo
>  patch 6/9
>   - fetch mcs/nss values from sta->link[] instead of sta->deflink
>   - fix spelling of 'incompatibility'
>  patch 8/9
>   - replace sta->deflink.addr with arsta->addr in
>     ath12k_peer_assoc_h_vht
>  patch 9/9
>   - replace sta->deflink.rx_nss with link_sta->rx_nss
> 
> changes in v8:
>  - rebase and resolve KASAN warnings reported by Jeff in v7, in patch 6/9.
> 
> Pradeep Kumar Chitrapu (9):
>   wifi: ath12k: push HE MU-MIMO params to hardware
>   wifi: ath12k: push EHT MU-MIMO params to hardware
>   wifi: ath12k: move HE MCS mapper to a separate function
>   wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
>   wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
>   wifi: ath12k: add support for setting fixed HE rate/GI/LTF
>   wifi: ath12k: clean up 80P80 support
>   wifi: ath12k: add support for 160 MHz bandwidth
>   wifi: ath12k: add extended NSS bandwidth support for 160 MHz
> 
>  drivers/net/wireless/ath/ath12k/core.h |    2 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 1144 ++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>  drivers/net/wireless/ath/ath12k/wmi.c  |   13 +-
>  drivers/net/wireless/ath/ath12k/wmi.h  |  107 ++-
>  5 files changed, 1061 insertions(+), 222 deletions(-)
> 
> 
> base-commit: 0d777aa2ca77584b339ce195db86fe0ee7dda5d5

This series no longer applies cleanly on ath/main, please rebase

Applying: wifi: ath12k: push HE MU-MIMO params to hardware
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/mac.c
M       drivers/net/wireless/ath/ath12k/mac.h
M       drivers/net/wireless/ath/ath12k/wmi.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
Auto-merging drivers/net/wireless/ath/ath12k/mac.h
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
Applying: wifi: ath12k: push EHT MU-MIMO params to hardware
Applying: wifi: ath12k: move HE MCS mapper to a separate function
Applying: wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
Applying: wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
Applying: wifi: ath12k: add support for setting fixed HE rate/GI/LTF
Applying: wifi: ath12k: clean up 80P80 support
Applying: wifi: ath12k: add support for 160 MHz bandwidth
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/core.h
M       drivers/net/wireless/ath/ath12k/mac.c
M       drivers/net/wireless/ath/ath12k/mac.h
M       drivers/net/wireless/ath/ath12k/wmi.c
M       drivers/net/wireless/ath/ath12k/wmi.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/wmi.h
Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
Auto-merging drivers/net/wireless/ath/ath12k/mac.h
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
Auto-merging drivers/net/wireless/ath/ath12k/core.h
Recorded preimage for 'drivers/net/wireless/ath/ath12k/wmi.h'
error: Failed to merge in the changes.
Patch failed at 0008 wifi: ath12k: add support for 160 MHz bandwidth


