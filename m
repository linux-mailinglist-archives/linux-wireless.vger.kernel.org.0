Return-Path: <linux-wireless+bounces-34732-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BAhJYzf3WkYkgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34732-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:32:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ECC3F5F78
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B139030156FF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2460B3537FA;
	Tue, 14 Apr 2026 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eKMs4xN+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE184A0C;
	Tue, 14 Apr 2026 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148361; cv=none; b=qbcN6BPL8Fh7/PxYEIt1uJLEqR0tRyB+/BR3vowbQ5l3suKpRvoo5khb6xGVnv3pPnoQXXRsM1hG9S7e4EUestyvX9z8kvxlKGt8ugP3aLPxeCEeZefcWt8lVqg+c3HPVZ6us+YnE/Lk3BdVSTnfYKFcBog2fh8rzGAHdGcWCCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148361; c=relaxed/simple;
	bh=WonIuD+EUoc8rtGk5o3trLSbmvOMKpcqBPExt7B6C9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tfFAkrfpbhAfVfH/qIDvBa1TjpMP7ww5k/2rLwIxvZOtY5A73QupfH1HSPniNjd6rOI+WBYcIyYx8imjIyeEyU+2iwZ4VY6eQ4lbHESa+ujHZlThWykQ05PYyA5IIYIGslesNA8Q5d7rqz8bn2P4SGEEKEEKMF1rNV+hEz4S42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eKMs4xN+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63E6WZPg81518040, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776148355; bh=ykQIfXQs7sxmZNFzaPrcCFQTpx6+Mtt2NBcP9VryOtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eKMs4xN+kFB8IBpV3RQxCu4xpwgQad/qr9F/GDTRzn79LgMAiwTQy5hMFNfA/qkMF
	 qdHPdMMmLNzhgTOm5Cw8pZWfGV7F5sArMNDWhHfozrQmb+U9siaMapSmYBA99oHpbo
	 lnGeGJ4f5ig2brWCwh0m+LP38kRmJzr+OHfxIUa033kykTJvtZ9ul2VLIB5A0uSlU9
	 Cdrw2m4qpJnj+muPRylke43zLMfsSw7P6fenhCdpAx22Hd3Lzy960D92uzba3JRQOI
	 vVLFqMtQB3+g7EJiz4P0P09+Hqdma3POG02BmyzmZ/IKui1JuvrydAJbqtOwTTqGDz
	 9qiMOpbhuwLKw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63E6WZPg81518040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 14:32:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 14:32:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 14 Apr 2026 14:32:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Louis Kotze <loukot@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtw89: phy: increase RF calibration timeouts
 for USB transport
Thread-Topic: [PATCH 1/2] wifi: rtw89: phy: increase RF calibration timeouts
 for USB transport
Thread-Index: AQHcyMAfjho2wwle9E6zUT5if/flK7XeHr3g
Date: Tue, 14 Apr 2026 06:32:35 +0000
Message-ID: <c722d16dd57041c8ae1b0b3b386b5cbb@realtek.com>
References: <795a8567fdbe48babc5cf0f2b5e10c0a@realtek.com>
 <20260410080017.82946-1-loukot@gmail.com>
 <20260410080017.82946-2-loukot@gmail.com>
In-Reply-To: <20260410080017.82946-2-loukot@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34732-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12ECC3F5F78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Kotze <loukot@gmail.com> wrote:
> USB transport adds significant latency to H2C/C2H round-trips used
> by RF calibration. The existing timeout values were designed for PCIe
> and are too tight for USB, causing "failed to wait RF DACK",
> "failed to wait RF TSSI" and similar errors on USB adapters.
>=20
> Apply a 4x timeout multiplier when the device uses USB transport.
> The multiplier is applied in rtw89_phy_rfk_report_wait() so all
> calibrations benefit without changing any call sites or PCIe
> timeout values.
>=20
> The 4x multiplier was chosen based on measured data from two
> independent testers (RTL8922AU, 6GHz MLO and 2.4/5GHz):
>=20
>   Calibration   PCIe timeout   Max measured (USB)   4x timeout
>   PRE_NTFY           5ms              1ms              20ms
>   DACK              58ms             72ms             232ms
>   RX_DCK           128ms            374ms             512ms
>   TSSI normal       20ms             24ms              80ms
>   TSSI scan          6ms             14ms              24ms
>   TXGAPK            54ms             18ms             216ms
>   IQK               84ms             53ms             336ms
>   DPK               34ms             30ms             136ms
>=20
> Tested with RTL8922AU on 6GHz MLO (5GHz + 6GHz simultaneous):
> 25 connect/disconnect cycles with zero failures.
>=20
> Signed-off-by: Louis Kotze <loukot@gmail.com>

Looks good to me. But please change comment style.=20

> ---
>  drivers/net/wireless/realtek/rtw89/phy.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wirel=
ess/realtek/rtw89/phy.c
> index e70d0e283..4d809df8b 100644
> --- a/drivers/net/wireless/realtek/rtw89/phy.c
> +++ b/drivers/net/wireless/realtek/rtw89/phy.c
> @@ -3956,6 +3956,13 @@ int rtw89_phy_rfk_report_wait(struct rtw89_dev *rt=
wdev, const char *rfk_name,
>         struct rtw89_rfk_wait_info *wait =3D &rtwdev->rfk_wait;
>         unsigned long time_left;
>=20
> +       /* USB transport adds latency to H2C/C2H round-trips, so RF
> +        * calibrations take longer than on PCIe. Apply a 4x multiplier
> +        * to avoid spurious timeouts.
> +        */

For now, we don't apply networking specific comment style. Keep first line =
'/*'.

> +       if (rtwdev->hci.type =3D=3D RTW89_HCI_TYPE_USB)
> +               ms *=3D 4;
> +
>         /* Since we can't receive C2H event during SER, use a fixed delay=
. */
>         if (test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags)) {
>                 fsleep(1000 * ms / 2);
> --
> 2.53.0


