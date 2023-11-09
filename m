Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED17E68FC
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Nov 2023 11:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjKIK61 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 05:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjKIK60 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 05:58:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFAE2590
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 02:58:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D15BC433C8;
        Thu,  9 Nov 2023 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699527503;
        bh=oGmYZsalVj4BFO+8JW/HOn/kuPR1YMEeiaVcL2bmWgA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W1dwicFVlj0eLdMe87TeIRw37G6uXuNjQxD+qlimPNiOQgVQKbj8R6pSOVWH6T9Qt
         fMHTS3YOdNT6/ls8Cz4YybqMaz4GbVVLwa0M6JGDWGFJ6M85cKaZbiY+yMakJx4+/Q
         d0Jne9mmDtM4ytBTKerTmUo7qEGHXaJmVj5G1oC593vh0RRas2V5ZoF4+Xi2oKlszq
         xZ5xUuXV1aVfbYmLnH+ZHf9mYnjcUtCn4U35XbMSgW7WBPG1TvvhdjTjr5m6FBv4gi
         EaZgkUXAxmuvC7UKM1R3TbGUmu0ofzzCQ5z8fK5L4hUO0Gk6XowJoSMaiv1WfV/t2a
         JVFQsebgKD0Sw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Patrik =?utf-8?Q?V=C3=A1cal?= <patrik@vacal.dev>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: ipw2x00 driver user here
References: <8fc.6Krdh.6K7Yey8hySX.1bI}zv@seznam.cz>
Date:   Thu, 09 Nov 2023 12:58:20 +0200
In-Reply-To: <8fc.6Krdh.6K7Yey8hySX.1bI}zv@seznam.cz> ("Patrik =?utf-8?Q?V?=
 =?utf-8?Q?=C3=A1cal=22's?=
        message of "Wed, 08 Nov 2023 22:36:57 +0100 (CET)")
Message-ID: <87pm0j9os3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Patrik V=C3=A1cal <patrik@vacal.dev> writes:

> I've just read about removing old wireless drivers in new kernel versions.
> There was also discussion about the ipw2x00 drivers.
>
> Just wanna let you know that I still use my ThinkPad x41 with ipw2200. Pl=
ease don't remove the drivers from the kernel.
>
> Also in case you need to test if the drivers are working on this machine,=
 I can test it out.

Thanks for the report. We got several reports of people using ipw2x00,
which was quite a surprise for me, and I have dropped the patch removing
the driver:

https://patchwork.kernel.org/project/linux-wireless/patch/20231023131953.28=
76682-11-arnd@kernel.org/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
