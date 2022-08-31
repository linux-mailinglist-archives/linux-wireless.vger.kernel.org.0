Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4A55A80F3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiHaPLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 11:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHaPLH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 11:11:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD46D564CD
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 08:11:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D941B81F65
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 15:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3D9C433D6;
        Wed, 31 Aug 2022 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661958663;
        bh=BlxYiDR3jX6tI4gjVnJtLuJxPgZkllFInlymPyUXjT8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZwNQ0vD4aynrtMo7T3j9dP6y7QGkHqPwCYlMK7m9R2cd0VL3uNOtDH6y/oYUOLPT+
         w17nYNyIeZ3CRVBZNsx5iseasjUkGWxHSOsY4wBmJlMpWZAwKkmI3Ycb5gRLQwkNVF
         aC1GeETDS9fl+6hTIXWFkUq1We6G3kI1Q2fz7mO16AlV2jYHbo9OUBWAQLPda5QPhW
         H6QF1hsXzQRmAGhGAoWb51/Zc55Fwja4u/oTVDwBxcskbLMqjPY4ESBPCdxZe55knU
         6CpK2QvVyDb0mpGtI9xqLxMISO7TlpXRRyMs8QgNMDlkvK0bpEu9VVSvkzKkl2icwv
         KqUUmIZ9sWrig==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Jes.Sorensen@gmail.com
Subject: Re: [PATCH] wifi: rtl8xxxu: Fix skb misuse in TX queue selection
References: <59c7e9c6-9bf9-8287-9400-16244f769bf1@gmail.com>
Date:   Wed, 31 Aug 2022 18:11:00 +0300
In-Reply-To: <59c7e9c6-9bf9-8287-9400-16244f769bf1@gmail.com> (Bitterblue
        Smith's message of "Sat, 13 Aug 2022 22:54:10 +0300")
Message-ID: <87zgfke9dn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> rtl8xxxu_queue_select() selects the wrong TX queues because it's
> reading memory from the wrong address. It expects to find ieee80211_hdr
> at skb->data, but that's not the case after skb_push(). Move the call
> to rtl8xxxu_queue_select() before the call to skb_push().
>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

A Fixes tag would be nice.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
