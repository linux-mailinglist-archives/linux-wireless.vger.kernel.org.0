Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8E601D95
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 01:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJQXbz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 19:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJQXbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 19:31:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D582E7268B
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 16:31:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id d26so28398639eje.10
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 16:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skymem-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dta6+x6T1yV3WXx9o2Y0d625a4aNpad06/6f+SXBGhU=;
        b=71uEUgaor76UP7F1i3DUdoA+vTjPaXTOfdGt+dkj0zwFEhy9Ae+DrWkYIx7c8oiQwf
         bGQoj7mHl7cZqLdfGPxGj82nH0RQBgtPPXogM1a1tbxY4r/pDXytP7KqQGV8R6lNrxJH
         mSjxaaclulNMndOgQfAEAyNNOo9OnPuu53vM4GV08HvjZhKFxPLbMIQleKHJ8Drb32Zr
         hg5Is8SWN5PfvjBLokbKVzAKcOJK7tMHwv+fUOKAqqMOmxJQ6CBSDPWgY10q0TBdiSJC
         yrDuOf/BM0EsLXbLUl3Ug7XNq8ztBe62cTuPF97ArYCsQT60W0X03fYm3nvh2ycYCSus
         Nqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dta6+x6T1yV3WXx9o2Y0d625a4aNpad06/6f+SXBGhU=;
        b=5GwZeKQ4j+06Ynypa5hf3FCHoWzEOCzxTddbToq/wWNGElL05hFytTpwWavCRGSmLq
         qMo3dauqBFyzqDUItF7FR+yF+olcy12SV8hglwDojlajdg0JAN6HnqrQn33mHGOLp2GP
         3dSABba19jQZM6udP6ITzwi1Eq2LDLcXH3ez719OIHBtswsNcUIGURUnMX7Ujv0kY2Ts
         FofNSKb4182qqBZ+3zCqhqEkucgnU33HXWrhlQghCwe+pXsDc21kNLdGkFeCDFPhUXCq
         QeRrDMI+C4WaNBenhX/jCXrCsBnfcUp33jq+Kndq0HiyxCJ7a1DfoUXZrklEMIso8MHa
         CGZg==
X-Gm-Message-State: ACrzQf2lc6LRiYHRm9Ea62EZyayUefAuAhM+QAMTkHPOh0uxr1suykGW
        c/77R1siF8v66irbsJIwAjiBRazYxej0Z9af1liNaAAIwA6qUXLs
X-Google-Smtp-Source: AMsMyM7v+6ynaYjBC6jnoNq240BCDWpKGGcW0RH9BhtlVfHPsiRvHJAB9qKHj648/pE42FhlX0+4MPUVqS1+tIbIK2M=
X-Received: by 2002:a17:907:9625:b0:78d:bb06:9072 with SMTP id
 gb37-20020a170907962500b0078dbb069072mr123159ejc.472.1666049509417; Mon, 17
 Oct 2022 16:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221017025204.1370004-1-PascalCoffeeLake@gmail.com>
In-Reply-To: <20221017025204.1370004-1-PascalCoffeeLake@gmail.com>
From:   Info Skymem <info@skymem.com>
Date:   Tue, 18 Oct 2022 01:31:37 +0200
Message-ID: <CAKvd=_i7TbF3Kxt8-bkBsUWxtdYsc4ZL86NjESdJAtcE6bKLZw@mail.gmail.com>
Subject: Re: [wireless-regdb] wireless-regdb: Update regulatory rules for
 Japan (JP) on 5GHz
To:     CaffeeLake <pascalcoffeelake@gmail.com>
Cc:     sforshee@kernel.org, wireless-regdb@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
thank you for your information.

On our website you can find email addresses of companies and people.
https://www.skymem.info

In short, it=E2=80=99s like Google for emails.

Best regards,
Robert,
Skymem team

On Mon, Oct 17, 2022 at 5:29 AM CaffeeLake <pascalcoffeelake@gmail.com> wro=
te:
>
> Support 144ch for JP Region.
>
> The Ministry of Internal Affairs and Communications has approved 144ch in=
 Japan.
>
> Source: https://www.soumu.go.jp/main_content/000635492.pdf
>
> Signed-off-by: CaffeeLake <PascalCoffeeLake@gmail.com>
> ---
>  db.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/db.txt b/db.txt
> index 012824f..8b3827a 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -907,13 +907,15 @@ country JO: DFS-JP
>         (5170 - 5250 @ 80), (23)
>         (5735 - 5835 @ 80), (23)
>
> +# Source:
> +# https://www.soumu.go.jp/main_content/000635492.pdf
>  country JP: DFS-JP
>         (2402 - 2482 @ 40), (20)
>         (2474 - 2494 @ 20), (20), NO-OFDM
>         (4910 - 4990 @ 40), (23)
>         (5170 - 5250 @ 80), (20), AUTO-BW
>         (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> -       (5490 - 5710 @ 160), (23), DFS
> +       (5490 - 5730 @ 160), (23), DFS
>         # 60 GHz band channels 2-4 at 10mW,
>         # ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v=
1_1.pdf
>         (57000 - 66000 @ 2160), (10 mW)
> --
> 2.37.3
>
>
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
