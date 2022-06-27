Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F037E55D39F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiF0PEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiF0PEm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 11:04:42 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8ED17584
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 08:04:41 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1656342280; bh=91w/wzpqHlDyYYgmMcGluRUKcpAIGwZBDwnr/j11vZ8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=y5dWsx6m3FlEDQAWBCXCSbVHu/egmaaFWM+BJCH4swhTdU9u6pUGfkSBt3++XlG2d
         QxRKjAiW5sGdtRWNrmLWzD0q+7lJX2Z6bFfHTX696bZRnqKiVzNjJ9vi6ln/k+wzJR
         W/Ep172VB5Qv3zn8FyDtqbgVYoxg12GBkqXECR0gBQKkYQDV8Ckz8kiZL3q/Ka/fMn
         Sj/uKojW4BrWWXI5Ot40uwyQjupnZU3h8slaeIGV9/ndUeau9UQSDTEaGxzZr0KO4B
         6lZCTP3o78GHMoDwWbSIoI+nCOpjyaoNAH85fOZn4BXxCBr7bvK5lS+l+f8OMBYWGM
         9/GwaxtmM7qTw==
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 7/7] mac80211: only accumulate airtime deficit for
 active clients
In-Reply-To: <20220625212411.36675-7-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
 <20220625212411.36675-7-nbd@nbd.name>
Date:   Mon, 27 Jun 2022 17:04:40 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877d52b113.fsf@toke.dk>
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

> When a client does not generate any local tx activity, accumulating airti=
me
> deficit for the round-robin scheduler can be harmful. If this goes on for=
 too
> long, the deficit could grow quite large, which might cause unreasonable
> initial latency once the client becomes active
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
