Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D41762CD0
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGZHN3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 03:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjGZHM4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 03:12:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F244EFD
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 00:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80376171A
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 07:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F6EC433C7;
        Wed, 26 Jul 2023 07:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690355345;
        bh=NwnoI/eHfBR3fSLAIrmDgyunZibD6RNBhonHwKan8Xo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XRqpgTOHWP53S5BfUEkhPBaM6gL7pwj5GasDZl/o+KKllBPPrPZWzlNZ9KmsuAc7n
         1mZrUyCjlXSbbdLp26Vai6QYUV0GQW0sbvPml+DlzUJITBzdQypSr8A4uYDe2+yfPE
         mCO4ILsMVgAG1GZZPqoiK240IHEIRnCPwYmFqLAveRRpcAGW5t6thyg4KLJ6qnP2To
         GvB9Y+kSJqYo7jbWQCri2H2vMo1HL7OG88SsNebfe8ChndMY1tx7e+4scuZ1m262ZS
         dwa7uPF3M6QeGYjIOVZfMNpgi9wReKNbefi6GkDc6t3uInhA+ZzZRMfqqc/NlY0rnw
         D0B6PYD8coK+Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: cfg80211: Fix return value in scan logic
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230723201043.3007430-1-ilan.peer@intel.com>
References: <20230723201043.3007430-1-ilan.peer@intel.com>
To:     Ilan Peer <ilan.peer@intel.com>
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169035534220.3467307.604241930680455122.kvalo@kernel.org>
Date:   Wed, 26 Jul 2023 07:09:04 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ilan Peer <ilan.peer@intel.com> wrote:

> The reporter noticed a warning when running iwlwifi:
> 
> WARNING: CPU: 8 PID: 659 at mm/page_alloc.c:4453 __alloc_pages+0x329/0x340
> 
> As cfg80211_parse_colocated_ap() is not expected to return a negative
> value return 0 and not a negative value if cfg80211_calc_short_ssid()
> fails.
> 
> Fixes: c8cb5b854b40f ("nl80211/cfg80211: support 6 GHz scanning")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217675
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>

Patch applied to wireless.git, thanks.

fd7f08d92fcd wifi: cfg80211: Fix return value in scan logic

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230723201043.3007430-1-ilan.peer@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

