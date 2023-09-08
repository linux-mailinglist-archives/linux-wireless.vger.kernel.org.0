Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3925E7985CB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbjIHKZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 06:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbjIHKZN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 06:25:13 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E7F1FC6
        for <linux-wireless@vger.kernel.org>; Fri,  8 Sep 2023 03:24:44 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-573429f5874so1049284eaf.0
        for <linux-wireless@vger.kernel.org>; Fri, 08 Sep 2023 03:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694168629; x=1694773429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DfAHPe/yZCXK6Ipx6KCp+2nRJ597fetZ8tOP8x/Y3eI=;
        b=RW7hdYqGQpjDkk3wX60XLgI92w6fqhyAw1bNRxHxw5FyMsCk2J+lGsjonR12jhoSqf
         RlAdCCf6zxYoWProgfHvAcYasA/IEV9FyY0vdYAUU/jaMfSYr5v11IDWf48fzZnze9ke
         MnLeFiFdd+QXLRwYnRwVV72mJ46oSqUm0eaLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694168629; x=1694773429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfAHPe/yZCXK6Ipx6KCp+2nRJ597fetZ8tOP8x/Y3eI=;
        b=By46TWkgKiwS6flWztLbweBCv6iWmVAZQ/ttSAJKDEHQ/C0oIvefmFzdH9z1ITf/x/
         g0hc8e/uM6dqXg9stRp8jGl2vCXh/uGX+L3Lr3Zsu1NSWl70YbQmVDB5zbTvupmSQfgh
         eZP94/N396qPKFJQ2tNPqAOCrHCdMIeYNFQhtIysC3qT5bZbEeL5+GMN8LykM64CE8Qr
         By2dSU9FjBb/9CNvDB2PVzuvy674ZIhWONrgykAnlN+AQQ5NeKWM6MK0S0+FgB6dwdVc
         CFXjUhKLDqxxO9lUGczzpsi0CFmjxXkmfDjeS5M7HIs6UH6R+eGK0ho9A63DKim340zg
         /QCQ==
X-Gm-Message-State: AOJu0YzAKXlB2hF9zq8lMUE1huCTC3bXQwYsW8HPl2seaXUNZIrwSTAQ
        vyi2PjCiYUJAMIVfnyQF/K3+hRLSiN1hXgppiG9oRA==
X-Google-Smtp-Source: AGHT+IEcsmWOaMN0sex/8VHBoGvhpIIwF11+aTivlfQzaWl3/Ih0CLNR8jF84J+DLODiKgcCnMCvalnsR/9BmpX0bTQ=
X-Received: by 2002:a05:6820:2296:b0:56e:a1d3:747e with SMTP id
 ck22-20020a056820229600b0056ea1d3747emr997434oob.6.1694168628939; Fri, 08 Sep
 2023 03:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230907093927.400634-1-treapking@chromium.org>
In-Reply-To: <20230907093927.400634-1-treapking@chromium.org>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Fri, 8 Sep 2023 12:23:38 +0200
Message-ID: <CABRiz0q9TjryfNs8m6czuExWRCpXiVYw0K7kW62r+jstBAm2Lw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> +       if (sizeof(rx_pkt_hdr) + rx_pkt_off <= skb->len &&

Not fixed. Did you accidentally resend the same patch?
