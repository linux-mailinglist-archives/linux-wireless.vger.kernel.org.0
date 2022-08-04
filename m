Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A258A1A5
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiHDUAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiHDUAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 16:00:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3969A6558
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 13:00:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r4so972866edi.8
        for <linux-wireless@vger.kernel.org>; Thu, 04 Aug 2022 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=RMf+U8t5fF9Cp8l7VCi6OIBjOa4i+CJEk11SiZqhKQWyWzTXiVPQHHQukV28iSm4ft
         HYevzuae4/8F9SgwWsToeSQUEgenwTu0j15F8Pybpqm/3wCQ+S0XgdPoDsbCCp3Lxg/j
         VTrtd1sRJ/ZKXRkEOG0vw33kjIw+pL69jwETuRJAEBGcXCenzuAqPkrs0m5P1NVT+szR
         DVbvpMjYxyihVUtWLSrSxUv3VrHqNce0+C9Sddxm/WraZkDqJpnF278avEspxzBHT7TA
         N3fR4Fne8/KI2DdBqJcnd3bymUD/kezwCrXXouXdMjiWC/HQI++3H9rLqeT5w3TFJKoJ
         FBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=FD5YI5v5H5pbKzre1FtDaHUMTlSC6jSNaVxLkOgFZGIQx7p5chs3c6T5armpwMr/Ma
         h1F/cGGAVBcF6EDVAYba1ZwacIm1+biNC1+bUURsO8utngFQFFXHJGyo6rkDeO+/DnuI
         b8HMZOa29hy+o3rh1TVHF7YX9rmU66ljdGPV4Sz3IAW9KkBnSYFICtMTk3PMfRNMkTHr
         fQ8WuJtebXmwTT86xLv5eDyOeNgMXm4sUSfY6FA5Y/vFXC342lmxdukwYq+50OyZRz9+
         am9n83d5NWqdp7yb8O6/XQV31gNBdlcqlURgvPyJqF9udnYw/EWh5WcLukhAR86kuSTz
         A5NA==
X-Gm-Message-State: ACgBeo0QPiQ6Qd+4eORMf+uaozXZjec8uWRhm1NHUtIfocK51RjBFoKY
        BNSeQ0qfY30i8vNEY9iqaVPJO1VT7CzV1bDRwaU=
X-Google-Smtp-Source: AA6agR4z15wYIrit8I4NOP3hsf068WWJbcYWhVWgjBWnu2WAdY7MIrk4TtKUQE9AwrTJMS1a2M1e9ssQgA0lGaKTIQE=
X-Received: by 2002:a05:6402:d05:b0:435:b2a6:94eb with SMTP id
 eb5-20020a0564020d0500b00435b2a694ebmr3555381edb.87.1659643214820; Thu, 04
 Aug 2022 13:00:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrs.mercykelvin1982@gmail.com
Sender: 553450897dy@gmail.com
Received: by 2002:a17:906:7d18:b0:72f:a2e7:487d with HTTP; Thu, 4 Aug 2022
 13:00:14 -0700 (PDT)
From:   Mercy Kelvin <mrs.mercykelvin1982@gmail.com>
Date:   Thu, 4 Aug 2022 20:00:14 +0000
X-Google-Sender-Auth: PVfCGMU2D2fX-M7O_5pnL7e4EMY
Message-ID: <CAMSAxkX3SWDcTxmpWi-9TRiU9aqVm2pt3tVyRq9vqQ7dCfM-sg@mail.gmail.com>
Subject: Se
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good afternoon!

Recently I have forwarded you a necessary documentation.

Have you already seen it?
