Return-Path: <linux-wireless+bounces-33214-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLxMCc4TtGlkgwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33214-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:40:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 969F8284111
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5437531125D6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1327329E40;
	Fri, 13 Mar 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="iQaFVNF6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94E3921D8;
	Fri, 13 Mar 2026 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408396; cv=none; b=S5OTzJ4wbS6MgK5fAfTtSAy/tgycGtaNIH8jZT+clDk0oSY6HkCyZKmKU+c8o1qaReqYP+wnTk5o7m8H8Dmv5o09kSGqKsBn71N3WSxo7MmI32d/p/0+l2jeVLKGVfy67qEt9uJtFx473iP0QvxwgZRlAeiowVuiRCetMfrFE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408396; c=relaxed/simple;
	bh=559YGIEhOLLEOi1GsznO54wkHlftgHkw+cTrAsCa1oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upyl9coHlXlpxpH8aE10Vs+afIm/1BdDmup2Q6s3QQH8nuKoSbe4/dj/go7iAgTZ/nMnLUFvvd2AQ/kotNwb5x287OdVRFLE69IcrPj6dUepvPRDXkZ+VluhLFiICRGRX9akoz/+xj0yUdLX1kRt5boJuc4yICvemWN4MndB2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=iQaFVNF6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773408392; x=1774013192; i=georgmueller@gmx.net;
	bh=jh1cT20ZWVuQGN3wYliE6B4udxMB6THc0W2OmXROhIY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iQaFVNF6sDECDXNj2xf/9s2CjjhbYI8J+qOJsO555VkirhEbJsbuCOihIFZC9Zkj
	 mjr99Cw//BCEq2CkMS1fQASAb0zUUxu3Ir19kvRcUzKuWRBapWyndafYrsIjwKpwh
	 D8bArTWJx6/rvM+IBqH8ZzLo8IN48KZKZJQQxsSPYXc53jmNfsmKaMFu1Ei67oRVS
	 Ns7LIdhPkwclm+IjIVsPG9qlSNOwDC53qb01Q1Mg4qWTHzPb7HyqeBfTwdzR3IigT
	 rsTTq1oV7R6BUSljnNNSGNDWlGUPjyii3Iuc49Dk2hiZ08JMFPX8QxQb+H0B2fEtM
	 q0rjASKeyAQfOsTTSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1vlr601sb2-00y3q9; Fri, 13
 Mar 2026 14:26:32 +0100
Message-ID: <6a18ac72-f2aa-43da-86b9-92207d28c93c@gmx.net>
Date: Fri, 13 Mar 2026 14:26:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/4] wifi: rtl8xxxu: update max report mac id on
 station add / remove for 8188e chips
To: Jes.Sorensen@gmail.com, rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260313131849.3148013-1-georgmueller@gmx.net>
 <20260313131849.3148013-4-georgmueller@gmx.net>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
In-Reply-To: <20260313131849.3148013-4-georgmueller@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sF0nROS6y+F5cETqR4AtSE12k5xD35FLujXlPNjYbBM0ynbEy7G
 iFH7CPno6gBF+lJr72e2VPSLAZAwilCeXlg+6ENHGFv9Yxk8kGrHMQvI92s+Kn3i9lFD4vA
 PsvCYzBJf5F/MooCtTX++mbgMVxV6xsKs+6+1RmeBvntLYIceAWDNkfwdiSk+Buj6Ej6F/g
 KX3TTVNdjm19O/vFkj8Kw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:91m+hwquu2A=;N9TI3J1oy9adHceqdlDzxZGlam/
 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
 tPx2WbHwHds
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33214-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmx.net];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 969F8284111
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Am 13.03.26 um 14:18 schrieb Georg M=C3=BCller:
> ---
>   drivers/net/wireless/realtek/rtl8xxxu/core.c | 22 +++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/=
wireless/realtek/rtl8xxxu/core.c
> index ea4dcca9d22a..6d97bb212f75 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -3884,6 +3884,15 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *pr=
iv)
>   	rtl8xxxu_write8(priv, REG_RSV_CTRL, val8);
>   }
>  =20
> +static u8 rtl8xxxu_max_acquired_macid(struct rtl8xxxu_priv *priv)
> +{
> +	u8 macid;
> +
> +	macid =3D find_last_bit(priv->mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
> +
> +	return macid;
> +}
> +
>   static u8 rtl8xxxu_acquire_macid(struct rtl8xxxu_priv *priv)
>   {
>   	u8 macid;
> @@ -7499,6 +7508,7 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *h=
w,
>   	struct rtl8xxxu_sta_info *sta_info =3D (struct rtl8xxxu_sta_info *)st=
a->drv_priv;
>   	struct rtl8xxxu_vif *rtlvif =3D (struct rtl8xxxu_vif *)vif->drv_priv;
>   	struct rtl8xxxu_priv *priv =3D hw->priv;
> +	u8 max_mac_id;
>  =20
>   	mutex_lock(&priv->sta_mutex);
>   	ewma_rssi_init(&sta_info->avg_rssi);
> @@ -7510,6 +7520,11 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *=
hw,
>   			return -ENOSPC;
>   		}
>  =20
> +		if (priv->rtl_chip =3D=3D RTL8188E) {
> +			max_mac_id =3D rtl8xxxu_max_acquired_macid(priv);
> +			rtl8xxxu_write8(priv, REG_TX_REPORT_CTRL + 1, max_mac_id + 1);
> +		}
> +
>   		rtl8xxxu_refresh_rate_mask(priv, 0, sta, true);
>   		priv->fops->report_connect(priv, sta_info->macid, H2C_MACID_ROLE_STA=
, true);
>   	} else {
> @@ -7537,8 +7552,13 @@ static int rtl8xxxu_sta_remove(struct ieee80211_h=
w *hw,
>   	struct rtl8xxxu_priv *priv =3D hw->priv;

sorry: declaration "u8 max_mac_id;" is missing here. This was lost when co=
pying back from my test VM.

>   	mutex_lock(&priv->sta_mutex);
> -	if (vif->type =3D=3D NL80211_IFTYPE_AP)
> +	if (vif->type =3D=3D NL80211_IFTYPE_AP) {
>   		rtl8xxxu_release_macid(priv, sta_info->macid);
> +		if (priv->rtl_chip =3D=3D RTL8188E) {
> +			max_mac_id =3D rtl8xxxu_max_acquired_macid(priv);
> +			rtl8xxxu_write8(priv, REG_TX_REPORT_CTRL + 1, max_mac_id + 1);
> +		}
> +	}
>   	mutex_unlock(&priv->sta_mutex);
>  =20
>   	return 0;


