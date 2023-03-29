Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDAC6CF497
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 22:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjC2Uig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 16:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC2Uif (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 16:38:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0315BAB
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 13:38:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id eg48so68239580edb.13
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680122312;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xi9uq08Lc7qgSHIkc+cRozRgpnVzBfheYQcmgwPVIi4=;
        b=MAXUZpc4pTAU6ekLmeLFfWzvhqwVz1lA7iyUqLl4W0/6UeJ5tGmhabGo/oCfC6oWoz
         pf/qNII8gFahJUZV51weRxDoZn53KfBE71NtGwyA2LOraFZr0J3qIyJ8QO6BV2QDyE/k
         wZJoo4/wNCW7q9TNQNGR2f7MGEY91MGS08hR0k+YoI4r6W8bBrttK/2pOx46JW6drUpG
         rxz2sK1vKNWoSH9JPQm623L7qXhkyZsKIleCfVsKQlXZuCSBETxZiTY56i6lsJ5OhRmI
         LKofFwedLz383fRG/WCBRzJN9dGguvod8/SV6wjUS7yCeVSSRjXJ1+gzD4uIcNQg0m1o
         VyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680122312;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xi9uq08Lc7qgSHIkc+cRozRgpnVzBfheYQcmgwPVIi4=;
        b=aV4+vZY8Qhqn0HbrZuhDVsaKvx5q7qkZktL2kj6L2FzaHNlAxF6ke6HJ9UwbRE5FPg
         tiP3Dc3Ai758uKLYq82EBNIwjteKPO6NkLgVlGVf8rZbtEg/Rlhc2pciLMHcb7qYzzl0
         uFOFRq3r67ImKZyFHjk6bygYutse+MOOttCB6ATjnvUMUExA2x11MsLTKbXkN7RHnS/h
         ZpSszYtvnEQzJUAvG5ZTolhiJi4Q8oL6NWqgZ3id9Bm2meSNnaVTrrj1fbmCx3C3cygx
         9+0aTWyat3W5B+8GBEyXFN7j0ooT9lObKsNp6Xn/WYPyX3xrC67wLVPKGiwOBwva7Ini
         BWqQ==
X-Gm-Message-State: AAQBX9exBTpPkRIhG665QSfkWaKf0lejsgJbo1fu3Dgmd3uj56qyxaPI
        H7VTvGZIXJuove0ch8+MxAVacG8hYSa59F1QQZc=
X-Google-Smtp-Source: AK7set8IKhOXQjZTLlpGMSgAqb4L8ovVn11yqkMxB+U8JWOKyW056qeGOtdaG2x7WtAPsrsm9cEw3gzRIrgEfSWyB0I=
X-Received: by 2002:a17:907:869f:b0:8b8:aef3:f2a9 with SMTP id
 qa31-20020a170907869f00b008b8aef3f2a9mr9904079ejc.0.1680122312595; Wed, 29
 Mar 2023 13:38:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7412:31e:b0:c2:ecd2:ceca with HTTP; Wed, 29 Mar 2023
 13:38:32 -0700 (PDT)
Reply-To: nepk08544@gmail.com
From:   Leihservice <poje048@gmail.com>
Date:   Wed, 29 Mar 2023 13:38:32 -0700
Message-ID: <CAE0BjDNWRpu7EkL5k7pohNHouJRoQSdsW=xUAtHKgHYZoD_MRA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Holen Sie sich ein einfaches Darlehen mit einem Zinssatz von 2 %.
