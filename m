Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699426945DE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 13:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBMMeN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 07:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjBMMeM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 07:34:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76369193C0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 04:34:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27CFEB811A2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 12:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F91BC433EF;
        Mon, 13 Feb 2023 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676291638;
        bh=y/2PNTTp0WU9n9seyOU2p79291AiqS6hxjKqz3xJri0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WJsutstLNBHViXtEQPLfRSNt4X6IHBFsC3tkljZ3h4mF2KFUHl8FWKtpqTx1/sGJo
         ZRzcZWJyhnerjfh+IrMKbbK3DQ6LjnFYkZZ0y7uKtyIxSDBAiHfQMtEiavkKt1l/8s
         oy52PhUkjybS4Fh4rBg5dTOdLo7XdmiJGQsRWZBPDX2zbY81nKAK4m/XI2TVt9PbCx
         tBeIiSvYu53dIPVZT6+heiFVn/r8d37HDzqWmcZzts8UzqqOsHNW6e2JE13caXYeyp
         /TduOWf8nAxv/5ZMRnz5MNsJ7W1GroD4mOGbEklY1zye6JUv1DcS+Uci2DmEdUGORm
         d7DXolpz3dZ4Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k <ath11k@lists.infradead.org>
Subject: Re: Resume from hibernation fails due to ath11k_pci
References: <1263051271.53086.1674425560245.JavaMail.zimbra@nod.at>
        <873579wze8.fsf@kernel.org>
        <370539199.123516.1676291073661.JavaMail.zimbra@nod.at>
Date:   Mon, 13 Feb 2023 14:33:53 +0200
In-Reply-To: <370539199.123516.1676291073661.JavaMail.zimbra@nod.at> (Richard
        Weinberger's message of "Mon, 13 Feb 2023 13:24:33 +0100 (CET)")
Message-ID: <87pmadvj66.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Richard Weinberger <richard@nod.at> writes:

> ----- Urspr=C3=BCngliche Mail -----
>> Von: "kvalo" <kvalo@kernel.org>
>> Richard Weinberger <richard@nod.at> writes:
>>=20
>>> On my shiny new Lenovo T14s resume from hibernation always fails, and c=
rashes
>>> the kernel.
>>> Looks like ath11k_pci is unable to resume the device.
>>> This happens also with Linus' tree as of today.
>>=20
>> Unfortunately a known issue in ath11k but no fix available:
>>=20
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D214649
>
> So the device is unable to operate after entering ACPI S4.
>
> Is this a bug in the Linux ath11k driver itself or more likely a
> firmware chip issue? I didn't verify whether resume works on Windows
> though.

IIRC the issue is that ath11k expects the firmware to be running during
suspend. And this was because shutting down the firmware for suspend
caused problems in the MHI subsystem during resume. To fix this I
suspect we need changes both in ath11k and in the MHI subsystem, so not
easy.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
