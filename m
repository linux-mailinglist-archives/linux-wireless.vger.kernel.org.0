Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5709E7E924A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 20:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjKLTjb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 14:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKLTjb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 14:39:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351B187
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 11:39:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e5dd91b0acso396179666b.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 11:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699817966; x=1700422766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPXgTuktbqtWeqdyLJjudSuaLvdprd72HkDeuPEKQYg=;
        b=cRP/MFN5wIeMM1UKwlC/W72XXgOVFzeuVq3B6UH2h/BvMA2jq2csDsZSKzZLjUDk5f
         tQLtuRhTQEFWdtY/PZhi3O/OtJ6P61ViZGexsMwKflP2C7Ew0pgn9WYPehOyxM+C+gI+
         fCML1L5Le0cx57InVpXDaFerglCDt/ai4WY6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699817966; x=1700422766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPXgTuktbqtWeqdyLJjudSuaLvdprd72HkDeuPEKQYg=;
        b=tk2kMveHypFEIilumoPNwqXAmPVToI74nP6WQaDWVyrNs/0qcJwSWNDWqESY+W1rc6
         nuVrrMWgTI6yZOI/BuF3vIG2I89PxDh2Y3IiUnWIa74MvvqzgkFeDcWJD/O36JS8paF+
         /E2jMIZGe4PA9ss7vWNZWv1ZiJ2vxL+MEMaWMnJpeSuywycozQDlafnNnrqCWHgh5L36
         lD8gzmLzgzz5MiRvTLoIMbEVG6tX+VNr3idqxZvsJf3Zdb44tAEVZwewPuupX6b79xXw
         FOvYq8fjgYuX/ROSiV0JQbP7Rl4EJ2wvN55qPbQUbMmcMqdvxMaukdpbeKn/GbcgP+pa
         E3zg==
X-Gm-Message-State: AOJu0Ywau6QRG+/X7T0/roQp9kBexfAYouSCLKiMEiO39C1vm7ImS9aR
        FbGCRW6FX2PwfoHeLPhaDzxPGMMGPnJasAOwAjyPPlAj
X-Google-Smtp-Source: AGHT+IEp7MXkmtJthe8MWAhoX040vg8tsMOhMXEHbTBlg6fxKqQvDT+7zTJk9LiXQrIlLTHo51uLAg==
X-Received: by 2002:a17:906:441:b0:9e3:5495:a33 with SMTP id e1-20020a170906044100b009e354950a33mr3879207eja.63.1699817966351;
        Sun, 12 Nov 2023 11:39:26 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709064e9500b009df5d874ca7sm2923139eju.23.2023.11.12.11.39.24
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 11:39:25 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so5748095a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 11:39:24 -0800 (PST)
X-Received: by 2002:aa7:cac4:0:b0:543:7c94:a879 with SMTP id
 l4-20020aa7cac4000000b005437c94a879mr3361889edt.29.1699817964440; Sun, 12 Nov
 2023 11:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20231112095943.19353-1-emmanuel.grumbach@intel.com>
 <20231112143620.36619-1-emmanuel.grumbach@intel.com> <875y26ajks.fsf@kernel.org>
In-Reply-To: <875y26ajks.fsf@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Nov 2023 11:39:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgyG-8ehCc4C4V-b-8rBtfyd9ApDeQSx-5BKRaHywhVpw@mail.gmail.com>
Message-ID: <CAHk-=wgyG-8ehCc4C4V-b-8rBtfyd9ApDeQSx-5BKRaHywhVpw@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: iwlwifi: fix system commands group ordering
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        pagadala.yesu.anjaneyulu@intel.com,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= 
        <pinkflames.linux@gmail.com>,
        Damian Tometzki <damian@riscv-rocks.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 12 Nov 2023 at 10:54, Kalle Valo <kvalo@kernel.org> wrote:
>
> Linus, I suspect it will take a while before we make a new wireless pull
> request (there's currently just one commit in the wireless tree). So if
> you want to take this directly to your tree please go ahead, otherwise
> you get it via the normal route in a week or two. Just let us know what
> you prefer.
>
> Acked-by: Kalle Valo <kvalo@kernel.org>

Ok, I just tested it in my private tree, and it fixes the WARN_ON() as
expected, so I'll apply it for real.

However, now that I don't have that big warning in there, I do note
another iwlwifi issue that is new to this meger window:

  debugfs: Directory 'iwlmvm' with parent 'netdev:wlo2' already present!
  iwlwifi 0000:45:00.0: Failed to create debugfs directory under netdev:wlo2
  debugfs: Directory 'iwlmvm' with parent 'netdev:wlo2' already present!
  iwlwifi 0000:45:00.0: Failed to create debugfs directory under netdev:wlo2

and looking at my system logs, this is new.

It looks like it is probably due to

  c36235acb34f ("wifi: iwlwifi: mvm: rework debugfs handling")
  e9dd25550770 ("wifi: iwlwifi: mvm: add a per-link debugfs")

but that's just from looking at the patches (ie no bisection or any
real effort).

This is after the system has come up, so I assume it's when
networkmanager or whatever actually is setting that wireless thing up.

Again: I actually don't *use* the WiFi on this machine - but from a
quick check it does seem to work. So this is just an annoyance and a
sign that somebody didn't do all the details right (possibly triggered
by odd user land behavior, of course, but still...)

                Linus
