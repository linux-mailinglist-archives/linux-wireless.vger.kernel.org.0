Return-Path: <linux-wireless+bounces-31242-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AGjCqkFeWk3ugEAu9opvQ
	(envelope-from <linux-wireless+bounces-31242-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 19:36:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9426B992B7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 19:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 823E6300D9E5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41EC2EA159;
	Tue, 27 Jan 2026 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcl/VH3H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hidD5fGp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D1326D75
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538982; cv=none; b=RiCbixpQ8WlFyJJHjAbjCL/Mu+IZ5hMUn3VbyvFlEJlp78zxmxeTfQF61ENRiffziBhMCd0w9gLxKAid3aTu1HC2LSIWJuY6wBgqhr45RU4273Bf4EAxuA1xrKK4pE5F8CjatoRLLjdQEVTebfaN0ByutcwFDyTnp14Kkp/b1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538982; c=relaxed/simple;
	bh=X5SOMit6xW/CG5wYI7n/539icYs06erCcCB+H1Vf9mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiIT02Msr/PCvIXuU0DdVQpGuiBqNIbBdAd87JwM1+6/VOTCuOtpFUlgx8Xj+7A7KBKreRQ+A/IxEqB7RFsTW+3b4aEvaQcYBrgn2r1DYl0fQokEEUWmlPufzQ0CkuD9rt7ZjsAjZcmQ4RTPvJnv/MnvVYuAzk8NjNuT3obrhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcl/VH3H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hidD5fGp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RHhbWa1952851
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ixa2UGNOFQZl7W2RGTX0PTpp
	eOqrnnMpuO5g8Z9i7aM=; b=fcl/VH3HO+yP94XAfGovsWpacnxdbhM9txSHE4yC
	9goskpflG6mtq3dkXu18L2niM28yWp4YfCHMktg3PcvCjYDFlB3r26lykEscqVJS
	+gmwNXcIPSnFe11tvCEMqR9ulpD/f4/kaIJIS/ymZh1EL6tpt3iijR54o1p5NVOx
	4QmwJd3+vZ1rLTxeYk4Yt3jYQuC6G27WjmLU4DRHjuEjxWOC6Zi5XeMhN5mHdF9E
	XzhyRe9VAN6KkyADozZfiTMUvHq9sR7vu3L/ibvhTrK3jWuPyiwGFjGDPOmvLZZs
	moZwT7rD1jRxWYK49qRCh3OWywvBqzngqz4mwhVcphmolg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by211862h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:36:20 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-93f59bf206dso7666215241.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 10:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769538980; x=1770143780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixa2UGNOFQZl7W2RGTX0PTppeOqrnnMpuO5g8Z9i7aM=;
        b=hidD5fGpvQ3Ew3pndjh1BKSmo7J2ZriSp51b6FR0l09hKIiP42fIl1EzA+x/cHK8UK
         M8qrPXdhX5EOxGmCEBzFHZRPqBohSxr93XBTZQ2wcEvNsZvMHk0JsF2yKGAxmRWuMq/7
         tGrhE4L8NtoTi5k30g5YIlnISLPS5IknA6t4K1eSQoPDq8TJqtpwbDje+CMOYZ+g/PLk
         a/uQr6gvQpWzT3tDarFk3v1XAIhxjEsvI/z3KKZW+N2IObU5fQy2n6VP0K9ygyYuwpXy
         88EMQSGzxm5DHTXMy8zXEpnhqi2mH4MbJQw51JVRyxXbtGwus9CW8xp5q6FcFkH7ARrX
         5uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769538980; x=1770143780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ixa2UGNOFQZl7W2RGTX0PTppeOqrnnMpuO5g8Z9i7aM=;
        b=kdsVnENDDZr5rC4lqVOZjrOBrnadkg41gh2QvEuqMJKcDrNeyOqgycUk/RrslJzEOR
         C8Hb9NgIy5V0RmJBV+ZrklKkuSQn+6NrJQnXwT+R/eYUjfdiVEMBhbYNKntLUq9nMHxK
         /mS/JlLNHFsx8nxYB2Wr5gkEtF7Y3fz1hktqs9wdst9X/FuvUSA3llv3TyNnG9FtVTpx
         mYuvykNQ10G+Dqk5OuaMV9Vddpbc/N12UXNkFvzALCC+5fO0SX994qKsauvgY/kzvQsK
         p0V+W24soVBykfhkNRmzbS4iX807CpQ2R1YCj1OJyC14ysn6pI25s6W0RRx1fxa1PjLJ
         1OGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqFmy96ldqFHCM85PzUPVmGy9N/OPmG+R3uHfxluhOjPvFuvxbKFzS4BRAT+qH3bHDbw5liTrun3kD/exkGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBMQnlOHwQ4D5NYegVAFWmDA5pfE9kVJ3UWtcaLWhhHQEETgw
	ZAcxlo+tgtXS+X8di/n6GWxah9i9ROWr/66oaN4u8EL+gMmliv/kKPOFLgXb77QGaUhLW0MH7+X
	wznHEKrZSNld+TGcW/jZOZYkTfuQfoC5qGFqpfCF2M694QWmda0CcPeKSz02MMdD5u8XlUA==
X-Gm-Gg: AZuq6aLHAby0seP9W0XUY7uXn1I7DiHDCarcIH62qY9qc+ehCpdKzLPZjYPmFPjS9Uv
	bVVbNZdkZMtZL+y3nQB8S9fGWoiGtaqarrVKYNRIcF1VL2FgvvAkeR9xz0iUo4zCPAL6qnrHvxB
	NFeykoVGL2wrZpjq10dU/ehckD2/iZ9ARPn5W/K3p3mA7wjFHw1yLMjxEgCnJtAcG6iNS/GQl13
	Kx4MWbPNlfHrMQUyF+i2Kdg0K5pQOAb+4IjhZDHxSDBiny1udBdyjoAru568Jq+j95NtwPCbOvU
	0ULbROYmmI27KbMsXM2PD5R4DUOrVDCcbe75kCjyo49AiTNGStNJan6kDvFrJzw06aAZ5U5XcPc
	tR8RA1Xshg9nMtJu4JgXbf5ghlKC8SwQykdoHSAI/zvn3NkTjGyq+wLTNbC+LJVZxGEfzvOBX3l
	FehPIk/DWSzeFn63iI97XNrhU=
X-Received: by 2002:a05:6102:a47:b0:5e1:866c:4f8e with SMTP id ada2fe7eead31-5f723817ee1mr912474137.39.1769538979637;
        Tue, 27 Jan 2026 10:36:19 -0800 (PST)
X-Received: by 2002:a05:6102:a47:b0:5e1:866c:4f8e with SMTP id ada2fe7eead31-5f723817ee1mr912467137.39.1769538979095;
        Tue, 27 Jan 2026 10:36:19 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e07481b72sm98670e87.11.2026.01.27.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:36:18 -0800 (PST)
Date: Tue, 27 Jan 2026 20:36:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260127
Message-ID: <usrawtmodalbj4b4i22tk3hzgbrpt3gdbji4x7vfzdhp6qsb3g@rw2bl7jdnp22>
References: <6f1fa3be-e28e-4653-bbf6-b0b64b7e65b2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1fa3be-e28e-4653-bbf6-b0b64b7e65b2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MSBTYWx0ZWRfX/7CCVpNEc8sx
 CU9GrSUChFQMkLZLr7cpSWkMo/oMEgDfanfWFJg7gl7PaZaNUV89GrdbkH1g00qmeXW823s3au7
 S6CsxHvH9dyV6fnYL4/enfBusPf4wB3WUMvRvxx0nNlDBsy9FpXllL3ZvwOdztHlCzV8VxiYNxw
 B9UgdnZn6X5+6Oiq98/rHgw3TT+JPwOKe9nPtRC18krdShba2ILz+AAGXD7xOflVC2ohvHnHiEF
 rgUuGC5+6hBUreqOU8yuqd0hRlrE5+WUys8hkZFPTl0g9b/ec33t2S6HyCLO2p9cOp73Lmjk07R
 0MwPQaIzE2j7nMkcTt66Modcxzo+SRtUH/tXVBsLvrQacaQeik/7lZCdhhJKhGqxrQR+W4UV2j+
 oVLvdXp/pRZ7lG/Bu+IUuOD0xQFN/P8a+LEGtdArqJjUXy5A/z1/Oa1AhsxdaV4V6pT8LbUcK+l
 eg8++XxOYorzh+LCd+A==
X-Authority-Analysis: v=2.4 cv=GuxPO01C c=1 sm=1 tr=0 ts=697905a4 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ic6Kjyy2t_iG7cYfer8A:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: WmR2oPZon2_t-dseKKNCnEwMG0tmtwRQ
X-Proofpoint-ORIG-GUID: WmR2oPZon2_t-dseKKNCnEwMG0tmtwRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31242-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9426B992B7
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:04:46AM -0800, Jeff Johnson wrote:
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k.
> 
> No updates for ath10k.
> 
> For ath11k update board files for QCA6698AQ/hw2.1 and WCN6855/hw2.0 to support:
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=255

Don't we need the variant for this one? Otherwise it's too easy to clash
with another unprogrammed board.

> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618,variant=QC_QCS615_Ride
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268,variant=QC_Hamoa_IOT_EVK
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618,variant=QC_QCS615_Ride
> 
> For ath12k update firmware for QCN9274/hw2.0.
> 
> Please let me know if there are any problems.
> 
> Thanks,
> /jeff
-- 
With best wishes
Dmitry

