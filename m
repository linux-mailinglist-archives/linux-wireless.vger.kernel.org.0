Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BDF6F6CEF
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEDNaR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjEDNaQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:30:16 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02E54C24
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:30:15 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4346efda846so295586137.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 May 2023 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683207015; x=1685799015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOxE372B6YQMi4PxOq7FaeZ+RepVPmY7i1cKRhI3wmM=;
        b=R4G3RNhmBwKCQQL/lB/4YqQBPvB4UbEXbcm6O5hmtpqsHeplQ538hi/b8WAa01oyUo
         Ba8As10yPkI3L1uKeiGfX0Fo/RmJ87AejqIcCt5gvW5BJd7o7QB3pX6rSlO7JLM0TM3M
         xtG/yVy64CxzOK+dCb51NoY6qlOdMNMVvS/v9hwGrV7pQLmyPA3EFDOiiHssEMslLpIG
         y5Yat5DB06iz9rN//YJsXmOS6V7X4U72VeYs7UnjhdpJsYu3L9ZcdTI0Yl8nuJEWDS1m
         ay85ToDQStenKDTHfxK3Bjzyed+Z9Sn9zPMCQfIySN0h2yeUd23aLrX42XahwBtxUwej
         J/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683207015; x=1685799015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOxE372B6YQMi4PxOq7FaeZ+RepVPmY7i1cKRhI3wmM=;
        b=WXBCjz71Uh5MWDJLKQW7KA4aqp8CP9Eb21uiCiR0zbHlgRdf/uKbs5NfKUPYIO1+6g
         n/UzHzyvy4tes1cPS0NuDEVaclvLoXSGTRtbc8kjdWCZvY5Sa/WC9U6dxOFwAHqFaOz4
         7QxHiXvh6qIntbKDuRLboU1m0R/l4+f5u2NutVsqMaCyvnV2FqbiG3kMulGoO0roO0f2
         vz+12tj6dpDgQPWwYkQ7sTE2Pde/ui046RnjPqcjtJGqP/9umAec9hWw9aeQ7grNAwZK
         kqPFDWBFJd57xGMmRkA8vuf3Eu4BEQg5wyjL2946JHabVjEXB3a5PzFLv5pCKDknWCHP
         +vNA==
X-Gm-Message-State: AC+VfDwLKpA385eKZK8Kmk5NJjUajaTfxcWB+WkKy8q6nG4jRKX25Oaj
        NBrwNK6yMWZSCo0g8oeF61z+7K/JBK5EyxR143NcPsgr
X-Google-Smtp-Source: ACHHUZ44JUsBPmJMRCCi13RJP7uJHgXXIKHJKhcE5rfCq/GNRx0EkTLyLgCMtkhPm2dnjOlTr30YfBN965u/fIYywyw=
X-Received: by 2002:a67:e24e:0:b0:42e:58ed:7970 with SMTP id
 w14-20020a67e24e000000b0042e58ed7970mr3004701vse.19.1683207014942; Thu, 04
 May 2023 06:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230430201830.2f8f88fe49f6.I2f0076ef1d1cbe5d10010549c875b7038ec4c365@changeid>
 <CAAJw_ZuFaE-oYWQWQ+k0Lz_GcJH+adF6SZuwaKpV8UB0XGqVzw@mail.gmail.com>
In-Reply-To: <CAAJw_ZuFaE-oYWQWQ+k0Lz_GcJH+adF6SZuwaKpV8UB0XGqVzw@mail.gmail.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Thu, 4 May 2023 21:30:04 +0800
Message-ID: <CAAJw_ZsK5c5Y7NpFeNG6i2-kozeT9jscog57+bwwEy6RtiFm8Q@mail.gmail.com>
Subject: Re: [PATCH] wifi: iwlwifi: mvm: rfi: disable RFI feature
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 1, 2023 at 7:56=E2=80=AFAM Jeff Chua <jeff.chua.linux@gmail.com=
> wrote:
>
> On Mon, May 1, 2023 at 1:18=E2=80=AFAM <gregory.greenman@intel.com> wrote=
:
> >
> > From: Gregory Greenman <gregory.greenman@intel.com>
> >
> > This feature depends on a platform bugfix. Until we have a
> > mechanism that can verify a platform has the required bugfix,
> > disable RFI.
>
> Greg,
>
> Patch applied and worked! Thank you!

Only issue with that is I was in the office with EAP, and couldn't
connect to the WIFI. I'll need more time to bisect next week at the
office.

Jeff


> > Fixes: ef3ed33dfc8f ("wifi: iwlwifi: bump FW API to 77 for AX devices")
> > Reported-by: Jeff Chua <jeff.chua.linux@gmail.com>
> > Link: https://lore.kernel.org/linux-wireless/CAAJw_ZvZdFpw9W2Hisc9c2BAF=
bYAnQuaFFaFG6N7qPUP2fOL_w@mail.gmail.com/
> > Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
