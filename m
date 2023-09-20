Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85F67A7106
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 05:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjITDgk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 23:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjITDgj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 23:36:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72809F
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 20:36:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84630C433C8;
        Wed, 20 Sep 2023 03:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695180993;
        bh=EdUVZ07sJwQ3a76LpnnAsRSzwpDUz+5zvHA1l9TrDtA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WQwaD1cfMWV6surSFZD5E/+T6LvdSt1M7HmXKZZt5hOQJkR+ZNgmgGVjIENhQ0Sjs
         4SSEQpB1di08mfna0LzRZV4994VQKduR57XwMqVW2N088yJlaYicTf1TCsktMMCfuc
         tNZ36yrQAQiOtFPBIT9R01eV8IWzn7MZds7kT1Ov2qIAIi+xPNSLXmlQ/nk/UWIF2s
         2p4W+LrKSLZNiL0Crcw+Gg4Byi3OR/iSdKoP/77LhL615t0//i/fBv1qV61ruM+GAf
         KgpkY/FSiQ+NWNWAYMjEiL1bFrXw47uRfx7fRjR73Z1KTNQO4PhC93WE8/ADDKzTza
         luT1rDNMTkXuA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH wireless] wifi: mt76: mt76x02: fix MT76x0 external LNA
 gain handling
References: <20230919194747.31647-1-nbd@nbd.name>
Date:   Wed, 20 Sep 2023 06:38:22 +0300
In-Reply-To: <20230919194747.31647-1-nbd@nbd.name> (Felix Fietkau's message of
        "Tue, 19 Sep 2023 21:47:47 +0200")
Message-ID: <87zg1hjyz5.fsf@kernel.org>
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

Felix Fietkau <nbd@nbd.name> writes:

> On MT76x0, LNA gain should be applied for both external and internal LNA.
> On MT76x2, LNA gain should be treated as 0 for external LNA.
> Move the LNA type based logic to mt76x2 in order to fix mt76x0.
>
> Fixes: 2daa67588f34 ("mt76x0: unify lna_gain parsing")
> Reported-by: Shiji Yang <yangshiji66@outlook.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

I assigned this to me on patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
