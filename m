Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604AE6A7B41
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 07:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCBGP6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Mar 2023 01:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCBGP5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Mar 2023 01:15:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7924323D96
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 22:15:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 050056153D
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 06:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADA0C433EF;
        Thu,  2 Mar 2023 06:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677737755;
        bh=gj9DUV7zv5VEvJ6WHVaoqujiN65v86EupFQIcl1U2MM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=piiXjKVbajJCIl5VC8EQlnElAPxc4RYUyuyFJKY5uqszU7YMGSAIF4N9Y9Al3fvsg
         AG7hM0sreHCiibFIl97qv0C61F4sXEI91vRyQy1CNWEltUVI22JzZQ5C5QdDfc2KaP
         N/zy8CgN9U9vFItXZfpUmPQ6LvqWP3b48cS6U1qVv/FxAUTDmB0Ql8PIhP6KYj+J9c
         AM0BXxuUi1lWIk679UWEmL+JJL59fPWAryAP0zcRG5/54U9zvOnTrqTbatPOx5GZ7y
         ilzKsAhVSMs3Q/GdaU2QTRnzFLo1dJ9swSiWaNIqBwhQjcsQA9l2c0+NiwDrl2M4R/
         6GPUI1IpZfEtA==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?Q?St=C3=A9phane?= Klein <hello@sklein.xyz>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: ath11k_pci 0000:01:00.0: failed to resume hif during resume: -5 after hibernaton resume on Thinkpad T14s Gen 3 AMD
References: <3ae33154-126c-42b8-a3cb-eeaa63c7a6f7@app.fastmail.com>
Date:   Thu, 02 Mar 2023 08:15:52 +0200
In-Reply-To: <3ae33154-126c-42b8-a3cb-eeaa63c7a6f7@app.fastmail.com>
        (=?utf-8?Q?=22St=C3=A9phane?= Klein"'s message of "Wed, 01 Mar 2023
 19:05:39 +0100")
Message-ID: <87sfenznjb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ ath11k

St=C3=A9phane Klein <hello@sklein.xyz> writes:

> I try to configure hibernation on Thinkpad T14s Gen 3 AMD. See full
> context here:
> https://gist.github.com/eloylp/b0d64d3c947dbfb23d13864e0c051c67?permalink=
_comment_id=3D4474569#gistcomment-4474569
>
> I see this error in my dmesg:
>
> [  210.043130] ath11k_pci 0000:01:00.0: failed to resume mhi: -5
> [  210.043134] ath11k_pci 0000:01:00.0: failed to resume hif during resum=
e: -5
> [  210.043136] ath11k_pci 0000:01:00.0: failed to resume core: -5
> [  210.043138] ath11k_pci 0000:01:00.0: PM: dpm_run_callback(): pci_pm_re=
store+0x0/0xe0 returns -5
> [  210.043158] ath11k_pci 0000:01:00.0: PM: failed to restore async: erro=
r -5
> [  213.050611] ath11k_pci 0000:01:00.0: wmi command 16387 timeout
> [  213.050624] ath11k_pci 0000:01:00.0: failed to send WMI_PDEV_SET_PARAM=
 cmd
> [  213.050632] ath11k_pci 0000:01:00.0: failed to enable dynamic bw: -11
>
> More information on these comments:
>
> - https://gist.github.com/eloylp/b0d64d3c947dbfb23d13864e0c051c67?permali=
nk_comment_id=3D4488325#gistcomment-4488325
> https://gist.github.com/eloylp/b0d64d3c947dbfb23d13864e0c051c67?permalink=
_comment_id=3D4488341#gistcomment-4488341
>
> Do you think it is a hardware bug, a bios bug or a driver bug?
> Or did I configure something wrong?

ath11k is broken and doesn't work in hibernation mode, we have a bug
about that:

https://bugzilla.kernel.org/show_bug.cgi?id=3D214649

Adding the ath11k list, please send all ath11k questions there.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
