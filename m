Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921EB66BCDF
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 12:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjAPL1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 06:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjAPL1d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 06:27:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7741F49D
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 03:27:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E163F60F75
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 11:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361C3C433F0;
        Mon, 16 Jan 2023 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673868435;
        bh=o/AV6yVHzBm979jnIN2UDWTIbHtO4qLRWDdLrOSYV9M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=caIgAHuwGYx/pjwux2d25j/pwxOMdrOb5XtuLhzVklod0q8lXrz1ElGwDUt0isCz4
         Fm9d/1bz32NEVVKmAJV2yYIQVmbyujFTzncEQ09KSw5fVxkzcOkE+y0eKLoZ3z+wWa
         uMcG5grFseT2lJBXa4dbZyeCZiMAgolsyD3i2uT1Yhqa06GIZ16UpEShWyEihTzK6p
         OC76npChW7Fa2/ZLhymCNQfEwm/b9qIAduskGTUKqVpNiM/+aeZan1X/R5vl+FVErH
         1bgMZMMxcRr62tycn7sF4a+Pykgy3TVXIEo5ROUMrAqUoZnrdAQ2JsM/JY0J7PIKof
         Db/nwhZJNUDQA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [V2] wifi: brcmfmac: fix regression for Broadcom PCIe wifi
 devices
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230111112419.24185-1-arend.vanspriel@broadcom.com>
References: <20230111112419.24185-1-arend.vanspriel@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        chainofflowers <chainofflowers@posteo.net>,
        Christian Marillat <marillat@debian.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167386843217.4736.4067058456953196067.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 11:27:14 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> A sanity check was introduced considering maximum flowrings above
> 256 as insane and effectively aborting the device probe. This
> resulted in regression for number of users as the value turns out
> to be sane after all.
> 
> Fixes: 2aca4f3734bd ("brcmfmac: return error when getting invalid max_flowrings from dongle")
> Reported-by: chainofflowers <chainofflowers@posteo.net>
> Link: https://lore.kernel.org/all/4781984.GXAFRqVoOG@luna/
> Reported-by: Christian Marillat <marillat@debian.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216894
> Cc: stable@vger.kernel.org
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless.git, thanks.

ed05cb177ae5 wifi: brcmfmac: fix regression for Broadcom PCIe wifi devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230111112419.24185-1-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

