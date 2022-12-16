Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FEA64E98B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 11:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLPKgs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 05:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLPKgr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 05:36:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F82EF22
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 02:36:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE1C061CFF
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 10:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1DEC433EF;
        Fri, 16 Dec 2022 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671187005;
        bh=QdJPW1es4pIi/AdIHAu/1rzhIl22O8T5oHinECl6AyY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kVm0Cla2OQY2OAc7Os2BX1R3pEQgzPfty9rBu5IzpqV4d+D3A8FERpqi2Mmsm9w0U
         sFv29JQ4KK/yXIHJf+uCt9nuypNa/9VeRyoURYDvzYO1GzgRNmUMNUNjKtHW9YBCGN
         iw1/gDQrpAOohEeo3uoe3+6AwzKVRP5LP+3M1leXOyjLLh5XlxbMapjWJHVggFK1jA
         sVKBUbB0XJ9AiiKrHfUWdps0ekeAE96nV4x1O0EuteT37jmQVKKRGsu0cbDVZi5uD5
         BouCNdojSKbFMW0iE8cc8I9HwPGRz3wrjl5nYIvjtjR296i6lksr1u5Eqg+vBLsiz9
         qkNoPEGnM+fcw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: [PATCH] wifi: mac80211: fix initialization of rx->link and rx->link_sta
References: <20221215190503.79904-1-nbd@nbd.name>
Date:   Fri, 16 Dec 2022 12:36:42 +0200
In-Reply-To: <20221215190503.79904-1-nbd@nbd.name> (Felix Fietkau's message of
        "Thu, 15 Dec 2022 20:05:03 +0100")
Message-ID: <877cyrljnp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> There are some codepaths that do not initialize rx->link_sta properly. This
> causes a crash in places which assume that rx->link_sta is valid if rx->sta
> is valid.
> One known instance is triggered by __ieee80211_rx_h_amsdu being called from
> fast-rx.

An example crash log would be nice to include, it would make it easier
to find this fix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
