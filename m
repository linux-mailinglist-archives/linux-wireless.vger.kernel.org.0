Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9160449C2E9
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 06:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiAZFFV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jan 2022 00:05:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57388 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiAZFFT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jan 2022 00:05:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A89C617C4
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jan 2022 05:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBFFC340E3;
        Wed, 26 Jan 2022 05:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643173518;
        bh=VYoezu2J2YP3nqOXvi05h2P4iBQgTGVeolBPBK/z7BE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SPhguLPWOPyKLmQstPMd6FWcqp43vAMsM9HyrHNjedNCJG0SUyLrkg4m5/8jlWlL1
         ylUhJh3ylH7jZPPrXnG3OH7HdVhVAqbe1VB6bOduf00Jw6m3AJ7mxadGUbI5q7bsee
         zAdiljSuLmQ8lZXVes1hcjJAYtTppRtROVNes9pcLbci0H3gvIb4fknRFXkT/Y9lc3
         lBhOPVau6UfeMvMIcdzvn0cH1FZ9mY8A8QjL8DMGW96g5AwPBmoN2xoRu3x2o3M28h
         sdrumWDm1GMObZqd+EJ+mvXUsmP70VUlj0lFxaHDJCjFEFXY3POXShu91/l9E5TK1d
         xasjEAmgwstRQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Zzy Wysm <zzy@zzywysm.com>
Cc:     linux-wireless@vger.kernel.org, dvyukov@google.com,
        hdanton@sina.com
Subject: Re: Fix fell on the floor for rcu violation in net/wireless/scan.c
References: <A7E1204B-E1CD-48AF-AA80-ECCF3E4F7049@zzywysm.com>
Date:   Wed, 26 Jan 2022 07:05:14 +0200
In-Reply-To: <A7E1204B-E1CD-48AF-AA80-ECCF3E4F7049@zzywysm.com> (Zzy Wysm's
        message of "Tue, 25 Jan 2022 17:47:34 -0500")
Message-ID: <87tudrdr3p.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zzy Wysm <zzy@zzywysm.com> writes:

> On 2021-07-30 syzbot reported the following bug in net/wireless/scan.c:
>
> https://lore.kernel.org/all/000000000000f66d1605c8542ca8@google.com/
>
> Hillf Danton proposed a patch, which I can=E2=80=99t find on lore but is =
available here:
>
> https://groups.google.com/g/syzkaller-bugs/c/fhfh_VqZQkI
>
> As you can see at the end of that thread, syzkaller has automatically
> closed this bug because it hasn=E2=80=99t seen it in a while. However, the
> proposed patch appears to be a valid bug fix. Can you re-evaluate it
> for consideration?

That's not a proper way to submit patches, see the wiki link below how
to submit wireless patches.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
