Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF478525F33
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 12:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiEMJoX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 05:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiEMJoW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 05:44:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30176644C6
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 02:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD1C621FC
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 09:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EF9C34100;
        Fri, 13 May 2022 09:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652435061;
        bh=HN8NEogXU4k9mck+7vkT8rZAjjTlfX6Ymd7aU/tE/aA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JUnc0rN12G598JAHvarLD/oSjX+n/yMFPxebBCN4SsZu79KhsCjzhT+3hTjdlSxqm
         n8BZFKaS4dw49kVjPZAOktkPDlvhmIfPLHOSj5bvM8VYToauAvto6mGXdHbV0akbY3
         FZGkk0kghty3YfhM9pXl654cB0gEDSKM9DpXoVy1KId9A7g25eA10J359rAvr0mtLv
         3yMrAu1xv1kN5IQKW9HWzNPeTtAn2vTAWtoUfMGQWm1lL80ge4cTh3fS5QvZlIz7BH
         vDiJgOtMAlZKbNmlTCt1A1Inj6KQq2Dsk7R50hrUhfTDS7OYmZZHqWImszclORFwFF
         zpjkRpE8jRb3Q==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4564338E70F; Fri, 13 May 2022 11:44:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: Re: [PATCH] mac80211: Use ATF by NL80211_EXT_FEATURE_AIRTIME_FAIRNESS
In-Reply-To: <20220513071948.2419-1-evelyn.tsai@mediatek.com>
References: <20220513071948.2419-1-evelyn.tsai@mediatek.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 13 May 2022 11:44:17 +0200
Message-ID: <8735hddaxa.fsf@toke.dk>
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

Evelyn Tsai <evelyn.tsai@mediatek.com> writes:

> Except for using debugfs to change airtime_flags (AIRTIME_USE_TX/RX),
> turn ATF into a proper NL80211_EXT_FEATURE, so the driver can determine
> whether using airtime scheduling.

So the reason we didn't do this from the beginning was that the driver
would just not call ieee80211_register_airtime() if it did not support
airtime fairness. Why is this not applicable to your use case?

-Toke
