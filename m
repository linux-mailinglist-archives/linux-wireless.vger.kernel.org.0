Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31635E5B1E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 08:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIVGJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 02:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIVGJK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 02:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD25B4EB8
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 23:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 382F16288A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 06:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46FDC433D7;
        Thu, 22 Sep 2022 06:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663826948;
        bh=x/iCfQzPAXDIwUoPt0mQ5jkrG6NVdWzzEv34BR4dyZg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CDJTKYo7iMXfpV/z5lZkjD+xvvtZCvUC/RqVnaPMJXSGnK2bcv+1g4RwVfzL+ouGv
         rZfsy9I2QH/C67Od6rOoR+myHzJrZ4TAm7AKX/rE8X77+J4gmMmqyhSGVtvX8R9ntV
         W8OzriOFz2OLOSNn7I3GdUY8r26bHnVPlYTA5xJ5eAgvGgqcL+XOHWVDN/hL4Usy6E
         D4RpSDUH7H2Tx4QSguJpYxrHGsnNGy8Xb2vnOP5V4TyTi1MBl4H9eoDPW3NynTWoXs
         XJ23sOXN7DJjaKujKqmJSyi7Z5X/c4e/qb7HqtWsJ2TwpLsBBzUlHE7iTes0aVZut1
         bgq8PH0cU0A0w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/12] wifi: ipw2x00: fix array of flexible structures
 warnings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220904212910.645346411660.I471e8fadce54ea262920828f25b8e84545bcd07e@changeid>
References: <20220904212910.645346411660.I471e8fadce54ea262920828f25b8e84545bcd07e@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166382694569.9021.3076206794710420639.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 06:09:07 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are a number of these here, fix them by using
> appropriate casts. No binary changes.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

3 patches applied to wireless-next.git, thanks.

28255dd9a8de wifi: ipw2x00: fix array of flexible structures warnings
c70a9d6783cf wifi: rndis_wlan: fix array of flexible structures warning
4cf4cf6eb0bf wifi: mwifiex: fix array of flexible structures warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220904212910.645346411660.I471e8fadce54ea262920828f25b8e84545bcd07e@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

