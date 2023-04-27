Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375816F0B5B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243876AbjD0RsC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbjD0RsA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 13:48:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BFB4EFE
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 10:47:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2496863c2c7so7394298a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682617650; x=1685209650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AowLft9EBX5gUxctKSIUsNiudl4F28FeVro2d7oaOEM=;
        b=K4EdX966gif7u1ukpy0llJYHxfFkYWdfFwMYcKVy6usRHt/PkkR2YDimen8qEqOwE8
         fGzRXODQ5CUo/tjE5+XIHaBeRBSqAYhjo9uObcaIaNjCodLXxRbWT9aG3cBAoPuBk5OL
         mNdKOFueqrBJqJbPEXDVDz55E7hKGLTusoanE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617650; x=1685209650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AowLft9EBX5gUxctKSIUsNiudl4F28FeVro2d7oaOEM=;
        b=MYlBGyxzfIYrxtSGivq+2SAez52o1A91hIxMbgOwkU00cbBu8V9kwbnwceWsHjGiRK
         pOXjVjXxP81p3U4Dl5JVq4qyiAq/QC3eZZPF9F97wX2VPvcd2+MgE5VKHyS7UWYiTMWr
         aNzarAdAEgI2SMOnuhulsLadcTliEct9hKrZU2Ga5zg4BzDSj2yamb6SQCNlOxpCbwec
         V2sYB3pm2tcd3tSZD820yQh7p9salgDBiGS+PA0EJvrpbcyfdEdkRDdoTTr9V9dym8FH
         LhGoZsFE+vsQAWT+L/VQlJgTPfB5A8zOeW9w42ZkyFLhC0gucuWlOZKNlf18mObGudZs
         /hGg==
X-Gm-Message-State: AC+VfDwqSvZ7+42iKK+u/ghQuZyVomMsv8o0et75UmUQwTZRUzSiX1fV
        qP1I/CafA9xfaMvI1lMIiznUFw==
X-Google-Smtp-Source: ACHHUZ7oDO17oEmp71hXDgibg5WFVW2Jl6Z+LeyB/FPq2+qXtjm2demldilHFox1tX28JgToNRGZYA==
X-Received: by 2002:a17:90b:3e82:b0:246:c223:14ab with SMTP id rj2-20020a17090b3e8200b00246c22314abmr2645491pjb.41.1682617650051;
        Thu, 27 Apr 2023 10:47:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:17bc:8fd4:f9e:3e41])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0023d0290afbdsm13597610pjb.4.2023.04.27.10.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:47:29 -0700 (PDT)
Date:   Thu, 27 Apr 2023 10:47:27 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] wifi: mwifiex: Use list_count_nodes()
Message-ID: <ZEq1L4LAXvY6yXbw@google.com>
References: <e77ed7f719787cb8836a93b6a6972f4147e40bc6.1682537509.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e77ed7f719787cb8836a93b6a6972f4147e40bc6.1682537509.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 26, 2023 at 09:32:36PM +0200, Christophe JAILLET wrote:
> mwifiex_wmm_list_len() is the same as list_count_nodes(), so use the latter
> instead of hand writing it.
> 
> Turn 'ba_stream_num' and 'ba_stream_max' in size_t to keep the same type
> as what is returned by list_count_nodes().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/wireless/marvell/mwifiex/11n.h |  4 ++--
>  drivers/net/wireless/marvell/mwifiex/wmm.h | 15 ---------------
>  2 files changed, 2 insertions(+), 17 deletions(-)

FWIW:

Reviewed-by: Brian Norris <briannorris@chromium.org>
