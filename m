Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070295A50EE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiH2QDu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiH2QDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 12:03:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C37F10F;
        Mon, 29 Aug 2022 09:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66C49B81103;
        Mon, 29 Aug 2022 16:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BB3C433D6;
        Mon, 29 Aug 2022 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789024;
        bh=0AOW/zs6zHy61FY4GddWkzH7pYiahcVeqYaXS5onjsY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZsTSWJO+IcoP4tUURggvMAy0hJcILNceeFhiIsbyeNoEEF8AUOHP5YZBo4Tq9gigy
         f/kl17jX+MArnENqg1xaaGY9aqoFayW1IRIhJmMG/g7jNqPCETQzUApsVvKe0/Sbv5
         tbWh8ptYKD1/NlOO0+ILXbSDePqH8Fjsa1ue/6aXi0MiT/yNkSxLZ1hbFe1ek0K5tT
         Fs21iw5WFiXsGEuWnaZUEFgn4ayuQdm4UFqJ1mMIqlaV4r2bjHFCC9eYDJLaDYNbbw
         TqxBJGfvWCwsLfUj/GOUbC3FSauNXVdHrnBxBniaMaGJLUr8ltd1ojXZYdjoVA5yqu
         eQnXNxmiOU+jQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wfx: prevent underflow in wfx_send_pds()
References: <Yv8eX7Xv2ubUOvW7@kili> <2729343.a3EqFhE7eK@pc-42>
Date:   Mon, 29 Aug 2022 19:03:38 +0300
In-Reply-To: <2729343.a3EqFhE7eK@pc-42> (=?utf-8?B?IkrDqXLDtG1l?=
 Pouiller"'s message of "Mon,
        22 Aug 2022 14:20:53 +0200")
Message-ID: <87a67ndokl.fsf@kernel.org>
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

> On Friday 19 August 2022 07:23:43 CEST Dan Carpenter wrote:
>> This does a "chunk_len - 4" subtraction later when it calls:
>>=20
>>         ret =3D wfx_hif_configuration(wdev, buf + 4, chunk_len - 4);
>>=20
>> so check for "chunk_len" is less than 4.
>
> This patch also ensures that buf[4] won't overflow during:
>
>     if (buf[4] !=3D '{' || buf[chunk_len - 1] !=3D '}')
>     	dev_warn(wdev->dev, "PDS:%d: unexpected content\n", chunk_num);
>
>> Fixes: dcbecb497908 ("staging: wfx: allow new PDS format")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Reviewed-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

BTW J=C3=A9r=C3=B4me, as you are the driver maintainer you can use Acked-by.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
