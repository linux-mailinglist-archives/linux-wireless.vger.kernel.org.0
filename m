Return-Path: <linux-wireless+bounces-36285-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPKoMp2hAmp2vAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36285-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:42:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C78D51966F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10BFE3075385
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D44288C96;
	Tue, 12 May 2026 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HhhtIRtl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XUm9eN0J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DF5296BBC
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557094; cv=none; b=P3H0QCM/63GCXyySF9CpUM1/eEmCbgLmrgKl4wHg0utqWrTdjfk5g8LrrcHUc8RVA6w61tcdWhdavWE3hgRh+sTv+IuMiVVdhJnT6qGNwcJxAGO/ILek5b5z/+TxIG8XbiwXpIMmicQLh2ud/0SMj9vC6v5zV25qcSQIjjSbHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557094; c=relaxed/simple;
	bh=HjScmhCJMqkbQa+xNKKBS9aGGc8oERncw7fVK7rZjN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZjpzFZ8yiX7L3miaOr0F9CC87bkIfzi2AwycCOJqmC/xZoMxMFWczGz/I9QYHkE4ffF+Il8SKV5o4yoeuUtb/Ti+ZvCNWOdV76mHrdLvUtQQI76W0D1YztoAR01MgDOTIrpe39rwyVq0ceTcBWGB5VaB99v3cPj681TebStC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HhhtIRtl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XUm9eN0J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK8DJ82173016
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 03:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fSbv6RWKhiNiVnUCEsPgSeJb67roaycaVI8OXa3HCvU=; b=HhhtIRtlZlemkC3C
	RJ3LWMcq6eRtJnHzhDkUDy6ljWmw4WPNUJn6yxKQ+n6PkKfPvVkBhE7bGslAl95R
	BxaADWsJq4szYwlKNHS7sMmkrgQnQuoYqGIRUQzWaDSB9R2etAb6u8LKOInEcwBL
	SlvN5IvLl3tIUgmy8ljwmEIDHEbatxcJGcnhCZRqgAfAzvN3MNTHI95uqjAqKJoP
	Wa3Wsuac2hvknuV+Bdg5BEsxFliM/7L1PzzvDvogFFWUGm8dScsBO15BTPormm6z
	GIYlrKFAJuqCkgdySUIlJ11d5CuTSzda8dqlQuL0IOEd1AiwVZDaK0EYeXR8gJ6L
	CixBVQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nvj99ys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 03:38:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so3691061b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 20:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778557091; x=1779161891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSbv6RWKhiNiVnUCEsPgSeJb67roaycaVI8OXa3HCvU=;
        b=XUm9eN0JNilktSWslZq2cdnuVCasyIi+kamdL38m9sL9CaydN82d7mWADhF71lotm+
         LA1gnOyj5xHn8t2SQinHPyWFZMeW9VKSdKCCy9SDseXfpsg7XetyaZGJpcBwJMLm+6FO
         7jzJjXI/0AJP+727a1CT3Hz7DxoserKkC9V39XSie+u8Dasp8NngnWzmCZudenqum527
         us7V2jmOgox6o+JE12N6ipPX4lswmU56GU19uPZTXmyhcihXapsCMOcw+1XNZj7QCzYN
         8OM2+iaNIfHyhf0C1poO0cA1gqDYyTCt7+uKm37x+Ah8ZOaHRYJhsVBaYuyUayFIfOtH
         D3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778557091; x=1779161891;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSbv6RWKhiNiVnUCEsPgSeJb67roaycaVI8OXa3HCvU=;
        b=kDoRho2qx8eGB5v6a4KcoeZSM3kRpWnPlvQOcxh1i9UCYQvSF6FiRlgqGJVvwmx1m6
         8JStqha1W3YoYVlDF+DPFT0bfQzkI564K6ANLHgKCLZu1Q1nSMYd+Fsfd6YkCzLpvq5S
         dGyJN78D69Z4fpVpZOBxoEMkAaYqugGU4Kf+Nk3r14RcHijTa8ZFiFY5kKLxmGOOLKAM
         nlBzYyZ5JcXWWWc0k2iR8xCC5hbqP5YVkH90a50oDe9GkwS2qivoT3/9NEKJnXyINR19
         0Z3Sm9ZRy3NIr9gHc0LEFmX/1WJxm/IYNYz482JWuSQtkWWO2kkxe35ywgFSYJTIXgsQ
         KzPA==
X-Forwarded-Encrypted: i=1; AFNElJ/NciO65stdq1eeLtXyjOmJAUlWiq9RgsAQmDsZeILw8hdAFrx51BeVnwsAwmtKEmXjlE39dsqdsRFDIOQmwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVWZ0p3yVxSztAqI+XGOKMXtGmePAGwLgGnEpt8vEMRr0qGMc
	i6BynGreJFFZoimM0HtvnqRHhhhAKDhnLLdaBzlMy5r28GFvk/wQT4BJv+02QZNOnSaE71Kp0e0
	8Efa0RveosxQ2Ml66ZbsgUXRJ0p7p+Po1Qdsb32XKVqOiD/C//pUtJIyV4bDucbzih0vk5RbOG+
	+MJNZNzkw=
X-Gm-Gg: Acq92OErJuN5aIgzDSnMlPgWDfBKwf1iWo62T4gHLrn+um53GA3wxYPl5Z/n7zLx0gS
	ye+v1XOFSdlyqQPBKOBeuVLjar/FnY+T+DuNtFHrBWHj1FWiq5SdDLi/hhttHresjqRGpkfoejb
	CMK7Y27OEz9vxO4zUnjPI/w22w29lLBSiV4uSKIVSEIy4SNPJrQVeHhJ4Vge1ZGM5F/k4IqrjeB
	OaWV+aD4ga+iwpRKQZoXux3XwHf4alPoPCobGg+EOXqdWPwZthjKqAioMu+4+aOQpd20gWE0EUI
	ea7P6wu/9nhnbkwFJdWvX/qABXHj9uFvmIHevYH0ffvX0+Jx3VabW5WPEDFq/Nwimt3xLopgk8u
	kbrLxgUaYZnFXO3CsG3FTY8TUzin8r556MeZkLJoIiXNNlrnu4GgoJPJUni+F9OKc1rFtSoz62m
	229BhyGXUpgLWVuqAailM=
X-Received: by 2002:a05:6a00:4605:b0:82f:3436:42d7 with SMTP id d2e1a72fcca58-83e395505ffmr12351675b3a.2.1778557090997;
        Mon, 11 May 2026 20:38:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:4605:b0:82f:3436:42d7 with SMTP id d2e1a72fcca58-83e395505ffmr12351648b3a.2.1778557090517;
        Mon, 11 May 2026 20:38:10 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm22441087b3a.19.2026.05.11.20.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 20:38:10 -0700 (PDT)
Message-ID: <0b450204-9afc-4ba1-b9c5-1876b5a7078a@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:38:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k WCN7850: Q6 Hexagon fault at WLAON region 0x1792000 ~2s
 post-AUTHORIZE on X1E80100
To: Marcus Glocker <marcus@nazgul.ch>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: jjohnson@kernel.org, kvalo@kernel.org, manivannan.sadhasivam@linaro.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>
References: <g7dkeq3uwg7eby57zcuu5eysf4tqomh5civlvkpnlziipn6xis@45eevyzgfmaq>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <g7dkeq3uwg7eby57zcuu5eysf4tqomh5civlvkpnlziipn6xis@45eevyzgfmaq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IPSVbHiPpY5_Y3ubCWYfl6LnErMRY5WK
X-Proofpoint-GUID: IPSVbHiPpY5_Y3ubCWYfl6LnErMRY5WK
X-Authority-Analysis: v=2.4 cv=H8brBeYi c=1 sm=1 tr=0 ts=6a02a0a4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=svG3Jch8njoXwoTW5vUA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAzMCBTYWx0ZWRfX42sUTAZSdAXH
 j9SQ9e+oki//pUlXqcK2J8wyEsGxbijDOpbqfvNvKGFAFaITfECGbbLhJbjHSUYY5uIYo1g9dtJ
 7zAhcrlFLQiSfD4ULRk+F3jqZIi6FDwYqpcJFf1HuZLDGRSddWSfgZvseXlOuIcLmwnN38l9Hq8
 QtHWQiZcVGbN7j+uwFd9drkXRGoTxhn2Ifoeg0LXy3N3zth/EQ4V4Y54bB/Tz6JoCiS2YVdje7i
 8CdSu7Aq7li0fYUjsINPgzkWxNfg8mPPGvQQDyE37HLEi4cqiVq5eudn2HW7afXh5nZnaE/kexy
 Tp2sEIYFuVcCX6ALQlbqp9B6p9WQKLSD3ezuAnmCyOoPXaKWU0/lu5M49At1oa96Dz5AfQMMDMM
 zvykDEvrZgQblgolUycWUo2BSgm0PyYURlaGKUlD27MWhXs7o1t4Te2rfU5S5zqyyucRiYGMQr2
 keZ6e5+WeebrtFK1T7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120030
X-Rspamd-Queue-Id: 2C78D51966F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36285-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/5/2026 5:08 AM, Marcus Glocker wrote:
> Hi,
> 
> We're porting ath12k to OpenBSD as the qwz(4) driver, targeting Samsung
> Galaxy Book4 Edge (X1E80100 SoC, WCN7850 hw2.0).  Scan, auth, 4-way
> handshake all complete; ~2 seconds after WPA2 AUTHORIZE the WCN7850
> firmware crashes deterministically with:
> 
> 	dlpager_main.c:147 Non Page Fault Exception cause code 0x 23
> 	at Address: 0x 1792000
> 
> Cause code 0x23 isn't a valid arm64 exception -- the fault is on the
> WCN7850's on-die Hexagon Q6 DSP, with QURT's generic exception handler
> (which happens to live in dlpager_main.c) printing it.  So this is not
> a host CPU fault.
> 
> Per the RDDM segment table (at the start of the dump), VA 0x01792000
> is the start of the chip's WLAON_DUMP region (size 0x820).  The Q6 is
> trying to read its own always-on hardware state region and the chip
> refuses the access.
> 
> (Samsung, Asus, Honor) with multiple FW builds.  Currently testing
> with WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> (fw 0x110cffff, 2025-06-25) -- the exact blob a Linux ath12k user
> runs successfully on the identical Samsung hardware.  Same board-2.bin,
> same compiled DTB (upstream hamoa.dtsi based).
> 
> We've field-compared qwz against ath12k and ruled out (byte-level or
> wire-level):
> 
>   * QMI host_cap, m3_info, wlan_cfg, wlan_ini, bdf_download (all
>     fields including ce_config, svc_to_ce_map, shadow_reg_v3,
>     feature_list, m3 paddr/size, nm_modem)
>   * MHI bringup ordering (BHI -> wait SBL EE -> wait M0 -> BHIE)
>   * BHI/BHIE DMA coherency
>   * ASPM disable before MHI start
>   * WLAON_WARM_SW_ENTRY zeroing + QFPROM_PWR_CTRL VDD4BLOW clear
>   * static_window_map=false + window-bank register init
>   * Per-chunk vs monolithic respond_mem allocation
>   * WMI_PEER_MIMO_PS_STATE = WMI_PEER_SMPS_PS_NONE (added matching
>     ath12k_setup_peer_smps; doesn't help)
>   * FW image variation (c5 and c7 both fail identically)
> 
> Specifically NOT involved (we have evidence either way):
> 
>   * Gunyah -- X1E80100 is reportedly run in EL2 without Gunyah by
>     users where ath12k works; so Gunyah isn't programming WLAON
>     access for the Q6.
>   * SMMU / pcie_smmu -- pcie_smmu is status="reserved" upstream,
>     pcie4 has no iommus property; PCIe DMA bypasses SMMU.
>   * SCM/PAS -- ath12k's PCIe path makes no qcom_scm_* calls.
> 
> Question: what subsystem inside the WCN7850 firmware touches the
> WLAON region at 0x01792000 around 2 seconds after the host sends
> WMI_PEER_AUTHORIZE?  And what host-side configuration (WMI command,
> HTT message, MHI state, etc.) primes that path so the access
> succeeds on Linux?
> 
> Even a pointer at the right Linux code path or the right FW-side
> component would unblock us.  We have full RDDM dumps and dmesg
> captures available; happy to share off-list or as attachments.

please help collect ath12k successful dmesg log and qwz failed dmesg log for compare.

Please enable verbose ath12k log when loading ath12k driver:

If you are using the latest upstream ath12k:

	sudo modprobe ath12k debug_mask=0xffffffff
	sudo modprobe ath12k_wifi7

If you are using an old ath12k:

	sudo modprobe ath12k debug_mask=0xffffffff

> 
> Thanks,
> Marcus
> 


