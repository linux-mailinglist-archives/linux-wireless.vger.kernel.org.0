Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6A64C8A4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbiLNMDI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 07:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiLNMCk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 07:02:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6C827143
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 04:01:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECAB8B818A5
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 12:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D5BC433F0;
        Wed, 14 Dec 2022 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671019310;
        bh=0xqfWBrK+AE0vSa5NV/a8hbMbqzYvsyfKzT5NUN5nuk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MvHd4l6Y462o8hVAXWWmwgqnesqJ3WnO0cNKVSzR1e1WLXqBxoRdSCfY6+JjXL0xe
         gpnBa/Axjf4sBnQYO8apLi10UrODpzo2F1vQYlMUsV16XTB4fcnWTBrepiXJhsUVHn
         BV8BRDENXujmm/qOWVn7t3ZM5zLX9fhwp9f+T2t1Rc+GO+V3RZA/mtm5um8rsFl2C/
         aFPlcd2fDrHawUHnzNw27XIEiDEvVjEX7JjvMgrMYNS/60ATbspD8AcmwyJg4hU9wV
         YRzHsR2wjVkaVzsEks/1h1sEfvTKFhmIlAOzXNA8v+iDClhv9vjwvTEdeef/GYMA7a
         ToOR6zVN+1NNA==
From:   Kalle Valo <kvalo@kernel.org>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        =?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>
Subject: Re: [PATCH] wifi: iwlwifi: fw: skip PPAG for JF
In-Reply-To: <20221213225723.2a43415d8990.I9ac210740a45b41f1b2e15274e1daf4284f2808a@changeid>
        (gregory greenman's message of "Tue, 13 Dec 2022 23:15:04 +0200")
References: <20221213225723.2a43415d8990.I9ac210740a45b41f1b2e15274e1daf4284f2808a@changeid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 14 Dec 2022 14:01:45 +0200
Message-ID: <878rja19ee.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

gregory.greenman@intel.com writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> For JF RFs we don't support PPAG, but many firmware
> images lie about it. Always skip support for JF to
> avoid firmware errors when sending the command.
>
> Reported-and-tested-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> Link: https://lore.kernel.org/linux-wireless/CACT4oufQsqHGp6bah2c4+jPn2wG=
1oZqY=3DUKa_TmPx=3DF6Lxng8Q@mail.gmail.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>
> This is a fix for a firmware assert. It can wait until the next RC of v6.=
2.

Ok, I'll take this to wireless tree.

> Kalle - should I send a pull request for it? Thanks!

For patches to the wireless tree I prefer that I take them directly.
What I recommend is to assign the patch to me on patchwork and add
"v6.2" to the subject like this:

[PATCH v6.2] wifi: iwlwifi: fw: skip PPAG for JF

That way I'll then apply it automatically. But this for future patches,
I have now assigned this patch to me.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
