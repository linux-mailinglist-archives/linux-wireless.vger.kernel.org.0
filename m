Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7756D76CB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 10:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbjDEIZE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbjDEIZC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 04:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF541FE8
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 01:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74F8A622F2
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 08:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9513C433D2;
        Wed,  5 Apr 2023 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680683100;
        bh=y/wyS1wybskgY3NT3qvYlhAj/QT7MG9Mf7/tNstaFbg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=tEWPde6v5O5Fpb4rSsKWNahmteWdXVmcqIQnoQ4mWFU8EFg3tjnBCjePa1W7YfFW1
         wOtRDKzzA2vvHSG3hWLcBuWa1j6twfuBpFNOpBfrHcV4poYkgnmaqFOvsfD/spUBv0
         HC96N8MlsNxk8fVQMucVjiOXEd6c3cwfAN0A/juTC4NR7Ix4U5vCRTbymXQMnhf6mG
         YcSEWkR+Qoj2frXvxKZz5ssWroCV0jQnIAzq3yB/ZSWCVgan22KJzIRrZQsrqyEfKU
         ksblnsJxWJ36GRTMQsVgLwTN6BffEL4AdMMU/J4dfwpVvwWpy4RJBB/LkiHwF62Te9
         Q4n8GwxFFFoOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B9FFC4167B;
        Wed,  5 Apr 2023 08:25:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     bugs@lists.linux.dev, linux-wireless@vger.kernel.org,
        quic_msinada@quicinc.com, ath11k@lists.infradead.org
Message-ID: <20230405-b217299-ec3c4e9b0c8a@bugzilla.kernel.org>
In-Reply-To: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
Subject: Re: wifi: ath11k: push MU-MIMO configurations to hardware
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Wed,  5 Apr 2023 08:25:00 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello:

This conversation is now tracked by Kernel.org Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=217299

There is no need to do anything else, just keep talking.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

