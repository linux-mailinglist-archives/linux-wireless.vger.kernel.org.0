Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590C446DAD8
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhLHSTB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 13:19:01 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38426 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhLHSTA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 13:19:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99FB2CE228E
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 18:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30D4C00446;
        Wed,  8 Dec 2021 18:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638987325;
        bh=JMmarYvhDm8d1m5LolRG+N7hzBElupbuo1uj2UWNfGE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hdMLiiX996D0Xke1UyuI9mAUOzbcFvxzVX3QLjOwvPalnc9enpkYMdjzBvvI5vyf1
         UrjXI7EQvpJB/7KevHnpT0PtuW4YM2mL6WaP97x3Gs3hcTV6vIsfC8inT9jNsPiKh1
         s6S+8Xde7/XuS1yYJ565g3VvP6pNv5/3Ayx5A3iTiMxrKGOOCKVKkzmJgY+M/xsJkg
         y7Ay3pK9MXHTAVNfP4RwLSjaIr9OsOs2SYbm6rDYQnxzsrqNniB/W4v51+dQUsYNso
         2le8hmB11aGSSDxaBEhfcB8eSVu4kdfs3DKmwRaW2xb12ZI21rDY6svQX9E527foj5
         zRvZKHGuAhAVQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH for v5.16] iwlwifi: mvm: don't crash on invalid rate w/o
 STA
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <iwlwifi.20211203140410.1a1541d7dcb5.I606c746e11447fe168cf046376b70b04e278c3b4@changeid>
References: <iwlwifi.20211203140410.1a1541d7dcb5.I606c746e11447fe168cf046376b70b04e278c3b4@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, luca@coelho.fi,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163898732063.8681.9902761651506738915.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 18:15:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> If we get to the WARN_ONCE(..., "Got a HT rate (...)", ...)
> here with a NULL sta, then we crash because mvmsta is bad
> and we try to dereference it. Fix that by printing -1 as the
> state if no station was given.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Fixes: 6761a718263a ("iwlwifi: mvm: add explicit check for non-data frames in get Tx rate")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

d599f714b73e iwlwifi: mvm: don't crash on invalid rate w/o STA

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20211203140410.1a1541d7dcb5.I606c746e11447fe168cf046376b70b04e278c3b4@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

