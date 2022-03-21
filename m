Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48304E2D12
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 17:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350615AbiCUQE0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350611AbiCUQEZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 12:04:25 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C5F20F6D
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 09:02:59 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1647878578; bh=MHIqg+qyDybG4rtl+9CycbUNI24bcEoi0tReJsEydHo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o2GEbBvXye0Nz5QhrZ+dF+WvQ9wYEwyf1SSanfAxksAPNnkrjufXpDVROSv/WizeW
         Zj3A/ne1wYtvdv7KiWnE4r+PdMhhC6y8iHTAfU/ZwDS9NTiUqiDt94EU5XGA8JzP7m
         tDo5XoLbLCqzdGfEb/lWOcrx/84Wdqv8G7VdfYn1nmlUYJ3oTJ6GA1Yh/4lcd2tnFY
         tCdAzwl2hhI632OUUuL4aGumyhWOuVHldGRoiYmoCTrGCC6xYKltZfr1jfAq42Q6Mh
         tge9zfYZVU5VZOINtVTw5F0V77vUQ0csHBsbJiOWPj/isg2765Up+Uf48doLCL3XBm
         A7qVhZV6D8neA==
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: Re: [PATCH 3/6] ath9k: use AR9300_MAX_CHAINS when appropriate
In-Reply-To: <20220320233010.123106-4-wlooi@ucalgary.ca>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
 <20220320233010.123106-4-wlooi@ucalgary.ca>
Date:   Mon, 21 Mar 2022 17:02:58 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y2138f9p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> Replace other constants with AR9300_MAX_CHAINS when appropriate.
>
> This change does not appear to affect the final binary.
>
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
