Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141BB694F1A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBMSUA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 13:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBMST7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 13:19:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956C0E3BD
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 10:19:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EBAF61216
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 18:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F83C433EF;
        Mon, 13 Feb 2023 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676312397;
        bh=+nSmVIqceQOP3XOZIFOHSsu9Xtpv5k9IyO91zr3Z0oU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KYsGonICOTDUObgAA2zXbc0fBDScnB5//FjSXv91gOjgFRQ1hrTOpiGztxGBdZ5VB
         rwmFJGwRDNm70E1rFZsJtgEgA359FPT9qGlTORmvZTxHsh8koeMdZyRvQvryIPtsze
         4G2UUpn+Q0i+ywnBQObbkdCBc7Dcn0hDjjDLVhGE1Jm6twiv3hDTIkXD5Kv1gXQha+
         AtV/YHXEze2TfpT0q2LFc2TBdxDvWH4bqV3xcroIGnf/LqdVO4SnovEmZCF0c5NnSN
         3PhP/pu3ivzp8+Q5Y6FBTmCyRTp4XXqjPTE0kbPLicmUtNUiMaJZDMBlrxx6jkhv9S
         aFf0JqhIDOipQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k <ath11k@lists.infradead.org>
Subject: Re: Resume from hibernation fails due to ath11k_pci
References: <1263051271.53086.1674425560245.JavaMail.zimbra@nod.at>
        <873579wze8.fsf@kernel.org>
        <370539199.123516.1676291073661.JavaMail.zimbra@nod.at>
        <87pmadvj66.fsf@kernel.org>
        <1617726247.124241.1676294102295.JavaMail.zimbra@nod.at>
Date:   Mon, 13 Feb 2023 20:19:53 +0200
In-Reply-To: <1617726247.124241.1676294102295.JavaMail.zimbra@nod.at> (Richard
        Weinberger's message of "Mon, 13 Feb 2023 14:15:02 +0100 (CET)")
Message-ID: <87lel1v35i.fsf@kernel.org>
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

Richard Weinberger <richard@nod.at> writes:

> ----- Urspr=C3=BCngliche Mail -----
>> Von: "kvalo" <kvalo@kernel.org>
>> IIRC the issue is that ath11k expects the firmware to be running during
>> suspend. And this was because shutting down the firmware for suspend
>> caused problems in the MHI subsystem during resume. To fix this I
>> suspect we need changes both in ath11k and in the MHI subsystem, so not
>> easy.
>
> Hm. So, currently the device is put into WoW mode instead of powering
> it off because of issues in the MHI subsystem. At least this patch
> series indicates so:
> https://lore.kernel.org/all/1607708150-21066-1-git-send-email-kvalo@codea=
urora.org/
>=20=20
> On the other hand, my device seems to have trouble with that workaround.
> Maybe powering it off completely helps.
>
> Do you have a pointer to said MHI issues?

No pointers but IIRC it was something related to MHI creating a struct
device in an invalid context and MHI fails because of that. Maybe it was
so that when mac80211 calls ath11k_mac_op_start() during resume, ath11k
called MHI to enable power on the device and MHI tries to create a
struct device at the same time, or something like that. This was a long
time ago so not sure.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
