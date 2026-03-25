Return-Path: <linux-wireless+bounces-33837-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFE3NivCw2n6twQAu9opvQ
	(envelope-from <linux-wireless+bounces-33837-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 12:08:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C683238C1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDF3530E0D0F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264873C553B;
	Wed, 25 Mar 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW5uaG+B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB139BFE4
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436380; cv=pass; b=lKELW72uHPJTBs1OlA9Nx8tXdmYlWCKcMZ08YW++oSDF77v8b2WinH5q8UZ22k+brCXFs1rnJ83d/GC4UGztdbB7Lh+q2Fb3GKSU7Bf6tuhfs1zR2G0kWQ+36m4rWTLNPrUFkPJAZhjpCptooxEly53AtGfOY5glK7mk3Lp++Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436380; c=relaxed/simple;
	bh=6OarUN5/S8KW9TtgegaCy/h6lb+LwPoIPD0hOhnuUbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEm5klLmp//T1mH/jw5oET7mBbsa7MaStzWGCx9ZLtPtqSNdP7dyVNPu/UAffHpMxAu3eCjtmnsgVIFZCaA8foxofuUbUR+VWfVIW2G3/tT8M5QE1bcBjA9sopIHR6TrLeRWfcI43Ao/PU2DtHlbyRCUknwlUSutAbk42A3faMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW5uaG+B; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so1352855fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 03:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774436377; cv=none;
        d=google.com; s=arc-20240605;
        b=QzHSHEw+5dfWlYegYZeAMBH3kqtEjFREFIyPU/x8E5W9OhljxGattrHKVdrljszfuo
         c6v/kvtBJbIeX3co7HemeYhTaVcOeLikgKv8PNSQ4CGj6iFjeOsKNvDSXoa5pjH3vz49
         dZ5sacgXrR+ibbcVMjvep0ivnLZqT8HMzkszDQVsWo7wHje5V/TmCDeJx9QxPr6rG/B1
         EBOu4/9x3MoxJxExniUPeUwgTndlQd/ChMgIJqeJ+daDTx3h7eWdvMigpEQWb4JW+8O+
         QD+1/xN3KFaE6AAwtr4snsYv00NH8j1znmc1Sj5gjqMN99948U13BaNuVIoOdEe7RabO
         fnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CRbV2+ZkI9Qv4tonWef15Wk6xuibNUPgwYnA9gQ8ovY=;
        fh=l513puzKs7lQQ1Lx0Tgqn7Eu9FdhMtKBNIt1wxmslLE=;
        b=SeLycEH18aocAa47YvNCqgKkFRWzWyLqsDvwO41e14UF3ciM20ifzRr4fdXD6wfbZJ
         V3EXwBzjoUlpOHkENGbEDzrnASGYYcRAARPRZ8YX/NHDOM4/oHSteD9qg/18gRfGx2he
         3mVS6p/w+oBT++SI/SDYBbcpQsvTgHVWZu5CiYm4brEbb/ttEkN+l1BfQWHfHTqz0Q37
         9mdif+KnHcjdiBhT5/3wXfcESbdBcEcIvBEozfYKnqz5WPeiuZsAhF2cXaGNO9eaRDbc
         iA6WaKoLN6arZFos6HD4D6UZIspz95ZTbWaXiTj/Gvz1c6ff2XRc1d6timZz8qteYazZ
         KPgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774436377; x=1775041177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRbV2+ZkI9Qv4tonWef15Wk6xuibNUPgwYnA9gQ8ovY=;
        b=kW5uaG+BLT9rKi4RFt6pShm6cAbISE6BcLdvqvJhA2EOh226+HM+rJyirBqoN0fvUV
         fcZI+qOEWh1xNSt6iRJ4AjEUvbMHPJN1aNGrc+sv2HHlBkyzIZg3IaZlAcGzSc5l2iAo
         w/FqaH777cvCZVIiljtQm5ZbPxD3ByCNghBIEdqNBiibghsvp8zABTTMg07zVuxZVv+h
         G8orzlusxwr6uAaDgcH5UCT3asts1OBfHyhpfviRMH2Ss5yGNCMvrn+30mKI6N8cIvRU
         rtM7oHVF3ZcaMD/8RLuLFcSUsSle2rEPlGRu9wzo/UcBK2ettbKC73EX2umEE9DWCbkf
         n2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774436377; x=1775041177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRbV2+ZkI9Qv4tonWef15Wk6xuibNUPgwYnA9gQ8ovY=;
        b=DI9gK4nyMWMb/TX5tEnvq2j2aL8rFFixJeKivqX3MS7ZixFKy92TT1Kep9AiFG4pQA
         /BFXXnphlM3RH42bjVr1jVOMnaw+oXsfRBzR+Cu46t+i3+v9VXMuNV+UE2T6lrzFOvUc
         XrPwHgTIzKlrdgelYmFOV1LcXTr+d5OdWc4Crfv2WUKzFkuQ6MdifnPvWXRKPrKmkwye
         pbRmeyy0nPavS9hQvpV8wXyd+xNTvP+9Mwv5PyWu4kGMPhC2e1/Jz3s7DtJPivcP88P5
         fEKqTmdbKB7H7rhX4wEuybqtcB6F4r612sgLTfqUKFEoSfHuPZxDi8zjt86nTtrlbDMl
         hOnA==
X-Forwarded-Encrypted: i=1; AJvYcCWmV8QMdUTJ2xaWwb+DUPrfpL77iulXff8tElwYAOo0vqQ7F2iiSRcUdrIMcigKavntUEzXOsmHmA+WP+NX9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvPKyKT2AtRY7y5/z1FbsI1dRVE7Y5H2sa0FShelXiL4t+Hzvs
	UxMgD9kFPfspuydqxhntGoztenNjiu9Gbs2MyZuz0+B58AIUjpwbcFZMhxren1nauQVEtu8w12z
	OHOyKAu//viiqtjJkvFcZnLoqWKXhkGdmU0fZa0I=
X-Gm-Gg: ATEYQzzDukIp6ZKydKXhx3bIa3DxiD+ojaFPLJNLQoZXGmhQw6s5rUDztp0tqObsc9Z
	OV/SRojAJzrZ0/hIeCUWK5J4jZklh9LXttRYMyaOGSlTVH5VMkxCwwXmMnqDFZqwMXn/rLlfd2K
	Bh/pmWTRJ0nxOIWgsxoDzDQeQ2qEzWO2YMhswZD7LkuZQ1jxYaeYZ7l6LKsenrdhB9OC936EqeK
	5Dv/J/MRNbSr65GViOEGXH7Zy/IsinGHP331VtOMx06xwFX8e90ZIJR0Ee6G63hMNSnzKz8+Qs7
	g48lfw==
X-Received: by 2002:a05:6871:5f09:b0:41b:f7f5:e88c with SMTP id
 586e51a60fabf-41ca6fd777fmr1829748fac.23.1774436377431; Wed, 25 Mar 2026
 03:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrW0C9+Pz5TOUgM_oodhfJnoO7P0YiEdp85D08h=hLPF5A@mail.gmail.com>
 <20260325001513.1303-1-fjhhz1997@gmail.com>
In-Reply-To: <20260325001513.1303-1-fjhhz1997@gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Wed, 25 Mar 2026 11:59:27 +0100
X-Gm-Features: AQROBzA2ShJuxo-ZuIgKycJxBGuFiWvCSCV0YHbexP8wyZK7UX0A9LeKEvpe0G4
Message-ID: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: fix monitor mode frame capture for real
 chanctx drivers
To: =?UTF-8?B?5YKF57un5pmX?= <fjhhz1997@gmail.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.57 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33837-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 73C683238C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello everybody. I've tested this patch and I'm sorry to say this...
but, bad news. Same behaviour. I mean, as soon as the DoS window
appears during the evil twin attack, the VM is completely frozen.

I put the full report including screenshots on the github thread:
https://github.com/morrownr/USB-WiFi/issues/682

If you are interested in reproducing what I do, it is pretty simple.
You just need linux, one wireless adapter using an affected by the bug
Mediatek chipset (in my case chipset is MT7921U, also tested on
MT7921AUN), a wireless network and a client connected (your mobile
phone is enough). Use the airgeddon tool and launch the most simple
evil twin attack over it:

git clone https://github.com/v1s1t0r1sh3r3/airgeddon
cd airgeddon
bash airgeddon.sh
Navigate through menus selecting the Mediatek adapter, then evil twin
menu (option 7) and then scan for your target network (option 4).
After selecting it, Just launch the "Evil Twin attack just AP" (option
5) and wait until all the 4 windows of the attack appear, then check
if your client (mobile phone) is disconnected from the network. That's
it.

In my case, just 3 windows opened... the first one is the Fake AP, the
second is a DHCP server, the third one is the DoS window, and as I
said, as soon as it appears, everything hangs... so no time for the
4th window to be opened (the control window).

Kind regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El mi=C3=A9, 25 mar 2026 a las 1:15, =E5=82=85=E7=BB=A7=E6=99=97 (<fjhhz199=
7@gmail.com>) escribi=C3=B3:
>
> Hi Oscar,
>
> Thank you for testing the v1 patch and reporting the VM hang -- your
> report was critical in identifying the root cause.
>
> Lucid-Duck did extensive debugging and reproduction work on this.
> The full discussion is here:
> https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-4120751621
>
> Root cause of the crash:
>
> The v1 patch falls back to list_first_entry_or_null(&local->chanctx_list)
> when the monitor vif has no chanctx. In your Evil Twin + DoS scenario,
> the AP and monitor interfaces created multiple channel contexts. The
> fallback blindly grabbed whichever chanctx was first on the list --
> which could be the AP's chanctx that the firmware wasn't expecting
> monitor traffic on. Injecting frames on a chanctx where
> mt7921_mcu_config_sniffer() was never called is the likely trigger
> for the hard hang.
>
> The v2 patch adds a list_is_singular() guard: injection only proceeds
> when there is exactly one chanctx (unambiguous), and is refused when
> multiple chanctxs exist. This covers the common single-channel AP +
> monitor case while preventing the dangerous multi-chanctx path that
> caused your crash.
>
> Lucid-Duck tested v2 extensively on kernel 6.19.8 with the MT7921AU
> (ALFA AWUS036AXML) -- single-channel AP + monitor + injection,
> multi-chanctx via P2P-GO, heavy load injection floods (50k fps,
> 1.8M packets) -- all stable with zero crashes or kernel warnings.
>
> The v2 diff against net/mac80211/tx.c:
>
>         chanctx_conf =3D rcu_dereference(sdata->vif.bss_conf.chanctx_conf=
);
> -       if (chanctx_conf)
> +       if (chanctx_conf) {
>                 chandef =3D &chanctx_conf->def;
> -       else if (local->emulate_chanctx)
> +       } else if (local->emulate_chanctx) {
>                 chandef =3D &local->hw.conf.chandef;
> -       else
> -               goto fail_rcu;
> +       } else {
> +               struct ieee80211_chanctx *ctx;
> +
> +               ctx =3D list_first_entry_or_null(&local->chanctx_list,
> +                                              struct ieee80211_chanctx,
> +                                              list);
> +               if (ctx && list_is_singular(&local->chanctx_list))
> +                       chandef =3D &ctx->conf.def;
> +               else
> +                       goto fail_rcu;
> +       }
>
> If you have time, could you re-test with this v2 patch in your
> original Evil Twin + DoS setup? That would help confirm the fix
> before I send v2 to the list.
>
> Thanks again for your help!
>
> Best regards,
> =E5=82=85=E7=BB=A7=E6=99=97

