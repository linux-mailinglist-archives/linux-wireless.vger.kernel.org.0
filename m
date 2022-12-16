Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FBD64EB2C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 13:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLPMEp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 07:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPMEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 07:04:43 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72696B0F
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 04:04:41 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x66so1643046pfx.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 04:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9mXC3HPGi4SnTUKl47vyKMshaiteCDhTRS81QCs77c=;
        b=m7cjw8crabx8KlKGQrst9fR8O1t2yxt8m9H3nFETO6imjVmYBLkdbBFU1+EBPQpevT
         oS0Q6dmT+58ZfalfAMbywVXqSPiF2l51wQ3/pfSedYILOPqAVD1nA1JDoQTluiseP3YR
         pcfH5oqi58+Id4i9jywkWBOQNdeiMifSpJzMbScizu5i1/Zd6ehw3I3qYPlMRcMpHNIf
         dqyK6asck4HZyI10daG3zkmLIQIGXQkDErqHWkfBKH+MhI0zJ5jK36WmBeJmgbgZsngp
         xeJiAtEmujjOg9xOLeNwugydT58GEq17iiPH87kxjmQayt0M0htfyEWLSDMJHwOHDR/z
         /FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9mXC3HPGi4SnTUKl47vyKMshaiteCDhTRS81QCs77c=;
        b=nFy1ypha3gBeRhV6Ux3yxc8k9wdhep66UVq3ESpVltMq/EPLlMXslV4r8visVVnwoS
         4QEeLb1Vd9pe7NlnjKqYcQiyjSCyFiFMLXIblCFDVZ3VnQ9mb/3XYKjRi2ZNIorFA/lP
         nj/rI5A/h6jxucudrrHac3de5NLTGL+pUlbZu04mV+8qj/ZakHNlRTYI23aVJZ9WIp5z
         p04+hBb4qo1KMFD7ubeQ5n/4uBfGRbv31ngSN5LwklWZqTSEwNVdGR0Kv5tWTilwDcR/
         mo/1i11Aq3O9bVuYz4HX+GJEtroFsKnrjOoHyA8vKXu1+RH1HEi46mNtsowtuvbyl5Ov
         vc4g==
X-Gm-Message-State: ANoB5pn3xG8McNPIemrzyDQffQmGeQ6Olw/8K7N0eZrXiyD1y2clCDqv
        5/a0Yc+nFNYSwlPLZn+12CxM1To7Uq1CMLtbbmw=
X-Google-Smtp-Source: AA0mqf5tnzdXarz4cLuC1psT15pF8dbErmLY7pdu3abV30FzMk3Scy0HKxN9Sy0NPEwGh7fuMiea3cItEzmWOvmbZLs=
X-Received: by 2002:aa7:8c07:0:b0:577:a422:e57d with SMTP id
 c7-20020aa78c07000000b00577a422e57dmr5559628pfd.74.1671192280935; Fri, 16 Dec
 2022 04:04:40 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5AW4JUEFiaFgr8PvC5x3a5VWA4Ut8cXYYAme5-scgBV6Q@mail.gmail.com>
 <872024534.20587.1671097586476.JavaMail.zimbra@z.j-2.se>
In-Reply-To: <872024534.20587.1671097586476.JavaMail.zimbra@z.j-2.se>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 16 Dec 2022 09:04:23 -0300
Message-ID: <CAOMZO5Bv+_2CN_CGeFswRCQp1-2fmuFZj26enxEeE5gpva160w@mail.gmail.com>
Subject: Re: ath10k: IRQ timeout after AP-STA-POLL-OK
To:     Patrik Arven <patrik.arven@j-2.se>
Cc:     kvalo@kernel.org, linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org, Bough Chen <haibo.chen@nxp.com>,
        Kevin Groeneveld <KGroeneveld@lenbrook.com>,
        Jakub Kicinski <kuba@kernel.org>
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

Hi Patrik,

On Thu, Dec 15, 2022 at 6:46 AM Patrik Arven <patrik.arven@j-2.se> wrote:

> Solution in my case was to revert to a custom(?) qca driver:

Thanks for your reply.

Yes, I am aware of this out-of-tree driver, but my intention is to
keep using the mainline ath10k one.

Does anyone know what triggers the AP-STA-POLL-OK event?

It looks like whenever AP-STA-POLL-OK happens, then the eMMC interrupt
is no longer handled and causes the interrupt timeout.
