Return-Path: <linux-wireless+bounces-37236-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePkdDBYlHWq6VwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37236-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 08:22:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3327561A1B5
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 08:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3EEB3009827
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 06:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A8B3368B6;
	Mon,  1 Jun 2026 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BkWyl2ZI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/pgLppI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A5263F34
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294708; cv=pass; b=Pa/HQuJ19vCrpIeK+2GYfSA6vrUmcCamw6NQAqFUXroJlN182gB8t3Belu7G9EigtWK+K4sBcQACLoqBWdlhKGXLMR5rVctoMWKyQCZPBh5mmAQq6xzmLae/0ad5UfudFxbmQrVeaUS5/HwtnxeqI6E9zgatFTtHKrapb/m7gik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294708; c=relaxed/simple;
	bh=7T1ENuv1LXQPf6DPR3m2gYWEJhzYKjNA5XV4EEj8dik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4t2AU2fmxkEw8tTTtsShZ4bcP40ACQysf/rZy6fbpszLhkSMXkpx4zir+zvTInUoiig0mCEbFq8GdtFmH8d5TFUZ/RK79yQj6rCMxsrTeg88z26ciXBf+xOhxtRFc8rKO8utmQA830dozLafAqpLBTEI95khZvNh8Jg/OdzpOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BkWyl2ZI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/pgLppI; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6512EYEG4187116
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 06:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qvyog2xv0x9HgcgrlPWRyztS6BlXbzPPs8Gk8UNZeaQ=; b=BkWyl2ZITRH6LyOA
	IL5o8zucdGlBako0aKAnKPy08Eknm+bFBSBETkNCrxS4S1UzxX8zrX0xLdbfSLR6
	Y87On6OwWxr4ubyWhmuKmHJBm/ntWMuwk43UDL5Lvy1Qdec9bqdawy5X6h4fS3lG
	ZCea9h7BUAPLzHe4LFEAswS87+vpZ/q79D67aqSfQAlaQbMBeaYvtDpxT/BZFI1F
	CLJCKnNrHmr3VwiGjoQACYfdFKw52SMM7kCt72CDJAt1+qON6S1TjbDuY4gKJybl
	pkD5hxXyuL0gfPFxMeiR7NluqW84UT4Zwkvpex5cox+B/2nnyLtJkJO2AAyJW437
	ze5gdw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efs66wtv5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 06:18:26 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-137daa666a6so155928c88.3
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 23:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780294706; cv=none;
        d=google.com; s=arc-20240605;
        b=dbiw3xxz33wp4S+0b0/NTijh3uPGkngQaXjWMBo/TEt6Kpi+tar8D52jn6rqi0eyTM
         jMTORVLzoTwXSKdd1V7lhqf/ysROkL5H6VTdB3DaFbNTe95mTshQnKPDIdxm+4Lck6wD
         rtapyaGkZ/m4i/ymepKA0K7t55PhtbsRZ3fWAt9WKXdsGaGLViwty0GxlRLRflmu5fXJ
         Ho8k2lQIsI2Tih02uUeHz+wGjR0STDISD/RUWfcVvbcqwTnUH8Og5Q9NFIq6az2p1Sky
         VBMWpVoNhkAvKy/xktMxjv8sF5jtSzBW/MpcGk3qSR97XO5/yQdgwwNwIpdfGGbAju4l
         CItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qvyog2xv0x9HgcgrlPWRyztS6BlXbzPPs8Gk8UNZeaQ=;
        fh=KREI/9Tm4Doy9y4Xg1vAUHSmNpEzfkGCDxU2MSzih4Y=;
        b=B8rZqwOBt2LkHRV5rebHzPO8hl1LTF2s4SzUzeuG2M1NBeQMtfiQYC/APYoYFMNLgq
         OcC2S2LQweE1mYc9AFq+LpckEf9Iv6CoEHwWodiiv2nnR778OSVkwvB2ksFWdZ+aJXrm
         oqhj/ClO7zRKVUapQ1tyT2E2hCZjdsABkjSxWLscxCAjW+6ud6NRJ/4Cco0c1ixRwY5P
         KdfN9yKwNUTkI0n3br6mmpViSrvL7DplwB6Qi/A6LlMDQVOSNbX12p+qSgQ3zaYt88SG
         HR1ZeiDfgsMOmhwVoOeEqEk7nzThR8dYfAxsnEBztdUGPyg4uObcnAJ1YmREru013z2y
         G9mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780294706; x=1780899506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qvyog2xv0x9HgcgrlPWRyztS6BlXbzPPs8Gk8UNZeaQ=;
        b=W/pgLppILJUCQPyeS6jBV3xnSovX5ffHDSADwxJPfIjF816urKQmOGYV7yuB7nkXQC
         5ILFS+9ej/LFVtkpWcloyoZD1tjhAll9x4yKPZDZcPC603ASw2Uvw3CN6cTp1lmAQhBA
         fX7BLkY8cegUNcVYuqo/OW4F/MbLqGOjmi0L3QlOOyVnqpVIz20bJmsPeAk3Qc8TXwl6
         914T8IwAzO6Yg47p9aPcaiYlAR3z4YIBb3a+JkUPXs4UWo0QHwxeFMXTFCFXaWxJ3SGx
         o1fAPslHNmsK7j3tZm6Pke+f/hjF9syJgppir0ks6/fgbGvhqwGjqNejF2vqX1NtETgF
         ij2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294706; x=1780899506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qvyog2xv0x9HgcgrlPWRyztS6BlXbzPPs8Gk8UNZeaQ=;
        b=gzViqUenHvK+4gzFEZzH2ycLWm3WJfiebENMJcFy0RZL8eQNteOrR+v+bjrdT4thPg
         SyJ9FXX6ufTKGpelbwVzDj5xFGS3kN3n8TNeMLIRyetR8MPlrWM3fwbVJW65VEqpjS0v
         qacvw7tVde7BW29n60OGlQ+Pensdos/dlrAijzVP2Wf58xGgNE+Q1Jm6Z3h9jo+6yY84
         lWLdfFU1ZWIOk1aleiqk6gF8g0nPIWyAiVWFA32MYUBRHpZFxNrjeVYVBOr5WMkUfAci
         g6KYQgQth5vyIcNa6Ve9dlOs+4P9NzaXvf0lTY11a4ej58L8Q9f9EKOFoE2RTGRgJc1C
         iFhA==
X-Forwarded-Encrypted: i=1; AFNElJ8S+ceS7lDXLp3ydXbBfPFJKf9gI6m0faePhylYVw4fBrvjFPhlu/OnbINYoxhQpI39HxMHMZZkoQosduYhtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwIQ13XpW1GNs6Wm+lFlLlvwuNId8UUQ8IBhV632yQIYLpzQz
	WOkeBhpLgE+JdPM6HAZeBJ/T7PwbwkeXpL8ccFc892n5oZDFMzKHhbG+wELayan+ikM4bWGqqxO
	JQfPGc8V+blFo1S4cIICvPIcXnmrdgFiOm4kEScH5Y60rG9Qz6ic1w1QbT9rT6S1v8IyFPcikP8
	Gf2YSnl3VRCkYuEjTVmGlu+X+zLh5CTb0sKszKYd5iEy4P
X-Gm-Gg: Acq92OGizetvL6A/ohRZ0HGPJT08kOj4GZWzYafVTZtnBKqb/tpz+AAgxGuipxCWaR9
	V4wDKSrXpxbEwp8pj4slVK1eckDzYo/dcjpyp10x7wb7TdTICUA1huRECB7MDM7FFvdHKAdUx0y
	XgIoELcK4RTpVhYKs4mYAwoRt0vB22tLxmIaSh1TZ6Uti4k1HkicmMKMRpS04/Emuw5MzTvsxrq
	oeJynIq3l17l4qRcJpvoZa6ULDqcT1GoBf8we7rTE9F+WrUr+I=
X-Received: by 2002:a05:7301:100a:b0:304:e865:f7da with SMTP id 5a478bee46e88-304fa6e6dc3mr1804587eec.7.1780294705796;
        Sun, 31 May 2026 23:18:25 -0700 (PDT)
X-Received: by 2002:a05:7301:100a:b0:304:e865:f7da with SMTP id
 5a478bee46e88-304fa6e6dc3mr1804576eec.7.1780294705272; Sun, 31 May 2026
 23:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512021108.2031651-1-miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <20260512021108.2031651-1-miaoqing.pan@oss.qualcomm.com>
From: Tamizh Raja <tamizh.raja@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 11:48:13 +0530
X-Gm-Features: AVHnY4KiU0ErHvWRPfRQiRNS-2Qoq90Pk8G7CKi42DNA3IBzX7PmwvcS2nXeZng
Message-ID: <CABkEBKaMYYVCfFSy7xQ9oN_OCq1mJpqB1ruwO5imePrmwQ8MEA@mail.gmail.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h_verify_tkip_mic()
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: jjohnson@kernel.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA2MSBTYWx0ZWRfX4V/Nvjdie3Go
 j98vIWmEik0OTV0qhIurwk+jDfTQL8I6MVGh9w9dde27etMm1DUIfGFBnDT9GWklAX/fyfyHOgw
 8SLFAWxqz/o7ujEYZ6yM+sdnRpzQrDOYWF46sshCr8FKnKWO4Posu5xBuSUuWY9F2pXqCctQSJx
 t2gDSjl7BfW71MJvZYOZeKgtEor79YRpesiffenHYeIGlLu2iVNr9ruq5UGzjg67HJzzLFd1cNL
 mokqF6CbVIIFw82kDCRswICLo+0JikISRQTzFonAnVR2/rzzRKNAgk0/k2fOrG/M8yagTzN+3Ja
 Gn3F/D7qTj95/DScVNtAwhgENEe3U/lwvDhEQj8dppiqcaMfnc842CrYPSMZRwhRFusWOTTa7/0
 gB+W7HsEpv/S4+e4bnRG5Xz3e49Nf6Y7h0Tcd7P9YooNk3x05ApnR6QKC+SB1EHmuAPhc9xxvl8
 42/VIO32emQW7F7DgHw==
X-Authority-Analysis: v=2.4 cv=X8di7mTe c=1 sm=1 tr=0 ts=6a1d2432 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=3WkuQKjiOEFfKZUmQP4A:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: pApm8U7jTLR0YLATzfXZDF_eGT3pxE3h
X-Proofpoint-GUID: pApm8U7jTLR0YLATzfXZDF_eGT3pxE3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010061
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37236-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3327561A1B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 7:41=E2=80=AFAM Miaoqing Pan
<miaoqing.pan@oss.qualcomm.com> wrote:
>
> In ath12k_wifi7_dp_rx_h_verify_tkip_mic(), the call to
> ath12k_dp_rx_check_nwifi_hdr_len_valid() may return false when the
> NWIFI header length is invalid, causing the function to abort early with
> -EINVAL.
>
> When this happens, the error propagates to
> ath12k_wifi7_dp_rx_h_defrag(), which clears first_frag by setting it
> to NULL. As a result, the corresponding MSDU is no longer referenced
> by the defragmentation path and is never freed.
>
> This leads to a memory leak for the affected MSDU on this error path.
> Proper cleanup is required to ensure the MSDU is released when header
> validation fails during TKIP MIC verification.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_S=
ILICONZ-1.115823.3
>
> Fixes: 9a0dddfb30f1 ("wifi: ath12k: Fix invalid data access in ath12k_dp_=
rx_h_undecap_nwifi")
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/=
wireless/ath/ath12k/wifi7/dp_rx.c
> index 945680b3ebdf..a5e290edaa89 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
> @@ -1028,8 +1028,10 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(st=
ruct ath12k_pdev_dp *dp_pdev,
>         skb_pull(msdu, hal_rx_desc_sz);
>
>         if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu,
> -                                                            rx_info)))
> +                                                            rx_info))) {
> +               dev_kfree_skb_any(msdu);
>                 return -EINVAL;
> +       }
>
>         ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
>         ath12k_dp_rx_h_undecap(dp_pdev, msdu, HAL_ENCRYPT_TYPE_TKIP_MIC, =
true,
> --
> 2.34.1
>
>
Reviewed-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

