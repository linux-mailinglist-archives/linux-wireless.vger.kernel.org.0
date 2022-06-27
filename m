Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B525955DE22
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiF0PE3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiF0PE0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 11:04:26 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1047217597
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 08:04:24 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1656342262; bh=hKYeLSRuJ9qzX6NySY84fjKX4ihNAvr4Mu0/33XaD38=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fSFuiDEDLRAmAvyPWqeT8ak1yg/cgwuOps7lcWJ5o0Pxc1Cv21Uzq14Dp28oatPIS
         TwIEXGnJdPKlXAjYeT4gqfIQUUH0oIK+aWRvbkrK2XUU8I2RbgXZBziMBw1OSiuw5k
         A6odnONniu+ZmnZ2DTwiXZNobmfWyOjP5Yx7aphUF/4q5XzZErmFDWo1zQXZmQOAjj
         onXceDNkjTkzIkk+Z5WAWTJS4F96i07fdxOFpMcLbI8jna/dkps6q5SJ11imYXtwZr
         bnWCWDRb1+Ya8DQ813fZsnJmwRMc+GEb94vKPKTuCkw82Bh/gqQgIR+W4QbLow3bQx
         DogQcdrbIk8aQ==
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 6/7] mac80211: add debugfs file to display per-phy AQL
 pending airtime
In-Reply-To: <20220625212411.36675-6-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
 <20220625212411.36675-6-nbd@nbd.name>
Date:   Mon, 27 Jun 2022 17:04:22 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a69yb11l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Now that the global pending airtime is more relevant for airtime fairness,
> it makes sense to make it accessible via debugfs for debugging
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
