Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F8774AB7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjHHUd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 16:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjHHUdg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 16:33:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CCE1B320
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 12:58:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc6535027aso25435845ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Aug 2023 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691524693; x=1692129493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xswoMLpcFoDTReNDe+HwH8oM5DQUMUC8+U79Zzosbf8=;
        b=GhvaRN9JoattUmbHokJ5Uz196iXQ5Xzg13QWi4JBIc/H77Q83JpHVCItq+jH1aE2fL
         euCUUhvVD+L2FSfr3XT7fAT0Ni/cUqjNW513Y6K0ESIxc5+y/ljMLbmPGJjjvMQUbhak
         pWkhZIM760TwI4LkFh5n7EVZSRDNVTCEXsW0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691524693; x=1692129493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xswoMLpcFoDTReNDe+HwH8oM5DQUMUC8+U79Zzosbf8=;
        b=JHeDsdN4NR1B65bpEi4hJzsFH1vuIkcRmayU2HowNlOm8Vguu/vZrOQdWUG3kRMN2O
         zUteL4wMEiqwk1tmR8/9VB7tUK2IFLfNmQ4zujyDjZHFYeVRUuTxKerBpozgeaPxRnKG
         OoeQx4Yt/Nid0I+JyNltoJUs8nzftvEodwSQ4uRykuVdlfbAOVbgDY9iID3k1UdKHdVa
         Va90h5ri9YS/8KJ55QWay7WJDqkE3GA8idzKR6kj6HjsS6PYymJt+pGm8reegjO3pWU3
         yafJmWUxy034OWR0P9x2YjwuU9/dGyJ+wk3YzyyxFrl/ftdZQ6DdTJZtDNgHtQ9cWevV
         x1fA==
X-Gm-Message-State: AOJu0YyEelYjL+LzgqF6YW3ed6ZSkFyzFTL8d9OWhxxe/0brU54OY5Bd
        kyUuNuscw+9qPkjNmwIWmRaMw6rBkCf/71R7ebg=
X-Google-Smtp-Source: AGHT+IHDzUXYIxBNPaaCARpuoUI/sn1yXaKimrtNyLgSjd9xIPluKRLxuPJt94Y7Kfe1p+kx1/bT7A==
X-Received: by 2002:a17:902:e545:b0:1bc:73bf:303b with SMTP id n5-20020a170902e54500b001bc73bf303bmr784178plf.33.1691524693060;
        Tue, 08 Aug 2023 12:58:13 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:800e:831a:c5f6:2dd0])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b001bb97e51ab4sm7255191plc.98.2023.08.08.12.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:58:12 -0700 (PDT)
Date:   Tue, 8 Aug 2023 12:58:10 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 5/5] [v3] wifi: mwifiex: drop BUG_ON from TX paths
Message-ID: <ZNKeUpjZT13uWkgj@google.com>
References: <ZMlHCmjf2ZovExsP@google.com>
 <20230802160726.85545-1-dmantipov@yandex.ru>
 <20230802160726.85545-5-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802160726.85545-5-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 02, 2023 at 07:07:19PM +0300, Dmitry Antipov wrote:
> In 'mwifiex_process_sta_txpd()' and 'mwifiex_process_uap_txpd()',
> replace 'BUG_ON()' with runtime check, and move all these checks
> to 'mwifiex_process_tx()'. This way, both callees may be converted
> to 'void', and the caller may be simplified as well.
> 
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v3: drop some overengineered bits, fix a few nits reported by
> checkpatch.pl, and reorder series by making this patch the last
> one, thus hopefully simplify the landing

Thanks, I think this version is pretty clear, concise, and an overall
improvement.

For the whole series (though you rightly carried my Acked-by on the
others already):

Acked-by: Brian Norris <briannorris@chromium.org>
