Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E44E653D05
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 09:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiLVIck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 03:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVIci (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 03:32:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230AE0C4
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 00:32:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB5C1B80185
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 08:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F57C433D2;
        Thu, 22 Dec 2022 08:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671697955;
        bh=0/K+/h8AKESJVT9RKA6JugiMWpAM4vJLoS7UncID/eA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Hfe5J5UATX0q0Ackta/rUXzKfat7JRTSreqaQXltzapNVMkBlh1Va8va+J+gShUPW
         UL+tuy66YChnXokLWDSENNLbxH6922FGE6Jtde9PehQotft3TgA8wd7asqMUNhCDkF
         tabX2BFm5NZmCwsskm4gBulwcsbEYUeRWycqnIYqEWeSj3HYvHKxWCRvhV9vuIiJKn
         TJ3InP+Cm7xosAL1DpxDn9jjiX/lUcqbmPQYYGC/u2Lb/Jd/z5IaTmi7zHvkLXvCdy
         gp4ih2fI94ipSVCb6JXpd51rJt3Smux7bvY4gLvS9lCbd5ySZGBa8nQX5vDWOeD5/9
         BwkXfC2CpUz2Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jaewan Kim <jaewan@google.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] iw: info: fix bug reading preamble and bandwidths
References: <20221220134233.2307164-1-jaewan@google.com>
        <20221220134733.2309329-1-jaewan@google.com>
Date:   Thu, 22 Dec 2022 10:32:32 +0200
In-Reply-To: <20221220134733.2309329-1-jaewan@google.com> (Jaewan Kim's
        message of "Tue, 20 Dec 2022 22:47:33 +0900")
Message-ID: <87ili3kfdr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jaewan Kim <jaewan@google.com> writes:

> Signed-off-by: Jaewan Kim <jaewan@google.com>

Empty commit logs are frowned upon. Even if the bug is simple there
should be a some kind of commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
