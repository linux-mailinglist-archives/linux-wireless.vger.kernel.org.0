Return-Path: <linux-wireless+bounces-38848-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RvjPJy3fUGqP6gIAu9opvQ
	(envelope-from <linux-wireless+bounces-38848-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 14:01:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297B73A7CE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 14:01:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PngctOSD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=h1HhfscS;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38848-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38848-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EAEB305BEFD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E934499B0;
	Fri, 10 Jul 2026 11:50:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE793B83F0
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 11:50:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684254; cv=none; b=brALELYcpm/qogUkIZnsevvQtPdbmZiNznc14PyOwZiGvTcOcAUWu5PMy3r01Z9RzH7te6Ox4wKEU8TsQt+2wol57bGbCPnfC4C/sk2XFCtn6WzGfebpOf1f9UIOuJkGFwJvfShGBeRj0qFu9V+UBg4hXDvAyLh3Bf58wlLKZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684254; c=relaxed/simple;
	bh=MIQ649ZvOgqhV+pT044hKDpX67AE9F8rtANHduwxGGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6c566subYSIIe7EIT5cK01CJx4oKb7NAqBWXLh9202PhhUL+ZVWobH6zYjj/iqxaF2oCgkYVE0rEkLsIXXXzNZjYa9K891/L7G4foCBnHtljVc4x/iX5gECjr30ap3z/mH9pm6NGnJEijqULOqtQRLWRiuNKWHeI5Wp5dDoNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PngctOSD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h1HhfscS; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAmnbl520593
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 11:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bt3ZzznhWEvrIU6LXkjK0Fr8OW0aQMQr0vzrLr2CA3g=; b=PngctOSDoyCHV13e
	jg8O7HgcMb+GnKHrKnmf9jSNDHA95aSJZhvGlQ+TGtrHD8jN92waTv7mUSpCayLO
	YdEOjjqf4d3D1xJIacAF/XvRCjqbXnAk1KunFzQ/V2TcLy1WuvU1euLMER8ZCDmX
	FAy4JLwz8h0uYJEfNs4hAmzggUtcf+qPo06NNW2vPZ3Hq1JrCJUwxZwPmixs3Kf4
	CRgJw/YaeCL0trB5JJvPqBaGEFdcU5ofbADIbQo0Kl/WK14h2SxO3J0+CAPV2dho
	WNMoEPdIxoTqneY/w6SsZa8Ynh3oFmrVg3Rz62OpD4sc2e6ruyhHpyh8FwPyWTeP
	p8j3ZA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjcg72-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 11:50:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-380b630c505so1095132a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783684234; x=1784289034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bt3ZzznhWEvrIU6LXkjK0Fr8OW0aQMQr0vzrLr2CA3g=;
        b=h1HhfscSrUhOFuBUOMgHTt8Gf/WDpe9Z6WIkkg1JHMpJ1eSm8qjB2OGRiPWUx7D3im
         516vcJOnrEiUzwxh2rut4XPkkONQSKUVRWD7tH0ZOxSxtcSAJu5gcBYkoJuObXE8G9Jb
         VTnHx6JJdcZcimTO3ftx9/NQqtKS4d5eStPpCOaOgI5PsOTBUbynFxBSWU2ylPnV1yGE
         ijWDQLymVCnv6YkSfIKWqdUThSrwK47kToVCdx0rG0vpR51HCV+75PgrTLQxETKynQ2b
         f8diacP1J4+RZi5QaLSG4EMMaDKGSr+6tTSwEWDBvdNIbE27dPkBmEMrkbVwQDYWqMWt
         5EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783684234; x=1784289034;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bt3ZzznhWEvrIU6LXkjK0Fr8OW0aQMQr0vzrLr2CA3g=;
        b=F2od/kKNKjBWSCLWHpWrvvuK1UulD6noUJ7Xu8i6U4K6kbwcOvTq1Ne9p2wPNGlnQj
         b/75F3jQJsgQJ30k9kRWw4/61122ZXxF1iCrEax9yy08Qg6VwxzQVWLR/cl5ylKAAHIU
         7miDTvZQUS5JM28DqmVlPhiUpc5BzvldqtPzT4Y4VHBtrSWaQ1r4HTMZhoTnGOkC5TLs
         YZ/I9oa8NC8wYdxNkbmEjSyGvOsGMDObMTI9HitDUhSKcnSkyEgrXWUmdvNla+8jFTrp
         1l/5fW49HAvlrmXRqHDp++0AdgcVcpJT12Z40mX2OaaORZx4X9UlG0pwn+5N0KxnEaBN
         fsJg==
X-Gm-Message-State: AOJu0YzJ0ix4hZl4fYoXctpbGvj17/mR+CTjFV/R/tcFMaWrygqz10V+
	hJtXLGMdAhytDyXve/ezNxvC0d73FB1uGZDJIkzZu+2BHYjv197e7n+ZfEiz6UMaMEEn/MtorWG
	13Hwf9ig0sk88DG2bgpX4WCHkhQQjilizeGbFkyMtc2OzRtNm5JpSJ02eMgrI1g2N3dL+Y6Ul5U
	HJ/Q==
X-Gm-Gg: AfdE7cmhnUGorkfOrP4ovH4mdFCE5l87XTbgM9F98aHXadc3fiWLQSU8ArFs4nXLI91
	/3o4HGVeIaQa7zbRCac8tyKGLXKN1CNnGKnhQaHke6z0MUJ/+W2RMLRbUcaM804urRr9YTvsD1E
	AVcfQsEX/qdvXjztmOpj6r1xfsVQ6hCcJn5tUk1wJ3WG54FYfEB4uxHp6dfADv7ailG8MWhzuJ9
	kalr/Hm4Hv1qy8erSnR+DCdeIdnjfDIc3sWUX2jf8FWBAQO74wzMpm5uj219D9GeKznW0BjnJ92
	qY5GOeyglNksoNF5tvWOxmFmRhz40qRtAMU09mxMDDRc6sRKi8WhYYHU+gAmuwoA79IGMnrYRFq
	2TaL0GMmjP5b1TKFC9liuNcyAH6IsFKa6wlHdUtE02eR6GIh8RYY=
X-Received: by 2002:a17:90b:3c4a:b0:381:21ea:912b with SMTP id 98e67ed59e1d1-3893f693923mr10301571a91.1.1783684234124;
        Fri, 10 Jul 2026 04:50:34 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4a:b0:381:21ea:912b with SMTP id 98e67ed59e1d1-3893f693923mr10301530a91.1.1783684233529;
        Fri, 10 Jul 2026 04:50:33 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b9ca880fsm1014309eec.23.2026.07.10.04.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:50:33 -0700 (PDT)
Message-ID: <be226b9d-4d47-4aad-84dd-3924017346ed@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 17:20:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: update IPQ5332 BDF address offset
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260710053534.879233-1-aaradhana.sahu@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710053534.879233-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDExNyBTYWx0ZWRfXxtoiCSTUcTTo
 rE2PtEA7WtbZf+feXSlL9GqwP9glYZbfqQz9B2CUz8J2V8GThqt/5RiApIsJrR+uImppg5Ssr+2
 7KX3kAvCUy0GppWf+675xUHQzaRQhsIHS8zVBeyA3k7aSde6rQ8ZG02CIfRgu7tRwkPX6R5pjq5
 GkbIUfbGsRO8OT9pYcLHmSGh86Qf1fYklFqE9FCtHNdtuJ3KH/kj4QPZC+pe5mraehOv2K27iyC
 PULMAaHPsBBjSUbqiZ9BjerYrTKUdp79YqEBQ5MiEJpIlw1d9kDzn8jhGd1tq+VshQEtMTSPoRN
 1ttFB4uwBQ73oblBdygaOMU9gTt/69MrvAxgglgIQMx90gRnjTDWC8+owXtg73pXvSjCwaEC2Yl
 cKldX0d9wY/507PXYwKMrG40UhXNqg3g9YzWgSJ/jC9KeOipqpDaB8HS+VN8SoV9q8w7rlxHBn6
 gOYYUoDXw+P+dcpl2WA==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50dc8b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=viQb0OZrn-eQzSfuS2QA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: PTUHv6kt3jcEdUucOesQYeZmcKZgXk0O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDExNyBTYWx0ZWRfXwk7Mp0KAo7xd
 w5Mvntm4/9tj1AUbnBg65sPDIM7fbEdGiACBUliXht7jrx1JwRPtMWkqfno7NXOJ4YyAgAvdk2+
 nZ/ZEe74Ww5aiLmGLD0PQxqWOXopFCM=
X-Proofpoint-ORIG-GUID: PTUHv6kt3jcEdUucOesQYeZmcKZgXk0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100117
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38848-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[rameshkumar.sundaram@oss.qualcomm.com:query timed out,aaradhana.sahu.oss.qualcomm.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6297B73A7CE

On 7/10/2026 11:05 AM, Aaradhana Sahu wrote:
> In the ath12k driver, the BDF_MEM_REGION_TYPE address is derived by
> adding a fixed bdf_addr_offset to the WCSS Q6 region base address.
> 
> The current offset (0xC00000) works only when the Q6 region contains
> the IPQ5332 ucode alone. On some IPQ5332 platform variants, additional
> devices share the same WCSS Q6 processor and place their firmware
> ucode in the same Q6 region. This results in multiple ucode sections
> within the region, and the existing offset can cause the BDF memory
> region to overlap with firmware read-only sections, which can lead to
> firmware crash and driver boot failure.
> 
> Increase the bdf_addr_offset to 0x1A00000, determined by analyzing
> firmware memory maps across all known IPQ5332 platform variants. This
> value represents the upper bound of the largest combined firmware and
> ensures all IPQ5332 variants can allocate the BDF region safely without
> overlapping firmware regions.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

