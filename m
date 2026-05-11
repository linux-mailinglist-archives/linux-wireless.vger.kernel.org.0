Return-Path: <linux-wireless+bounces-36232-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EmhDbLqAWpHmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36232-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 16:41:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8DB510662
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A9D530A9428
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5B840148F;
	Mon, 11 May 2026 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5acmmuw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6D3FE67D
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510074; cv=pass; b=aDR8cvyYrhDAwIICoA6pCFFYZE7C6VcFHjwA+EydnIn+NSTirtv3H5PjGxR80+yK499ymeQG9FJhFwU2i7VT677S7LbcRdmnn1lcwXFDCFHoJC9WiUKBTK/c0YF2sjn2LbUC5KZZ4ny+zztbENDlB05qxcdMGf+suwGHBs/dZeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510074; c=relaxed/simple;
	bh=vD7AonEnJis4H4yYmplk1jKeBBiHyHkWqatkz2fEvwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKPeWZ2PdWOBvWrvn0srgXzoQO8oLz4ML0lupoGbtHSM28GaVrtYD++7h+XlH2Eoflbo1y5fKaZWPgGK6OhteyxEulWecMRuSuKAEwoHcO+00juFfeAMxsCqQ349dAT0fuPDw6NFd0Bq6fFxzGCfHOgL732LttWJvSFE32gl3EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5acmmuw; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7c0dea734b8so16329907b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510071; cv=none;
        d=google.com; s=arc-20240605;
        b=aNZimDHYX4gAomkBpRVCcXmNBCcDh6fLpWqPuaRx3uvIA3rk6gynfmQycqLwTHaSQu
         Io7bF2QkxkNkvXd+ZJxVi9Vi3vLss8Tj5wXlozsAZ8rJAhqjhYUEMJTq7XCdNN7966ZP
         +wdyKWEmMzgbQoBPqL6JZmaVrsmhiCKTiKlcxT1T1PG+RcjA9ssGz+e0l2qXJMzcL+xa
         JnfvlwFlLt9Utow4U7138xwrti/L8nBmFgfpaf+phT2IPWFKWifWCmnXJQbKtXB9YGMp
         chuj+DEnQHVoPszPwaSG/p62t8d96IVcPxvNvwMZg8zIwGAwG13JSFG6ZbStOJgQAZdz
         dmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+v2ay7d5zaezO4LQdeMSaE6xJKDm17at2Vx/sGq20mw=;
        fh=ZGHAo1lQq8en8xKg3F0T1Y63VoF9UWDXeRf7h/cuVZ8=;
        b=I6xz5yQsrc2Kr4ik4UKzb4c+OK3hLvTR8c+xwUgaRL3aPOa15ar1KimOYsNH7ryWAE
         43LGvcT+SKMIdvEZs3neavLBScsiJdGQPQhDLNGmZDEYIxzKrcHKlAf7fi3276DjxnST
         RPwf8Ybq3dtY+R6NMPQhlgainZCH3vXl8Qgc/MHdcPckUJ3Gr8sttjpZjBZ7xiq1Ewuq
         NTp4PjHpQuCHTBWFSQnp2t1572KjwrUkGSoMlW5koq/vpFm/RaWjelk0wJGw5KUqH2UM
         4VU1cAAFOMHjSKAgpHGkPSiC9GCnyEYLiGCpxLkr1js6ZJ8uil5g6SJeuSRnf+0zTODZ
         rDJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778510071; x=1779114871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v2ay7d5zaezO4LQdeMSaE6xJKDm17at2Vx/sGq20mw=;
        b=Q5acmmuw9wc8edoPdpXTRIwB3HzpMyeIudW0Ur6smFGRtCXex9lcXNCJEHQ9eBisC2
         OJJsjyxxJeZZLTIHkqIubFD4yul2mCa/jdspskTZwxE3mNC8jZF55CIljIjFjw+66PPX
         ufBLOrpjF2XrNpVGeRVJbp0B4y77uheUB5MKkxLRKdocVLcNMtXXLaygFrzdEM1fetxo
         MJlfxKGffvb52b+X4RGpE8lthQex+Ey0+MEkXvCYQ+jbh0iZd/LB2qZJeggAjsnxPfVe
         0ebDK35wE6quPfMgapxEILmsQTJC90ebkQoQTC/7wq8aY2dccrymOJXQe9egPFlTuuZv
         hUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510071; x=1779114871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+v2ay7d5zaezO4LQdeMSaE6xJKDm17at2Vx/sGq20mw=;
        b=Z+n+Nf123cgFEMlp09cg8DSZDCf2+60rAfX7MFQ2SnpXrMy62lto14zHXvWN82yr1u
         Os63NIXgDBd71L49sElDyann0CNq5e51pUmxneUIOIa9FeY6Yj/TOR1ChWNKm4irZ0QX
         CLPzCApE2CWDD1O43MJSHdWSkV6FXP3oJsekzxqYicVe+nCnFWf1mOqTnNlnofRSGD/w
         y2aSZjTif1KNXZrhFoaVBeqUWEvJLvgOtAKkKpYu9fr6YG2dx2ovk60hiFSm9xiJpCFt
         MpCPfvWrQJyRJfPUnk+sDNCSnvQBhFsLMcfgoE8DWX2T7EamCOiXcXJr2uBnxTXDHELJ
         kbSw==
X-Forwarded-Encrypted: i=1; AFNElJ+zyoeJGuqQqqpwQsJq+zS8+axD2VIXZOcKgExBKN1BRh8udn5jfkNpAzERrZptH4v2b/rcrelcD2Yr2uKyBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzULUIM07Cbcb3FfbSGi/zd6H2tmRUsmTPzkiz8seWBGPXZHjG8
	lcLqOdQL0t0I1FpixjQE5xF7h/jKvSc9lSbeLNFJ5PoIXGcxf0vaBpk626d0YSVq3L03kzLKuW4
	1qGlYUKYnVsvQByGAf0kZC40rmuepLOg2YbYwINjHXw==
X-Gm-Gg: Acq92OGELVbNswNM40BkfUwSdoRHlEWaJdyrbX0uMAy5i60hcFausmcV71D6VThsrwe
	e5C9KyW6tt4X7k71XxUmYDNXXN24UaV9G3IYxqzfj53rNUGi67Ow8qZKpsX6CfSho0tWGIv63pk
	xyJ1BVn3Mtz+LzuwXYQKRIas6lzjl3zPiD/bSYIIbVIMMEuhNaFwnmixIPZfSnF34MBaexbnU8G
	fzaawyt6EiTPHDouHBywa2XJ+zZPo03nMal7AsKJW3epAmsw+qQOaFCfDaVo25z4pCrRKjrLVFo
	LEXAIbSP51CWX84a490=
X-Received: by 2002:a05:690c:dd3:b0:7ba:d5fb:b543 with SMTP id
 00721157ae682-7bdf5dcc7b4mr242694677b3.13.1778510070862; Mon, 11 May 2026
 07:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com> <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 16:33:52 +0200
X-Gm-Features: AVHnY4Lsmc0xOoSZAdNPsitAF34xmre0WH2Fz_Ejkt7Ep8UMQ1cwv9JaIHq62oo
Message-ID: <CAPDyKFo6nvBCnOHXUSvedaT3Rnob+oF=nZoRoic_EkgFBTxzwg@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in sdio_driver_id
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9A8DB510662
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36232-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,gmail.com,collabora.com,lists.infradead.org,realtek.com,nbd.name,mediatek.com,chromium.org,dolcini.it,linux.intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,baylibre.com:email,linaro.org:email,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 17 Apr 2026 at 15:11, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> On all current Linux architectures sizeof(long) =3D=3D sizeof(void *) and
> this is used a lot through the kernel. For example it enables the usual
> practice to store pointers in sdio_driver_id's .driver_data member.
>
> This works fine, but involves casting and thus isn't type-safe.
> Additionally with the CHERI architecture extension there are machines
> with sizeof(void *) > sizeof(long) for with the traditional approach of
> storing a pointer in .driver_data doesn't work.
>
> By replacing the plain unsigned long .driver_data by an anonymous union,
> most of the casting can be dropped and it yields a working solution for
> CHERI.
>
> All users of struct sdio_driver_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Feel free to take this via whatever tree makes best sense!

Kind regards
Uffe

> ---
>  include/linux/mod_devicetable.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_deviceta=
ble.h
> index 5b1725fe9707..0eb5d196f5b5 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -414,7 +414,10 @@ struct sdio_device_id {
>         __u8    class;                  /* Standard interface or SDIO_ANY=
_ID */
>         __u16   vendor;                 /* Vendor or SDIO_ANY_ID */
>         __u16   device;                 /* Device ID or SDIO_ANY_ID */
> -       kernel_ulong_t driver_data;     /* Data private to the driver */
> +       union {                         /* Data private to the driver */
> +               kernel_ulong_t driver_data;
> +               const void *driver_data_ptr;
> +       };
>  };
>
>  /* SSB core, see drivers/ssb/ */
> --
> 2.47.3
>

