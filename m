Return-Path: <linux-wireless+bounces-34065-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK7qBOF4xmnwKgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34065-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:32:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2973443BA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 852EF3100AAB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD92DCF41;
	Fri, 27 Mar 2026 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="fXFvKDVY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D3391827
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614287; cv=none; b=Dve2m0PpImv+hEmBYXEnvyoAHDdkzzIoe1h41o8ZHZICz7XvJSrr2cqNOQepOkiiASUQnL7pUECPzBcOttbkxLp64y81ItOigQlHrBYa/+veOf7QCuvazk33pAk6QK5VUr4mU6kDVCz7Gp9JmYV2XoJCFYjHg1t8nI5KnQq0Iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614287; c=relaxed/simple;
	bh=Bdw8ZyVtG/zURlf5XnuJI28PXlTI/mMcNdKC5G44Xi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ae0NNIjdebqa2pslq+e+m5BTMXs/3mc4M/lWfBVExXgyGZVRSbqnIwp2NnckjiCCiGSn/HjgLsumillgd8IKeJcn4D1GxQ9SyuQeVfB51WqvXeVaLOXenS35bq2wXfhVuBLUVfCCPjSSgr5NzMnZH55c+ipkF26Z+NeWMlYSuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=fXFvKDVY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b9b1900bso1213556f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774614283; x=1775219083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VE0mUtvaKJh96rGFyMdSjp0T4IgO6SxexlOymySS2hc=;
        b=fXFvKDVYc2MGWqh4n7JjW31M+qLQG89Ka52JMVdmcZYr+fLTiRn4sgrhbxYtcoQ2N5
         wsJgWJjgIchZg+UFBtL2q4F7UZFYKRzVTyRI4m498aM0iYbM8wAqT6mEdGa/hOczQkh2
         w96HJy8UxFG4OFaP1RMlLH6dlYmkjT0UNE/rf6ImFmk74BpOF6z7wFWh61lU3qJNYGf9
         0aspJPfreLf/I7GDbdIErsEnH8zNKBfwetaP2Moo9r7vFIwabpEFCQbaYGog4dme3YvE
         DDIJlIc4KhkThOjQCzncp1/n7SquBpgc5jQs8SA26AWiXnQs0m0CiNvtOLVjd7+H1GcP
         Y3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774614283; x=1775219083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE0mUtvaKJh96rGFyMdSjp0T4IgO6SxexlOymySS2hc=;
        b=CNoPOax/RJhZo7wsKecyi5PbnuGNFD+t8S3X6fcbEZ3h4FW4/OGhAYuVQHNhMnNYLN
         98fNAniBs8D39j6+fUy1f0DH14CQN1gO51O3TVrKGh4SXbTvU0JTvHF+pxLrGy2rYrNt
         Scj5jTq6xhyV2aleyuMbRuXb5qJg2N8LHlGIIrOireRMUwQo/nQK1yh6n4LIEubHCl34
         RW3uV6uV9mAL/KByM/SbiW4mQ8TdDc/TBkd7mkzmZDDhCEa/1K3pdH/6tvpt6qQPBsjj
         uuu+YR/Ee5ANuCvagmmNJvZH1ArL0XGOaZz8DhpOB0BD4mqRV5N440eEq1M7pyj+ZHx1
         gW8w==
X-Forwarded-Encrypted: i=1; AJvYcCXXOpyqfcaGGmp8Z8WHoX1PP6er1DlX9gNsGJ4DLKqqQTuGLXPpjXPQT1y8WeEGXGbycbZy/vKdOgna/BUpgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2QEAzJpWEb13Bk98HVtEBYRvO1IkY+qFjyWIoT82oTpAMo4P
	0QTaxsaHHVEGIxPYJ86p1EYDSthkeIyzOzcc0wKBgfnmw38qn2hXLNoUzKXfNo3Dts3S/vWL1qx
	8RfeE
X-Gm-Gg: ATEYQzwNQtE+GwBpOu5/09d8JZyn0H23LxHjw6CqOnJ/w38ErmKdIJpCpzlvK2wXGWN
	V03fxEyTrK8tRg3/IBaauUPOUyXdwO4NCKFYnlwCAOrRzXKYa3WsXxLeofKt6CUjymcg4ebxoh/
	LC7O0/URKOXzsJJK041uqv605viMZ75yTjTjGf1ndX9ApfRMZpJB57NvfxOuTmIS7/VIheLjmAg
	dR1upwyZ3D9UqikXDyoe+2yMxRGlYBkTFDV8XRQtPORwD6365PEdKKIGTGTQ8B7d5h7GuAT9FbW
	Z20CV0DbUdpXeuKP+kCjn9p90wzv/fsAhVL3EgZWeK0v0ri3O/S+8bofxa9xiaWXICuP5RGxl2e
	MKkKs3LKHraxO4sJ27T0JpFk0e6/Va7o66WkdLp2uPuAE41a6D0yxCt/ROczijbEETFFABOQlz2
	npC/yv07TbbZcOfQe38jZpJ/h2793A3+tzMXiXLVsR4aNysZW9TiEU6tsaNlCtlVYIKO2bJerT
X-Received: by 2002:a05:6000:2c04:b0:43b:5022:7fa with SMTP id ffacd0b85a97d-43b9e9e840dmr3823607f8f.13.1774614282710;
        Fri, 27 Mar 2026 05:24:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:71:7cc0:9f51:a89f:3777:bbea? ([2a01:e0a:71:7cc0:9f51:a89f:3777:bbea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7372sm16442078f8f.34.2026.03.27.05.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 05:24:42 -0700 (PDT)
Message-ID: <79228bab-aa6c-4fda-97c9-768b158dfa3a@freebox.fr>
Date: Fri, 27 Mar 2026 13:24:41 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/19] wifi: mac80211: clean up STA NSS handling
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
 <20260327103659.5296c2f3a949.I97fb93ccc1b366110ab23de58fcd73676cdd85d6@changeid>
Content-Language: en-US
From: Pablo MG <pmartin-gomez@freebox.fr>
In-Reply-To: <20260327103659.5296c2f3a949.I97fb93ccc1b366110ab23de58fcd73676cdd85d6@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-34065-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,freebox.fr:mid]
X-Rspamd-Queue-Id: 5F2973443BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

If we are doing some cleanup, let's go full on it.

Le 27/03/2026 à 10:31, Johannes Berg a écrit :
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Move ieee80211_sta_init_nss() from VHT code to station code,
> and disentangle it from rate control. This way, it becomes
> clearer when 'rx_nss' is set up.
> 
> While doing this, fix the client side code to set up
> link_sta->op_mode_nss instead of link_sta->pub->rx_nss for
> the opmode element in association response, and remove the
> (now wrong) comment about handling that in the function.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   net/mac80211/ibss.c        |  2 +
>   net/mac80211/ieee80211_i.h |  2 +-
>   net/mac80211/mesh_plink.c  |  2 +
>   net/mac80211/mlme.c        | 11 +++--
>   net/mac80211/ocb.c         |  4 +-
>   net/mac80211/rate.c        |  4 +-
>   net/mac80211/sta_info.c    | 92 +++++++++++++++++++++++++++++++++++++
>   net/mac80211/sta_info.h    |  1 +
>   net/mac80211/vht.c         | 93 --------------------------------------
>   9 files changed, 108 insertions(+), 103 deletions(-)
> 
[...]
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index b3a016f3736b..31cf45095c60 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -3401,6 +3401,98 @@ void ieee80211_sta_remove_link(struct sta_info *sta, unsigned int link_id)
>   	sta_remove_link(sta, link_id, true);
>   }
>   
> +void ieee80211_sta_init_nss(struct link_sta_info *link_sta)
> +{
> +	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
> +	bool support_160;
`support_160` is only used by the `has_he` block, better define it only 
there.
> +
> +	if (link_sta->pub->eht_cap.has_eht) {
> +		int i;
> +		const u8 *rx_nss_mcs = (void *)&link_sta->pub->eht_cap.eht_mcs_nss_supp;
> +
> +		/* get the max nss for EHT over all possible bandwidths and mcs */
> +		for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
> +			eht_rx_nss = max_t(u8, eht_rx_nss,
> +					   u8_get_bits(rx_nss_mcs[i],
> +						       IEEE80211_EHT_MCS_NSS_RX));
> +	}
> +
> +	if (link_sta->pub->he_cap.has_he) {
> +		int i;
> +		u8 rx_mcs_80 = 0, rx_mcs_160 = 0;
> +		const struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
> +		u16 mcs_160_map =
> +			le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
> +		u16 mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
> +
> +		for (i = 7; i >= 0; i--) {
> +			u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
> +
> +			if (mcs_160 != IEEE80211_HE_MCS_NOT_SUPPORTED) {
> +				rx_mcs_160 = i + 1;
> +				break;
> +			}
> +		}
Why go throught the trouble of parsing `mcs_160_map` if `support_160` is 
false ?
> +		for (i = 7; i >= 0; i--) {
> +			u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
> +
> +			if (mcs_80 != IEEE80211_HE_MCS_NOT_SUPPORTED) {
> +				rx_mcs_80 = i + 1;
> +				break;
> +			}
> +		}
> +
> +		support_160 = he_cap->he_cap_elem.phy_cap_info[0] &
> +			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
> +
> +		if (support_160)
> +			he_rx_nss = min(rx_mcs_80, rx_mcs_160);
Pretty sure this is an error, everywhere else we are taking the max NSS 
but here we are taking the min ?!
> +		else
> +			he_rx_nss = rx_mcs_80;
> +	}
> +
> +	if (link_sta->pub->ht_cap.ht_supported) {
> +		if (link_sta->pub->ht_cap.mcs.rx_mask[0])
> +			ht_rx_nss++;
> +		if (link_sta->pub->ht_cap.mcs.rx_mask[1])
> +			ht_rx_nss++;
> +		if (link_sta->pub->ht_cap.mcs.rx_mask[2])
> +			ht_rx_nss++;
> +		if (link_sta->pub->ht_cap.mcs.rx_mask[3])
> +			ht_rx_nss++;
> +		/* FIXME: consider rx_highest? */
> +	}
> +
> +	if (link_sta->pub->vht_cap.vht_supported) {
> +		int i;
> +		u16 rx_mcs_map;
> +
> +		rx_mcs_map = le16_to_cpu(link_sta->pub->vht_cap.vht_mcs.rx_mcs_map);
> +
> +		for (i = 7; i >= 0; i--) {
> +			u8 mcs = (rx_mcs_map >> (2 * i)) & 3;
> +
> +			if (mcs != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
> +				vht_rx_nss = i + 1;
> +				break;
> +			}
> +		}
> +		/* FIXME: consider rx_highest? */
> +	}
> +
> +	rx_nss = max(vht_rx_nss, ht_rx_nss);
> +	rx_nss = max(he_rx_nss, rx_nss);
> +	rx_nss = max(eht_rx_nss, rx_nss);
> +	rx_nss = max_t(u8, 1, rx_nss);
> +	link_sta->capa_nss = rx_nss;
> +
> +	if (link_sta->op_mode_nss)
> +		link_sta->pub->rx_nss =
> +			min_t(u8, rx_nss, link_sta->op_mode_nss);
> +	else
> +		link_sta->pub->rx_nss = rx_nss;
> +}
> +
>   void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
>   					   const u8 *ext_capab,
>   					   unsigned int ext_capab_len)
[...]

Pablo MG

