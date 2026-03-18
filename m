Return-Path: <linux-wireless+bounces-33363-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PLLJUrruWlmPgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33363-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:01:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 910A72B47DF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B24EF30157CA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 00:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9978F59;
	Wed, 18 Mar 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSJvan/z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56818C2C
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792068; cv=pass; b=E9qPXjQZG/DQLFnc42ccqh7WH5g9FpZk4GqlxUz1FgM/jvALEFi9HVgcNG22Oum9jwy1LYz+buNmT0yZAWMNpLMQ5GXkqW4A0EKVr8Zl6S5VUT5n9PnnxpD4VWibD8lxQkfDbGkTtCDyJ8XTderhCvgBS4VD+QrLZQ7KZ4CKaUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792068; c=relaxed/simple;
	bh=dOJ5MHKagkP75at+FV1I0jenFRaEBbwnC0ssPLbWGTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gtbplc/H5fSDvmvyC5QW8GPUZUTYYtMcAm6C0lt+3+ZMuqSGlmcibZnmYPPmtq5AfpskKEebFUaDTVifA4fp075pwwOkpH1SpjDu/16hrzkcHJqc9W2XwsUxSg60+UtogZrVy/W1t9GlMnYmH8UQo1816iQ7321twY3vqgz32Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSJvan/z; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40ea611d1a4so2538280fac.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 17:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773792065; cv=none;
        d=google.com; s=arc-20240605;
        b=V9VjFP7ZbGDiCUSHbjpWaA/BUCfYclwWj6lw6g5YOYN+cOhpjRGz6pIt1u0MGHynje
         hd3SSINIT68DkI1VSQnEScdoiz/1lq49z5ZUZ/nJa8rHgPp8omLlA/zZl3Oii9ikQWDG
         xjzT4QLX+LoaFFYp2TZujV8rpDj9VN0qfhMgSukxzvfgEHTnTAL5LUS/XN7EOUywDuDx
         FeVQO4D0AFejZlLEjoku2WioMbX5hc/4xh2jblrSSMMT0Z2t/4NtmqDQtgA7qmxNVpi8
         zkv+vS8v/QOyT2bCgGBid0n8sip7sKr3XwCtV/xiPFEmgdfZvMA67NCvDyXYrZMajHqW
         HtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ueFNgbMJNHxikmVVGpFUvWlEwEZGN1fl+3lj1B8ybD8=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=kaQ/RzZP5PMCLjHAmcR/jZ4EydQXdV4g4GX5hrB84cWW5K+TpnqbEANNImCmMyGlZi
         rCOUQUiHBsNhN3Tt66BGfqKTAQsLHHFWKvAb5lanRlEb3qcVsxWk+VS1EVk47FpLbpxi
         uwMzofOk83UXliWAlBmkx5Fkg8/EktRSR4QJixtQRucsk0yiPdB6veB48kuJwBKOUf/f
         caCyZiJa9sNrUQ3vaMJN0efweENsxTFUxVBuGCA6hLAGKlpXYBuLqJo9C6VdKwYwfqaL
         e/KabeOg4lJJsBO9cC5GVlsxyLPXtCA/roY3TqHjEXuGrT65XpAUGm8l1b+VWAXJzOsP
         0Euw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773792065; x=1774396865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueFNgbMJNHxikmVVGpFUvWlEwEZGN1fl+3lj1B8ybD8=;
        b=FSJvan/zUou9PdRcMW9WXZBoVx8SlkvfZL1F9giO4FgqxlC58+NJ2T2d01s9e84rdM
         9cXcjwET7OfhiJ1OnMo+s8IO5mjLj8ltn513fCniIyEmA4BLuRtsrL9Zi4OlbuQoIryX
         SuQnSdOcaS8JRg0w14bVzXpuf7Psj0ALhNhpJrDvn6Lbq9s27sF9KAc9LUYa6ivcn3CS
         SQ5A8nFE2jBomoEnr/oQyzA3SfTzYlzMGbCpn/XQpPC6abHZOukbUtBXB9JTh1jut3qQ
         m+sDCR3qvcm0R44wLFdEE4ONfczkwchRuVuzKWI2KWefHC89Dv3X4d4dmydGX42Lkx3D
         CpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773792065; x=1774396865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ueFNgbMJNHxikmVVGpFUvWlEwEZGN1fl+3lj1B8ybD8=;
        b=QWrutotssnkV+musfVeB27hzd8AXx0ij0zxAmoxpA0qvz6Ocnc+6TCAjyH0Fz+b97+
         jvpILEpJBl7u07g4LOzsQuNAxuLvH+hlIo5imDxfnvUK5sNZce0sPL3CV0YV/HQMo+7Y
         VeS/s/sEdHw80cAK+ZSQ6Pq47pm1dIEUG/XjhHJScEqi7M5bx1CfD9E0zFybLcL0X+JQ
         DdbCCwFIytQSPETIaDrK93WyAPmZ/tLI3hYICYyKro9omWYM6r0mFGfNUpCLHOd6qatW
         qmdypPlQ0bWqlTHhSfRZnHms/m5ze4H1FaKLnQqsUIgKKGi6TCRwP/YHNFHnR1Q/kfQk
         Sh9g==
X-Gm-Message-State: AOJu0YxOgUuPkE5c/Mv/7Ai/0DHY6iOmXsC7b3Mmgr6sYk+JRLzp7a1A
	x/KdqPOiWoB2Z7lzEgsgnuZcZ7DKYTk/xWMrAr7YPv9CHif3qKP9V7MdyIQNl0JY+MNjh04UcIP
	DOorKZB3BpoCrrGsCjyc7Q+XfsWS8bWUBUOF1hJ2vflK7
X-Gm-Gg: ATEYQzxn8PPBddJERj0QoAZBydVwJkfgQzXQ7bhpn6Gj8upMXt0LF3yLlrIovlHX/np
	jTyO5VUdnNnyrkNpyjTrqxmsPXVCcdWbbM+bNqEIyoSY13QJltid9d4OozRf4ye74GMa9vtaxeM
	53NFrmhX/GdfGVEfK8Qye4IYxLPrBe3WwKamDK0fPtynzGbJgy4vkkNH84LFczsShtRM0auz2H1
	iAvH3YuQ7t2XxT0OMXHpUYNqxK7gNQ6+GJdaPc4NNwY0su32v4vR1TrKxy6ZN0rXXH2FBUC3L4t
	k9FwjmR1pL13p86iog==
X-Received: by 2002:a05:6870:d414:b0:409:8ccb:bc12 with SMTP id
 586e51a60fabf-41bd3e9a091mr931950fac.10.1773792064948; Tue, 17 Mar 2026
 17:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com> <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
 <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
 <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
 <1bd495ffe57c47eb827eec084729afa2@realtek.com> <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com>
In-Reply-To: <e5f00d0a42994812b42df867718fa087@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Wed, 18 Mar 2026 02:00:28 +0200
X-Gm-Features: AaiRm50VNIV5W9cuJozISOK5LW5GCasdXgrQ_3huMW9ceqbUxAG9XubVBfCMF6c
Message-ID: <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33363-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 910A72B47DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> To reproduce this reliable, you need to remove driver ko and mac80211.ko,
> and reinstall them.
>
> However, you have confirmed this is the symptom. I think only if you
> want to dig why the rate reported by hardware is weird, otherwise we
> can ignore this warning.

Following your suggestion, I performed a full stack reload including
mac80211.ko and cfg80211.ko, and was able to reproduce the warning:

  [152.226055] Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: =
0
  [152.226057] WARNING: net/mac80211/rx.c:5491 at
ieee80211_rx_list+0x177/0x1020 [mac80211]
  [152.226336] CPU: 2 UID: 0 PID: 638 Comm: irq/56-rtw_pci Tainted: G
IOE 6.19.7-1-cachyos
  [152.226344] Hardware name: HP HP Notebook/81F0, BIOS F.50 11/20/2020

One observation worth mentioning: the warning triggered approximately
72 seconds after initial association, coinciding with a Bluetooth
device connecting to the system. This may suggest the NSS=3D0 condition
occurs during BT coexistence negotiation rather than during normal
WiFi traffic. I am not sure if this is relevant, but I wanted to
mention it in case it helps narrow down the root cause.

I also noticed the offset is now +0x177, which matches exactly what
you showed from v6.19.6. The earlier +0x183 was likely an artifact of
CachyOS's LTO optimizations while mac80211 had been resident for a
long time.

As you noted, this appears to be a separate issue from the freeze and
h2c timeout problems, so I leave it to your judgment whether it
warrants further investigation.

---

I would like to take this opportunity to thank you sincerely for your
time, patience, and expertise throughout this whole process. From your
very first response to the final v2 patch, your guidance made it
possible to properly identify and resolve a bug that had been causing
real frustration for users of this hardware for a long time.

If any further testing of the rtw88 driver is needed -- whether for
this hardware or for other patches -- I am happy to help to the best
of my abilities and available time. This HP Notebook with RTL8821CE
will remain available for testing whenever it is useful.

Best regards,
Oleksandr Havrylov

=D0=B2=D1=82, 17 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 03:28, Pin=
g-Ke Shih <pkshih@realtek.com>:
>
> LB F <goainwo@gmail.com> wrote:
> >
> > Ping-Ke Shih <pkshih@realtek.com> wrote:
> > > Not sure if this is because PCIE bridge has no ASPM capability?
> >
> > That could indeed be the case -- I do not have a way to confirm
> > without further hardware-level inspection.
> >
> > > LN5491 (kernel v6.19.6) is:
> > >                 case RX_ENC_VHT:
> > >                         if (WARN_ONCE(status->rate_idx > 11 ||
> > >                                       !status->nss ||
> > >                                       status->nss > 8,
> > >                                       "Rate marked as a VHT rate but =
data is
> > invalid: MCS: %d, NSS: %d\n",
> > >                                       status->rate_idx, status->nss))
> > >                                 goto drop;
> > >                         break;
> > > Looks like driver reports improper VHT nss/rate? But this warns once,=
 and
> > > you message isn't like this.
> > > Could you check the source code LN5491 you are using?
> >
> > The file net/mac80211/rx.c is not available on disk on my system
> > (CachyOS ships only .h files in the headers package), but I located
> > the exact warning message in journalctl:
> >
> >   Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0
> >
> > This confirms that line 5491 in my kernel matches exactly what you
> > showed from v6.19.6 -- the RX_ENC_VHT case checking for
> > status->nss =3D=3D 0. The offset in my trace is slightly different
> > (+0x183 vs +0x177), which is likely due to CachyOS's LTO/AutoFDO
> > compiler optimizations.
> >
> > The warning appeared once in my initial test session:
> >
> >   Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0
> >   WARNING: net/mac80211/rx.c:5491 at ieee80211_rx_list+0x183/0x1020 [ma=
c80211]
> >
> > However, in subsequent module reload and reconnect cycles I was unable
> > to reproduce it. This is consistent with WARN_ONCE behavior -- it
> > likely fired on the first invalid nss=3D0 packet after the initial
> > driver load and has not triggered since. I cannot confirm it as a
> > reliable symptom.
>
> To reproduce this reliable, you need to remove driver ko and mac80211.ko,
> and reinstall them.
>
> However, you have confirmed this is the symptom. I think only if you
> want to dig why the rate reported by hardware is weird, otherwise we
> can ignore this warning.
>
> >
> > ---
> >
> > Regarding patch stability: the results below are from testing your
> > original RFT patch [1], not any newer submission. I want to be
> > explicit to avoid confusion:
> >
> >   [1]
> > https://lore.kernel.org/linux-wireless/20260311020816.7065-1-pkshih@rea=
ltek.
> > com/
> >
> > This is the exact diff I compiled and tested:
> >
> > --- a/drivers/net/wireless/realtek/rtw88/pci.c
> > +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright(c) 2018-2019  Realtek Corporation
> >   */
> >
> > +#include <linux/dmi.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include "main.h"
> > @@ -1744,6 +1745,34 @@ const struct pci_error_handlers rtw_pci_err_hand=
ler =3D {
> >  };
> >  EXPORT_SYMBOL(rtw_pci_err_handler);
> >
> > +enum rtw88_quirk_dis_pci_caps {
> > + QUIRK_DIS_PCI_CAP_ASPM,
> > +};
> > +
> > +static int disable_pci_caps(const struct dmi_system_id *dmi)
> > +{
> > + uintptr_t dis_caps =3D (uintptr_t)dmi->driver_data;
> > +
> > + if (dis_caps & BIT(QUIRK_DIS_PCI_CAP_ASPM))
> > + rtw_pci_disable_aspm =3D true;
> > +
> > + return 1;
> > +}
> > +
> > +static const struct dmi_system_id rtw88_pci_quirks[] =3D {
> > + {
> > + .callback =3D disable_pci_caps,
> > + .ident =3D "HP Notebook - P3S95EA#ACB",
> > + .matches =3D {
> > + DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > + DMI_MATCH(DMI_PRODUCT_NAME, "HP Notebook"),
> > + DMI_MATCH(DMI_PRODUCT_SKU, "P3S95EA#ACB"),
> > + },
> > + .driver_data =3D (void *)BIT(QUIRK_DIS_PCI_CAP_ASPM),
> > + },
> > + {}
> > +};
> > +
> >  int rtw_pci_probe(struct pci_dev *pdev,
> >     const struct pci_device_id *id)
> >  {
> > @@ -1808,6 +1837,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
> >       bridge && bridge->vendor =3D=3D PCI_VENDOR_ID_INTEL)
> >   rtwpci->rx_no_aspm =3D true;
> >
> > + dmi_check_system(rtw88_pci_quirks);
> >   rtw_pci_phy_cfg(rtwdev);
> >
> >   ret =3D rtw_register_hw(rtwdev, hw);
> >
> > Results with only this patch applied:
> >
> >   - The hard freeze lockup is gone.
> >   - However, during idle the logs are flooded with:
> >
> >       rtw88_8821ce 0000:13:00.0: failed to send h2c command
> >       rtw88_8821ce 0000:13:00.0: firmware failed to leave lps state
> >
> >   - To give a concrete sense of the volume: over an ~80-minute
> >     observation window after a clean module reload, I recorded
> >     11,757 "failed to send h2c command" events and 2 "firmware
> >     failed to leave lps state" events -- approximately 110 errors
> >     per minute during active periods.
> >   - These errors cause Bluetooth audio stuttering and WiFi
> >     throughput drops.
> >
> > When I additionally set disable_lps_deep=3DY alongside your ASPM patch,
> > all h2c errors vanish completely and Bluetooth/WiFi remain fully
> > stable. This confirms that disabling LPS Deep is necessary for
> > complete stability on this specific HP SKU.
> >
> > I also noticed what appears to be a new patch in a separate mailing
> > list thread. I will test it shortly and report back with the results.
>
> Thanks for your experiments in detail. :)
>
> Ping-Ke
>

