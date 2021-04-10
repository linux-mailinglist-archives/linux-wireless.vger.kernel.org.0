Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA1135ACD9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Apr 2021 13:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhDJLPR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Apr 2021 07:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhDJLPQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Apr 2021 07:15:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2ACC061762
        for <linux-wireless@vger.kernel.org>; Sat, 10 Apr 2021 04:15:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so8064520wrr.2
        for <linux-wireless@vger.kernel.org>; Sat, 10 Apr 2021 04:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cw2t6eb8fvkQCAc0NfL2uriPlJtboYeLlRh7110sWZw=;
        b=vDVgHWTLXGlHpMruraeyopn1y/INc4iASB6LrkzXdJpwQIiW+1xa81D+mDChq5Wqkg
         TsBMEOvim2NDgdcg/9p73X92IXVUaJruI0CAORyu/cZc7QTpTzc8OrMeqc2Gey4rrPx1
         UtRxw2JlEJra2pDknlpqRyqbu20zPaDyUuQQu6VAcmCK5bj1jnDggeVOcjFmgYttXLKZ
         Bn7WG6+1i+hfWGA3Coh8KCa+gOD16M4uCzCbEo19uc8BMaI0DRLBnWXZdxvgTIlA+Es2
         SAeVZXjS0oPRnpKLvC0gWbhLdz0B9sZv+2reVaJcDKkE0DW/l3r7cAhcvNSXdtm9JAt/
         S4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cw2t6eb8fvkQCAc0NfL2uriPlJtboYeLlRh7110sWZw=;
        b=hOBonZpAj8652jC+pCCvG8X7/3p3ea+BgPIWw/z5rjHjlBnzXcEBQ+MLahuNGlBj//
         hCAqfh52crJnTgFdfCIXj2+3Y/edgEVDzlGvEd1Zb74ozeW/2m3rkTrti7k0rKI9mLS+
         JkfFZ4qzAJL7dDlaSO2t+tmPCg7IBsM0af6++Mkb1A1nHoh4Pz4NCu9qAbd0OMNNtPKv
         u1JVQ32Vl3ndj9peVtUpmpjl7TEdESK0dJjOo4B/NNleUeJ4xvcssFTCFRriDrd++8rz
         LihRRtwKrAiLYKkGHVI7RX6XbycnM4aZmrKvQW3sRwq+kOrwvcOtouKEHZZZrsXu11mL
         ARpg==
X-Gm-Message-State: AOAM5300sldydsDz7ChqQ69Xrfm8Hq+FRxx0yZWrGJ+QdaS2u8+jC3PK
        V9xTBb98D7L7NqBpFJUFx9/cXqGpTls=
X-Google-Smtp-Source: ABdhPJxgLTywqb/q7GtAanO+IfFTMq5YztUVEjQh10sFs/MLXIIfbWV5citjcx4M3LkU7p5NpYFXIg==
X-Received: by 2002:adf:e809:: with SMTP id o9mr10541402wrm.25.1618053301061;
        Sat, 10 Apr 2021 04:15:01 -0700 (PDT)
Received: from paula-ultrabook.fritz.box (dynamic-2a01-0c22-a41a-e200-35a1-ce2e-1cf4-ff60.c22.pool.telefonica.de. [2a01:c22:a41a:e200:35a1:ce2e:1cf4:ff60])
        by smtp.gmail.com with ESMTPSA id f12sm9439293wrr.61.2021.04.10.04.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:15:00 -0700 (PDT)
From:   Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
To:     johannes@sipsolutions.net
Cc:     benjamin.aschenbrenner@gmail.com, linux-wireless@vger.kernel.org
Subject: Re: Re: [PATCH 2/2] iw: fix ftm_request missing arguments segfault
Date:   Sat, 10 Apr 2021 13:14:51 +0200
Message-Id: <20210410111451.32563-1-benjamin.aschenbrenner@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <4f625f7cf6b8a325b128a71bf1805dd7e334cc6b.camel@sipsolutions.net>
References: <4f625f7cf6b8a325b128a71bf1805dd7e334cc6b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry I missed that. Will resend as v2.

Kind regards,
Benjamin
