Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E17B680C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjJCLe5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 07:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbjJCLe4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 07:34:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BB2E5
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 04:34:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D9EC433C7;
        Tue,  3 Oct 2023 11:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696332877;
        bh=H9BMXe2QJO9RO+58CeddPp7WyfIXqfePJ6p2eJ8y0xc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FdzhN2x0XYUzNIw7Jg+eiFouvZ6lDDJN1/Xted0/1CxRdCVqtVS3LuYA5lUwznsMU
         Qi7eQYphGDPE0MhlJeWIJdVZCIsg+czjOZkX8vIGn43EgKCd2B98BCEBhwgbFkBXyA
         iBveIc5dkvsOQLEjJdJ+X2Bkcs9/UBT8vonat58f5EtOPXYqNSzRlLDa/HxBLKarLL
         39b45j6k/bG4P1njgUdPjT1a4/vKl5UvZypPe1XVjEFJxiZwIKMcxEOu06hW1Op5ui
         cGImPEZpI+fVVC5VrYQ97mJYZXB43/O/CpMLeA3nSTOP7QbA7qv90Xo5KoIddiFZai
         t0b8rCQm+yVEg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/4] wifi: rtw89: update to follow regulations of China
 and Thailand
References: <20230927072156.26336-1-pkshih@realtek.com>
Date:   Tue, 03 Oct 2023 14:34:34 +0300
In-Reply-To: <20230927072156.26336-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Wed, 27 Sep 2023 15:21:52 +0800")
Message-ID: <87bkdg6it1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Recently regulations of China and Thailand are changed, and these chips
> have gotten new certifications, so apply new TX power tables.
>
> Zong-Zhe Yang (4):
>   wifi: rtw89: regd: configure Thailand in regulation type
>   wifi: rtw89: 8852c: update TX power tables to R67
>   wifi: rtw89: 8852b: update TX power tables to R35
>   wifi: rtw89: 8851b: update TX power tables to R34

Manually applied as patch 2 was too big for the list:

1af55a76e073 wifi: rtw89: regd: configure Thailand in regulation type
ae22f2b9f535 wifi: rtw89: 8852c: update TX power tables to R67
e4a8efb52ef0 wifi: rtw89: 8852b: update TX power tables to R35
e9d9027e4ac9 wifi: rtw89: 8851b: update TX power tables to R34

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
