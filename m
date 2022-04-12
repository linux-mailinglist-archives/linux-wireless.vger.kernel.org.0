Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9814FE27A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356120AbiDLN3h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiDLN3X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 09:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A1D7;
        Tue, 12 Apr 2022 06:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F46619D7;
        Tue, 12 Apr 2022 13:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9577EC385A1;
        Tue, 12 Apr 2022 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649770024;
        bh=4SRMm+oi+OXE5VmvCpvFhkMlZkhqhIVBfNpql/7kyPQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qWV+Lea1tXQSYUwgAZtZ4pFi645XWEi86YDrMS5snj9TX+F+EB71mhkf6z+nkVQJC
         pOFfIIwNE6tbqP0AaW10xIYlFU2dMzdNbED/siTYxuiUe+9uYD1wZXB054SuoKew7x
         J3CtwsI6+cA9Lwk567ss31520Qs02GSKDHEfO0VgnH+2s4h0yb4tuZWhVniTKsAi+w
         G9BwMQj/ECIY1rGwnGy5SbQQ+vxCNu+VhmwBcuRaHTehE09xPQi+WivOB9/c7gaXvn
         PtyP3Ljv3pxOkmhMUz7/JxdCYskS9h2bkuddyZ+qB1oV4uIzscVkcYZqjKSL3nuy5/
         nEdeJizXLDpxg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ath9k_htc: fix potential out of bounds access with invalid rxstatus->rs_keyix
References: <20220409061225.GA5447@kili> <87tub26ir2.fsf@toke.dk>
Date:   Tue, 12 Apr 2022 16:26:58 +0300
In-Reply-To: <87tub26ir2.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Sat, 09 Apr 2022 23:37:21 +0200")
Message-ID: <875yneo2jh.fsf@kernel.org>
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

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Dan Carpenter <dan.carpenter@oracle.com> writes:
>
>> The "rxstatus->rs_keyix" eventually gets passed to test_bit() so we need=
 to
>> ensure that it is within than bitmap.
>
> s/than/the/ ?
>
> This I think Kalle can fix up when applying :)

Yup, fixed now in the pending branch.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
