Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC534EA7BD
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiC2GSZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 02:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiC2GSX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 02:18:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2CC247C37
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 23:16:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so1828712pjm.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 23:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Gru0xzSKUSWfV5dC8TSWAVYp7Xp73z1wb7Z02fCucT8=;
        b=M2t+04rEO3niWVZ2J8ixxCWh41dGVdD9s/U1swO6nHQagfS4BqNCxQgpLfh+vsvBND
         cxI8h4Pak6jnCdaFXb1eZ6E4313GHxj91XxKmgsFmxbYyjfEsa4vNpodpGh0ogGLJnjz
         VpoPIXoJM69g2KrlKguKQ44lJ7JpQqfrlxaFUh2Z43GgncH7k2CFGxuW86T1ZweevqOw
         UX+mLAJXE1qdCuxovV0UTpysavZHvWhoHnFls5z/p+nNDJDQu/5V2YtlScTDuSV+zqKm
         PaXNk4CFVJrAbPYF9d5YDc4inv9IsTPEXQm4filIM9SUtBqMFAKi21sQ6gxft29Ascyc
         XW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Gru0xzSKUSWfV5dC8TSWAVYp7Xp73z1wb7Z02fCucT8=;
        b=mCZMVO++DL6ySrfLBnir17l9KnCJmYmfsLP1h8hnt9S7+eXEyl1vg8dhogyadU4Pjg
         RzTnZHNrJAJxw/pkbIQ419zts0OnzfV54aXoZ2mKjlM1NFLoMMZSdRHaEdM/bMTb9+Pe
         OqZbjTao66vupMQxmMMZEAlkBEsZnsEQh735cVOTM+Sv5MOIMARsIPr2xQUx5gW9SRLA
         5ux5jG5vaPUh9WO3z3HJIiK2ktg1AL3ChH1Ru+bhA8RnApwdiFfX6imuNjo3EiUdVMVZ
         EcqDmbaDaKZBVIi0ipF0qbjQPM6rTPl7vtKfymDo8gCI9a7kY6vmJL88db6Z7DOCWWOw
         Tjvw==
X-Gm-Message-State: AOAM530RzYvaRwXpe0UTDDxC3/hqchPD/WTAiiTcy5RTp5XuCifcMbpZ
        FbRuxSa7Hni5a0MeEkcZs0429cq0qG7NrAT2OGd+Qh2Mm/k=
X-Google-Smtp-Source: ABdhPJwgTuggsT1qwoJVnCo+Aqj6qQ6SNOIEu6aMYRgILTMekaCHZqw442dax1Wp8DRoHiHdyx2QuiKAOyIg4vk3QkY=
X-Received: by 2002:a17:902:c745:b0:151:e8fa:629b with SMTP id
 q5-20020a170902c74500b00151e8fa629bmr29674562plq.90.1648534600844; Mon, 28
 Mar 2022 23:16:40 -0700 (PDT)
MIME-Version: 1.0
From:   Jupiter <jupiter.hce@gmail.com>
Date:   Tue, 29 Mar 2022 17:16:04 +1100
Message-ID: <CAA=hcWRay+5Xqz+RO_EX1-Yr2Ef_uXcLUL7dZE45d6wBga4mzA@mail.gmail.com>
Subject: Which vendors maintain SDIO WiFi in mainline stable kernel
To:     yocto <yocto@lists.yoctoproject.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        oe-core <openembedded-core@lists.openembedded.org>
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

Hi,

I could not understand why so many large WiFi chip vendors retreat to
stop maintaining WiFi SDIO chips to mainline Linux kernel, and to
settle it's chip support to out of the tree, use its own SDK and
proprietary kernel tree to source.codeaurora.org or private repository
which are not compatible to mainline stable kernel, the kernel
configures are also different.

I looked at the following link, the mwifiex and mwifiex_sdio support
the Marvell (NXP) 88W88 chipset, but only kernel 4.19 was able to
build and to run, kernel 5 cannot support 88W88 chipset, any more.
Same to Qualcomm, the old Atheros WiFi modules are supported, the
QCA-9377-3 chipset is in source.codeaurora.org only supported by old
kernel 4.9.

Given the OE/Yocto poky kernel build is based on a mainline stable
kernel repository, how can I build kernel 5 for 88W88 chipset or
QCA-9377-3 from source.codeaurora.org or private repository? Or which
WiFi vendors are still well maintaining the WiFi chips for kernel 5,
the only sensible solution is to switch WiFi SDIO chips? Appreciate
your advice and comments.

https://wireless.wiki.kernel.org/en/users/drivers

Thank you very much.

Kind regards,

jupiter
