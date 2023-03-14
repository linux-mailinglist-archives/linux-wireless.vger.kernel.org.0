Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D236BA16E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 22:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCNV1V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 17:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCNV1L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 17:27:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298915073C
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 14:27:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so11788228edb.11
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 14:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678829228; x=1681421228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bG0O3Y7aIPiYHIEJTSqU8nLImLNqR3olnmqu3uCV1o=;
        b=NxtAQ+Jx0vhYqcPaRj0hOKvcN5HLpJo+RsO2f9TDbPvuU4Fk9rZQw5qPZU1qG6cnMj
         qN9vBBh/3IlQbHD9pfzq/DrYJfTVMdeioIXhSpTSDXNMprAOaBkLOvP7FwfbuUjQkINz
         m8wJ82vAIV1lPnX4AqwiocaVelUYTZKP6PdVU0LP2R2VihT163bdnFOFzNqZH6xOL0zC
         veAd5uBsFaySJnFxpqTXVVK+U62FLh4GJMTZ6BQr2iUWGarvFdumGGSLhT5fa/MWhWLk
         t8lDVjLS1eAjAoPffmwakB+NWEdkMI1BoKIcOAPnAnenGg/5hmsY3rrzY7zZpVO3j7vh
         28fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678829228; x=1681421228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bG0O3Y7aIPiYHIEJTSqU8nLImLNqR3olnmqu3uCV1o=;
        b=vR7q6BD/FdUSXwztDF56EnREecflnSTLMFUBo92bZahnuk/nB5Ho9GnJZeOPWaSgYe
         eIQYedgEHXtkP3AibSuyT93I+OUXMtwONuKaVXDA5ZL0eOYwWf1nQy5cFCHtlNxpITHj
         csJrCXZ4h+/nRXAXjeIumjQZGZAECU2/Bj5qBwR9Ti4uTYQ7c5aWVLxQOWq9aqGHriHB
         MZQC7wZr0CJC5bXI4DA9O4vW2vCR/4S8niachd+U9zhl1V1ALT+dG5mcdlFpcSEuCbXW
         TNrtZBaBSQChwEPwFVlIrguEnCSwaHsScZcixHpUBz0tic0B5IQTSXMWAcxk2mHWalKu
         onLA==
X-Gm-Message-State: AO0yUKUhb4vq5pdZ/hQWp7Ziy7nxvFf0cG2hXO/URTrtSMROiRGVnzFa
        +bdDvSVUwI6xGxPhEP90x1g=
X-Google-Smtp-Source: AK7set8kmw9CNJYnRqKUzz8ypTLAG/gIcqz6u3G+9YG45Rs+wrKsxNZpAxS4/mwdAak+uoPRUoNsEg==
X-Received: by 2002:a17:906:2c9:b0:8dc:ebb5:a115 with SMTP id 9-20020a17090602c900b008dcebb5a115mr15870592ejk.0.1678829228542;
        Tue, 14 Mar 2023 14:27:08 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709060b1600b0092a7c28c348sm1604671ejg.69.2023.03.14.14.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:27:08 -0700 (PDT)
Date:   Tue, 14 Mar 2023 22:27:06 +0100
From:   philipp hortmann <philipp.g.hortmann@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Jiajie Chen <c@jia.je>
Subject: Re: [PATCH v3] wifi: rtl8xxxu: Support new chip RTL8710BU aka
 RTL8188GU
Message-ID: <20230314212706.GA6367@matrix-ESPRIMO-P710>
References: <4edbe29f-00b9-8eef-9789-20bed0b141e2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4edbe29f-00b9-8eef-9789-20bed0b141e2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 13, 2023 at 03:58:14PM +0200, Bitterblue Smith wrote:
> This chip is found in cheap "free driver" USB adapters from Aliexpress.
> Initially they pretend to be a CD-ROM containing the driver for Windows.
> "Ejecting" switches the device to wifi mode.
> 
> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
> 
> This chip is more unique than other Realtek chips:
> 
> * The registers at addresses 0x0-0xff, which all the other chips use,
>   can't be used here. New registers at 0x8000-0x80ff must be used
>   instead. And it's not a simple matter of adding 0x8000: 0x2
>   (REG_SYS_FUNC) became 0x8004, 0x80 (REG_MCU_FW_DL) became 0x8090,
>   etc.
> 
> * Also there are a few new registers which must be accessed indirectly
>   because their addresses don't fit in 16 bits. No other chips seem to
>   have these.
> 
> * The vendor driver compiles to 8188gu.ko, but the code calls the chip
>   RTL8710B(U) pretty much everywhere, including messages visible to the
>   user.
> 
> Another difference compared to the other chips supported by rtl8xxxu is
> that it has a new PHY status struct, or three of them actually, from
> which we extract the RSSI, among other things. This is not unique,
> though, just new. The chips supported by rtw88 also use it.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Tested Chip: RTL8188EU
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150


