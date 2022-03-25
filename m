Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803D34E717D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 11:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbiCYKqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 06:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiCYKqh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 06:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45436C967
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 03:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EFED61744
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 10:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800F5C340E9;
        Fri, 25 Mar 2022 10:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648205102;
        bh=iFa06lDX4ZDX8oQfRM+qTbuZs+1jOAO3pJ0t+GgyL2w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WP+CXiC6Khd16aF7TkiYmU4/EbZC9OEJ6TcHLYxykFAqWrpGnFslnJRgwY1mCYFzt
         WPG+QZBhVNSI/zT4oozKjgiYbvyPDlfYmll+oX6lByrtE9hQIYRF9CxNWTE6ChhS4S
         GXXOt3RU4pIFxV1FdnrH+nmShswahDs4Vzezts5RNfFxc+80X/miY4FV9NMQY/63QV
         8rvtbONN9K7D8popcl2B+svhy3/edLrAgbudy3vErHpaU2z0QwyiD01CZ04wtOiuWr
         OHqeCDxhs4z9I8fy5FCMFTRAq3tiJdVjpfrhIw/A2ae+kIuhnUzCkq+NiyweeOnQhm
         dLcVhLwmPDzPg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Rameshkumar Sundaram <ramess@qti.qualcomm.com>
Cc:     "Rameshkumar Sundaram \(QUIC\)" <quic_ramess@quicinc.com>,
        "johannes\@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: Re: Recall: [PATCHv3] mac80211: disable BSS color collision detection in case of no free colors
References: <DM6PR02MB4937B7DC9B6609463E435794E91A9@DM6PR02MB4937.namprd02.prod.outlook.com>
Date:   Fri, 25 Mar 2022 12:44:55 +0200
In-Reply-To: <DM6PR02MB4937B7DC9B6609463E435794E91A9@DM6PR02MB4937.namprd02.prod.outlook.com>
        (Rameshkumar Sundaram's message of "Fri, 25 Mar 2022 07:34:27 +0000")
Message-ID: <87tubmux94.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rameshkumar Sundaram <ramess@qti.qualcomm.com> writes:

> Rameshkumar Sundaram would like to recall the message, "[PATCHv3]
> mac80211: disable BSS color collision detection in case of no free
> colors".

Please don't send recall messages, they are just spam for most people.
And does anything else than Outlook even support this feature?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
