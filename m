Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09823F9C1C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 18:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbhH0QJM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhH0QJM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 12:09:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CFBC0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 09:08:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x16so2571700pll.2
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3BOREjcUGdekjt/HzJv8JPNZZV+WRxv1ga5r5CaLfMg=;
        b=LgSMkv8yRY6NcFjGg/J63Y2GpE2F2TGefzma4o9g5HEhtSAND6DhVddNHYYks45NsN
         vl/76kMWgkZPlkAHgvJTPVgljvSFRJ7Ui/2QED3sjgSLOAoCwiEAsmgZNMGT/LdlCbMz
         6XWQqYT5qF5nKBsTivPFzvO7iyOTn/hubgj2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3BOREjcUGdekjt/HzJv8JPNZZV+WRxv1ga5r5CaLfMg=;
        b=qGsd2hpygss9Lb9lj3/BSrWK4HEXdDUi7Lh+RSea6GEgiZCh8j3YT4GAiI0Z3KaB1M
         YQ1LFpQCKaKn30x8giq4A/Eel/bdv0AxBIrOadbmZbWlP69BuujwXEjEI1AZVor2Oj+P
         7qo5w21kp8hJ8zszOA6dtuSvfBQVXvPy1pJELjUjgYNO6V560Bc4gS/5cMcCVWnSghkj
         u8HP0nwQ6DAXn42ULc93677nkUQQd6XgITon31Mtfa3IaAusYcG/Y0M3t1rdNRdtWx38
         EXIn/hNYv349hCWergENu0k21Dotd1lp8Iu+NQXm+xtHtwlpa1Fv3Jx91t7997VMd1/k
         ySiw==
X-Gm-Message-State: AOAM530vS0fE+5ytSTKbfJCjE1TbwE0fCxj8pebT58RMznf+4CFB5hxx
        FSgt+OHIr0H+Wtfrfmx+vqOT3w==
X-Google-Smtp-Source: ABdhPJz9b21uTH+fuc32V76US0q/VM+qkB83+nJU8q4xHvgfI8nk8UEzE23GCJMggnW3rTr9tTvrxA==
X-Received: by 2002:a17:90b:357:: with SMTP id fh23mr8796487pjb.140.1630080502650;
        Fri, 27 Aug 2021 09:08:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h9sm13930821pjg.9.2021.08.27.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 09:08:21 -0700 (PDT)
Date:   Fri, 27 Aug 2021 09:08:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Luca Coelho <luciano.coelho@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-crypto@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-can@vger.kernel.org,
        bpf@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/5] treewide: Replace open-coded flex arrays in unions
Message-ID: <202108270906.7C85982525@keescook>
References: <20210826050458.1540622-1-keescook@chromium.org>
 <20210826050458.1540622-3-keescook@chromium.org>
 <20210826062452.jekmoo43f4xu5jxk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826062452.jekmoo43f4xu5jxk@pengutronix.de>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 26, 2021 at 08:24:52AM +0200, Marc Kleine-Budde wrote:
> On 25.08.2021 22:04:55, Kees Cook wrote:
> > In support of enabling -Warray-bounds and -Wzero-length-bounds and
> > correctly handling run-time memcpy() bounds checking, replace all
> > open-coded flexible arrays (i.e. 0-element arrays) in unions with the
> > flex_array() helper macro.
> > 
> > This fixes warnings such as:
> > 
> > fs/hpfs/anode.c: In function 'hpfs_add_sector_to_btree':
> > fs/hpfs/anode.c:209:27: warning: array subscript 0 is outside the bounds of an interior zero-length array 'struct bplus_internal_node[0]' [-Wzero-length-bounds]
> >   209 |    anode->btree.u.internal[0].down = cpu_to_le32(a);
> >       |    ~~~~~~~~~~~~~~~~~~~~~~~^~~
> > In file included from fs/hpfs/hpfs_fn.h:26,
> >                  from fs/hpfs/anode.c:10:
> > fs/hpfs/hpfs.h:412:32: note: while referencing 'internal'
> >   412 |     struct bplus_internal_node internal[0]; /* (internal) 2-word entries giving
> >       |                                ^~~~~~~~
> > 
> > drivers/net/can/usb/etas_es58x/es58x_fd.c: In function 'es58x_fd_tx_can_msg':
> > drivers/net/can/usb/etas_es58x/es58x_fd.c:360:35: warning: array subscript 65535 is outside the bounds of an interior zero-length array 'u8[0]' {aka 'unsigned char[]'} [-Wzero-length-bounds]
> >   360 |  tx_can_msg = (typeof(tx_can_msg))&es58x_fd_urb_cmd->raw_msg[msg_len];
> >       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from drivers/net/can/usb/etas_es58x/es58x_core.h:22,
> >                  from drivers/net/can/usb/etas_es58x/es58x_fd.c:17:
> > drivers/net/can/usb/etas_es58x/es58x_fd.h:231:6: note: while referencing 'raw_msg'
> >   231 |   u8 raw_msg[0];
> >       |      ^~~~~~~
> > 
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Ayush Sawal <ayush.sawal@chelsio.com>
> > Cc: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
> > Cc: Rohit Maheshwari <rohitm@chelsio.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Stanislaw Gruszka <stf_xl@wp.pl>
> > Cc: Luca Coelho <luciano.coelho@intel.com>
> > Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> > Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Johannes Berg <johannes.berg@intel.com>
> > Cc: Mordechay Goodstein <mordechay.goodstein@intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Wolfgang Grandegger <wg@grandegger.com>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
> > Cc: linux-crypto@vger.kernel.org
> > Cc: ath10k@lists.infradead.org
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: linux-scsi@vger.kernel.org
> > Cc: linux-can@vger.kernel.org
> > Cc: bpf@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/net/can/usb/etas_es58x/es581_4.h          |  2 +-
> >  drivers/net/can/usb/etas_es58x/es58x_fd.h         |  2 +-
> 
> For the can drivers:
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Thanks!

> BTW: Is there opportunity for conversion, too?
> 
> | drivers/net/can/peak_canfd/peak_pciefd_main.c:146:32: warning: array of flexible structures

Oh, hrmpf. This isn't a sane use of flex arrays:


struct __packed pucan_rx_msg {
	...
	__le32	can_id;
	u8	d[];
};

struct pciefd_rx_dma {
        __le32 irq_status;
        __le32 sys_time_low;
        __le32 sys_time_high;
        struct pucan_rx_msg msg[];
} __packed __aligned(4);

I think that needs to be handled separately. How are you building to get
that warning, by the way? I haven't seen that in my builds...

-- 
Kees Cook
