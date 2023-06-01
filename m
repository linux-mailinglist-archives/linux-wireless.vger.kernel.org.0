Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7160A7191D4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 06:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjFAE0C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 00:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFAE0B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 00:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA3101
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 21:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D84663689
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 04:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43292C433EF;
        Thu,  1 Jun 2023 04:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685593559;
        bh=V7fI4XEjnNZk+iN+EP2u/wmo7xyoIyh84s6MyENF4BU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KrSwinupbKOXFA8VvXcp0Re81B5LQWHZAgo3YQWszpx6rFPMCiIEmQaKhcf3PAQX9
         KFcr0DDWS3gfunujmUtODiKvRakiANvY79H8p2HtsINikzbHg9H+QTR8OTM/F7129N
         W2GTYsxltEjKseTfVY+M5CyMtqJMPZCoF7K1e3V2ePy41ocX1Xrb8pVLCWYR/4IbgX
         HMjHjpp8CswssPXHXuKM1oNN1aKFWb7lBGiV3uuu86dlks9fD5J6vdCATJGQfM3tz8
         vYCf6EuXrR15xUTZzpsjONM7DVSpxmglBkjfz+NJKkUdFjBlZQn0JQv04H+fZTKEy6
         9ISLMeo7Yw6aA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Neal Sidhwaney <nealsid@gmail.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH] wifi: brcmfmac: Detect corner error case earlier with log
References: <CAJ4cxaQiYWEOmf9sZHsvXqYc_SKSg2dm5jQvifa82+o+W41aNw@mail.gmail.com>
Date:   Thu, 01 Jun 2023 07:25:54 +0300
In-Reply-To: <CAJ4cxaQiYWEOmf9sZHsvXqYc_SKSg2dm5jQvifa82+o+W41aNw@mail.gmail.com>
        (Neal Sidhwaney's message of "Wed, 31 May 2023 22:23:48 -0400")
Message-ID: <87h6rrkdv1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Neal Sidhwaney <nealsid@gmail.com> writes:

> In some corner cases, an I/O read can fail and return -1, and this
> patch detects this slightly earlier than is done today and logs an
> appropriate message.
>
> Signed-off-by: Neal Sidhwaney <nealsid@gmail.com>

From looking at patchwork the patch seems to be malformed:

https://patchwork.kernel.org/project/linux-wireless/patch/CAJ4cxaQiYWEOmf9sZHsvXqYc_SKSg2dm5jQvifa82+o+W41aNw@mail.gmail.com/

I strongly recommend using git-send-email to submit patches to avoid
issues like this, more info in the wiki link below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
