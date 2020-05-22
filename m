Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483941DDD0C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 04:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEVCO0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 22:14:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35885 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgEVCOY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 22:14:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id c75so4271142pga.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 19:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=5xXlAUdNxxbqmtIzPX0Y6v5oVDMXcpv1kNE3XH49C+s=;
        b=jhqdXhtXB6qPVc68oP5Jrdk6oOr68NjV7+nsGnyfdW+1QVNrlhgVf6dR4PzlIFEr58
         zzFMxNZxDDBOFTw1/DKOot3gDD9/g47OL2g1tmCmlp+oB7KRpgoFETIokvAjoJ+qVMF9
         2/bVvPh+N/H63dPecSMKQtLZsyzBDL/arbM7yWhCv9v3AAuH9joAg5aLZ1vzqvwMIoVO
         g7NSiUWI+ey7ziPtRks9xMNgGD4nzeMsUkEKo4lmILD+CD6zVwf+lNmLKiJHCUumcoM+
         3f79T2VRFmdESyuqdA9NRTmVwzpBWhFusM6q6olciWqtqI95jx8qNqMl/0TsND6fyL/7
         3Btw==
X-Gm-Message-State: AOAM533Ws3Rwckwo9s2LbcezluXo3LaIianlv9gdtVkUtR7sXDbAHNge
        OoqD+lPLYtUZG0npFnQraEM=
X-Google-Smtp-Source: ABdhPJwPo3q1iCo4RyJ0sfUw3XyKH3HFb8BkVNkTbTt8wPc0Z6XwgWMML8ftGGVJapgbOs9lR4L+WQ==
X-Received: by 2002:a62:e305:: with SMTP id g5mr1728352pfh.144.1590113663219;
        Thu, 21 May 2020 19:14:23 -0700 (PDT)
Received: from [10.101.46.193] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id c63sm5386372pfc.2.2020.05.21.19.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 19:14:21 -0700 (PDT)
Subject: Re: [PATCH 0/3] rtw88: 8723d: follow up fixes
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        kai.heng.feng@canonical.com
References: <20200518081444.7664-1-yhchuang@realtek.com>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
Autocrypt: addr=vicamo.yang@canonical.com; keydata=
 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
 suzL+d2CSm1cCUYQeOxX/7MpmAIm
Message-ID: <445782d3-6729-8e37-f54f-a7220b82037f@canonical.com>
Date:   Fri, 22 May 2020 10:14:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518081444.7664-1-yhchuang@realtek.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xOl6bSipeugcobRdyQ3BsLsGsCeqYj4bn"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xOl6bSipeugcobRdyQ3BsLsGsCeqYj4bn
Content-Type: multipart/mixed; boundary="4UqWfIcBFUTmVtbq0RLA7AasKk0aBgWDj"

--4UqWfIcBFUTmVtbq0RLA7AasKk0aBgWDj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This works for me by following verification steps:

1. pair with one Bluetooth headset,
2. connect to some WLAN
3. run `nmcli d disconnect $ifname`, `nmcli d connect $ifname`
interactively with time intervals for 100 runs.
4. wireless interface is still alive without that "deauthenticated
(Reason: 23=3DIEEE8021X_FAILED)" error.

Tested-by: You-Sheng Yang <vicamo.yang@canonical.com>

On 2020-05-18 16:14, yhchuang@realtek.com wrote:
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>=20
> The RTL8723DE devices have been tested by Canonical for the coex
> and basic wifi functions. And they have reported some issues for
> RTL8723DE. Fix them accordingly.
>=20
> Ping-Ke Shih (3):
>   rtw88: coex: 8723d: set antanna control owner
>   rtw88: coex: 8723d: handle BT inquiry cases
>   rtw88: fix EAPOL 4-way failure by finish IQK earlier
>=20
>  drivers/net/wireless/realtek/rtw88/coex.c     | 21 ++++++++++++++-----=

>  drivers/net/wireless/realtek/rtw88/mac80211.c |  3 +--
>  drivers/net/wireless/realtek/rtw88/main.c     | 16 ++++++++++++++
>  drivers/net/wireless/realtek/rtw88/main.h     |  4 ++++
>  drivers/net/wireless/realtek/rtw88/rtw8723d.c | 10 +++++++--
>  drivers/net/wireless/realtek/rtw88/rtw8723d.h |  1 +
>  6 files changed, 46 insertions(+), 9 deletions(-)
>=20


--4UqWfIcBFUTmVtbq0RLA7AasKk0aBgWDj--

--xOl6bSipeugcobRdyQ3BsLsGsCeqYj4bn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEVhtdp+wXuXuqVL95S6BJ+2O0nE8FAl7HNXIACgkQS6BJ+2O0
nE+Wzwf/UShwAKl7FPozHNI4xz0AKPzwrXnmzBDmaqtPPqLB6I81JjDqyGjulVh6
+xNFRpXg7VCjIetAPZ1ZhXOy4iT9fWUL2c8NzLiDG7aPT//8pmYWU1UHAzfW34Q3
djmBU8O5Mu7IVkMCh94ae0CGe/tk+uCN8rgpfSS1vaL92gZnMlTmepkp/gzkuzOG
kPmxf6M0pn7SfMBVMCLYL2StRKUgbisWq9pIZ/m2Df4onr90ASgxxqUvg+rFStPo
4WgN70A7WD0VzdZIOtp3Wt0Yv8NFpFonx6+7LGssUI3O4kOrWLwSYb4rbGbZ52k2
4eG7zIGGshBd0AEXJ73SClIyq4gFKA==
=cAam
-----END PGP SIGNATURE-----

--xOl6bSipeugcobRdyQ3BsLsGsCeqYj4bn--
