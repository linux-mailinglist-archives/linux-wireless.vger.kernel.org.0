Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AC576BC70
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 20:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHAS2T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHAS2R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 14:28:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106282D73
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 11:27:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso22398025ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 01 Aug 2023 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690914466; x=1691519266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDSuwNr8b9yZ1uVIrm7o5L6KbFRnN74BMROL8ICVnYY=;
        b=R3Q7XRjtScPX/ZwfFhljIi3qshaFqqXVxfhet9LGtS/2pYUwpHRQ3j9Cai71xAJFuX
         gOIo2fgmorqOcJsilit6lemBuXm7TcDXMQwyKtxKVmtLvxuNPFE25nNhKbu5kjqpcoVE
         qyGgAnHbNfvh3SVZ2Fs3UGW3lfhb9zc74pli8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914466; x=1691519266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDSuwNr8b9yZ1uVIrm7o5L6KbFRnN74BMROL8ICVnYY=;
        b=jLdf2BKKyOemzsbXavlboFtvqLpGCx3JApxtdQlPd3/pfB/VMsJupXVQQzG5s1sIAy
         aCx7Ln6KCOt94jxmShwFto67pQQSBOafuUb0/bZhEjzXwqJf9PxEhPJxHUMZ+i+8CcX6
         5mgr3SKh3QgrpMaHMuJcnKAzJMnKtxkRwLI7GmcpqfV9FH+FcG1LIZyBLICBydn4h4+z
         w/UAXup7yoajn0R8+gMTL48VoMZ0ILKnkWJJVGCuvmgj2HsyaJNdvbORa05q8FOmBvQM
         AIDptNYMl6anzvDix3F9SAQ+iJZz/xqEBcxt9JZ54Pr+OS0FOamD6/CbIuqpWijSK/ea
         AhzQ==
X-Gm-Message-State: ABy/qLZaHSjGR/B/UQqzYtp5ULYQz2Fs7+TjHc4KaKRXJtk027xWba0B
        e7/b95y9f+cp13XjbvxoO23VoCfADtDjn7lHdEY=
X-Google-Smtp-Source: APBJJlGMl34qSDMAHUDubR3nacZLSE+pv3Q8YjV0vsu2eMSWztYaP3FzGVsGnCWWrDHR6snuWgeNEQ==
X-Received: by 2002:a17:902:d70c:b0:1bc:1b21:cbfb with SMTP id w12-20020a170902d70c00b001bc1b21cbfbmr4062242ply.58.1690914465988;
        Tue, 01 Aug 2023 11:27:45 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1c1f:af3f:7a1e:7fc2])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001b8c689060dsm10831632plw.28.2023.08.01.11.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 11:27:45 -0700 (PDT)
Date:   Tue, 1 Aug 2023 11:27:43 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: fix error recovery in PCIE buffer
 descriptor management
Message-ID: <ZMlOn7VqW2Ds30XO@google.com>
References: <20230731074334.56463-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731074334.56463-1-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 31, 2023 at 10:43:07AM +0300, Dmitry Antipov wrote:
> Add missing 'kfree_skb()' in 'mwifiex_init_rxq_ring()' and never do
> 'kfree(card->rxbd_ring_vbase)' because this area is DMAed and should
> be released with 'dma_free_coherent()'. The latter is performed in
> 'mwifiex_pcie_delete_rxbd_ring()', which is now called to recover
> from possible errors in 'mwifiex_pcie_create_rxbd_ring()'. Likewise
> for 'mwifiex_pcie_init_evt_ring()', 'kfree(card->evtbd_ring_vbase)'
> 'mwifiex_pcie_delete_evtbd_ring()' and 'mwifiex_pcie_create_rxbd_ring()'.
> 
> Fixes: 0732484b47b5 ("mwifiex: separate ring initialization and ring creation routines")

I'm not sure that's truly an appropriate "Fixes" target, as that commit
just shuffled the existing bad code around. I'd either remove that line,
or else also add:

Fixes: d930faee141b ("mwifiex: add support for Marvell pcie8766 chipset")

where the buggy stuff was first introduced.

I don't think you need to resubmit just for this; Kalle can usually make
small adjustments like this when applying. And even if not, the issue is
trivial.

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/marvell/mwifiex/pcie.c | 25 ++++++++++++++-------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Patch looks good, thanks:

Acked-by: Brian Norris <briannorris@chromium.org>
