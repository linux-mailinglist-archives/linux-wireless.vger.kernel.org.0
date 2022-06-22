Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38C554E83
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359099AbiFVPEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359016AbiFVPEE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 11:04:04 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDF53A71A
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 08:04:03 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k6so7226360ilq.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=Jt/qXO7TwQJF3EWuk5p4azKGOCxq/Rzk3KoLqC6Pwff+0tHhs8als9639cidnzFde4
         ry7ero38QELHA22RBkZWtE0xNRPiiPEWIvKtPd0fZpNhUDrKHRyETW5WgRrbPPmi6/vT
         vJpxoQNLrGfsMgIfV+PXszjD1nMaBRUe0Gxx0eYZw7YGtSc5pfRkGeshne5cjr5BaKxu
         3INPcNuWqxw7/0puGY6UuhzUSAv6SoxD7Bz3CVHuDQWru55+lIHO02gOv78FJXnTYNjB
         rbtWgbiyhkE21LXWR11Bk6fRJOPFFcU92J8XbdNavb7vvb9W0t8MjYRzeI2ufnWOCsiS
         AGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=wAUCd7meh+gKDdw2lS6F1YajvARrcDD6keCIzGvd0lcYuZAVE9U/UnFfSJhW/VJ/1E
         NO3urva8E5soHOV0lQ3Oiy9w4Oa7HkHe8XaxMSs5XBTvr9PBre7BevV+yswFkVx3yELe
         L/UbbMkc7mE1Vw1HXwXBZAxYJTTWDlcYIBYFBir4upzk6GAkA5j2i1cbvVAv68Fj9vO+
         cmyHd2bibK9uFuOAJVRZNJNsgbJyq/bWdEZkR86D/Yn5a0xiTqDTe1Ae3QEYCgNzGeo6
         CsZD+EvRUYpeKfT0RNfP2Wcr0Kw/CcpJybwI454/1g91BVIwQibQgxKSeHPpyC/27/oZ
         kvcA==
X-Gm-Message-State: AJIora/6DQT/fWrXzm/C+mHS+k3uwtET+aY2v6ifw5F2d6xZLVl0VRw0
        oC/5nhVZQldQ5RN0J7aMcd2/IHErcropcWhK7TR6gPCwUUcK6VMc
X-Google-Smtp-Source: AGRyM1uVFGSnpr+dTCH2B3yi91+xpZWxlNuq532hGAWMLDkFZu1Qrq3wwA6KogrJ63y1ppaQwcWp21NviyeWeo5Xswg=
X-Received: by 2002:a63:af1c:0:b0:40c:f9fb:deca with SMTP id
 w28-20020a63af1c000000b0040cf9fbdecamr3305128pge.479.1655910232628; Wed, 22
 Jun 2022 08:03:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:2308:b0:16a:1b3f:f74b with HTTP; Wed, 22 Jun 2022
 08:03:51 -0700 (PDT)
Reply-To: sales0212@asonmedsystemsinc.com
From:   Prasad Ronni <lerwickfinance7@gmail.com>
Date:   Wed, 22 Jun 2022 16:03:51 +0100
Message-ID: <CAFkto5szY9scoLwccBhUx92cgUVnT2cx2c=WmxiOTkm7N_y9gg@mail.gmail.com>
Subject: Service Needed.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hi,

Are you currently open to work as our executive company representative
on contractual basis working remotely? If yes, we will be happy to
share more details. Looking forward to your response.

Regards,
