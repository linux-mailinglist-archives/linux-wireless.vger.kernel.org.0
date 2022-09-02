Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BF75AAA39
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiIBIh5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiIBIh4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:37:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806F29CA5
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E98620E6
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0CDC433C1;
        Fri,  2 Sep 2022 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107874;
        bh=UqzXZQYdTttPpGLppaPDIhPVmMwec5+dj8Hg6foCDr8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nuekQ/E/mbFBzudHtuWnxId9GKPKHTXTfSt9d63YIGgGxOuGorJtOi0SRwEy7v6km
         Lp5CatkTFGph8qED7JRNpQO+dOmlw9xD6ar+SEyGIE7GnNgYEqel6T0UMbogmTJQO+
         aLd4lmTpsVChcf/FuGbJ78DfP5yNVu2j/+W+I6w77a9gRd9uPy5DR5/9Ad5tRGWjZF
         nFrL7swDNdaptLfGFsCf/YG0am96qUYWXIsEqxtejWCoZZkIc1mLJNWAP8KGpYmoLA
         a16xy+fK8/wM7HZwBx/RhZglcpndmIbjH9Kaspz+gNzH94/fWtF9M3WnPcMZ3u8Ke6
         JyotTlV5Iv7lg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: no HTC field if TX rate might fallback
 to
 legacy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220826061011.9037-1-pkshih@realtek.com>
References: <20220826061011.9037-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210786891.24345.14272162500479036626.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:37:53 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Packets containing HTC field with legacy rate could be dropped by AP. If
> TX rate of report is lower than MCS2, hardware might fall back rate to
> legacy. Therefore, add a checking rule to avoid HTC field in this
> situation.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

0d466f05262a wifi: rtw89: no HTC field if TX rate might fallback to legacy
ad275d0a82cb wifi: rtw89: correct polling address of address CAM
fec11dee177a wifi: rtw89: declare to support beamformee above bandwidth 80MHz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220826061011.9037-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

