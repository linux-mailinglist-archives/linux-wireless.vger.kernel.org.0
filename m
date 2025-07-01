Return-Path: <linux-wireless+bounces-24701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF242AEEC5A
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 04:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB701BC2AE5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 02:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CFB12B71;
	Tue,  1 Jul 2025 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JVzipEJa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56950125B9
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336177; cv=none; b=NlI3fKiTDFzh8RiZ96Uyo+XQROQPCWASQXuQxJggKBdQV4w2aGdUgK7Zu59DhD+zmJ0mQYFyuaLj1JO5IKgZiyN8UR7jvy5oOXOY87WYUdQxvxc0CFtKRPhV49bRtiAG+cmLSFLuBZyAVXwBcEW2QIgrCbuF5ARpRw7wa1tbkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336177; c=relaxed/simple;
	bh=+9C2M+ppdFEg25S3v7fUXc6qauLb3JUdOxmmH8VF1Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1mC5QP4c6z9OZU2n5p+x3/d8qBttAePCjRNN4UIvOgQms5/SeYpTNk5r3ODlLD/mn5wHLN70W1splAVvm8AdYcACYX5jA+BR2ccIwq9zgXucbGkPPzVTXufOp69Z0Fyyh3g5VvL/++joEFg76YSg2MaicUowShiDn5AC6jsOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JVzipEJa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFSYul025200
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 02:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pFHZR640whZ50apTRavefB7gtI4x66BfTikrkd3j2JA=; b=JVzipEJa5pritMl+
	4CW3825w9IHTnwFHVlCP+9+QqOVUYUa72B5VAXwvw9YEztLxK4f94a6e96Df9bWv
	NU54lBlbtXL5rzVhmmd8epHCMHdN3U8vReFpsqmBAIevJjpuXkh6nDI8kNhqbJEZ
	FKPmgUx2FfeqHJ5dl/GfsX3sWFso+99/fcr6OTEbcReVFwe1Yk6QVhueAiu8gw6q
	ZvlXMtQ78doSkr8421k3uU+rE4xMFT+j5GuPV7TM6Mw/AEzeNLgCYQ0wcTB3ANGd
	WXzwB+RPkeTGS8WVsco1OXKN/oDOVgSI7V7YIM4i7/Vpzj+1gFB2dGgp6CmBElAw
	woNZiA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kd64m0dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 02:16:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23692793178so42879325ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 19:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336171; x=1751940971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFHZR640whZ50apTRavefB7gtI4x66BfTikrkd3j2JA=;
        b=UnF72mb1aU4ZmGYbS/hft6pTUeLiCGc2/jszDPL/3UDNCdfN3JjPZkUHwpE6ipEKPq
         GlsWZPFnUdLezqUTMxUjx835GBSqi4ia4AsZVTLf80KczkPKWcmGRJIfP9E4CEePiQwS
         fMPYcADwIYkQCxvnku+y6rUyRPm17WGjsrCHea5KbvHLanavDWODOtri+gm+vAOWQhyX
         kQhRnb6E8X7sGxColqFqwWQ8usnqE6Ao6Y49UIWDwPtQIKAF/jid3D9nSlueFl2a27Gh
         NY+wxwy5O4oFmiGo2o54/X+F4SkzKhuOLHXj6/AVdwOvGJIq779W3OtQAXRJ2MQFhbG0
         mOTQ==
X-Gm-Message-State: AOJu0YzXwflb1uKhX3ns2d8M8uJJZcEA7AaSKHpfv6ChX9JcziNcZW8r
	7G50ta1MqCScxJ1iMMshq7Ihbw7TSgBYBRnOOMrpoTwq8NDe5xzaIlhqHrXIPvCqepkOhFYCO2l
	bZ2Ull1y01KVtboQ5nzn7P0N5A4tSCfROeYl//ja2hbO1SQBbLAJu17X4yQVBCgxokQDn8YR2A/
	f8rxfC
X-Gm-Gg: ASbGncsO4hGQ3hKFIGrOLHniGh67GLnd5nL/e5DzM/NinVJEU1J62SgqvOA6w5w91B7
	iX05j0E8z9uijjEyd/QZxakYUBIzxtKKG9WDCXLuiqhxycojlvOo9dq4bab/QRRWXHwBcbMxVbx
	cQXYi09cq5iV7kmL17vOf6bfScu97lMXrAp6otEFFxLUOXwgvPCIPga8dlct9y74W8Yd5Tp509J
	LRI1MP/Ll4wvjBs31u8KlNi10p4T5wZoC3UT0uQ0W2IcZUiQjt5Ky6OKtFpZsgk/MEo5QP+/eg4
	A2g8GifaIQ+KhDfcQPSwc861QaBzSzs2xpzdKwrVnYJ/yh0uGxfcQdxEP2Zc6RIqbAlSLLh2Vt+
	lf5TVaBMr
X-Received: by 2002:a17:902:da8b:b0:22f:c19c:810c with SMTP id d9443c01a7336-23ac48e36demr215881695ad.51.1751336171322;
        Mon, 30 Jun 2025 19:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl01jur39CibMv88CkAiIoOzI3KNSrRmyG7VLRH6HJ62L2QCjUqXTwQIAIA8IMkZVVV7dQsg==
X-Received: by 2002:a17:902:da8b:b0:22f:c19c:810c with SMTP id d9443c01a7336-23ac48e36demr215881415ad.51.1751336170846;
        Mon, 30 Jun 2025 19:16:10 -0700 (PDT)
Received: from [10.133.33.126] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c8649sm95503675ad.236.2025.06.30.19.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 19:16:10 -0700 (PDT)
Message-ID: <bd46f78c-6448-4b89-a788-45801acb2b16@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 10:16:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V15 0/9] wifi: ath12k: add MU-MIMO and 160 MHz
 bandwidth support
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z+PsHGRA c=1 sm=1 tr=0 ts=686344ec cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=g9aHqRueWkUMR_c1qpIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAwNyBTYWx0ZWRfX9oLTbmVXK+9O
 PjcutgRQMf9ZCFgobCb5DeoTSq6E23NxPkoNhMsXalQ7jukygV8kDBOoPdj4cFpRzdm0/nWCUyO
 W7wkbr6A5Efu77vRdP/wb3dSlylFjB2uUEd/Sls395ierO4r3N14vEGjFquw6i4PHn9VZnf6Zvd
 sUgya5+H7SzPwgROSn/ofUUJC8Xlqsqu5zdqnsYHdhIgp4ZvmQHH+OlkBvXUAINNDT1wvs/VEIC
 pmtTtZXaINaI9g3EL5PkP2VHi65tYUzZWkvfsXlurNkrkyfQGwunMOYMaqXiVpYODgW2hOPUfzc
 S7KBPZ+axDuBPnyKggghKAMcd4+5q3tTLZEsN7MIMb07rWgbimbhas8Z6QI26MMpvvNKaNx/qLq
 SIwQDGzyjoIL52+0p3TpwRxxhy/ugr8KluRfjwyn+TGsQ4tpUN1/Of/kjsRIVss8UtUrtkE5
X-Proofpoint-GUID: Gmb1yfiOrZB3DPmQEaTFrxkmMv60focU
X-Proofpoint-ORIG-GUID: Gmb1yfiOrZB3DPmQEaTFrxkmMv60focU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010007



On 7/1/2025 9:03 AM, Pradeep Kumar Chitrapu wrote:
>   Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v15:
>  - rebased the series after merge conflicts reported
>  patch 4/9:

patch 5/9 ?

>  - change the fix to apply for all modes except STA mode as
>    WCN7850 expect it same as before.

It is not chip specific behavior, for now we believe it is mode behavior.

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
>  drivers/net/wireless/ath/ath12k/wmi.c  |   28 +-
>  drivers/net/wireless/ath/ath12k/wmi.h  |  100 ++-
>  5 files changed, 1069 insertions(+), 222 deletions(-)
> 
> 
> base-commit: c256a94d1b1b15109740306f7f2a7c2173e12072


