Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3775D76FD48
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 11:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjHDJ3r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHDJ3f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 05:29:35 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F8C49EC
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 02:29:32 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1691141369; bh=mtj3Ks7I0FH9PbRtGPNyvnxNoLJNFfNr53IieLs1jZo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XetNNFFvY2lndEeB/W5Q580u19PPhLRNEuJm5zpcVdR76/VyiDrqlQDFI4WIRH8L1
         LCILjt4WHG2180NPA4Vx3YmBREQ1jbr0uMU0YtlS8uGFD1phtw3xqU9BgjN/1bC02C
         lfdMS0mC/o97HuFgpcSf7U2a3yig0wxX2ynzyiXB/Ikcbodt+6aHjadjK4N13EJkWd
         Sc0RXnB6UbDnqG/bOcNf1ldS8YvO41uhOTlmsbuATEZ6dEM2WYILBTAjD8Viq2ZuLU
         7uBRLfoIEg23PC7iOzSOAD4hYG7G1pGPSD3WSKP9bIXElkXdg589pVCvYha2otKQ3o
         ifmfCrmNL11NA==
To:     Kalle Valo <kvalo@kernel.org>, Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH -next] ath9k: Remove unnecessary ternary operators
In-Reply-To: <87wmybs2xc.fsf@kernel.org>
References: <20230731124455.2039184-1-ruanjinjie@huawei.com>
 <fae803e7-9131-11bb-ad2d-7a61e76dc9ce@huawei.com>
 <87wmybs2xc.fsf@kernel.org>
Date:   Fri, 04 Aug 2023 11:29:28 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o7jncg07.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Ruan Jinjie <ruanjinjie@huawei.com> writes:
>
>> Ping.
>
> Please don't top post. And also don't ping, you can check the patch
> status from our patchwork. Read more from the wiki link below.

Also, in this case the maintainer is on holiday :)

I'll be back starting next week, but will probably take some time
getting through my backlog...

-Toke
