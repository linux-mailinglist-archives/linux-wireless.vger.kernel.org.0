Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB27678BF
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jul 2023 00:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjG1W6A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 18:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjG1W5t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 18:57:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F092211B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 15:57:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso1591355ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690585067; x=1691189867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqGEzOR5r6kH79o9SwA25U8njOcawYVrofop3YQ6YUY=;
        b=fiGthZSlKO+TzVRMFQ/lllIkD1Hxo0n//085ngVGHX+MFVacNMT3jIfwGlotRfqjgi
         7/P2vA/h8L+veUta3UBM+pWIrJvHr/5k6/Rjn4abuIqxwd7smLlUVI8+sxAVHHkqY9Dm
         ClG4EhRzY0307ShUnA4g6h5b+AA+GZOvaUXcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690585067; x=1691189867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqGEzOR5r6kH79o9SwA25U8njOcawYVrofop3YQ6YUY=;
        b=NNHbS4zPp0vxE0H20iHa3ymwS58jzzWdIods+yjQsriC5O25MBfLNkLDVp3L7CCMlm
         wmE1DnD2+uCC8H+CQ/ooH7DXgygqHMFRW9Y7T3+bFBMNyj0YL/K7Xp3uTK3VWprc8wi+
         ur+3SWXIrnkPFoFxfjCkWsXxLTbhmz2gihrwfzwa8xaHHJdABYVykaWEPPnBm8HDAnJW
         Kc9fH7nwwsAHbCAiUX51q8uPLJmGAAlH9OmW86onFAP7wx3Dt202GUw0LYs9+fGwyEGL
         GlyvYdzl7ODn8Q66wRhy7X9Ww/9HDuGnDRZXj/1+pQSqlVDR+bPIqEjlnQgHV2aAY0nY
         ITjA==
X-Gm-Message-State: ABy/qLZpYGsHnT4tgYexC5k6ULk2jrtI0v+7LRKB4VOBir09id9vOlmy
        +csvjZ4+1t9YvG05iAiq5Ii3Qw==
X-Google-Smtp-Source: APBJJlFOw6OVfT4p2CaNm9atJ1j4OmKSy9hELnlIdDyAntpjKQSdNnE2D3nHAe//JnmbkZEc3Ervlw==
X-Received: by 2002:a17:902:c405:b0:1bb:a85f:4645 with SMTP id k5-20020a170902c40500b001bba85f4645mr3324239plk.15.1690585067446;
        Fri, 28 Jul 2023 15:57:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001bb9b87ac95sm4082927pld.103.2023.07.28.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:57:46 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:57:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.5-rc3
Message-ID: <202307281551.D894AA39@keescook>
References: <CAHk-=wi4Yau-3Bsv2rXYmtXMTLaj3=Wyf4cdM6d89czFvkVsRQ@mail.gmail.com>
 <20230724122626.1701631-1-geert@linux-m68k.org>
 <88f83d73-781d-bdc-126-aa629cb368c@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88f83d73-781d-bdc-126-aa629cb368c@linux-m68k.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 24, 2023 at 02:43:02PM +0200, Geert Uytterhoeven wrote:
> On Mon, 24 Jul 2023, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.5-rc3[1] to v6.5-rc2[3], the summaries are:
> >  - build errors: +5/-0
> 
>   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 583:25, 493:25
> 
> mips-gcc13/mips-allmodconfig
> 
> Full context:
> 
>     In function 'fortify_memset_chk',
> 	inlined from 'memset_io' at /kisskb/src/arch/mips/include/asm/io.h:486:2,
> 	inlined from 'build_auth_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:2697:2:
>     /kisskb/src/include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>       493 |                         __write_overflow_field(p_size_field, size);
> 	  |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     In function 'fortify_memcpy_chk',
> 	inlined from 'memcpy_toio' at /kisskb/src/arch/mips/include/asm/io.h:494:2,
> 	inlined from 'translate_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:955:3,
> 	inlined from 'ray_hw_xmit.constprop' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:912:12:
>     /kisskb/src/include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>       583 |                         __write_overflow_field(p_size_field, size);
> 	  |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Single-element flexible array abuse in drivers/net/wireless/legacy/rayctl.h:tx_msg.var

^^^^
is this line from you or is there a tool outputting this? Because, yes,
very true:

struct tx_msg {
    struct tib_structure tib;
    struct phy_header phy;
    struct mac_header mac;
    UCHAR  var[1];
};

I'll send a patch.

-- 
Kees Cook
