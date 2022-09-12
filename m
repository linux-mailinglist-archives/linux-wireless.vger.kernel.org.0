Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2BB5B5931
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiILLTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiILLTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5ADF1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C077611B6
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0719C433C1;
        Mon, 12 Sep 2022 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662981570;
        bh=aDD2lGzC7nGySE3Qy89VDEyR24XirHHe0seDLsnVq3A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fA6URyx4m31/ZFj1PUZSkfm9xdHr6cUCrTtOmrV76oZj80aUSmkKUAASyYJMGT2+T
         EszchF3x3xyhUjTn1Yzhz40n04Z9bW3uYZ+n1op+mNQU+Q81h+6CEjX/vlSBAWtnIF
         zJPiE9R6lUxGSZHrwpE2pMPzihv98VLWXbRUyK9YfyxWyl22k8Gf9YU+MDRaqM6284
         E68Ik2k7LQAxBPgbr2ui0cQHb53SeCtuQF4+pism3Qr67VVspYIJLTcN1Ul6UPKpvg
         EtJl9dEdfOwrPh5kSW0GeUj9Oi2TjbPOtx7t0LZnSh7Vfi8Pm6y55+GgcLp6Uh38G0
         rI9U07ckct3rw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>,
        linux-wireless@vger.kernel.org,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgen?= =?utf-8?Q?sen?= 
        <toke@redhat.com>, Golan Ben Ami <golan.ben.ami@intel.com>
Subject: Re: [PATCH] iwlwifi: Mark IWLMEI as broken
References: <20220907134450.1183045-1-toke@toke.dk>
        <CANUX_P3NRqD2YWfkFri37F982QVaCASfyz2qaicGjc9wJ6mDYQ@mail.gmail.com>
Date:   Mon, 12 Sep 2022 14:19:24 +0300
In-Reply-To: <CANUX_P3NRqD2YWfkFri37F982QVaCASfyz2qaicGjc9wJ6mDYQ@mail.gmail.com>
        (Emmanuel Grumbach's message of "Thu, 8 Sep 2022 11:27:41 +0300")
Message-ID: <871qsg96wz.fsf@kernel.org>
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

Emmanuel Grumbach <egrumbach@gmail.com> writes:

> On Wed, Sep 7, 2022 at 5:02 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@tok=
e.dk> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> The iwlmei driver breaks iwlwifi when returning from suspend; the bug
>> report[0] has been open for four months now, and now fix seems to be
>> forthcoming. Since just disabling the iwlmei driver works as a workaroun=
d,
>> let's mark the config option as broken until it can be fixed properly.
>>
>> [0] https://bugzilla.kernel.org/show_bug.cgi?id=3D215937
>>
>> Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation =
with CSME")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> I am not very proud of this, to say the least, but unfortunately,
> despite Toke's patience and
> his willingness to provide logs and all, I couldn't find the time to fix =
this.
> We had tested against NetworkManager wpa_s, but not against iwd.

> From the start, we thought distro wouldn't enable this and this is why
> we disabled iwlmei by default.

I'm always saying that a Kconfig option is not a "free pass" for
anything, some people will enable Kconfig options which they don't
understand and they must not break existing features.

> This driver is meant to be used by specific groups that need this and
> they'll know how to enable this driver even if it is marked as BROKEN.

This is just a temporary solution to workaround the regression. But we
cannot have broken code forever, so I hope this is properly fixed soon
so that the workaround can be removed.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
