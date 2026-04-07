Return-Path: <linux-wireless+bounces-34453-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIiUEe7L1GmtxgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34453-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 11:18:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B633ABD67
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 11:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D8353001BE7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEE339934E;
	Tue,  7 Apr 2026 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pCNaob2X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jaAzu77x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB739C011
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553515; cv=none; b=Z3SPyc9xQeC3U5E5F4tTtZLcL0ymNxjBqWdKFXXOOy3Y5jOLlnSJRtN+fnqp42b+fq1XKyKpE6BLSiaa2s6Bn7zyvznemSbiW9YV8ZmFcGRwC3SJBhEyCV7F9QWP8TMEc1OynZT5D6XWH6rmgKbbn9vjxjJ/NB/3gtst3hpUijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553515; c=relaxed/simple;
	bh=OHg1qc0lU+UpwiawoPFl1IVt5fYWlOfLIIEHaxwrUzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crwd0F+i9LWS0k1iX+RTzYfCw+TE8LRf7n7EGVHBRhXoI0xh1r4Yq457YjWFnGX6s9TqD7aizSV/kHJbftXVOBVj8ZhiYboTwk/HWQsG1zuKOwHjEIW/LdUJhuWxzGYkJcgK8GGOFr7A/NwAVEm94lWJJDThK9akP4vieXYsGIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pCNaob2X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jaAzu77x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376xXaa4008693
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 09:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FlMN1zYTip17TcOkPr1kOdTAgk+GGVLiyPaqUC8VoaM=; b=pCNaob2X2tCsBeL4
	mtPpqdTVqd71K8h+1S86I0JEo876TW20yPfcXBm0p0I6qleAKbxVABAp85W1pC+f
	iITHthTLBiPlvZ3j47zWCpXra+FyGdKUJg9WwSvqmAslKn8Yu8dY9Z8fB5FgdRo4
	FlYQh34H3bxMP7jF/ddNIQ3WJpGoBVwTItFCS6rSX3cNQB9hoFZLe9Q2hNvqr9B+
	P5p5N22gQ5aeAH6cWVbNPxZHtRnwhlR0pSSr3x2xLVSh3wRIu+Z4BWeZCoJh5CYa
	A+xPKa40sxgnZMsFali2atI7cTYUK1dQ48Rc3vYvECALd3BgcVPADhN/j5zBWIMu
	C4nfJg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrksyfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 09:18:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82a88a2704fso2418169b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775553511; x=1776158311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlMN1zYTip17TcOkPr1kOdTAgk+GGVLiyPaqUC8VoaM=;
        b=jaAzu77xzmtKRXiNlWmmQDGMr+8QJkLcTmonjr85XiCv7DENEDcRBuw/Nm7EHTq+9n
         pOVqGQyJcqdK+zF7e3llbVELd+IpOM7YDXbUGqKLHqgd3CPBqrgVeqEW5RLdwctqSPd5
         ziXjEfhedYrAoBY6OQV6jSQ0BzKYWLu9mhlq0Iks7puUd1FxcATwc06j+a7eRxTgIdJT
         ZIa7nHo4UGGSPfgc1fjPW912MMWCfAu2zkganWVPO/8mc+gS5einHBLpGKypaDHvmZNA
         xf9it5iqiOuaQAy+CvUji0eAStTJYeUBniNMHBw0et5njqGwKJxrhfh9nJsZCVZ1KsDU
         diMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553511; x=1776158311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlMN1zYTip17TcOkPr1kOdTAgk+GGVLiyPaqUC8VoaM=;
        b=BBvDbmsmj2kiD47XRj80ogQHp+DmOBKe/7HqCdrEuZoxQdSHb6DADR3aV2Otf2KcUQ
         WJV92kkI9pQK5dDuodp4BKPhWDb+mquNj4Xq1TlQMBhcxcobwowl8ob6WO6ai2P6NbU9
         H94d0lN6FqbftKcxXdP+awLECLu1/XblZwjJJHJiYWfHUio1M6Thl97VCKTvr48VZu69
         PQ3RqYKFGgdXk67dWDG2nKxD1pOFfNE2Lr3ovwGNOD0RnuU21ypbMjMjvlF5VUVzY+IU
         eZr+rhUnMV73j8MqdvLMq+daLpsL2O17MaBAB1kF8j8L5czZ674XJlV8lHgnxtm4LQpk
         ePkw==
X-Gm-Message-State: AOJu0Yyt6xTY+1wngsH7bBs4iCZp2P//zjRQXTpHigl08Mzp3jPAjiaJ
	07QMLY9cCdKvmNUDG5uh7MrsQ9POJyhgwjk0PvVnM9o9CJTENH34CxFP/UdpeGQeMzlIDfEwHGB
	3TOmEAuj4lKCYbDVnNtZkrMMNWMtYouNpdXDWaFJhONy/H83VXP8Ehe3SWSWeYn5xdoeCvA==
X-Gm-Gg: AeBDieuAyYsPG+EJATsUFWd0aFKjM8TOzF4+UgF5ygFiMSOrq3yHPTQOW4qfkNPDm0m
	fQWMqSVA9Miy2qlBDZCz98jVeic6OMefL8Yjctt0oNpkaJ3DYuxRjrq1B80HQMdNl9xj+mTYuc5
	rrJJ+E0HG3H5MAzsD/rfXpLXhIXQ6eXsztw1Q127f6Bb0fyiK2v77RSfrcK3RwuGKcAFY5E/JAv
	EvF/vU3nctM4xsZHX4Q4+vFcx9ZWeT3JrfJ7vs0KpeyRJuFRz4fCiwOIJzOdbzZRHquFMN7BIX8
	pjvfuff9gierEVwibVbWGTeyvqTTHR82jtD6mHo2gzXS7hD86c4mOUrOst1y/etnRbfF9hJBu7B
	MWlZHPGay/3iX73uoAdI9ZiYqonvb7h26oBSPSs4cuoxfZuMP3cdr94+yBouljA==
X-Received: by 2002:a05:6a00:2790:b0:82c:20c2:81d4 with SMTP id d2e1a72fcca58-82d003ab2fdmr15556779b3a.30.1775553510941;
        Tue, 07 Apr 2026 02:18:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:2790:b0:82c:20c2:81d4 with SMTP id d2e1a72fcca58-82d003ab2fdmr15556753b3a.30.1775553510287;
        Tue, 07 Apr 2026 02:18:30 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm17566518b3a.38.2026.04.07.02.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 02:18:29 -0700 (PDT)
Message-ID: <a5d079c9-e60e-4bc7-82c1-c62d1001d476@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 14:48:26 +0530
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
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260326050641.3066562-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Rrz16imK c=1 sm=1 tr=0 ts=69d4cbe8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ygHbHArRDiDl1jTHKCoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WXh41_lk23nxYAlnGnThC7lwie9PB3nf
X-Proofpoint-GUID: WXh41_lk23nxYAlnGnThC7lwie9PB3nf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4NSBTYWx0ZWRfX3kdwyCbdcI5s
 TeTVZxgtIK2Yb1dF8Iqh6G9Etf1Wyvif1l43UtO9k78c0/d4opAUeeuNv7jQkRLajnlhs/P/3ET
 97JyukcU8yyGlEksKt81guDzq5gy1Rr4Jv4bdTzhhLvbV+qajC7mtXjBlT86HXCcd6ijefBxWVo
 UYBGVD1JOE6/SuG4if7gWhX9Rxw/3jBFWjGKYOeEuNsLcvqN1NZKaUKPIjLvZUPvHje3x8EuhFC
 BpNcdpMPdRnZkBorlUdqKkfKJNQSe2Ja+L6I0qKBVnKINWCn6XpCuDJvr7wKPbnEZ7VKjqX/F14
 ptjKXICXO3DoYZzbJGhfaqLgJf1QqSM46k2LED/Mivqy6qdoesnddbL7WTbaoy0L3xZZS9i8HCb
 nZFC/IZA4Baj8hi3mt0G5bepHJw3a/b8opmOj3hy/CrZDBnL4qgFXAfqrqWqe2csd7eJcV/deKU
 5/CJu11hbDwa1pSmDbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070085
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34453-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quicinc.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B0B633ABD67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/26/2026 10:36 AM, Roopni Devanathan wrote:
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
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harish Rachakonda <quic_rachakon@quicinc.com>
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
> ---
>   .../wireless/ath/ath12k/debugfs_htt_stats.c   | 72 +++++++++++++++++++
>   .../wireless/ath/ath12k/debugfs_htt_stats.h   | 26 +++++++
>   2 files changed, 98 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 7f6ca07fb335..b772181a496e 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -5722,6 +5722,75 @@ ath12k_htt_print_tx_hwq_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
>   	stats_req->buf_len = len;
>   }
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
>   static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
>   					  u16 tag, u16 len, const void *tag_buf,
>   					  void *user_data)
> @@ -6024,6 +6093,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
>   	case HTT_STATS_TX_HWQ_CMN_TAG:
>   		ath12k_htt_print_tx_hwq_stats_cmn_tlv(tag_buf, len, stats_req);
>   		break;
> +	case HTT_STATS_CHAN_SWITCH_STATS_TAG:
> +		ath12k_htt_print_chan_switch_stats_tlv(tag_buf, len, stats_req);
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> index bfabe6500d44..82ab7b9e4db9 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> @@ -164,6 +164,7 @@ enum ath12k_dbg_htt_ext_stats_type {
>   	ATH12K_DBG_HTT_PDEV_MLO_IPC_STATS			= 64,
>   	ATH12K_DBG_HTT_EXT_PDEV_RTT_RESP_STATS			= 65,
>   	ATH12K_DBG_HTT_EXT_PDEV_RTT_INITIATOR_STATS		= 66,
> +	ATH12K_DBG_HTT_EXT_CHAN_SWITCH_STATS			= 76,
>   
>   	/* keep this last */
>   	ATH12K_DBG_HTT_NUM_EXT_STATS,
> @@ -267,6 +268,7 @@ enum ath12k_dbg_htt_tlv_tag {
>   	HTT_STATS_PDEV_RTT_HW_STATS_TAG			= 196,
>   	HTT_STATS_PDEV_RTT_TBR_SELFGEN_QUEUED_STATS_TAG	= 197,
>   	HTT_STATS_PDEV_RTT_TBR_CMD_RESULT_STATS_TAG	= 198,
> +	HTT_STATS_CHAN_SWITCH_STATS_TAG			= 213,
>   
>   	HTT_STATS_MAX_TAG,
>   };
> @@ -2156,4 +2158,28 @@ struct htt_tx_hwq_stats_cmn_tlv {
>   	__le32 txq_timeout;
>   } __packed;
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
>   #endif
> 
> base-commit: 37538641dac955f6690372f0ebb94e5e14a23418

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>



