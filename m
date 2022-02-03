Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4E14A8044
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 09:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbiBCIZi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 03:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiBCIZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 03:25:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D8C061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 00:25:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23D98B83220
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 08:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35276C340E4;
        Thu,  3 Feb 2022 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643876734;
        bh=pvs9vkPw5MF4bHVhBTSi/niT9/4LwtJs964u2BnIXbs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uL3+gb8cyN3ho++PloKKM6Ap13C+AZSucSxMZ80uoN8klW3bqH+VomoAKlb310LaQ
         65hZTQdNphGG0ZZB8Jo7ZHFkcTIX68BaILo2R7ALCXQlxLvQMoP9UerqIJ2KFoKD8A
         m4LurQ9iZx99Wg9Wo2ZH33L/wOYmVuGUnEd2trBblxoqXRHSv3Kx1utslJcCFLb2VV
         BFY3ED250+JvdPAdBi3hB5ndfpoexA+HO8jPW2jI5jgiP9C0T3IT56JSckHpHFGZXt
         lZVjZC4dt0q5poP8AwsXT1eUidluS7ftkNUHe5W5THsjXcCGNMUJ3r6CuhSPUsMrEU
         e3bn81cKmB0Ug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH for v5.17 1/8] iwlwifi: mvm: fix condition which checks
 the
 version of rate_n_flags
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <iwlwifi.20220128142706.a264ac51d106.I228ba1317cdcbfef931c09d280d701fcad9048d2@changeid>
References: <iwlwifi.20220128142706.a264ac51d106.I228ba1317cdcbfef931c09d280d701fcad9048d2@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164387672743.14378.5149309511977046730.kvalo@kernel.org>
Date:   Thu,  3 Feb 2022 08:25:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> 
> We're checking the FW version of TX_CMD in order to decide whether to
> convert rate_n_flags from the old format to the new one.  If the API
> is smaller or equal to 6 we should convert it.  Currently we're
> converting if the API version is greater than 6. Fix it.
> 
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Fixes: dc52fac37c87 ("iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES versions")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

8 patches applied to wireless.git, thanks.

be8287c9b832 iwlwifi: mvm: fix condition which checks the version of rate_n_flags
973f02c932b0 iwlwifi: fix iwl_legacy_rate_to_fw_idx
e9848aed1477 iwlwifi: pcie: fix locking when "HW not ready"
4c29c1e27a1e iwlwifi: pcie: gen2: fix locking when "HW not ready"
e1849784de9b iwlwifi: mei: fix the pskb_may_pull check in ipv4
44bf7c4667ef iwlwifi: mei: retry mapping the shared area
7cf800f46e07 iwlwifi: mvm: don't feed the hardware RFKILL into iwlmei
30de48b436a0 iwlwifi: mei: report RFKILL upon register when needed

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20220128142706.a264ac51d106.I228ba1317cdcbfef931c09d280d701fcad9048d2@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

