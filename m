Return-Path: <linux-wireless+bounces-34412-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJkQL6d41GlduQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34412-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:23:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E7D3A963A
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FBA930059B2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 03:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14013C8E8;
	Tue,  7 Apr 2026 03:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ffmNw9Vl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WW257mWV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5DDDA9
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532195; cv=none; b=PGxCYjYsPPZTZo0klLf9s/LJk/bsAHFt7YRFCgyNnd4LHJxgG+200FuTMC8nnL6RFUuT1MpxNH3c1XcVpe60GkJk/ET3R5DYhTstQoEx0ZKdTSANzdR1L/IwDAw3q2OAQeeCV70mxULqQet3QPquRKoFciCPfPz3iWpdIPd87is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532195; c=relaxed/simple;
	bh=YFsX+iwE702HOKlElF4TZ8DFCkldAz7wlNtIotTLTR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fwj5nG246CmXKgk+pqHI5NjYgMa4Mta+sF1Dl+8/uFQ0uwbIY3RJjdCr+i093jzaeUqU8RAldaIVH1Yozkcu313H0pJ/nfJCYBXYZPX2dW3A3WDpI4aDmUj9W+nK5k1c7Vx/R7gHSlDw5xwac8DxGpwMyuLGLe23ayHxQINx9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ffmNw9Vl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WW257mWV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQ9OS1404160
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 03:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5ZPIEdea3QaePrtU5LQ0oU/DerRtsXtjj2lfv6TYp9c=; b=ffmNw9Vlq5ZmLDyg
	C46K/ppTFLwFciBWmTMXqAl+9vkSeK00X1hgyo+j6biPaJHcZdSTY/C6H+4zvO6y
	2Fz/IOQvuQ2D5bG4PlVkdbG7oE5nbrRp253J4Ni5nxiJW2BQqrZ3r+MqGZlqmrVL
	wM3I/X4o9e2Qd7uR8L/4eqBIv5iol6KQ81GSDh+VTbMEFJeEjjYtC+K2l801HBY0
	Y9QsVezURzmyox1F/3oAU8ghDFFVs9kc+Js2NcaKfOOM7svkYnTD5gxe3htFmRUY
	jmKph/It35i3O6EMzHfffEu+jnCuizyHtH80BreiezqC/q1MwMC/FQ8ZeTjVCnDW
	0aExqg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr88ssy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 03:23:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso1747862a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 20:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775532192; x=1776136992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZPIEdea3QaePrtU5LQ0oU/DerRtsXtjj2lfv6TYp9c=;
        b=WW257mWVaL+hcCOiF8w6AaBe5RhR2bFBC2k9+zaJfQcZp5y/eRtv8bjxqUGz5R8DvB
         toU8BQW+86fEStkYadBnu4qJN7KfoHfCPvZdHPUEhIR7/CDzHYgFohjoyWrlZIUN9fIS
         MZJ+p/TbJFqu5NwgL5SyxcWlJYqOfPxoE+50GU538Lrd96dfgF7G99g9Y2+xu3oeUpgX
         ukPIYzC53RDgn6D8x+p4V2nGJKYQjugQP1avTQDz1cyG79cD6+RhyHRMAVUwmbRDEeL0
         ryNiU+QUW6PMFLsWvpPv6wTwEtZc9IwxxWhc9VbPOtzj24obFUA+l7Rd0iF060j+YHz/
         R6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775532192; x=1776136992;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZPIEdea3QaePrtU5LQ0oU/DerRtsXtjj2lfv6TYp9c=;
        b=DSvcRNkYsQoG/aPkcTsXeFQtj7ki1ui1LiKgAFMmSKh3GjvZVzaDny+xnt7JE5+FBk
         1KzK9RBkmBJ/I5if7653OfbYh83qi/xp+az/X0fL8pPOFYv+OYgn3IVcS7Ko3a8q44sH
         tiDo1uiaq0TtuFWQ7fUn/ALQjdTioLP5PcA2kK7uIMowAptIQwlHv96QSG6rdp0ysFRi
         1InUm8P65arm8esBSznRENooioB3Ui0QjSCMFE/YhQgYeVUnsTcl1vYGKxFxMydhf+HC
         FUpa2W6Khmyo3Ea25qs2puZi8zG7pOEoVtj6yapSIE1qgKDWJKmxRbCWKZPzNT451d7U
         fvbA==
X-Gm-Message-State: AOJu0YxqZ51NEb+5T4sTfKvBP3zOTG5k7vLUjrUuJXEovjG3mJ8ivD/L
	KoggjeaMxjdZjtB6LCl88CsqSqyGgwFc5ulCzRL5T7Sp3x6bfaOHNQnL2ktcFcTz8VdUC7RKCPj
	KaGqqlf5e/4lytfwgnj6zUqx0DER2kNQFS/U7dHU26Ywgq/9SNyu6k4yiqU9sOccgrdxaIkWqTR
	nuBjiD
X-Gm-Gg: AeBDieu+m1+ZLXcm14u3g8N7IzRJP09tavVRcgHIj0TvEMlu2F3662k117B8Q0e3bLs
	w9k/ObLIqYeZYrOlmUc0jXtFUt5n5bNSs7iI8cwPB3V3h4Ugm7DJHl+dM4pNzmK/ijYkA9bcNKB
	9/qDWq7UPmW91VBhgqwKLnnMiYnOtx/Tl7Gm2FlGnuyO1YiF4Hw+sdbUo73rjU/Ep5bg0oDnvMh
	mr8fQvQ8dpm3A973XSpOxmUfxxg3A69ZLuet2zA2c8LZsATf4Nt6SQUb5HZsrGOHrWHjcO/ME13
	sXhuGDZHS705ZPgK973zWWHADgbkzA3p78NPhyLWkQd1yc95aJCveslgDKukYawd5GPeskqRIRG
	5ZU/ZujlMVa6rEt1bd0f80CmnoWw142WEsePUlw6PwY4XqZ8U8/2tQdXgICIpJqWD6Te1SY+lWb
	uuWBxbmcQDuaJEeAjJPK0=
X-Received: by 2002:a05:6a20:3942:b0:39c:113:14a4 with SMTP id adf61e73a8af0-39f2f26892cmr14189467637.50.1775532191936;
        Mon, 06 Apr 2026 20:23:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:3942:b0:39c:113:14a4 with SMTP id adf61e73a8af0-39f2f26892cmr14189443637.50.1775532191375;
        Mon, 06 Apr 2026 20:23:11 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6562018sm14074850a12.18.2026.04.06.20.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 20:23:11 -0700 (PDT)
Message-ID: <63acfa83-753c-4b45-8f11-8e18e760cbf2@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:23:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Support channel change stats
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Harish Rachakonda <quic_rachakon@quicinc.com>
References: <20260326050641.3066562-1-roopni.devanathan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260326050641.3066562-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: z28G4eOHcliu2tXFOg61mZJk9vpnU0DX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyOSBTYWx0ZWRfX3RpSU6gXcEnu
 /OEPMhDEjFc1xf9+0XUsis204PUcbvQzs4sRnsoT6Wp8J3Juq81mhVWAedO+YH3vriEkCoIshB7
 28oy9+i+wbeuO3bwz152ubuLUA6nYBeVCQplHDxMvEPvcwHmdGDpYpT/4cckXK3shw7F5SpMPon
 RINadmE7nQUZjbbwClNoEmt+kfOVnVtesPvpBb8BpPZDEHUd097r4eH/qLkId7fPrCu2lVoepJU
 zAmj/J3s3L2fHHqJoN2UBG8zC6IUusqkp/4urn1nLvGJjkgBkY8M6KXUphJUYYNc6c5Uwm9wZda
 HxzHf5YegAols7YiDrsnm/apcH5VNyQz1CpOgqcim+4+iAV5VB6fAc6MwTthwzVYeK3uztoTJtq
 j7PgoIg0neYsvRT3urcwWC5XKzcnW+gBUzOW6+h8JFoDu3FDfoe9q6m4ktf0dpUdpGPoBESZlpA
 /+EUZVYlMX+5aM0nnPw==
X-Proofpoint-GUID: z28G4eOHcliu2tXFOg61mZJk9vpnU0DX
X-Authority-Analysis: v=2.4 cv=A/hc+aWG c=1 sm=1 tr=0 ts=69d478a1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ygHbHArRDiDl1jTHKCoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070029
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34412-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 52E7D3A963A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/26/2026 1:06 PM, Roopni Devanathan wrote:
> From: Harish Rachakonda <quic_rachakon@quicinc.com>
> 
> Add support to request channel change stats from the firmware through
> HTT stats type 76. These stats give channel switch details like the
> channel that the radio changed to, its center frequency, time taken
> for the switch, chainmask details, etc.
> 
> Sample output:
> echo 76 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> Channel Change Timings:
> |PRIMARY CHANNEL FREQ|BANDWIDTH CENTER FREQ|PHYMODE|TX_CHAINMASK|RX_CHAINMASK|SWITCH TIME(us)|INI(us)|TPC+CTL(us)|CAL(us)|MISC(us)|CTL(us)|SW PROFILE|
> |                5200|                 5200|     24|          15|          15|         448850|   2410|      10546| 434593|    1071|   1100|         4|
> |                5240|                 5240|     24|          15|          15|         450730|   4106|      10524| 434528|    1306|   1150|         4|
> |                5180|                 5210|     26|          15|          15|         467894|   4764|      10438| 451101|    1337|   1508|         4|
> |                5200|                 5200|      0|          15|          15|          13838|   2692|       1736|   8558|     686|    802|         6|
> |                5180|                 5180|      0|          15|          15|          13465|   3207|        855|   8579|     578|    760|         6|
> |                5200|                 5200|     24|          15|          15|         570321|   2441|      10439| 555661|    1574|    949|         4|
> 
> Note: WCN7850 firmware does not support HTT stats type 76.

this note also applies to QCC2072.

> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harish Rachakonda <quic_rachakon@quicinc.com>
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
> ---
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 72 +++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 26 +++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 7f6ca07fb335..b772181a496e 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -5722,6 +5722,75 @@ ath12k_htt_print_tx_hwq_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
>  	stats_req->buf_len = len;
>  }
>  
> +static void
> +ath12k_htt_print_chan_switch_stats_tlv(const void *tag_buf, u16 tag_len,
> +				       struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_chan_switch_stats_tlv *sbuf = tag_buf;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	u32 switch_freq, switch_profile;
> +	u32 len = stats_req->buf_len;
> +	u8 *buf = stats_req->buf;
> +	u8 i;
> +
> +	if (tag_len < sizeof(*sbuf))
> +		return;
> +
> +	i = min(le32_to_cpu(sbuf->switch_count), ATH12K_HTT_CHAN_SWITCH_STATS_BUF_LEN);
> +	if (!i)
> +		return;
> +
> +	len += scnprintf(buf + len, buf_len - len, "Channel Change Timings:\n");
> +	len += scnprintf(buf + len, buf_len - len,
> +			 "|%-20s|%-21s|%-7s|%-12s|%-12s|%-15s|",
> +			 "PRIMARY CHANNEL FREQ", "BANDWIDTH CENTER FREQ", "PHYMODE",
> +			 "TX_CHAINMASK", "RX_CHAINMASK", "SWITCH TIME(us)");
> +	len += scnprintf(buf + len, buf_len - len,
> +			 "%-7s|%-11s|%-7s|%-8s|%-7s|%-10s|\n",
> +			 "INI(us)", "TPC+CTL(us)", "CAL(us)", "MISC(us)", "CTL(us)",
> +			 "SW PROFILE");
> +
> +	/*
> +	 * sbuf->switch_count has the number of successful channel changes. The firmware
> +	 * sends the record of channel change in such a way that sbuf->chan_stats[0] will
> +	 * point to the channel change that occurred first and the recent channel change
> +	 * records will be stored in sbuf->chan_stats[9]. As and when new channel change
> +	 * occurs, sbuf->chan_stats[0] will be replaced by records from the next index,
> +	 * sbuf->chan_stats[1]. While printing the records, reverse chronological order
> +	 * is followed, i.e., the most recent channel change records are printed first
> +	 * and the oldest one, last.
> +	 */
> +	while (i--) {
> +		switch_freq = le32_to_cpu(sbuf->chan_stats[i].chan_switch_freq);
> +		switch_profile = le32_to_cpu(sbuf->chan_stats[i].chan_switch_profile);
> +
> +		len += scnprintf(buf + len, buf_len - len,
> +				 "|%20u|%21u|%7u|%12u|%12u|%15u|",
> +				 u32_get_bits(switch_freq,
> +					      ATH12K_HTT_STATS_CHAN_SWITCH_BW_MHZ),
> +				 u32_get_bits(switch_freq,
> +					      ATH12K_HTT_STATS_CHAN_SWITCH_BAND_FREQ),
> +				 u32_get_bits(switch_profile,
> +					      ATH12K_HTT_STATS_CHAN_SWITCH_PHY_MODE),
> +				 u32_get_bits(switch_profile,
> +					      ATH12K_HTT_STATS_CHAN_SWITCH_TX_CHAINMASK),
> +				 u32_get_bits(switch_profile,
> +					      ATH12K_HTT_STATS_CHAN_SWITCH_RX_CHAINMASK),
> +				 le32_to_cpu(sbuf->chan_stats[i].chan_switch_time));
> +		len += scnprintf(buf + len, buf_len - len,
> +				 "%7u|%11u|%7u|%8u|%7u|%10u|\n",
> +				 le32_to_cpu(sbuf->chan_stats[i].ini_module_time),
> +				 le32_to_cpu(sbuf->chan_stats[i].tpc_module_time),
> +				 le32_to_cpu(sbuf->chan_stats[i].cal_module_time),
> +				 le32_to_cpu(sbuf->chan_stats[i].misc_module_time),
> +				 le32_to_cpu(sbuf->chan_stats[i].ctl_module_time),
> +				 u32_get_bits(switch_profile,
> +					      ATH12K_HTT_STATS_CHAN_SWITCH_SW_PROFILE));
> +	}
> +
> +	stats_req->buf_len = len;
> +}
> +
>  static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
>  					  u16 tag, u16 len, const void *tag_buf,
>  					  void *user_data)
> @@ -6024,6 +6093,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
>  	case HTT_STATS_TX_HWQ_CMN_TAG:
>  		ath12k_htt_print_tx_hwq_stats_cmn_tlv(tag_buf, len, stats_req);
>  		break;
> +	case HTT_STATS_CHAN_SWITCH_STATS_TAG:
> +		ath12k_htt_print_chan_switch_stats_tlv(tag_buf, len, stats_req);
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> index bfabe6500d44..82ab7b9e4db9 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> @@ -164,6 +164,7 @@ enum ath12k_dbg_htt_ext_stats_type {
>  	ATH12K_DBG_HTT_PDEV_MLO_IPC_STATS			= 64,
>  	ATH12K_DBG_HTT_EXT_PDEV_RTT_RESP_STATS			= 65,
>  	ATH12K_DBG_HTT_EXT_PDEV_RTT_INITIATOR_STATS		= 66,
> +	ATH12K_DBG_HTT_EXT_CHAN_SWITCH_STATS			= 76,
>  
>  	/* keep this last */
>  	ATH12K_DBG_HTT_NUM_EXT_STATS,
> @@ -267,6 +268,7 @@ enum ath12k_dbg_htt_tlv_tag {
>  	HTT_STATS_PDEV_RTT_HW_STATS_TAG			= 196,
>  	HTT_STATS_PDEV_RTT_TBR_SELFGEN_QUEUED_STATS_TAG	= 197,
>  	HTT_STATS_PDEV_RTT_TBR_CMD_RESULT_STATS_TAG	= 198,
> +	HTT_STATS_CHAN_SWITCH_STATS_TAG			= 213,
>  
>  	HTT_STATS_MAX_TAG,
>  };
> @@ -2156,4 +2158,28 @@ struct htt_tx_hwq_stats_cmn_tlv {
>  	__le32 txq_timeout;
>  } __packed;
>  
> +#define ATH12K_HTT_CHAN_SWITCH_STATS_BUF_LEN	10
> +
> +#define ATH12K_HTT_STATS_CHAN_SWITCH_BW_MHZ		GENMASK(15, 0)
> +#define ATH12K_HTT_STATS_CHAN_SWITCH_BAND_FREQ		GENMASK(31, 16)
> +#define ATH12K_HTT_STATS_CHAN_SWITCH_PHY_MODE		GENMASK(7, 0)
> +#define ATH12K_HTT_STATS_CHAN_SWITCH_TX_CHAINMASK	GENMASK(15, 8)
> +#define ATH12K_HTT_STATS_CHAN_SWITCH_RX_CHAINMASK	GENMASK(23, 16)
> +#define ATH12K_HTT_STATS_CHAN_SWITCH_SW_PROFILE		GENMASK(31, 24)
> +
> +struct ath12k_htt_chan_switch_stats_tlv {
> +	struct {
> +		__le32 chan_switch_freq;
> +		__le32 chan_switch_profile;
> +		__le32 chan_switch_time;
> +		__le32 cal_module_time;
> +		__le32 ini_module_time;
> +		__le32 tpc_module_time;
> +		__le32 misc_module_time;
> +		__le32 ctl_module_time;
> +		__le32 reserved;
> +	} chan_stats[ATH12K_HTT_CHAN_SWITCH_STATS_BUF_LEN];
> +	__le32 switch_count; /* shows how many channel changes have occurred */
> +} __packed;
> +
>  #endif
> 
> base-commit: 37538641dac955f6690372f0ebb94e5e14a23418

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


