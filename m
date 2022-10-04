Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E15F4923
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 20:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJDSTD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 14:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiJDSTC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 14:19:02 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541DE275D1
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 11:19:00 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-131ea99262dso15105322fac.9
        for <linux-wireless@vger.kernel.org>; Tue, 04 Oct 2022 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=J/u7DVEXjJmIG7E07wTucPWE0DEZVNW1Zgg6U1VTcqU=;
        b=DZucEzQg4rd/R2rQfRYiNG8xzIFGzkQ+xHLY+JeVdNNAMEvuiDRo+WRZ/vr9fFsOVh
         8gV2V5PttaNSdcQwoEY57/BeiVqrOSxy9iFD8EWqkHrAj3qLIErM79UVC1f2WCUk8x5F
         uPdeLvfmr0U9NLISaGT4K1PgGuOOFYFBu79qIMWvyRpVp+THbkA5TxJhsqfyuzsoFYQV
         E+L5KAYa+NuFPbS6FcKLl8mGiRqRqfZ4JUG6/mjuDXtzVhQEGM94B1UB2vRR9N9oMRQ4
         8CO1DpISaB7U41Wll7EiLSI9kQelMc9LbfLtB8feFnMJvQ/gL9IRN4Z0zJyAS41W5J5b
         Qgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=J/u7DVEXjJmIG7E07wTucPWE0DEZVNW1Zgg6U1VTcqU=;
        b=Ffh4UERXrXh6c0xy3AtXVQdsXbEXDs1xNI8h0hdZzfh6dZ7eo6iuCn27+XyKG8V/r6
         AhcdQG034Lh9Hl0T1t8+8n5/fmR4oIC2so2ZpKB6lMYBkBkwE4DFa5yRhBrOc2ttBJBk
         u5lZjsAvBs/Z43ysEkbmk1mVGrRgY3Prk3SDi/mjlyWONd4QIff+MRWre2aOCco6TfJk
         vBRi7IkGNVIhLp4uDsr8ynOvIRZV0Z4rCb9T0uRCNEvTLRzqOyYSnQ4rmEWujRKljRLu
         gEEnV+PZHkVwtb6OmwNwDY4Kaz4hcYjvw0dIF9Ljbcp5W5ooZTfmfVlKlr0xMs0QrCi4
         ffjA==
X-Gm-Message-State: ACrzQf0sk/8t/I+OtE//poqD05XJsrVXuIAYotJP1FzSsGf3bal58mR4
        rkwoEO6qQYMM+7SCA74P+d+9KQqzcItHspQ9HV9BMg==
X-Google-Smtp-Source: AMsMyM5eYgJZ0rdYt1FfA/mNTnuOkQ439BsgHDHgbvv+i3JhcKSs7GCeRJ9scZeaNGCeY0vOQzdoffZxmx0OYeEljes=
X-Received: by 2002:a05:6870:390b:b0:132:9ca3:8dc1 with SMTP id
 b11-20020a056870390b00b001329ca38dc1mr590447oap.106.1664907539754; Tue, 04
 Oct 2022 11:18:59 -0700 (PDT)
MIME-Version: 1.0
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue, 4 Oct 2022 14:18:48 -0400
Message-ID: <CAM0EoMmZy1+VRTvpN0OYkOzdCrJ24hb1h2rz8XdDLXGp3YH81w@mail.gmail.com>
Subject: netdev conf 0x16 schedule posted
To:     people <people@netdevconf.info>
Cc:     Christie Geldart <christie@ambedia.com>,
        Kimberley Jeffries <kimberleyjeffries@gmail.com>,
        prog-committee-0x16@netdevconf.info, lwn@lwn.net,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        xdp-hints@xdp-project.net, lartc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The tentative schedule for netdevconf 0x16 is now published,
See: https://netdevconf.info/0x16/schedule.html

Last day for Reel cheep early bird registration. You get
served lunch too with that price ;->
See: https://netdevconf.info/0x16/registration.html

cheers,
jamal
