Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCCC537886
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 12:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiE3JNx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 05:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiE3JNw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 05:13:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D645D19D
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 02:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 825ECB80C94
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 09:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F3EC385B8;
        Mon, 30 May 2022 09:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653902027;
        bh=v7vsrV3PTEK1ClFtBOkyaQrxZYU1Fp6O1gOrnCuYX/8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=foLyqnYpKyYI8CpeBQs5bc+0YfRNyUcSTNJb5ZnLhSUV/u10sm0/z6NQZlFNT9NIJ
         wnp5EAfjmDw0Q7MCpYrxtr4HmEoOMnPTtVPRMONFWFIc4EWPgR9jhfdd2rqRmhIQJW
         89Fs7xwrlcyQ3BTooh4QriIwnKSfeZaQoL2pNzuo6Y6zOf1YVy9AJHCESfA4Ur6sg1
         D18qyVGodRMEHQmxUMvZN8sy3S7FqkTmPe7o2oLita+UfIM/yDOkj4f4kyjrpN5L8L
         3xjv6x9hRA1oTjUyjD0FSOK64qSmOwSIqEEk7FWYNebtRW1vHFOtgcMEbCZFfW8NkA
         0TquUWOjPQEeQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: libertas: use variable-size data in assoc req/resp
 cmd
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
References: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165390202128.17496.8793271919986651475.kvalo@kernel.org>
Date:   Mon, 30 May 2022 09:13:45 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> The firmware has a 512 limit here, but we use less, so gcc
> starts complaining about it:
> 
> drivers/net/wireless/marvell/libertas/cfg.c:1198:63: warning: array subscript ‘struct cmd_ds_802_11_associate_response[0]’ is partly outside array bounds of ‘unsigned char[203]’ [-Warray-bounds]
>  1198 |                       "aid 0x%04x\n", status, le16_to_cpu(resp->statuscode),
>       |                                                               ^~
> 
> Since we size the command and response buffer per our needs
> and not per the firmware maximum, change to a variable size
> data array and put the 512 only into a comment.
> 
> In the end, that's actually what the code always wanted, and
> it simplifies the code that used to subtract the fixed size
> buffer size in two places.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Acked-by: Kalle Valo <kvalo@kernel.org>

Patch applied to wireless.git, thanks.

d944e09ea839 wifi: libertas: use variable-size data in assoc req/resp cmd

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

