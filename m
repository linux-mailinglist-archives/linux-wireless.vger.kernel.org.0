Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48A076BB40
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 19:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjHARaf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjHARab (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 13:30:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A032122
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:30:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-563d3e4f73cso3432968a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Aug 2023 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690911028; x=1691515828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UkfaFNS6PyQamzbmmCA96R1ctLMlDtPFxg5rPKFvn0=;
        b=ig03R9f26Io9mZRy/gthUxgE3w+/0k7snxeJgxSl6+mwRNVWizC02DNjIQDq8m3xrH
         Vg840aKGAHvEdMCDs04jyfu3tyarRhBnRM84RJCzWd5nUxZPZ8k7tWC/tinCeIEbqtOf
         4Xd/hpUfIMEz1/0zzW7kCpw/bOi703v2qdmP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911028; x=1691515828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UkfaFNS6PyQamzbmmCA96R1ctLMlDtPFxg5rPKFvn0=;
        b=cPOM2ZBAC2Tuy18z6XuipjayLLL2oz4CDKE7kxNc0tsPPvjipJAjDoS2z8w5d03h/h
         bo/2nYlXTOlg+AsN+UScCMMeWsrySwJEMjZdSNG3RQIEtHJaCRLg0SDiTmNC5vHo7JtF
         fpk2IydK6dt9MVuZBKkg2Bj/JUouXAz/I5J3VNXOOnt4GfMSRbgIyOeeu2hHJkognM0Z
         y5n35PrfYKIYIDgmgkiWi1gqWvX4p/a0vgc2Wf8nUcZRl5DsNZ0FXLyVFfkm/Rg3cs62
         4ZzxxbR9Y4v9rPzFWD6S0lrgi6Q3jBuQQOkUns7oB1PR7dUN54CiDt/BIjbk5IhNo9Az
         7kPQ==
X-Gm-Message-State: ABy/qLZgdjfTmc7okQP4zJidDcTCN03tAq/5sNJ1ecWPsXr3rI6RJfsC
        Gl9aM+xpJnigjFiE1VcNjn4+ZQ==
X-Google-Smtp-Source: APBJJlGeRYdG7+8sYbdVaQYLv/kApU8rzcyO+v9cxR1ZM3lkg/IZowd6BZdBE5G926/17ajA741tIw==
X-Received: by 2002:a17:90a:46c7:b0:262:e742:f40a with SMTP id x7-20020a17090a46c700b00262e742f40amr10648695pjg.44.1690911028158;
        Tue, 01 Aug 2023 10:30:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z136-20020a63338e000000b0056001f43726sm10106893pgz.92.2023.08.01.10.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:30:27 -0700 (PDT)
Date:   Tue, 1 Aug 2023 10:30:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Ian Lin <ian.lin@infineon.com>,
        Wright Feng <wright.feng@cypress.com>,
        Hector Martin <marcan@marcan.st>,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ramesh Rangavittal <ramesh.rangavittal@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Brian Henriquez <brian.henriquez@cypress.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <SHA-cyfmac-dev-list@infineon.com>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH v1 3/3] wifi: brcm80211: change channel_list to a
 flexible array
Message-ID: <202308011028.BC462D29E@keescook>
References: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
 <c18a31a293fb5ba5d7a845c4b5052516ff724a9f.1690904067.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18a31a293fb5ba5d7a845c4b5052516ff724a9f.1690904067.git.petr.tesarik.ext@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 01, 2023 at 05:36:42PM +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The channel list is in fact a flexible array, but it has a length of 1 to
> make sure there is enough room for the special chanspec -1 when the struct
> is allocated on stack to abort a scan.

There is patch series proposing a way to put flex array structures with
a compile-time-known size on the stack. Would that help for this series?
https://lore.kernel.org/netdev/20230801111923.118268-1-przemyslaw.kitszel@intel.com/

-Kees

>
-- 
Kees Cook
