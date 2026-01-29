Return-Path: <linux-wireless+bounces-31295-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eITYOVcPe2nqAwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31295-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:42:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 22034ACDB7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C372F30657ED
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2281374172;
	Thu, 29 Jan 2026 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NObh+eyw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ScyLHaV6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164DA37AA9C
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672019; cv=none; b=JdJPjH/Z0FRrjYoGLkPKeTg/zQeI09Ccp3/pyyqFZkuNATccpQ5TnPHMwQPZVZ7G/kGl8box0dkrChQjbA8edFhH7tlc0zpLkkgcgZ4OjqhGPEwWp3q8JA3ApJ+tbe2x86JO+kd4zATLOCUuyylw7oTOQM7QPE99hM9r3KsPRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672019; c=relaxed/simple;
	bh=3gX8HijMuiImGXMdc1PwLzWh9h64CmK9IqJuZWG9xx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0uLjVcYnF71QNurJzOEcFsZRbx0XBaSGp8nA75z9mlCJ61e2O6rhiSsvktVUTKcjqJMeRdbn8M7QFpcDgBoq+EDz/xBnMxRZcin6sdaFfIhuCttny4HvVM2E5augJ5drb44RWwtxkZ6TlPajjvaIadP33YSK0pXNSxfwuwWaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NObh+eyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ScyLHaV6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2qFBo1525164
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 07:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ITzCif2SI49ds4TIjmAR6gichOGOkzNCxPnwrIbXTi0=; b=NObh+eywbGUpFXGT
	/3KVp/sc5xn4eiQLvsiqekoAL7rp/FVmeCVnPkrpf6W48g16KZXkZ6J2CvgUGmE6
	6toNvNano3DRBjcvSH6kWn6qure79mCzwNdzJ9WNJVb3okfnHOlRdesTd6yyvEFK
	SGFWPXDwwZv38rbjDgD3Xx00B7tFq0FmnzMpDsEeO3zbnw6PhF/UeZQBit6z+eoS
	FtIHel08EIlbRxhG1t99M5nGdHuZ+b4hPMNBhMLqRMJ7EsgupLrDep8YRyPiIWg9
	W6AjprVSuqxeErknx8vlPF87V+TMBg3D0jCAVz5Blpr+p3Qa3Xsl3XyGgjJQGI2j
	FO+V9A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byjxhua52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 07:33:36 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81e7fd70908so1290288b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 23:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769672016; x=1770276816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITzCif2SI49ds4TIjmAR6gichOGOkzNCxPnwrIbXTi0=;
        b=ScyLHaV6TwmF9YbA1UDM7AZlwj14DMoRpSKryBfJ2IGMp7SsfXnmSur83haioQR+ZL
         UgszBxzBvhryB5F/knHnQKS5W49uKLVzVgFQqC9+qs7oW3sgMnqn+1H1v1ai11X2bidC
         hWyzJ5EmNY42ElsTlXwNm4MSZKk94T4H23p/TDAYa0fX7O0Q9NtuNCrQYoxtxvPkCeq1
         khmlB6/XDMCbO0qv0ILD8rQZtnFfTtFXK3dvrpNe0dR+ymXD+LA8sjGurbGweUB4lYIP
         0jGm8bMf6SNHE5v6ngFy0uO6VFRiOQ7/zB+ukNz7+W9EoHUmP6zOJoUeUPO60tR75V5f
         VAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769672016; x=1770276816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITzCif2SI49ds4TIjmAR6gichOGOkzNCxPnwrIbXTi0=;
        b=axBs98Y3nXthGxxXmKyJGXyUPAcoKpeDxv2LH55SGUlFuGw3KBJ8x0ozJmwHCgoqRF
         1wx4A9F8ZAeW+tRpeXzRKwqAhR1zSea86seFR3l/CFgrT/Jlgk5fyhTwFWzh6CEN4TjS
         hH05bRSoIQGpwGK+iav8BiCt3Jp1yW5H8bSXrxO/ioQHhXxlkAZNAyb2j4OAgmi1yDl/
         6C1W8ZaOT46fw3zXFp2qXezt0//WSbC/0wimHiBHu3rouRC46t1nJUy9+tFEfHhFePBa
         McdEaMesfVY7fw7IqE1alv2W66Rc2iWIsTZTR2YCwcq5thHtknxtwmwHCFuhrQ1VwYgN
         Hm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfD9kiLgmy629wJx8l23Z/qwMQPlV/pZtbcaeoJ2Mz67EKcNue9w7yJqVCz+NXVLGX5K0BjXgih9d7+m96Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoPckPYC3laPkDCuLdQPByKxr8yoCfLaSxuIroJO/ihYPA1kN
	h+PTRf3Jo5gXJeu0zUwD3stYe6iFrTE5UlwhLf+2uVUCsLm4vI5ScBz7/k9nKNUMtlcMLGKax2S
	uFw5bfEUz0dfqpmXGxas057DMCQeV6fgZzL9490F5vJmi+7T3QF4ZdQt8hScdf1hKN+/SW0TCV9
	ImYQ==
X-Gm-Gg: AZuq6aLI0yCXcLvAS6j+eSBbA8NS1N9Yq9bbfYxFTaqrkXXrgGMqZFl2VRSsQEfzo3k
	nrJigPk9oI+MbKdPnYkQ+SZTGu9NMa5XXGLC0bHwcv0Pw9NGzBMw51FRe0scWGktdHENHe/EXVM
	ik/UE8IF6tTe7jkNHQqGKnyyRVrkG5K58hAPO5i7HMMZxV8wskJGVmoUS2hYGvwd6tOBqHMOjFt
	kHHdbn1la8wG3McTNU/Sm6j4dWIVzXVZyxF6e7kB9k/C7ljIyjt8WAAdwYWmzMF0/ssEMob624i
	+v72eM/iweztJKemewcYfSNNNGzo6oY7uN7TA9V2N9zdS1VQ1J2gQELqsFoO0jRflvBeiAE2XaF
	v9fRBQFH9a5eHhlIAhh/gKcjIKZDuiC7qozASNPSt6iF/k7pYuxQ=
X-Received: by 2002:a05:6a00:39a7:b0:81f:9938:b07d with SMTP id d2e1a72fcca58-82369167625mr7583497b3a.7.1769672015624;
        Wed, 28 Jan 2026 23:33:35 -0800 (PST)
X-Received: by 2002:a05:6a00:39a7:b0:81f:9938:b07d with SMTP id d2e1a72fcca58-82369167625mr7583476b3a.7.1769672015090;
        Wed, 28 Jan 2026 23:33:35 -0800 (PST)
Received: from [10.152.199.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b4ea8bsm5385704b3a.22.2026.01.28.23.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 23:33:34 -0800 (PST)
Message-ID: <ec69981d-aa4d-4ce2-ad7f-71e68784029e@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 13:03:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 1/3] wifi: ieee80211: add some initial
 UHR definitions
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260128133033.aa4a43982df0.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <20260128133033.aa4a43982df0.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CyE0-6ZZn2lw1xQKAo0N3cMWzamKNgHc
X-Proofpoint-GUID: CyE0-6ZZn2lw1xQKAo0N3cMWzamKNgHc
X-Authority-Analysis: v=2.4 cv=b9G/I9Gx c=1 sm=1 tr=0 ts=697b0d50 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=skU_J7KqAAAA:8
 a=6sLwTB8bCWpBakW1fQAA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=b6CkM2rtsW-bHoL29FmJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA0MyBTYWx0ZWRfX/LYBGxg0d/mi
 gFvYm+OTs3h3ijKp4ratNQ83eIP+2yOzA5uTqkxXTgXuuGDT3Z6ZGooexaBL47zzwWPh+q40mT2
 8LeBhSoObOg6hqPDXnimtmaRagWgVaGrfMvd6OcgzY1qrJOg+QpzHP+uWWfxpAP4f6Lz+Kzsqdq
 U5Z6boVgxbHzU6vnki5bKjUDP6DAjepsc4e1w+U/WYLQyIVfeNx4SXC8/LZDEA0iGRNhfqW7cGN
 4mXIXxqWPjRK83nlXAidCV9uOIytCimu9V6+yr6QWdcq3iv59RCOIm1B0vj9lZ3BPJJBmtXAfNI
 f60BWdgMElvb51aqosFbzukFUlcLUESDjmFth6O+hn2Ab8GaCtLYDugeKU7U+B6vBPtTOrMycXy
 w4h/1Qke5MPVXZ3cB2s6sTaZjIRdZstNngsuGDEkgN3Dk3grxeXKgRxddDBVxX1iXrxW/GM493Z
 B94k30kAmJuPCeYCm4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_01,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290043
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31295-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sourmilk.net:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 22034ACDB7
X-Rspamd-Action: no action



On 1/28/2026 6:00 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This is based on Draft P802.11bn_D1.2, but that's still very
> incomplete, so don't handle a number of things and make some
> local decisions such as using 40 bits for MAC capabilities
> and 8 bits for PHY capabilities.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v4:
>    - update to D1.2, including DBE in UHR capabilities
>    - fold in suggestions from Pablo
> ---
>   include/linux/ieee80211-uhr.h | 215 ++++++++++++++++++++++++++++++++++
>   include/linux/ieee80211.h     |  33 +++++-
>   2 files changed, 246 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/ieee80211-uhr.h
> 
> diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
> new file mode 100644
> index 000000000000..06556867b004
> --- /dev/null
> +++ b/include/linux/ieee80211-uhr.h
> @@ -0,0 +1,215 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * IEEE 802.11 UHR definitions
> + *
> + * Copyright (c) 2025-2026 Intel Corporation
> + */
> +#ifndef LINUX_IEEE80211_UHR_H
> +#define LINUX_IEEE80211_UHR_H
> +
> +#include <linux/types.h>
> +#include <linux/if_ether.h>
> +
> +#define IEEE80211_UHR_OPER_PARAMS_DPS_ENA		0x0001
> +#define IEEE80211_UHR_OPER_PARAMS_NPCA_ENA		0x0002
> +#define IEEE80211_UHR_OPER_PARAMS_DBE_ENA		0x0004
> +#define IEEE80211_UHR_OPER_PARAMS_PEDCA_ENA		0x0008
> +
> +struct ieee80211_uhr_oper {
> +	__le16 params;
> +	u8 basic_mcs_nss_set[4];
> +	u8 variable[];
> +} __packed;
> +
> +#define IEEE80211_UHR_NPCA_PARAMS_PRIMARY_CHAN_OFFS	0x0000000F
> +#define IEEE80211_UHR_NPCA_PARAMS_MIN_DUR_THRESH	0x000000F0
> +#define IEEE80211_UHR_NPCA_PARAMS_SWITCH_DELAY		0x00003F00
> +#define IEEE80211_UHR_NPCA_PARAMS_SWITCH_BACK_DELAY	0x000FC000
> +#define IEEE80211_UHR_NPCA_PARAMS_INIT_QSRC		0x00300000
> +#define IEEE80211_UHR_NPCA_PARAMS_MOPLEN		0x00400000
> +#define IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES	0x00800000
> +
> +struct ieee80211_uhr_npca_info {
> +	__le32 params;
> +	__le16 dis_subch_bmap[];
> +} __packed;
> +
> +static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
> +					      bool beacon)
> +{
> +	const struct ieee80211_uhr_oper *oper = (const void *)data;
> +	u8 needed = sizeof(*oper);
> +
> +	if (len < needed)
> +		return false;
> +
> +	/* nothing else present in beacons */
> +	if (beacon)
> +		return true;
> +
> +	/* FIXME: DPS, DBE, P-EDCA (consider order, also relative to NPCA) */
> +
> +	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)) {
> +		const struct ieee80211_uhr_npca_info *npca =
> +			(const void *)oper->variable;
> +
> +		needed += sizeof(*npca);
> +
> +		if (len < needed)
> +			return false;
> +
> +		if (npca->params & cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES))
> +			needed += sizeof(npca->dis_subch_bmap[0]);
> +	}
> +
> +	return len >= needed;
> +}
> +
> +/*
> + * Note: cannot call this on the element coming from a beacon,
> + * must ensure ieee80211_uhr_oper_size_ok(..., false) first
> + */
> +static inline const struct ieee80211_uhr_npca_info *
> +ieee80211_uhr_npca_info(const struct ieee80211_uhr_oper *oper)
> +{
> +	if (!(oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)))
> +		return NULL;
> +
> +	/* FIXME: DPS */
> +
> +	return (const void *)oper->variable;
> +}
> +
> +static inline const __le16 *
> +ieee80211_uhr_npca_dis_subch_bitmap(const struct ieee80211_uhr_oper *oper)
> +{
> +	const struct ieee80211_uhr_npca_info *npca;
> +
> +	npca = ieee80211_uhr_npca_info(oper);
> +	if (!npca)
> +		return NULL;
> +	if (!(npca->params & cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES)))
> +		return NULL;
> +	return npca->dis_subch_bmap;
> +}
> +
> +#define IEEE80211_UHR_MAC_CAP0_DPS_SUPP			0x01
> +#define IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP		0x02
> +#define IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP	0x04
> +#define IEEE80211_UHR_MAC_CAP0_NPCA_SUPP		0x10
> +#define IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP		0x20
> +#define IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP		0x40
> +#define IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP		0x80
> +
> +#define IEEE80211_UHR_MAC_CAP1_DSO_SUPP			0x01
> +#define IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP		0x02
> +#define IEEE80211_UHR_MAC_CAP1_DBE_SUPP			0x04
> +#define IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP		0x08
> +#define IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP		0x10
> +#define IEEE80211_UHR_MAC_CAP1_PUO_SUPP			0x20
> +#define IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP		0x40
> +#define IEEE80211_UHR_MAC_CAP1_DUO_SUPP			0x80
> +
> +#define IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP	0x01
> +#define IEEE80211_UHR_MAC_CAP2_AOM_SUPP			0x02
> +#define IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP		0x04
> +#define IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP		0x08
> +#define IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP		0x10
> +#define IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG	0x20
> +#define IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW		0xC0
> +
> +#define IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH	0x03
> +#define IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV	0x1C
> +#define IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW	0xE0
> +
> +#define IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH	0x03
> +#define IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS		0x04
> +#define IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE		0x08
> +#define IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP		0x10
> +
> +#define IEEE80211_UHR_MAC_CAP_DBE_MAX_BW		0x07
> +#define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES	0x08
> +#define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES	0x10
> +
> +struct ieee80211_uhr_capa_mac {
> +	u8 mac_cap[5];
> +} __packed;
> +
> +struct ieee80211_uhr_capa {
> +	struct ieee80211_uhr_capa_mac mac;
> +	/* DBE, PHY capabilities */
> +	u8 variable[];
> +} __packed;
> +
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80	0x01
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80	0x02
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160	0x04
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160	0x08
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320	0x10
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320	0x20
> +#define IEEE80211_UHR_PHY_CAP_ELR_RX			0x40
> +#define IEEE80211_UHR_PHY_CAP_ELR_TX			0x80
> +
> +struct ieee80211_uhr_capa_phy {
> +	u8 cap;
> +} __packed;
> +
> +static inline bool ieee80211_uhr_capa_size_ok(const u8 *data, u8 len)
> +{
> +	const struct ieee80211_uhr_capa *cap = (const void *)data;
> +	size_t needed = sizeof(*cap) + sizeof(struct ieee80211_uhr_capa_phy);
> +
> +	if (len < needed)
> +		return false;
> +
> +	if (cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
> +		u8 dbe;
> +
> +		needed += 1;
> +		if (len < needed)
> +			return false;
> +
> +		dbe = cap->variable[0];
> +
> +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
cpu_to_le32 ?
> +			needed += 24;
It should be in bytes right offs += 3 ?
> +
> +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
> +			needed += 24;
Same here
> +	}
> +
> +	return len >= needed;
> +}
> +
> +static inline const struct ieee80211_uhr_capa_phy *
> +ieee80211_uhr_phy_cap(const struct ieee80211_uhr_capa *cap)
> +{
> +	u8 offs = 0;
> +
> +	if (cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
> +		u8 dbe = cap->variable[0];
> +
> +		offs += 1;
> +
> +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
cpu_to_le32 ?
> +			offs += 24;
It should be in bytes right offs += 3 ?
> +
> +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
> +			offs += 24;
Same here
> +	}
> +
> +	return (const void *)&cap->variable[offs];
> +}
> +
> +#define IEEE80211_SMD_INFO_CAPA_DL_DATA_FWD		0x01
> +#define IEEE80211_SMD_INFO_CAPA_MAX_NUM_PREP		0x0E
> +#define IEEE80211_SMD_INFO_CAPA_TYPE			0x10
> +#define IEEE80211_SMD_INFO_CAPA_PTK_PER_AP_MLD		0x20
> +
> +struct ieee80211_smd_info {
> +	u8 id[ETH_ALEN];
> +	u8 capa;
> +	__le16 timeout;
> +} __packed;
> +
> +#endif /* LINUX_IEEE80211_UHR_H */
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index fbde215c25aa..82d797be95b9 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -9,7 +9,7 @@
>    * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
>    * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
>    * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
> - * Copyright (c) 2018 - 2025 Intel Corporation
> + * Copyright (c) 2018 - 2026 Intel Corporation
>    */
>   
>   #ifndef LINUX_IEEE80211_H
> @@ -1200,8 +1200,9 @@ struct ieee80211_mgmt {
>   #define BSS_MEMBERSHIP_SELECTOR_SAE_H2E 123
>   #define BSS_MEMBERSHIP_SELECTOR_HE_PHY	122
>   #define BSS_MEMBERSHIP_SELECTOR_EHT_PHY	121
> +#define BSS_MEMBERSHIP_SELECTOR_UHR_PHY	120
>   
> -#define BSS_MEMBERSHIP_SELECTOR_MIN	BSS_MEMBERSHIP_SELECTOR_EHT_PHY
> +#define BSS_MEMBERSHIP_SELECTOR_MIN	BSS_MEMBERSHIP_SELECTOR_UHR_PHY
>   
>   /* mgmt header + 1 byte category code */
>   #define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
> @@ -1802,6 +1803,15 @@ enum ieee80211_eid_ext {
>   	WLAN_EID_EXT_BANDWIDTH_INDICATION = 135,
>   	WLAN_EID_EXT_KNOWN_STA_IDENTIFCATION = 136,
>   	WLAN_EID_EXT_NON_AP_STA_REG_CON = 137,
> +	WLAN_EID_EXT_UHR_OPER = 151,
> +	WLAN_EID_EXT_UHR_CAPA = 152,
> +	WLAN_EID_EXT_MACP = 153,
> +	WLAN_EID_EXT_SMD = 154,
> +	WLAN_EID_EXT_BSS_SMD_TRANS_PARAMS = 155,
> +	WLAN_EID_EXT_CHAN_USAGE = 156,
> +	WLAN_EID_EXT_UHR_MODE_CHG = 157,
> +	WLAN_EID_EXT_UHR_PARAM_UPD = 158,
> +	WLAN_EID_EXT_TXPI = 159,
>   };
>   
>   /* Action category code */
> @@ -2745,6 +2755,22 @@ static inline bool for_each_element_completed(const struct element *element,
>   #define WLAN_RSNX_CAPA_PROTECTED_TWT BIT(4)
>   #define WLAN_RSNX_CAPA_SAE_H2E BIT(5)
>   
> +/* EBPCC = Enhanced BSS Parameter Change Count */
> +#define IEEE80211_ENH_CRIT_UPD_EBPCC		0x0F
> +#define IEEE80211_ENH_CRIT_UPD_TYPE		0x70
> +#define IEEE80211_ENH_CRIT_UPD_TYPE_NO_UHR	0
> +#define IEEE80211_ENH_CRIT_UPD_TYPE_UHR		1
> +#define IEEE80211_ENH_CRIT_UPD_ALL		0x80
> +
> +/**
> + * struct ieee80211_enh_crit_upd - enhanced critical update (UHR)
> + * @v: value of the enhanced critical update data,
> + *	see %IEEE80211_ENH_CRIT_UPD_* to parse the bits
> + */
> +struct ieee80211_enh_crit_upd {
> +	u8 v;
> +} __packed;
> +
>   /*
>    * reduced neighbor report, based on Draft P802.11ax_D6.1,
>    * section 9.4.2.170 and accepted contributions.
> @@ -2763,6 +2789,7 @@ static inline bool for_each_element_completed(const struct element *element,
>   #define IEEE80211_RNR_TBTT_PARAMS_COLOC_ESS			0x10
>   #define IEEE80211_RNR_TBTT_PARAMS_PROBE_ACTIVE			0x20
>   #define IEEE80211_RNR_TBTT_PARAMS_COLOC_AP			0x40
> +#define IEEE80211_RNR_TBTT_PARAMS_SAME_SMD			0x80
>   
>   #define IEEE80211_RNR_TBTT_PARAMS_PSD_NO_LIMIT			127
>   #define IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED			-128
> @@ -2815,12 +2842,14 @@ struct ieee80211_tbtt_info_ge_11 {
>   	u8 bss_params;
>   	s8 psd_20;
>   	struct ieee80211_rnr_mld_params mld_params;
> +	struct ieee80211_enh_crit_upd enh_crit_upd;
>   } __packed;
>   
>   #include "ieee80211-ht.h"
>   #include "ieee80211-vht.h"
>   #include "ieee80211-he.h"
>   #include "ieee80211-eht.h"
> +#include "ieee80211-uhr.h"
>   #include "ieee80211-mesh.h"
>   #include "ieee80211-s1g.h"
>   #include "ieee80211-p2p.h"

