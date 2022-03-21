Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC11B4E2D0F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 17:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiCUQEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 12:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346093AbiCUQEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 12:04:10 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3753A7E
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 09:02:44 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1647878563; bh=CPa44N5ctjfcgKvrTeIS9etPhRsv2341cLdlWKDZvP0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KtRTe2vqU4SjQ56cf4lewqR4kjpMaI+Ql18Xy/fvLhnR+842A6aN9UwwWCCNtI8Pa
         rZu1LtyWJ7+UgzUYK5L5hnM0D6Y7DdK16yx1FunD0/NUaO2Z6ziyw5gqP+lWZljASu
         oedxh6PFFU1SlcbDTRR6LhAoUznBVZShgcpyGkkJ0tU6ZxRFILZRAyTgH9HoF1cpX2
         JacAENXgcnTGn9yzeNF7Au4YdnKWPAhzu5r1NPTvCetCL7g6kNuWEt1gKMubdZSyHD
         vFrHgsTI0yFFP1uZ4BphZUMsooqfBpKOwTg6z7UYZ+U7J8CLlALZvpKWR7vBw+ZP6n
         VsvKwr6tGVEBA==
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: Re: [PATCH 1/6] ath9k: make ATH_SREV macros more consistent
In-Reply-To: <20220320233010.123106-2-wlooi@ucalgary.ca>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
 <20220320233010.123106-2-wlooi@ucalgary.ca>
Date:   Mon, 21 Mar 2022 17:02:43 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874k3r9tuk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> This makes the macros more consistent and removes hidden dependencies on
> ah for macros that take _ah as a parameter.
>
> This change does not appear to affect the final binary.
>
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
