Return-Path: <linux-wireless+bounces-34420-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAJtDj6D1GmVugcAu9opvQ
	(envelope-from <linux-wireless+bounces-34420-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 06:08:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 886323A9A0C
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 06:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3607B300D44C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 04:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED37377579;
	Tue,  7 Apr 2026 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NMVrl8Ag";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EFa2i5LW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FED35DA47
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534822; cv=none; b=e953VqtDITVd0HQGhjnGbd1Ho7UpvfUcLCcbdfVzV2Kbs1t6ybZCedcyJImEe1g5/YBWxaDc2vfV2o4+hmJYLS09Pd5nc6ypa3659ocHes8qWBT73y7O5DzWTfS2voNqnfFDspvH4GmjeCHCcUtvvCrhI4lw84eGiDQMI1mpbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534822; c=relaxed/simple;
	bh=/hfGQbtesKRC3lit+F91bIJfGvVZA63Gc2j//SRpkW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRpPKEyBSpB0sppY4SO0jk8y6yseqZMSaNEO6mui/uP1IXjBPx2nyI7LLE2gvco7lSI4322tKpGxX/d0HZdmdSE/X1WmLezDN81Yn12/6b73CFVRX8+dRd/EuXlDb0nsa81damdpy13aVJ8JJuYSuJmWgnc/JGYt8vuM3wf5Rpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NMVrl8Ag; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EFa2i5LW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQKY12549972
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 04:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5OG6lICsmuX05QyL4RIPqB/8SW9MLBfBau3CiAnvoY=; b=NMVrl8AgoCNV5rTW
	sHdkBslP0f3lNzkrbFcRcpeTpcg51I5aBbQbtnWuMj4nIJfi2jifSFja+qHxgOaW
	DHIuZsIbsu8ARY7snOG2xGXGer2xWLbI89K+aU0krpy935k0ToEWDGCNGC+iNZEv
	1T92hZhmFJMz7NAu4fEwFdgJCfh774IVxAKBfhpsG3Vb4q9fPRGO3eWSe9ZazTsr
	kzbNIKhnFtY/CJejE/SoPCOrvKIieyUrEYIAVCbm2m2gkRGoxlAucz/X6++o9D3o
	ddt9HWnWQn8KBGkVVwblaVgkqJ74qzT354G+9q/WikrrHakHvKBZ0hJbguLGKXxk
	bEvJJA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmre8xgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 04:07:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82a77f807e4so5895541b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 21:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775534819; x=1776139619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5OG6lICsmuX05QyL4RIPqB/8SW9MLBfBau3CiAnvoY=;
        b=EFa2i5LWdiAIwbOHTo2QAV2BjMrRvmXnl2NCl50u1pZIp9bnUw+xxoQA9/OjPTSQft
         fyXStl2+F5zVFHCc/FKc2L+vy0FqTb/B+vLgewE49E579pNluwad4TbdaQyzcCZgD+Gk
         brVgeamTywC0MbdCjmrdI7LeiDW095PUGhWo1suhb9Jr2AaGHjnZA3fakxDBOW87P7Ab
         IPQlH1ypr33ADK4AAPvm2UuPp25kzDZlWQWt9tHJeHXmJBQkWnK7oqnt8GC/PJKAtFyb
         O1wF9wQSKoXAgMRwY5CiflYMy0wYG5O3xHC0/iwxQuD4TK24PEc3EXIDwq2dMXhdJpUs
         9a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775534819; x=1776139619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5OG6lICsmuX05QyL4RIPqB/8SW9MLBfBau3CiAnvoY=;
        b=OOyw2WYSd+FkaFil73NaMs4Y2vtQ0OXXsp3bL9XebSJ35z/jUl9s6u0IYqvXJBhB7Y
         o4n4SOsmVwHr9PXUtEjhPyH6m7jSqUany30JduMhMJCLRAvOunKJ+txxHerKosboWhxa
         SyjLgkXxOQR1OPX88ik9WKxbtqfIYOf8iW9kxPJtWuFtZROPfP7e6ljeejuxt/AY2qz/
         tHyglcfIf51h6rxw9A9rQuRGtQmSTBlHcrmGtFsGff6E2qTtLzQyLjW01g+4E1FwfFon
         +9HIQM8cFETjrmZWBtQwe1ou0m4uGh597PkYLI4HZ1mjggQ4qZljyjFwzne2IGQm8Z45
         +SgQ==
X-Gm-Message-State: AOJu0YyMRJQUcvUDaRad6jyYKlc/pW6g8CDm+blItn5L33ui47cYZQRK
	el2ARU2QaWWWamA1RGMVtegS/FE8iz6bZQ5T723sTkaIqr9MMEacRo6EDnc0I2aXqMS+/ecRwBt
	FGLdHxo30lgpugREzNG61uBqrxKE28ABTty9J0XcANVYUjIK4YjTetVKSS14truWOmP7kUw==
X-Gm-Gg: AeBDieulJJYFRqHrmVxqDBvTvJ0QlNczk/i89r7sqP3CwRenpWopmsItXxWmgyHCsjV
	p+DFupA6m8Phw6xodMk6N5WyY4c/1YovykBSuMEkGi9RpeyhqhMcP2S7M9bYpoJ5w5VpFSmkqe0
	fDPiipbWjaiEn06ql6PeQmeCDXxpfQvmnfj46bdnPPLCRqnIV5uTKr9fljb3JhvvtiSrbA3dQc6
	8Wy9WHzdvyUu3N97L+z8UbobxBJ8CoA7TNcA8AMW+tU1LdwYaVVI4varbPVNmQTCdr5cpDM2mtc
	GNmLQ/CWRPMTEbIOPxWYIffR2mt05GscuMxzln/nK1R94IOZYqWhGG/IexcNzOHXeGBUqr7SkFr
	aZGAHUsLAH7itMp5q2/PzFdIFXl4MyOCmzHzXQBc8bQPbHApgtw==
X-Received: by 2002:a05:6a00:298e:b0:82c:e601:3601 with SMTP id d2e1a72fcca58-82d0db8f8dcmr15118562b3a.42.1775534819427;
        Mon, 06 Apr 2026 21:06:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:298e:b0:82c:e601:3601 with SMTP id d2e1a72fcca58-82d0db8f8dcmr15118528b3a.42.1775534818855;
        Mon, 06 Apr 2026 21:06:58 -0700 (PDT)
Received: from [10.152.196.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cfebe5b23sm15802821b3a.59.2026.04.06.21.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 21:06:58 -0700 (PDT)
Message-ID: <ae47256c-053f-474f-b799-24274c68dfd5@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 09:36:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4 2/6] wifi: ath12k: Add ath12k_hw_params for
 IPQ5424
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>
References: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
 <20260402-ath12k-ipq5424-v4-2-cd1e0f0a6c88@oss.qualcomm.com>
 <5fff7189-fee7-4d73-a9a1-728389900678@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
In-Reply-To: <5fff7189-fee7-4d73-a9a1-728389900678@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d482e4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=tZNLRw8BZbjVNQK_SNEA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 9rqcs1LkHBZ4HqpDGhrwC1LKY9aHYQbI
X-Proofpoint-ORIG-GUID: 9rqcs1LkHBZ4HqpDGhrwC1LKY9aHYQbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAzNiBTYWx0ZWRfX2FOkdd59ufmy
 pRaRsOQlx6/3ZJbhGWxTgIG6N0r+hQPk2gXZ4WKPTQpuazR5TVKu3+BHZWqRGIW+ZL67TymdCjs
 1zw0bwkFzV9B6byik3Jry9E3oXqS0hIzTlrQl1xksoKGXdY1WQ/nuSGgVI/VRoRnSaoeVDA3DoQ
 uisE+3pFOpZaqfBUEYUvv+oiA0Oj+oh39C6RhXLYmfisw+HCcQ+llbKfbNYEHOdiC4uGsfBroof
 MWFLlVVFrvf+QlSePFi84mZPTdk9haB9DwKItlyy4JYX+jRK8bAV/Qs5D9rXU2yMyHi6ooG5cOg
 Q02CYqBFNIfTkfpYMdrsaPm41Y7iPYuijrbqal83Rk9eDPSeZQLwmLefk4WPSvsHcLtEDJ99yNh
 A4BlKzX3QBqKYFtcqn6lEooEHoe/kUp9mlwjphg+IS/4xjAyAQxhdf/t7StZE9Z12p7A2vWWtUZ
 5/7CJGNdSNcP6BWrCcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070036
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34420-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 886323A9A0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03-04-2026 14:31, Baochen Qiang wrote:
>> +	{
>> +		.name = "ipq5424 hw1.0",
>> +		.hw_rev = ATH12K_HW_IPQ5424_HW10,
>> +		.fw = {
>> +			.dir = "IPQ5424/hw1.0",
>> +			.board_size = 256 * 1024,
>> +			.cal_offset = 128 * 1024,
>> +			.m3_loader = ath12k_m3_fw_loader_remoteproc,
>> +			.download_aux_ucode = false,
>> +		},
>> +		.max_radios = 1,
>> +		.single_pdev_only = false,
>> +		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332,
>> +		.internal_sleep_clock = false,
>> +
>> +		.hw_ops = &qcn9274_ops,
>> +		.ring_mask = &ath12k_wifi7_hw_ring_mask_ipq5332,
>> +
>> +		.host_ce_config = ath12k_wifi7_host_ce_config_ipq5332,
>> +		.ce_count = 12,
>> +		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_ipq5332,
>> +		.target_ce_count = 12,
>> +		.svc_to_ce_map =
>> +			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
>> +		.svc_to_ce_map_len = 18,
>> +
>> +		.rxdma1_enable = true,
>> +		.num_rxdma_per_pdev = 1,
>> +		.num_rxdma_dst_ring = 0,
>> +		.rx_mac_buf_ring = false,
>> +		.vdev_start_delay = false,
>> +
>> +		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>> +				   BIT(NL80211_IFTYPE_AP) |
>> +				   BIT(NL80211_IFTYPE_MESH_POINT),
>> +		.supports_monitor = true,
>> +
>> +		.idle_ps = false,
>> +		.download_calib = true,
>> +		.supports_suspend = false,
>> +		.tcl_ring_retry = true,
>> +		.reoq_lut_support = false,
>> +		.supports_shadow_regs = false,
>> +
>> +		.num_tcl_banks = 48,
>> +		.max_tx_ring = 4,
>> +
>> +		.wmi_init = &ath12k_wifi7_wmi_init_qcn9274,
>> +
>> +		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
>> +
>> +		.rfkill_pin = 0,
>> +		.rfkill_cfg = 0,
>> +		.rfkill_on_level = 0,
>> +
>> +		.rddm_size = 0,
>> +
>> +		.def_num_link = 0,
>> +		.max_mlo_peer = 256,
>> +
>> +		.otp_board_id_register = 0,
>> +
>> +		.supports_sta_ps = false,
>> +
>> +		.acpi_guid = NULL,
>> +		.supports_dynamic_smps_6ghz = false,
>> +		.iova_mask = 0,
>> +		.supports_aspm = false,
>> +
>> +		.ce_ie_addr = NULL,
>> +		.ce_remap = NULL,
>> +		.bdf_addr_offset = 0x940000,
>> +
>> +		.dp_primary_link_only = true,
>> +	},
>>   };
> mhi_config and current_cc_support are missing, please explicitly set them.

Sure will update in next version.

