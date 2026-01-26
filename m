Return-Path: <linux-wireless+bounces-31170-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA/2EyA9d2mMdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31170-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:08:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4865866F7
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47D30302D0E6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A2A30149F;
	Mon, 26 Jan 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="JXWlXr+z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD609315D22
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421896; cv=none; b=CpnorDJnTNj2n9AqBhGKH/kAbdohvJu72Tr5KInulaA5JJNJJUZATLdNtMkGfIoEeFqCHpDXG8fZX0mIFxELYyezoJo/1tzIrn1Wpc+GQQMd7vvzM3rCGAu4SCje9Iv1JgqNB8804WsjjJoA5RAo8tZFudEwcGZ1w2G7rcc3nZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421896; c=relaxed/simple;
	bh=uCz3E4WmOWLA6FPF9mYh+HtP1MrmQ54eayGQ9BDA8FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdtILFg4G85ZcZdQQm9xR/Hn/HK88uruE+Zww6qP1fjiemzy0ltOLCfHoqtRjPFl7MH6f6NkDE3hqN9jotrF67g5S1HN+zQirqg601u0A+itkvUIA+kee2e+nkzPKRI8qQJM48f0RgUJzPkOlHFTCj+e4cV9bMvcae36hvwWuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=JXWlXr+z; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id EBE1E2100A;
	Mon, 26 Jan 2026 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1769421297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c6SLZHWmi3bG47uXLjitlBWU8dCnV9F9bNYLjpvzGDo=;
	b=JXWlXr+z/H6t0c/RyhH2cc37C/M3U7DRo0wts1vHN3vsYQJbz+1UwM5rKwJ+80VHfmP/Sv
	JoS0nfdtypBj268eI6iLcbx/X3rhqxbvnj59ef4dq9AYIEp0XVB5Of1TMrXoAkIvOJIbqn
	aBstN6HxnSc/cVIgpHviP6cF379rcq0=
From: Sven Eckelmann <sven@narfation.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Allen Ye <allen.ye@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject:
 Re: [PATCH v1] wifi: mt76: fix backoff fields and max_power calculation
Date: Mon, 26 Jan 2026 10:54:51 +0100
Message-ID: <3594635.QJadu78ljV@ripper>
In-Reply-To:
 <e92213f793f9cb9f509c26205e7ecb2be6ce77aa.1769156922.git.ryder.lee@mediatek.com>
References:
 <e92213f793f9cb9f509c26205e7ecb2be6ce77aa.1769156922.git.ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1952104.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31170-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4865866F7
X-Rspamd-Action: no action

--nextPart1952104.CQOukoFCf9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Date: Mon, 26 Jan 2026 10:54:51 +0100
Message-ID: <3594635.QJadu78ljV@ripper>
MIME-Version: 1.0

Please change your prefix from [PATCH v1] to [PATCH mt76 v1].

On Friday, 23 January 2026 10:32:34 CET Ryder Lee wrote:
> From: Allen Ye <allen.ye@mediatek.com>
> 
> The maximum power value may exist in data or backoff field.
> To reponse the correct value of txpower, mt76 should also consider
> these values in sku table.
> 
> Fixes: b05ab4be9fd7 (wifi: mt76: mt7915: add bf backoff limit table support)
> Signed-off-by: Allen Ye <allen.ye@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> v1 - add "wifi:" prefix into subject


Please send your patches before submission through checkpatch. Tools like 
b4 [1] can help you to have a good workflow by reminding your about this
(and provide good templates for many other things)


WARNING: 'reponse' may be misspelled - perhaps 'response'?
#126: 
To reponse the correct value of txpower, mt76 should also consider
   ^^^^^^^

WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: b05ab4be9fd7 ("wifi: mt76: mt7915: add bf backoff limit table support")'
#129: 
Fixes: b05ab4be9fd7 (wifi: mt76: mt7915: add bf backoff limit table support)

ERROR: that open brace { should be on the previous line
#173: FILE: drivers/net/wireless/mediatek/mt76/eeprom.c:319:
+       static const u8 connac3_table[] =
+               {1, 2, 3, 4, 5, 2, 3, 4, 5, 3, 4, 5, 4, 5, 5};

ERROR: that open brace { should be on the previous line
#175: FILE: drivers/net/wireless/mediatek/mt76/eeprom.c:321:
+       static const u8 connac2_table[] =
+               {1, 2, 3, 4, 2, 3, 4, 3, 4, 4, 0, 0, 0, 0, 0};

CHECK: Macro argument reuse 'arr' - possible side-effects?
#288: FILE: drivers/net/wireless/mediatek/mt76/eeprom.c:462:
+#define __apply_array_limit(arr, type)                                         \
+       mt76_apply_array_limit(dev, (arr), ARRAY_SIZE(arr), val, target_power,  \
+                              txs_delta, &max_power, n_chains, type)

CHECK: Macro argument reuse 'arr' - possible side-effects?
#292: FILE: drivers/net/wireless/mediatek/mt76/eeprom.c:466:
+#define __apply_multi_array_limit(arr, type)                                   \
+       mt76_apply_multi_array_limit(dev, (arr)[0], ARRAY_SIZE((arr)[0]),       \
+                                    ARRAY_SIZE(arr), val, len, target_power,   \
+                                    txs_delta, &max_power, n_chains, type)

total: 2 errors, 2 warnings, 2 checks, 233 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.


>  static void
> -mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const s8 *data,
> -		       s8 target_power, s8 nss_delta, s8 *max_power)
> +mt76_apply_array_limit(struct mt76_dev *dev, s8 *pwr, size_t pwr_len,
> +		       const s8 *data, s8 target_power, s8 nss_delta,
> +		       s8 *max_power, int n_chains, enum mt76_sku_type type)
>  {
>  	int i;
>  
> @@ -316,18 +337,50 @@ mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const s8 *data,
>  		return;
>  
>  	for (i = 0; i < pwr_len; i++) {
> -		pwr[i] = min_t(s8, target_power, data[i] + nss_delta);
> +		s8 backoff_delta, delta = mt76_tx_power_path_delta(n_chains);

Please avoid multiple function declarations per line. "To this end, use just 
one data declaration per line (no commas for multiple data declarations)"

This also looks on the first glance like destructuring (which doesn't exist 
in C).

> +		int backoff_n_chains = 0;
> +
> +		switch (type) {
> +		case MT76_SKU_RATE:
> +			pwr[i] = min_t(s8, target_power, data[i] + nss_delta);
> +			break;
> +		case MT76_SKU_BACKOFF:
> +			backoff_n_chains = mt76_backoff_n_chains(dev, i);
> +			backoff_delta = mt76_tx_power_path_delta(backoff_n_chains);
> +			pwr[i] = min_t(s8, target_power + delta - backoff_delta,
> +				       data[i] + nss_delta);
> +			break;
> +		case MT76_SKU_BACKOFF_BF_OFFSET:
> +			backoff_n_chains = mt76_backoff_n_chains(dev, i + 1);
> +			backoff_delta = mt76_tx_power_path_delta(backoff_n_chains);
> +			pwr[i] = min_t(s8, target_power + delta - backoff_delta,
> +				       data[i] + nss_delta);
> +			break;
> +		default:
> +			return;
> +		}

Instead of calculating something different in every case, couldn't this be harmonized as

		int backoff_n_chains;
		s8 backoff_delta;
		s8 delta;

		switch (type) {
		case MT76_SKU_RATE:
			delta = 0;
			backoff_n_chains = 0;
			backoff_delta = 0;
			break;
		case MT76_SKU_BACKOFF:
			delta = mt76_tx_power_path_delta(n_chains);
			backoff_n_chains = mt76_backoff_n_chains(dev, i);
			backoff_delta = mt76_tx_power_path_delta(backoff_n_chains);
			break;
		case MT76_SKU_BACKOFF_BF_OFFSET:
			delta = mt76_tx_power_path_delta(n_chains);
			backoff_n_chains = mt76_backoff_n_chains(dev, i + 1);
			backoff_delta = mt76_tx_power_path_delta(backoff_n_chains);
			break;
		default:
			return;
		}

		pwr[i] = min_t(s8, target_power + delta - backoff_delta, data[i] + nss_delta);

or

		u8 backoff_chain_idx = i;
		int backoff_n_chains;
		s8 backoff_delta;
		s8 delta;

		switch (type) {
		case MT76_SKU_RATE:
			delta = 0;
			backoff_n_chains = 0;
			backoff_delta = 0;
			break;
		case MT76_SKU_BACKOFF:
			backoff_chain_index += 1;
			fallthrough;
		case MT76_SKU_BACKOFF_BF_OFFSET:
			delta = mt76_tx_power_path_delta(n_chains);
			backoff_n_chains = mt76_backoff_n_chains(dev, backoff_chain_idx);
			backoff_delta = mt76_tx_power_path_delta(backoff_n_chains);
			break;
		default:
			return;
		}

		pwr[i] = min_t(s8, target_power + delta - backoff_delta, data[i] + nss_delta);

[...]
>  static void
> -mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
> -			     const s8 *data, size_t len, s8 target_power,
> -			     s8 nss_delta)
> +mt76_apply_multi_array_limit(struct mt76_dev *dev, s8 *pwr, size_t pwr_len,
> +			     s8 pwr_num, const s8 *data, size_t len,
> +			     s8 target_power, s8 nss_delta, s8 *max_power,
> +			     int n_chains, enum mt76_sku_type type)
>  {
>  	int i, cur;
> -	s8 max_power = -128;
> +
> +#define connac2_backoff_ru_idx	2

why this define in the middle of the function? Should this be in a header? 
Should it just be a const?

>  
>  	if (!data)
>  		return;
> @@ -337,8 +390,13 @@ mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
>  		if (len < pwr_len + 1)
>  			break;
>  
> -		mt76_apply_array_limit(pwr + pwr_len * i, pwr_len, data + 1,
> -				       target_power, nss_delta, &max_power);
> +		if (!is_mt799x(dev) && type == MT76_SKU_BACKOFF &&
> +		    i > connac2_backoff_ru_idx)
> +			type = MT76_SKU_BACKOFF_BF_OFFSET;

Can you please explain in the commit message how this format is structured. So 
why everything after the third line of the expanded multi-array limit must be 
considered a MT76_SKU_BACKOFF_BF_OFFSET? Adding some kernel-doc to each item in
enum mt76_sku_type might help too.

I have only seen one device in the wild (MT7905DAN + MT7975DN) which actually 
uses the DT for the limits
https://github.com/openwrt/openwrt/blob/17d45f677b0eb1da3c8190a2778fcdfcd9ecd234/target/linux/ramips/dts/mt7621_plasmacloud_pax1800-lite.dts#L11
And there, it just uses the 2T1ss to the place where 1T1ss might be for beamforming.
And this field doesn't seem to make a lot of sense (beamforming with 1 antennna?)
and needs to be skipped.

So yes, I can answer it by looking at some code I've used before for converting 
some CSV [2] to DT entries:

    rates_table = {
        "paths-cck": [
            row[0:4],
        ],
        "paths-ofdm": [
            row[4:8],
        ],
        "paths-ofdm-bf": [
            [
                row[8],
                *row[8:11],
            ],  # duplicating first entry because it is needed in DTS but will not actually be used
        ],
        "paths-ru": compress_rates(
            [
                [1, *row[87:97]],  # RU26
                [1, *row[107:117]],  # RU52
                [1, *row[127:137]],  # RU106
                [1, *row[11:21]],  # BW20 (HT/VHT)
                [1, *row[30:40]],  # BW40 (HT/VHT)
                [1, *row[49:59]],  # BW80 (HT/VHT)
                [1, *row[68:78]],  # BW160 (HT/VHT)
            ]
        ),
        "paths-ru-bf": compress_rates(
            [
                [1, *row[97:107]],  # RU26
                [1, *row[117:127]],  # RU52
                [1, *row[137:147]],  # RU106
                [
                    1,
                    row[21],
                    *row[21:30],
                ],  # BW20 (HT/VHT), duplicating first entry
                [
                    1,
                    row[40],
                    *row[40:49],
                ],  # BW40 (HT/VHT), duplicating first entry
                [
                    1,
                    row[59],
                    *row[59:68],
                ],  # BW80 (HT/VHT), duplicating first entry
                [
                    1,
                    row[78],
                    *row[78:87],
                ],  # BW160 (HT/VHT), duplicating first entry
            ]
        ),
    }

But it would be good to have this written down somewhere.



> @@ -360,18 +418,11 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
>  	struct device_node *np;
>  	const s8 *val;
>  	char name[16];
> -	u32 mcs_rates = dev->drv->mcs_rates;
> -	u32 ru_rates = ARRAY_SIZE(dest->ru[0]);
>  	char band;
>  	size_t len;
> -	s8 max_power = 0;
> -	s8 max_power_backoff = -127;
> +	s8 max_power = -127;
>  	s8 txs_delta;
>  	int n_chains = hweight16(phy->chainmask);
> -	s8 target_power_combine = target_power + mt76_tx_power_path_delta(n_chains);
> -
> -	if (!mcs_rates)
> -		mcs_rates = 10;
>  
>  	memset(dest, target_power, sizeof(*dest) - sizeof(dest->path));
>  	memset(&dest->path, 0, sizeof(dest->path));
> @@ -408,47 +459,51 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
>  
>  	txs_delta = mt76_get_txs_delta(np, hweight16(phy->chainmask));
>  
> +#define __apply_array_limit(arr, type)						\
> +	mt76_apply_array_limit(dev, (arr), ARRAY_SIZE(arr), val, target_power,	\
> +			       txs_delta, &max_power, n_chains, type)
> +
> +#define __apply_multi_array_limit(arr, type)					\
> +	mt76_apply_multi_array_limit(dev, (arr)[0], ARRAY_SIZE((arr)[0]),	\
> +				     ARRAY_SIZE(arr), val, len, target_power,	\
> +				     txs_delta, &max_power, n_chains, type)
> +
>  	val = mt76_get_of_array_s8(np, "rates-cck", &len, ARRAY_SIZE(dest->cck));
> -	mt76_apply_array_limit(dest->cck, ARRAY_SIZE(dest->cck), val,
> -			       target_power, txs_delta, &max_power);
> -
> -	val = mt76_get_of_array_s8(np, "rates-ofdm",
> -				   &len, ARRAY_SIZE(dest->ofdm));
> -	mt76_apply_array_limit(dest->ofdm, ARRAY_SIZE(dest->ofdm), val,
> -			       target_power, txs_delta, &max_power);
> -
> -	val = mt76_get_of_array_s8(np, "rates-mcs", &len, mcs_rates + 1);
> -	mt76_apply_multi_array_limit(dest->mcs[0], ARRAY_SIZE(dest->mcs[0]),
> -				     ARRAY_SIZE(dest->mcs), val, len,
> -				     target_power, txs_delta);
> -
> -	val = mt76_get_of_array_s8(np, "rates-ru", &len, ru_rates + 1);
> -	mt76_apply_multi_array_limit(dest->ru[0], ARRAY_SIZE(dest->ru[0]),
> -				     ARRAY_SIZE(dest->ru), val, len,
> -				     target_power, txs_delta);
> -
> -	max_power_backoff = max_power;
> -	val = mt76_get_of_array_s8(np, "paths-cck", &len, ARRAY_SIZE(dest->path.cck));
> -	mt76_apply_array_limit(dest->path.cck, ARRAY_SIZE(dest->path.cck), val,
> -			       target_power_combine, txs_delta, &max_power_backoff);
> -
> -	val = mt76_get_of_array_s8(np, "paths-ofdm", &len, ARRAY_SIZE(dest->path.ofdm));
> -	mt76_apply_array_limit(dest->path.ofdm, ARRAY_SIZE(dest->path.ofdm), val,
> -			       target_power_combine, txs_delta, &max_power_backoff);
> -
> -	val = mt76_get_of_array_s8(np, "paths-ofdm-bf", &len, ARRAY_SIZE(dest->path.ofdm_bf));
> -	mt76_apply_array_limit(dest->path.ofdm_bf, ARRAY_SIZE(dest->path.ofdm_bf), val,
> -			       target_power_combine, txs_delta, &max_power_backoff);
> -
> -	val = mt76_get_of_array_s8(np, "paths-ru", &len, ARRAY_SIZE(dest->path.ru[0]) + 1);
> -	mt76_apply_multi_array_limit(dest->path.ru[0], ARRAY_SIZE(dest->path.ru[0]),
> -				     ARRAY_SIZE(dest->path.ru), val, len,
> -				     target_power_combine, txs_delta);
> -
> -	val = mt76_get_of_array_s8(np, "paths-ru-bf", &len, ARRAY_SIZE(dest->path.ru_bf[0]) + 1);
> -	mt76_apply_multi_array_limit(dest->path.ru_bf[0], ARRAY_SIZE(dest->path.ru_bf[0]),
> -				     ARRAY_SIZE(dest->path.ru_bf), val, len,
> -				     target_power_combine, txs_delta);
> +	__apply_array_limit(dest->cck, MT76_SKU_RATE);
> +
> +	val = mt76_get_of_array_s8(np, "rates-ofdm", &len, ARRAY_SIZE(dest->ofdm));
> +	__apply_array_limit(dest->ofdm, MT76_SKU_RATE);
> +
> +	val = mt76_get_of_array_s8(np, "rates-mcs", &len,
> +				   ARRAY_SIZE(dest->mcs[0]) + 1);
> +	__apply_multi_array_limit(dest->mcs, MT76_SKU_RATE);
> +
> +	val = mt76_get_of_array_s8(np, "rates-ru", &len,
> +				   ARRAY_SIZE(dest->ru[0]) + 1);
> +	__apply_multi_array_limit(dest->ru, MT76_SKU_RATE);
> +
> +	val = mt76_get_of_array_s8(np, "paths-cck", &len,
> +				   ARRAY_SIZE(dest->path.cck));
> +	__apply_array_limit(dest->path.cck, MT76_SKU_BACKOFF);
> +
> +	val = mt76_get_of_array_s8(np, "paths-ofdm", &len,
> +				   ARRAY_SIZE(dest->path.ofdm));
> +	__apply_array_limit(dest->path.ofdm, MT76_SKU_BACKOFF);
> +
> +	val = mt76_get_of_array_s8(np, "paths-ofdm-bf", &len,
> +				   ARRAY_SIZE(dest->path.ofdm_bf));
> +	__apply_array_limit(dest->path.ofdm_bf, MT76_SKU_BACKOFF_BF_OFFSET);
> +
> +	val = mt76_get_of_array_s8(np, "paths-ru", &len,
> +				   ARRAY_SIZE(dest->path.ru[0]) + 1);
> +	__apply_multi_array_limit(dest->path.ru, MT76_SKU_BACKOFF);
> +
> +	val = mt76_get_of_array_s8(np, "paths-ru-bf", &len,
> +				   ARRAY_SIZE(dest->path.ru_bf[0]) + 1);
> +	__apply_multi_array_limit(dest->path.ru_bf, MT76_SKU_BACKOFF);
> +
> +#undef __apply_array_limit
> +#undef __apply_multi_array_limit

Is such a big style change really necessary for a patch which is a fix 
(according to you)? This might just make it harder to spot the differences and 
might (in some cases) make it harder to backport it to stable kernels.


Regards,
	Sven

[1] https://b4.docs.kernel.org/en/latest/
[2] https://github.com/openwrt/openwrt/pull/20152#issuecomment-3341491145
--nextPart1952104.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaXc56wAKCRBND3cr0xT1
yyaOAP9ynxiwshEHZcAF5pYXJIjwQY3Zk67nu2Hh43ROZN5dIAD+KTwzj/hRWaBe
z4ib3qzbSqnG5qrH+gVCrDpoxQyPgA0=
=NLs/
-----END PGP SIGNATURE-----

--nextPart1952104.CQOukoFCf9--




