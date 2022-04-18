Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C37C504F63
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiDRLiz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 07:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiDRLiy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 07:38:54 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F283C1571C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 04:36:15 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1650281774; bh=IbW/cuJA//0oDSvZ3i/IYYMkeN95p2xEDL+6oPGV8wQ=;
        h=From:To:Cc:Subject:Date:From;
        b=xaXiuoXgVc0N5d63bqEBFKGkKODvq8bwvMbiuBjzzxWNmYAntKyzylPrqbx/p7F4S
         BQPa5RpDe7ELlekwglY9cc8qewIzULGyLhatCaorcpJIrEBeDgqp63W4bzPPpfulQy
         1vZinYbLGIgcP6ZRli672xgH35VxMl5lXgd1UdsqaJB5XA2YMiy4IeVGhpSTALdtyd
         knZnkOmg1LMprumlS58j14PpQ8KiLtnwuVpxu5bk/PEzjyds+tR2ui3yne1lb8MVOT
         tJhzjFkt6voeQinrIkhsOVjFH92Bqk8Wd9W6B9TCfD1gIMYRh1lygd3NXyHFC/5LoL
         Bcir0hUtg/sag==
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: iwlwifi devices disappear after suspend on kernel 5.17
Date:   Mon, 18 Apr 2022 13:36:05 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87czhe39p6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Luca

I've started seeing issues with my iwlwifi interface going away after
suspend. I get errors like these in dmesg:

[104393.142264] wlan0: deauthenticating from 4c:60:de:ea:b8:58 by local choice (Reason: 3=DEAUTH_LEAVING)
[104393.347775] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Couldn't get ACK from CSME on HOST_GOES_DOWN message
[104393.347876] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: failed to send the SAP_ME_MSG_CHECK_SHARED_AREA message -19

And when the host comes back up, there is no connectivity. Restarting
iwd fixes the problem.

This is on a 5.17.3 kernel (Arch Linux distribution kernel), and lspci
says the WiFi device is an "Intel Corporation Wi-Fi 6 AX201".

Any ideas? :)

-Toke
