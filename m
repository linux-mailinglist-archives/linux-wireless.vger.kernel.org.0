Return-Path: <linux-wireless+bounces-38928-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FroMBq1VVGorkwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38928-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 05:04:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2055746D73
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 05:04:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=M3rERpre;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hrlLH6Ny;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38928-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38928-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4D9E3004F1E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B009379C5E;
	Mon, 13 Jul 2026 03:04:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41461377ED9
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:04:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911846; cv=none; b=vCBV90A57nPJGSvltCsR01o/x8So79OybADJjgaoT1AZGdxyLEA5GcPw44AFJYF9SLg/DqO3tecDtsxQBA7ZPPPhUH9MI+VAHbeVcHrk0DcJd8O0Z0aI/cX3VBK8XFFcf//QVb8lBz2RuVStJLA2+H5IQipDz4gomhyQ3GmjZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911846; c=relaxed/simple;
	bh=3Hcjl9A0uA9Bit0vnDEkPP8AB/z7fYVyoBuDTgFizp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0vyhrF/IhcNXZJQ+5g7y4Fe53y3Cpm/YlrOSK2m4UI3AS71ccarVz0P5Vfs1X9cpZgyYQMRFygbyKRj+bEkS1vEPxdFWtLCtzvYTmQ9e0KOKkjYq8sSa/PP8KMYOmgPAxYJ7KJLz90FOm9eiZ/jtEn4C7BS/wig2tsaQnUNM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3rERpre; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hrlLH6Ny; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D29VZ6083289
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/jlH+kqpuhP4XLp/9HwP9AS7/ZVK5TzgNUSZ5uQWx4k=; b=M3rERpreWkDVQVWv
	8pP8V5ev28A+tYAPTIpxhMPjBKmur/93b8VARdiNFJARpJA3GF/uX85Iw/eTGRL4
	MXhDpdgNwYr0lAGgbq0QgsFGcXtE2WLkwaihXQowlr4tAIduyRNfFCchO//CuKtD
	VfmNB9spdZUHAKbFLE7gqaIkSMf2xclM59m4rFb1hoOqMVEEquLy+44DP6pbxVhh
	P46Qv6Do6Uw5w6aDsNuszQ5Y0dOwCntOJ3gOYIHJ5r1hk3cxFLVtRhKahFBB/Vjr
	OBANTIP/nHawaohLsz27e5RAw72KewLDZE8DBVqZY2u0kYgXC827EStRDpvAQXjF
	9B19UQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr419a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:04:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8894570b58so1929183a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783911844; x=1784516644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/jlH+kqpuhP4XLp/9HwP9AS7/ZVK5TzgNUSZ5uQWx4k=;
        b=hrlLH6NydUEXVSM0XN2ZIuc4J2Zd+8/G7iZ/vmvX5d88HRXaEh9eQlF6XJ4OeKjw5x
         4MFZg9aNhdNlne2YsOBsYMi8y6havtGN2XeYdPTW7dkCnjj4/2OTBxWE5a5y4Oi2xtKK
         DA5yyh5N9p+opDQ4Etzj7wyTqFziUB2HFK+ixBiOa11qjgqzl+20+7WXu3pzqdx+yHUk
         UOdvt1IlBBWks7K5jOFI8tzTbuohPaRiVZFludH0eW0eO/I4ovYsf3cEMc0uiOQBRa+8
         7ooG7p/IyAu+kfrDYm8BG/iaIk/LYWUyXl0DuBjyq4WqJw9NAXwE2vS8aQ2zlHJCTQ0S
         qFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783911844; x=1784516644;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jlH+kqpuhP4XLp/9HwP9AS7/ZVK5TzgNUSZ5uQWx4k=;
        b=N03V5b+RtACbetKeaSrmtTxJQ+lkP68sOSzclYWMXmp2X2XsrZgAdFUlXEnIrcVtk7
         xseyuEkB0emlDndB2eEymfSOMg6rbb9eNkBbxphzsaOD0KneGpI+iCh0WN4JecJGx16w
         /HcBVYhDW29y9pER0brC/2Nqgz4s0WTmC0HlCkn0xmI0Dj5KQynKe3+2DJW2jwZc2lDl
         FPT+JS1+QWr0kJf/kP5U7ApMNOuMNuf6qKiGjnchHPROdWrrtkqwUbL3/3O+1gFhvvTi
         p21+HaW++xB9dov9YhpY2+yfBUUG9dl9v7cZe7Gv7SjZJWfRg6c41pC4zaD9QPoByvGZ
         WsFw==
X-Gm-Message-State: AOJu0YwxMCqjWpV7ak1GJirC+sYDyaNYj/zXXOhikPCVUdu0a85zua5R
	OuZHATisXp80UdUhnU98lz3yELL4B71ZI9JJYKUJm7kqyzPEqg2N+catYcIJFthovJZlSiQcQe8
	Ijx392P2tEc+UrvGk9hWdDjYnbtS4Tx9i/Rzj+lur3yQGUgCrrkDJfzjFXq18C75jR2baxs19+k
	ZjtJvM
X-Gm-Gg: AfdE7clzCPJ+nahkVIgR0ODIUPIOMUYM+WC8DCCSps9edVr3F4xKoC8iwas+2c3z5hT
	1dnHwXA6UcIXEwImrSkQTAy8lM0LB5J0rP2FlT1ejIEvG5z2TPRIYmRdC+ZhnsFOvleL5LsADXJ
	SuBotFxzaVJow8e+8AlFavhq7MuW7RSEUmtOsHOgx/sPqCBuTSPUpAIQMXwkmd0juaH5fjW59z+
	0nIVxwiygXmQkHL9NiIZUFQWa13YJCBuk3HuBYXxjDBx6BXBH7+YxVPvFaRZjB/4Y+fna6f3AxQ
	SQcXe6JfKiBBHRkXqJk0sdwfdg66r0TzZjqzrGzL9nQSSkKhQKA1VQYMF6ufTeq5S0loFX8x6ZO
	WxoOQb+UxkdWUYGfbEg6yOfgGfAJU00Io7dkXB+1xXDjoqSgZd0+Usb8bA0J61SMnEZhf5DavyM
	ypK/77JZg=
X-Received: by 2002:a05:6a20:394a:b0:3bf:c2ce:972b with SMTP id adf61e73a8af0-3c110b6344bmr8240658637.50.1783911843506;
        Sun, 12 Jul 2026 20:04:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:394a:b0:3bf:c2ce:972b with SMTP id adf61e73a8af0-3c110b6344bmr8240634637.50.1783911843013;
        Sun, 12 Jul 2026 20:04:03 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162d3csm7701435a12.18.2026.07.12.20.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 20:04:02 -0700 (PDT)
Message-ID: <fe668799-6024-4370-acfc-ee64fb3a4d5c@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 11:03:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: skip PCIe global reset on initial
 power-up
To: Nazar Mokrynskyi <nazar@mokrynskyi.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, jeff.johnson@oss.qualcomm.com
References: <20260505172415.566328-1-nazar@mokrynskyi.com>
 <20260505172415.566328-2-nazar@mokrynskyi.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505172415.566328-2-nazar@mokrynskyi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAyOCBTYWx0ZWRfX/Qz/yXKrLXzH
 I79zkv7RfwZiirDal6UJ2gxKaQ+rfclC0+i3SZwQ9Op5VVFBCssAYeSyjveK9WqiDs+iTocNW23
 NDnDSFtcB26YoKcYZAzHFdlcA96vUus=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a5455a4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=TD6mGIVpAAAA:8 a=D4nGGoZ5glmf7WdhsA4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=V7iCuLqznmuTtf2Pv1nF:22
X-Proofpoint-GUID: lhMC5g3AzBSjm9gT6BAEGV7O7J1LJ1Wa
X-Proofpoint-ORIG-GUID: lhMC5g3AzBSjm9gT6BAEGV7O7J1LJ1Wa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAyOCBTYWx0ZWRfXxHH5xDNLCXNZ
 rSxXcn2zMos4PaugetSPFXiOdio08TBGg8ggPG0bTcj4eKelusIHK/NS8fgwg54ib7bKs7KnBFu
 vr7a44mP4PzwE94dg2VHHecyC22/Em2JrImVom9RfCKIHzXQnWOcgEuDHt7OeDGTCP1E2hsZWUx
 OLsnJJWo9X9vjNaidVi1mCwhOqexx4WHN4+T0QqNOH6yKnLY8H3Z6BDg8Ltpn1gyQwzyOlwa4wI
 T+z308Y64hbMobPUTTJI6PrMvHlRp4PiCvDrzSUCsbMf4MHPrHqx9sgmScK8OkatCpzj6X/DtFc
 uNgHkwKti/XhtQ8V800rEvVOKG4zgVYnhHAnDkChGTPBQSQf2z9utD5HAfHRkZHb1frVyqfnkl/
 qJ49yRMxp7fbyXoQB6pk6ntrqK78UrD08PdJQEJpXQn57YrPTvi7RIM6irV0piYJoE8XYXEjcXr
 7OEr2d1la9LOkUg5P0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130028
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38928-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nazar@mokrynskyi.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,mokrynskyi.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2055746D73



On 5/6/2026 1:24 AM, Nazar Mokrynskyi wrote:
> ath12k_pci_sw_reset() unconditionally calls ath12k_pci_soc_global_reset()
> regardless of whether the device is being powered up for the first time or
> recovering from a previous run. The global reset drops the PCIe link and
> relies on the host root complex to perform physical link retraining before
> the MHI BHI register can be accessed.
> 
> When the device is passed through to a VM via VFIO, no physical link
> retraining occurs after the reset since QEMU's virtual PCIe bridge does
> not implement hardware LTSSM negotiation. As a result, all subsequent
> MMIO reads return 0xffffffff and MHI initialization fails with -EREMOTEIO.
> 
> On initial power-up, vfio-pci has already performed a Function Level
> Reset before handing the device to the guest driver, placing it in a
> known clean state equivalent to what the global reset achieves. The global

AFAIK this is not the fact. Some internal registers are not cleanly reset without a global
reset.

> reset is therefore redundant on power-up and only necessary on the
> shutdown/recovery path where it tears down an already-running firmware.

is ath12k recovery working in Qemu in your setup? I doubt it since recovery would also hit
the link retraining issue ? Also how about the rmmod / insmod sequence in Qemu, since
rmmod also triggers global reset ?

To me this is more like a Qemu/vfio issue than a driver issue. The QEMU's behavior that
virtual PCIe bridge does not implement hardware LTSSM negotiation basically breaks all
hardware requiring runtime PCIe link retraining. Not sure why it is designed like this. If
it can not be fixed/changed in Qemu, can we do it in the host vfio?

> 
> Skip ath12k_pci_soc_global_reset() when power_on is true to allow MHI
> initialization to succeed under VFIO passthrough without affecting bare
> metal behavior.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nazar Mokrynskyi <nazar@mokrynskyi.com>
> ---
>  drivers/net/wireless/ath/ath12k/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 375277ca2..a3d7aeb72 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -303,7 +303,8 @@ static void ath12k_pci_sw_reset(struct ath12k_base *ab, bool power_on)
>  
>  	ath12k_mhi_clear_vector(ab);
>  	ath12k_pci_clear_dbg_registers(ab);
> -	ath12k_pci_soc_global_reset(ab);
> +	if (!power_on)
> +		ath12k_pci_soc_global_reset(ab);
>  	ath12k_mhi_set_mhictrl_reset(ab);
>  }
>  


