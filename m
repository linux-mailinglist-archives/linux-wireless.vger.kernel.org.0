Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F484ED351
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Mar 2022 07:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiCaFiw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 01:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiCaFiv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 01:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840E15E143
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 22:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E57C61584
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 05:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEC3C340EE;
        Thu, 31 Mar 2022 05:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648705020;
        bh=4oO3c7uTvDyCSMmcUFa/N6pdp16qOZqXDXNpe3Jo8Qk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mAyqp2G8Bssr8sbn0BpS924qZv4JsGPUeD9SNADv7TMFr0lplNwpMw0LlRyb+OVQT
         fMZ+YIbhAo5oh/fmkHDp90yhAqvXebJm7XPiLsoT1suuX9NAADnTYALBtXma66fb/C
         r2oQKgpNVRi23y+qwF75Or48hRlrZT26GgP4PQCt5O99HWvQ3Fn0INPinDVz44KmR5
         B55Kygg9NK+2p4oGTqlcTb7MbvaH9F6k/41UIEvPJfkK7NP4/5Nlw4xjW9OuSd/1iM
         luZ5i5+PvXLkZ57sebwCru14koBD7+F83E23EUlxoMi3gnuq61upfiP+nmJaIFP/W4
         pHNXvU/x41J6g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5.18] ath9k: Properly clear TX status area before reporting to mac80211
References: <20220330164409.16645-1-toke@toke.dk>
        <8ad2754c-c5bb-7b07-6b3f-5701d0434eee@gmail.com>
Date:   Thu, 31 Mar 2022 08:36:53 +0300
In-Reply-To: <8ad2754c-c5bb-7b07-6b3f-5701d0434eee@gmail.com> (Bagas Sanjaya's
        message of "Thu, 31 Mar 2022 12:06:45 +0700")
Message-ID: <87fsmyvg22.fsf@tynnyri.adurom.net>
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

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 30/03/22 23.44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The ath9k driver was not properly clearing the status area in the
>> ieee80211_tx_info struct before reporting TX status to mac80211. Instead,
>> it was manually filling in fields, which meant that fields introduced la=
ter
>> were left as-is.
>>
>> Conveniently, mac80211 actually provides a helper to zero out the status
>> area, so use that to make sure we zero everything.
>>
>> The last commit touching the driver function writing the status informat=
ion
>> seems to have actually been fixing an issue that was also caused by the
>> area being uninitialised; but it only added clearing of a single field
>> instead of the whole struct. That is now redundant, though, so revert th=
at
>> commit and use it as a convenient Fixes tag.
>>
>> Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time before rep=
orting TX status")
>> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
> No regressions and UBSAN warning [1] reported on dmesg.
>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> However, there is something missing. I don't see Cc: stable@vger.kernel.o=
rg
> trailer in this patch. I think it should, because I reported that this is=
sue
> first occurred on v5.17, then still appeared on v5.17.1.

I can add that during commit.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
