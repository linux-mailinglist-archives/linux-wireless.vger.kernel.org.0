Return-Path: <linux-wireless+bounces-37968-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DydnKAj/OGqWlAcAu9opvQ
	(envelope-from <linux-wireless+bounces-37968-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 11:23:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE28B6AE2BC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 11:23:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=UHbs9GGV;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UMgjJHWE;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37968-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37968-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E6233012247
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D55368D5A;
	Mon, 22 Jun 2026 09:11:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3336923F
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 09:11:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119470; cv=pass; b=oFQ/jCyohoPz/S8pp9COAWAD7P/YCCF9iy65Dp+fuX+TA/KkbLdIEBaQtA+upS0++lAPyBeOmiQIgE5fEVMq94sHDbnpWFmuFDFxTVO7Up/Rf/3f28/0uv+5zX+AVVvoa5aZciLrKjcrUzGu7N5UhWfAIWckb+tNtt6elblA630=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119470; c=relaxed/simple;
	bh=rbC8uCyeb4N07lYWfmL8pDIopX4mDTIIwupeRrWW52c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSiCM7b1Q2XK42SjWkuYOMH+AUo7w85e+LWkrvwfZtmyTM6h6rckV2LDZj/kz3JFPqJVgHLB6v00M/jVYkaj2XL4zUCk7GIX8aYmWNz4yVySBsukCj7qDruRCfMbBeXyfWkraYTMJUfwIRLbIP5l6gnmkmnDxbm1sZSqiiycz4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UHbs9GGV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UMgjJHWE; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59AsY3786541
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 09:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YaOsRs0LRou+mLeHSOKGCppMhfgA6DLd02/UT5IRX1c=; b=UHbs9GGVRULviA+Y
	cTvRQaJ+3zSJ3yQP1fdXSf6B4MN2cdqiv5l19AVnxDvZ/IomcVYHLs5s/w639jWx
	adS2C+EBkgEdnP3fEfVi/0BAPPkGgnGqFn+libD4ZVaiZJkB2D3fpumYop7nDZe4
	Scq+hpyo1SkfzQX5D22vGVEAjOkwijzXlJIYH/p6uHLi9ho4bI08dJT5VQJR3yuK
	xJW7njtAEegeqkvLgZ4SDerqRCEGpoDGShndkrNbcTXChwRj2WjiBAL5YWB4KBRq
	vfr4RKLbbHTW3EQmOOP/nxTUQHW2wUNLAeG3useBZESwqf9EtNFeZlXg2sADqtnH
	E4jdVw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewkmedmgu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 09:11:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1399a989312so345508c88.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 02:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782119467; cv=none;
        d=google.com; s=arc-20240605;
        b=BEHXmUDbQlWygewtBU8LyBuvl4u0K88/NEJjVDdclUgkKE6HRiwC0KOuuNIb+ecbJi
         CanxT3YcPSSP08v/efGE0Oek9NdzZthG7/eHVJPe8MQjX3IRGa7YSZQ9C5Ik0kYUwERA
         w2+83tmO4JAb/YfmMhFr/QQrrvfVc/1pfUJd4XtJEHqNFYm5kLNEwlaOkg1+yDGjUeEX
         BHsbVaQ4nFJNtqLaTew0nxyOZHGJ8w5ZRYRJVZtnCQmhxWv7ofgg8HthvUn0mF5sqPXZ
         XiLBA3VgDTwiLg0DpIWp4HgF0AWc6k1xDbU8u9pkppcNHWuqU9Ml/0227XeVT9uzEyBB
         e3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YaOsRs0LRou+mLeHSOKGCppMhfgA6DLd02/UT5IRX1c=;
        fh=2yRhjbMbAryW519VYJ5MRTy+ljCvm28XJWljCR+CXnY=;
        b=DaeqLURqYXH7ccN11P8bsknD1lIjQdhzDFDyFZf1CN1at1+n0j/2LvJS0bwvy3M51r
         UF7+YEFViS+anj80rjI/SiJIc8mUDfqwrtPAmQZ5fd14Unq9eOHboK1FCLLvGfWX8lau
         egn9J8qRKvXG9kiaWlbiEyZixnzW0OV9GKC2NLirqFpoZQbfodIiwi4a5QGcpVpBmMoK
         NYN6sZPq4YeeCJ/sGaX88b7JSSjdX2vA6Qx8l8H8Lv5cuyyg6G4DYm76tKjJJJzSDtJw
         DTuzOsczCkzBf1BCBS0FByn39R7oBps53s2uOE9oJiH0/5E3Cmx1NB7K2qmpbtDHmVbg
         Fj+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782119467; x=1782724267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaOsRs0LRou+mLeHSOKGCppMhfgA6DLd02/UT5IRX1c=;
        b=UMgjJHWERJfqRoPaPO3lHCExZ/G7rn9f2QQSjEyTZMMYxuOhVYv7lCtjcIHRa4hFgu
         cDV7sduh8ymoQynZ9BQxckrkcNwtrT4QoRKa9JnLCX1lMZsLJGO3S6dQSJd/+CGC6e/J
         9ll/ovu8hvf3ZSWcranWDrbKCEAiivdP+wokq60XcIQTJ7AmzcfeCR9i46cyIW0ReTzp
         mrjCwmWTVOG+yMlZRarWIft2Oc6eRyMMwLgYwPgA8lBbIBF+jk/eH8GiwcS2sZ9geZER
         KuBqBUunHYoQRfH108V2CsexnsP+q9YQrsndrvvTSflfYKuuKtgkADjUsy5chqdVR7SM
         CULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782119467; x=1782724267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YaOsRs0LRou+mLeHSOKGCppMhfgA6DLd02/UT5IRX1c=;
        b=n1OnEkcz44xqsBI5SLqdUl0GG4KEIPGxzKhIwwC3UwN/kj/pRAhVM2sUBjKMxGIfT+
         wXpQrkDXyFr0aHSsOPLszku2b3hLFa17+AI49OIBj8C7xRv7RydII71ABI19QUNxDqMT
         llCkBs6+1eFAojgkyxhZ/2hndUnAKkS0KbMStJe9e6beFzgJiHZIJyhuj7+MSLxHwjrs
         zCfJpee/GTxGIjXtJVINNYGpAbTnhyzv6uyS/gFYAZKfLSAHZne5JIPux40ScRpWUTeo
         k07rb1+iZzawPK70XjKlsjwqtnBEXee2aSV0Va9t0XhQuhNfoUED2D/91EAZ3I9LGDP5
         88Sw==
X-Forwarded-Encrypted: i=1; AHgh+RpgJriYiAg46eOjabUVIvsSgn1ng4N4HXE0x/Xp9smCVjIS8QwzdMR4vUYfEnmgpDd+Ujp+cUm/BIgXvR8Q0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8G8/+tMnw5IdIn2RgJm3rYwykLZ1xDxEoXIdMrel4aCllIXNd
	rTKDhu1x2RQCu/OwboKY9yEgAxZGlvmznnpNWoCdKzwZE6dz1PXN7pczsrwAzzkBuy24F1WulFs
	MrYvJD1OHtlrFiPJEcLLQZ9pAKZq2ukrOp3ruyTT/tr5wTcYuit0YWxpArNfLiwuHMnfTgUNsKh
	pvrag8szfZYR0Vr7oGJKz8PAsXPI8ZiNQNNs3S5IiWr2AwIvqoEjctxBE=
X-Gm-Gg: AfdE7ckX9y6RnXBxpUZRDsa9Rf5YFGhNtXMM96HWl7GI1el+DSRYGkp6gyA4r4XAsZD
	ifWEFdxEa5qGBWpYnuy5vkusZrU0d48Gp5Ewd/wIY65/eGR717Z8T2HN4YdL2h5ngC8OL03j8Br
	a55E9xB6wW8z5I3ITVECwFcYuBzGYMCuqat7xy974eO74ndWjpGCvzaVbVYgGodbdD6m4/2vbdH
	AqAO26oylNvJXrVAmFDhivsSSbn
X-Received: by 2002:a05:7300:e619:b0:30b:d2f5:d503 with SMTP id 5a478bee46e88-30c0750d8fdmr4098288eec.7.1782119467079;
        Mon, 22 Jun 2026 02:11:07 -0700 (PDT)
X-Received: by 2002:a05:7300:e619:b0:30b:d2f5:d503 with SMTP id
 5a478bee46e88-30c0750d8fdmr4098282eec.7.1782119466526; Mon, 22 Jun 2026
 02:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619120751.363340-1-aishwarya.r@oss.qualcomm.com>
In-Reply-To: <20260619120751.363340-1-aishwarya.r@oss.qualcomm.com>
From: Tamizh Raja <tamizh.raja@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 14:40:54 +0530
X-Gm-Features: AVVi8Ce17OEu23lhhI2Od_riIPTL7ct0BldPdVY0gOJHeCcYTmGonWOJyQsiEPY
Message-ID: <CABkEBKYmknpO09Yc_hM0XM2ck3F8zjmgCuyBo96usXtgkGeo_g@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: reset REOQ LUT addresses before
 firmware stop
To: Aishwarya R <aishwarya.r@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <praneesh.p@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA5MCBTYWx0ZWRfXxyekPmZlcF3P
 l//q3mBIOAuLPnU5ODqqLagT9qYhvwhh2NsN/xn/bRwXQ8I+kcSEMLn5zYiymQHmckxMZAztr0u
 bkj259+c7cq2A7aWZ9gcYSMaoA9f68ID2oNoYgkNJV94K8WTZhmzx4/ikYJYNfnUkQAMD5bZ9xt
 B1EbpaNYxaNA9WKweoTwmTIB9Pg4Xo1ejjyYZTEa58wE9gjqeApbKOOLEooa79FsrpRF+RvUG50
 HPabjc9YaJZZFgmNUuCiZ1ieTgQIJUv2YokrCdO34uHvV54g9FBtYYEvsfsG8XDOvk6lO2wAxzQ
 EdKDk6S6b63hVLPNME5pRRdqT55rAnLylfHBjNzltsdh+GdS49QR0NPtqpkI0DvL8BhOCP8QVXc
 /EZw+1LYytreYWqilT1u4YJtJ7CnKxFui1tvONOfcr0P7UWLEHq/x91KmMaiePUtB8q7G7tMHNy
 76p+xLwqAf3PrUknhBQ==
X-Authority-Analysis: v=2.4 cv=MtFiLWae c=1 sm=1 tr=0 ts=6a38fc2b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=cLK05Zz3rd6hSRXFw-QA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: h3-B2LHw_Ez0Lq5iFhRbmXQ7h2W964CD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA5MCBTYWx0ZWRfX81MgUI/krvEk
 9CCw8H3lYVWzLr6XgPh5JGrX5a7yLdnUFHwcYaMlrUvQHfaQ0Lv4ZyppWPGfcGd6uHfFjYqcWAE
 kHrhebZikkedgt3CQofZyM3fJ80YvxE=
X-Proofpoint-ORIG-GUID: h3-B2LHw_Ez0Lq5iFhRbmXQ7h2W964CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220090
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37968-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aishwarya.r@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE28B6AE2BC

On Fri, Jun 19, 2026 at 5:38=E2=80=AFPM Aishwarya R
<aishwarya.r@oss.qualcomm.com> wrote:
>
> During module removal, REOQ LUT cleanup writes 0 to the REOQ/ML-REOQ
> LUT address registers. That cleanup runs from ath12k_core_stop(),
> after ath12k_qmi_firmware_stop() has already stopped the
> firmware (mode OFF), so the register writes can hit an invalid target
> access.
>
> Move the REOQ LUT register reset before ath12k_qmi_firmware_stop(),
> so the registers are cleared before stopping the firmware,
> while register access is still valid.
>
> Additionally, handle the error path where firmware-ready setup fails
> after LUT programming but before core_stop() is reached, ensuring the
> registers are properly reset in that case as well.
>
> On the crash-recovery path, ath12k_core_reconfigure_on_crash() calls
> ath12k_core_qmi_firmware_ready(), which re-enters ath12k_dp_setup()
> and ath12k_dp_reoq_lut_setup(), so the LUT registers are reprogrammed
> before use and stale values do not persist across recovery.
>
> There is a brief window between the crash and when the LUT registers
> are reprogrammed during recovery, during which the registers still hold
> the freed DMA memory addresses. This is safe because the device is
> non-functional in that window and will not initiate any DMA access
> until firmware is restarted and the registers are reprogrammed.
>
> No functional issue has been observed so far due to this sequence.
> However, this change proactively avoids potential issues such as
> invalid register accesses after firmware stop during module
> removal and error handling.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
>
> Co-developed-by: P Praneesh <praneesh.p@oss.qualcomm.com>
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c |  5 ++++-
>  drivers/net/wireless/ath/ath12k/dp.c   | 14 ++++++++++++--
>  drivers/net/wireless/ath/ath12k/dp.h   |  1 +
>  3 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireles=
s/ath/ath12k/core.c
> index 742d4fd1b598..efe37dc91afd 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -708,8 +708,10 @@ static void ath12k_core_stop(struct ath12k_base *ab)
>
>         ath12k_core_to_group_ref_put(ab);
>
> -       if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
> +       if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags)) {
> +               ath12k_dp_reoq_lut_addr_reset(ath12k_ab_to_dp(ab));
>                 ath12k_qmi_firmware_stop(ab);
> +       }
>
>         ath12k_acpi_stop(ab);
>
> @@ -1371,6 +1373,7 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_ba=
se *ab)
>         goto exit;
>
>  err_deinit:
> +       ath12k_dp_reoq_lut_addr_reset(ath12k_ab_to_dp(ab));
>         ath12k_dp_cmn_device_deinit(ath12k_ab_to_dp(ab));
>         mutex_unlock(&ab->core_lock);
>         mutex_unlock(&ag->mutex);
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/=
ath/ath12k/dp.c
> index af5f11fc1d84..fbc0788b37a0 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -1097,7 +1097,6 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12=
k_base *ab)
>                 return;
>
>         if (dp->reoq_lut.vaddr_unaligned) {
> -               ath12k_hal_write_reoq_lut_addr(ab, 0);
>                 dma_free_coherent(ab->dev, dp->reoq_lut.size,
>                                   dp->reoq_lut.vaddr_unaligned,
>                                   dp->reoq_lut.paddr_unaligned);
> @@ -1105,7 +1104,6 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12=
k_base *ab)
>         }
>
>         if (dp->ml_reoq_lut.vaddr_unaligned) {
> -               ath12k_hal_write_ml_reoq_lut_addr(ab, 0);
>                 dma_free_coherent(ab->dev, dp->ml_reoq_lut.size,
>                                   dp->ml_reoq_lut.vaddr_unaligned,
>                                   dp->ml_reoq_lut.paddr_unaligned);
> @@ -1568,6 +1566,7 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
>         ath12k_dp_rx_free(ab);
>
>  fail_cmn_reoq_cleanup:
> +       ath12k_dp_reoq_lut_addr_reset(dp);
>         ath12k_dp_reoq_lut_cleanup(ab);
>
>  fail_cmn_srng_cleanup:
> @@ -1627,3 +1626,14 @@ void ath12k_dp_cmn_hw_group_assign(struct ath12k_d=
p *dp,
>         dp->device_id =3D ab->device_id;
>         dp_hw_grp->dp[dp->device_id] =3D dp;
>  }
> +
> +void ath12k_dp_reoq_lut_addr_reset(struct ath12k_dp *dp)
> +{
> +       struct ath12k_base *ab =3D dp->ab;
> +
> +       if (dp->reoq_lut.vaddr_unaligned)
> +               ath12k_hal_write_reoq_lut_addr(ab, 0);
> +
> +       if (dp->ml_reoq_lut.vaddr_unaligned)
> +               ath12k_hal_write_ml_reoq_lut_addr(ab, 0);
> +}
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/=
ath/ath12k/dp.h
> index f8cfc7bb29dd..9b39146e65e1 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -701,4 +701,5 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(str=
uct ath12k_dp *dp,
>                                                   u32 cookie);
>  struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_dp *dp,
>                                                   u32 desc_id);
> +void ath12k_dp_reoq_lut_addr_reset(struct ath12k_dp *dp);
>  #endif
>
> base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
> --
> 2.34.1
>
>
Reviewed-by:Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

