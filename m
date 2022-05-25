Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A217253455A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 May 2022 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiEYUxd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 16:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEYUxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 16:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AEB90CC8
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 13:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16AE561A34
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 20:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22982C385B8;
        Wed, 25 May 2022 20:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653512008;
        bh=smssZ+GIcbjJTVUm8nsNU6CGFkBZ+qMqxtzUrcjaJpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N39Y9+rq8LBDT2gQ24MkcIAUfs2p+ZPjt99nUUzo4cw5S2Yl9d7FvPGvRJ3WNU98N
         aM4DP/rpNqznFKPdoQtn+1ZkHuuG8OBDtakmFD5MX54zIte3Rx25RF/rb2B5W829K4
         /nJvzCwxwYZiwwxKCtVPTSmBnQVXYLVDYIEB/wRQVhsVQaVQ+bUN2zSnaJaTI3mU/M
         cUYdT3xXvFycATIT+2kXZiMV7v+9PwBiQUL5vk3qo0DppDXextxMPhjaUVKS8OEhrn
         IZ0iQcIjPCTOTvGAAAMjMZzCxxpjIjTcH+iH1gEEt9+mTbNzd0MMq/SexzglD8gE6w
         qKE9nf+2UYzNA==
Date:   Wed, 25 May 2022 13:53:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: libertas: use variable-size data in assoc
 req/resp cmd
Message-ID: <20220525135326.1da8fe36@kernel.org>
In-Reply-To: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
References: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 23 May 2022 18:02:01 +0200 Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> The firmware has a 512 limit here, but we use less, so gcc
> starts complaining about it:
>=20
> drivers/net/wireless/marvell/libertas/cfg.c:1198:63: warning: array subsc=
ript =E2=80=98struct cmd_ds_802_11_associate_response[0]=E2=80=99 is partly=
 outside array bounds of =E2=80=98unsigned char[203]=E2=80=99 [-Warray-boun=
ds]
>  1198 |                       "aid 0x%04x\n", status, le16_to_cpu(resp->s=
tatuscode),
>       |                                                               ^~
>=20
> Since we size the command and response buffer per our needs
> and not per the firmware maximum, change to a variable size
> data array and put the 512 only into a comment.
>=20
> In the end, that's actually what the code always wanted, and
> it simplifies the code that used to subtract the fixed size
> buffer size in two places.
>=20
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Is there a chance to get this into net before the merge window is over?
