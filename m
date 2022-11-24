Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC82637D7C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 17:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKXQLr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 11:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXQLp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 11:11:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEE13BB6D
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 08:11:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 223A4B82873
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 16:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B83BC433D6;
        Thu, 24 Nov 2022 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669306301;
        bh=wKbM0GdQjqWiS1yaYWGcf5+tzF0rUU8/9RK2LV18lO8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=d7xp5P/tJ7itkhFphJnawm5+FRv7uzxvJ4HBuXT4zfI2JxExHMJ3CLQaz7/C7qwNc
         AfYUTmMvOpMtONahBqA2ri/0177VGWhuCiPfoVyUnu3JRAQciTcS67zZYeD6QRivQT
         5yuFJxCgtOmqf0n45hnJ8Gn6XwbRwCaD8Pbzcf+7oWA1S8aaJvM9xa32aAdtv/fGPN
         sQ6Xr+h3MrDYGY/OehQvAdY1+VJ0cP5LGfsYZHHu7uEn75Bofqc8SvymMEY0hTHwmO
         JY+rhcMSgp8NWDnVbcOe6e8Yt5mSvOyoRAMQqaJSxnUO7pHxYtJ74565uJVYKjR52I
         0dGeWdlf2EF4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: wilc1000: validate pairwise and authentication
 suite offsets
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221123153543.8568-2-philipturnbull@github.com>
References: <20221123153543.8568-2-philipturnbull@github.com>
To:     Phil Turnbull <philipturnbull@github.com>
Cc:     linux-wireless@vger.kernel.org, ajay.kathat@microchip.com,
        claudiu.beznea@microchip.com,
        Phil Turnbull <philipturnbull@github.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166930629392.4337.6665790087805819751.kvalo@kernel.org>
Date:   Thu, 24 Nov 2022 16:11:40 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Phil Turnbull <philipturnbull@github.com> wrote:

> There is no validation of 'offset' which can trigger an out-of-bounds
> read when extracting RSN capabilities.
> 
> Signed-off-by: Phil Turnbull <philipturnbull@github.com>
> Tested-by: Ajay Kathat <ajay.kathat@microchip.com>
> Acked-by: Ajay Kathat <ajay.kathat@microchip.com>

4 patches applied to wireless.git, thanks.

cd21d99e595e wifi: wilc1000: validate pairwise and authentication suite offsets
051ae669e450 wifi: wilc1000: validate length of IEEE80211_P2P_ATTR_OPER_CHANNEL attribute
f9b62f9843c7 wifi: wilc1000: validate length of IEEE80211_P2P_ATTR_CHANNEL_LIST attribute
0cdfa9e6f091 wifi: wilc1000: validate number of channels

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221123153543.8568-2-philipturnbull@github.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

