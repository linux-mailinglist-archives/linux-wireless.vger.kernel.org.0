Return-Path: <linux-wireless+bounces-38244-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iduBALnxQWpmwgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38244-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:16:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9D6D5D08
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:16:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=n+K0TcjZ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=SOULNfYv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38244-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38244-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3DF23002527
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6842D218845;
	Mon, 29 Jun 2026 04:16:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295ED4C92
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:16:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782706610; cv=none; b=dl6gz9fl0g6fjI5vVUv0/q46Lfnhkjzrr196VpA8AJBd+GnRd8EI5tGeceoovqlzLu2LhjFWf+GvOCrILVrrv/iDGNz7R11xDd7djsdc0Rs2QNrEm6X6gSYa0jRjtMdEoormeE6YVCBKyyfwGmJKvQz0FpWOmLDfasRzmW5gjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782706610; c=relaxed/simple;
	bh=tmPkTu4MCEI+18s0F0R2Cw1j+3g8em4G+yn7sVeLWTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPmraLCJhXU1ieXqt53bKNcW3FSkG2Y4u3vCTPu9hzMxqcX7WSXMKeffiSYs6XcPeNFXNaLozRpouFUWVqQfqxJicyZkgE2HopTI0K9ytkRdZBF800FMw7gd37fh9zyc3N2pu7aBnXYsP2ohQeYTnc+SNJNleCLn6VZjkZc8ALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n+K0TcjZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SOULNfYv; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T2cleG1503992
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eJ/ELpwOroT6yaLDC3aRC4jOxJftHTkof6pHm02gk64=; b=n+K0TcjZVRiU6LAs
	DFqtfI+qKv568Q6Om9A3TxEx2+sigGZpIMCyO2Jw9V+lT91ocW+B4Wsyybqig3qQ
	Q9sAeUslg86aMUmAOc91920guTsukxpYZRCt6seH4z3fAIpnZsWRec6kIZ/a2aJ5
	OFoX9YiyvnpABtB/c5o9ERscsdzb8iDSInGnCe6QVPzfE/EFBi/IeYA09HzqDJ6t
	EI8YmHalj5HntYkBRnZ+l3cV7SzKoOeXQKXXIkr7QMiz373S8U0SivfBFh/aDpLI
	DGOIQvQ73WywrzHG40WRH5zIh0ED2HfO+qxa5SsIUxYSdl4CaJHKTBG322hlZOsj
	wDWCpA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7v9ga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:16:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30ba395b047so10536973eec.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 21:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782706607; x=1783311407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJ/ELpwOroT6yaLDC3aRC4jOxJftHTkof6pHm02gk64=;
        b=SOULNfYv0Y80rcjE2fiNnc1ObiO5udmxfuRQ4SEWOL8iJZO4FZSizi84bKZmoAkKYI
         F8Pv3R0UpWv7lGq/c+EGhgvUftSjVFZSC0DrZ+bPpFlLYDxl8EXvAQUHsWBErd6OE0z2
         dFCcB2I5bQAkiHlNSDY/Ejmoe4KfQnotJTb0USxcELiCLpUy9QjvvyqXZCrSwVrJGh2C
         xIHNL9rmdscoNMSuPpyYzGpx8sibzYEz7B6LWM8vBWYLMvv4lzeDu1ivOiKd5FD0L1ss
         6F5qb7/356w/H9KxiKZKsH3omp+gNTbnMx76hMgbZelAGyedAqUIeMUfmtqCDJK0Y0uo
         gMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782706607; x=1783311407;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJ/ELpwOroT6yaLDC3aRC4jOxJftHTkof6pHm02gk64=;
        b=VLUIW92Q5XhnNhEuuTRupp8LBzlEsxyow17LhWLqus5lTuCFm8VHtjms3dXgrs/yfA
         Jj27KkOwcixCsGQNZcZbQBZPUlP6C2ZZsybXuhH4eAkAJvP33fgIsVnqSH+DCEwj9Jl7
         mJE2brWYH+tyeOHgjs1wpqSRJZf+6TtZXSHHtT6BQoActFR0hNnvpbY1cz0wxiVHa7RG
         HhP59FN8E+gVEHPTYuSZjZr8Z+Qr35rCiR0h7r0GwJE0EGsFYkpyjxUfAjRHEhYR8K+M
         Mj33C61vMCIfx7IpiUuRPEG6DhQH214vwiqv+KBgsaneZf9s5cBgwJMAj92Ke087az+A
         tv8A==
X-Gm-Message-State: AOJu0YwUAxUZQX71DFTsCTuADfnGCImREAiT2deePGsSdvulzPaKTl+g
	8ZQlOdZWY0AKOqx9h8ss73Azjhs8XbB69RfLCCTv9ggDGJ8iuK4WjOrYGCzIFqtrdNM4T9Ab3Jh
	u2m1uE9837NTkr8wPupPCqLcGbfpGcbNdrUKFWVzQdNGwyVGkQ67yOe/k+tDdgCMS7pvKtVo58s
	7JxA==
X-Gm-Gg: AfdE7clReMWa4y+FznD9Kw+TkeNh7mLo+gNK9Hu68JOfN466fLVm24w7SDvC8z/imu5
	J8Qck9qnYdmrxjcIhizJp1uECsnFW+Hj9Gkr2XhTqtMjvhkTTpRZrlaETK26TbAWk3rR2Y4YuJ7
	wCCtO2I8H7Ks4XMXy2Z2FoFjq01eKg1Ycjk3bnvM8BLqI3l3MoeVC1WoJVd9YVnWybAzNg5lQ74
	hGI9Ml4h/edHR7VNtcUP42Q1N95UB+N/90SRB36bDHd0vSnYdoW4nJ5JcVPqzGUV5pX12y2XnB9
	uaZIJl5bmkKCJ9zrKbTXondZ/Ohq1MN0hkQfAWm/0aRA2wAoYPYvCMWFvnWFY3FyORhLlw2tAiP
	vgY228b3vJ7RLTOjEWmZwdlCYuQzLn8PvaeWx6GHcad5Sat4UcUA=
X-Received: by 2002:a05:7300:748d:b0:30c:ab4f:46c4 with SMTP id 5a478bee46e88-30cab4f495cmr8426986eec.42.1782706607399;
        Sun, 28 Jun 2026 21:16:47 -0700 (PDT)
X-Received: by 2002:a05:7300:748d:b0:30c:ab4f:46c4 with SMTP id 5a478bee46e88-30cab4f495cmr8426973eec.42.1782706606927;
        Sun, 28 Jun 2026 21:16:46 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm43439951eec.4.2026.06.28.21.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 21:16:46 -0700 (PDT)
Message-ID: <f7f94919-9fc6-444a-8611-339562491765@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 09:46:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/3] wifi: ath12k: Improve dp stats
To: Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMyBTYWx0ZWRfX2zqB4/DY7h2J
 Xfk/xFY3ADNmOyKruHmg1tAJfP3RMLSeWODAagwmRzVxysyYmooN6yMuqoQeg+hFN68t5330lPK
 yR/3Zgpk1SAKJVHNdO7gEtaHW01Lr8QaP3Ip5mRrQSZAELs/Rr5fVGGbEK2jNcYNyUPkf/Uq0rB
 s/gq0eYMsY3alAPPnNhDYtD0mKMkpEknPAsKzOcu7mItBOAkuw8Z3ooV9OM78jNaFvg1w7efyDl
 RtbAdIGmtKGE58h7wxJ0BkPEU6K8Axr/pOHP8hGA3yFH1HSPfn52i+SsGSojpsMJGGsfw9t/AiV
 oGLN4J8JA+GrCnKZwM18uV920dVZuvod0o13RK1G0ebxWXW55egt5kkSCcUEOb7U1M9ur60d+NF
 xQiMOymn3IaOmSoovdbVbkVB4Tw86SK7EuUa/jvSDMg5KR+Z/YiLjyCGGmcwRS4NLNunAo8ESCB
 VA0rLSxXzRS/uo1N2xA==
X-Proofpoint-GUID: cMZzaxEltvVGy84VNDXbWws7rNQAAOU8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMyBTYWx0ZWRfX752OfM2irANx
 VXREYhv5h+3+mifOlp0noWxMCseXn0LWayk/N4ehuvx7h6yoMcOd0nIScS0CYJz84sM8q+6NXtd
 g1C9feYiv/ogmj5LVPQFhWnsbJ8+/mM=
X-Proofpoint-ORIG-GUID: cMZzaxEltvVGy84VNDXbWws7rNQAAOU8
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a41f1b0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=w1hz04t2yJB1brSwPtAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290033
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38244-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sreeramya.soratkal@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4C9D6D5D08

On 6/26/2026 2:22 PM, Sreeramya Soratkal wrote:
> This short series improves the device_dp_stats debugfs interface in
> ath12k to produce more useful and accurate diagnostic output in MLO
> configurations.
> 
> Patch 1 fixes a latent correctness issue where the REO Rx and WBM
> release error tables were unconditionally printed for
> ATH12K_MAX_DEVICES columns showing zero-filled entries for device
> slots that have no hardware. Replacing the compile-time constant
> with the runtime device count keeps the output compact and correct.
> 
> Patch 2 prepends a ktime-based millisecond timestamp to the top of
> the dump. In MLO setups the per-device file is to be read
> independently for each ath12k instance, so without a common timestamp
> it is difficult to verify whether two snapshots are contemporaneous,
> making cross-device counter comparisons unreliable.
> 
> Patch 3 extends the existing per-radio section to report the center
> frequency on which each radio is currently operating.  This allows
> the reader to correlate throughput and error counters with the channel
> without having to cross-reference iw/nl80211 output separately.
> 
> ---
> Changes in v2:
> - Rebased the patch series on the latest tip of ath-next
> ---
> 
> Sreeramya Soratkal (3):
>    wifi: ath12k: Use runtime device count in dp stats display
>    wifi: ath12k: Add timestamp to dp stats display
>    wifi: ath12k: Show per-radio center freq in dp stats
> 
>   drivers/net/wireless/ath/ath12k/debugfs.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> 
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

