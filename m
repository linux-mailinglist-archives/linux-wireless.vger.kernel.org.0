Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125F6740EF3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 12:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjF1Khk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjF1Kfi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 06:35:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36980187
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jun 2023 03:35:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso3313467a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jun 2023 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687948529; x=1690540529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFF36qN3ZuOZkQLAZyv7DUyKVdgOhZNMPXsAgM28wlU=;
        b=pnUi6Ctj+0LbU43JP5axsRQDqfy/fLsNMnjeHbORgb2tA7WeRC2rlwv1rz9JSkovaY
         +n0AS5yRpaRxvaKlQanpMbiZvZAfvbocCaOwOMaYv+5Gb3MHlgKyjL28HO8yRF9lgzqM
         1gxcPvFdr/6kcSCUf6j08DuTotgn4xLvjuanQeiqgDICBC2hyRNrNtEJgFRidNhbbwYs
         rXWztxlksD97GC+BAIUQrgML67bzR3mqrnSBKE8ASBe9Cm7wzZIq4ZDaHwvOg0a4ENrS
         eagsnsQkD24Ler1SI34tnXc+JFmZB2AHgd29LvXfN3KC40MJHLxgU9rfIP+3CMnIAhRU
         PfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687948529; x=1690540529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFF36qN3ZuOZkQLAZyv7DUyKVdgOhZNMPXsAgM28wlU=;
        b=M2/iiZ3zr7N1yUAVpCAIIiWP+ZYxARtZgBznQ89qSLaPQcIFcQoJXVl2xqgibSjh8P
         uKWLjGaFPljXWAMsoHlIxWOyZ1uYhuykZFm25j5bGieMrZtg7ap3ZXueIapFPhqI0z3h
         xaU7tqvLRxaGEf2iFnlJ95flbg93eNjFex90nC5kLutvtVXFHW5+K4jB0SKuvFG+YG9J
         0pEUZCtUXWBL0YVt7ozZrJr6Z87rtIGwY7LmVwBg9MfZXvyUgJxVvIHUAa/h2ba02WP9
         ZmVkvyQUgmUMU7cyL0X8BaxYDbb4jQ2NhGebIqK6I4PH3qHFaPIddhpQ/Uf5mz02Sx/t
         hYqg==
X-Gm-Message-State: AC+VfDwiOetNZUAkUtlz2iI3JJer9E3JwO0SYyJ+79E1tt7pX3Vpq2cD
        Q5Ge0Mpcz4lXm5fny5JmxIRvTawKBCUyTqA9FQ==
X-Google-Smtp-Source: ACHHUZ4SbrAYORmf0AhgW0YvYQFhQ/ebQ2x0IdQMJcvKy4t+/loUvN5+/3UmGpPHyiLhuTVY9nIq5ul1xGAqiUAOAgc=
X-Received: by 2002:a17:907:6e26:b0:98f:c9b:24ed with SMTP id
 sd38-20020a1709076e2600b0098f0c9b24edmr9063607ejc.67.1687948529413; Wed, 28
 Jun 2023 03:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+zRt5HKvOQihOwoSj_G1eKFQ5ap9L4uRK2hvtV_SxOqwn-2Dw@mail.gmail.com>
 <e02fe1f4-d837-4124-b53e-cf8b28105a17@lockie.ca> <CA+zRt5GTSbKBjARaD19V7oQEkXUJJz_pvYO1fOXA9hPrzPS1sg@mail.gmail.com>
 <c4b24c16-788b-4f15-ae68-8df44e60a27d@lockie.ca> <b3c5f2f05d0844dfb4e9f7e943b4cbbd@realtek.com>
In-Reply-To: <b3c5f2f05d0844dfb4e9f7e943b4cbbd@realtek.com>
From:   Giulio Paci <giuliopaci@gmail.com>
Date:   Wed, 28 Jun 2023 12:35:17 +0200
Message-ID: <CA+zRt5HyZaOvDpVUxF9Rfv4rrx4Us1Krs+TeiP-U9QsrA_SX6A@mail.gmail.com>
Subject: Re: Realtek 8822ce connection is very unstable
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     James <bjlockie@lockie.ca>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il mer 28 giu 2023, 03:29 Ping-Ke Shih <pkshih@realtek.com> ha scritto:
> Try below options to see if they can help:
>
> 1. try another band (switch from 2GHz to 5GHz or opposite)

I tried to force 5GHz. And then to force 2GHz. When connected to 5GHz
it seems a little bit more stable, but still hangs within seconds.

> 2. try another AP

I have tried 2 different AP, but the situation is very similar with
both. One of them supports only b/g/n, so I was able to change band
only with the other one (which is a hotspot on Android phone).

> 3. disable WiFi power save by
>    rtw88_core.ko disable_lps_deep=1
>    or
>    iw wlan0 set power_save off

I tried setting disable_lps_deep=1, but still the connection seems unstable.

> By the way, when you try disable_aspm=1 and disable_msi=1, I suggest to
> create a file and add them to /etc/modprobe.d/, and then shutdown and turn on
> your computer after a while. Because some PCI settings are persistent if only
> do rmmod/insmod.

I confirm this is the approach I used in all my attempts, including
disable_lps_deep=1.
I also checked /sys/module/$module/parameters/$option content, to
confirm that the options were correctly set.

I have also carried out some additional attempts:

- boot with iommu.passthrough=1 instead of pcie_aspm=off, but it does
not seem to improve anything (and AER errors came back in the dmesg);
- After my comments on https://github.com/lwfinger/rtw88/issues/150,
https://github.com/lwfinger/rtw88/ was updated and I was able to load
these modules. The connection is still very unstable, but with these
modules, when the connection hangs, dmesg reports:

rtw_8822ce 0000:03:00.0: firmware failed to leave lps state

sometimes followed by:

rtw_8822ce 0000:03:00.0: failed to send h2c command

I have tried to set some of the options above using modules from
https://github.com/lwfinger/rtw88/, but so far, apart from these
additional messages, the results are almost identical to the
precompiled modules that come with Debian.


One of my colleagues has the same hardware (same AP model and same
laptop model) and also tried to install Debian bookworm on it. I asked
to check if he experiences the same issue, but in his case he was able
to stay connected for a few hours without any issue.
I wonder if the issue I am experiencing could be due to defective
hardware (initially I excluded it since the same configuration is very
stable under Windows). Is there any specific test that I can try to
exclude hardware issues?

Bests,
Giulio
