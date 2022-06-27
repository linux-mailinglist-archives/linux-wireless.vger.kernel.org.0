Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0F955E1FD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiF0PCS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiF0PCQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 11:02:16 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059DF1834D
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 08:02:14 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1656342133; bh=q0zFaa23yf3ciG+/3V/M99AzR9YG7OjEQu7K6ssGsYY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=on5eNecv200Q/L1CNm4uR/1UxrpTDpy+cnmzoZXT8CcZP13daGPq/2cH+W+3acDRh
         39kfSXgsgurMLf1rDMX5D722hF9TJZxe3ROOGCSVCQj7Ya5Cj1pyLx1Mu+fqGO/flh
         Zybpl6e+6MxACiSjdal1K2vkaZid9SQsIRHu2c5Hy+ca3DVk92TrgUDhVbipCOIc9j
         itxbuAQWTD91nVgqxUbycsS8tj/Y4QFysqvSn1P5B3BdZyGX40cYO4hMjWxeuneiMR
         bloYHX65qyE6sY7CbbnlqGm9NbpkoGYvYSONLpMPJsehmRQdobjff+PSuHyBCXelVw
         9OY7H9mHCSb6A==
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 1/7] mac80211: switch airtime fairness back to deficit
 round-robin scheduling
In-Reply-To: <20220625212411.36675-1-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
Date:   Mon, 27 Jun 2022 17:02:12 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o7yeb157.fsf@toke.dk>
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

> This reverts commits 6a789ba679d652587532cec2a0e0274fda172f3b and
> 2433647bc8d983a543e7d31b41ca2de1c7e2c198.
>
> The virtual time scheduler code has a number of issues:
> - queues slowed down by hardware/firmware powersave handling were not pro=
perly
>   handled.
> - on ath10k in push-pull mode, tx queues that the driver tries to pull fr=
om
>   were starved, causing excessive latency
> - delay between tx enqueue and reported airtime use were causing excessiv=
ely
>   bursty tx behavior
>
> The bursty behavior may also be present on the round-robin scheduler, but=
 there
> it is much easier to fix without introducing additional regressions
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
