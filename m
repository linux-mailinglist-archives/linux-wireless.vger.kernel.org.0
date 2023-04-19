Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03596E7D10
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjDSOlN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 10:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjDSOlL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 10:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A44C20
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 07:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A1C163FC1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 14:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBA06C433D2;
        Wed, 19 Apr 2023 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681915265;
        bh=gTPPRV81BSS/cUoVriXJYgZjhP3pEp7MZXd0feEjlLw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=em71wt4LUn5vYzukpXN6sLZgl6Gp7Zc6hBqiKfNHP2QqUjnXBSvMs2O4J4FCO1EyY
         2nRVuLUQdBg5N6jLY4egIWjaE8KpMkd4Kq3VzWt66udzYF6Vb9mLMMaVGuiO0kqKA/
         eaNO+hObmOyhgfimTOhnNQt2eKHrN4IEqftRdsayoNMWPPz1gAR7Wl+6fEOd1Q3Kkq
         ePi10OwoVPtNimmpVjwvqkXoglY6a6r2aeyoC3KE/jVwkoBqBRNfxqusylEKp6g/yF
         u65XnI3fEH2/KpB0XMqavJyuQYMyq3n3RaTgF06awpCKaiEUhRhbNZMSq8kONKIR1G
         Wq5JwW2jIwr9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC3F3E3309C;
        Wed, 19 Apr 2023 14:41:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     quic_msinada@quicinc.com, ath11k@lists.infradead.org,
        quic_akolli@quicinc.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, robert.marko@sartura.hr
Message-ID: <20230419-b217299c11-fb15135c977f@bugzilla.kernel.org>
In-Reply-To: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
Subject: Re: ath11k: regression with 80+80 and 160MHz channels
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Mailer: peebz 0.1
Date:   Wed, 19 Apr 2023 14:41:05 +0000 (UTC)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_FROM_NAME_TO_DOMAIN,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

kvalo writes via Kernel.org Bugzilla:

Fixed by:

https://git.kernel.org/kvalo/ath/c/b100722a777f

View: https://bugzilla.kernel.org/show_bug.cgi?id=217299#c11
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

