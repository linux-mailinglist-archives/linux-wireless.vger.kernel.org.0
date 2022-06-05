Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11253DD56
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jun 2022 19:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiFERSm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jun 2022 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiFERSl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jun 2022 13:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA4265B7
        for <linux-wireless@vger.kernel.org>; Sun,  5 Jun 2022 10:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB4FC6115D
        for <linux-wireless@vger.kernel.org>; Sun,  5 Jun 2022 17:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F97AC385A5;
        Sun,  5 Jun 2022 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654449520;
        bh=xeWUEBrUs8G3WXbFqgDaVyYlnjDmkLc2Nd9fY2d77Ts=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Kamgo85WVfXeJRk4v4ETi43oGuzy8JjShF6RRlSOmLIFagam06Kkxcd17g8Rcl/zd
         h4o0pXARHL+A8XCSbBlVSjzQp04eH/NSTwqIBd/cL4DxZYbSMmLTqZWZ+OVned0OP5
         ivFunIKozyxK22yY5OP9kzYX5A/KBmzEIINXkdcjMNQy0JWrq+hK8sdk9eK1cfptS5
         04t3Vf2ueu9nlWLfKp3BSiweyBG92fk/z12g7KDLb/AhqY+LkLyXiJ6cn913qSzXGQ
         S7rx6pQzsgRpzIer2bdppqu9hHP/+a9sGyoFoxSJKGos5U3vsBnsdaM8Ss0K02MtnY
         Ds55HCvtfCH7w==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E7E4140551D; Sun,  5 Jun 2022 19:18:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 1/2] mac80211: fix overflow issues in airtime fairness code
In-Reply-To: <20220603164307.92189-1-nbd@nbd.name>
References: <20220603164307.92189-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 05 Jun 2022 19:18:14 +0200
Message-ID: <87bkv7owq1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> The airtime weight calculation overflows with a default weight value of 256
> whenever more than 8ms worth of airtime is reported.
> Bigger weight values impose even smaller limits on maximum airtime values.
> This can mess up airtime based calculations for drivers that don't report
> per-PPDU airtime values, but batch up values instead.
>
> Fix this by reordering multiplications/shifts and by reducing unnecessary
> intermediate precision (which was lost in a later stage anyway).
>
> The new shift value limits the maximum weight to 4096, which should be more
> than enough. Any values bigger than that will be clamped to the upper limit.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

The weights are UAPI, so I guess we could run into applications that
expect to be able to set a weight higher than 4096? I don't think this
is too likely, but maybe it is better to reject such attempts instead of
silently clamping the value, to flush out any breakage if it does occur?

-Toke
