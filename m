Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927DB7A9D31
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjIUT32 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjIUT3K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED0EA9F1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25436C433CD;
        Thu, 21 Sep 2023 06:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695277790;
        bh=CM+HxMSjwxkR6zP0LHozqPQxAeEJMm9yiBkQwSqQAow=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CDHMbdT3ndRgyhm/Xka5l9JL3w3sUCxJWq9FAJFd0eqMI3OGuFja0Icbtl4RXyJe7
         +P5nHa3PQyIYFAL26PojIaYlOMpbU1JrSxPKt08MxFqo8IokhT4rk1cTYa6bt26ndZ
         Ib/r6cyjIndlU3JmhSVXq+2UJf33f+IsFTEzO/p9Ed/j5GeF0qShw6BJSBU+dWJ8Lw
         JJPRrmLIoZtg5UxS8CO1DLauNG1G4Pmkd0qkeoksWu0xbhfZZY7PVKgVILrWq5qlpI
         nebFMDpTo+F0SJkfEoOY7kF3X+Wl9H5ytiqIdb16ZBsJlkCk0NQfzvsydOzF7UFam5
         gLA1IpoXMjQpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: mwifiex: use MODULE_FIRMWARE to add firmware files
 metadata
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230914211938.28395-1-victor.gonzalo@anddroptable.net>
References: <20230914211938.28395-1-victor.gonzalo@anddroptable.net>
To:     =?utf-8?q?V=C3=ADctor_Gonzalo?= <victor.gonzalo@anddroptable.net>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?q?V=C3=ADctor_Gonzalo?= <victor.gonzalo@anddroptable.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169527778800.1469888.8957763957282176888.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 06:29:49 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Víctor Gonzalo <victor.gonzalo@anddroptable.net> wrote:

> The mwifiex_pcie driver is missing the MODULE_FIRMWARE macro to
> add the firmware files needed to the module metadata.
> 
> Signed-off-by: Víctor Gonzalo <victor.gonzalo@anddroptable.net>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

260323c3a3e3 wifi: mwifiex: use MODULE_FIRMWARE to add firmware files metadata

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230914211938.28395-1-victor.gonzalo@anddroptable.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

