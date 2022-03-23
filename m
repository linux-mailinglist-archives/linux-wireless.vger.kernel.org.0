Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4304E51FF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 13:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiCWMSV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 08:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiCWMSU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 08:18:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD927B10B
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 05:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E6E1B81E7F
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F28C340F2;
        Wed, 23 Mar 2022 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648037808;
        bh=9xhilUj75YGBB7PG/yxTwW2TlEI2qA5Aik0yxa9CJxE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gaR31ljla2CQjqSjEZ0IDI3R+pBl76nYBH6Ne9RqQYwI2Dqdtk4OzuVtI8J2hG/ws
         aTbR5MKToqhFCEkks0YRr/hyIwbRKhCI56sorFfxO8vG/LPGgfYuE77+zOGsz/cGWs
         i0Vs7vuikQaKyVPLNnY3XBeBG6sifKd/Dqs2wED+W1i1SfqVIR5YWSt3tvc/EFOkaj
         CBfDdngBtV3RfmxomaITNhASPzG6cW2ht/f+7W9q/ytM/3GlwaRPueStvtE5u5gVTU
         0p9eZe1Sd6p1WU6ZzXOU6aNlYSkGxIpM5DVTl1rZmRFVPzk4mvd+sCI2dxip8RaKYG
         XFkx9ZLGbF7AQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Wenli Looi <wlooi@ucalgary.ca>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
        <20220320233010.123106-5-wlooi@ucalgary.ca>
        <8735j9vww4.fsf@tynnyri.adurom.net> <87v8w4api4.fsf@toke.dk>
Date:   Wed, 23 Mar 2022 14:16:42 +0200
In-Reply-To: <87v8w4api4.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Wed, 23 Mar 2022 12:15:47 +0100")
Message-ID: <87pmmckgnp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Wenli Looi <wlooi@ucalgary.ca> writes:
>>
>>> The current implementation is reading the wrong eeprom type.
>>>
>>> Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving
>>> the eepmisc value")
>>> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
>>
>> The Fixes tag is wrong, I fixed it in the pending branch.
>
> Ah, oops, my bad for not catching that; thanks for the fixup! :)

No worries, I'm using Stephen's script which check that :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
