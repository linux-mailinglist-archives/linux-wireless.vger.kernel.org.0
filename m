Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1712A6C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 11:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfECJ1J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 05:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfECJ1J (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 05:27:09 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E3902081C;
        Fri,  3 May 2019 09:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556875627;
        bh=7qhFXLqBoqbzSNpID0ElAur1bS9tnehNJ0eIpq4FKo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBqV69XQoq9sqmvhbZcYCK5UZiBpbDOmt5Vc8zDPNOXyPyf2gNmTnCloLse/FWIvU
         71iu1VtiIY4BD8Ib9jnjimqUfsxVT1TBu4UVRUrivIABVmB4CyTJID9zaNJfVJCBcS
         yeWomU19J+8mjCh40spf5f7+3Ra1jcK3M0cwDIg0=
Date:   Fri, 3 May 2019 11:27:02 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Roy Luo <royluo@google.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org,
        Ryder Lee =?utf-8?B?KOadjuW6muiruik=?= <ryder.lee@mediatek.com>
Subject: Re: [RFC 10/17] mt7615: mcu: remove skb_ret from mt7615_mcu_msg_send
Message-ID: <20190503092701.GA20594@localhost.localdomain>
References: <cover.1556726268.git.lorenzo@kernel.org>
 <8038126699e72985310b992cc7c36cd07f918e00.1556726268.git.lorenzo@kernel.org>
 <CA+zupgzQTzQyihC_UskHD=63Ag3AnQcD4_pcas7VdaehyoCE1w@mail.gmail.com>
 <20190502153142.GA7459@localhost.localdomain>
 <CA+zupgxPj_oziDiSkztE3zLxZ9BXMAbQ3Vb4eEWSJ4JrSE41=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <CA+zupgxPj_oziDiSkztE3zLxZ9BXMAbQ3Vb4eEWSJ4JrSE41=A@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, May 2, 2019 at 11:31 PM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
>=20
> > > Hi Lorenzo,
> > >
> >
> > Hi Roy,
> >
> > > IMHO, the skb_ret parameter from mt7615_mcu_msg_send is not just used=
 by
> > > patch semaphore control.
> > > The other cmds also got their own event response that can be interpret
> > > accordingly by their own caller, which can provide the status of the =
cmd
> > > (success/fail) and other information that might be helpful case by ca=
se.
> >
> >
> > Do you mean the fw does not put the status code in a 'event struct'
> > at the beginning of the skb data buffer? What are the cmds that do not =
use
> > that approach?
> >
> > Regards,
> > Lorenzo
> >
> >
> What is the 'event struct' you're referring to?

I mean the one defined in mt7615_mcu_patch_sem_ctrl:

struct event {
	u8 status;
	u8 reserved[3];
};

> The common part in the beginning of the skb should be mt7615_mcu_rxd, the
> payload after that varies by cmd.
> Most cmds put status code in the beginning of the payload, then append so=
me
> cmd specific content after it.
> There is also a little difference between ext cmd and non-ext cmd in terms
> of mcu rxd, which is why we do this tricky -4 to get status code out of
> patch sem event.
> skb_pull(skb, sizeof(*rxd) - 4);

I guess in the future we can manage the mcu reply in mt7615_mcu_msg_send() =
or
even add a new routine for it run by mt7615_mcu_msg_send.
I would avoid to modify __mt76_mcu_send_msg signature since it is used even=
 by
mt76x02 and mt7603 and most of the times we will pass NULL to it.

Regards,
Lorenzo

>=20
>=20
> Regards,
> Cheng-Hao (Roy) Luo
>=20
>=20
>=20
> > > For now, we just assume every cmd works well and do no error handling,
> > > which is risky.
> > > If we are to take FW response into consideration in the future, maybe=
 we
> > > should keep this parameter.
> > >
> > >
> > > Regards,
> > > Cheng-Hao (Roy) Luo
> > >
> > >
> > > On Thu, May 2, 2019 at 12:08 AM Lorenzo Bianconi <lorenzo@kernel.org>
> > wrote:
> > >
> > > > Remove skb_ret parameter from mt7615_mcu_msg_send signature since i=
t is
> > > > actually used just by mt7615_mcu_patch_sem_ctrl. This is a preliman=
ry
> > > > patch to use mt76 common mcu API
> > > >
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 77 ++++++---------=
----
> > > >  1 file changed, 24 insertions(+), 53 deletions(-)
> > > >
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > > b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > > index b8d928e8949c..4d1d4c0bc2e2 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > > @@ -116,8 +116,7 @@ static int __mt7615_mcu_msg_send(struct mt7615_=
dev
> > > > *dev, struct sk_buff *skb,
> > > >  }
> > > >
> > > >  static int
> > > > -mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
> > > > -                   int cmd, struct sk_buff **skb_ret)
> > > > +mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb, i=
nt
> > cmd)
> > > >  {
> > > >         unsigned long expires =3D jiffies + 10 * HZ;
> > > >         struct mt7615_mcu_rxd *rxd;
> > > > @@ -142,18 +141,11 @@ mt7615_mcu_msg_send(struct mt7615_dev *dev,
> > struct
> > > > sk_buff *skb,
> > > >                 if (seq !=3D rxd->seq)
> > > >                         continue;
> > > >
> > > > -               if (skb_ret) {
> > > > -                       int hdr_len =3D sizeof(*rxd);
> > > > -
> > > > -                       if (!test_bit(MT76_STATE_MCU_RUNNING,
> > > > -                                     &dev->mt76.state))
> > > > -                               hdr_len -=3D 4;
> > > > -                       skb_pull(skb, hdr_len);
> > > > -                       *skb_ret =3D skb;
> > > > -               } else {
> > > > -                       dev_kfree_skb(skb);
> > > > +               if (cmd =3D=3D -MCU_CMD_PATCH_SEM_CONTROL) {
> > > > +                       skb_pull(skb, sizeof(*rxd) - 4);
> > > > +                       ret =3D *skb->data;
> > > >                 }
> > > > -
> > > > +               dev_kfree_skb(skb);
> > > >                 break;
> > > >         }
> > > >
> > > > @@ -177,8 +169,7 @@ static int mt7615_mcu_init_download(struct
> > mt7615_dev
> > > > *dev, u32 addr,
> > > >         };
> > > >         struct sk_buff *skb =3D mt7615_mcu_msg_alloc(&req, sizeof(r=
eq));
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb,
> > > > -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
> > > > -                                  NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb,
> > > > -MCU_CMD_TARGET_ADDRESS_LEN_REQ);
> > > >  }
> > > >
> > > >  static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const =
void
> > > > *data,
> > > > @@ -219,43 +210,26 @@ static int mt7615_mcu_start_firmware(struct
> > > > mt7615_dev *dev, u32 addr,
> > > >         };
> > > >         struct sk_buff *skb =3D mt7615_mcu_msg_alloc(&req, sizeof(r=
eq));
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_START_REQ,
> > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_START_REQ);
> > > >  }
> > > >
> > > >  static int mt7615_mcu_restart(struct mt7615_dev *dev)
> > > >  {
> > > >         struct sk_buff *skb =3D mt7615_mcu_msg_alloc(NULL, 0);
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_RESTART_DL_RE=
Q,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_RESTART_DL_RE=
Q);
> > > >  }
> > > >
> > > >  static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool =
get)
> > > >  {
> > > >         struct {
> > > > -               __le32 operation;
> > > > +               __le32 op;
> > > >         } req =3D {
> > > > -               .operation =3D cpu_to_le32(get ? PATCH_SEM_GET :
> > > > -                                        PATCH_SEM_RELEASE),
> > > > +               .op =3D cpu_to_le32(get ? PATCH_SEM_GET :
> > PATCH_SEM_RELEASE),
> > > >         };
> > > > -       struct event {
> > > > -               u8 status;
> > > > -               u8 reserved[3];
> > > > -       } *resp;
> > > >         struct sk_buff *skb =3D mt7615_mcu_msg_alloc(&req, sizeof(r=
eq));
> > > > -       struct sk_buff *skb_ret;
> > > > -       int ret;
> > > >
> > > > -       ret =3D mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_SEM_CO=
NTROL,
> > > > -                                 &skb_ret);
> > > > -       if (ret)
> > > > -               goto out;
> > > > -
> > > > -       resp =3D (struct event *)(skb_ret->data);
> > > > -       ret =3D resp->status;
> > > > -       dev_kfree_skb(skb_ret);
> > > > -
> > > > -out:
> > > > -       return ret;
> > > > +       return mt7615_mcu_msg_send(dev, skb,
> > -MCU_CMD_PATCH_SEM_CONTROL);
> > > >  }
> > > >
> > > >  static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
> > > > @@ -268,7 +242,7 @@ static int mt7615_mcu_start_patch(struct mt7615=
_dev
> > > > *dev)
> > > >         };
> > > >         struct sk_buff *skb =3D mt7615_mcu_msg_alloc(&req, sizeof(r=
eq));
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_FINISH_=
REQ,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb,
> > -MCU_CMD_PATCH_FINISH_REQ);
> > > >  }
> > > >
> > > >  static int mt7615_driver_own(struct mt7615_dev *dev)
> > > > @@ -554,8 +528,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *de=
v)
> > > >         for (off =3D MT_EE_NIC_CONF_0; off < __MT_EE_MAX; off++)
> > > >                 data[off - MT_EE_NIC_CONF_0].val =3D eep[off];
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_EFUSE_BUFFER_MODE,
> > > > -                                  NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb,
> > > > MCU_EXT_CMD_EFUSE_BUFFER_MODE);
> > > >  }
> > > >
> > > >  int mt7615_mcu_init_mac(struct mt7615_dev *dev)
> > > > @@ -570,7 +543,7 @@ int mt7615_mcu_init_mac(struct mt7615_dev *dev)
> > > >         };
> > > >         struct sk_buff *skb =3D mt7615_mcu_msg_alloc(&req, sizeof(r=
eq));
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_MAC_INIT_C=
TRL,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_MAC_INIT_CTRL);
> > > >  }
> > > >
> > > >  int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
> > > > @@ -589,7 +562,7 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_dev
> > *dev,
> > > > u32 val)
> > > >         };
> > > >         struct sk_buff *skb =3D mt7615_mcu_msg_alloc(&req, sizeof(r=
eq));
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PROTECT_CT=
RL,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PROTECT_CT=
RL);
> > > >  }
> > > >
> > > >  int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
> > > > @@ -627,7 +600,7 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, =
u8
> > > > queue,
> > > >         }
> > > >
> > > >         skb =3D mt7615_mcu_msg_alloc(&req, sizeof(req));
> > > > -       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EDCA_UPDAT=
E,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EDCA_UPDAT=
E);
> > > >  }
> > > >
> > > >  int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
> > > > @@ -657,7 +630,7 @@ int mt7615_mcu_ctrl_pm_state(struct mt7615_dev
> > *dev,
> > > > int enter)
> > > >         };
> > > >         struct sk_buff *skb =3D mt7615_mcu_msg_alloc(&req, sizeof(r=
eq));
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PM_STATE_C=
TRL,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_PM_STATE_CTRL);
> > > >  }
> > > >
> > > >  static int __mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
> > > > @@ -704,8 +677,7 @@ static int __mt7615_mcu_set_dev_info(struct
> > mt7615_dev
> > > > *dev,
> > > >
> > > >         memcpy(skb_push(skb, sizeof(req_hdr)), &req_hdr,
> > sizeof(req_hdr));
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_DEV_INFO_UPDATE,
> > > > -                                  NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_DEV_INFO_UPDATE);
> > > >  }
> > > >
> > > >  int mt7615_mcu_set_dev_info(struct mt7615_dev *dev, struct
> > ieee80211_vif
> > > > *vif,
> > > > @@ -830,8 +802,7 @@ static int __mt7615_mcu_set_bss_info(struct
> > mt7615_dev
> > > > *dev,
> > > >                     bss_info_tag_handler[i].handler)
> > > >                         bss_info_tag_handler[i].handler(dev, bss_in=
fo,
> > > > skb);
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_BSS_INFO_UPDATE,
> > > > -                                  NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_BSS_INFO_UPDATE);
> > > >  }
> > > >
> > > >  int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> > > > @@ -914,7 +885,7 @@ __mt7615_mcu_set_wtbl(struct mt7615_dev *dev, i=
nt
> > > > wlan_idx,
> > > >         if (buf && buf_len)
> > > >                 memcpy(skb_put(skb, buf_len), buf, buf_len);
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_WTBL_UPDAT=
E,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_WTBL_UPDAT=
E);
> > > >  }
> > > >
> > > >  static enum mt7615_cipher_type
> > > > @@ -1092,7 +1063,7 @@ __mt7615_mcu_set_sta_rec(struct mt7615_dev *d=
ev,
> > int
> > > > bss_idx,
> > > >         if (buf && buf_len)
> > > >                 memcpy(skb_put(skb, buf_len), buf, buf_len);
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_STA_REC_UPDATE,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_STA_REC_UPDATE);
> > > >  }
> > > >
> > > >  int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
> > > > @@ -1220,7 +1191,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev,
> > > > struct ieee80211_vif *vif,
> > > >
> > > >         skb =3D mt7615_mcu_msg_alloc(&req, sizeof(req));
> > > >
> > > > -       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BCN_OFFLOA=
D,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BCN_OFFLOA=
D);
> > > >  }
> > > >
> > > >  int mt7615_mcu_set_channel(struct mt7615_dev *dev)
> > > > @@ -1285,12 +1256,12 @@ int mt7615_mcu_set_channel(struct mt7615_dev
> > *dev)
> > > >         memset(req.txpower_sku, 0x3f, 49);
> > > >
> > > >         skb =3D mt7615_mcu_msg_alloc(&req, sizeof(req));
> > > > -       ret =3D mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_CHANNEL_S=
WITCH,
> > > > NULL);
> > > > +       ret =3D mt7615_mcu_msg_send(dev, skb,
> > MCU_EXT_CMD_CHANNEL_SWITCH);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > >         skb =3D mt7615_mcu_msg_alloc(&req, sizeof(req));
> > > > -       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_SET_RX_PAT=
H,
> > > > NULL);
> > > > +       return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_SET_RX_PAT=
H);
> > > >  }
> > > >
> > > >  int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211=
_vif
> > > > *vif,
> > > > --
> > > > 2.20.1
> > > >
> > > >
> >

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXMwJYgAKCRA6cBh0uS2t
rLLHAP9y2yWRzpCJlgx1uZbSwe0+1rXI9Vc3TwZ+5zQEY3ePtAD+IO4GoR0m/VZP
MU2d5LIE/lpOzfMdOaiQgBVVQgcEgQ0=
=fjSk
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
