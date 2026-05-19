Return-Path: <linux-wireless+bounces-36622-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDVJHWu7C2q3LgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36622-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:22:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4DE576034
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F60B3011C56
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C1F2580E1;
	Tue, 19 May 2026 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3DAl7Rn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dOSFW0A9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A616248F62
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153738; cv=none; b=m+0afgBX2ldooDX6DOySPFWnIJ8bZfThX5CXI5/+PvZG6ElkVa/pjJ3jdq/1FaoqDtcSbJltQk0xGemPCLiefZTkrnnyUHMWnSOHwbcEG4WxuSPj8rq0/Pv+KellpjkwYSs05PsOq7slhPN9lZJP0Ic8mFYKMoL4hBQU5PRCV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153738; c=relaxed/simple;
	bh=f5XszkWlSQMMw84KPX8WkfhqD9oT5VWuWEbEFqZzt88=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hri+bje4FqjfCDPiOR4al1svYmpZjgfHt7LsNiPTADlfHMZz1oM/RbeQH2wOTU0pKExDXlc15lLo9LABOCG+apeoySpBLW3LEklRDkEYCja0Roy9iLXteBnah0JOAEwA52e0WeTF41+yUDDiH14GRMBTEYr1zRieCblFFbL+Eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3DAl7Rn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dOSFW0A9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IHGF5k2082390
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HUYrIrQZ26u2sDJnVp8nlyt3Y89Q1ocf3D+sqdUX+3o=; b=o3DAl7RntEwSSlD7
	UHOQJ2VDjCbd6nPjiJHQRMOz0BM9sz+9taNF0BCRaqFMxxZ1QBmcbimx1uvd5y4r
	UTE9FC+sFw1h3BkJch+Rz0r9AeQHW4pWfY0BZGzjVAZ4n6RRC+ifCdaZbuZoo8NQ
	/eiPRYK4dab1XPp+wqEXIk7F2D5sYlL32IBV89/KWExKV6v6jMNTPJcUqRDMWDIc
	e0QQ1qRpym0Rko2zdiF9hLByLzSBwz0nE5MC7lzHLK2c3TWfz64+4WJzb1HEprmU
	Fz6Ny8SJRCY8vTZvpyOBHRDSOo6jtOPaZ8kNnB0R14zpGxWO0eHAIsnJC1aay42D
	YN72zA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81chawv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:22:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so5796813eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 18:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779153735; x=1779758535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUYrIrQZ26u2sDJnVp8nlyt3Y89Q1ocf3D+sqdUX+3o=;
        b=dOSFW0A9afAPxPPLEmr0NTluikp28owbfFJ3Dk5ehYRLmL7Vi6Y5Dexgj2Ecz+DGqa
         sQfDaUQGBxNRJH7TIkV6Ep+ptbYhSYSplOMbOhV1nDs8thPIkRO8Z562RQDweCpeX0Eg
         gZUS2n4mUJ20H4nbpb/BlKyijw5zt1YBDrk9NFH/YFZt6pAVad9Pe/CghilyD6Xwlr3h
         G7fMT4IJA1UOW/p+EuChanxxiPjBM1o839XGrgmrxUDf3RLg+Gca3UT27Etjm7UIfG8s
         2hL5x0flMPI5uHyKH0wzD8i5+S3c9pMgLuf35GVviMwoycFUaLeEa+Lb4zTwLmBVzDjR
         1ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153735; x=1779758535;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUYrIrQZ26u2sDJnVp8nlyt3Y89Q1ocf3D+sqdUX+3o=;
        b=BsxMID7FvDiZP0Gqv+z/TX3S182Pi62ICkU2LPKYHERUoBwuO0iuNfs1ZueetSDI19
         zeekZSyJ2Fd5fnxVpb1bf2Wa5GLXzt1Vjd35KuJD/0VwtzuxUyDsb8pmk9j5mPVQFXpk
         b8EQKlOLw/ARycWNJCDYIuebZkXiJbg1CQ03SwNIHsmySDRDHZpYgGiI8R2kYjV6+Shd
         0F7Q2rlYxr56xZdYHDiK6+iqKxiIHenP74FzCdLyH/jd6f3CX5FWvixl13y9qbxi0J1v
         bSmW6EIJBVUInDzkKgw2ZT651GvjD6xQ74LLlg1v1MmAeuSY/wDrUzynqha6m57cb+m+
         4YSQ==
X-Gm-Message-State: AOJu0YyfUpTSud5Tustr1l9F+yYLIVo9e7Hu5xp14vR5sEdKur6ztQaQ
	+0UkWJ8Ihk5KRfZDZpks/fZSn50aSVdBSkIvYdE0hMtBxDX70LQCjwjlXZmXUaK4vKxg1GUwyEB
	otWUZd4zeUBQu1js1f9TslCZxHxxvcGJd44c6vahFc+shopxQ6cQdhLIlHvcesUF+B5EJAg==
X-Gm-Gg: Acq92OG9vm6qDB3dLEhJpbji0j7M97CtIq1W+TMvgfViV7FYMIcvh9i+FOg43MF3Cie
	41CIc5cI0fnl8BaPjEaX9PKb3IHmjqrDFwl9h9CVuyTr5/2aUuahdTRzr5rM74jKcSUThUjfLS6
	fimB9R76ohJyAfVnJ4bxGKCUrwhDriHBI0k78nxf/zF3NfejG2GpBms1SeuicW1BJlSOTEgPj2y
	93mHU630Z/Ei1zM5A+nYLA2EoyLhF9XfD1YsSC+GzvjrGR56Q3+m4HPTLSEaTAIYQe3TmVlH0nl
	tx+FwswOnhLsbcSPBYpNvzzBjtbWr0+BLsDFvEd9oKX9Fgcjzh9VqnGD49rpVNgGxNekTZth0NA
	xPYTr7JOELH3kY4UdKR6taYNKz/H0Y6RPSa0DPIhrqxd3cxlQC8O1EW+GliQjS/u1APuD7BWU61
	W5MJ8=
X-Received: by 2002:a05:7300:d70e:b0:2da:2ec2:64e5 with SMTP id 5a478bee46e88-303986771a4mr7267535eec.18.1779153735178;
        Mon, 18 May 2026 18:22:15 -0700 (PDT)
X-Received: by 2002:a05:7300:d70e:b0:2da:2ec2:64e5 with SMTP id 5a478bee46e88-303986771a4mr7267520eec.18.1779153734616;
        Mon, 18 May 2026 18:22:14 -0700 (PDT)
Received: from [10.110.41.137] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e6a9sm14910656eec.2.2026.05.18.18.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 18:22:14 -0700 (PDT)
Message-ID: <6d7f958b-90e6-4e87-89b1-3cb87cef2c34@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:22:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] genirq/ath12k: fallback to threaded NAPI when IRQ
 affinity is unavailable
From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
To: tglx@kernel.org, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260519010758.712297-1-hangtian@qti.qualcomm.com>
Content-Language: en-GB
In-Reply-To: <20260519010758.712297-1-hangtian@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a0bbb48 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=saHGBBN5nZt_bAPv2P8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAxMCBTYWx0ZWRfX7iqLlapMH1bx
 LPUJa4EVZl+7b2p2gcdwB/XfuC4Z3GPufkMBs9xWjfMLrsKR7TPTzB/pVNKw5b4CHvx74JC8SRv
 9p0Rfmqq9k1VpBOtq82l74oGbaJiCsSxtXXlUqCD+WzYMwoNY8gbhwf00RHqSEqnQbOsohFgurx
 26U4rGJQYeNXlB4DKgf6E1IDPzD53kuJdMmfsnp8J2EXb2an+AKpAAT+aVTG++Vgq4SoBOnezMI
 wr/pc4Yzul6OWzjouqk7D7fBLT6oakHLOobAGdcQ9g3QeCs1hHkfbFISe78QtYFH1wfoWbyXva/
 SYz7rfqsdBhFMLwn/XptSbhaVfiMsG4nHK/4jhWxF12VQ8frKLNH7FWaGgCsz/zH5Njy6RQVGkZ
 N/ANGErrV5lgRPWN5LEAHxuZs6ZczXD1T9pQA5ODThzJhtWUeCd6KBWyRgxq0W42Z49WmRPPTCe
 2Un/hvF2wOjrjO8923w==
X-Proofpoint-ORIG-GUID: h2DQURFCxGd5B4FN6dQKl0sQ-93iN4Gj
X-Proofpoint-GUID: h2DQURFCxGd5B4FN6dQKl0sQ-93iN4Gj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190010
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36622-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hangtian.zhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CB4DE576034
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/19/2026 9:07, Hangtian Zhu wrote:
> From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
>
> This series improves ath12k datapath behavior on platforms where the
> effective IRQ path for WLAN MSI interrupts does not support affinity
> setting.
>
> In such setups, DP processing cannot be distributed as intended and can
> become CPU-constrained. The ath12k change switches to threaded NAPI when
> runtime IRQ capability indicates affinity is unavailable.
>
> Patch 1 exports irq_can_set_affinity() for module drivers so they can
> reuse the IRQ core helper instead of open-coding equivalent checks.
>
> Patch 2 uses irq_can_set_affinity() in ath12k PCI to enable threaded NAPI
> for DP interrupt groups only when affinity cannot be set.
>
> On RB3Gen2 with QCC2072, EHT160 UDP downlink throughput improved from
> 802 Mbps to 2.58 Gbps after enabling threaded NAPI.
>
> Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00074-QCACOLSWPL_V1_TO_SILICONZ-1
>
> Thanks,
> Hangtian Zhu
> ---
> v2: sanity check irq >=0 before irq_can_set_affinity in patch 2
> v1: initial post
>
> Hangtian Zhu (2):
>    genirq: export irq_can_set_affinity() for module drivers
>    wifi: ath12k: enable threaded NAPI when DP IRQ affinity is unavailable
>
>   drivers/net/wireless/ath/ath12k/pci.c | 11 ++++++++++-
>   kernel/irq/manage.c                   |  1 +
>   2 files changed, 11 insertions(+), 1 deletion(-)
>
>
> base-commit: e12d2d3983acb150fd987d19ec6a2a530da110df
ignore this series as wrong patch version, resend with "[RESEND PATCH 
0/2] genirq/ath12k: fallback to threaded NAPI when IRQ affinity is 
unavailable"

