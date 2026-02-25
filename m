Return-Path: <linux-wireless+bounces-32184-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qClbI/Iun2mCZQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32184-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 18:18:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296919B6A0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 18:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 640003011C63
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647327B353;
	Wed, 25 Feb 2026 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="afza419v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IvuiCtJ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C62288D5
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039808; cv=none; b=H2IcNNclnsQVbhHG+bLyCeYiP0JKVg0W261gvazxW5+62a3XUe8K+20VNu4DlaMV0IWzRgNJmv5Bq2gIBbxYrYC6y5tOzccDQBpz4aIpq9+nUsvELqScUBjP1ki2MWPFaoIhyDG5aZGEBFgQN7F9qSKxfhicIctip8y2idaAb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039808; c=relaxed/simple;
	bh=Y6CtCEPbNUTKqfJy3L7oraPFSqzGaGRR9ZQD5YEgNKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyPJTVPKU86nE0BYTrCJm1Ah6lvW653IN74JQoKVHwlZCuCH0nYQQAgvK9JdEYhjdCTi0eP3hkvJbJySseY7jgEr0salAuAJNcxw5h+bNsUWYhNedhsyrds699ELDPNjLBw+pKdvEcPmRDAlAH+S5ol1DBLlU8ulpfzdUrrIYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=afza419v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IvuiCtJ+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PH3iTv1195669
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ciOAPCiiBYAFoSPYdBWAJh+twKO/zxGm8VVRYLtvQWc=; b=afza419vUROKRJ9+
	xxfq+nVzU/gZ5q3sBjbOLijUdd4f1j9L7WDW1qPA/3FZ+3Lnd49yIqiKdLWS1Slz
	mDIlAzUN230CKO2Xopj7JN+/sag3onwu0IwdFZziS8a761kIq4q5cS6dINuyK3TI
	zHNbfP664Gz72f62xs5ducN6/OryVVNpG38DRa55hMscO6swGqdoRsndtXDoMU/o
	CF8A8rR36GK5b+MPBb4uhQJUuasEFuMtzoRzrfn+uwcs5+j/aXB3ORl7PuDsBcRh
	L8hqeWNzib84ylL3+U7Hc47V9YFEsCb73duhSgSPzBkLaZKMcyvs2uYPt5y4yzEe
	Nfvzug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj559g1rh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:16:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aadeb3dee4so496314015ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 09:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772039805; x=1772644605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ciOAPCiiBYAFoSPYdBWAJh+twKO/zxGm8VVRYLtvQWc=;
        b=IvuiCtJ+l402kwBwgkPZIyiaXu1EK7IEecYbV2F+y3qEGJ/6+E4K1YCkGAYMJd7VXh
         ahoXZQZr56NAvriTBHSYgkUVopTKVGS6Y5TtJEaYOOAVtSkKq/GGvREOWWcYqZtYy8HY
         5Kl1/S0LoHPUfmbtw5NI9Y5jcGubI8qanEX1BTP0K1I1S7sNsoCK6X6j8YBzOsi3nJ+x
         dJVpedxCsFPqcSqxia0IpbKlonphQEuRLTcx/QPS5y8rTAkJ8czx/5mw9vHb+nZ/O0h5
         JjVKVLRVMrDwkl2IUOPmQESk0FeJxQZy6Eu1HxzEqw2SAwLZs8+BT6sj+3uzwZ5Zn46q
         sedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039805; x=1772644605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciOAPCiiBYAFoSPYdBWAJh+twKO/zxGm8VVRYLtvQWc=;
        b=eaoMApbqy/wTNeFerBs1vJl0NiI5pnEQE3XQCi5OHutTu8nIBcaf2NO1RtwBTKBFWb
         vqLo9X8lNbRyFJ/RSO7FJSFTBGpV0aSUtaJf+7rtFbWzpupba+6ONuNFx8B4VTZWORvX
         7GlvPCZ9M8lPg8pB4oQxL2+9Fbn39JETf5yaiPcMOEZV/Z7ZFsIP8iA9qEWhq1qecHmt
         rWvW1l8fL2YmSNxBqlwPrRvGl1dttEcu5XrB8avMTXK700gXFcUMA5lceYssjc7tdXF+
         vPt3tqrllY7lo1UrEAAwHcwjUBRVHH+djheZLY0NTavfAJ72CwPuHMGN0gP0WZEa5wqk
         b0cA==
X-Gm-Message-State: AOJu0Yyuga4rbZRzmAlREbDj9yZUdPEA+gFM1llm9ghfjfXTGRLsSYnp
	aClk3Y8vKWu54SiqEPKNPN5oLCmRYNKSViAQCIIL390Sf5MWCmLen5+V3Nup69DjV80V+PGzRuw
	KeaT+31vwmmW46/9L2ncuC+LqT0CDD49Q/ico9lyMHTTJ5CYCY4AveuyzPfWIcdPGMZ0j1RFXZY
	9EMg==
X-Gm-Gg: ATEYQzwHiWmen2iOGzdi1rHiVL6wwdVPjbwuTRZrGsv0w4IZGYpbdmIYgdYi4bJ+hAb
	oI/TMzk1TCKgbnbW+BXWRc3UdFQKRyrhsoTHZhc6POybttKK0+qOSXEcYCb+hk4WZH3+X63nW21
	iaxYTgbQvLZ6K3qCCvB7bmvO68OzIkKExvPA7IU6E3XFTy3bBUdbysd7aJQgAyL05tHbf88Ydvg
	ipVQEz29aWwmxWmvlbfxcMbfkyNRzPiCWI6VYiDyqKllzVaEFO/rkgR59iD3Jn+Lt57YDEVq99S
	oD0LRKXCYVSwaQO6rxgU3hTu/GWAYMcA46XrHi1gPu/Ke0AZYxenw24fzU+pbzPYvf2G6KVFM6h
	D1Qo74Of/NzmEXcarsWn2EUdhzuim3ybL5F8FEDgWqpQh63K09xXHHfgI1mY62rjyMAhqRh6VwA
	==
X-Received: by 2002:a17:902:dacf:b0:2a9:4450:abbc with SMTP id d9443c01a7336-2ad744e0d24mr157392605ad.26.1772039805134;
        Wed, 25 Feb 2026 09:16:45 -0800 (PST)
X-Received: by 2002:a17:902:dacf:b0:2a9:4450:abbc with SMTP id d9443c01a7336-2ad744e0d24mr157392265ad.26.1772039804563;
        Wed, 25 Feb 2026 09:16:44 -0800 (PST)
Received: from [192.168.225.142] ([157.49.193.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75054aa3sm145895395ad.89.2026.02.25.09.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 09:16:44 -0800 (PST)
Message-ID: <a2278722-d370-40f1-b9a2-6bc13aa04a2d@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 22:46:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix legacy rate mapping for
 monitor mode capture
To: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
References: <20260209054924.2713072-1-thiraviyam.mariyappan@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260209054924.2713072-1-thiraviyam.mariyappan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: v19fGDH9jJ28BjXu_PsBLd6MBmaOOKez
X-Proofpoint-GUID: v19fGDH9jJ28BjXu_PsBLd6MBmaOOKez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2NSBTYWx0ZWRfX/MWJrENnVBQ+
 aLqxl0kwSRgTUf8z+JaoK4kclVf3xp0die2fLGUGLtn2QrbgVVdc+P5+TGxwvKjA5DZQpeyvUQf
 pYx2oFmbgPZjeFTafRrLzxWHJbZG5zO75vvFv7O8adrBldQqxsPVIvHxExcHG+FtdsrpWJXJnw1
 P4ERcV0GW2U38FjFn7OqF2Z2eF0q7oeJlnMw41PN9OGxSMIu004IAeY7Zr6uP9kOJ7+YsZf3L3r
 sfFa6Uo0y5dWL4v4f8KgdutSbWy15Ar+ZzE1Eo8SdFsXAe06QTiltITGJZi3UU9be94Hjyj3u4l
 IaQjf0eHSLec10g1poOWuyD6TK7qJlUNIL94JiaEILyeJc9aIvfkMNQUtJGe6QoeI+AhFv1eFdw
 9Z5b+NwNe2TdXsUWZEZtLT/J05umvCzSt95+TQYfuLHEkDKjtMb1S5cTBghazI78fRFtEoSe8dh
 YqkobTV5Jqn+7QoDjPA==
X-Authority-Analysis: v=2.4 cv=TcybdBQh c=1 sm=1 tr=0 ts=699f2e7d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=hSb1S3R1191yeZY/11SCyA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kvUqLCy4jVkouz2hCqIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32184-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1296919B6A0
X-Rspamd-Action: no action



On 2/9/2026 11:19 AM, Thiraviyam Mariyappan wrote:
> From: P Praneesh <praneesh.p@oss.qualcomm.com>
> 
> The current implementation incorrectly reports legacy CCK and OFDM rates
> in monitor mode radiotap headers. The rate field displays wrong values,
> for example showing 11 Mbps when the actual rate is 1 Mbps. This occurs
> because the HAL layer uses a unified enum for both CCK and OFDM rates
> without distinguishing between long/short preamble variants and proper
> rate mapping to hardware rate indices.
> 
> The root cause is threefold:
> 
> 1. The hal_rx_legacy_rate enum conflates CCK and OFDM rates into a
>     single enumeration, making it impossible to differentiate between
>     802.11b CCK rates (with long/short preamble variants) and 802.11a/g
>     OFDM rates.
> 
> 2. The L-SIG-B parsing function maps hardware rate values to the wrong
>     enum values. For CCK rates, it incorrectly combines long and short
>     preamble cases (e.g., cases 2 and 5 both map to 2 Mbps), losing
>     preamble information critical for proper rate identification.
> 
> 3. The mac layer's rate-to-index conversion function does not properly
>     handle the precedence between long preamble, short preamble, and
>     OFDM rates when matching hardware rate values.
> 
> Split the hal_rx_legacy_rate enum into two separate enumerations:
> hal_rx_legacy_rate for CCK rates with explicit long preamble (LP) and
> short preamble (SP) variants, and hal_rx_legacy_rates_ofdm for OFDM
> rates. This separation allows proper identification of rate types and
> preamble modes.
> 
> Introduce a new mapping ath12k_wifi7_hal_mon_map_legacy_rate_to_hw_rate()
> that converts HAL CCK rate enums to hardware rate indices defined in
> ath12k_hw_rate_cck. This ensures the rate field in ppdu_info contains
> the correct hardware rate index that matches the mac layer's expectations.
> 
> Update the L-SIG-B parsing to map each hardware rate value (1-7) to its
> corresponding CCK rate enum with proper preamble designation:
> - Cases 1-4: Long preamble (1, 2, 5.5, 11 Mbps)
> - Cases 5-7: Short preamble (2, 5.5, 11 Mbps)
> 
> Update the L-SIG-A parsing to use the new OFDM-specific enum values,
> maintaining the existing rate mapping for 802.11a/g OFDM rates.
> 
> Refactor the mac layer's ath12k_mac_hw_rate_to_idx() function to
> implement proper matching precedence:
> 1. First match OFDM rates using the IEEE80211_RATE_MANDATORY_A flag
> 2. Then match CCK short preamble rates
> 3. Finally match CCK long preamble rates as fallback
> 
> Add helper macros ATH12K_MAC_RATE_A_M and ATH12K_MAC_RATE_B to improve
> readability of the rate table initialization and ensure the mandatory
> flag is set for OFDM rates.
> 
> This fix ensures monitor mode captures display accurate rate information
> in the radiotap header, correctly distinguishing between 1 Mbps and
> 11 Mbps, and properly identifying preamble types for CCK rates.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
> Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

