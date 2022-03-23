Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD424E5115
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 12:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbiCWLRX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiCWLRW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 07:17:22 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577447891B
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 04:15:51 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1648034148; bh=108UX2r2i85XSndx8luIIVW/EIAG+BPvICsLBN4gEKg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RyY9HgQVDHIZk19ITJtiFTKMQSPSQZDqYpQHSZ5azNym5xVMQ+6pu4zOQsT2L41cz
         Tuat7pR7uQ9p1Kh8W3XunEcQyS05JPSMJpi8CxCasRo0NqHBQiUUSFsfUOY5SaabRf
         6THZm8eL+DoazglRCIn0tVJ+mtFByk87D4LyjudeZhoIkrJKHPxPEW0JokETLStoGH
         DqGCQpVBJThmRiDdnZO1jsKgCuGwnJ1E+n/5I+EY7hrWNgi9ydS6LjUW74vPRvyCDs
         t6CihMn8zS5XcS04aKxA9nZrDncz1E9kQzxqRmETr8Gfp2hEKN54pBxoERdsJzxr0m
         ZJnW2niv1lnnQ==
To:     Kalle Valo <kvalo@kernel.org>, Wenli Looi <wlooi@ucalgary.ca>
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
In-Reply-To: <8735j9vww4.fsf@tynnyri.adurom.net>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
 <20220320233010.123106-5-wlooi@ucalgary.ca>
 <8735j9vww4.fsf@tynnyri.adurom.net>
Date:   Wed, 23 Mar 2022 12:15:47 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v8w4api4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Wenli Looi <wlooi@ucalgary.ca> writes:
>
>> The current implementation is reading the wrong eeprom type.
>>
>> Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving the eepmisc value")
>> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
>
> The Fixes tag is wrong, I fixed it in the pending branch.

Ah, oops, my bad for not catching that; thanks for the fixup! :)

-Toke
