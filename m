Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91BB53C8D7
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbiFCKiF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbiFCKiC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 06:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBCE3BBF6
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 03:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B35A060AB3
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 10:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F512C34114;
        Fri,  3 Jun 2022 10:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654252679;
        bh=/k8PznFyRZuvrNCDkSbEbNKLfcYHfATv3sZBKBsR0Ng=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W2u1DWZtJu8uHYJaAqHcqrTsYfjaa4Vd85cMWi6aDUFc443zWU3vp0kllWa5ZlECE
         KLYo4bDWTXpDkilr76yzDPAn4ADpJCCvyQ8mkuds2xqSzhJpfcmk/sNiyV64fd8P/4
         1BFzMJPdVshCFuhRCX6ggZN2JBscn50hHPG2bx9HHpXGPLz6kcq2IsJsnWKYMFOUed
         tNhz/JBDCP0e82zcdV5okHF+PBpqv/OG2lrTx+xk5nG0zPbTXgiTYuz2WvI4I0TIEj
         FMrlsJn4TOZorM3B/wy23bhaYaR+8e9SYBCfwLcGVkwEItEMgJfBciS81euDyEzf7A
         Jf9ubsWtif6EQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Aditya Kumar Singh \(QUIC\)" <quic_adisi@quicinc.com>
Cc:     "Jeff Johnson \(QUIC\)" <quic_jjohnson@quicinc.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k\@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: Re: [PATCH 1/2] ath11k: move firmware stats out of debugfs
References: <20220602051425.9265-1-quic_adisi@quicinc.com>
        <20220602051425.9265-2-quic_adisi@quicinc.com>
        <07248432-bf0f-e2d5-6ada-61c66337f295@quicinc.com>
        <DM5PR0201MB3589A92F02DBAA0A26B8BF8684A19@DM5PR0201MB3589.namprd02.prod.outlook.com>
Date:   Fri, 03 Jun 2022 13:37:54 +0300
In-Reply-To: <DM5PR0201MB3589A92F02DBAA0A26B8BF8684A19@DM5PR0201MB3589.namprd02.prod.outlook.com>
        (Aditya Kumar Singh's message of "Fri, 3 Jun 2022 04:23:04 +0000")
Message-ID: <87r146m3r1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

"Aditya Kumar Singh (QUIC)" <quic_adisi@quicinc.com> writes:

> Sure, will address in v2. Thanks for pointing out.

Please edit your quotes. You had over 500 lines of quotes in your one
line reply, this makes it horrible to use patchwork:

https://patchwork.kernel.org/project/linux-wireless/patch/20220602051425.9265-2-quic_adisi@quicinc.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
