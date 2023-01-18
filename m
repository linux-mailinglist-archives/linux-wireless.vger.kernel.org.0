Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6136714AD
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 08:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjARHNF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 02:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjARHMj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 02:12:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF096FFA0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 22:37:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71F5BB81A3E
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 06:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7C9C433D2;
        Wed, 18 Jan 2023 06:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674023814;
        bh=rMt7RLBg+8UgFhPbYQja+uE8JR12ZtZAkrWUxIpGEg8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rp9gWJ00bkUn6AbhMl9kkRPzORTuVNr6xqZ47/78O8TwJ4aZJ4RYMaW6D4qXSDBXb
         ooF0XixG4yONiHjr1NrcPXje/BWN+SlBcBNavzzCW0JuX961fimcYKgG9+kkXgtsv1
         P2IcLn0z5/6tFelaSCN30uZ5njohXMWH+aZ60PM6t8SaWZf2MoxvhdhcCor3xHVoPx
         9u6zTmIypYrIh7OdtUi+9ARWw2dsHJQ0D3nz7uqFSLJnTEpBIpZNyauPVZn/dr/aFn
         37LvIi4NXY6p0nfmpb3+2H+3CM5VJnQhtgFhO/znJFA4ApF3LgT2vkda2ZA8BMIGH4
         /ERrfPAebbpHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath12k: hal: add ab parameter to macros using
 it
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221220120655.19389-2-kvalo@kernel.org>
References: <20221220120655.19389-2-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167402381127.24104.9379612780147081639.kvalo@kernel.org>
Date:   Wed, 18 Jan 2023 06:36:53 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> It's considered evil if a macro is using a variable but not having the variable
> as a parameter. So add the ab parameter to macros using that.
> 
> No functional changes.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

1a8dc2eb5b4e wifi: ath12k: hal: add ab parameter to macros using it
f8209eef730e wifi: ath12k: hal: convert offset macros to functions
cfec785c7662 wifi: ath12k: wmi: delete PSOC_HOST_MAX_NUM_SS

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221220120655.19389-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

