Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B654E7159
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353563AbiCYKgS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 06:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358908AbiCYKgR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 06:36:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A6C627B
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 03:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD2BCB82703
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 10:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F540C340E9;
        Fri, 25 Mar 2022 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648204478;
        bh=JEgbcGk0OMkDG1OwGkXfDwtBIYLBLq3rTJjF0Vu0R5Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X1de9OKnUurhO/C7sI+QoJh06Y5wPBR+DenqUHzVnzf4ljPIKt39so5ll20Eff4+R
         JW7OSnaOcDtp5W1DLsIt+SBG4LjIJrhgInGcS/WlW5HXD09DWe+KlPvdeWxsFysy0J
         0pOvvZlxXl843q+XtMO5S5QQcxtmK89im/UJpONue2qbWKDjtp07EYDR6pISl1c0Ep
         4L9k6+n8FCguR0J8i5rilYbfJKpOenyLeVtNnevIeJErQ6hPzsI//otZZGkpz4rNqG
         AYsEbVKO2jj6flCNbyD8AUjb1T1jk5zXD0CHSVqE2/FxAfXA8J1PYyqCd/ltf/yvfD
         gfqguHxH9kvCQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] ath9k: make ATH_SREV macros more consistent
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220320233010.123106-2-wlooi@ucalgary.ca>
References: <20220320233010.123106-2-wlooi@ucalgary.ca>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Wenli Looi <wlooi@ucalgary.ca>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164820447100.12637.9228708228356153188.kvalo@kernel.org>
Date:   Fri, 25 Mar 2022 10:34:37 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> wrote:

> This makes the macros more consistent and removes hidden dependencies on
> ah for macros that take _ah as a parameter.
> 
> This change does not appear to affect the final binary.
> 
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

6 patches applied to ath-next branch of ath.git, thanks.

26c31016fe7e ath9k: make ATH_SREV macros more consistent
a96474a794e1 ath9k: split set11nRateFlags and set11nChainSel
3096a4d9eb9b ath9k: use AR9300_MAX_CHAINS when appropriate
9aaff3864b60 ath9k: fix ar9003_get_eepmisc
193025378c44 ath9k: refactor ar9003_hw_spur_mitigate_ofdm
673424ce0e77 ath9k: add functions to get paprd rate mask

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220320233010.123106-2-wlooi@ucalgary.ca/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

