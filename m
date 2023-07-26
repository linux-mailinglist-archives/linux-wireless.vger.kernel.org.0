Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62C8763F72
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGZTWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 15:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGZTWk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 15:22:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3FC271B
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 12:22:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbc87ded50so939965ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690399359; x=1691004159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHNoA7m9GicaGGa7vYCwwPEzUoHD3BqRxI+RE52+Svk=;
        b=Eha09UWL24jKcvok2PsCqF7Ep/0Lo50o5lLRef1IazT+sIzjiWVExilAVggAkc6TGU
         rTEJVXomNsuUJ/Y8JCiRzx9pf58vgUI+egd/rWcRvS2fsXyI3c/CXIx5ygccJ8TwUHnX
         U8i+qrsl9BLIiyB3klkcDbS8v8h6JSM0pbsZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399359; x=1691004159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHNoA7m9GicaGGa7vYCwwPEzUoHD3BqRxI+RE52+Svk=;
        b=IcmeJB82nMXKcGaZaVTN9TOvCMo/N7h3umeUMFM2DSvxKEzjNP3sD3/hFUanvORZye
         u+bw2zUitsizf7p8SwWqt1TIV0Yxi2Ch2DBHGUE10k7vTJ8YfKVlXWUhWgce9kVVE3OM
         zzfYkV9n4muHPWhgvZ/RTZ2Xs/Vvady6x5GbmBeBZgo/K8qOFQogcD/bhA6RgpDMZA6z
         5yrYu2ZxyAr/WBH2vdBQmYD1CI5RkmK2HQds+KvTU3xP+lPA8Am6nNwHIErXakh/ttXz
         Zb7ztNKyssKxNLnDJIzNBezlW/GQZ2jm6/FuDaKh1N6UkWR9Xb6YojUHEOR86PoqgO4j
         flEg==
X-Gm-Message-State: ABy/qLb81IaZ4gouzU4+qhx5iACNCsV+KpVs+HhMH7oCRATqlXRDKSsn
        2DXkvTZed7t9GQDVau4CV0+sGLEV3BuQcFIaAlc=
X-Google-Smtp-Source: APBJJlE87ckY0ldzwwsMWTs4RhaYLR+ESFD4oC0vTG4nsYMeaQj1+npXDSKQPbpXqQ/9JF3acncatg==
X-Received: by 2002:a17:902:e5ce:b0:1b8:50a9:6869 with SMTP id u14-20020a170902e5ce00b001b850a96869mr3080804plf.66.1690399359302;
        Wed, 26 Jul 2023 12:22:39 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cf94:79ce:7d48:984a])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b80ed7b66fsm13523362plx.94.2023.07.26.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:22:38 -0700 (PDT)
Date:   Wed, 26 Jul 2023 12:22:36 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/5] wifi: mwifiex: drop BUG_ON() from TX error handling
Message-ID: <ZMFyfJrDa5jwI6Ep@google.com>
References: <20230726072114.51964-1-dmantipov@yandex.ru>
 <20230726072114.51964-2-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726072114.51964-2-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 26, 2023 at 10:20:53AM +0300, Dmitry Antipov wrote:
> Remove 'BUG_ON()' from 'mwifiex_process_sta_txpd()' and
> 'mwifiex_process_uap_txpd()'. In case of insufficient
> headrom, issue warning and return NULL, which should be
> gracefully handled in 'mwifiex_process_tx()'. Also mark
> error handling branches with 'unlikely()' and simplify
> error messages (there is no need to use formatted output
> to print the value which is known to be zero).
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

You already sent a version of this patch, and I already gave you
feedback:

https://lore.kernel.org/all/ZJ3lyIQy7GPbA9YL@google.com/

You didn't respond to or integrate that feedback.

Brian
