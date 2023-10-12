Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1A7C71E3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbjJLPyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 11:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbjJLPyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 11:54:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA1AB8
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 08:54:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDE9C433CA
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697126084;
        bh=tPJ9KrNVeE06pPoJlJHfmSHhz2Dtk0XGoPa/vNvC3MQ=;
        h=From:To:Subject:References:Date:In-Reply-To:From;
        b=nukdWWoOVN6S5cw+AUaCO5/JhQveymGlYU1akTShs5svn1OSrMsLwLuCbnw2gYrKW
         1aI73rNvhy7MzUWsRJdPxZDgqQFfawG/ldX4EhcDh8nrND9dDKWm3LaBC2J11DVWNg
         CoIjk75g0BfLrANX4I1XOOyYwYdVJoofgWzRXJ4pJ2/sx/OFTqbzp3bSHJ3mPypdmU
         YRBzw9DFkCnYMBC2R3gG4ajWW/fzIzrwpyybnIYPMmMg4Dio+ILNPwSKgwLIJnWU+i
         Rk6pG+f/1kAks1LqEr9p7KajdOYGxQc+e19WCLs/RMsPAglnOV3hlV3vVyCkf+SQNh
         xUO/Yz3ctbtWw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: iwlwifi: fix format-truncation warnings
References: <20231012140251.3473708-1-kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 18:57:16 +0300
In-Reply-To: <20231012140251.3473708-1-kvalo@kernel.org> (Kalle Valo's message
        of "Thu, 12 Oct 2023 17:02:51 +0300")
Message-ID: <87bkd3g7fn.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> On v6.6-rc4 with GCC 13.2 I see:
>
> drivers/net/wireless/intel/iwlwifi/dvm/main.c:1467:19: warning: '%s'
> directive output may be truncated writing up to 63 bytes into a region
> of size 32 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/dvm/main.c:1465:9: note: 'snprintf'
> output between 1 and 64 bytes into a destination of size 32
> drivers/net/wireless/intel/iwlwifi/mvm/ops.c:1307:19: warning: '%s'
> directive output may be truncated writing up to 63 bytes into a region
> of size 32 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/mvm/ops.c:1305:9: note: 'snprintf'
> output between 1 and 64 bytes into a destination of size 32
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:549:33: warning: '%s'
> directive output may be truncated writing up to 63 bytes into a region
> of size between 48 and 56 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:547:9: note: 'snprintf'
> output 9 or more bytes (assuming 80) into a destination of size 64
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:729:33: warning: '%s'
> directive output may be truncated writing up to 63 bytes into a region
> of size between 48 and 56 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:727:9: note: 'snprintf'
> output 9 or more bytes (assuming 80) into a destination of size 64
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:989:51: warning: '%s'
> directive output may be truncated writing up to 63 bytes into a region
> of size between 46 and 58 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:987:33: note: 'snprintf'
> output between 7 and 82 bytes into a destination of size 64
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:984:53: warning: '%s'
> directive output may be truncated writing up to 63 bytes into a region
> of size between 40 and 50 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:982:33: note: 'snprintf'
> output between 15 and 88 bytes into a destination of size 64
>
> Two of the warnings were easy to fix by using strscpy(). But the rest were more
> challening. For now I was only able to come up with artificial testing of
> snprintf() return value but that doesn't make really sense. I marked the ugly
> once "FIXME" in the code.
>
> Any ideas how to fix the warnings properly?
>
> Compile tested only.
>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

I didn't notice that Gregory had already submitted a patch:

https://patchwork.kernel.org/project/linux-wireless/patch/20231012153950.f4465b4b4e2b.Idced2e8d63c492872edcde1a3ce2cdd6cc0f8eb7@changeid/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
