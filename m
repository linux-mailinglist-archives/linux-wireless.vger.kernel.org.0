Return-Path: <linux-wireless+bounces-33273-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNKnAwuWt2kMTQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33273-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:32:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1D294CF0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B76B43014951
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 05:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AEC346A14;
	Mon, 16 Mar 2026 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nMEo1Eeh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA17337BBC;
	Mon, 16 Mar 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773639151; cv=none; b=iFtTRzEYLhpEETAT0SHcWvzdhTfzvDWMEBnP/4zBbYT6veivO1ZciLNle6O1BRXKYGjXRWURKERHehE39q5Vj6Vzwpf4TaVkmDGyA1ojACEZIHiUByrjzJ477v6ZXw5sWn33tF7A4b/S5nk+2Hr9fwn5Ltv/V7qUPnDmJKxAqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773639151; c=relaxed/simple;
	bh=6uvMLRrmWBn0c9d5cnqUUCqJsHk+RQ7MNIsulG3f8XY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qml0OAolQ2bNLrgmIfgXB8O0hZSKZKCZWVygh4fD+EvJFKqG1MO4qhonqUXq0JyvLiYbSgZZt5zZRcsd55yvg72FLCbl4UeuLwXJZawe0BUbEgFvWoDd+0751yYfu+rvVSbBNa+L0Zc/6kvhFnH+cISRyfmDEBnl3s12KAqLi2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nMEo1Eeh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G5WOxN41302985, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773639144; bh=cVZF5tOJU32dHKuMrz9L3GdhSEhmX2mA//LW9EkdMr0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nMEo1EehhwjgQJvjIpnCrvd3ZMcSua2CzYYeg9poxApJj3aYL5qNDamkwPihfkW/R
	 bhG4CK9vSXhM9dOP2jyq+hHjmO53HUojuO7d/42GbOQ8KT/e2StW6iBPEhZbk1gywC
	 wjtw6ia+7g27JsdBK9mApdkrNRJXjjiyxwOUS1gn8lcoB5Z7SywdzAYR3DW4JCwiHi
	 LzTQdTqF9KKFM52YhVxo78ODlrpxkfwKbNVtJYE6CuAPnCvUXTxCmxZQnGng6osoiQ
	 tTqnPShnGkY/Wh8z+08ueKy0V2IRcUVjJND7gvmYQgLgyrPWqx9E+abNkQo2BMvwWL
	 ZoQVTzlDPSJUg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G5WOxN41302985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 13:32:24 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 13:32:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 13:32:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 16 Mar 2026 13:32:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christian Hewitt <christianshewitt@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Topic: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Index: AQHcqTNMihHWcqnNfk6dLicVJRRJxLWwuJTw
Date: Mon, 16 Mar 2026 05:32:24 +0000
Message-ID: <a7d421b1d3074a00968f2902c9debb42@realtek.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
In-Reply-To: <20260301042422.195491-1-christianshewitt@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33273-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 65E1D294CF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Christian Hewitt <christianshewitt@gmail.com> wrote:
> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
> physical map dump intermittently fails with -EBUSY during probe.
> The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
> read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
> bit after 1 second.
>=20
> The root cause is a timing race during boot: the WiFi driver's
> chip initialization (firmware download via PCIe) overlaps with the
> Bluetooth firmware download to the same combo chip over USB. This
> can leave the efuse controller temporarily unavailable when the
> WiFi driver attempts to read the efuse map.
>=20
> Add a retry loop (up to 3 attempts with 500ms delays) around the
> physical efuse map dump in rtw89_parse_efuse_map_ax(). The firmware
> download path already retries up to 5 times, but the efuse read
> that follows has no retry logic, making it the weak link in the
> probe sequence.

I'd prefer adding a wrapper to retry 5 times without delay as bottom
changes for reference. If you want to limit retry only for
'dav =3D=3D false' case, it is also fine to me.

>=20
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

[...]

>=20
>  drivers/net/wireless/realtek/rtw89/efuse.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c
> b/drivers/net/wireless/realtek/rtw89/efuse.c
> index a2757a88d55d..d506f04ffd6c 100644
> --- a/drivers/net/wireless/realtek/rtw89/efuse.c
> +++ b/drivers/net/wireless/realtek/rtw89/efuse.c
> @@ -270,6 +270,7 @@ int rtw89_parse_efuse_map_ax(struct rtw89_dev *rtwdev=
)
>         u8 *log_map =3D NULL;
>         u8 *dav_phy_map =3D NULL;
>         u8 *dav_log_map =3D NULL;
> +       int retry;
>         int ret;
>=20
>         if (rtw89_read16(rtwdev, R_AX_SYS_WL_EFUSE_CTRL) & B_AX_AUTOLOAD_=
SUS)
> @@ -289,7 +290,17 @@ int rtw89_parse_efuse_map_ax(struct rtw89_dev *rtwde=
v)
>                 goto out_free;
>         }
>=20
> -       ret =3D rtw89_dump_physical_efuse_map(rtwdev, phy_map, 0, phy_siz=
e,
> false);
> +       for (retry =3D 0; retry < 3; retry++) {
> +               if (retry) {
> +                       rtw89_warn(rtwdev, "efuse dump failed, retrying
> (%d)\n",
> +                                  retry);
> +                       fsleep(500000);
> +               }
> +               ret =3D rtw89_dump_physical_efuse_map(rtwdev, phy_map, 0,
> +                                                   phy_size, false);
> +               if (!ret)
> +                       break;
> +       }
>         if (ret) {
>                 rtw89_warn(rtwdev, "failed to dump efuse physical map\n")=
;
>                 goto out_free;
> --
> 2.43.0

How about retrying 5 times without fsleep(500000)?

diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wirel=
ess/realtek/rtw89/efuse.c
index a2757a88d55d..89d4b1b865f8 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -185,8 +185,8 @@ static int rtw89_dump_physical_efuse_map_dav(struct rtw=
89_dev *rtwdev, u8 *map,
        return 0;
 }

-static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map=
,
-                                        u32 dump_addr, u32 dump_size, bool=
 dav)
+static int __rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *m=
ap,
+                                          u32 dump_addr, u32 dump_size, bo=
ol dav)
 {
        int ret;

@@ -208,6 +208,25 @@ static int rtw89_dump_physical_efuse_map(struct rtw89_=
dev *rtwdev, u8 *map,
        return 0;
 }

+static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map=
,
+                                        u32 dump_addr, u32 dump_size, bool=
 dav)
+{
+       int retry;
+       int ret;
+
+       for (retry =3D 0; retry < 5; retry++) {
+               ret =3D __rtw89_dump_physical_efuse_map(rtwdev, map, dump_a=
ddr,
+                                                     dump_size, dav);
+               if (!ret)
+                       return 0;
+
+               rtw89_warn(rtwdev, "efuse dump (dav=3D%d) failed, retrying =
(%d)\n",
+                          dav, retry);
+       }
+
+       return ret;
+}
+
 #define invalid_efuse_header(hdr1, hdr2) \
        ((hdr1) =3D=3D 0xff || (hdr2) =3D=3D 0xff)
 #define invalid_efuse_content(word_en, i) \





