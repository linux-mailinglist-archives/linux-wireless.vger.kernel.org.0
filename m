Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B5775685
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 11:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjHIJfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIJfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 05:35:44 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A0A1BFF
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 02:35:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:d315:0:640:bb64:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id 72A6A5F098;
        Wed,  9 Aug 2023 12:35:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bZVGJ3DWwCg0-fxSsnbFk;
        Wed, 09 Aug 2023 12:35:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1691573738;
        bh=M8qQL2hcl+E5dKE+in4KliIbDhYQxIJvQJB9jr51AC4=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=V/IdSzFp5vmxt/mDmtKmoReS/07tSO5VvSQVvvvZpJH2R9TKA1BnD8jvUczedReCW
         Z9YjjeVR6kibWYkOhreO4Bmdjl5Ldfp5sezXtL5E/wcocfGi5PEuq3epJBX+yRT6qg
         egtQD75unUD3afXQhgdHc1cuJWkxx65YzbvKDFuA=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <9ad63828-3c85-fcc4-a91d-58e1d16b60b7@yandex.ru>
Date:   Wed, 9 Aug 2023 12:35:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230808084431.43548-1-dmantipov@yandex.ru>
 <ZNKhb2lgSmfEqqsW@google.com>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: mwifiex: avoid possible NULL skb pointer
 dereference
In-Reply-To: <ZNKhb2lgSmfEqqsW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/8/23 23:11, Brian Norris wrote:

> This feels like it should be 'rx_dropped', since we're dropping it
> before we done any real "RX" (let alone getting to any forward/outbound
> operation). I doubt it makes a big difference overall, but it seems like
> the right thing to do.

This is somewhat confusing for me indeed. In 'mwifiex_uap_queue_bridged_pkt()',
both 'rx_dropped' and 'tx_dropped' may be incremented, for a different reasons
(unexpected skb layout and error (re)allocating new skb, respectively).

And I have some doubts on 119585281617 ("wifi: mwifiex: Fix OOB and integer
underflow when rx packets"). Looking through 'mwifiex_uap_queue_bridged_pkt()'
again, it seems that 'return' is missing:

	if (sizeof(*rx_pkt_hdr) +
	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
		mwifiex_dbg(adapter, ERROR,
			    "wrong rx packet offset: len=%d,rx_pkt_offset=%d\n",
			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
		priv->stats.rx_dropped++;
		dev_kfree_skb_any(skb);
                /* HERE */
	}

	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,

because 'rx_pkt_hdr' points to 'skb->data' plus some offset (see above),
so reading freed memory with 'memcmp()' causes an undefined behavior.
And likewise for 'mwifiex_process_rx_packet()' (but not for
'mwifiex_process_uap_rx_packet()' where 'return 0' looks correct).

Dmitry

