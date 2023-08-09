Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D80776A0C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 22:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjHIUcy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 16:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjHIUcv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 16:32:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3535B2123
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 13:32:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so207932a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Aug 2023 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691613167; x=1692217967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbtGAppGkgkkcepdIWwjEf7iWCCTLoC4KdX3LkZb6Hk=;
        b=QwF6yfJJw+u9lU723E3kfvee/A3ez31/xIOxHs6dBY3mu3tmOAItCxGz9wqYq9RNwO
         HiawLiiaemIALEflV1d0kpS6JtVQYdyoCuFq/HbofCypNAEdkINxQUGS6WtTXDxh/GRU
         KnooJvE9a6IkZXUY/+IE/1w3YBf+NqovqUM1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613167; x=1692217967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbtGAppGkgkkcepdIWwjEf7iWCCTLoC4KdX3LkZb6Hk=;
        b=RDetIfX5GaAXae3NOw4RnPT9LSrsT1x7WT9+nZcvTXfLdNx5YqjGjRZ8ye1Gt0wsgU
         wA7qmQVm7kdn4dCCeJE25afne73SkSVRwId5Fbezr94KPHsQWiCQNDGC3xlcSXpr/csg
         23002umQbdbum4S6vIBSac4MioOqUYRk4dZM4ohE/5PNlPUlftqLYldGev2kNMURZdOF
         J7srdVOTjp31KrztzknHLhfWbc5kA9/ze2jMkqx+/GkZu3uwP8k1iAiXiB0bsUwZNb2I
         MUV5eGGt4H73xSNooWFs1DEiMMyV9W5CgfQnKXWG7Okf/8c8RXO+W0BqBnkrtNMFTvu4
         wyZA==
X-Gm-Message-State: AOJu0YxyLCeum6Zi6ARWK5lZMyaqT6tVEzTfQQhbv06b91HeI173Y+Ay
        u78Ns2ReN53mk78vyWttPGRXEw==
X-Google-Smtp-Source: AGHT+IHLlLUAzZw7E26xJCWEPQyi1lpGYJxVIHTNvTJn6qpA6YVnnBUiyo+59/aT02FevpBa1otQrw==
X-Received: by 2002:a17:90b:234f:b0:268:1e51:3496 with SMTP id ms15-20020a17090b234f00b002681e513496mr350579pjb.21.1691613167654;
        Wed, 09 Aug 2023 13:32:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6cbc:9b4c:cfc0:e406])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a019c00b002636dfcc6f5sm10063pjc.3.2023.08.09.13.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:32:47 -0700 (PDT)
Date:   Wed, 9 Aug 2023 13:32:45 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Matthew Wang <matthewmwang@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Bug in commit 119585281617 wifi: mwifiex: Fix OOB and integer
 underflow when rx packets
Message-ID: <ZNP37WfcNfCWB1yX@google.com>
References: <20230808084431.43548-1-dmantipov@yandex.ru>
 <ZNKhb2lgSmfEqqsW@google.com>
 <9ad63828-3c85-fcc4-a91d-58e1d16b60b7@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad63828-3c85-fcc4-a91d-58e1d16b60b7@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 09, 2023 at 12:35:37PM +0300, Dmitry Antipov wrote:
> And I have some doubts on 119585281617 ("wifi: mwifiex: Fix OOB and integer
> underflow when rx packets"). Looking through 'mwifiex_uap_queue_bridged_pkt()'
> again, it seems that 'return' is missing:
> 
> 	if (sizeof(*rx_pkt_hdr) +
> 	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
> 		mwifiex_dbg(adapter, ERROR,
> 			    "wrong rx packet offset: len=%d,rx_pkt_offset=%d\n",
> 			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
> 		priv->stats.rx_dropped++;
> 		dev_kfree_skb_any(skb);
>                /* HERE */
> 	}
> 
> 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> 
> because 'rx_pkt_hdr' points to 'skb->data' plus some offset (see above),
> so reading freed memory with 'memcmp()' causes an undefined behavior.
> And likewise for 'mwifiex_process_rx_packet()' (but not for
> 'mwifiex_process_uap_rx_packet()' where 'return 0' looks correct).

That's...completely unrelated to the post in question, so changing the
subject. But it's also an excellent (and terrible) catch.

Polars or Matthew, can you fix that up in a new patch ASAP?

CC Johannes, in case this patch is going places any time soon.

Brian
