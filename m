Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C968B742DC6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjF2Tua (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjF2Tu0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 15:50:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B503210E
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 12:50:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7e66ff65fso8960055ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688068225; x=1690660225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yj5xEFPwmeqQKsNwFssN9UsbLjraO5Z0rLMbfS3paIg=;
        b=KuBvbxPcgkAFaA+RMSk0F2vqTSILuzyWl1gf8qRzY77+in3AHTE9HdhWw2KUd5s+OG
         Pl+9EXKy6RRLfrZ6rbTDofw0lObDShYQCDwf9E0pQ4SNGcLeOduKFoMZ+z1rvO7uUnTx
         u7JnIvxh3KoNKU2MbuFsSXbvs3uLSga7MUlRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068225; x=1690660225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yj5xEFPwmeqQKsNwFssN9UsbLjraO5Z0rLMbfS3paIg=;
        b=PB971D4HUp5qgLj3JhGLBhc0OXZZYswlRoEV2xDA9Wh029PejCj6XMiH1SNqrH0C/w
         1cBycX/+SXYemsFcCfesLfZGE3E8rtkChjC433zw4wucpcCaVsPz5Zk5P1frl5JMcvCZ
         mrDdsPeE/2vKUIMb+JZga+e2jkz7EKT18t/+d0n4QdweBkaCg4DawGuTqkAZi3OIJcPR
         PWN4z/oUkakrIIGh0rngdCFnxrvhubjrC3bCm/1kymnsCI0a8PoImhOcomueblOo3G1r
         w8qWxW6zWJ5x3utqduhQMZ4oaR08NznEBF0fq064/0xhalHVC2FxvJYqnH1MIGGraVN9
         UGLA==
X-Gm-Message-State: ABy/qLZ0xOpFF8YiL7juG8muabWULr+FB0iZj5DAARCplztUbCb4jx7I
        6k90v5CC5KnBjRjmyDRVZLyXpQ==
X-Google-Smtp-Source: APBJJlHP9PZofLFIMvLE+BkXRkIz15OknLgdNS0patr3+fPhtRoATppo8U9RYvCnHHt0KzY3qfq8tg==
X-Received: by 2002:a17:902:d4d1:b0:1b7:ed16:c804 with SMTP id o17-20020a170902d4d100b001b7ed16c804mr175673plg.27.1688068224972;
        Thu, 29 Jun 2023 12:50:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3c2b:cbff:22ae:80d6])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001b53d3d911dsm5161073pls.69.2023.06.29.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:50:24 -0700 (PDT)
Date:   Thu, 29 Jun 2023 12:50:22 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] [v4] wifi: mwifiex: prefer strscpy() over strlcpy()
Message-ID: <ZJ3gfhyBNgx0pImm@google.com>
References: <20230629085115.180499-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629085115.180499-1-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 29, 2023 at 11:51:00AM +0300, Dmitry Antipov wrote:
> Prefer 'strscpy()' over 'strlcpy()' in 'mwifiex_init_hw_fw()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v4: simplify to drop strlcpy() only (Brian Norris)

Reviewed-by: Brian Norris <briannorris@chromium.org>
