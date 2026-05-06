Return-Path: <linux-wireless+bounces-35984-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JIeHKpbS+ml0TAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35984-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 07:33:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F6D4D64BD
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 07:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B743B300F151
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532D12B94;
	Wed,  6 May 2026 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9J3K/+m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IG+gjtwW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D3E54B
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778045587; cv=pass; b=mzXb43NT3mY+8dEYy+4a5b/UXBm9cItJR/0yTdQbCINixZbiyRROv4e9e2h/tPIBvi6YbdZlg7Bcqq1ze8dWB9TQj9aA7PSfENGLzjWygI6qcMBYpN6IHQ5FapaikwFxYD1Ootdg7jK6Dj9f/1nAv/z7tv6mSZZzbN4pLznEvdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778045587; c=relaxed/simple;
	bh=9v6O990mkErFL60w75A4U14iLUG64G/pvNkasHB4ilg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swLlvCn5OC1ka3c4F31IUuPzKpR+YsWOqe0GuMXOHCep3FInnReVTUWvHizAiW97VBP9/AvBvvPxCIqenNiVg9fIv/Xa0FehB3D2i5rGZGpKcXM5lY14Idi8jqWyV+gTLo5YzFqQP3B+7K1Ql22gIGoOC6vf6ESk9FftN9QdBfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O9J3K/+m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IG+gjtwW; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645MKj74912393
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 05:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x2tY4+pnycU+w90UF9osCn3xcRDllh+pintXaUXr9DI=; b=O9J3K/+mtcme+e4O
	vZbL3VNY+sudp7t5Z9HM6QqrpKY9RWTWx4HZU6TY9OKEhEFz4+2qrhf1iIEXIE0m
	jW0jzJ9wiMfXnl6x3TuxQCm+x0hJk+ptWUmHF9f31k/ib+FSQGjKGP63yaGCytVt
	fI+nOfyVmhkmVcmCVOW5AxGfS7Js1o6FGpxsniFv6nm90ZRHRqZcrmQ98hiEzAlZ
	Yi8x9NBBiMavTzbrMY9+MNI8appZDFdLjfBMe6+xJXctzZvmdp9LsDyiRVTOYLHb
	oMmjulRjIZLkf+3aR9YJ7+kzHitL2vPWmoa778KtT8vox3pFjbSIO8ISku+bt5f/
	2Qtdag==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj7jk1dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 05:33:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12c8ca57a23so743919c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 22:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778045584; cv=none;
        d=google.com; s=arc-20240605;
        b=SKNH5prRlTcm2BD88J0fHiDdGHYYwx/6Zf5qKgrtOWX6R9pyJGUx5v/NbP9hxazPdL
         4XbnL6JqCI2iUpcxyDc939k1o8bhoLfQ6CxUc1B7h6yzH+Gn/9kNmRVrAXclkawA9gde
         bGFu0LyURpWq23p+M/hy4dYMLmN9O14RpzWKGQvW2a/fkf7ft/QNlAQVObZGAXtRXpub
         0843UTeaKzyxB2H6uA9mx1QOJBYeCJc0NHBOTtrL5vRyXRSHEhFDBkHcgAPP+t3FB4tz
         OhtSZBMQZI+nGMHeTR6iKRc2ZnqtOmp1SuH9gjTYwGQVIwHMNX8L3YtXr8Oz+FYKPzP2
         cFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x2tY4+pnycU+w90UF9osCn3xcRDllh+pintXaUXr9DI=;
        fh=3OdLH0vdBSfuPtusJQYsc2KK026peqjJnuWhwAG1O/4=;
        b=NqO1UcqUgoHggJwYQlVHmqaCZ35D2m3OvWo01R772EFgLBgJv4SElm/4K3p6NfUOc1
         n25zS8//48Lk+2yftAJiEdbLcrbCltCw47cDkwrNQWuOD38bJxmThNBw1noBeIyjE20n
         iX2GAOkC8gNvVCA8shpYTCPVdOF5hrOf/p41HAMPIA6k7eWcHFRO9LntFLWlfkVDGchb
         K6KIdMsYV6ImJTphQqFk7MkNmR8T+l0YJq2cGmzuy4brKMpxWbNSfLuKS78WdOIuJDOF
         DOhffpexIzAAAWgmZktoJmB3OybzG1tMwXlcB2WfBYp2dAfwn5LK42JxexqyuNL1A5CN
         wqZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778045584; x=1778650384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2tY4+pnycU+w90UF9osCn3xcRDllh+pintXaUXr9DI=;
        b=IG+gjtwW/tGRjKWreppIp98rm53X45NKdIdSYAwQEWj7vPRyAwYPYbb7KqLhmHGuzk
         m36IvH1bDAvhWq1vmZSp/ytHbvXpgfDUt8vHxYxXjBj3Gd5eKMdvVe+F1tAdgpY+y9B9
         VYNKoWwMGqy8I0HOPlf3byjOKhQWXKWBWqo5AARtGBVOCI02UKZF716wda8eQb/MHbn+
         PvTpJjlV8Tv8m8HlVB9dx78mjfRxEPRpJwIDTarS6ZHR3Ha5s1Vg4VBiGQsUyqgWkRU5
         hIonPPoaxQD4YgDV0p7RDFEziMAa4y2CPuvHoGG9dPRPdTstVNlXoB08SVTh4MYM6fJm
         dW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778045584; x=1778650384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x2tY4+pnycU+w90UF9osCn3xcRDllh+pintXaUXr9DI=;
        b=qVk2K6dQSmbA7br+Kk7jdYnNg7Nd9K8FEGwBXhsr0ihE/7RcUCA3XV1xm1G8do1WPD
         J/TBPZm0XRltN4CBgBgHTMNRhycxMFXWLQ15W4n8kCOzkblKJHUeFnBuRzYmOxI40tfJ
         fvsW0k5sBTbmuH3kdmRhWcCymqaSFF0VxHhzTLHGJypGi4npf5BjLMQro2SFCa/JzWZo
         LKvf4AsGf6hAk5tMTSGxv03kxV/6sgxA0CLa2LoGoyhFslPWiV3lRY7iXZtal3HDGGgl
         dxPG6ndjfpGVI30EE0qHLzoq9oedcPGR5wJxRE2YPk+7i+3/djj7C6qIn0apeXYVe5OM
         zsNg==
X-Forwarded-Encrypted: i=1; AFNElJ/vB/l4bdbWP4E8svwti1hwS9tLaI5Ux6uyal2a4Dd/SUa9RKFN3DJO0uBkvZO0zCi6ME6yTPu+/UyXduQK9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5mb5yzWreaU/etsQKgdkRTsS8kPTJMDrWM65RyrUlkEJ/4gK
	P/FoFmuIaHA6YCWkmADmjesjVGKlLC7+cmxEpMpGdvqFF+wORZBXog56ek99Dw2ufRxagI+G1dN
	Es/evPtJccybqZe8na3kqpwVeQ1wIF5B0+uwA5AmQqtoxqLoqLYO7L9gmFJ2VxV2iOFA5qPP3mV
	E/8y1+5tLtjV5MQrXCOH1CrXvYQwAtKj5hZa2xbGCG1sYaXc8ZAnLd
X-Gm-Gg: AeBDievpnxgeG6sYNVcrteQOQ9gPxdMUKgFoo5IZOIbEN+czGJZ1hyO7+XhHxeQlfbr
	9W/PKsMaRRqG0c/CW+bqGeLAjIZzLRD7BtytyTf8S1iPUZV45yHMcm8UxDIrnfggjBWwr32a9Jx
	2mnsK21eOFz/jCSIHcd+rQKSNDOh6EvOV8r81oJFPDRRa/4+cC4icwuOw3irq8c688m/lrfTGGn
	0JVINsEDi16tTErzQ==
X-Received: by 2002:a05:7300:2327:b0:2d5:9438:2a02 with SMTP id 5a478bee46e88-2f5671e15a8mr425072eec.1.1778045584218;
        Tue, 05 May 2026 22:33:04 -0700 (PDT)
X-Received: by 2002:a05:7300:2327:b0:2d5:9438:2a02 with SMTP id
 5a478bee46e88-2f5671e15a8mr425065eec.1.1778045583591; Tue, 05 May 2026
 22:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505040920.57521-1-laicheehou9@gmail.com> <CABkEBKbVG-UGWOQUgi0Q4M9HkMqOF-nc2gWTwBn9gebC8s7U8Q@mail.gmail.com>
 <69fd7b6b-ebda-4203-a798-6227feba7350@oss.qualcomm.com>
In-Reply-To: <69fd7b6b-ebda-4203-a798-6227feba7350@oss.qualcomm.com>
From: Tamizh Raja <tamizh.raja@oss.qualcomm.com>
Date: Wed, 6 May 2026 11:02:52 +0530
X-Gm-Features: AVHnY4I4gzfpUwgkPXbBTsTjvICWhp0LY0e-Oi5BVBF1LqxZflnFqdSaxaU8mOU
Message-ID: <CABkEBKaMvDsACmKzXy7RyrF7eJ+5hAxbG3LcZOZ9b_eENbqnpA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS
 reporting in monitor mode
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: kwan1996 <laicheehou9@gmail.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA1MSBTYWx0ZWRfX1ZtuQWd/CGmE
 aieHUEa6JQ/MwCEQdMOP3Sau+VrqQJs9lbV72z69x2vIv5cowZ0Djrp2zAi15RtOLYdC+jiqdWS
 KbiK9jMakzGvGS9RrYXYFfpQ0BEbF2LqixIzO/fAzWyxWfecpvqv35vFR2G9eoJRjX26cVv8VIy
 YwHUFITp+PzGQjMkyS9CMF7sOLB3JP+gdrx8DwX12gRa/Rx4qoaaP1PiAOzukNhwJZYv2Bf3m4Y
 gM6jtEi7x+Z+CGgSwXlOBrPHuHTKtQ/8DH3WYLAi/8kz/5KJiZuNzD50YW2hF4fxAMIP0MULAbh
 vEhgpFKnc4ZdooHRKmLzQyOBnxL+xPoh34Wr6heaQ4q9AF2gEWRygJACd9eNubUQqxuahXZkgHT
 j9aGPAeN7EMBC5Zxa9lFNjQq2KSDF7CRV3V9ssxUMAuWRJ3fN++hTfkjPmannApf1cUAZ+B83z7
 BF5xKCyNvya7CD2Zhrw==
X-Proofpoint-GUID: nyapSsRYbMIcVSeFYN99j29uYKiasbMR
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fad291 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=rYbqYaeFVUH_0xll3yUA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: nyapSsRYbMIcVSeFYN99j29uYKiasbMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060051
X-Rspamd-Queue-Id: 00F6D4D64BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35984-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email]

On Tue, May 5, 2026 at 10:52=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 5/5/2026 9:43 AM, Tamizh Raja wrote:
> > On Tue, May 5, 2026 at 9:40=E2=80=AFAM kwan1996 <laicheehou9@gmail.com>=
 wrote:
> >>
> >> In monitor mode, the driver incorrectly assigns the legacy rate
> >> to the rate_idx field of the radiotap header for HT/VHT/HE/EHT
> >> frames, ignoring the actual MCS value parsed from the hardware.
> >>
> >> This causes packet analyzers (like Wireshark) to display incorrect
> >> MCS values (e.g., legacy base rates instead of the true MCS).
> >>
> >> Fix this by assigning ppdu_info->mcs instead of ppdu_info->rate
> >> for HT/VHT/HE/EHT frame types in ath12k_dp_mon_fill_rx_rate()
> >> and ath12k_dp_mon_update_radiotap().
> >>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220864
> >>
> >> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ
> >>
> >> Signed-off-by: kwan1996 <laicheehou9@gmail.com>
> >>
> >> ---
> >>
> >> v2: Fix indentation and formatting issues in v1.
> >>
> >> ---
> >>  drivers/net/wireless/ath/ath12k/dp_mon.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wi=
reless/ath/ath12k/dp_mon.c
> >> index 39d1967..4119bb8 100644
> >> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> >> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> >> @@ -1925,6 +1925,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
> >>                 }
> >>                 break;
> >>         case RX_MSDU_START_PKT_TYPE_11N:
> >> +               rate_mcs =3D ppdu_info->mcs;
> >
> > Can we assign this rate_mcs before the switch case? Since in all cases
> > we are assigning unmodified ppdu_info->mcs.
> >>                 rx_status->encoding =3D RX_ENC_HT;
> >>                 if (rate_mcs > ATH12K_HT_MCS_MAX) {
> >>                         ath12k_warn(ar->ab,
> >> @@ -1937,6 +1938,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
> >>                         rx_status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI=
;
> >>                 break;
> >>         case RX_MSDU_START_PKT_TYPE_11AC:
> >> +               rate_mcs =3D ppdu_info->mcs;
> >>                 rx_status->encoding =3D RX_ENC_VHT;
> >>                 rx_status->rate_idx =3D rate_mcs;
> >>                 if (rate_mcs > ATH12K_VHT_MCS_MAX) {
> >> @@ -1949,6 +1951,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
> >>                         rx_status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI=
;
> >>                 break;
> >>         case RX_MSDU_START_PKT_TYPE_11AX:
> >> +               rate_mcs =3D ppdu_info->mcs;
> >>                 rx_status->rate_idx =3D rate_mcs;
> >>                 if (rate_mcs > ATH12K_HE_MCS_MAX) {
> >>                         ath12k_warn(ar->ab,
> >> @@ -1960,6 +1963,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
> >>                 rx_status->he_gi =3D ath12k_he_gi_to_nl80211_he_gi(sgi=
);
> >>                 break;
> >>         case RX_MSDU_START_PKT_TYPE_11BE:
> >> +               rate_mcs =3D ppdu_info->mcs;
> >>                 rx_status->rate_idx =3D rate_mcs;
> >>                 if (rate_mcs > ATH12K_EHT_MCS_MAX) {
> >>                         ath12k_warn(ar->ab,
> >> @@ -2259,13 +2263,13 @@ static void ath12k_dp_mon_update_radiotap(stru=
ct ath12k *ar,
> >>                 rxs->encoding =3D RX_ENC_HE;
> >>                 ptr =3D skb_push(mon_skb, sizeof(struct ieee80211_radi=
otap_he));
> >>                 ath12k_dp_mon_rx_update_radiotap_he(ppduinfo, ptr);
> >> -               rxs->rate_idx =3D ppduinfo->rate;
> >> +               rxs->rate_idx =3D ppduinfo->mcs;
> >>         } else if (ppduinfo->vht_flags) {
> >>                 rxs->encoding =3D RX_ENC_VHT;
> >> -               rxs->rate_idx =3D ppduinfo->rate;
> >> +               rxs->rate_idx =3D ppduinfo->mcs;
> >>         } else if (ppduinfo->ht_flags) {
> >>                 rxs->encoding =3D RX_ENC_HT;
> >> -               rxs->rate_idx =3D ppduinfo->rate;
> >> +               rxs->rate_idx =3D ppduinfo->mcs;
> >
> > rate_idx should be assigned with ppdu_info->rate only not mcs.
>
> why is that? documentation says:
>  * @rate_idx: index of data rate into band's supported rates or MCS index=
 if
>  *      HT or VHT is used (%RX_FLAG_HT/%RX_FLAG_VHT)
>
> ppduinfo contains separate rate and mcs so doesn't one or the other need =
to be
> copied to rxs->rate_idx based upon the current PHY configuration?
>
Yeah, sorry for the confusion. Change looks good to me, We need this
fix for ath11k as well.

> btw looks like the struct ieee80211_rx_status documentation needs to be
> updated for HE & EHT (and UHR?)
Yes.

