Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA297BE5A8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 17:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377072AbjJIP5Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376789AbjJIP5P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 11:57:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BA791
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 08:57:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b9a494cc59so796043766b.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Oct 2023 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696867032; x=1697471832; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sS/e/hw4jCtdsY89aS5EtxAVP80gniVJgMVrvS9y9WI=;
        b=L621JKcoKihswE+y+j9sPiJ3wgKVCLoAS9bWWYu9a4NFeTwgXs1iGBC81DoC9vFv+5
         t0zgo94ONd5Y4J2rYu3nDWfFwHCBQ+B0Boi1Meg+F94PpXE+AbK1epqtp7/TINKPzUku
         n/edbXypwpvFw+IccLHDy1R/9jTez2/IPhsHruXRWJovsnW1bB6aaASrJynAsdMj922D
         AwquvZBtP/JnLqYPNJN5nf1WFgjZUdGYEGWaNX7JdVr5jgrQY3rJpHDvfO89yosWBD8o
         +zoctktY8ErZia9sTMNgjLGiG8cLmROHtM5HRhlWUZgx1DP8PYEbMEW/a48OYrEBxOS9
         Yfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867032; x=1697471832;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sS/e/hw4jCtdsY89aS5EtxAVP80gniVJgMVrvS9y9WI=;
        b=JOvlvfkWI5MR4MunTwRHnsmWSl/VAADzXlOI8GSkevgPv7uw5kUt5IwlxL7Pu455Wm
         ghfcBEHYU06EOlshpXFZzdf353YOb1ERhwrPTVfj13SRMAdOR6jqwDQU1D+jgYhBW6D3
         qNeFoKbn+QOHwEzv3n4oXAk+gB8IJ19JC3EsvKcJ7b68D2IhhAYt19i9AqKElGo+vZ0N
         X0le6jTYs6FoGOpSSo+gd8JzSq9wGT7upTT15HCqxsFqARyOsH9t90itfPz+oIRrUFeM
         iX7OAEibbuC/rXCFX7nMvlgYQTSZi8ze0ovyMVbtmg7oPEej39/wVInYCeIiLsed5yWt
         iWgw==
X-Gm-Message-State: AOJu0Yx5RjjTujAeTutN6Wm6ytG+kIMJjQ5GzwgaDjMqSek/FKmA9u3D
        aZTJBvNLGJZlCOY+MCH1aHORNJmdbsgnYsOCNmfbqIQ51KE=
X-Google-Smtp-Source: AGHT+IGeju/rCVsf1zPShUdAvVQvCYTgUK2IWXR8OUBDZv2+p0H24WbNI0SgAC3pmvBZPXpB0CxSZtjKVlqGA0aYaZE=
X-Received: by 2002:a17:906:ce:b0:9b2:a078:4461 with SMTP id
 14-20020a17090600ce00b009b2a0784461mr13390655eji.44.1696867031802; Mon, 09
 Oct 2023 08:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMvbhGsA4A9qHrYdXcNXLzv7a7xZZq98f90Q-Btb-9vs9ayCw@mail.gmail.com>
In-Reply-To: <CAAMvbhGsA4A9qHrYdXcNXLzv7a7xZZq98f90Q-Btb-9vs9ayCw@mail.gmail.com>
From:   James Dutton <james.dutton@gmail.com>
Date:   Mon, 9 Oct 2023 16:56:35 +0100
Message-ID: <CAAMvbhHo8wo924YVZqFrLKQko59iSiLMhVAzb=tdSvf_-v1CCQ@mail.gmail.com>
Subject: Re: mac80211 bugs
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 1 Oct 2023 at 11:27, James Dutton <james.dutton@gmail.com> wrote:
>
> Hi,
>
> I recently saw a report of a kernel bug that was caused by a null
> pointer reference in:
> mac80211.c: sta_set_sinfo()
>

The kernel Oops has this:
Code: d3441c63 12000c00 8b030ca3 f9409c63 (f9400465)
Extract of the code:

/usr/src/linux/net/mac80211/st
a_info.c:2451
    d118:       17fffee6        b       ccb0 <sta_set_sinfo+0x6b0>
/usr/src/linux/net/mac80211/sta_info.c:2422
    d11c:       f9402107        ldr     x7, [x8, #64]
    d120:       d3441c42        ubfx    x2, x2, #4, #4
    d124:       12000c00        and     w0, w0, #0xf
    d128:       8b020ce2        add     x2, x7, x2, lsl #3
/usr/src/linux/net/mac80211/sta_info.c:2424
    d12c:       f9409c42        ldr     x2, [x2, #312]
    d130:       f9400447        ldr     x7, [x2, #8]    <-----It_crashes_here
    d134:       b40004c7        cbz     x7, d1cc <sta_set_sinfo+0xbcc>
/usr/src/linux/net/mac80211/sta_info.c:2427
    d138:       52800188        mov     w8, #0xc                        // #12
    d13c:       52800082        mov     w2, #0x4                        // #4
    d140:       9ba81c00        umaddl  x0, w0, w8, x7
    d144:       79400800        ldrh    w0, [x0, #4]
/usr/src/linux/net/mac80211/sta_info.c:2428
    d148:       f10004df        cmp     x6, #0x1
    d14c:       54000080        b.eq    d15c <sta_set_sinfo+0xb5c>  // b.none


/usr/src/linux/net/mac80211/sta_info.c:2424
       case STA_STATS_RATE_TYPE_LEGACY: {
                struct ieee80211_supported_band *sband;
                u16 brate;
                unsigned int shift;
                int band = STA_STATS_GET(LEGACY_BAND, rate);
                int rate_idx = STA_STATS_GET(LEGACY_IDX, rate);

                sband = local->hw.wiphy->bands[band];

                if (WARN_ON_ONCE(!sband->bitrates))      <------It_crashes_here
                        break;

                brate = sband->bitrates[rate_idx].bitrate;
                if (rinfo->bw == RATE_INFO_BW_5)
                        shift = 2;
                else if (rinfo->bw == RATE_INFO_BW_10)
                        shift = 1;
                else
                        shift = 0;
                rinfo->legacy = DIV_ROUND_UP(brate, 1 << shift);
                break;
                }

Looking at this, it can be one of two things:
1) local->hw.wiphy->bands[band];    is NULL
2) bands is an array of 6 items, making band valid for values 0-5.
If band >= 6, it would cause problems.
So maybe something along these lines might help:

Signed-off-by: James Courtier-Dutton <james.dutton@gmail.com>
--- sta_info.c.org      2023-10-08 19:52:13.578270007 +0100
+++ sta_info.c.new2     2023-10-08 19:52:09.450214070 +0100
@@ -2420,7 +2420,26 @@
                int band = STA_STATS_GET(LEGACY_BAND, rate);
                int rate_idx = STA_STATS_GET(LEGACY_IDX, rate);

+               if (band >= NUM_NL80211_BANDS) {
+                       printk("ERROR: band=%d is too large.
Returning\n", band);
+                       break;
+               }
+
                sband = local->hw.wiphy->bands[band];
+               if (!sband) {
+                       printk("ERROR: sband NULL. Returning\n");
+                       break;
+               }

                if (WARN_ON_ONCE(!sband->bitrates))
                        break;
