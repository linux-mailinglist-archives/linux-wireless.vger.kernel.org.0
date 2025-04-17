Return-Path: <linux-wireless+bounces-21613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D37CA91260
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76F74431E7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA027E1;
	Thu, 17 Apr 2025 04:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XhUsGYpj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D901C8628
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865382; cv=none; b=ZCDW9YlU0aUAp1lsr81oJJNrtweX91VLPNX/hpMzMRNMTta4aDS18dXHpI69LuJTp5asIOMr7f/tuWCgVoYShHGgA18WO26sGMluhjHoh1512SFEHudUbG3B2oYR/98Wtu2IILbCPo54HQKVfZz/CzMP6klY+0O2XOMPWFTQGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865382; c=relaxed/simple;
	bh=lXtzV4n0p+xSdLMmQT11N5+0BlWO5FhXAcjQg+682x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAfIb3CyqnkJd3H/FhnNuBFMAPuos3d2iBCjzVIYBCbu2i8dvX83pWWpEx8sXdXdsTjWh93pgcK9fNhxzNa1ognjFla6RyL9ZwshteW2mdKV3GxEUcPjLaP6YSrClweUcHGv/AjGumvPqSImcIBe0VoTySgGDHG8yTZo5Vnm1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XhUsGYpj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GMI3mf007047
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/3EKP6uAXQ9ad1MBBIQlu3ccbBQuP26LuQ6x9C0Rj48=; b=XhUsGYpjHQdAJFrU
	axDHr9VLgvYMyFmWbh746IEWGcYx/3Zc/T3j1QzhnNluaqo34dvKU8ZAyiPkoVc0
	dRH4+i/fzZ0I0kJdsT9WpdFlFc//VlcTGgseRbCFTdZxOZN2oVeqxCNHICumj796
	dgrKPZufnwkTH3VKUEt3upydKYkHbNjltZvmuADKqnw2jDUqnN5COufM2EFnSyVL
	bKM2EPAxrWO/EnPuXYnbi3P5msGDr+7HGuzE02fr3VFGNYPVM/1UZXRkXzYdtjO+
	g2wALuJv6r6wbM2vZUOMq3BCzZ7XMHPGVojV33QPMVP2iIdhaV6SGHXUV1+fKfA6
	QQb40g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjnkqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:49:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736c0306242so410289b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 21:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744865378; x=1745470178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3EKP6uAXQ9ad1MBBIQlu3ccbBQuP26LuQ6x9C0Rj48=;
        b=FRdZ/0Dw9uh66BHo163gqjfQYjGviLAdizgre9Xxof33ocyA6NP/yPrRjMqOKwIk/e
         28JQZWknBEZRPz/kylg9UtG2vEs2aeZ9y751GWiMUAYaFBjxnIu6tfOJnJuGz5LwZGUq
         jYn95C+NV862/PuslL8pY6kFA1AsxZDsrNPCit2m0KDvdw9gJjAxXbAVmIh6lHmb6/zU
         XvZOYWig97U+oUf9kSU4e3/dmVF6X+voU9jeWRfwvRzTQ0w7nSwNeO70xXh2FYPIAg6L
         aCTHXypGGnVtG0sNpHwSO9zRfAgTkAw/gmKB2n2jnuLYfkcf+Qkvhe4raoA46YgFe2Dy
         05Ug==
X-Gm-Message-State: AOJu0YxCAKS+Zbk+kASVzSTDnQV/BlSZmp6oWEw5RyWPm2agqjZ0yXBd
	LvrmNpNc5EAovP9TgyDJ5RmTP7hVGOdIK7Jzc2zCPDYICQdkZQsXzEMJ4h0kiRW0mCVKjBSmmWZ
	gR9nTtoT/jTDLa3gq+U55QmNXFT5DXuBe4U+o55RDGbGvRk3YvTvovHhy6v5VZjqEoA==
X-Gm-Gg: ASbGnctXyfnnYFOADTn2YhaBNHtc9cBcVTpT7UWSGi2SsfIBWgl447IqQXd+YSaDNPL
	LEd4wAZd7zOjVvbp5KeOZbJW0A6ckqOzQg/haT+TlI0ZI4Gq9AoXh1s+4SpHrOVZX9o9DZ/HTIY
	pLu6i+ERIgpWHxlUL55MEUalqquvQ5nzVsKiK4eA0r+E59eieyP+9TsjiDhFckbMwmCNyLVarJM
	rcCGMstYPerlPw95Lapn1A6Inowt0b6dxlgQDeE/msXVfwBEN8cQ8KaA7ptHv+X15wRUcCf4/6Z
	6r3P3V0bijYb3mwcRa4Hg01IlgVA1jmuWTnbZmXB3OhIFQLC9fu/bQ==
X-Received: by 2002:a05:6a00:851:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-73c267fb35bmr7123608b3a.24.1744865378480;
        Wed, 16 Apr 2025 21:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMC9zn4r4+rmAcpaTVyf+mUWEy2vO6ypTp2fj9ynJIxEOdODtpj3XMuwCjby3H7vbRzs637g==
X-Received: by 2002:a05:6a00:851:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-73c267fb35bmr7123580b3a.24.1744865378019;
        Wed, 16 Apr 2025 21:49:38 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e578sm11728852b3a.144.2025.04.16.21.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 21:49:37 -0700 (PDT)
Message-ID: <043ce38b-f472-7e39-bbdf-d676f5622936@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 10:19:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Prevent sending WMI commands to
 firmware during firmware crash
Content-Language: en-US
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250416020414.2161545-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250416020414.2161545-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: am4_-o_VbcPRxvMCs6DnFd_jlXoLqO2Q
X-Proofpoint-ORIG-GUID: am4_-o_VbcPRxvMCs6DnFd_jlXoLqO2Q
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=68008863 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=diN9YrPEvmRJHg0F7aYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=863 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170035



On 4/16/2025 7:34 AM, Maharaja Kennadyrajan wrote:
> Currently, we encounter the following kernel call trace when a firmware
> crash occurs. This happens because the host sends WMI commands to the
> firmware while it is in recovery, causing the commands to fail and
> resulting in the kernel call trace.
> 
> Set the ATH12K_FLAG_CRASH_FLUSH and ATH12K_FLAG_RECOVERY flags when the
> host driver receives the firmware crash notification from MHI. This
> prevents sending WMI commands to the firmware during recovery.
> 
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x75/0xc0
>   register_lock_class+0x6be/0x7a0
>   ? __lock_acquire+0x644/0x19a0
>   __lock_acquire+0x95/0x19a0
>   lock_acquire+0x265/0x310
>   ? ath12k_ce_send+0xa2/0x210 [ath12k]
>   ? find_held_lock+0x34/0xa0
>   ? ath12k_ce_send+0x56/0x210 [ath12k]
>   _raw_spin_lock_bh+0x33/0x70
>   ? ath12k_ce_send+0xa2/0x210 [ath12k]
>   ath12k_ce_send+0xa2/0x210 [ath12k]
>   ath12k_htc_send+0x178/0x390 [ath12k]
>   ath12k_wmi_cmd_send_nowait+0x76/0xa0 [ath12k]
>   ath12k_wmi_cmd_send+0x62/0x190 [ath12k]
>   ath12k_wmi_pdev_bss_chan_info_request+0x62/0xc0 [ath1
>   ath12k_mac_op_get_survey+0x2be/0x310 [ath12k]
>   ieee80211_dump_survey+0x99/0x240 [mac80211]
>   nl80211_dump_survey+0xe7/0x470 [cfg80211]
>   ? kmalloc_reserve+0x59/0xf0
>   genl_dumpit+0x24/0x70
>   netlink_dump+0x177/0x360
>   __netlink_dump_start+0x206/0x280
>   genl_family_rcv_msg_dumpit.isra.22+0x8a/0xe0
>   ? genl_family_rcv_msg_attrs_parse.isra.23+0xe0/0xe0
>   ? genl_op_lock.part.12+0x10/0x10
>   ? genl_dumpit+0x70/0x70
>   genl_rcv_msg+0x1d0/0x290
>   ? nl80211_del_station+0x330/0x330 [cfg80211]
>   ? genl_get_cmd_both+0x50/0x50
>   netlink_rcv_skb+0x4f/0x100
>   genl_rcv+0x1f/0x30
>   netlink_unicast+0x1b6/0x260
>   netlink_sendmsg+0x31a/0x450
>   __sock_sendmsg+0xa8/0xb0
>   ____sys_sendmsg+0x1e4/0x260
>   ___sys_sendmsg+0x89/0xe0
>   ? local_clock_noinstr+0xb/0xc0
>   ? rcu_is_watching+0xd/0x40
>   ? kfree+0x1de/0x370
>   ? __sys_sendmsg+0x7a/0xc0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: a9b46dd2e483 ("wifi: ath12k: Add firmware coredump collection support")
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

