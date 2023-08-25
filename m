Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1447880B0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 09:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbjHYHMV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 03:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242712AbjHYHMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 03:12:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFEB1B2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 00:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E23660E5
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 07:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DA2C433C8;
        Fri, 25 Aug 2023 07:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692947533;
        bh=NOREAnHMH/tAAfpXF0vbsCRUdD3UAZG+zZuD5B0gBkg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XYQ9DUv6xsSp/cW/42ol0Ced7yo9Hjq6oE6Gsa29GZfJg9p+sroT8GH07hRQdQRpm
         dNebgqTbLcy2m5Ay0YBLO+F2b1IghGXgk16X0L/kVQufeRBb8C3mnGThuuEjRRQsj/
         4zOM7VHC62UXV6YSSjPwuRraDuds6iFn7JWy+2m7G0JUuN7wyE02eX8R0DnIOhSvHR
         5YCwLuCeoclqJgz3qD7egukmxPZp0YVRCzVu+/xJdEzn4P300vpu2tPrI4Nz5xo/p4
         urbTS4EIygmEhg4FC+SfBUNEkmt/2VcQ2nXAov0PLW24O52OpOeqhz4+vWG88oyrEe
         AGT6vEdFSxXsg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mwifiex: simplify PCIE DMA mapping management
References: <20230802161049.89326-1-dmantipov@yandex.ru>
        <169278633096.1133515.976396654998983133.kvalo@kernel.org>
        <CA+ASDXOTyRtMgNc47v=Qy28Y+grCh=xwL31qZM9YXVjkbwGC0Q@mail.gmail.com>
Date:   Fri, 25 Aug 2023 10:13:15 +0300
In-Reply-To: <CA+ASDXOTyRtMgNc47v=Qy28Y+grCh=xwL31qZM9YXVjkbwGC0Q@mail.gmail.com>
        (Brian Norris's message of "Wed, 23 Aug 2023 12:49:28 -0700")
Message-ID: <87jztjvblg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Wed, Aug 23, 2023 at 3:25=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wro=
te:
>>
>> Dmitry Antipov <dmantipov@yandex.ru> wrote:
>>
>> > Simplify PCIE DMA mapping management by eliminating extra copies
>> > of {address, size} pairs to/from temporary data structures. Map
>> > and unmap operations may use skb fields directly via introduced
>> > 'MWIFIEX_SKB_DMA_ADDR()' and 'MWIFIEX_SKB_DMA_SIZE()' macros.
>> >
>> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>>
>> I assume these patches are compile tested only so I'm very reluctant
>> take these.
>>
>> 2 patches set to Changes Requested.
>
> That's fair IMO. These kinds of patches put a much larger burden on
> the reviewer to make sure they make sense. Thus, I had this in a
> backlog to review, and haven't gotten around to it.

I'm looking at this from risk vs reward point of view. The risk is that
these cause regressions which is of course more work for us maintainers
but I'm not really seeing any concrete benefit from these patches.

> [1] Although, I don't think I have permission to change the Patchwork
> status, so it still might be lost to /dev/null without a RESEND.

I can change the status by request, not a problem. We could also setup
you admin access to patchwork.

BTW with ath9k patches we do so that patchwork first assigns the patches
automatically to Toke. Once Toke has reviewed the patches he either
drops of them or assigns them for me so I can commit them. At least from
my point of view that works really well, do let me know if you would
like to try something like that.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
