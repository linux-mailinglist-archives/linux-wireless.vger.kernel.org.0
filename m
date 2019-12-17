Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D256B122332
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 05:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLQEog (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 23:44:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35489 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQEog (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 23:44:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id f71so2491325otf.2
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2019 20:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LynGs4Ktcgo+Y8y0f+dyRQ7tAwuVfDFlN85s+3OARo8=;
        b=LWSlNL1sVnMEMo7fPpCvhHMlM/V7a2jMERXuBJXSLMtjg/6x77Yqo48pb58ZDxumoY
         Tcs3YUiqENTv6oUD7PMY3lO1AjrsLy/gUdVOnPDVEbc8XfasfS90XVme6pL3FLbDeTsN
         +6wjBi0aOBPJOFdW2m7BxsLqX2ZL8DkNUC8QABlQtCSJWwJPNRPWfpGk4eUB1jnCTJPH
         Bf4QvBc91OxQcKpwuWIcLVMAG6Dxk7HlDRANHVwCbmpN5ACixAXSSbTpU5F0ZMwjizeL
         /8KYTf0dpmfn9CaMClfTG6cRoPXD+G+YHYyP9AXYy5uhcmV/KfPZop5sdAhVb7bOiwyM
         rdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LynGs4Ktcgo+Y8y0f+dyRQ7tAwuVfDFlN85s+3OARo8=;
        b=n/AItOsi6b744XdZQ9Tl7TFwXVkkPSkhOcj/nj4J3ef1sfVSgxCQ3sjImeh4QUmVl7
         WGG4uHRNn+3eUOrNnCpHnOFreczJUimByVmrFsvYQCcx8pQEL3Mta5wMmSwG3GloCypA
         SzojB6PQt/q6xOvcnW4Q5mJp7Y4Ijs6V2JV1Tauxrs+Dyl2atjInpvL9BCq7Wfvdb5/4
         lKm1jMLFsLtdKXZ2vOtEkjWAGxrTraLuiDP8Ig7l/1iGFiYAnA/UMWyF4HQHa4wwtiFo
         z+SkJ3E8Ro73G5IJzkSU7PDE0VgRC5MNU/6DKk5iq9sBnBCr82pBX6TBdlJg+8CmtQYR
         uEsQ==
X-Gm-Message-State: APjAAAU16nO5OzgXjdSpggxgO7w/LjUL8LWqvcpbCkqXMXBIFb8XuFHX
        /0ERvxAB/5t73ATxotOEU82fKFfSO2+LrvVh5ykvvQ5T
X-Google-Smtp-Source: APXvYqzz69u2EhIxjgNZI2P+MvQYdYPdMnVP2L1bzKvaoCgFpxSIL5gtpbBj4ZCAtAJLkNUHyDQLHyZ7OIuMKxeEN5k=
X-Received: by 2002:a9d:eea:: with SMTP id 97mr33627442otj.177.1576557874891;
 Mon, 16 Dec 2019 20:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20191213230334.27631-1-greearb@candelatech.com> <e2c54ffb-d346-65b0-e4ab-1cd2f8ff2a27@candelatech.com>
In-Reply-To: <e2c54ffb-d346-65b0-e4ab-1cd2f8ff2a27@candelatech.com>
From:   Justin Capella <justincapella@gmail.com>
Date:   Mon, 16 Dec 2019 20:44:23 -0800
Message-ID: <CAMrEMU-Ei3Y9zT=td+amsM3-fi4WP2_ihX=Tjh0A=vPx08_Biw@mail.gmail.com>
Subject: Re: [RFC] mac80211: Fix setting txpower to zero.
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

https://patchwork.kernel.org/patch/9465291/ looks like this older
related patch was to work around p2p control vif being set to zero and
never reconfigured, I'll try and test this patchset with various vif
types. One thing I thought of, it might be cleaner to use int max,
since code is already looking for a minimum, and ultimately would be
limited by 2g/5g power limit,  perhaps initialize the txpower with
those values? Then you avoid a magic value?

What does the hw do with a txpower of zero anyway?

On Mon, Dec 16, 2019 at 2:56 PM Ben Greear <greearb@candelatech.com> wrote:
>
> On 12/13/19 3:03 PM, greearb@candelatech.com wrote:
> > From: Ben Greear <greearb@candelatech.com>
> >
> > With multiple VIFS ath10k, and probably others, tries to find the
> > minimum txpower for all vifs and uses that when setting txpower in
> > the firmware.
>
> Johannes, sorry to be impatient, but I want to get some new ath10k-ct
> changes into OpenWRT (to fix per-chain RSSI reporting), and if only my
> driver change goes in, then ath10k-ct will have the old problem that Ryan Hsu
> tried to fix.
>
> Are you OK with initializing the txpower to -1 to mean 'unset' in mac80211?  Or, do I need
> to come up with some other way to indicate to the driver that the txpower should
> be ignored?
>
> Thanks,
> Ben
>
> >
> > If a second vif is added and starts to scan, it's txpower is not initialized yet
> > and it set to zero.
> >
> > ath10k had a patch to ignore zero values, but then it is impossible to actually set
> > txpower to zero.
> >
> > So, instead initialize the txpower to -1 in mac80211, and let drivers know that
> > means the power has not been set and so should be ignored.
> >
> > This should fix regression in:
> >
> > commit 88407beb1b1462f706a1950a355fd086e1c450b6
> > Author: Ryan Hsu <ryanhsu@qca.qualcomm.com>
> > Date:   Tue Dec 13 14:55:19 2016 -0800
> >
> >      ath10k: fix incorrect txpower set by P2P_DEVICE interface
> >
> > Tested on ath10k 9984 with ath10k-ct firmware.
> >
> > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > ---
> >   drivers/net/wireless/ath/ath10k/mac.c | 2 +-
> >   drivers/net/wireless/ath/ath9k/main.c | 3 +++
> >   drivers/net/wireless/ath/ath9k/xmit.c | 7 +++++--
> >   include/net/mac80211.h                | 2 +-
> >   net/mac80211/iface.c                  | 1 +
> >   net/mac80211/main.c                   | 2 ++
> >   6 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> > index 289d03da14b2..c846f232e930 100644
> > --- a/drivers/net/wireless/ath/ath10k/mac.c
> > +++ b/drivers/net/wireless/ath/ath10k/mac.c
> > @@ -5906,7 +5906,7 @@ static int ath10k_mac_txpower_recalc(struct ath10k *ar)
> >       lockdep_assert_held(&ar->conf_mutex);
> >
> >       list_for_each_entry(arvif, &ar->arvifs, list) {
> > -             if (arvif->txpower <= 0)
> > +             if (arvif->txpower < 0) /* txpower not initialized yet? */
> >                       continue;
> >
> >               if (txpower == -1)
> > diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
> > index 14f253199909..2edf70cf7e7e 100644
> > --- a/drivers/net/wireless/ath/ath9k/main.c
> > +++ b/drivers/net/wireless/ath/ath9k/main.c
> > @@ -1196,6 +1196,9 @@ static void ath9k_tpc_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
> >   {
> >       int *power = data;
> >
> > +     if (vif->bss_conf.txpower < 0)
> > +             return;
> > +
> >       if (*power < vif->bss_conf.txpower)
> >               *power = vif->bss_conf.txpower;
> >   }
> > diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
> > index 751d0d0550b5..82c592ca2cd2 100644
> > --- a/drivers/net/wireless/ath/ath9k/xmit.c
> > +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> > @@ -2114,10 +2114,13 @@ static void setup_frame_info(struct ieee80211_hw *hw,
> >
> >       if (tx_info->control.vif) {
> >               struct ieee80211_vif *vif = tx_info->control.vif;
> > -
> > +             if (vif->bss_conf.txpower < 0)
> > +                     goto nonvifpower;
> >               txpower = 2 * vif->bss_conf.txpower;
> >       } else {
> > -             struct ath_softc *sc = hw->priv;
> > +             struct ath_softc *sc;
> > +     nonvifpower:
> > +             sc = hw->priv;
> >
> >               txpower = sc->cur_chan->cur_txpower;
> >       }
> > diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> > index 2b70b9268f76..db66520c5389 100644
> > --- a/include/net/mac80211.h
> > +++ b/include/net/mac80211.h
> > @@ -569,7 +569,7 @@ struct ieee80211_ftm_responder_params {
> >    * @ssid: The SSID of the current vif. Valid in AP and IBSS mode.
> >    * @ssid_len: Length of SSID given in @ssid.
> >    * @hidden_ssid: The SSID of the current vif is hidden. Only valid in AP-mode.
> > - * @txpower: TX power in dBm
> > + * @txpower: TX power in dBm.  -1 means not configured.
> >    * @txpower_type: TX power adjustment used to control per packet Transmit
> >    *  Power Control (TPC) in lower driver for the current vif. In particular
> >    *  TPC is enabled if value passed in %txpower_type is
> > diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> > index b0c2df6e22c5..49fcf9d80f85 100644
> > --- a/net/mac80211/iface.c
> > +++ b/net/mac80211/iface.c
> > @@ -1459,6 +1459,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
> >       sdata->control_port_no_encrypt = false;
> >       sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
> >       sdata->vif.bss_conf.idle = true;
> > +     sdata->vif.bss_conf.txpower = -1; /* unset */
> >
> >       sdata->noack_map = 0;
> >
> > diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> > index a148509a88bc..2f53188851ee 100644
> > --- a/net/mac80211/main.c
> > +++ b/net/mac80211/main.c
> > @@ -145,6 +145,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
> >                       continue;
> >               if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
> >                       continue;
> > +             if (sdata->vif.bss_conf.txpower < 0)
> > +                     continue;
> >               power = min(power, sdata->vif.bss_conf.txpower);
> >       }
> >       rcu_read_unlock();
> >
>
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
