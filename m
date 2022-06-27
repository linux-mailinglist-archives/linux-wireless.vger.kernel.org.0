Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3AC55D472
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiF0PCz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiF0PCb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 11:02:31 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4E1834D
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 08:02:30 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1656342149; bh=NE4ZyUkOQMAvxOzcaBhAjdl/y/HIpZm4Sj77rOr2Jps=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=t/qjodyMTJwDS0KrFjU02gA72LXzqWymrtcIXgbh0hnlRb2gKBZtlB7VWMu2Y25UE
         OSYgDqX45ILLECB0YVLjLMCG/ARVDk5hP0ewQ9+M50g0RYPeHAargMMaB7upjeiMHI
         Q5Dc7aMREf/lYIJsqfG+VaugJp2Mln6McOusoG5CSlA3/dMX80uLE9yIl9F1IRfrXg
         GXTuVGXIEk4djaBoafjQEmqjmEuO2vaw6Kxkex35VmOg2LDf2Tjgivw9oYwcxBB/yj
         2JO0jxkI0MCAy3llx3JikIOACe+1zWDbaXsVnWcTmOq95Re+5AHDymNJbgw9qYr5Ec
         0uy4wCB4GunlA==
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/7] mac80211: make sta airtime deficit field s32
 instead of s64
In-Reply-To: <20220625212411.36675-2-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
 <20220625212411.36675-2-nbd@nbd.name>
Date:   Mon, 27 Jun 2022 17:02:29 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87letib14q.fsf@toke.dk>
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

Felix Fietkau <nbd@nbd.name> writes:

> 32 bit is more than enough range for the airtime deficit
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
