Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4EB5B183A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiIHJSy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 05:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIHJSs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 05:18:48 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6290DD293A
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 02:18:45 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1662628723; bh=idX9htAOlhMB3K5vdodzlR2ovFnvxgJtSye+uG5Dlog=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SCw3997poR4wzziJwcAXbqCHPS9W6NIX7grDPj6pthtwKvcRoOA9dOV3vEbaEvzsY
         bxA46ma9c+yZBI+cXWeKGPE3IQBlOyFBjJUlkaI6X7rx3NDf38mwS7Oj+LaG233rnf
         nyRw7J2bkbcJkJAKlmW9TBvav8oWRLVl5ePbXNpGD8GWRWLImZqamTZhST72MZwM+m
         e21aE1AsyYdHUGuWtr/FNNSRQ9aiDdihmQ+PpLbMgWs+qZnms2Z9hV+vTSBA68AXSR
         0d33tYLfo2Kd/GkRjvoGAlbourxxg3d0QjFZuRKBeUy75QVnixAtw4fnhmgurVsPiK
         s0Q65dZ8R6K6A==
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ayala Beker <ayala.beker@intel.com>,
        linux-wireless@vger.kernel.org,
        Golan Ben Ami <golan.ben.ami@intel.com>
Subject: Re: [PATCH] iwlwifi: Mark IWLMEI as broken
In-Reply-To: <CANUX_P3NRqD2YWfkFri37F982QVaCASfyz2qaicGjc9wJ6mDYQ@mail.gmail.com>
References: <20220907134450.1183045-1-toke@toke.dk>
 <CANUX_P3NRqD2YWfkFri37F982QVaCASfyz2qaicGjc9wJ6mDYQ@mail.gmail.com>
Date:   Thu, 08 Sep 2022 11:18:43 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87illyxlzg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <egrumbach@gmail.com> writes:

> Hi,
>
>
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

Well, thanks for your efforts anyway :)

> We had tested against NetworkManager wpa_s, but not against iwd.
> From the start, we thought distro wouldn't enable this and this is why
> we disabled iwlmei by default.
> This driver is meant to be used by specific groups that need this and
> they'll know how to enable this
> driver even if it is marked as BROKEN.
>
> This is why, with a heavy heart:
> Acked-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Thanks!

> I'd also suggest to CC this to stable 5.17+

I expect the Fixes tag will be enough to get this pulled into stable,
but I'll try to keep an eye on it and submit it there manually if not...

> Thanks Toke and Sorry!

You're welcome :)

-Toke
