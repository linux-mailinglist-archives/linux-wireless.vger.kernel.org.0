Return-Path: <linux-wireless+bounces-36651-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJarEnATDGoZVQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36651-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:38:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A3C579371
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9097E3010662
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F43D88E1;
	Tue, 19 May 2026 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="A2X9MQKo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D913D5652
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176277; cv=none; b=ebJ8djdx+upkWcIgkHE1IEaMyDSWWBC5ZGk/Eld4MjT7tlGSFuRrvdZRifkyHdL5FfnVgx+zSQv6iHncrWU52G0ANBQX2EaoP0VrrzgbVYd4zH0ucBIMt8I1a+fB5Kq+oim6MIYrmZACT5tQzCdmBwUJv47+CjfV6rj3fSUYwHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176277; c=relaxed/simple;
	bh=OIzfkAczi8zwL66pzFvMwjqwVudaSelfqLtNmRcq5is=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BXhhzN87osOZnyXDWisc0DTPiNB3GhG5EmO/aUzLp8q4x54kXmzZj8wuWSNwi7ubr3sM1hwWBzBQ/3qY/c2Mt6h2jAxiyScmOT5MVHbunikR7kAG+s5xlFt3tHIpEJeHUG6HaOGR0V4oG+7J20IYugEkB4TDl7ber+3EcUXalBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=A2X9MQKo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64J7bfH732923250, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779176261; bh=1PmyMsxCJTJgKR+eUT+JZUmGGR9eXsasI3WrYNWOSXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=A2X9MQKoyHjYX+DlwvhZ3RRvIAd85FzPgwZUnVPDaldz8c8Ok+x9FfP61ZrEDFuYS
	 m1jZYH2luA4pKKVTSH9lakOAzplJRc1VDH2o2ysIA3KFmYsBrVLEit7Nnw80VMf5DC
	 dIq+4yn6wsef5OlXCsadkyMrX6h5DtgOu/J3gD8keZm/yLsPODSmSLTD8x5F6FlO+m
	 IR82VzPCDsZ79uvN+/yzPuKkoK1fUz155F7iu7z2PsMeoj10O+ok3m5nXXYQ4vZL23
	 +vnBajEvyxEENSbnZbvrwM3mwdMsDB0fdfrGqak2WgZXzGK8bHPhPtmCEN5jc2IBq8
	 tLZXr5b7kCBuw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64J7bfH732923250
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:37:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 May 2026 15:37:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 May 2026 15:37:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 19 May 2026 15:37:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: Johnson Tsai <wenjie.tsai@realtek.com>
Subject: RE: [RFC rtw-next 1/2] wifi: rtw89: usb: add hw_info sysfs attribute
Thread-Topic: [RFC rtw-next 1/2] wifi: rtw89: usb: add hw_info sysfs attribute
Thread-Index: AQHc52EVZUUl01fNIkynWMN/z/NzF7YU84wg
Date: Tue, 19 May 2026 07:37:42 +0000
Message-ID: <efb61959e14e4f57b78fbd49a563398e@realtek.com>
References: <20260519072415.25746-1-pkshih@realtek.com>
In-Reply-To: <20260519072415.25746-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36651-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09A3C579371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johannes,

Need your comments on usage of sysfs.

Ping-Ke Shih <pkshih@realtek.com> wrote:
> From: Johnson Tsai <wenjie.tsai@realtek.com>
>=20
> Expose the device's Serial Number (SN) and UUID from EFUSE through a
> read-only `hw_info` sysfs attribute on the USB interface device.
>=20
> This hardware identification information is essential for user-space
> applications to uniquely identify, track, and manage specific Wi-Fi
> adapters. For example, in automated factory provisioning or device
> management systems, user-space tools rely on the EFUSE SN and UUID
> to bind specific configurations to a physical adapter. Currently,
> standard wireless APIs do not expose this low-level hardware
> information, making this sysfs node the only viable and necessary
> solution for user space to extract this data.
>=20
> Relying on debugfs or setuid binaries is unviable for production
> environments, as explicitly requested by Valve (Steam). Steam frequently
> runs inside unprivileged containers (e.g., Flatpak) where debugfs and
> setuid binaries are inaccessible. Furthermore, many end-user systems
> disable debugfs in their kernel configs, and strict access controls
> (SELinux, AppArmor) block it regardless of permissions. Since Steam
> installs as an unprivileged user, setuid deployments are impossible.
> Consequently, exposing this data via a world-readable (0444) sysfs
> node is the only functional approach to ensure reliable, unprivileged
> access across diverse customer systems.
>=20
> Example usage from user-space:
>   $ cat /sys/bus/usb/devices/2-3.1.2:1.0/hw_info
>   SN: 36 42 00 01 23
>   UUID: aa ec 2b 7c 0a 55 47 27 8d e0 b3 0f eb cc bb aa
>=20
> User-space scripts can easily iterate over bound devices to extract
> this information:
>   for dev in /sys/bus/usb/drivers/rtw89_8852cu/[0-9]*:*; do
>       dev_id=3D$(basename "$dev")
>       echo "--- Device: /sys/bus/usb/devices/$dev_id ---"
>       cat "$dev/hw_info"
>   done
>=20
> Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> Hi maintainers,
>=20
> We are submitting this RFC to discuss the most appropriate upstream path =
for
> exposing hardware-specific IDs to unprivileged container environments.
>=20
> 1. Given the strict environment limitations (Flatpak, missing debugfs, LS=
Ms),
>    is a read-only sysfs attribute acceptable for this specific hardware d=
ata?
> 2. If exposing this globally via sysfs is not preferred, would it be acce=
ptable
>    to restrict the creation of this node to specific vendor VID/PIDs only=
?
> 3. If sysfs is strictly a no-go for this use case, what is the upstream-r=
ecommended
>    method for an unprivileged, sandboxed application to retrieve eFuse da=
ta?

I also looked up lore.kernel.org and only found a thread commented by Kalle=
 [1].
However, it is not clear to us if sysfs is suitable to read efuse SN/UUID.

[1] https://lore.kernel.org/linux-wireless/87ziib3da5.fsf@kamboji.qca.qualc=
omm.com/

> ---
>  drivers/net/wireless/realtek/rtw89/usb.c | 51 +++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wirel=
ess/realtek/rtw89/usb.c
> index c6d55e669776..53dcb84af5c0 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -1059,6 +1059,41 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev=
 *rtwdev,
>  	usb_set_intfdata(intf, NULL);
>  }
>=20
> +static ssize_t hw_info_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct usb_interface *intf =3D to_usb_interface(dev);
> +	struct ieee80211_hw *hw;
> +	struct rtw89_dev *rtwdev;
> +	struct rtw89_efuse *efuse;
> +	ssize_t ret;
> +
> +	device_lock(dev);

I think it isn't necessary to do lock/unlock in show ops. We will revise
it by v2.

[...]

Thanks
Ping-Ke



