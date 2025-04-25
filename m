Return-Path: <linux-wireless+bounces-22078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B00A9CF02
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F320189F25E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2F1B87C0;
	Fri, 25 Apr 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="SOq/Gh4v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFC1A3152
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599778; cv=none; b=WUcwKCSIxWOxwMMfah2gFnJlHAjqlqh4kq366QVGdIXgXz7MpF3EQoQ8t8we3nSlm0nBT4sMZ84j0k2dh7BDwPP+kRy59aLbxtgbX4ekScwxNbGjrsmxVEZ5b89oZCn7OJEFaDa3oyGGWGEhxkaVO38OHkkoq+9pB0tYh/Qa3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599778; c=relaxed/simple;
	bh=Lsf0S+vUVkTKSmrTusoRK1riqmlMVBxIhTwbVEI953E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMdiH5eQQtAKRGeoInnfnR6Kkznx+ZVUdU2kDoEKFIlL+2+13IplXuK2pmKqFapP7g6bGuB7zrUjyiFF44pMNLrQZnBpAnD/tNEK539+U4jCQXrlGpy5wBMFPhw9y+NHzxmSv/pu+AsaLM125C5rjl//U1GFzQvBPFETW8G5sY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=SOq/Gh4v; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f435c9f2f9so3203366a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1745599773; x=1746204573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbKgincIXwNS069akmSCof3QJASoEBvfuiSMsRimGso=;
        b=SOq/Gh4v9+SBkMqNTQ3MZvLfzlCkarb8njY4USLEg+/yp/qswlLn5PrGfydLtIYcss
         cuqgCc/AWZ6SnG6W7V65wrv5T0Udcu9xpUvST3AZJtuE1XdL5vdj6+jYtMIW71hqpBqL
         c1PwqdRmW6uKaRQqckQJHaRkwrGrf83RcSbBCnT2D76Vv2jzzrk9C/U4ymYdhGegXSyn
         eaFKH84mlh98TSG/ho95UKprZtjUElBEMtOvYz40Djis7l74934/BTia6j36/xytmV4c
         BofYYpvqSlmVUfutcat92IX9QwNcGyAlE2inwwmbap3Ol4AE55JslPvNkaky7hsRcHEM
         aMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745599773; x=1746204573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbKgincIXwNS069akmSCof3QJASoEBvfuiSMsRimGso=;
        b=i13AEZxIAf7fEDXUWn7cwDqLzZa6UvKl6HhxxpqBoXHU5uEOhUnGe6olBiH1zkIsXg
         O+FF3JbMMRKMqHDBavCgTb3ti94pfFmFLEIFAnCxbG1v9d8XNnL0rvtJ3EdXW/jXt8i9
         NYjCKguvAts/3/d6QTDYtlySWFbK4zp9CZdj+R+Vu7WHssuPf8MZegVsPxCHtu26XGmf
         FYlyNtiKvjrxUeVrsM76xECBLRTMDcRRpsfn9NV/scVWN8csEXupfPmNcvPaAYxAh/Sp
         HcYmqtsOeAdxF3SBT00RR+k8LNrBT6YzFa+t7xbzZOjsl1kD7xNZ8JEEXTMjwXjdvcFa
         j/5w==
X-Forwarded-Encrypted: i=1; AJvYcCVO2XrxA6FgwCDrGkof6R0ir/wheyabNFNef28MhKd8Vyz4Qu6tIJZoy48qkQusRMEXn+UMXCDwfOg8irzk+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bjLc9jWtE2Q2aus2emVs65PVjwaG9hZboDR19MCTeEY+Iy0M
	isjAWSoBIcQA5XcHbGoKKY/IzqzWIxv/kkZxJHbvAQDPRHqb0Qu070LA1cbXolQaw2E0WKKGc1X
	YSr6b7oY6jUTi71B9Woa9pNT+oA4O8PgVdDOGyA==
X-Gm-Gg: ASbGncsDE4EogMArM5+ANwKvgdDKdR2+l47CCL1q7xTlY0Zj+sQdt9OmrBgWanVPxdE
	CZeecDW8E7C3SZ/3iXbcT/uaooo7AZJl1AUhhvD96QEwJKPWMPMUhTlwPJ0QsSOsFGzmh6WiwuD
	F5RZqIfqTNoX1BgSyVyR6sxuE8VYv7Ij36fA==
X-Google-Smtp-Source: AGHT+IF+K/Y/hteHUL1Z1Houp7sxak6tVG3ZmtYLQ81YFGs/nLav2zw2Js385WaP/0YCdeVMq4A3IVLkIyFbhxRyO8U=
X-Received: by 2002:a05:6402:254c:b0:5f6:59e5:5c6e with SMTP id
 4fb4d7f45d1cf-5f73982bd97mr62863a12.26.1745599773147; Fri, 25 Apr 2025
 09:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422175918.585022-1-artur@conclusive.pl> <20250422175918.585022-3-artur@conclusive.pl>
 <45b74f9f0831294e783a019cd6a1437fdad4eb6a.camel@sipsolutions.net>
In-Reply-To: <45b74f9f0831294e783a019cd6a1437fdad4eb6a.camel@sipsolutions.net>
From: Artur Rojek <artur@conclusive.pl>
Date: Fri, 25 Apr 2025 18:49:22 +0200
X-Gm-Features: ATxdqUGbZqRqLun2t5seqE0xBbyhBwhTsJOfC8_PKvG7-cB8xXWfuYtVPvY4uP0
Message-ID: <CAGhaMFO_f_bvFB+39-z6xVF+y446ONwm1ROHQ=rXj=s4MnL54w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] wifi: Add Nordic nRF70 series Wi-Fi driver
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Klama <jakub@conclusive.pl>, 
	Wojciech Kloska <wojciech@conclusive.pl>, Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,
thanks for the review thus far!

Replies inline.

On Thu, Apr 24, 2025 at 5:07=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Tue, 2025-04-22 at 19:59 +0200, Artur Rojek wrote:
> > Introduce support for Nordic Semiconductor nRF70 series wireless
> > companion IC.
>
> Seems simple enough ... but I notice you're not even adding a
> MAINTAINERS file entry. Does that mean you're not going to stick around
> to maintain it at all? I'm definitely _not_ going to. Please don't
> expect the community to.
>
> Are you doing this for your customers? Or are you just doing this a
> contract for someone who needs it? I don't really care all that much but
> contracts have a tendency to go away and then we're left with nothing
> upstream ...

This is commercial work. I am employed by Conclusive Engineering, and
was tasked with writing this driver. It was done for our internal needs
(we sell hardware [1] with nRF70 on-board), however I was also asked to
send the series upstream.
Nordic showed interest in this work, hence why their representative is
CCd to this conversation. They agreed to use our hardware as a reference
board for nRF70 used in Linux context.

I fully understand your concerns with maintenance (I am privately
a kernel contributor as well), and discussed this topic internally with
appropriate decision making people. They understand the responsibilities
involved and agreed to allocate time for me to support this driver long
term. As such, I will add myself to MAINTAINERS in v3.

>
> Also, related, what are your plans to help out with wireless in general,
> particularly reviews? You're building on the shoulders of everyone who
> did work before ... I'll do a _very_ cursory review, but if you want to
> get this merged I would expect you to also become a part of the
> community and help review other people's code:
>
> https://lore.kernel.org/linux-wireless/21896d2788b8bc6c7fcb534cd43e75671a=
57f494.camel@sipsolutions.net/

Bearing in mind above time constraints, I have no objections to helping
out. That said, this is my first Wi-Fi driver, and as such I am not that
familiar with the cfg80211 subsystem (hence why this series is RFC), so
my expertise will be limited at best.
What sort of help would you expect from me with the reviews?

>
> > +config NRF70
> > +     tristate "Nordic Semiconductor nRF70 series wireless companion IC=
"
> > +     depends on CFG80211 && INET && SPI_MEM && CPU_LITTLE_ENDIAN
>
> That CPU_LITTLE_ENDIAN seems like a cop-out. Do we really want that?
> Asking not specifically you I guess...

I addressed this in the cover letter (Patch 0/2), but nRF70 communicates
using little-endian, byte packed messages, where each message type has
a unique set of fields. This makes it a challenge to prepare said
messages on a big-endian system. I am aware of the packing API [2],
however a cursory look at it indicates that I would need to provide
custom code for each and every message (there's almost 150 of those in
total, even if the driver doesn't support all of them at the moment -
take a look at nrf70_cmds.h).
So I decided that until someone actually needs to use nRF70 on
a big-endian machine, implementation of big-endian support can be
postponed.
Unless the __packed attribute is guaranteed to align the bytes the same
way regardless of the endianness, and so calling cpu_to_le* for every
field of a message is good enough (these messages are byte packed, not
bit packed)?

>
>
> > +#define      NRF70_RADIOTAP_PRESENT_FIELDS                           \
> > +     cpu_to_le32((1 << IEEE80211_RADIOTAP_RATE) |            \
> > +                 (1 << IEEE80211_RADIOTAP_CHANNEL) |         \
> > +                 (1 << IEEE80211_RADIOTAP_DBM_ANTSIGNAL))
>
> You did some work on making it little endian properly ..
>
>
> > +
> > +#define      NRF70_FW_FEATURE_RAW_MODE       BIT(3)
> > +struct __packed nrf70_fw_header {
> > +     u32 signature;
> > +     u32 num_images;
> > +     u32 version;
> > +     u32 feature_flags;
> > +     u32 length;
> > +     u8 hash[NRF70_FW_HASH_LEN];
> > +     u8 data[];
> > +};
> > +
> > +struct __packed nrf70_fw_img {
> > +     u32 type;
> > +     u32 length;
> > +     u8 data[];
> > +};
>
> making the u32's here __le32's (and fixing sparse) would probably go a
> long way of making it endian clean. The __packed is also placed oddly.

When declaring structure members for the messages (in nrf70_cmds.h),
I noticed that this attribute has to go before the braces:
> struct __packed { ... } name;
rather than after braces:
> struct { ... } __packed name;

I then went and applied the same style elsewhere in the driver. I guess
I can restore the latter syntax where it makes sense.

>
> > +static int nrf70_verify_firmware(struct device *dev,
> > +                              const struct nrf70_fw_header *fw)
>
>
> What's the point in doing this? The hash is trivially adjusted if
> someone wants to play with the file, if hw doesn't check anything, and
> ... not sure we really need such a thing for "file is corrupt by
> accident"? *shrug*

No idea if the hw does any verification of the hash, but sure, I can
drop this.

>
> > +     ret =3D request_firmware(&firmware, "nrf70.bin", dev);
>
>
> You might want to make that async so that the driver can be built-in
> without requiring the firmware to also be built-in.
>
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to request firmware: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     header =3D (const struct nrf70_fw_header *)firmware->data;
>
> (const void *) cast would probably be sufficient
>
>
> > +     return ret ? ret : (wait_for_completion_timeout(&priv->init_done,=
 HZ) ?
> > +                         0 : -ETIMEDOUT);
>
> that construct seems a bit questionable :)
>
>
> > +static void nrf70_handle_rx_mgmt(struct spi_mem *mem,
> > +                              struct nrf70_event_mlme *ev)
> > +{
> > +     struct nrf70_priv *priv =3D spi_mem_get_drvdata(mem);
> > +     struct nrf70_vif *vif =3D nrf70_get_vif(priv, ev->header.idx.wdev=
_id);
> > +
> > +     if (IS_ERR(vif))
> > +             return;
> > +
> > +     (void)cfg80211_rx_mgmt(&vif->wdev, ev->frequency, ev->rx_signal_d=
bm,
> > +                            ev->frame.data, ev->frame.len, ev->wifi_fl=
ags);
>
>
> shouldn't need the (void) cast?
>
>
> > +static int nrf70_change_bss(struct wiphy *wiphy, struct net_device *nd=
ev,
> > +                         struct bss_parameters *params)
>
>
> See also this discussion:
> https://lore.kernel.org/linux-wireless/29fa5ea7f4cc177bed823ec3489d610e1d=
69a08f.camel@sipsolutions.net/
>
> > +static int nrf70_dequeue_umac_event(struct spi_mem *mem, void *data)
> > +{
> > +     struct nrf70_priv *priv =3D spi_mem_get_drvdata(mem);
> > +     struct device *dev =3D &mem->spi->dev;
> > +     struct nrf70_umac_header *header =3D data;
> > +     struct nrf70_vif *vif =3D nrf70_get_vif(priv, header->idx.wdev_id=
);
> > +     struct cfg80211_scan_info scan_info =3D { .aborted =3D true };
> > +
> > +     if (IS_ERR(vif))
> > +             return PTR_ERR(vif);
> > +
> > +     switch (header->id) {
> > +     case NRF70_UMAC_EVENT_TRIGGER_SCAN_START:
> > +             break;
>
>
> This sounds like you pretty much built the firmware for cfg80211 ;-)

That's because the firmware *is* cfg80211. Perhaps I am opening a can of
worms here, but it has to be opened at some point during firmware
upstream. From what I've seen, part of the nRF70 firmware (called UMAC)
is derived from the cfg80211 project. Nordic makes the source code
publicly available at this location [3]. I have also asked Nordic to
provide a matching version of the source code for the fw blob they will
be upstreaming to the linux-firmware project (I believe I will be
assisting in that process as well). I hope everything there is dandy
license-wise, as I am not a lawyer :)

>
>
> > +#define      NRF70_MSG_SYSTEM                0
> > +#define      NRF70_MSG_DATA                  2
> > +#define      NRF70_MSG_UMAC                  3
> > +
> > +struct __packed nrf70_msg {
> > +     u32 len;
> > +     u32 resubmit;
> > +     u32 type;
> > +     u8 data[];
>
>
> similar comments here throughout this entire file wrt __packed and
> __le32, obviously

Addressed above wrt __packed.

>
> > +/* Undocumented PHY configuration parameters. */
> >
>
> haha :)

Yep :)
To be clear on the development process of this driver, no proprietary
documentation has been used. I've written it entirely based on the
publicly available Nordic's SDK [4], their Zephyr driver [5], the
aforementioned UMAC source code, and a fair amount of guess work. This
means there is some undocumented stuff available only as magic numbers.

>
>
> Oh and before I forget, how about firmware availability?

Nordic gave us permission to upstream it, see the cover letter.

PS. I was oblivious to the specific patch submission rules for
linux-wireless until after I've sent v2 series. Sorry for any
inconvenience! The v3 will be formatted appropriately.

Cheers,
Artur

[1] https://conclusive.tech/products/kstr-imx93-sbc/
[2] https://www.kernel.org/doc/html/latest/core-api/packing.html
[3] https://files.nordicsemi.com/ui/native/developerDoc/external/oss/nRF700=
x/
[4] https://github.com/nrfconnect/sdk-nrfxlib/tree/v2.7-branch/nrf_wifi
[5] https://github.com/zephyrproject-rtos/zephyr/tree/main/drivers/wifi/nrf=
_wifi

>
> johannes

