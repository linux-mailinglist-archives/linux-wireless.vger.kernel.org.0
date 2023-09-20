Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFEB7A8FC7
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 01:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjITXPJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 19:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjITXPJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 19:15:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA4EC1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 16:15:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf1935f6c2so1860655ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695251703; x=1695856503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4O+a49wANz5JW2SXRQFiJWKtfetonYCX4XgQOEDgVJQ=;
        b=oRY58HaALlbgCY2B0InvxkpXVl/x+VuniykytOkt2v3Qskel0JglIYzJ5L7RK+1iOp
         k5U4ZO48be1VVlIJNFtb2CcWrWo8dhoj3TmeCOHGWlYceWNGMM2GagM3YYcrFHPs+Pnd
         tRp6oZRbD6j1qM8OUGonZ53oLaZFD7Nuumk24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695251703; x=1695856503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O+a49wANz5JW2SXRQFiJWKtfetonYCX4XgQOEDgVJQ=;
        b=nJs+0EdzeN4CgPQ+0kL/AlsNV7dy7gCE6sXYUsGnmlyq8KTEKMPBeGEMhJyj03Brne
         maYWPdcaBW2WkwZoAZS3lrLvKG73cUFvCUZLu/FoiWHIb6+1ET/wYodKw0kPubMHEwUb
         AWZGSfIWcyR3UuBnlLIZYaJ8iGbuMN4WDNGzhIWaeS66ABejvi5IPqiFKAKtro6tZ4pj
         0p6m2cmNGLgJY553gAiDSa9wCFkPKQB6LjgCmxZEsCmhUf/PX4tu3huzpg8/ClfN15Ao
         0OaekIqpUg1p9Pqy0Uei1ItO8hFJY+VnRO9zhjbBEPKY6K/r6+5ijJK4CkaZ3rnESvoR
         ao0w==
X-Gm-Message-State: AOJu0YyxVtZu85AHLCeqB6ZpiDKYJixO+ouYHB+y3ZnbLwBVFyPHsfou
        S/2Vqhm4r28p6gmcCENS/1DImi3RHO2byPfOOZDrag==
X-Google-Smtp-Source: AGHT+IGIf8VTDVJrnQE3o4GcHReUUwSVbnGMBMqy/RDzrJFa3uSd4fLk7IIvghtdc/0HCyKrnqBbXw==
X-Received: by 2002:a17:902:e881:b0:1c4:314a:d045 with SMTP id w1-20020a170902e88100b001c4314ad045mr10127015plg.14.1695251702830;
        Wed, 20 Sep 2023 16:15:02 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:23d5:c394:2c98:ffcf])
        by smtp.gmail.com with UTF8SMTPSA id z6-20020a1709027e8600b001c322a41188sm50796pla.117.2023.09.20.16.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 16:15:02 -0700 (PDT)
Date:   Wed, 20 Sep 2023 16:15:00 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: mwifiex: fix SDIO firmware dump wait
Message-ID: <ZQt89BPMN6Fg3H6z@google.com>
References: <20230920112259.18656-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920112259.18656-1-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 20, 2023 at 02:22:32PM +0300, Dmitry Antipov wrote:
> In 'mwifiex_sdio_generic_fw_dump()', move (presumably placed
> by mistake) 'if (tries == MAX_POLL_TRIES)' check to an outer
> waiting loop.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Have you tested this patch? You've certainly caught a logic bug, but
that doesn't mean the seemingly obvious solution actually works.

(Disclaimer: I haven't tested it.)
