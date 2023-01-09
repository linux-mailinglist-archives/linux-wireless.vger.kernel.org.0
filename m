Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9655B662A8A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjAIPvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 10:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjAIPvT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 10:51:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285AF17062
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 07:51:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3925D61198
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 15:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0C4C433EF;
        Mon,  9 Jan 2023 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673279461;
        bh=uEMGZG9vJXq8a3kilCLSoEbgPSkOTZcFG7GjasXF6d4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eFEeNLYGbeDjAYYNWoJSf1mHO23oqz2PrTf+9wc+f1S367wbc1ZvHQWJbT5uA8fTy
         XvBx4M/Ow8TjFHOgs0nzYJTbxTAG0kUKrtHkqJ/W25fbiIXBhcbrD8YyXwCGu2X5R9
         PFGj4KVGgwO9XkyYqOco7kVyj7sDqy9Bk53dg/El27k+kaFp0IbkvCBNdfDUL6Czsd
         NrDQ9wkUKEEvT4ymC2wh/mH28am2pxE6IEADWvpZUm4B8oYEtinZyGOy6IEBb6sty9
         1sMwQxnWehF6a+ndrSCu4bPNhCFIwi+qoOYRMynCUtzOidrNPH6k+JSzwVFXnTGwgF
         wlv11XlLOdmmA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH for-6.2 3/3] wifi: brcmfmac: change cfg80211_set_channel() name and signature
References: <20230103124117.271988-1-arend.vanspriel@broadcom.com>
        <20230103124117.271988-4-arend.vanspriel@broadcom.com>
Date:   Mon, 09 Jan 2023 17:50:55 +0200
In-Reply-To: <20230103124117.271988-4-arend.vanspriel@broadcom.com> (Arend van
        Spriel's message of "Tue, 3 Jan 2023 13:41:17 +0100")
Message-ID: <87pmbnhfkw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> The function cfg80211_set_channel() is an static function in brcmfmac
> but the name is misleading. Hence rename it with 'brcmf' prefix. Also
> changing the parameters to avoid additional conversions.
>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

If I understood correctly this patch 3 is for wireless-next. So adding a
reminder for myself to _not_ take this to wireless tree :)

(I wish patchwork would have a support for offline notes so I would not
need to send emails like this)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
