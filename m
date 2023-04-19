Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F36E78B5
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 13:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjDSLhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjDSLhN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 07:37:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0FB97
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 04:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C344A62C54
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 11:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7564C433D2;
        Wed, 19 Apr 2023 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681904229;
        bh=sP0wkLWC2lvC54cBoiO0IVOYkXO8B40pum1kdNnjGes=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Nmquq1PS205gER9nW2x7DofcwDcklOKQtXkYy0MKaz9a/rl1ROBElO+XoeTeCLHCR
         tCmFvT+u96b8SGEo0kGfatEIOMUiJpccX+4JB7H6W1GmtZoygK3HEcY6Y1EParPvtK
         ah4AN0BfxfGj2X7YyzQkyw3CAYd1eaQNr7BxnNs/orp9/0X4eULiI26E3fIqPJgw88
         NWf7xNFNXo0a2Ujek3a35GmXxF4w2rbL3561f4VN7Rnml3QJ06xOuucHPyME5aB0ev
         9gWROumlPkp9scHRl/IOvQD/j/dWJbn4DHPMM6+TekSXKqUB9W77aZXzRTwFpXCfE6
         lKVtvrJzRSOyg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/2] wifi: cfg80211: Add short_beacon_tail/head/period
References: <20230417012151.2512303-1-gilad.itzkovitch@virscient.com>
Date:   Wed, 19 Apr 2023 14:37:01 +0300
In-Reply-To: <20230417012151.2512303-1-gilad.itzkovitch@virscient.com> (Gilad
        Itzkovitch's message of "Mon, 17 Apr 2023 13:21:50 +1200")
Message-ID: <87ttxcqf1e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com> writes:

> From: Kieran Frewen <kieran.frewen@morsemicro.com>
>
> Support variables to handle short beacon period and adding a
> separate tail/head for them. Also, add short beacon period,
> head and tail attributes for user configuration.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304131044.Y2mHsqp7-lkp@intel.com/
> Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
> Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
> Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
>
> v5:
>  - initialise s1g beacon variables to false
> v4:
>  - squash cfg80211 commits together
>  - add protection for short head/tail with S1G band check
>  - better validation rule for short_beacon_period
>    and align its types
> ---

We (wireless) prefer that the changelog is after the "---" line. Not
sure if Johannes can fix that during commit or not.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
