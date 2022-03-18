Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AE14DD8C2
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiCRLLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Mar 2022 07:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiCRLLm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Mar 2022 07:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B3160694
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 04:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E624C6172C
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 11:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0354DC340E8;
        Fri, 18 Mar 2022 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647601823;
        bh=ILk3uFGMUCXr+XEUkP8BHLCmfpJ7GIdoV+EMW7yerUc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Uuk9GjSc2xnI6Kz5BfJNfqW0dJiKDN9tuqEec1EzUEleftAitqcc8/pzcn5Fl3vE1
         pqAp5KM6/DcuSLF2zH4UuLVZgM52nwjnw/WrrJZL61a6mat3NM2MLgCYIv1nFAGizK
         oId032+ABK+CkH00brnmvKhrKuymzSQaxAnO8dAAWgSFstxiGlIkWO83T1LrRNvx8V
         aEY3+O4bGCeY2q5yuidRnbo3F0OGgIeQOopV4BckzU6Q+yL04yL/xzgkFw6uTOB3Lr
         ksXBsmlLAcVbzcSyzU/1xs5E0Lu/T43tLGJI+kNS1OtamYXBDb5VQm+PXkWhY2po6/
         QwZr7nXXtSAkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rfkill: make new event layout opt-in
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220316212749.16491491b270.Ifcb1950998330a596f29a2a162e00b7546a1d6d0@changeid>
References: <20220316212749.16491491b270.Ifcb1950998330a596f29a2a162e00b7546a1d6d0@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164760181908.1508.6458450052251228118.kvalo@kernel.org>
Date:   Fri, 18 Mar 2022 11:10:21 +0000 (UTC)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Again new complaints surfaced that we had broken the ABI here,
> although previously all the userspace tools had agreed that it
> was their mistake and fixed it. Yet now there are cases (e.g.
> RHEL) that want to run old userspace with newer kernels, and
> thus are broken.
> 
> Since this is a bit of a whack-a-mole thing, change the whole
> extensibility scheme of rfkill to no longer just rely on the
> message lengths, but instead require userspace to opt in via a
> new ioctl to a given maximum event size that it is willing to
> understand.
> 
> By default, set that to RFKILL_EVENT_SIZE_V1 (8), so that the
> behaviour for userspace not calling the ioctl will look as if
> it's just running on an older kernel.
> 
> Fixes: 14486c82612a ("rfkill: add a reason to the HW rfkill state")
> Cc: stable@vger.kernel.org # 5.11+
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless-next.git, thanks.

54f586a91532 rfkill: make new event layout opt-in

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220316212749.16491491b270.Ifcb1950998330a596f29a2a162e00b7546a1d6d0@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

