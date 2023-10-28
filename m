Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C20D7DA7B0
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Oct 2023 17:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJ1PL4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Oct 2023 11:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ1Oyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Oct 2023 10:54:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37650C0
        for <linux-wireless@vger.kernel.org>; Sat, 28 Oct 2023 07:54:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14202C433C8;
        Sat, 28 Oct 2023 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698504869;
        bh=jmQSCqgDSKptEABEDsP6a/iiYUjDanDG6iLy5CVLGjQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=haIDfLBB36jy1G2GFIUTW1z08Fi/nxgDtZI+n2jeQzy5Z9Lh4lsVeiwQh0pYZDUKh
         O6/bK23JCylhEDUmDNCr/dvTv0oVU1OdJJVakAO0yrZSzetTc2NFGsStXG0i3JEgwQ
         mc41hsnXlmmch07k1N4+auxBpWmugFu91U6qxCRtnZ0r4ef2ZP8zKiKgCwAA8+OzE8
         15Z5T680ia0TIDk6WNnHZp+JZoJEJZf8Hu/u69KO9nGHsc3dPFBtFaDLgvVPArszHY
         +7qcZGe4o656B3g6qfay40I2xXr8/0B1hogJup354OPPxJi6l8RvMQccByt4fScbFO
         nEbKyWsn2fRMw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 2/3] wifi: rt2x00: disable RTS threshold for rt2800 by
 default
References: <20231028121532.5397-1-yangshiji66@outlook.com>
        <TYAP286MB0315DBC21F89552F7D235E56BCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Date:   Sat, 28 Oct 2023 17:54:27 +0300
In-Reply-To: <TYAP286MB0315DBC21F89552F7D235E56BCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
        (Shiji Yang's message of "Sat, 28 Oct 2023 20:15:31 +0800")
Message-ID: <87y1fmbxwc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> writes:

> Disable the RTS threshold for OFDM and CCK rates by default as the
> initial RTS threshold is 'IEEE80211_MAX_RTS_THRESHOLD'. And RTS
> thresholds for all other rates have already been disabled when init.
>
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>

The commit log should always answer to the question "Why?". What problem
does this patch fix?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
