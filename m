Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B50A693101
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Feb 2023 13:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBKMiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Feb 2023 07:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKMh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Feb 2023 07:37:59 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BCC2E832
        for <linux-wireless@vger.kernel.org>; Sat, 11 Feb 2023 04:37:58 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id eq11so7406440edb.6
        for <linux-wireless@vger.kernel.org>; Sat, 11 Feb 2023 04:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9TPLO5aEnVBKwSXE8213FMs/5W0ZG3K+omgdnsMh0M=;
        b=NiZoNhs1sEZdez7aaM3g7+j/Z8OoeydEuaZ/ExevBXUsCE4BEGUeM0f9MvD+uUfa7e
         zdFCOjlgjPB0wDD75gpWjtPQ+7LycPoKXC5XQGQ20526RIX8N2il53OZfdV+N3/YkP4Q
         xzyE7N1Ylh322x3YatN9Klk17UiE1d3H3n1olRezVLli4EiaIs9KCqgtSJhi7EgS1+TS
         C1Po76y8C2bQ49/GhgFMu5Q2t4CC14OC2G9Uy2REnLWE6kBg8EwFN0I0959+Csnwg/b5
         DaDsbX8Vu5O12ZRZgmlGaA0UmgrghJhs7Wjxe8s4RRVXur0LAQKQVwL4MD8C7IrQA7n2
         /9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9TPLO5aEnVBKwSXE8213FMs/5W0ZG3K+omgdnsMh0M=;
        b=El70nqzDLypS8oipN6sYjw232XnSJem+H/obW6dnDw0RcIyGGgtBnbHIC5eI92kCTF
         +SGiI1e9VfnfMwp7Z33IlDgnwM3vKOMSlSJm4pEK9WmWFp8R5SWTIVyzYV9khcJgJlFg
         O/N/vow0JGxyW1xGi2N6MvQ7HDywCbq4EXK1JyhgCJ3GE8NLnSPIUzx88XJWyIcI6J7e
         ozhsV+us8wudWYIfcFBbgJwRam9QOmXWdxJKCXCgEvsVOS01tsXxtRQa/mKXWGYmUtEU
         VELo/Ny4aV0HDWafocfKlta5BDSJK4qjk4fg1GRQP6VesBVHOpxqIBfZ9jvkJ8mKo1eC
         yf3A==
X-Gm-Message-State: AO0yUKVzN7W37xeeEi6OG3BnOJBzTbSa9YoXNj5BVqKr9EBg847HRQno
        aC3G5RcGgwB4eJy4xEJsDChTTPd7eMYyHR4jnrQ=
X-Google-Smtp-Source: AK7set//pAud9hytWtC8P3bsGtMiV26NrJaZkpY4QjRc3If0z6pfHSjqb1u5ARU1QGms6+pEABBctGByzEnXO655zPg=
X-Received: by 2002:a50:d599:0:b0:4ac:b832:856c with SMTP id
 v25-20020a50d599000000b004acb832856cmr519484edi.1.1676119077094; Sat, 11 Feb
 2023 04:37:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:4c57:b0:887:402d:367 with HTTP; Sat, 11 Feb 2023
 04:37:56 -0800 (PST)
Reply-To: infolawfirm25@gmail.com
From:   Jessica Thomas <jessicathomas202344@gmail.com>
Date:   Sat, 11 Feb 2023 12:37:56 +0000
Message-ID: <CAP7asjzNp_54mDO9VHQfKULxQbks0MX6g=RejUnw=n48CGtpgA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hi I am Jessica thomas i would like  to make good frindship with you
It is obvious that this letter will come to you as a surprise but
please find time to reply me thanks.
