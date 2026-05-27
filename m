Return-Path: <linux-wireless+bounces-37005-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNeONsPZFmpVtgcAu9opvQ
	(envelope-from <linux-wireless+bounces-37005-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 13:47:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C75E3986
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 13:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6AEE3021EE9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 11:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237E740149B;
	Wed, 27 May 2026 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eftInNdC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65F401A00;
	Wed, 27 May 2026 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882388; cv=none; b=pNl6QseeNmGOJM7JpWw+agtKfxivNvKCI3bDC/g7OztuypjZpeWG39BRcUree+u0Rg4ZRcdUordnWeqbdgGjt5b+0M6xMrRxm0xwsSaeXhv7UrBVdIfKeRmoBm0hXRyv9lXnF+yVHL1Ob5arBzJsTlfgwomG/PV5ALO0kKne5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882388; c=relaxed/simple;
	bh=YdM2KuPsS6iEQIV2TOVchhZb/kIOUPLQ77gl483YzAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YSy5Uh6jyfsAJQE5XZv6XN2tRjwUBqcemBENlJI58ntiHEnHfr0dX1Xdi+U2xSyjMN/6FHV/NvJC9ePXNTAF2IizBjet2b84Q2KBU8aBnw31rnukX16zpehJRU1Dl4aypNygP/ogbu7ICbYngiCP0WkyFyltLFKuNsypKzAtCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eftInNdC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64RBkKFh92410910, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779882380; bh=rjeoj5txp/QNANBD/CsC+abAp7dZWLxhaSriYxUJR8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eftInNdCpHecLatPHW93lzwifgAagIM7Wl0GVY2rr2Ty9mluz+/93bTeUgVtZjyiF
	 5gYS3nY67+Nn+ggQwXZC4FN1cyTeDpEcbX1JV18SdAti+gRLQ90eEcN+2csnQjLIsN
	 xQCX4Nj6CfIPTq8f5zRSnePzpwtbrjqwTI4QgwRAlA+xaQKzdoYwCCXZ9Xc9sG2stF
	 0UCzgMcBqPMQy4FNopm3G+yAX0k+tHQPdm11aj3BXXmX/IAf309XXubrU9mB6exlWn
	 VIShCbBGWgiK2ZJ/LqDHBtZYI2ghdQK5dRs1F3o8p3m9nbr3nEtSu6pAz1+ugPT1bz
	 E0zcJqr1nLFIw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64RBkKFh92410910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 19:46:20 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 May 2026 19:46:20 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 May 2026 19:46:16 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Wed, 27 May 2026 19:46:16 +0800
From: Johnson Tsai <wenjie.tsai@realtek.com>
To: Greg KH <gregkh@linuxfoundation.org>, Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, Mh_chen
	<mh_chen@realtek.com>, "charlesl@valvesoftware.com"
	<charlesl@valvesoftware.com>, "sabae@valvesoftware.com"
	<sabae@valvesoftware.com>
Subject: RE: [PATCH v2 rtw-next 2/2] wifi: rtw89: usb: add serial_number and
 uuid sysfs attributes for 0x28de:0x2432
Thread-Topic: [PATCH v2 rtw-next 2/2] wifi: rtw89: usb: add serial_number and
 uuid sysfs attributes for 0x28de:0x2432
Thread-Index: AQHc7CPK7XAjaKq4wE2RBM65kSD0ZLYenDKAgAMmwCA=
Date: Wed, 27 May 2026 11:46:15 +0000
Message-ID: <ea36d1a110984db6a583d82449ee532e@realtek.com>
References: <20260525085148.35180-1-pkshih@realtek.com>
 <20260525085148.35180-3-pkshih@realtek.com>
 <2026052524-ammonia-zeppelin-9edb@gregkh>
In-Reply-To: <2026052524-ammonia-zeppelin-9edb@gregkh>
Accept-Language: zh-TW, en-US
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37005-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenjie.tsai@realtek.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 036C75E3986
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On : Tuesday, May 26, 2026 3:33, Greg KH wrote:=20
> On Mon, May 25, 2026 at 04:51:48PM +0800, Ping-Ke Shih wrote:
> > From: Johnson Tsai <wenjie.tsai@realtek.com>
> >
> > Expose the device's Serial Number (SN) and UUID from EFUSE via two
> > read-only sysfs attributes, `serial_number` and `uuid`, on the
> > ieee80211 phy device under the `rtw89_usb` attribute group.
> >
> > This hardware identification information is essential for user-space
> > applications to uniquely identify, track, and manage specific Wi-Fi
> > adapters. For example, in automated factory provisioning or device
> > management systems, user-space tools rely on the EFUSE serial number
> > and UUID to bind configurations to specific physical adapters.
> > Currently, standard wireless APIs do not expose this low-level
> > hardware information, making these sysfs nodes the only viable
> > solution for user space to extract this data.
> >
> > The attributes are gated behind a new RTW89_QUIRK_HW_INFO_SYSFS
> quirk,
> > enabled only for the VID 0x28de / PID 0x2432 device via the
> > dev_id_quirks field in rtw89_driver_info.
> >
> > Example usage from user-space:
> >   $ cat /sys/class/ieee80211/phy0/rtw89_usb/serial_number
> >   3642000123
> >   $ cat /sys/class/ieee80211/phy0/rtw89_usb/uuid
> >   aaec2b7c-0a55-4727-8de0-b30febccbbaa
> >
> > Cc: Elliot Saba <sabae@valvesoftware.com>
> > Cc: Charles Lohr <charlesl@valvesoftware.com>
> > Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  .../ABI/testing/sysfs-class-ieee80211-rtw89   | 24 ++++++++
> >  drivers/net/wireless/realtek/rtw89/core.h     |  6 ++
> >  drivers/net/wireless/realtek/rtw89/rtw8852c.c | 10 ++++
> > drivers/net/wireless/realtek/rtw89/rtw8852c.h |  6 +-
> >  .../net/wireless/realtek/rtw89/rtw8852cu.c    | 12 +++-
> >  drivers/net/wireless/realtek/rtw89/usb.c      | 57 +++++++++++++++++++
> >  6 files changed, 113 insertions(+), 2 deletions(-)  create mode
> > 100644 Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
> > b/Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
> > new file mode 100644
> > index 000000000000..7dfdce08a42f
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
> > @@ -0,0 +1,24 @@
> > +What:                /sys/class/ieee80211/phyX/rtw89_usb/serial_number
> > +Date:                May 2026
> > +Contact:     Johnson Tsai <wenjie.tsai@realtek.com>, linux-
> wireless@vger.kernel.org
> > +Description: (Read) Serial number burned into EFUSE of the RTL8852CU-
> based
> > +             USB Wi-Fi adapter.  Only present on devices that set the
> > +             RTW89_QUIRK_HW_INFO_SYSFS quirk (currently VID 0x28de /
> > +             PID 0x2432).
> > +
> > +             Format: %10phN (5 raw bytes printed as 10 lowercase hex
> > +             digits, no separators).
> > +
> > +             Example: 3642000123
> > +
> > +What:                /sys/class/ieee80211/phyX/rtw89_usb/uuid
> > +Date:                May 2026
> > +Contact:     Johnson Tsai <wenjie.tsai@realtek.com>, linux-
> wireless@vger.kernel.org
> > +Description: (Read) UUID burned into EFUSE of the RTL8852CU-based USB
> Wi-Fi
> > +             adapter.  Only present on devices that set the
> > +             RTW89_QUIRK_HW_INFO_SYSFS quirk (currently VID 0x28de /
> > +             PID 0x2432).
> > +
> > +             Format: %pUb (RFC 4122 UUID in lowercase with hyphens).
> > +
> > +             Example: aaec2b7c-0a55-4727-8de0-b30febccbbaa
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.h
> > b/drivers/net/wireless/realtek/rtw89/core.h
> > index e687216da5b6..09f17d958075 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.h
> > +++ b/drivers/net/wireless/realtek/rtw89/core.h
> > @@ -3615,6 +3615,9 @@ struct rtw89_sta_link {
> >       u32 data_tx_cnt_lmt:6;
> >  };
> >
> > +#define RTW89_EFUSE_SN_LEN 5
> > +#define RTW89_EFUSE_UUID_LEN 16
> > +
> >  struct rtw89_efuse {
> >       bool valid;
> >       bool power_k_valid;
> > @@ -3625,6 +3628,8 @@ struct rtw89_efuse {
> >       u8 adc_td;
> >       u8 bt_setting_2;
> >       u8 bt_setting_3;
> > +     u8 sn[RTW89_EFUSE_SN_LEN];
> > +     u8 uuid[RTW89_EFUSE_UUID_LEN];
> >  };
> >
> >  struct rtw89_phy_rate_pattern {
> > @@ -5373,6 +5378,7 @@ enum rtw89_quirks {
> >       RTW89_QUIRK_PCI_BER,
> >       RTW89_QUIRK_THERMAL_PROT_120C,
> >       RTW89_QUIRK_THERMAL_PROT_110C,
> > +     RTW89_QUIRK_HW_INFO_SYSFS,
> >
> >       NUM_OF_RTW89_QUIRKS,
> >  };
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
> > b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
> > index 7bb1264bcaef..3861cce42b1b 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
> > @@ -621,6 +621,15 @@ static void
> rtw8852c_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
> >       gain->offset_valid =3D valid;
> >  }
> >
> > +static void rtw8852c_efuse_copy_sn_uuid_usb(struct rtw89_dev *rtwdev,
> > +                                         const struct rtw8852c_efuse
> > +*map) {
> > +     struct rtw89_efuse *efuse =3D &rtwdev->efuse;
> > +
> > +     memcpy(efuse->sn, map->u.sn, sizeof(efuse->sn));
> > +     memcpy(efuse->uuid, map->u.uuid, sizeof(efuse->uuid)); }
> > +
> >  static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
> >                              enum rtw89_efuse_block block)  { @@
> > -640,6 +649,7 @@ static int rtw8852c_read_efuse(struct rtw89_dev
> *rtwdev, u8 *log_map,
> >               break;
> >       case RTW89_HCI_TYPE_USB:
> >               ether_addr_copy(efuse->addr, map->u.mac_addr);
> > +             rtw8852c_efuse_copy_sn_uuid_usb(rtwdev, map);
> >               break;
> >       default:
> >               return -ENOTSUPP;
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
> > b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
> > index 8585921ac6c4..b1d7c354c18e 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
> > @@ -13,7 +13,11 @@
> >  struct rtw8852c_u_efuse {
> >       u8 rsvd[0x88];
> >       u8 mac_addr[ETH_ALEN];
> > -};
> > +     u8 rsvd1[8];
> > +     u8 sn[RTW89_EFUSE_SN_LEN];
> > +     u8 rsvd2[29];
> > +     u8 uuid[RTW89_EFUSE_UUID_LEN];
> > +} __packed;
> >
> >  struct rtw8852c_e_efuse {
> >       u8 mac_addr[ETH_ALEN];
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> > b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> > index 8f89f9a31455..81ee96b0a048 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> > @@ -39,6 +39,16 @@ static const struct rtw89_driver_info
> rtw89_8852cu_info =3D {
> >       },
> >  };
> >
> > +static const struct rtw89_driver_info rtw89_8852cu_valve_info =3D {
> > +     .chip =3D &rtw8852c_chip_info,
> > +     .variant =3D NULL,
> > +     .quirks =3D NULL,
> > +     .dev_id_quirks =3D BIT(RTW89_QUIRK_HW_INFO_SYSFS),
> > +     .bus =3D {
> > +             .usb =3D &rtw8852c_usb_info,
> > +     },
> > +};
> > +
> >  static const struct usb_device_id rtw_8852cu_id_table[] =3D {
> >       { USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03a6, 0xff, 0xff, 0xff)=
,
> >         .driver_info =3D (kernel_ulong_t)&rtw89_8852cu_info }, @@ -53,7
> > +63,7 @@ static const struct usb_device_id rtw_8852cu_id_table[] =3D {
> >       { USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x991d, 0xff, 0xff, 0xff)=
,
> >         .driver_info =3D (kernel_ulong_t)&rtw89_8852cu_info },
> >       { USB_DEVICE_AND_INTERFACE_INFO(0x28de, 0x2432, 0xff, 0xff, 0xff)=
,
> > -       .driver_info =3D (kernel_ulong_t)&rtw89_8852cu_info },
> > +       .driver_info =3D (kernel_ulong_t)&rtw89_8852cu_valve_info },
> >       { USB_DEVICE_AND_INTERFACE_INFO(0x2c7c, 0x8206, 0xff, 0xff, 0xff)=
,
> >         .driver_info =3D (kernel_ulong_t)&rtw89_8852cu_info },
> >       { USB_DEVICE_AND_INTERFACE_INFO(0x35b2, 0x0502, 0xff, 0xff,
> > 0xff), diff --git a/drivers/net/wireless/realtek/rtw89/usb.c
> > b/drivers/net/wireless/realtek/rtw89/usb.c
> > index 88d7ec200837..7e23d0a32025 100644
> > --- a/drivers/net/wireless/realtek/rtw89/usb.c
> > +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> > @@ -1059,6 +1059,61 @@ static void rtw89_usb_intf_deinit(struct
> rtw89_dev *rtwdev,
> >       usb_set_intfdata(intf, NULL);
> >  }
> >
> > +static ssize_t serial_number_show(struct device *dev,
> > +                               struct device_attribute *attr, char
> > +*buf) {
> > +     struct wiphy *wiphy =3D container_of(dev, struct wiphy, dev);
> > +     struct ieee80211_hw *hw =3D wiphy_to_ieee80211_hw(wiphy);
> > +     struct rtw89_dev *rtwdev =3D hw->priv;
> > +     struct rtw89_efuse *efuse =3D &rtwdev->efuse;
> > +
> > +     return sysfs_emit(buf, "%*phN\n",
> > +                       (int)sizeof(efuse->sn), efuse->sn); } static
> > +DEVICE_ATTR_RO(serial_number);
> > +
> > +static ssize_t uuid_show(struct device *dev,
> > +                      struct device_attribute *attr, char *buf) {
> > +     struct wiphy *wiphy =3D container_of(dev, struct wiphy, dev);
> > +     struct ieee80211_hw *hw =3D wiphy_to_ieee80211_hw(wiphy);
> > +     struct rtw89_dev *rtwdev =3D hw->priv;
> > +     struct rtw89_efuse *efuse =3D &rtwdev->efuse;
> > +
> > +     return sysfs_emit(buf, "%pUb\n", efuse->uuid); } static
> > +DEVICE_ATTR_RO(uuid);
> > +
> > +static struct attribute *rtw89_usb_attrs[] =3D {
> > +     &dev_attr_serial_number.attr,
> > +     &dev_attr_uuid.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group rtw89_usb_group =3D {
> > +     .name =3D "rtw89_usb",
> > +     .attrs =3D rtw89_usb_attrs,
> > +};
> > +__ATTRIBUTE_GROUPS(rtw89_usb);
> > +
> > +static void rtw89_usb_sysfs_create(struct rtw89_dev *rtwdev) {
> > +     int ret;
> > +
> > +     if (!test_bit(RTW89_QUIRK_HW_INFO_SYSFS, rtwdev->quirks))
> > +             return;
> > +
> > +     ret =3D sysfs_create_groups(&rtwdev->hw->wiphy->dev.kobj,
> > +                               rtw89_usb_groups);
>=20
> You just raced with userspace and lost, please use the is_visable callbac=
k
> instead, and make this the default group attributes.

Thanks for the explanation.

I see the problem now. The user space sysfs path remains identical,=20
but the timing and mechanism are different. Using dev.kobj requires=20
manual creation/removal outside the hardware lifecycle, whereas=20
setting dev.groups will automatically handle creation/removal within=20
the same hardware lifecycle to avoid the race condition.

I will remove the manual sysfs creation and switch to default group=20
attributes in v3.=20

Specifically, the visibility of the entire group will be managed via the ma=
cro:

    /* Control the visibility of the entire attribute group */
    .is_visible =3D SYSFS_GROUP_VISIBLE(rtw89_usb),

And the group will be attached to the wiphy device default groups before re=
gistration:

    /* Attach the attribute group to the wiphy device */
    rtwdev->hw->wiphy->dev.groups =3D rtw89_usb_groups;


Thanks,

Johnson



