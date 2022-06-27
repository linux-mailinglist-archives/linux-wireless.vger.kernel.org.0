Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9FC55CA74
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 14:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiF0PDX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiF0PDV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 11:03:21 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9257167C7
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 08:03:20 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1656342199; bh=agwTZ8nT/ZbdOtqVKSDtYLPq9pLVDyawymUo7NyLkjM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MANW7yV0peRxx7QYexovvPYUI1Bq+51rRMtvr40s1TrQ3Yc5R3A+I2gMi5eiU/nOg
         yRSlNjKgC6kLf8TQLxLLQRP5piVzbvDjEvYwPiyamUZOpaCCkj8Hp1bxxoztcF6RIa
         9PIwh2eyByQXWzQ4kwBEoSOXANl1Z8U0488xICOwAs7lmenW2rCn/MVv8DOD7ArH8h
         /owrpEpn6urW/pWB2ts4+kDvBOlQvykUm7M2v7vRGvR1dfFnFGCmUtQhueY4YS3fhf
         cvaxhF29XDJJQ0+AGAJLVwt67+DTJVNeZ8tQjT5H+5gzpPiYstRwJj7JYrFZl+LPe6
         Uzu8Yg8poicpA==
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 4/7] mac80211: keep recently active tx queues in
 scheduling list
In-Reply-To: <20220625212411.36675-4-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
 <20220625212411.36675-4-nbd@nbd.name>
Date:   Mon, 27 Jun 2022 17:03:19 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fsjqb13c.fsf@toke.dk>
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

> This allows proper deficit accounting to ensure that they don't carry the=
ir
> deficit until the next time they become active
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
