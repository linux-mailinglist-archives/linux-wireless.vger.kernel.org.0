Return-Path: <linux-wireless+bounces-34404-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLZGBMRT1GnhtAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34404-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:45:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 810533A8813
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4292E301F167
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 00:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D8F4C6C;
	Tue,  7 Apr 2026 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hC5HwtgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6013FEE
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522753; cv=none; b=Yz5U9R0eY9xPYG7HoveX//8gNKf3Wge8uGugghlkiweXQIIykK/V/dqeb3Kiz2gbfWhY5RywIitcYL/2zbQ18h3xRRgLjc30kjjNYt4onR+DKfmiZ2rcueXQarYq8mlNf21ElfMaA6RvUvVBzbNyVU70LfEdgL95mqmYAU1vQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522753; c=relaxed/simple;
	bh=h6/CWYK64hZdpnkpxEp1V1BEnV1k2Q97XTPCLOYZLnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sfmQotW8K5qmZvnCmgD4bRwdagrcGyNeCgbJvZUB+mHxjRFuvp4gu/NAiVSKAyyJstS/X+RrjkB31OvWFmFl4+C8ddLCNts5eByFGsJjuahidZxdPEaw6TO+WpyErqkXEFfR7RSLEQmvVxihRk8bXoqtwMgu9exCkTMoESQ2qyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hC5HwtgR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6370jfUaB4186282, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775522741; bh=UslwYroS3YqntyP92ZnqAD/4F4EtsgwUccj/HwM2FVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hC5HwtgREo2df6hOsWyyfB3FkJDfBASK8niAO/3xhyjBZ3KzCsrbG/IIXaiDd/2qS
	 OEzIMFdHLLcch18Mp6cQqbsBTDOP/JRZ8oMev14zEvyUM9eiQ/iclpdtC4nl91qwau
	 mJ57NE4TSMsegBXM3cP2xP/6CtQPWnjjC7TBrNJSEKn+S0Z3nFcCS/BQVHt4CFShqM
	 ylixCrl94/6pAwox0CS5NZd3PZ10vWou++FWMtg6LIqoOsRzOxHi+l7grc3PBQVWQl
	 i3qiPQxM2Wqxcqn0OugsjMD3EI23b14RskmyJlMZ7TZdxkvxcKHh47bDV2V7z4ySdw
	 NpCjsUV3ErjPw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6370jfUaB4186282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 08:45:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 7 Apr 2026 08:45:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 7 Apr 2026 08:45:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 7 Apr 2026 08:45:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
CC: "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtlwifi: rtl8821ae: Remove dead code in
 rtl8821ae_update_hal_rate_table()
Thread-Topic: [PATCH] rtlwifi: rtl8821ae: Remove dead code in
 rtl8821ae_update_hal_rate_table()
Thread-Index: AQHcw4qRCOppWt5udkW4QOvR3fba7LXSyDqw
Date: Tue, 7 Apr 2026 00:45:41 +0000
Message-ID: <f801f866b83c49cda398c7e167e48b51@realtek.com>
References: <20260403165416.131684-1-chelsyratnawat2001@gmail.com>
In-Reply-To: <20260403165416.131684-1-chelsyratnawat2001@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34404-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 810533A8813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chelsy Ratnawat <chelsyratnawat2001@gmail.com> wrote:
> Sent: Saturday, April 4, 2026 12:54 AM
> The variable 'mimo_ps' is initialized to IEEE80211_SMPS_OFF and never
> modified throughout the function. This makes the condition checking for
> IEEE80211_SMPS_STATIC always evaluate to false, rendering the entire
> if-branch unreachable dead code.
>=20
> The error was reported by Coverity Scan.
>=20
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
>  .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> index 3a4a33476205..81d36041a79b 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> @@ -3257,7 +3257,6 @@ static void rtl8821ae_update_hal_rate_table(struct =
ieee80211_hw *hw,
>         u32 ratr_value;
>         u8 ratr_index =3D 0;
>         u8 b_nmode =3D mac->ht_enable;
> -       u8 mimo_ps =3D IEEE80211_SMPS_OFF;
>         u16 shortgi_rate;
>         u32 tmp_ratr_value;
>         u8 curtxbw_40mhz =3D mac->bw_40;
> @@ -3288,19 +3287,15 @@ static void rtl8821ae_update_hal_rate_table(struc=
t ieee80211_hw *hw,
>         case WIRELESS_MODE_N_24G:
>         case WIRELESS_MODE_N_5G:
>                 b_nmode =3D 1;
> -               if (mimo_ps =3D=3D IEEE80211_SMPS_STATIC) {
> -                       ratr_value &=3D 0x0007F005;
> -               } else {
> -                       u32 ratr_mask;
> +               u32 ratr_mask;

Declare local variable at top of scope or function.

Otherwise, looks fine to me.=20

>=20
> -                       if (get_rf_type(rtlphy) =3D=3D RF_1T2R ||
> -                           get_rf_type(rtlphy) =3D=3D RF_1T1R)
> -                               ratr_mask =3D 0x000ff005;
> -                       else
> -                               ratr_mask =3D 0x0f0ff005;
> +               if (get_rf_type(rtlphy) =3D=3D RF_1T2R ||
> +                   get_rf_type(rtlphy) =3D=3D RF_1T1R)
> +                       ratr_mask =3D 0x000ff005;
> +               else
> +                       ratr_mask =3D 0x0f0ff005;
>=20
> -                       ratr_value &=3D ratr_mask;
> -               }
> +               ratr_value &=3D ratr_mask;
>                 break;
>         default:
>                 if (rtlphy->rf_type =3D=3D RF_1T2R)
> --
> 2.43.0


