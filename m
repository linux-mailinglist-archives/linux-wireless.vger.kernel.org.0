Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806FC58249D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 12:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiG0Kkn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 06:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiG0Kk2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 06:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B03617B
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 03:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECC776188C
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 10:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00853C433D6;
        Wed, 27 Jul 2022 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658918426;
        bh=2aAAbl7HtqycJhSGG4MOhyn4n1vDDbjI8YyivZ1vBOg=;
        h=From:To:Cc:Subject:Date:From;
        b=jL3akpO6Z0zFN3pNnIUd4tsrVSOmkK7DUCN7ic9Eb04HBI9hwklJxLZgCnKYgoSpo
         LfvRAqCMOMy9LmWlBtJh3UqWQPkevc0pLEZD8kjoQpXPDvJ4+1EXIDkOPc04eWGXz9
         EG+fiZxfCOkpbvZ4MvJGOnNzXH8umohHcXLTewNStUKTDUNVMU/1kP/cstGA4MSNWL
         TScRHUJdp8cYt576dp+QmpZH+4NEr9PEgvGlPW9qIJmctMhH+D4QIUdeLVeb/AB+eF
         ZtOM+yEDPQgtbmJOWRL/KSd97qESYuDohor2OIY1uwGQ2SLMBlMikGNmLwyX1nta2J
         OPiquoGPh/LLg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>, gregory.greenman@intel.com,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [IMPORTANT] Use of wifi: prefix in patch titles
Date:   Wed, 27 Jul 2022 13:40:23 +0300
Message-ID: <87bktaq1ns.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Some of you have already noticed that few weeks ago we started using
"wifi:" in patch titles, here are few examples:

wifi: mac80211: optionally implement MLO multicast TX
wifi: cfg80211: report link ID in NL80211_CMD_FRAME
wifi: wcn36xx: fix repeated words in comments
wifi: ath11k: mac: fix long line

Everyone, please start using this new prefix on all wireless patches
from now on. But no need to resend existing patches because of this.

I also updated the wiki:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Kalle
