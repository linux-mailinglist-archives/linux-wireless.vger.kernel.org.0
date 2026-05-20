Return-Path: <linux-wireless+bounces-36685-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AOSCIpZDWpuwQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36685-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 08:49:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 892E85885E7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 08:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C034301C944
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A96D36492D;
	Wed, 20 May 2026 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUGjX1Yo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068633F5B5
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259783; cv=pass; b=lgi6A6yr5px4GYBQZoofh+LwBxzqpTCO/8UX1leYXYtA6tr4kTQuIlaJ3ck8FzQz/campsxbjINIck2BaGw6/6Y5HworeyIThEEtJr7vU6wgmI8tZp+jnkzfsGssOrJXzFtpX13zg3ZZYB35ag7FmD5LdMjqRU7lYHUNl/xkA1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259783; c=relaxed/simple;
	bh=sT50Js/HvqbILTuamLO2U3DFc324FocpvqzyXtZn8Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btR55+yEGT8f9O/r7sMQb0opE185LPfGG7Up5fCS/seGBTYBHXpP9Y1g1VsxfuLf32a4jLzPP9xZkmT/8m/s2lfZVN7v0UhjrwO8OsFU748FgBg+T/b4jDBrajxQJCh9ZZy95C7d7rdrQxQ2XO2SqTWiZvn4KSQt4yV/0sHPlN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUGjX1Yo; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so2259396a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 23:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779259780; cv=none;
        d=google.com; s=arc-20240605;
        b=fZyRkISlKzFMn50muwXs+Pz8gk6U9vJa/ZZJ6SdefufqxQfTlQdHcPJ20+OQG9ABvx
         YSfsmLensYFnY4p1RDKoH8w+nUbJIxDTCKTNSe5WkQoBI69tX0QWuDf/GPbCuEZyTbQa
         nszWfLOb0YoUF+yvBUxiAnQQ7sXk6pY5RBycnm5JF2MQ4U2C5QqWpd5a5fhAMDeXwZTY
         EkBYI/LL3uOBjt40bWdFqLU1GhbS+7hnzzaAmlNL8KD7+VI8xZ4CvFalNOWezBcRx+j+
         T42pzPPJ0Rs3mchuXfxhv8Nk7XqVTgyi+Vmb76GUt9jsXcV2U5q9YMTmzjeRdRqacvf7
         GrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JAuSrL4+rxOaHQyti+Llt0W4L9ZSa8Y9FlYNFRrGF9o=;
        fh=Xt6DJBhVdGLD/sjgGstjsLUTR1NKMVjw3VQjALXAPBY=;
        b=Dd7DZ3TXXylVstlN+B2ePPJ7IscYbSauDJxqFg66J5LKbhRMrmT/KVBEAt4beDMmiU
         ACYjkRMBpHRjHTOReIiHhaUukoNdSvATambW00ntI7ykXOAmi21OdnfHyVVfM0Z71KCt
         t6WktjHPXN7IN7UYZmMtcX0VFJGuHRtXdbw4Dn31/stAxSLUkwbIXFYGK+1ClLu+70O7
         5D31AVeMNIEY96zw5Xi+nKXnNU6JGMs4blhBHkSfjeOV92fkN8Fd5c6j4ArJMP+3FC6u
         F5DxJYJwrPqcKUqhinPKiyMKN5Tz7bny4OTSJh0LHhNZbimE+pMTnIy2eIL0XClcCbxc
         yPvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259780; x=1779864580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAuSrL4+rxOaHQyti+Llt0W4L9ZSa8Y9FlYNFRrGF9o=;
        b=lUGjX1Yo5SOVVT0+lGvnbHgbuTtn2RyzQu/TTaP3AW6wbtWZYd7az1j56+hFIXKBVO
         eL8ECPjJitpM67J/8NW5j7ZSkYVCaE2HFCEmtLWYaQ45fNz13PTWGhMVFChg5o7bAZWf
         rY0ZJVwCucY3PTHnnoktn/FpDLCtzVS4DCo/oCuQ2K/ZW79KXagvBjEXRQ9b4xxGVvrD
         FnMc+lJIusOqWGHaavE62tVtFctiqysxPVwKm3JtnsGxk5lfUrV8Z1nTjj1l72jJgLdi
         9sTsucCZW5uTsTg4GW+oC+eFgf1iXWSlloQkI0hJoJPEr8LrLYt6MZ+gmkMVXFYwfFqX
         Pp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259780; x=1779864580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JAuSrL4+rxOaHQyti+Llt0W4L9ZSa8Y9FlYNFRrGF9o=;
        b=bSM81F8j/a5SaWdIosSxSYIqphVy+eZ8dZ8sAFKjSxt0/elU+5soBDbZS8cmtOAU9R
         Jj2mE5fM5VjZ9qsf6b211g0CONobDI25B90c5QWwE8ytFSulf02hUpYtALgvn58vPMRX
         M6IOhXHY7VEqxwp/AngS98qqFoH6fLwC7aok3s+plJ/gnr8ECIqSq0JI4xfMByxNiG0S
         J18S+VyimPMiHj2HV2B64XqSMrgfapw7Zt4YNSIHLgii0jaUqlLgv9im1Au/L/d8HQFe
         IvaxVRLm5NqPRYplS34vQPl08LG0mr9HTbs8Zz/sGE6NQqcq1Ym/a/5J2+X4r9Ap+6tA
         M0uA==
X-Gm-Message-State: AOJu0Yy48JRZpY/O6Ems7utbqo6YHGGYRBqkZsgNSejpe2+MK4tvFbZY
	+HVVVPnALqGUuqbeASEXVu8i3/sUZuuAoTujvmUdCIoJoLKyxOX0ppII5j48aeuaYOnxm4RfcM3
	K+Mu3vQ2S9mkbFvVN5FNbwlrTXBMBS5s=
X-Gm-Gg: Acq92OGyzZ5wGqR5qtQI4jsqvyKor3TLPO1o02RshFxaYfoQ6gKh/WIu61MJjOqVmkh
	Qx3hfQG3Y3pPq+C5P9KFhZh41HkfvUOLqRDMywxQyp1bpRXmvTDimRtjQ10vnLciQLGjZ0lkwVJ
	5D7eDwAghzsq5qr5Lh0g/fnYFnESNDd4xAjs0exW/oGulXa4xeYq2k3LA+SOTXzIooUebsH8oGW
	eIcc5TX0i7KTskc6zhhbc8wffXj/TtfHCITi5eavk0JYZ3uMUldIuarIfOMz8cpjUISzh/XB7/S
	SflIytwU
X-Received: by 2002:a05:6820:207:b0:696:1c20:722d with SMTP id
 006d021491bc7-69c9bfe7be4mr14201167eaf.53.1779259780425; Tue, 19 May 2026
 23:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
 <20260519235713.49109-1-lucid_duck@justthetip.ca> <20260519235713.49109-2-lucid_duck@justthetip.ca>
In-Reply-To: <20260519235713.49109-2-lucid_duck@justthetip.ca>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Wed, 20 May 2026 08:49:28 +0200
X-Gm-Features: AVHnY4L7szzLrhL-gTybMcDm-TbHhbYKzO0W-AtsQUpeg5gxYof-SGTMSn63v9U
Message-ID: <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: Devin Wittmayer <lucid_duck@justthetip.ca>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, 
	Brite <brite.airgeddon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36685-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,nbd.name,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,sipsolutions.net:email]
X-Rspamd-Queue-Id: 892E85885E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Let me know if any testing of a concrete patch is needed when you feel
it is completely fixed.

P.S. My environment was Kali VM using Vmware.

Regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El mi=C3=A9, 20 may 2026 a las 1:57, Devin Wittmayer
(<lucid_duck@justthetip.ca>) escribi=C3=B3:
>
> From: =E5=82=85=E7=BB=A7=E6=99=97 <fjhhz1997@gmail.com>
>
> Commit d594cc6f2c58 ("wifi: mac80211: restore non-chanctx injection
> behaviour") restored the monitor injection fallback for drivers using
> chanctx emulation but explicitly deferred drivers that transitioned
> to real chanctx ops. mt76 falls in that category and still drops
> every injected frame when monitor coexists with another interface.
>
> When the monitor has no chanctx of its own, fall back to the only
> chanctx in flight if there is exactly one. Refuse if multiple are
> present: picking arbitrarily would inject on an unrelated channel.
> Emulated and real chanctx drivers both flow through this fallback,
> since emulation always presents zero or one chanctx in
> local->chanctx_list.
>
> Reran the airgeddon evil-twin flow (hostapd AP + coexisting monitor
> VIF on the same phy + aireplay-ng deauth from the monitor) on
> mt7921e PCIe and mt7921u USB across 2.4 GHz and 5 GHz, and on a
> Kali VM with MT7921U passthrough as the closest match to the
> original reporter's setup. None reproduced the hang seen against
> the earlier attempt at this fix
> (<20251216111909.25076-2-johannes@sipsolutions.net>) or against v1
> on lore in March.
>
> Cc: stable@vger.kernel.org # 6.9+
> Reported-by: Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>
> Closes: https://github.com/morrownr/USB-WiFi/issues/682
> Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
> Signed-off-by: =E5=82=85=E7=BB=A7=E6=99=97 <fjhhz1997@gmail.com>
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> ---
> v4:
>   - Drop the dedicated local->emulate_chanctx branch. Emulation always
>     presents zero or one chanctx in local->chanctx_list, so the
>     single-chanctx walk handles that path too.
>   - Real-chanctx TX path is unchanged, so v3 Tested-by carries.
>
> v3:
>   - Replace list_is_singular() + list_first_entry() with
>     list_first_or_null_rcu() and an rcu_access_pointer() check
>     that the entry is the only one in the list. The v2 pair
>     re-read ->next without RCU between the singularity check
>     and the entry fetch, racing list_del_rcu() of the sole entry
>     (rculist.h).
>
> v2:
>   - First respin under my submitter signoff; preserves fjh1997
>     authorship.
>   - Verification matrix; airgeddon evil-twin flow on mt7921e/
>     mt7921u/Kali-VM does not reproduce the hang reported against
>     the v1 attempt at this fix.
>
>  net/mac80211/tx.c | 16 ++++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 933c86ca21c3..a8c5d3a2b1f0 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -2407,12 +2407,18 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct s=
k_buff *skb,
>                                 rcu_dereference(tmp_sdata->vif.bss_conf.c=
hanctx_conf);
>         }
>
> -       if (chanctx_conf)
> +       if (chanctx_conf) {
>                 chandef =3D &chanctx_conf->def;
> -       else if (local->emulate_chanctx)
> -               chandef =3D &local->hw.conf.chandef;
> -       else
> -               goto fail_rcu;
> +       } else {
> +               struct ieee80211_chanctx *ctx;
> +
> +               ctx =3D list_first_or_null_rcu(&local->chanctx_list,
> +                                            struct ieee80211_chanctx, li=
st);
> +               if (!ctx ||
> +                   rcu_access_pointer(ctx->list.next) !=3D &local->chanc=
tx_list)
> +                       goto fail_rcu;
> +               chandef =3D &ctx->conf.def;
> +       }
>
>         /*
>          * If driver/HW supports IEEE80211_CHAN_CAN_MONITOR we still
> --
> 2.54.0

