Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7896554C7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Dec 2022 22:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiLWVhD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Dec 2022 16:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLWVhA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Dec 2022 16:37:00 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBF1CB2B
        for <linux-wireless@vger.kernel.org>; Fri, 23 Dec 2022 13:36:51 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id o14so2892239qkk.5
        for <linux-wireless@vger.kernel.org>; Fri, 23 Dec 2022 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FQl/76Qbqte4fVJmlL7WAYT8S3tkJD7vqlBp3Ta3BXU=;
        b=YhoeCmS8E59bILv70dkyyIduqvYX83mAGInMibHDhgo0tk6DykF+jsGPZB5bxHUqjy
         8YrWXirta9o7i/o1wNfcsOQxxvljnvWweae/N+5qQf1VmmbfxAcSsI+wzxECrI8Z4Git
         PzsEHhr1HzS1yZvNYuuPphTBjSZsl2IS5bFrmR/PKJIj12BMdu+MLV4IvSA124iogMa2
         t1FmRUHZa3r2SnEm/FpwYEqW9Ox9CwCDTa9in87XR96UK0MWsZXbpkBQgHGn6kkHW/er
         ajiVz4/717vbWBd4vgGR2Z6qXguEL3J6IjkWUkP9tRkb7IHLRrSGXdZQ4076DmxPU8Rk
         laTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQl/76Qbqte4fVJmlL7WAYT8S3tkJD7vqlBp3Ta3BXU=;
        b=KKWxMwrcBj9byhwJATzJqB41I2DkfdEcBg52zqi9fY0z++8ihTqy9Z788ArGKENBPI
         uiqT/K8xhdjqzK6oGRtncuI7ui2DHWrKtLa/lV6RUWQG6DOiN5dlADvZMwx4cO8ilz84
         Z+jhYE4IHc85lCXYF6hxoW2mUVGZadXc7/eVsGPuBUfa6fVdzsAG3ZEeDDjvUtlrDm+1
         8k6DVX871qjqjndgbQjSYisJWTScY+4OS1Vyu5PsRKiOtRclT2touR5C3jDvQ0lkjf9G
         YWn4UQW6KBVsXSQ2NEpGGduJZudnM7mSPuKba8FXKaaIiSkZDwz/ch9AdpjxnzsG2jgm
         exWg==
X-Gm-Message-State: AFqh2kpC0kaDhV2+DWQUZ3i7jVuDpgFEP3JBNB/tx36ImW088V4RZLBJ
        QOYW1ATkYgM2OmOaEAhdgrQRPCLM/iyu2ij+KNySvEdxeQ==
X-Google-Smtp-Source: AMrXdXuSvTz92FM6LoV9OmCmeotEKkb6BPDV+TCWa5PCfnK1/aAkhdBFom5bvfkmTAe991Pq8JTL+axZtgcVM5SaF0s=
X-Received: by 2002:ae9:eb4d:0:b0:6fe:ffbf:1b51 with SMTP id
 b74-20020ae9eb4d000000b006feffbf1b51mr585289qkg.361.1671831410196; Fri, 23
 Dec 2022 13:36:50 -0800 (PST)
MIME-Version: 1.0
From:   Nick Morrow <morrownr@gmail.com>
Date:   Fri, 23 Dec 2022 15:36:24 -0600
Message-ID: <CAFktD2fRnSbNgWRRoGbQzG5_Mw7=zFJKTVBHS_3D+mNUYcv9hQ@mail.gmail.com>
Subject: [bug report} wifi: mt76: mt7612u/mt7610u - 6.1.x hard locking systems
To:     nbd@nbd.name, Lorenzo Bianconi <lorenzo@kernel.org>,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        Sean Wang <sean.wang@mediatek.com>, deren.wu@mediatek.com
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
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

Starting with kernel 6.1 rc1, mt7612u and mt7610u are hard locking
systems when connection is established. From a report this morning:

"So I'm using a MT7610U based adapter and updated to 6.1.1 in Arch
Linux and it's a complete lockup a few seconds after connecting as
other people have said, I'll use the LTS kernel (5.15) in the
meanwhile but this is probably going to get a lot of people that use
distros with newer kernels."

Background: Problem first discovered with kernel 6.1 rc1. Bug report
was seen on linux-wireless around the rc5 timeframe. This is an
additional bug report.

I don't think additional info is needed as I have tested on several
distros with various RC's of 6.1 and the problem is 100% reproducible
and unavoidable. This is a show stopper bug and will result in
widespread reports as distros upgrade to kernel 6.1.

Regards,

Nick
https://github.com/morrownr/USB-WiFi
