Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67B65A50B
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Dec 2022 15:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiLaOdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Dec 2022 09:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaOdu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Dec 2022 09:33:50 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5842C6319
        for <linux-wireless@vger.kernel.org>; Sat, 31 Dec 2022 06:33:49 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s22so24754633ljp.5
        for <linux-wireless@vger.kernel.org>; Sat, 31 Dec 2022 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x8PA7JqyJvYT3pyzInTP/rAu2qw/ZQ5FitjJHrmpwio=;
        b=OBxN9I+tUtzcJt+aPBELswKvbJVQPtqCvmbYeprUDNIxm2u9PFDQOMzODZJxbFe4pt
         CVodofu8aGCFE4+ebxzHdTDcL3BKtf+n+x5H2e3pPlFyXqZR1V+zGipfXZBHgA02y4HZ
         zxP8RoHVEFhb2A8OGt2aCpp1ooT7IlbgPBDGFMultFvHQ5oebF4A9BOvBHAx7IxH0fyF
         ZYBLj4vLFiuTaHuDEvus5dovxqrZB9yy4iG/jJCPhL4fzMPzEJDGcRlKCu99AgE7Go86
         OxguV/mZrvTSBDVzq+/aGTeCnAfUAvJc4Sigzf45xKd6YJIpLqjoo7eosE+eKz6AH8jZ
         Jnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8PA7JqyJvYT3pyzInTP/rAu2qw/ZQ5FitjJHrmpwio=;
        b=PVtPSKZKG+sq59pdwNTZW2TwcfLeExMOa7Y15jlr7FRHAIBznIp4ADiZzLWE8vVX6y
         ADwm1Vbq874+ir5Hlni7zuGuH+J2FaKoYaXW2/JZ4gCMnKp8mrBXjB3GpfDIuBP/vb1u
         Pa2WCAsRQkZqAe8IQk5NRw8vSk+td9275AIPTw7TM5jKyiDEtqGG49vaLOeoijTtRm8P
         nC28YB6eQ2mFuXKcYGD1DvxbCIzn3V77pmkE6RFYtPPXiw8XZhCFqIDFPEaf/Myy3v2g
         I1kHXxAmw3WjJEFxHlpeuQg1Gcs1wk0TqmOaBzJn2OGQx8Z1qnSkJxBs6VSWuJrUo0iV
         J7iQ==
X-Gm-Message-State: AFqh2kph2hRtUzDsiQ2lMv0pW50xhzH9DveONJN4MXAjtwdQP8yeuKJY
        SwSUzsqzZUR9HXnMbD2z8gRBZC5lHGwWPZ2kKcQ=
X-Google-Smtp-Source: AMrXdXu65mziylIpDfXKz7w02P1kxBPLdYMvXoDrYO/Hjz8trxzad5XgunY01fNdq4MPR+io8z62weBOQEqRPuA8uXk=
X-Received: by 2002:a2e:7a0d:0:b0:27f:d911:acf9 with SMTP id
 v13-20020a2e7a0d000000b0027fd911acf9mr365016ljc.23.1672497227627; Sat, 31 Dec
 2022 06:33:47 -0800 (PST)
MIME-Version: 1.0
References: <CALeDE9O1+qgn_9z=zTVKbWx3FphEa4y8Dn9f5ORoQgW_gL1dqg@mail.gmail.com>
 <d88f4aff-45ad-db10-ada3-f7f5b34a6620@i2se.com>
In-Reply-To: <d88f4aff-45ad-db10-ada3-f7f5b34a6620@i2se.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sat, 31 Dec 2022 14:33:35 +0000
Message-ID: <CALeDE9O_qX_Gu1vwCLW_PbMdgnSoHTA5LhxYQrsUqwGHRwv-Eg@mail.gmail.com>
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        regressions@lists.linux.dev, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stefan,

> could you please provide a "bad case" file list of all firmware files
> for the Raspberry Pi 3 B+ which worked before Linux 6.1, so i can
> reproduce it?

What do you mean by the file list? We're running the latest upstream
firmware, we do used compressed firmware but that hasn't regressed
with any of the other firmware, this is very much brcmfmac. With the
same firmware it was working on 6.0.x and reboot into a 6.1+ kernel
and it stops with nothing else changed.

> Also OpenSuSE seems to be affected [1].
>
> [1] - https://bugzilla.suse.com/show_bug.cgi?id=1206697
>
> Regards
> Stefan
>
