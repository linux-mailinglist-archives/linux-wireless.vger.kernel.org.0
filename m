Return-Path: <linux-wireless+bounces-34202-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Gbe5N4VTy2l+GQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34202-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 06:54:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB28363F21
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 06:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B1DC300BCB2
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 04:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82F23469FA;
	Tue, 31 Mar 2026 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkfUh/1j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iy/XDhsu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A41345CDD
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774932863; cv=none; b=cuUBOEn/VXYTvXp5ceu9oOwvjj37v7HekFgF7F1npVqBbPV2QTZiAFMzGyGgoNxEUuRdWPXViFozkvDgTzV4s2dISohjgKlkmkZZ0Xx36o3kFkq2yIgyt8EsiAtZJjvXqVcuyTii/XLdLQqth/NyMqxVk7p3mK+vesmF5Y/QolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774932863; c=relaxed/simple;
	bh=0qugxe6tSxv0HAgo+2vtQ9x4rW1YvzNRnQyrLYH8rew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeKkWJeDxx/rY+b/9LrAqUF6MRgo2DQi9CCIoldHJ00K2hRvI57/1QmO4YkE8ea5avWBD/fU7NSzOfI9vD7mGZpVcA7Gn7ROV00Hz9YGmANiAO1Kp1ONrqHxQhdBlIq0+TgRn2J6NPcMK8QCRTw9PmcX9DRm3RogUzIEXD1R54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kkfUh/1j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iy/XDhsu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UL41af1841221
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 04:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ts8RTHXqc/NqG7zXquFLtRv6EI5Px79CzR6ZkrGYM/o=; b=kkfUh/1jSxklFtXH
	HSSFjBvjFOIw0khumfSoot2buUq196Vb7JDTWV9GKqAaO5uAgbAsd3U9spgpNkaM
	pDjjhjUHUOkBXkDxkbKkRSxKA0hnjUZQ2lFW9CDJGnuefov9yvES4sDoLSRcmWCa
	i1lUzxncna8ts2bzBf9YHmzXxpl1/JM3nySInod9ysezbyXaydibvC4usRoOJciy
	TfgeV0pP9J2hvFHR09YCek2Ss/e+8f2+v/TsZ6I3h2D65i77oKTJ6/sJfX9eFBR8
	8HMZfBxkim4cNCDf0A2ys9UQey5gzCTC1uLIepfHEMtsF2N1AppXMMLtXDSgHeda
	AxsvDQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80rsh9ff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 04:54:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c70d1f65aso3414813b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 21:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774932860; x=1775537660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ts8RTHXqc/NqG7zXquFLtRv6EI5Px79CzR6ZkrGYM/o=;
        b=Iy/XDhsuxmvdYp5XtMmy8A03ixY9fTDJ1H2QqhqZdIgoHhKeXORQHVxf2H9H3cp59d
         QKWEB833+Hrej/ZOdke5xoYWcN5e76BYcy7LExOaAqM8YLv4uMNTiBrMZOohhDmTkz/7
         panN/xnV3lopo2K8WIVpELyH4sfyeWgTzWNIJ4Sr237DxXobrOJbazCt07cFZ6rWRuGV
         GQPzKvDFZG9vVP4Ohz6mHxGkPon/omGke0l9HA6ZNoB6dnwkCQ6mJ+/qgaKpeXlIRpks
         vSkJqxICsPFLtVsRriIAVmQtKz6IzMIeSE5QBFJlsdGp1SZPuwmcYfH5k/S8gKxwNHG2
         foAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774932860; x=1775537660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ts8RTHXqc/NqG7zXquFLtRv6EI5Px79CzR6ZkrGYM/o=;
        b=qloJ9RZV/Od1uNW9s4ZY27mZamhN419ryckEkz54OFCJFYt9AXZOunZYI7slrYvDTd
         jpio8XZvl4FWRcRiG7ZqIRngKPQraq8gTntzonip6SFF4xuDJhLFoXXBEeZnh8OE3fdp
         uHh+DPsElba6PD3hbOcyihc75A4IFeewVj3ChRsbBJFklvZd9VOa+krK8uvL1431l3oy
         kDw+byU1j9C3D9v7R36uSCE49QBrsA6TAJX8nwyMplsCJZ13rdIon67fWjLTEfj8SX5a
         ZQ3w4dirB0IUX6hsWdh7ltImmrZxLZcILrw+IeJ+3yN80XbsOlSdYEbWBb07KV6ms46x
         FVKA==
X-Gm-Message-State: AOJu0YwH4LRiJoX9SJJQ183eal3My6UxYGMRBxIDOpXinV0CGum0itFM
	PvlPzOZQMKxY9+lgggbbrfKOb8X64QRUQn8vS71B2kb8+/Za5o+JOAkypZnROMM4PaeLs/VElZm
	a1bM1SAaguzHZxMcwoftl4rlzB1wdXjteG1D/aO6RQT/D4v0lH7OSrla3dG7X5DmuOTMGmg==
X-Gm-Gg: ATEYQzzpFSPGRVjSzWjudvIoJSh4iQHjAUyXpeWoV4g422Y578fhfz/TlRZwFvlssDy
	A2J8Zu231BSZ+SP/I2Cg1yetvxx04jZx/dGoz2Iq8bYDhtsuQB8F7E6ZTTwW373t8NMqV2kHjT2
	Q+wcebeIVla4xOK1tQZ8cuc6n/vfkcS832P0BxxdvkqGOM7aqGuJFkOpHlE+digF6dfTjSiQe6W
	RHbUWuLEuKtb0L0wxMn2BJiLyhg04hi528DequEB1P4hBpspoez5kjwlHrII+RZ2ofXilQnMYEk
	mdYh9WePyw1xrReXUScw/95iSHxofgzlV+mWa3iRn8zawnn8dZfiFhsfyeVLW7DcybbcqSz9WDB
	sLdTn3dH5SDFfS5yVrtljvXrALvnkhUjnsWuXYVP3sPtHSOsIKlX7ectZlwuX7g==
X-Received: by 2002:a05:6a00:b4d:b0:829:793f:da78 with SMTP id d2e1a72fcca58-82c960728c4mr14890418b3a.48.1774932860085;
        Mon, 30 Mar 2026 21:54:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:b4d:b0:829:793f:da78 with SMTP id d2e1a72fcca58-82c960728c4mr14890387b3a.48.1774932859553;
        Mon, 30 Mar 2026 21:54:19 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca847ff4dsm8959928b3a.23.2026.03.30.21.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 21:54:19 -0700 (PDT)
Message-ID: <1c4bbf63-0464-48a5-aade-81b0f7b412b4@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 10:24:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath10k: fix station lookup failure
 during disconnect
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        pmenzel@molgen.mpg.de
References: <20260325-ath10k-station-lookup-failure-v1-1-2e0c970f25d5@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260325-ath10k-station-lookup-failure-v1-1-2e0c970f25d5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: b939IPStZs2exM46WxTBC8zv1mWC2fiR
X-Authority-Analysis: v=2.4 cv=VInQXtPX c=1 sm=1 tr=0 ts=69cb537d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5JJ4Ai1OY_Bm05l3Z7AA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: b939IPStZs2exM46WxTBC8zv1mWC2fiR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA0NCBTYWx0ZWRfXycUZQvnAossv
 iV1ItlWtuA/B3ljprLg05/j+QIQb8YFRfifXIvpQZZjL7TnxRS2OgLlGBeZBt9e4O6VOJsNBZPB
 OM3bLCF4D9WKanOJzQVr+Mrr1avo09L6W3KJESyEYo5bfTiTQhIJJyyt0/JwbUtycBKdy9VBd58
 9JwdRUG/rorOWom4iNBCteDdFuaJlTQafojMsPGZIuUDtjfqMpfgJTjBbiOj1JUCbrmqKw94Mtw
 ZRW/cfcGcR9kQOzMg6kfWQ0snb933QvyOcWKXYtaAOOpXv4negwXy4r7MjdY43mTkZzG3CwP+gE
 I1eFrUrX6vvn+uBhh/AEfHHUPPknyTH0vRdUrVLaIdXrs2a8aBCnFL+e96VO8VVMqALHxvv/Dpf
 OL2jshqbftd7Zb4Awtxu+0azyaQm8m4+gIwK6QkVrXn6ML6rx+Ot0Nuzwwh5RoDHr/Fh8ZMyBLP
 jo5/GS1lnstVxsEZkPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310044
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34202-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CCB28363F21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/25/2026 8:35 AM, Baochen Qiang wrote:
> Recent commit [1] moved station statistics collection to an earlier stage
> of the disconnect flow. With this change in place, ath10k fails to resolve
> the station entry when handling a peer stats event triggered during
> disconnect, resulting in log messages such as:
> 
> wlp58s0: deauthenticating from 74:1a:e0:e7:b4:c8 by local choice (Reason: 3=DEAUTH_LEAVING)
> ath10k_pci 0000:3a:00.0: not found station for peer stats
> ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
> 
> The failure occurs because ath10k relies on ieee80211_find_sta_by_ifaddr()
> for station lookup. That function uses local->sta_hash, but by the time
> the peer stats request is triggered during disconnect, mac80211 has
> already removed the station from that hash table, leading to lookup
> failure.
> 
> Before commit [1], this issue was not visible because the transition from
> IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST prevented ath10k from sending
> a peer stats request at all: ath10k_mac_sta_get_peer_stats_info() would
> fail early to find the peer and skip requesting statistics.
> 
> Fix this by switching the lookup path to ath10k_peer_find(), which queries
> ath10k's internal peer table. At the point where the firmware emits the
> peer stats event, the peer entry is still present in the driver's list,
> ensuring lookup succeeds.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1
> 
> Fixes: a203dbeeca15 ("wifi: mac80211: collect station statistics earlier when disconnect") # [1]
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/ath10k/57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath10k/wmi-tlv.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> index ec8e91707f84..01f2d1fa9d7d 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> @@ -3,7 +3,7 @@
>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>    */
>   #include "core.h"
>   #include "debug.h"
> @@ -14,6 +14,7 @@
>   #include "wmi-tlv.h"
>   #include "p2p.h"
>   #include "testmode.h"
> +#include "txrx.h"
>   #include <linux/bitfield.h>
>   
>   /***************/
> @@ -224,8 +225,9 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar, u16 tag, u16
>   						const void *ptr, void *data)
>   {
>   	const struct wmi_tlv_peer_stats_info *stat = ptr;
> -	struct ieee80211_sta *sta;
> +	u32 vdev_id = *(u32 *)data;
>   	struct ath10k_sta *arsta;
> +	struct ath10k_peer *peer;
>   
>   	if (tag != WMI_TLV_TAG_STRUCT_PEER_STATS_INFO)
>   		return -EPROTO;
> @@ -241,20 +243,20 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar, u16 tag, u16
>   		   __le32_to_cpu(stat->last_tx_rate_code),
>   		   __le32_to_cpu(stat->last_tx_bitrate_kbps));
>   
> -	rcu_read_lock();
> -	sta = ieee80211_find_sta_by_ifaddr(ar->hw, stat->peer_macaddr.addr, NULL);
> -	if (!sta) {
> -		rcu_read_unlock();
> -		ath10k_warn(ar, "not found station for peer stats\n");
> +	guard(spinlock_bh)(&ar->data_lock);
> +
> +	peer = ath10k_peer_find(ar, vdev_id, stat->peer_macaddr.addr);
> +	if (!peer || !peer->sta) {
> +		ath10k_warn(ar, "not found %s with vdev id %u mac addr %pM for peer stats\n",
> +			    peer ? "sta" : "peer", vdev_id, stat->peer_macaddr.addr);
>   		return -EINVAL;
>   	}
>   
> -	arsta = (struct ath10k_sta *)sta->drv_priv;
> +	arsta = (struct ath10k_sta *)peer->sta->drv_priv;
>   	arsta->rx_rate_code = __le32_to_cpu(stat->last_rx_rate_code);
>   	arsta->rx_bitrate_kbps = __le32_to_cpu(stat->last_rx_bitrate_kbps);
>   	arsta->tx_rate_code = __le32_to_cpu(stat->last_tx_rate_code);
>   	arsta->tx_bitrate_kbps = __le32_to_cpu(stat->last_tx_bitrate_kbps);
> -	rcu_read_unlock();
>   
>   	return 0;
>   }
> @@ -266,6 +268,7 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
>   	const struct wmi_tlv_peer_stats_info_ev *ev;
>   	const void *data;
>   	u32 num_peer_stats;
> +	u32 vdev_id;
>   	int ret;
>   
>   	tb = ath10k_wmi_tlv_parse_alloc(ar, skb->data, skb->len, GFP_ATOMIC);
> @@ -284,15 +287,16 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
>   	}
>   
>   	num_peer_stats = __le32_to_cpu(ev->num_peers);
> +	vdev_id = __le32_to_cpu(ev->vdev_id);
>   
>   	ath10k_dbg(ar, ATH10K_DBG_WMI,
>   		   "wmi tlv peer stats info update peer vdev id %d peers %i more data %d\n",
> -		   __le32_to_cpu(ev->vdev_id),
> +		   vdev_id,
>   		   num_peer_stats,
>   		   __le32_to_cpu(ev->more_data));
>   
>   	ret = ath10k_wmi_tlv_iter(ar, data, ath10k_wmi_tlv_len(data),
> -				  ath10k_wmi_tlv_parse_peer_stats_info, NULL);
> +				  ath10k_wmi_tlv_parse_peer_stats_info, &vdev_id);
>   	if (ret)
>   		ath10k_warn(ar, "failed to parse stats info tlv: %d\n", ret);
>   
> 
> ---
> base-commit: 4242625f272974dd1947f73b10d884eab3b277cd
> change-id: 20260325-ath10k-station-lookup-failure-be4dd6e81100
> 
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

