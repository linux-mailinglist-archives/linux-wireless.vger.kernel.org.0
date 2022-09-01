Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB915A94B3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiIAKdU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiIAKdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 06:33:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C412206D;
        Thu,  1 Sep 2022 03:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF31C61CE6;
        Thu,  1 Sep 2022 10:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66689C433C1;
        Thu,  1 Sep 2022 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662028398;
        bh=BiuK04+CE8YoYewJRijQZYZ40574bNvs7fZjdplgJJI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SKHwIPNDOiB0UORbMxLK20HkTEJpVICgTJR7jYCwr+8xIf6qY7tcxGLtUtHBXz/iq
         0d22GeqWlfXoCsZwgKbbdX/kAzSrAzLSMvjFH1O4tJ/AtIMvocKMwn97Via5a8xk2i
         HEbz2VlkNzvqATaEOnjNz8Q8GANiA7ilxRRMNMLpjOCijczub97HWarGF7v0GDqnP+
         jwJQy5cppwJ/Uvn1dVwlkWxi+PZ2qltBOn0iSc6ZiM1R7JeOreXVh2SahOBLiQFsed
         0vMPtynh2ZUStUJfxZb3e5Iy96FO4DqLjCFaKKvYtjJm5RJ/2JMBjDj6P2da/0MfXJ
         01PkhG8rtuaVw==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wfx: prevent underflow in wfx_send_pds()
References: <Yv8eX7Xv2ubUOvW7@kili> <2729343.a3EqFhE7eK@pc-42>
        <87a67ndokl.fsf@kernel.org> <37769865.10thIPus4b@pc-42>
Date:   Thu, 01 Sep 2022 13:33:15 +0300
In-Reply-To: <37769865.10thIPus4b@pc-42> (=?utf-8?B?IkrDqXLDtG1l?=
 Pouiller"'s message of "Mon,
        29 Aug 2022 19:12:40 +0200")
Message-ID: <87r10ve650.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com> writes:

> On Monday 29 August 2022 18:03:38 CEST Kalle Valo wrote:
>> J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com> writes:
>>=20
>> > On Friday 19 August 2022 07:23:43 CEST Dan Carpenter wrote:
>> >> This does a "chunk_len - 4" subtraction later when it calls:
>> >>
>> >>         ret =3D wfx_hif_configuration(wdev, buf + 4, chunk_len - 4);
>> >>
>> >> so check for "chunk_len" is less than 4.
>> >
>> > This patch also ensures that buf[4] won't overflow during:
>> >
>> >     if (buf[4] !=3D '{' || buf[chunk_len - 1] !=3D '}')
>> >       dev_warn(wdev->dev, "PDS:%d: unexpected content\n", chunk_num);
>> >
>> >> Fixes: dcbecb497908 ("staging: wfx: allow new PDS format")
>> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> >
>> > Reviewed-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>>=20
>> BTW J=C3=A9r=C3=B4me, as you are the driver maintainer you can use Acked=
-by.
>
> Reviewed-by does not imply Acked-by?

Acked-by has "stronger" meaning and is meant to use by the maintainer of
the code in question. So anyone can use Reviewed-by but only the
maintainer should use Acked-by. My preference is that maintainers use
Acked-by as then I can easily see from my patchwork script that the
patch is ready to be applied.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when=
-to-use-acked-by-cc-and-co-developed-by

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
