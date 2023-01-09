Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9D661CAE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 04:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjAID2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 22:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjAID2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 22:28:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9293E559D
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 19:28:32 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qk9so17008136ejc.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jan 2023 19:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoNSLMosHAarytATuIdRvcxNL2oMrGcNMkG2OXCiBm0=;
        b=OhAzq0ON3BtWr9Vy6mGpHdzLedc/jcdcZ1x7J19FpyDnX+MU7lN3J43I3/RGTodGGC
         caAswwh1Bkc198Lk4ApR6Us8T1RFdd15iarFZTsEnHV6mb9p/OV5fjus7ebigVkHPfke
         YLsdFsWDsiI5oMyqZyF+2S4iiSZ/GAEPY1ECXTaq7+baWT34Gkg4LSSYzkVfBMFkyWwd
         5OhNa8YGgTek+zCCj0cMAsIEoPJF4JjGX4J6nPqhgUyR4XD/3di0DhxkeKRJpvtiKOlS
         SA4doQIlTCIs7FQ4f++SD8f0KQ1zYwInadmuOZeBfmQjCGw+W/YzTXBw5sLxXS42Ch6M
         Djeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoNSLMosHAarytATuIdRvcxNL2oMrGcNMkG2OXCiBm0=;
        b=C4y9pkHBqy2TQiEDhuJcq98JLPr+rvkqrvC/i28nfxhNeUo8Ht0jfVUkoLOZZZWYCp
         QIRiW+FwlFd3KyiF5e12SiCpX6Fq/HquSBWyHGkToHIRjAYxnCkvL0EkV/5iu8dngQGL
         hC2Cecan17LmjxrbnNNzAFpcgdAL8LcVlyEl6NSQPt+1U30nT6JxkUHIYr0HoJLetTf3
         x/8coSVI7HaVlQrtRAbkmg/crZxGwbIunzofzYq/BblxvTGvyF1uhTzx8OaPOMLG4n/q
         zWiiu0cxboCYUYPb+KWi1pa8bVCaaMd3l48AEW6E9m4Xmos8nPvcVLurEqLATE6nDnR+
         CuyQ==
X-Gm-Message-State: AFqh2koV5l2DUj6Q7ynWCp3SGQPetw5avcQgzzw0fxdh0YmJd2uFRm+d
        gUgh2s+Cu57mbFBlIpc2Xh2m54ROTMT9QC9Mq9njGb8kwsU=
X-Google-Smtp-Source: AMrXdXsrq2GQ0RBe0oyU2WDPUba26sV+N6A+2kOdCfWDQQtHhYgXP+DCSkx1JZG7tpA7KULhBoXnJcgI8I2yDt5NCds=
X-Received: by 2002:a17:906:7fc3:b0:81d:3231:591f with SMTP id
 r3-20020a1709067fc300b0081d3231591fmr4565331ejs.46.1673234910701; Sun, 08 Jan
 2023 19:28:30 -0800 (PST)
MIME-Version: 1.0
References: <CAN_LGv2FLLKxsbruJ0u_Gh3+_nTGaVGd4154DXQ7Tz+BnFt3EQ@mail.gmail.com>
 <ac023262-c6cb-01ad-aeee-2dbf379f4c37@leemhuis.info>
In-Reply-To: <ac023262-c6cb-01ad-aeee-2dbf379f4c37@leemhuis.info>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Date:   Mon, 9 Jan 2023 11:27:54 +0800
Message-ID: <CAN_LGv0gqd1VpWgD0vdVuPZGhZ_R8pdNQntSJ9_602ym_ofeog@mail.gmail.com>
Subject: Re: Commit b320d6c4 broke mt76
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Benjamin Berg <benjamin.berg@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=D0=BF=D0=BD, 9 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 04:58, Linux kernel=
 regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info>:
>
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>
> On 08.01.23 20:46, Alexander E. Patrakov wrote:
> > Hello Benjamin,
> >
> > I have this hardware, which is supported by the mt76x2e driver:
> >
> > 04:00.0 Network controller [0280]: MEDIATEK Corp. MT7612E 802.11acbgn
> > PCI Express Wireless Network Adapter [14c3:7612]
> >
> > Since Linux 6.1, the mt76 driver panics the kernel due to null
> > dereference shortly after authenticating to the AP, as follows:

<snip>

> > b320d6c456ff2aa43491654407d448bcfa58ac9f is the first bad commit
> > commit b320d6c456ff2aa43491654407d448bcfa58ac9f
> > Author: Benjamin Berg <benjamin.berg@intel.com>
> > Date:   Fri Sep 2 16:12:40 2022 +0200
>
> Not my area of expertise, but I guess it's fixed by this patch:
>
> https://lore.kernel.org/all/20221230200747.19040-1-nbd@nbd.name/

That patch indeed fixes the problem. Thanks!

--=20
Alexander E. Patrakov
