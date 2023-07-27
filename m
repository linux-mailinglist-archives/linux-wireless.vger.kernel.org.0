Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DF765965
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjG0RCb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjG0RCa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:02:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCD6F7
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:02:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8ad8383faso9771585ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690477349; x=1691082149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wT/ZsiiDZwcgiQgl4DELrnCzGmHF+3XYDdWiMBrFYvo=;
        b=K0phnEYk/GVAqF5YbTQkVwMdPv8mpH4CuAkx7IsfmRJ5aLTp4xG8IBBDRxwU3rp18M
         H3sZi0bD5d69IgZnJX0pGk+67CRDZxTrseYrgwlMhuP5Q9J4PWS82sWweo8TAt9iHOuR
         rX1q8/lxZ76BFQzEOl67eODr84NVHK31gql9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477349; x=1691082149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wT/ZsiiDZwcgiQgl4DELrnCzGmHF+3XYDdWiMBrFYvo=;
        b=LJWoFOSO2OasiZd+XejVZmheVUE04yYLbGEWH6itmNcaxndAOyEI8/MTlJo972DZzD
         swVfSX6IcR/+pSwOdti1QTSZ6amoz1svg7qMIToX5XKSbJErlBXdoWGZrqWeehcVSYjM
         rn3P1+1nQoeozgTX3OU7BfPV0fRlBUACMkvySmQIjX8HDQ7XlwY04Y7A12JWE03iX/+O
         dGdg2zHqd1gO2DsAoxjLFnip1Mf6MCUeKmCzO6xvso2pVv13aaPBkq2u89wNO4wvKlWQ
         /PJ4NmZKfDvnTZP280NEN7jHZJVrkX7vFqjd84jpMROl2StFygHvXYCw0ykn8dGMq+dM
         AFAA==
X-Gm-Message-State: ABy/qLZEflZ1sqE+OkOMDFc6mKaHPj2VxP9VGmZm1tzwMSXTljUXiN+O
        gXXGpjZVzW0pdBCnNFMyioq4zA==
X-Google-Smtp-Source: APBJJlEJpUVqcSMnFLWNvhMQvBdF6RrGYz2iohHdmUVWppDCrgiBB6p74K9WRtxaVJoGd8oU9n28vw==
X-Received: by 2002:a17:902:dac4:b0:1bb:cd10:8209 with SMTP id q4-20020a170902dac400b001bbcd108209mr5653824plx.50.1690477348974;
        Thu, 27 Jul 2023 10:02:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b001ac7f583f72sm1879688pld.209.2023.07.27.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:02:28 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:02:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-hardening@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: Replace strlcpy with strscpy
Message-ID: <202307271001.13EA5FB@keescook>
References: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
 <202307121653.4A9C69C655@keescook>
 <CADmuW3UY=w0p-h1h4qOord7z1nFnvpyCOU3fcCaATm_PvFFUeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3UY=w0p-h1h4qOord7z1nFnvpyCOU3fcCaATm_PvFFUeA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 18, 2023 at 12:38:37AM -0400, Azeem Shaikh wrote:
> On Wed, Jul 12, 2023 at 7:54 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jul 03, 2023 at 06:12:56PM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > >
> > > Direct replacement is safe here since DEV_ASSIGN is only used by
> > > TRACE macros and the return values are ignored.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > > [2] https://github.com/KSPP/linux/issues/89
> > >
> > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> >
> > Looks good -- thing is using return values from the macros.
> 
> Just to confirm, you mean *not* using return values from the macros?

I thought I'd replied to this, but I see it didn't happen: yes, I meant
"not using return values". Sorry for the confusion!

-- 
Kees Cook
