Return-Path: <linux-wireless+bounces-35444-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPdCFLJh8GnDSQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35444-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:28:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EC647EDAE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F0B0306D28B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9BF3BF68D;
	Tue, 28 Apr 2026 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+liJsDd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IhyHweQr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82676346E5A
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360762; cv=none; b=SxWhS9Bhsar4DmlA/7n7AFELHfFZ5TBsiRj/j1WAQa+8HBSBUCsWf1tGRf9S3WnUYV23uJ+pnn+dK1swqu8sfI27pv8VKSaRNI7InYfzRhgcVWTb17sUwnAjxn0gnxtxvOhv5ZzS0xtSjuJ7susz7B5iuirpKEQqGkzhKXtUk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360762; c=relaxed/simple;
	bh=uGVKkyNx81VzhTdaTkMaHJMU/PiYSekfP8+BMfVmHPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3GKUfTLkOwGLnUS4sOG2LKoQ8f6r2GnZMLqVQD0XDl7U4R+86MW2rU/OZw1kyMmA50+7A34CFm0or45TWRBaBW+pCNIL2+UBdJPYUgEKIRKPjHltS70N5l0euXoE6VGDpQEzVXuwiNKAQqOdF5+FJpVn525i+pFMmzpzgYOYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+liJsDd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IhyHweQr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6OD4U241134
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QTzlCsJxRzarVSCWMnV2DjTN1aJ/3SZ0E8/5kT1ecwo=; b=T+liJsDdoA04rsFe
	d53NbqK0ag/2MOtHRHOR06JUiexyDx2gBJ5vQqtxZBJFAdBI/V3oYTNJEeXy/vZI
	DSl8AGGZTcO6NpLiOJ9sBBn0LkETrNsW/iFF2sRC/gjj/vgw1CLXvr6Mj92FWUSl
	6RmbBQPMPtPzVWDL4AujiV155IXqI6pXhASR/WtM+gZ00W8FdgDVo04uk2q+8lFe
	61YhHvVvmFBRNs4abwzoHtNQtw5OxiZAX4n6opp+SU116rd9RTQNOMy0dfhyEWmC
	HiQtPP18TKr7bfpPMjKzMdA1LHHvaCeApk1eyWTUJWBWfKgIjdNdW8EwEnUipXhh
	SX4wEw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946uh11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:19:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da1c703d1so13090185a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 00:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777360759; x=1777965559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTzlCsJxRzarVSCWMnV2DjTN1aJ/3SZ0E8/5kT1ecwo=;
        b=IhyHweQr8diL5qYolacKnlBtcTKupotfx/rnq1ObSKHKNpTbG09T1HMgyGUSNsjYu0
         Qjoc49ZZ+vioH64jHV1YL+TQxGsCbmTg8KNUZVWIx5fVw7EJCcX12j8rP64ySlIj3KJa
         iWJ+lVAy6cKY90QGejt3WgCgHHycxxAWi9fb162gKXfvaB+W42bo0FUPdyALcPIQjg9/
         xrVnwGexaHonPi05NAr2KarknI/A03/Q0imSfaegSCn1G5tcjJeNWXQj1I8ynocBYbbt
         N4oOZGTevELIWKdKYHkcctxR1mZcuqkBFMbBrjTL+fWltwpyRZwLQag2L8zsXgRjJfA8
         WMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360759; x=1777965559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTzlCsJxRzarVSCWMnV2DjTN1aJ/3SZ0E8/5kT1ecwo=;
        b=FC1gcj6+FYPDDU/+KRHN1YD51YQgq8wdXjy44S224TYtQFaukMNvVyoKnBr1D5JycF
         rjtBNTAIs0XyavL2u+ajtQWkd4Lq2EPWTdqLAOcCElG31x6rUdrQQHNGKXH4ZY6YynfD
         LG03t9VoWnifptX2D5T1Dls7sqGpU9EHuHbWqQkvuuIyxUhTTRgYbZedGBtM+kBJQHGi
         ZTtLLBfXuolKbCqV9RWJox0k2TVe/IYJNt23sxQS0WYRuPOXVbcXDh2V86k0st8KvvZ8
         AMXXNTvzI1QmMPcadu9fJCxxfozwtwZHQf+DbKKiGEZpDWOeiZn53mQK1y9bNjDD0Bs3
         ryag==
X-Forwarded-Encrypted: i=1; AFNElJ+cU6tMf0384vxv2ysXMhGrtnXZzzSVipduiGaizry+/8bHsnPE+DlGzQSDBzKijb/27mlvbs6vFo3r7dRVOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSIkebmYWPs13E/+uW3ed1e2AamChOVtfdj+bDzOHGOCgyay0
	kEKfYXK/IrhzzP0N72v1KyOYkErmt/XnTUELv/nxcalHw3x6wfdUTTZBgtr0KZBMBZqFVEj15dO
	OpVOkTktkjGORUZCxIghRdGnvwGxNUrV1MP5uJCrOpnmBfSYLLO5zMhoDim7WVAneMgluPg==
X-Gm-Gg: AeBDieshsDY5RmRCgs7rJqGAu9uti2uG7SB5P7J1Ii0KECZdNz8QcusCuoOh9UrLDc3
	jNsmy5FQF202+lRNnbwJWfh0x8wlHpSS0gDdMePN+8nJT0Hx6iNfoRaiELC1HUZChBUm+edUYtJ
	qtmTizyY7jvmqcUeDHqrLY4yfNWjej5EbAxRWcW8U2z7FcyksxwX9/Nnkvav+dmzyQX03SxORK8
	ZpuZRYmAbV+iCyMBobKkfbBHlAq9VhSIU7xdpuaNcntFsy6nzD8kbI1Z5LwJig7qiUTnrqwmlub
	lIDKodd1ztj52k4Cs6DTTVd2nxQJx8rCLkc5TZy5K+gMtj77uTFDtlZ7sKzt6bitwEq1uq9urQM
	wwM4aftogh2XUzycf+n5KRUy/45IccnDEIzhlERwsHC91nI+1v0yo8lFdgNcTyPdO0y08Q4pS
X-Received: by 2002:a17:90b:2790:b0:364:6558:99bf with SMTP id 98e67ed59e1d1-3649202bd08mr2009572a91.14.1777360759280;
        Tue, 28 Apr 2026 00:19:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2790:b0:364:6558:99bf with SMTP id 98e67ed59e1d1-3649202bd08mr2009551a91.14.1777360758856;
        Tue, 28 Apr 2026 00:19:18 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649069c775sm894335a91.0.2026.04.28.00.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 00:19:18 -0700 (PDT)
Message-ID: <7d59bfa4-ea59-4527-ab5b-1e2350d08de7@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 12:49:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: cancel SSR work items during PCI
 shutdown
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260404043050.3433754-1-wei.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260404043050.3433754-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69f05f78 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=G9A0gv2bhTP1aVYgofQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: NK8VAEM9JKPF14b2DsdoAWNyDFlP6Pp1
X-Proofpoint-ORIG-GUID: NK8VAEM9JKPF14b2DsdoAWNyDFlP6Pp1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2NiBTYWx0ZWRfX4oyPU9X9smX2
 Uv/4f42wq2JfD5Z2ac6AKxjGADk3TSXGK/wYFOVFUtr212QvX7NXQDzJEGwzSn7ifqqYcdsRxYg
 QaDPUGp8Meo2nl4KCESPOP7NY1HoAPIrXVTUevbKwdMRt4g85h9mA4GfYr8DeIFmSDQ9WzoJ/kD
 Dz5+M640UrBrqStQVva7o08eb9D4Rn3PDYVigJerg854RIcM89Z+Ubpe2M2lZlXTwRcUYcB5nyu
 QEyGqYnv13Iq6jzsqZBA921i2OLjfzXVPThTBEFzqcLY0BMPfQg76LGTvb2k6+K8q/kyj9JwSpn
 6I2xPdIsXlWa7BOc+xI41AF/Xcl/PXideNk+T70CnBdnUitEgLgqJGtFDrt5XGrMfwjkFzE9TmQ
 XCVR+AndhCryNvQBeEGcceA2+YCpNuwt/5NXuLxyWp/b3H0HALzmHK5E/4t7y85AZ/jhN3OW1Wh
 m3S6ED2h+6AmKvVZmbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280066
X-Rspamd-Queue-Id: 85EC647EDAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35444-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/4/2026 10:00 AM, Wei Zhang wrote:
> A reboot can crash the kernel if it overlaps with WLAN firmware crash
> recovery (SSR). The crash is a NULL pointer dereference in the MHI teardown
> path while freeing DMA-backed MHI contexts.
> 
> Simplified trace:
>    dma_free_attrs
>    mhi_deinit_dev_ctxt [mhi]
>    ath11k_pci_power_down [ath11k_pci]
>    ath11k_pci_shutdown [ath11k_pci]
>    device_shutdown
>    kernel_restart
> 
> On the host side, SSR is driven by the MHI RDDM callback, which queues
> reset_work to perform device recovery. reset_work power-cycles the device
> by calling ath11k_hif_power_down() followed by ath11k_hif_power_up(). The
> power-down phase deinitializes MHI and frees DMA resources.
> 
> Shutdown/reboot runs fully asynchronously with this RDDM-driven SSR
> recovery flow. As a result, the shutdown path
> (ath11k_pci_shutdown() -> ath11k_pci_power_down()) can race with the SSR
> recovery sequence.
> 
> Fix this by canceling SSR-related work items during PCI shutdown, marking
> the device as unregistering, and serializing the RDDM callback path that
> checks and queues reset_work. This ensures that no new SSR recovery work
> can be queued once teardown has started, and that any in-flight recovery
> work is fully synchronized before device power-down, preventing MHI
> teardown and DMA resource freeing from running more than once.
> 
> Note: This issue only affects PCI/MHI-based devices. AHB-based ath11k
> devices do not queue reset_work in normal SSR flows.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04866.5-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Fixes: 13da397f884d ("ath11k: add support for device recovery for QCA6390/WCN6855")
> Fixes: 5edbb148bc57 ("wifi: ath11k: Add firmware coredump collection support")
> Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

