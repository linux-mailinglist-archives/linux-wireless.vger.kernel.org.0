Return-Path: <linux-wireless+bounces-38942-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kNgZCI6PVGptnQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38942-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:11:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86195747D72
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:11:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ntEd9RvD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="eFq2E2r/";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38942-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38942-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 852B13016BB1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124E365A00;
	Mon, 13 Jul 2026 07:11:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2C914F70
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:11:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926667; cv=none; b=ujFs3E28e5C/pfx2AXrpXYxdcNFabqLnCXoFoeqBToCE+9LUUTuChWsXiDpZOW7FleA6wou+wtEwGscgRODiAnIVlLWpiIVa3u4UZ4SofqaTztdyLYAnvE21Mu+tDazvtAJREE4gYFCtQ8WUMKoDBBbJUd0vuK2mLMrILskOjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926667; c=relaxed/simple;
	bh=lnjk+I25nNgHoUc3qKc56eY6BYSnkjhzMuu/R+DCDds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJ1pkVTYImu7Xtb+n+RMyxd3pE/6Q3cudEHk3gwtz1leI9nUKP0UfiLe2PifDHipgZvfZFhywrHsUU1BYgFQxsKEji26xB4LVUPcgNmLxRAqbVf6GMgCz/7JQE5gjvgeWIhPdTsrmYnaB6f7UGhLWJL0kPgSSQlXPwZ1/rk286E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntEd9RvD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eFq2E2r/; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NtBv507388
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RSzNUSs2EjT2U8xgegIJDooqgLj5sbqIxrz14JPKQGs=; b=ntEd9RvDjN4kA8N6
	uAJtro9+o3xPly58+WciEpsiI9Ejuy02CWQM2JMk3HggtrtB0hO3Y3mruFv+eo0f
	dQHrDbFhpqJfdxEd4ELhKIvXSFfRPqygT9T7HttOx8IHq9a4XQ6tBV/QG36yf/DN
	wZBxFsdiO1ElJBrmP7zCqfRfHDEnRTPRLBTFRPM4RLRzC8ycn6iowF3vg3OuEAQ/
	K3+Ro1624xLwQitw7Wg5qChjchCur1XLMJdvSQ8OdcClPW3VyQrwrCLkwA2xJlva
	+dljYapJF+3UULpLVvQBJAcK8Wp58Pg2lt1jvYrwSPxB3UdrkF/lBkUIht8aeu4c
	yJaSQQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8ga4n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:11:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848860def2cso2299020b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783926665; x=1784531465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSzNUSs2EjT2U8xgegIJDooqgLj5sbqIxrz14JPKQGs=;
        b=eFq2E2r/APy1+FR2VtgqfxKdS33oOSbi14+fTn06HmjJE9HKsGTeVPIAy8hkBL6ojW
         msG+Jl+qB0jVk3UjoXphBwDlrtHHMarg0+O9UGh2Dk6VFSPiIvP3pwSavEuhZSOlGPWt
         gCqj3gRJ98g27fZUjglqsF+K1FX9JLH3X/8RDGt/Q53ZxiE9E/Oqh7UbZCu2C4jQkQkQ
         OVILhS8zUWt5nks11Q/EANaNL9S3TP6nmRsvc8Zv0/d74x/R4neZHV8Ae9vEXey28YEg
         96KdEFG0AindEph/1gFOi8cAS5SSfeUpd3QhRaqgZdLdekM1MvU+EM/rqZ46t8NT2vsY
         QjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783926665; x=1784531465;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSzNUSs2EjT2U8xgegIJDooqgLj5sbqIxrz14JPKQGs=;
        b=FpEBSiEguTlA06g1OrumMaDhrt9rIRb1r6nJ6VPqqcHDIKKZ+wlxrqtzc5wNH6VaiC
         djCUVf/2hFMDIFkT+ysMzcrHXKYirf5EdkwWKAeGcKJCK1HdE2rvQG20TIKGv7PzMWSy
         xsuX0KdRFj2G/39s8TPjpfXP92DV1YOi6X2TMiYlKMRR/rXiVFrmUi32BwzdY63zGIRG
         0sYEqPgJ2wtKuT6Cx5GeNci0NfX0apOAcs3ZaUxWPQRtQUhcwzY4lTQ737ebodKbQPD5
         9r1q6PHnlqFfFSfCbQ3pG8j4sd/b9qldbNWA9DLxUENZ7nGk1xE3nsj881NqApTkvoYo
         9/EQ==
X-Gm-Message-State: AOJu0Yw2st1fvKf3jJpcCSuXEgupPUZg8KUCt08W6im8HEC/5GDNHN7x
	1iSIWLCQqYxxqcubE4P2v3CwEiT0znvmJikEzQM+7pBVFEdV8g1Vx+LK7VWW5s/4DmR55y03Ixw
	80+L7x0AFn9PM8wvgnaeYip/Lfp8fU9R2VIuHH06JuCm60iGH/rPcMbiF8c6nadZxUqLHXA==
X-Gm-Gg: AfdE7cmua/gXbrmUuGkHHuH92Nsh9n06tOZzT5XwbhBdwyvC50Qf5zu42eoiGrKTknX
	MG+UDZXKXNL+i3nPN6QLMSV3S94c/vhzA8Lcl7mwel10BB19/cLNagbCmtMAUkJeUXe37B0bTm/
	5vUZreorWoHaoXMdl8a/Gx0I6kQd+mhtCrfhjitMxZo4GYVUtK2CemHItqnkEf1YbNIdtZCUa1x
	u1AVv5GqlyZ7HwsosDG1gDLYCm2L0XJDMl5HQI8sKuZqqOKqdBL+KTy03TCROt8N5ixJ/ha7QQu
	oqrg/4QRav8Zva2SvHAzpzy5vlWpiAvX9YG2KgDkaLg9jARKRgvOsPaBMhuFHBAkBptpSOdQwoS
	5tZEKHXOq8nlsYpAnhnyFiLdmHaW7bbdPewES6cZdE8ahWh0cNh0=
X-Received: by 2002:a05:6a21:6e0c:b0:38d:fad1:cf2a with SMTP id adf61e73a8af0-3c11062f6f4mr8616671637.13.1783926665017;
        Mon, 13 Jul 2026 00:11:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e0c:b0:38d:fad1:cf2a with SMTP id adf61e73a8af0-3c11062f6f4mr8616647637.13.1783926664519;
        Mon, 13 Jul 2026 00:11:04 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c865asm72740326c88.11.2026.07.13.00.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 00:11:04 -0700 (PDT)
Message-ID: <c6dee88c-9c0e-47fe-8c73-c462a7613451@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:41:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: cap out-of-range rx MCS instead of
 leaving bogus rate
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260701-ath11k-invalid-he-mcs-v1-1-7d963080c079@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260701-ath11k-invalid-he-mcs-v1-1-7d963080c079@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gkydZkl-lzyvEAmPnX2iM76Ihaw49Bc8
X-Proofpoint-ORIG-GUID: gkydZkl-lzyvEAmPnX2iM76Ihaw49Bc8
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a548f89 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=WYK7N4G5aUrBRle6tyUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3MiBTYWx0ZWRfXxufX/bMHb1r5
 IVPNmV0ejQ9ZgwiQRzV20403g9XpZ3950Ruh9QseO3KntGa0k6fntpD9o+dVbr+FdMC4nWi97LU
 MotaaHfby20+h/w2t+U1lsgRCfc8W4w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3MiBTYWx0ZWRfX5Mo5NbfvjyI2
 VG4om3JMd4idfpTNdXwxlmx0W1aYAoaJlHUHbb0TybUzqfQaLLknq90fTR8byIzDcgx/CY5t/36
 yMPgfXj7YU7HiUiALBSYgj8vi/ZOhLk+5/WvjzMUftbzjzoIapZeuNIKgSBlFH0wYDdmVJtKrn8
 QjnVk3zB5paYsyz8OxhzHcMDZ2BvgtHCbbGFO/eKcacbzTkLh9DeLt8y6fMobak4ZH9asNTWzHz
 5+mwMyZFqsRdQOQT8bT/nm2hk/vAEIBCuuS3UN7c6uxG0xGEREIv9vRrY1mzCua2wb70NjzukbR
 0V8+UE2oK4oXoz90qhBP+VWI5Qi00i96fFkwtrl3iiq0DzW9yHXroBgdxuMk87lO43Zv3YlmQjG
 Zb4+/exqjVltjYafYmQh8h7OLV34riKrV8vg5WwmEOhJH1PEtDp/d8LlXJLl3s3qLpJL9u9SX3T
 G0vW3U+/7xbZvTVq1FQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130072
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38942-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86195747D72

On 7/1/2026 7:19 AM, Baochen Qiang wrote:
> ath11k can receive HT/VHT/HE frames whose reported MCS is above the
> maximum that can be expressed in the corresponding mac80211 rate space
> (e.g. an HE frame reported with MCS 12, while HE tops out at MCS 11).
> 
> The frame itself is valid and decodes correctly, but for such a frame
> ath11k_dp_rx_h_rate() leaves rx_status->rate_idx set to the out-of-range
> value and never assigns rx_status->encoding, so it stays RX_ENC_LEGACY
> from the ath11k_dp_rx_h_ppdu() initialization. Once that frame reaches
> mac80211 it trips the rate sanity check and the frame is dropped with a
> splat:
> 
>    ath11k_pci 0000:03:00.0: Received with invalid mcs in HE mode 12
>    WARNING: CPU: 0 PID: 0 at net/mac80211/rx.c:5433 ieee80211_rx_list+0xb0a/0xe90 [mac80211]
> 
> Dropping the frame would discard otherwise valid data, so instead cap the
> reported MCS to the maximum the rate space can express and deliver the
> frame. Set rx_status->encoding before the range check and assign rate_idx
> from the capped value, so a frame with an out-of-range MCS no longer
> leaves partial or bogus rate metadata behind. Also downgrade the logging
> level since they are not treated as invalid frames now. The only loss is
> that such a frame is reported as the capped MCS in the rx rate statistics.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

