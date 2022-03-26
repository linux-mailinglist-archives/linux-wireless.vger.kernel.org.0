Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0A4E81B7
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 16:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiCZPDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Mar 2022 11:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCZPDT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Mar 2022 11:03:19 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8BE0CA
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 08:01:42 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1648306900; bh=ZIohhxZZ78y9xqnPxohLO9KrJQxTzwl/B2NPlKCxwo8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X9mrvPfQDZeyzxoPYSdp/TCdDkAHgZ/cP9wu9YrBvcmCdR06lhzPvZD2pDD6jvPhj
         1ovnBWIBupJG4BXqhkfmqUD5e+ZPEsIenAetgjZSFGMtR38RrgRtT/vkCN2nR+ZoRe
         Aeu0pZcpCcil4kpAH2IAHChjcZcq0eDFbw+kMnZS/FZL+Xp3GTCevxXDOeETRMaMnV
         I5NOLA6qKvKveoFhNsfikcn2qxJYjwJ683RsvcsAE04G9zKYGknvjvh719LluAFNcq
         zo8vfRurbMJgd0lL2Y5+ks3AwjyBR04krop87p/frirGrSx3K8x0ynclU9n0sxCLTl
         CKVS6iLYYOM+Q==
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: Re: [PATCH] ath9k: make is2ghz consistent in ar9003_eeprom
In-Reply-To: <20220326054754.27812-1-wlooi@ucalgary.ca>
References: <20220326054754.27812-1-wlooi@ucalgary.ca>
Date:   Sat, 26 Mar 2022 16:01:40 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ee2o7o6j.fsf@toke.dk>
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

> Replace a "mode" variable indicating "is 5ghz" with an "is2ghz" variable
> to make it consistent with other functions in the file.
>
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
