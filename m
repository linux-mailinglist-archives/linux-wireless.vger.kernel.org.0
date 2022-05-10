Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676195223E1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 20:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiEJS3f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 14:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbiEJS3e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 14:29:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040502A7C00
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 11:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3C88B81F67
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 18:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C364C385D7;
        Tue, 10 May 2022 18:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652207134;
        bh=/wrEw/XPtbX7Aa29RfzFLqQ9L9elo+ns/lNVoxwRdQI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aPLY6S64CdECRAhwnpT+P6Lg+3tOjpWl4QS0jzwFkK+G/HKph/VIe4/NGnPV/uy7/
         R1M+0fR/DbgwPWTBJm3pGd9t4oKPZmJszTo8jj3DVRtphMPGBH59ylHSj1/Kzx7G0d
         5aMXeKTI2AxBSnNfhgQeUyTZNA1gI15cF+eg1dTYb4xTG/DVvvX1SqMsiT92qzQ48J
         L3epn1xXXlQyRS0Zd72nXdNGyHRAJTBmW00LnxBVOjPM8uivEQzPLzxHFZh3qgx8sz
         RqhDuWGFjRS7m6AnUDTJw2GGGCOf+8x5NhuOQhdA4nCWg7H/wVDVv34bilE3JbmdrU
         cfaLbZHICp2lw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E16FA34E33B; Tue, 10 May 2022 20:25:31 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: [PATCH] mac80211: Simplify queue selection
In-Reply-To: <20220510155828.9406-1-alexander@wetzel-home.de>
References: <20220510155828.9406-1-alexander@wetzel-home.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 10 May 2022 20:25:31 +0200
Message-ID: <8735hhxn1g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexander Wetzel <alexander@wetzel-home.de> writes:

> I still don't understand why we don't want to use qdisc with the iTXQ
> drivers. I now just made sure we don't start using qdiscs with this
> patch to start with the least invasive approach. Anyone able to shed
> some light on that?

Because of aggregation, basically. To build an aggregate you need to be
able to pull several packets that has the same STA+TID; if all packets
on the interface are just sitting in a qdisc you have no interface to do
this.

Before switching to TXQs, drivers (the ath9k in particular) would solve
this by having another layer of per-sta queueing inside the driver,
which was just a dump FIFO that added a bunch of latency. The iTXQs
moved that up to mac80211, while doing proper queue management (flow
queueing + CoDel derived from the FQ-CoDel qdisc) at the same time; this
made the qdisc layer redundant for most purposes, which is why we
switched to noqueue by default.

-Toke
