Return-Path: <linux-wireless+bounces-36599-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJHvNv7zCmpZ+QQAu9opvQ
	(envelope-from <linux-wireless+bounces-36599-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:11:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A7056B4FF
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD1B03187244
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9373F0777;
	Mon, 18 May 2026 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="o4QPHGZy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811B3F0772
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101908; cv=none; b=U1+ArNJ1nBAb374t4Hcpx8Jq4SwAsg8+v+mg56XEpMBpVTI65BDzQ8sr+yZLV3v93tthiPLcjdvowbwmHZavc0/HcjWuQf19YIuOrM7SAtBP7echZ61BAOAT7Kc0xJJ+V2ahCnccLzujDbW+U0PlTeexPeNjS77YEVjadxn6d8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101908; c=relaxed/simple;
	bh=y5db7xXvIg/mACuWbNijMu8LoDbiMhC/c2uL5wb4YWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YyGqgdTMhSwhqMg8B4BFDqilKXj14zY8GKbkNTaVux0wELwxPhDz5FH9fTdXRDbn5n7L4Qo/gOlJh7xwqIzrAf3sVThrhz4bGvq6wB3fWuPC2O5LAhTBCuKSQu3EGkJiqJYXNtCid/Zxn24cfY/tdMnwIrGCtC+hIoPdIjWGdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=o4QPHGZy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64IAw8akD1819910, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779101888; bh=d4pwud2CRxr9RYIT+yMhbdJIcfKesSdue/HvhESSYIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=o4QPHGZykWjEaaVvjd1QRfo+H/udA4yvVBn+J6joBDK9ODmpw6EDz9g8gz8LxWvwx
	 aC2vJEFL9djrmxQIl+Hx/52XPNYbenb6nB96OUwZ+Ib60mBfEfYLYSawiXgAo9Vlxt
	 7ViaZ/Ybb7fadBKfFBhtZB9SJLbQSrLZoSJmGRGJA/RX7r870ECODxpwhio04H01Li
	 R3I6Fwf2+VnLHg7dXTlV8TVRCwm0TCPysopFVGliiWVTThnWrEVXGNlh1SSaRmddvI
	 LWHWVqq4ZAupEoUTN0vkG9S8VEiHgxKKbdymgukoYEx96L0rS7OvTNhI2jxK0vU2EA
	 5O12ZAZTHZu8g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64IAw8akD1819910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 18:58:08 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 May 2026 18:58:08 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::a2e:aeb4:fa27:c32f%9]) with mapi id
 15.02.2562.017; Mon, 18 May 2026 18:58:08 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFT rtw/rtw-next] wifi: rtw88: check if center channel is
 supported before setting
Thread-Topic: [RFT rtw/rtw-next] wifi: rtw88: check if center channel is
 supported before setting
Thread-Index: AQHcywd1Kx+cfkNEaU6FsyLRHWz2UbYNdYeAgAYqdxA=
Date: Mon, 18 May 2026 10:58:08 +0000
Message-ID: <a7f59b380639458eb1dc54e9b16fab14@realtek.com>
References: <20260413053601.13037-1-pkshih@realtek.com>
 <agYJNW7Mxt0dOfTw@quatroqueijos.cascardo.eti.br>
In-Reply-To: <agYJNW7Mxt0dOfTw@quatroqueijos.cascardo.eti.br>
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
X-Rspamd-Queue-Id: 59A7056B4FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36599-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin_yang@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
>=20
> On Mon, Apr 13, 2026 at 01:36:01PM +0800, Ping-Ke Shih wrote:
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > Some unusual center channels may be assigned to driver. However, RF
> > doesn't really expect them, and then warnings happen due to lack of TX
> > power limit configurations. For example, center channel 114/130 with
> > 80MHz. So, add a check before setting the channel.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>=20
> Hi,
>=20
> I have tested this patch and it does prevent 80MHz from being used.
> However, RF seems to accept those center channels with 80MHz just fine. I=
 can
> get up to 600Mbps with UDP while I can get past 300Mbps after applying th=
is
> patch.
>=20
> Should we apply something like [1] instead?
>=20
> https://lore.kernel.org/linux-wireless/20260306-rtw88_channel130-v1-1-ff2=
5a5
> bc930a@igalia.com
>=20
> Regards.
> Cascardo.
>=20

Hi,

The chipsets supported by rtw88 are only verified with the existing center =
channels
before 160MHz. Although you set 80MHz here, but these center channels actua=
lly
appeared after 160MHz. I also have checked with our HW members. They said t=
hey
cannot guarantee everything will be right. So, we won't officially allow th=
ese center
channels.

Maybe you think your test result is fine to you, but throughput test doesn'=
t tell the
whole story, e.g., is it really fine for regulatory? So, I suggest that you=
 change the AP
configuration to use another center channel with 80MHz.

Thanks.

> > ---
> >  drivers/net/wireless/realtek/rtw88/mac80211.c |  7 +++++--
> >  drivers/net/wireless/realtek/rtw88/main.c     | 13 +++++++++++--
> >  drivers/net/wireless/realtek/rtw88/main.h     |  2 +-
> >  drivers/net/wireless/realtek/rtw88/phy.c      | 18 ++++++++++++++++++
> >  drivers/net/wireless/realtek/rtw88/phy.h      |  2 ++
> >  5 files changed, 37 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c
> > b/drivers/net/wireless/realtek/rtw88/mac80211.c
> > index 766f22d31079..9d97e8dd0c1e 100644
> > --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> > +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> > @@ -92,8 +92,11 @@ static int rtw_ops_config(struct ieee80211_hw *hw,
> int radio_idx, u32 changed)
> >               }
> >       }
> >
> > -     if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
> > -             rtw_set_channel(rtwdev);
> > +     if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
> > +             ret =3D rtw_set_channel(rtwdev);
> > +             if (ret)
> > +                     goto out;
> > +     }
> >
> >       if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
> >           (hw->conf.flags & IEEE80211_CONF_IDLE) && diff --git
> > a/drivers/net/wireless/realtek/rtw88/main.c
> > b/drivers/net/wireless/realtek/rtw88/main.c
> > index cd9254370fcc..08aebb3c5a78 100644
> > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > @@ -868,23 +868,30 @@ void rtw_get_channel_params(struct
> cfg80211_chan_def *chandef,
> >       chan_params->primary_chan =3D channel->hw_value;  }
> >
> > -void rtw_set_channel(struct rtw_dev *rtwdev)
> > +int rtw_set_channel(struct rtw_dev *rtwdev)
> >  {
> >       const struct rtw_chip_info *chip =3D rtwdev->chip;
> >       struct ieee80211_hw *hw =3D rtwdev->hw;
> >       struct rtw_hal *hal =3D &rtwdev->hal;
> >       struct rtw_channel_params ch_param;
> >       u8 center_chan, primary_chan, bandwidth, band;
> > +     int ch_idx;
> >
> >       rtw_get_channel_params(&hw->conf.chandef, &ch_param);
> >       if (WARN(ch_param.center_chan =3D=3D 0, "Invalid channel\n"))
> > -             return;
> > +             return -EINVAL;
> >
> >       center_chan =3D ch_param.center_chan;
> >       primary_chan =3D ch_param.primary_chan;
> >       bandwidth =3D ch_param.bandwidth;
> >       band =3D ch_param.center_chan > 14 ? RTW_BAND_5G :
> RTW_BAND_2G;
> >
> > +     ch_idx =3D rtw_band_channel_to_idx(band, center_chan);
> > +     if (ch_idx < 0) {
> > +             rtw_warn(rtwdev, "not support band %d ch %d\n", band,
> center_chan);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       rtw_update_channel(rtwdev, center_chan, primary_chan, band,
> > bandwidth);
> >
> >       if (rtwdev->scan_info.op_chan)
> > @@ -910,6 +917,8 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
> >        */
> >       if (!test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
> >               rtwdev->need_rfk =3D true;
> > +
> > +     return 0;
> >  }
> >
> >  void rtw_chip_prepare_tx(struct rtw_dev *rtwdev) diff --git
> > a/drivers/net/wireless/realtek/rtw88/main.h
> > b/drivers/net/wireless/realtek/rtw88/main.h
> > index 9c0b746540b0..a368f1a4a003 100644
> > --- a/drivers/net/wireless/realtek/rtw88/main.h
> > +++ b/drivers/net/wireless/realtek/rtw88/main.h
> > @@ -2241,7 +2241,7 @@ bool ltecoex_reg_write(struct rtw_dev *rtwdev,
> > u16 offset, u32 value);  void rtw_restore_reg(struct rtw_dev *rtwdev,
> >                    struct rtw_backup_info *bckp, u32 num);  void
> > rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss); -void
> > rtw_set_channel(struct rtw_dev *rtwdev);
> > +int rtw_set_channel(struct rtw_dev *rtwdev);
> >  void rtw_chip_prepare_tx(struct rtw_dev *rtwdev);  void
> > rtw_vif_port_config(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
> >                        u32 config);
> > diff --git a/drivers/net/wireless/realtek/rtw88/phy.c
> > b/drivers/net/wireless/realtek/rtw88/phy.c
> > index e2ac5c6fd500..a543eaa57f2c 100644
> > --- a/drivers/net/wireless/realtek/rtw88/phy.c
> > +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> > @@ -1630,6 +1630,24 @@ static int rtw_channel_to_idx(u8 band, u8
> channel)
> >       return ch_idx;
> >  }
> >
> > +int rtw_band_channel_to_idx(enum rtw_supported_band band, u8 channel)
> > +{
> > +     u8 phy_band;
> > +
> > +     switch (band) {
> > +     case RTW_BAND_2G:
> > +             phy_band =3D PHY_BAND_2G;
> > +             break;
> > +     case RTW_BAND_5G:
> > +             phy_band =3D PHY_BAND_5G;
> > +             break;
> > +     default:
> > +             return -1;
> > +     }
> > +
> > +     return rtw_channel_to_idx(phy_band, channel); }
> > +
> >  static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd=
,
> u8 band,
> >                                      u8 bw, u8 rs, u8 ch, s8
> > pwr_limit)  { diff --git a/drivers/net/wireless/realtek/rtw88/phy.h
> > b/drivers/net/wireless/realtek/rtw88/phy.h
> > index 8449936497bb..98aeb576e24d 100644
> > --- a/drivers/net/wireless/realtek/rtw88/phy.h
> > +++ b/drivers/net/wireless/realtek/rtw88/phy.h
> > @@ -201,4 +201,6 @@ enum rtw_phy_cck_pd_lv {  #define
> > RRSR_RATE_ORDER_MAX  0xfffff
> >  #define RRSR_RATE_ORDER_CCK_LEN      4
> >
> > +int rtw_band_channel_to_idx(enum rtw_supported_band band, u8
> > +channel);
> > +
> >  #endif
> > --
> > 2.25.1
> >
> >

