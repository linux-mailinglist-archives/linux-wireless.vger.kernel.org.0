Return-Path: <linux-wireless+bounces-34483-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDMyE94u1WmU2AcAu9opvQ
	(envelope-from <linux-wireless+bounces-34483-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:20:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 964653B1BBA
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD993001CFA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DCA39479B;
	Tue,  7 Apr 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="evivHoFT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hpi3MY7e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B135BDBB
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578813; cv=none; b=tyA91zc38I8NO+vAA9hWjZn5iE4hyohrp3U8o4P2KnjH80CU7ztvaow57aamx2g6EfydJzH7azWKYf0kptPcddt5nW+cxML4AZo8vLmoLnxb7HBOns818ZnEGrVXkwBc0noeCKSwZ9zRO5QxZK5foBKqbYUjHSpaxLvTYvBefLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578813; c=relaxed/simple;
	bh=r4C9S0bv2445jogsNg3miUfs/j7bPhpTiPbkMRI3mEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9gpiCG8LPWrG+k3UqSI2Zzsx/gJD6gU36Y6C92yCRi8xZmz56Lc6+oGcoWAHCJtud8ly8fd01xOOWgP2uxGzi1tjKrgVhZT7sDx9+VbYN5asEbQJn+T4Kq+4EdeM6jH8p7Ft25L9Dpe+ReYFDqvBMNLhG/HBmBFv7+mwK+t59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=evivHoFT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hpi3MY7e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CwaZ3493201
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 16:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a0f18Oq9boIMyQuBhUbaPDsT2QYQ1+En6l/jUXzn0FQ=; b=evivHoFT6YT9TVN3
	lTe/Swb3WC14V3UYGg66kwDepgWHvO3tVlIY3Htc5IwzR6n54DHWx4WQBFejwnl/
	WoWc0oiSHb73jfF0lHtwp4l66gj9j9DEyz9YCn20srpm5OjhfwhwFGC8V57vhhrF
	a1ackd15Rlon4vz3QGh8bQRz3Kt7iIcPIqhXjJHtf2p4tiWs2Da2zD23f+5wqJ3r
	vrpOgTP+ysygkOD8812necAVGhDZ/6YjzYYk7ywZDv0Bas5wFucUkw3LFV3xFYM/
	XFYOP6E/9zm5TnPNiV0g+m9EnDtJ3LrqMOXTAY34D5D54AK+AeNIH0f8LO06CzU2
	QMvmJA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8uj0f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 16:20:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2454fc131so92659995ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775578811; x=1776183611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0f18Oq9boIMyQuBhUbaPDsT2QYQ1+En6l/jUXzn0FQ=;
        b=Hpi3MY7ezVWldAA+CmNkC1aWCEGA5ddJbES1Yxh71f5xsowpDGoytJnQHJwhs1R/fp
         UcDH2QbNcq7YXcTWZL4/5AQz/lLnsxgonYy0SJfhhgnAJ6DPOFQ82GRxgRoOM91GFKHm
         71WJ7FHIY6xu0eqkNh2sJx9viW/dIGf9QbZHD8qvGqY5SaE8Y2l8gndqdWXDzgNpcips
         bxR3jl6aRGimQMsMpwhZG9GFiYxQs96mwrkk6M5QZP9mVE1gaJmAk0Unecqq4faBqoRc
         YJHv9Ggz3BZ9K6Mi73mBc02keN5zL24xJi9rmWBbIglLfPj2IsNV/oM1OQYYayO1deHu
         mMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578811; x=1776183611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0f18Oq9boIMyQuBhUbaPDsT2QYQ1+En6l/jUXzn0FQ=;
        b=it8I21lNxIHM6o20nQrXtwbIWjUlO0ef+gdoNb1eQVLY6wfGzunDsVlD6RdFzUy722
         aAp1O4DUPFZDsdEqjmu3O0Tos6lfwyputjF7AES6NCyc/g6ucsqU0Y5O/41ZV4JwwHud
         J3Mnj2dvJQmg5d5oG6fEtA6VJoHceAIpL8n1UKv794VWRDnIbmqSD4sdMNsw5ZvwhGfj
         cCcuRDR34JT0iZv8D15HskgT5E2D6z+yjNIA3YS25sWscEwG8J+yYcWZQDv5vFWM2cji
         KKzUQYt03jMe7CpXKAAvKS9foZjSnBaaGuYNS3JhULQKqdJuBD/WgGWNJkq2UT0umSOG
         mNGQ==
X-Gm-Message-State: AOJu0Yx1G/t2if/l4vcijeSPfSy689COb4ut194Xgb0CjbDM8EtKFgda
	7xbbCJuJd9ggZENBKWQzt5M6yaNK03mUR2XSJEhUYoxr47dm22B+MgVhalIQwlPqs6hoJLfzJ2Z
	JipxdP0yTl2WiVnFte24MTO2aSNpoN2+XZA0XP408B3R/8dyLFRV/1LIPocsWrSYK4oyxCg==
X-Gm-Gg: AeBDieuO3oP30OhJlbHgFepXBpb2vgxkbCg8hmZs9nX8TBCpfwn2XsY1oHM401/QkR1
	0NKdVf19sUTXXf7EVy2rSDbQJnitKrICWdpbjdD5OivB6BaIPJGpxy01El08glgd1nUwKWbhsol
	2syT6k0X/xsztQphDZ6Kq9jMTJ7l8Kt2I3cW0sVqp/rfiCDddjdR0yVLbe/kgG2GpoXJmHneCh1
	3cIwCSK/hSxDSwUynWEwyOUmYMnWCBl6uujpEp/wYLs/2Dzdpw1YauG8QEzw7Kc8HCR9ZeKlPd0
	ojUCmIRRf4SmxHM6RKpVPF2/I7zoYnEhXKJxiWbk7Wyv4q5SNZIevPi7j6Dm2MzUiF6/W7kZU3H
	Djr6cE7UdUlQsRf0JMsnbomeGsU98Pbi4bAKPClP29JjSRZWeVdfKQBel3CKTMZ9PDQ==
X-Received: by 2002:a05:6a20:430a:b0:395:ccae:d494 with SMTP id adf61e73a8af0-39f2ee10e34mr19028500637.20.1775578810754;
        Tue, 07 Apr 2026 09:20:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:430a:b0:395:ccae:d494 with SMTP id adf61e73a8af0-39f2ee10e34mr19028445637.20.1775578810093;
        Tue, 07 Apr 2026 09:20:10 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65a3f08sm16286043a12.31.2026.04.07.09.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 09:20:08 -0700 (PDT)
Message-ID: <3496f9c2-fe73-4732-9ffb-513ea51928df@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 21:50:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5 2/6] wifi: ath12k: Add ath12k_hw_params for
 IPQ5424
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
 <20260407-ath12k-ipq5424-v5-2-8e96aa660ec4@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-2-8e96aa660ec4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RImy7dofrRSo6-zXGFazlq9X2RcO_8GM
X-Proofpoint-ORIG-GUID: RImy7dofrRSo6-zXGFazlq9X2RcO_8GM
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d52ebb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=RSpPW0pkKGs0CHY-rOEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0NyBTYWx0ZWRfX2/ArHZpxvgBN
 s7tvr9Ob36CKvKgeIrOSKCIRN2KY5dETFH6KLgdMamKJ7dxX24yQoFu/vMPIV6oPzZBqQOe1rle
 7mDjqqU8nIIjYmec7GCF2FETgEYwaV85Qc+p4L6rr6bcUnwAAHVYXeQxpUzdwoNR7EmEmLQFA/B
 6mwnTtr993qf4pzt2yJFfI9oZCQBPx7fF4qwxnGgUbIbkEJshmTer2hFogi8+JuW0VRQt7kmhZF
 yDk/ziETvwOjXiFby0QTi3s2MjYjoby9BPnjzfI9m1kCln6/z/x8oYB90pvrvWEchfUoNZjSAYN
 WaOLVcSrHGBKbKAdCmHmg2991EhRexXci05UK2CQFRf7bgdofVC5Vhr3GZsUtcbdOYcnpJ55bEp
 te9Q1Y3b7alvZRZL3r+ZKebrNfsvC/BqJIomC/mPnY3NE+2O7mbRfcL2/gK259/cE7YOS/4CBeY
 TZfaVKQ3Okt7iroUwSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070147
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34483-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 964653B1BBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 10:56 AM, Raj Kumar Bhagat wrote:
> From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> 
> Add ath12k_hw_params for the ath12k AHB-based WiFi 7 device IPQ5424.
> The WiFi device IPQ5424 is similar to IPQ5332. Most of the hardware
> parameters like hw_ops, wmi_init, ring_mask, etc., are the same between
> IPQ5424 and IPQ5332, hence use these same parameters for IPQ5424.
> Some parameters are specific to IPQ5424; initially set these to
> 0 or NULL, and populate them in subsequent patches.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h     |  1 +
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c | 79 ++++++++++++++++++++++++++++++
>   2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 59c193b24764..68453594eba8 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -157,6 +157,7 @@ enum ath12k_hw_rev {
>   	ATH12K_HW_WCN7850_HW20,
>   	ATH12K_HW_IPQ5332_HW10,
>   	ATH12K_HW_QCC2072_HW10,
> +	ATH12K_HW_IPQ5424_HW10,
>   };
>   
>   enum ath12k_firmware_mode {
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> index ec6dba96640b..2b5d1f7e9e04 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> @@ -753,6 +753,85 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
>   
>   		.dp_primary_link_only = false,
>   	},
> +	{
> +		.name = "ipq5424 hw1.0",
> +		.hw_rev = ATH12K_HW_IPQ5424_HW10,
> +		.fw = {
> +			.dir = "IPQ5424/hw1.0",
> +			.board_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
> +			.m3_loader = ath12k_m3_fw_loader_remoteproc,
> +			.download_aux_ucode = false,
> +		},
> +		.max_radios = 1,
> +		.single_pdev_only = false,
> +		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332,
> +		.internal_sleep_clock = false,
> +
> +		.hw_ops = &qcn9274_ops,
> +		.ring_mask = &ath12k_wifi7_hw_ring_mask_ipq5332,
> +
> +		.host_ce_config = ath12k_wifi7_host_ce_config_ipq5332,
> +		.ce_count = 12,
> +		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_ipq5332,
> +		.target_ce_count = 12,
> +		.svc_to_ce_map =
> +			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
> +		.svc_to_ce_map_len = 18,
> +
> +		.rxdma1_enable = true,
> +		.num_rxdma_per_pdev = 1,
> +		.num_rxdma_dst_ring = 0,
> +		.rx_mac_buf_ring = false,
> +		.vdev_start_delay = false,
> +
> +		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
> +				   BIT(NL80211_IFTYPE_AP) |
> +				   BIT(NL80211_IFTYPE_MESH_POINT),
> +		.supports_monitor = true,
> +
> +		.idle_ps = false,
> +		.download_calib = true,
> +		.supports_suspend = false,
> +		.tcl_ring_retry = true,
> +		.reoq_lut_support = false,
> +		.supports_shadow_regs = false,
> +
> +		.num_tcl_banks = 48,
> +		.max_tx_ring = 4,
> +
> +		.mhi_config = NULL,
> +
> +		.wmi_init = &ath12k_wifi7_wmi_init_qcn9274,
> +
> +		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
> +
> +		.rfkill_pin = 0,
> +		.rfkill_cfg = 0,
> +		.rfkill_on_level = 0,
> +
> +		.rddm_size = 0,
> +
> +		.def_num_link = 0,
> +		.max_mlo_peer = 256,
> +
> +		.otp_board_id_register = 0,
> +
> +		.supports_sta_ps = false,
> +
> +		.acpi_guid = NULL,
> +		.supports_dynamic_smps_6ghz = false,
> +		.iova_mask = 0,
> +		.supports_aspm = false,
> +
> +		.ce_ie_addr = NULL,
> +		.ce_remap = NULL,
> +		.bdf_addr_offset = 0x940000,
> +
> +		.current_cc_support = false,
> +
> +		.dp_primary_link_only = true,
> +	},
>   };
>   
>   /* Note: called under rcu_read_lock() */
> 

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>



