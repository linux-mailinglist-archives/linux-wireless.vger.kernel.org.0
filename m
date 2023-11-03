Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EDC7E0A8F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Nov 2023 22:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjKCVFA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Nov 2023 17:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCVE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Nov 2023 17:04:59 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F3D55
        for <linux-wireless@vger.kernel.org>; Fri,  3 Nov 2023 14:04:54 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a92782615dso30337207b3.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Nov 2023 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699045454; x=1699650254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qy3OuAgfwsXLCV1yZj84+HeyH48ULIPhiiEV5yyrxBc=;
        b=BWsuEiPK2uEr1ARn5hipj2OlnvgPFXmYIjWGXmHOvpGIh1zqrjK/lBbJv1RQplEKeO
         H751J7QcY4PDl5sWWlEqin+RNQOd/Cl7b4vLmvYCDkYf/qkV3pUmp7sgPmqY7C4tmCcC
         +IsAEJIGWOzczWkTx19u1YMFOtoO6fqkEU4DpVk1thjQBYOp6+QR/Z75SxkQYhy+32N9
         vg/qUCXDyTPs+rAcztYJD/ly2zV/xtHO4+cPUi5M/nt2hFK5xjHz28ziOm6SiR9PeqQg
         FKWvHpp3MwVIOPAAyJnl8TW8F6B2KJUV5+80gUf5Qi3fdJ95TGRRvycFOGae+rwpLGL+
         It5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699045454; x=1699650254;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qy3OuAgfwsXLCV1yZj84+HeyH48ULIPhiiEV5yyrxBc=;
        b=J4d23d2+eBoGLTgbJy62Y8Pk+rvpyiyL09exfViV0DYAVCEjX/kEk9+cj1eJEylANB
         4ZIxF96q+nqLjq3Iwv41gEZsaFsrhA/c1+klkwza94+zf+SvXrlZojwgKWxhzHPm/HCH
         cV74vdB1Niv8eUVVQJJxlQ7PoWxOLHQ2WmJdx4e7R+rnKi2VaKirfJE/dGpBYs29bVu5
         gk5dnOCbId+imHLE65/fNw3/Nf4aUBGp2bWdNhwzUYPKE58UkkV7PKijACEhgSsEq9m6
         Ymj+x0zN7rCasRRnjbA3vbp3Kgi2vGQwze85KCZh94A3jMa4WHbha8WaVzL8kl8c13Ka
         ph1w==
X-Gm-Message-State: AOJu0Yy9XtsC2w+HHeSVlH3vPUKR3km8AGGv89wAR2iDinNLFzzL+Fb1
        KqJvrtennrg6jfNBaOS4Dw6E3/9VE6EMBvLljNM+NvBDyRZCyg==
X-Google-Smtp-Source: AGHT+IG7pmhgomWSmmFmD9JRHZPDEizOy9TQY/xZ5Bg0WcaJg6KBxR8mKNiRlJ6iRkA9HygoD6mlxtImRKog6uLifAU=
X-Received: by 2002:a81:6c49:0:b0:59f:773a:b14c with SMTP id
 h70-20020a816c49000000b0059f773ab14cmr4104495ywc.37.1699045454366; Fri, 03
 Nov 2023 14:04:14 -0700 (PDT)
MIME-Version: 1.0
From:   Diego Garcia del Rio <garci66@gmail.com>
Date:   Fri, 3 Nov 2023 18:04:03 -0300
Message-ID: <CAL4zwzyGT2YdMWU3iOpE6q8kd=TKb4=cSFZud_vPpoid2A-SSw@mail.gmail.com>
Subject: wireless-regdb: Update regulatory rules for Argentina (AR) on 6GHz
To:     linux-wireless@vger.kernel.org
Cc:     wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear wireless-regdb / linux-wireless list members,

Argentina approved, in may 2023, the use of the 6GHz band for indoor
use. The specific decree can be consulted here :
https://www.boletinoficial.gob.ar/detalleAviso/primera/287126/20230524
but the specific technical addendum can be read at the link "Anexo 1"
at the end of that document.

The main changes are that operation on the band  5925-7125 MHz is
allowed at an EIRP of 30dBm for APs and 24dBm for clients. The APs
must also follow a maximum Power Spectral Density 5dBm/MHz  and
clients must restrict themselves to -1 dBm/MHz EIRP PSD.

I wasn't sure how to express the PSD requirements in the txt file nor
how (or if its possible at all) to distinguish APs from clients.

The given PSD limits would mean 18dBm for an AP at 20MHz, and 3dBm for
each doubling in frequency, so a max of 27dBm for 160MHz APs)  while
for clients, it would be 12dBm for a 20MHz channel and again, 3dBm
plus for each doubling in channel width  (maximum of 21 dBm for a
160MHz channel).

I believe that basically copying the FCC restrictions for the 6GHz
band would probably be enough, but I was not 100% sure.

Thanks!
