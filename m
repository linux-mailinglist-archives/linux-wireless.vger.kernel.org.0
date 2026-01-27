Return-Path: <linux-wireless+bounces-31234-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJtbNVLYeGmftgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31234-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 16:22:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F11096997
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 16:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 060C630A58B3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7BF35D5E7;
	Tue, 27 Jan 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="xkIaoJnt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A635CBA2
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526505; cv=none; b=g9Yi0t+EtEWjz5SHU8GTAF1qV+KxxTYqtFZI70jESVYA4WLjVMpWZuvECkFqzBqoR1XExUGdsmPxgHesjQmtaacuObTFbn1TnmL7A0DAAxp67Lp2bTEzorbVvJXR+xkLEAS/sy42m4Xj5oLSut4ozqqQfa6ux00jw51HXqPI9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526505; c=relaxed/simple;
	bh=Sq/oqf0zB6kBRgF/wvk02mpFCEJOzNLYP6WW/9Wo3Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgVQ4vHvHhc9iBazujcDQKCbnlnsyrnUsNMQUOaVot0Avf6oikv3CKBBHHADvOzQOJNBgeSY+6lFOf3OXgwcJcC7Pb135Dm/qAhr027H7hJjCqL1ojTXf0rsBSxh//AlMqVZKG8fDzsoqmb94zR1bOJR2RqCditiSNGWXEcmvWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=xkIaoJnt; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4801bc32725so45319545e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769526500; x=1770131300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egAKjuHhaT855DUHA1FAxe6XFNwZVap0/KgXarf4Mf8=;
        b=xkIaoJnt9j3ef6mToHiKuTcnW+RFro5GKbWpa1+uQOgjzmEWA+cPGjtVMGhQhM7Z2I
         T0pVXkXfdL1EwsSmRmFfx1gB1hEUewnZ4vGHeyDR4rEHuI6VAFgYqekxMlIB3SWUtPj+
         xrUfpWt1FpfPOtn3v5GsKp3zZWw2/DnELQA5EiyOT+aAutDkF1db2/w9WcBVeRqmT6g3
         dNuVIMdbJ/rJCFiuSzjR/WvXuPBc+jfduyZxKOdwd/Gc1GBWRZeHwP8ZkRc3803D7AZm
         q46EL2jLYzcsoSqK2PZDOxXXQMWcuCA+BTUvrtXzvAJ9NTxBzy2Z43cIleMr+TQcPgHr
         xJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769526500; x=1770131300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egAKjuHhaT855DUHA1FAxe6XFNwZVap0/KgXarf4Mf8=;
        b=H3dxFKYG6NMPo3G7gRHHn/ZBoC2D8lUhWCYaHfLVIIW7EHgvfnzyaC6635tdzYcinB
         i6UnC8fRrwUgQVHM1S1nNehnjU4+uQqLbwamEoHe0edkSxkE21zVWUVxWLVJ7gRMTuU5
         1ThhONHe7m6rjQ3H4ISzZWt1nkcUaC74sl/KSmfPT3/6Lqfxtd8KZDX/7Gw2dz8Aqqam
         M0xNENi6mFId4jRPshQAwOMbeg2RlZpvehhnVyLqXT5cTGzmQYhbFQQZZDcxpQE9KY9n
         ZMlBUytcoCopVWLDKNHTqAk2qFuMItZM4DgfL/fpw/75QDejOYZdISGS0Tbl5D58uJpR
         pCgg==
X-Forwarded-Encrypted: i=1; AJvYcCX5ahRq09zNStWg/m2RZR7w8iYLOVlQmdZr/9a4B8mj12eiOFJVMITigIWs+WuVqRwZfq0x+NsxfgoLyl37hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+PSJBgQAEQ3YRacnmU//9CLi9Y5dlBG+3kayVZiecDdqBQZR
	ryB0YXXEnHUHgIenwIM5EDkHFP1EgUaY+lRj/gahQc0YeTy/CNsO+uHOoVnvOfFiRhc=
X-Gm-Gg: AZuq6aKpGOXf9tElcBE65/f2XRfsknaCyNcFXJyWC/rAkUTjReuw/1rqpxqchBcglqk
	FctJVXASpMquFWeveSmFx9msQyC+HZUQEy5NVzwoilC4s3/lUwoXtII7hwcIopt9nZ4CZNuXgCO
	3Bjo8PvyBhx8ihqal/PMEnKPkQJpdLDIZwpVddi8qpivSh8ipVbfbcFFfzgg23sQKInkWiqSp+T
	/fIUtN6zkOaYJYpusic4VDu1rYluoE2J5d/dkAaxB+73kSCeg6XFZrVNR5SJDK8TGvHKGAc2Gk9
	GT5jg/rrjGt3WUuvk8sRLKfdtGoWxOR4phlAbr1JAAgim6W946SKlFHFeeu8Ao3ZWoVDcy8XMzQ
	1s749FGHmoqP8XjEpCco4WYi+ea4AYqMnE3xecGj42bIxW9fdVZFHKwdV3awpUgI/Tb6L58d9pF
	ehr9TSkwD+wVbcw7sB/+0z+aizuE4FRb7ZspwTlp26Bf/PxrLFLryi
X-Received: by 2002:a05:600c:64ce:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-48069c92cacmr23546585e9.32.1769526499517;
        Tue, 27 Jan 2026 07:08:19 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d3b4625sm137458675e9.0.2026.01.27.07.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 07:08:19 -0800 (PST)
Message-ID: <55abccdc-3752-4bb6-b022-42901a8b303f@freebox.fr>
Date: Tue, 27 Jan 2026 16:08:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 1/3] wifi: ieee80211: add some initial
 UHR definitions
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260127141005.583581-5-johannes@sipsolutions.net>
 <20260127151005.7681c4f95202.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260127151005.7681c4f95202.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31234-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2F11096997
X-Rspamd-Action: no action

Hello,

See my comments below:

On 27/01/2026 15:09, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> This is based on Draft P802.11bn_D1.0, but that's still very
> incomplete, so don't handle a number of things and make some
> local decisions such as 40 bits for MAC capabilities etc.
> Also, I fixed the NPCA channel to be 8 instead of 4 bits.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   include/linux/ieee80211-uhr.h | 176 ++++++++++++++++++++++++++++++++++
>   include/linux/ieee80211.h     |  31 +++++-
>   2 files changed, 206 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/ieee80211-uhr.h
>
> diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
> new file mode 100644
> index 000000000000..e57181ba0182
> --- /dev/null
> +++ b/include/linux/ieee80211-uhr.h
> @@ -0,0 +1,176 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * IEEE 802.11 UHR definitions
> + *
> + * Copyright (c) 2025 Intel Corporation
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
> +#define IEEE80211_UHR_NPCA_PARAMS_PRIMARY_CHAN		0x000000FF
So I understand you've changed the NPCA channel to be 8bits instead of 
4. I see it's 8bits in D0.3 but it has been updated to 4bits in both 
D1.0 and D1.2, so I would believe 4bits is the correct value
> +#define IEEE80211_UHR_NPCA_PARAMS_MIN_DUR_THRESH	0x00000F00
> +#define IEEE80211_UHR_NPCA_PARAMS_SWITCH_DELAY		0x0003F000
> +#define IEEE80211_UHR_NPCA_PARAMS_SWITCH_BACK_DELAY	0x00FC0000
> +#define IEEE80211_UHR_NPCA_PARAMS_INIT_QSRC		0x03000000
> +#define IEEE80211_UHR_NPCA_PARAMS_MOPLEN		0x04000000
> +#define IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES	0x08000000
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
> +#define IEEE80211_UHR_MAC_CAP0_ML_PM_SUPP		0x08
FYI this has been converted in Reserved for D1.2
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
I would choose between shrinking `Interval` into either INTV or INTVL 
but not use both
> +#define IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTVL_LOW	0xE0
> +
> +#define IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTVL_LOW	0x03
IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTVL_HIGH
> +#define IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE		0x04
You are missing the bit for Bounded ESS (B34) [BTM Assurance is B35]
> +
> +struct ieee80211_uhr_capa_mac {
> +	u8 mac_cap[5];
> +} __packed;
DBE Capability Parameters is not handled yet? [it's defined in figure 
9-aa8, even if the title of the figure is wrong in D1.0]
> +
> +struct ieee80211_uhr_capa {
> +	struct ieee80211_uhr_capa_mac mac;
> +	u8 variable[];
> +} __packed;
> +
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_LE80		0x01
This is specifically for sounding NDP, I would name them 
IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_XXX instead
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_MU_LE80	0x02
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_160		0x04
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_MU_160		0x08
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_320		0x10
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_MU_320		0x20
> +#define IEEE80211_UHR_PHY_CAP_ELR_RX			0x40
> +#define IEEE80211_UHR_PHY_CAP_ELR_TX			0x80
> +
> +struct ieee80211_uhr_capa_phy {
> +	u8 cap;
> +} __packed;
> +
> +static inline bool ieee80211_uhr_capa_size_ok(const u8 *data, u8 len)
> +{
> +	/* FIXME - DBE */
> +	return len >= sizeof(struct ieee80211_uhr_capa) +
> +		      sizeof(struct ieee80211_uhr_capa_phy);
> +}
> +
> +static inline const struct ieee80211_uhr_capa_phy *
> +ieee80211_uhr_phy_cap(const struct ieee80211_uhr_capa *cap)
> +{
> +	/* FIXME - skip variable DBE stuff, assume not present for now */
> +	return (const void *)&cap->variable;
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
> index fbde215c25aa..3dcfc4acf7d5 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
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
> +	WLAN_EID_EXT_BSS_TRANS_PARAMS = 155,
This is specific for SMD, I feel like WLAN_EID_EXT_SMD_BSS_TRANS_PARAMS 
is more appropriate
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

Best regards,

Pablo MG


