Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBBF4CC9FA
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 00:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiCCXUQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 18:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiCCXUP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 18:20:15 -0500
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53081617D3
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 15:19:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 7BEC910FB7;
        Thu,  3 Mar 2022 23:19:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lIsd1hGJ8t21; Thu,  3 Mar 2022 23:19:24 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 04 Mar 2022 01:19:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1646349564; bh=mQvSJ6iX5J4KdPAB9kq8frispN/EAqUsO3xhvhWxqc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAkz3yOHJ5WwXOIwSBez3W4NWb0xanCK1+zK5Ors8mmE6nhnHMKqd3x5EORTzcd5S
         lW5DgvujH2wUwKDGlav1weVCG8YKbJeNydAaY9JOxfwoKFz9daf0quqPOjXNW9Gm7W
         mitVKZb9+c5HIFm2uHGV/vu0V0j4+hAIcGbSuPQqOG4X4bJoI53VnWQwEeaK0O6WI9
         14FOfT67Xy5iyvWD9ZQaZyj0nNNRF2Eiy0k6BwqjW3BF6q/YRlQsBg9Kz0YabYgkTv
         avvJWEQO0vfQAmpdY9fUXZCwVnDvXKVoe41DWS4sioAK58YLP4DcU3DYT/lcOCGLtJ
         TIwHGGlTCVczw==
Date:   Fri, 4 Mar 2022 01:19:22 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 0/9] introduce background radar detection support
Message-ID: <20220303231922.GA481387@w1.fi>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 20, 2021 at 04:48:15PM +0100, Lorenzo Bianconi wrote:
> Introduce background radar/CAC detection through a dedicated off-channel
> chain available on some hw (e.g. mt7915).
> Background radar/CAC detection allows to avoid the CAC downtime
> switching on a different channel during CAC detection on the selected
> radar channel.
> 
> Lorenzo Bianconi (9):
>   Sync include/uapi/linux/nl80211.h with mac80211-next.git
>   DFS: introduce dfs_set_valid_channel utility routine
>   DFS: add capability select radar-only channels
>   nl80211: report background radar/cac detection capability

Thanks, applied patches 2-4 with some cleanup (mainly, replaced the
int flags parameter in 3/9 with an enum to make the code more readable.
Patch 1 changes are covered by another commit.

>   DFS: configure background radar/cac detection.
>   DFS: introduce hostapd_dfs_request_channel_switch routine
>   DFS: enable CSA for background radar detection
>   DFS: switch to background radar channel if available
>   DFS: introduce radar_background parameter to config file

These have open questions or dependencies on patches with open
questions.
 
-- 
Jouni Malinen                                            PGP id EFC895FA
