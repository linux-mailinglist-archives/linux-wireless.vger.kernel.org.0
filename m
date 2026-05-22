Return-Path: <linux-wireless+bounces-36793-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGs7INUfEGqjTwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36793-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 11:20:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158D5B10A6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 11:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DA8730074E2
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91683346E7D;
	Fri, 22 May 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G4Hl+a2b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bmJH5B2N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164039732F
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441596; cv=none; b=BqYGFN/YlWGaSLsIAZdJcNCo1eDsKczZpSiB1e8DfdyVFl80NurnClTB8bRYewKjNYFr/2cvERG7zBHwCTMCWEaSqm5a34/N56Mbba0Pj5f0+Rpt8zvOwz+fxj1MJqCiIH8JfSEfWSJJLcxf/fxvocEUEu/I+/sZU2WMEn7IpPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441596; c=relaxed/simple;
	bh=aa27yL9XB0t2F+tWITMQEZO/IPOBwdPI2VkyEG99Tq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPXFhGsSrf+4v7Wyed4ftnZ92eMvGo9RX2KqbD+r0OsFb/oPSq0YepwQyQnCsw93vdvg1sZI36bhq9DbBXkyAcyPcgcs+8d4YokBEXd6lUO+BwTV1x3nPXzhucs/93gwnvFLxM8OrNs60GDplsVIphVFZV6Cob595T59reWNG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G4Hl+a2b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bmJH5B2N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M6MkYh1298044
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 09:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VFZFaXo20zyBmuw5LWPStkgN4cehYROfIhtSIYDc2NY=; b=G4Hl+a2bt9xlT2xB
	i33NHHBsAMvqM4JTaoRo6J9jdtEjEdAPknF7IUcKa2QmmhGxzC27bvY+tVYX5Xj9
	kiZoXBn3WAHOqmwu8T23KtrdqhbDz170SjOq93IM8ILJ4l8TFQ644RGVytnzKIBx
	AQoLJg+eh11S8HSm4dfOLuu4nonzHqpl4eDTe//NNxggneVnggdxx5AkDle2F7jG
	I7Q3xIZMfiGD+nIOkkg/lT7hwus1982KpkHL/oJYRmACRgnbquJa/PPGROpCxMrD
	DiWGtpJeJ55WFcMQ0FEE4vnLr1vM234NbtJjeDysEgC5Jl4Hk1wiMLdrtGhnKjqr
	DqnF7g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah0a88q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 09:19:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c827c880e39so3606929a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779441592; x=1780046392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFZFaXo20zyBmuw5LWPStkgN4cehYROfIhtSIYDc2NY=;
        b=bmJH5B2NRtNafM+uOmoHY+KdYsPcCdaEuerosQ+RnEncLWL9tjJrMfOvPMpXaQ11cU
         SX90uSEMqOgQn+S+aNXSrZhXhYZoKdZYp7whh2qMlgYVAyUgSg7zOm5zm8A8pV8qmogL
         3hU3PaMs1cfDqz8iILVDswEkHUHjBGfyHraT6czsQVtN4F7qmNpFqYe9Ik7YxAsTV8S5
         IQFd15Sp72fjMqh2g/Ftf3p2mG+5TmmMDmRx51fHMNDHIlRcwdf58nOjqv7xhkGzXReJ
         rl1DdC7nfBV1rSbdgKDSeWcfHmlH0xtlukMdLFLOKUovGUaG7uINJ0cF+bX+bbJtEZIV
         C7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441592; x=1780046392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFZFaXo20zyBmuw5LWPStkgN4cehYROfIhtSIYDc2NY=;
        b=qeJTbIGHyDcRfsgmcqA9GdTwn8OP6QRCzW5JPcJ36A733+uNw5sGmLx+PZid9x/UT4
         MW6Y8gwph7PHb0w3l2i5Ujd9zIrFToPgqvqcDVg8QrgLmytwbnAK/mYX/870S9RtLlig
         vAjx3N7c4eEqMUxsX5apbmtNMz33fhByuTL+rHCC60D8Hc4pn8LhTbBWqaWXdn0mwVyp
         LeH8yxsJqZJqfseYPXjoRpX2MiOjCigIn8JSQT2HcA/l0eZOovix3qedyo7CzTJ7j/Dg
         Z0ml24bNffHQ27a52RrozlETM7oQDSynxXLp/VffdrorLD4+SZjDDm9g0r4Rz23aUGJg
         idBw==
X-Gm-Message-State: AOJu0YzL78Bh+W4LVNgM9u9J9QpZ7sFAFusXMq/noWbgNSUxTW1ZXulK
	BSyeuPOeL3oU5js1o7+BdUoeLICdsT3uOrz8L5ck0HRNjTX68EowJrbUcoDe0JX2uYF97iWC9+z
	Rt1mKpXb7FW0Sg6fcBCw9CRqyxO3BvA4SgtruFZj/IczrCoSj3Vio3chokNWqQyj0B88bCA==
X-Gm-Gg: Acq92OEfowHlkmJ9FpsmIu/gyz0DmkdEs/aYt9c6nz2QsWvmFGCHCXMpy58l65UZhAE
	SHeTHXExT5ynQGWKseKFbKUPuMHpUVFTXnW/1bXgfC5w9UejsQ+fBP/0ByYGZpscTZ9lzs7uYpp
	uD73XJmKG6m8KOLtxMzdjtsZgLRxFZ5967Ifr1/qNLU4Qg5AuCiAsEn/RE4O9rDLGGndS4EwVZw
	s2PRwGkb/oN2asRW+2O3VrTnHW5eyyyV7Tzf53Oi/vXFJdWMhtTA1UUEqtvS/2iSFDLylPAUAeV
	b/wtzg03eOxfK70ob9HRMvq00fMho2D1yjX50wQXyT3HibOkDnkK+Cuw2mPpAOdgiFDc1e5BzIs
	dT1h2eojCsiHgn7iiJGlpVrgR2Rc3NTHqbenTuOYMbmyy0KIDb2wfqPqtVheTwJ5b
X-Received: by 2002:a05:6a00:4f94:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-8415f3d0e36mr2709312b3a.11.1779441591994;
        Fri, 22 May 2026 02:19:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f94:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-8415f3d0e36mr2709286b3a.11.1779441591459;
        Fri, 22 May 2026 02:19:51 -0700 (PDT)
Received: from [10.152.204.244] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ea4de4sm1391410b3a.35.2026.05.22.02.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:19:50 -0700 (PDT)
Message-ID: <e3328366-77ab-4505-b1e2-63f928cea903@oss.qualcomm.com>
Date: Fri, 22 May 2026 14:49:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Prevent incorrect vif chanctx
 switch when handling multi-radio contexts
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20260522091200.3179640-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Language: en-US
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
In-Reply-To: <20260522091200.3179640-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MiBTYWx0ZWRfXx4m3ML2AcKP7
 0Mnw2u00q/NTR1w4nQ3AkV6m+bxc3zsQNs6vlrAoluDIAF46u8ZXzQ1p3mtAxtG1EsDVoETsX7Z
 RF1lXdcUCeykjHoQryYEE9loWSyMDsvNsPEVMVTlUaJF1sYXhrISRQgFyeP9GrZisJ24N4NdZhF
 qIVgcyHHO2gSvackoJ792nUQ6UWyTdoKcrIuA8MNEUPKTNhpWWMZGwRAVBSUmG45VdN0s3UPxBf
 Z57r0Ix51+0jkUwQ+gUrMnoKy2VZHb+VFVyGI/F0F6IvOfDxH5MLrB7dt3FUOB0Jwe8f6TaDUEm
 MdFhuk1VJuueZQXPBeirm9hdGbBsgp21jYSXpymf7LT4BcuOV3TAQIxRxn55K2PBgFCA4WmJ4+H
 bRj0P24a2aFAetgKU1P1Ho2EPN4AbtqXjqC0UhjBW5ebZkBzT86JXl/DwuLD4idLK55MM5w/quL
 B9ux0bR7rXR+tnLrDAw==
X-Proofpoint-GUID: ZMfUipcVaszsuxZLFWNrpsrHUhXrAtNr
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a101fb8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Ve6J-mc7yfqyW4SkaIUA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: ZMfUipcVaszsuxZLFWNrpsrHUhXrAtNr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220092
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36793-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8158D5B10A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 22-05-2026 02:42 pm, Maharaja Kennadyrajan wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


Kindly ignore this patch. I will send v2 of this patch with 
Co-developed-by tag added.


> When multiple links switch channel contexts around the same time, mac80211
> may complete CSA for several links together and invoke
> ath12k_mac_op_switch_vif_chanctx() with an array of vifs spanning more than
> one underlying radio in a single-wiphy configuration.
>
> The driver currently assumes that all entries in the vifs array belong to the
> same radio and derives the radio context from the first element. On multi-radio
> hardware, this can lead to incorrect vdev selection/updates and may corrupt
> driver state when the number of vifs exceeds what a single radio supports.
>
> Fix this by validating each vif's switch request and then processing vifs
> grouped by their associated radio. For each vif, ensure the band does not
> change across the switch and that both old/new channel contexts resolve to a
> valid ath12k device. Reject attempts to move a vif between radios (not
> supported for now) and return -EOPNOTSUPP to upper layers.
>
> Then, iterate through the input vifs, collect all unprocessed entries that map
> to the same radio, and invoke ath12k_mac_update_vif_chan() separately for each
> radio group. This removes any reliance on mac80211 providing the array grouped
> by radio or sharing old_ctx pointers across vifs.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 87 +++++++++++++++++++++++----
>   1 file changed, 76 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 54081beb9a5f..5c8e25d40a98 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -11476,6 +11476,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
>   			continue;
>   		}
>   
> +		if (WARN_ON(!arvif))
> +			continue;
> +
>   		ath12k_dbg(ab, ATH12K_DBG_MAC,
>   			   "mac chanctx switch vdev_id %i freq %u->%u width %d->%d\n",
>   			   arvif->vdev_id,
> @@ -12267,23 +12270,85 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
>   				 int n_vifs,
>   				 enum ieee80211_chanctx_switch_mode mode)
>   {
> -	struct ath12k *ar;
> +	struct ath12k *curr_ar, *new_ar, *group_ar;
> +	struct ieee80211_vif_chanctx_switch *v;
> +	int i, j, count = 0;
>   
>   	lockdep_assert_wiphy(hw->wiphy);
>   
> -	ar = ath12k_get_ar_by_ctx(hw, vifs->old_ctx);
> -	if (!ar)
> -		return -EINVAL;
> +	if (n_vifs == 0)
> +		return 0;
>   
> -	/* Switching channels across radio is not allowed */
> -	if (ar != ath12k_get_ar_by_ctx(hw, vifs->new_ctx))
> -		return -EINVAL;
> +	struct ath12k **ar_map __free(kfree) = kzalloc_objs(*ar_map, n_vifs);
>   
> -	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
> -		   "mac chanctx switch n_vifs %d mode %d\n",
> -		   n_vifs, mode);
> -	ath12k_mac_update_vif_chan(ar, vifs, n_vifs);
> +	if (!ar_map)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < n_vifs; i++) {
> +		v = &vifs[i];
> +
> +		if (v->old_ctx->def.chan->band != v->new_ctx->def.chan->band) {
> +			ath12k_generic_dbg(ATH12K_DBG_MAC,
> +					   "mac chanctx switch band change not supported\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		curr_ar = ath12k_get_ar_by_ctx(hw, v->old_ctx);
> +		new_ar = ath12k_get_ar_by_ctx(hw, v->new_ctx);
> +
> +		if (!curr_ar || !new_ar) {
> +			ath12k_generic_dbg(ATH12K_DBG_MAC,
> +					   "unable to determine device for the passed channel ctx\n");
> +			ath12k_generic_dbg(ATH12K_DBG_MAC,
> +					   "Old freq %d MHz (device %s) to new freq %d MHz (device %s)\n",
> +					   v->old_ctx->def.chan->center_freq,
> +					   curr_ar ? "valid" : "invalid",
> +					   v->new_ctx->def.chan->center_freq,
> +					   new_ar ? "valid" : "invalid");
> +			return -EINVAL;
> +		}
>   
> +		/* Switching a vif between two radios is not allowed */
> +		if (curr_ar != new_ar) {
> +			ath12k_dbg(curr_ar->ab, ATH12K_DBG_MAC,
> +				   "mac chanctx switch to another radio not supported\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		ar_map[i] = curr_ar;
> +	}
> +
> +	/* Group vifs by radio (ar) and process each group independently. */
> +	bool *processed __free(kfree) = kzalloc_objs(*processed, n_vifs);
> +
> +	if (!processed)
> +		return -ENOMEM;
> +
> +	struct ieee80211_vif_chanctx_switch *group_vifs __free(kfree) =
> +						kzalloc_objs(*group_vifs, n_vifs);
> +
> +	if (!group_vifs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < n_vifs; i++) {
> +		if (processed[i])
> +			continue;
> +
> +		group_ar = ar_map[i];
> +
> +		count = 0;
> +		for (j = 0; j < n_vifs; j++) {
> +			if (!processed[j] && ar_map[j] == group_ar) {
> +				group_vifs[count++] = vifs[j];
> +				processed[j] = true;
> +			}
> +		}
> +
> +		ath12k_dbg(group_ar->ab, ATH12K_DBG_MAC,
> +			   "mac chanctx switch n_vifs %d mode %d\n",
> +			   count, mode);
> +		ath12k_mac_update_vif_chan(group_ar, group_vifs, count);
> +	}
>   	return 0;
>   }
>   EXPORT_SYMBOL(ath12k_mac_op_switch_vif_chanctx);
>
> base-commit: 30d516006fa1f72f957c18c6171f5680dcdebfb0

