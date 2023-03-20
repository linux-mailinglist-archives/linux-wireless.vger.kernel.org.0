Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDCF6C10D3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 12:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCTL3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCTL3b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 07:29:31 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A449FB
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 04:29:29 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f17-20020a9d7b51000000b00697349ab7e7so6524207oto.9
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 04:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1679311769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIOaYo/BoAvvf3IBOhm5utFpJRVaCdlr5z1ikSk990Y=;
        b=eP9VMpuL+RKnHLRak4H/3R5FZpdufTw+xFVfLQruIk+8kzqQvyRiJXB1zfwomeueOV
         IUmdm6O9ijka0+HtYH2FFAqhWurHh9jRX7YtDOSVmTPvkiPmyiAjhKD3vEc8QJX/ftM6
         Nb0rnTY0My3a3ofp8FIq+hFGtaZu9uePjvpgblq5rd21Ezd6/oiEHcMsxxhxZEiB6u7B
         wBPOQC+uQ/5qrjcG3mRvt4SUd4qfoflb79g1dMqgSWIKhsusdlIwaNB8DflAqaK8WQ9y
         JBJh3u2KkCagPK6gp6bZKF/drGtOCqXP5VYLbnPYMkkvQM9JwajbRxP44gfpGoHdquIy
         PWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIOaYo/BoAvvf3IBOhm5utFpJRVaCdlr5z1ikSk990Y=;
        b=aXnQUesZ9/PQR3N+rWqrB5jZ595sOQItyV20yoVkWUIdumquZJMAYG9vJh2TOWsFaS
         hicZl9nzhNfp/ZpFQ96MVkyyOVgLTzwo9MNlkik+teZdr467tp79YgBASbv32FjhHc36
         UdAPJBMWmXe9vMUnL0I+NjHk34NlrCKYS/1jG4eemZxlVn6WVv5ow5nDj1+SRWU7Gmtn
         3CO9BmTlLrFCI+jkNKmyTlzsLNVRg4Q2X7u3f1uvAT/Gv8702eA1hd757effVM5bC3ZT
         3Mmc+7DQ+FgpzEwZwtxlQW0BhdX6ImZs/YZ7zpw+ZWHJdFItdfzkL5rY03evlCIOn5EE
         IhSA==
X-Gm-Message-State: AO0yUKUgNMHdpyHMZwN6+kKSAiSNUd+jbmKgBjtArmhEU/vTOi6lNmkL
        AEI/O35qgOtnNaU4WUS8NHRD/oxGT2OHmkwitysFSQ==
X-Google-Smtp-Source: AK7set+epEP3sgQtbfzun6NTPr1IVv2gwUa9AtL4egLS195bxNyBbm/pCGqh+yqgh8OXdpgmODmKfv7TY94R/sfnlYk=
X-Received: by 2002:a9d:4b0b:0:b0:699:199a:1223 with SMTP id
 q11-20020a9d4b0b000000b00699199a1223mr2754770otf.5.1679311769199; Mon, 20 Mar
 2023 04:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU0TuNA26F+hFwTRGc2pVvW34-7Sc7oQ9EW8V+2cVFgcag@mail.gmail.com>
In-Reply-To: <CAJ+vNU0TuNA26F+hFwTRGc2pVvW34-7Sc7oQ9EW8V+2cVFgcag@mail.gmail.com>
From:   Daniel Drake <drake@endlessos.org>
Date:   Mon, 20 Mar 2023 19:29:18 +0800
Message-ID: <CAD8Lp44c1k-xP1U9X8PR_kw=8joMY8RUwcKVBvuWaV7faNhWZg@mail.gmail.com>
Subject: Re: ath9k legacy vs MSI interrupt issue on imx8mm soc
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        rhu@qti.qualcomm.com, ryanhsu@qti.qualcomm.com,
        rwchang@qti.qualcomm.com, aeolus@qti.qualcomm.com,
        "Valo, Kalle" <kvalo@qca.qualcomm.com>,
        ath9k-devel <ath9k-devel@qca.qualcomm.com>, linux@endlessm.com,
        rafael.j.wysocki@intel.com, andy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 18, 2023 at 8:17=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> =
wrote:
> It seems that Daniel may have been running into something similar back
> when commit 7368160f0ab0 ("ath9k: add MSI support") was merged
> [1][2][3]
>
> Does anyone have any advice here about what can be going on?

The issue we found earlier was that ath9k MSI is broken unless the MSI
IRQ number coincidentally is aligned to 4.

Worked around with:
https://github.com/endlessm/linux/commit/0a2d86a2b9da8f936d873addf0a97e3411=
77fe8a
https://github.com/endlessm/linux/commit/970d2b4b59465cd926e5213e0feb633f6b=
623447

IIRC the PCI patch wasn't accepted upstream at the time and I never
got any response from Atheros/Qualcomm about this device
hardware/firmware bug.

Daniel
