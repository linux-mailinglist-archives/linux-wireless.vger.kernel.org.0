Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77C67B35A5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjI2Oel (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjI2Oe3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 10:34:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1011D2726
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 07:33:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9129C433C7;
        Fri, 29 Sep 2023 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695998004;
        bh=gJM000iU/qxw+nMqCXY3TCqRWK5JPoW6L+5coAokIkE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mjt+hJKebUnCYT8C9jf5xidUCWbhhbyVfmJyv3qV1jc7SxOMf/s0LoumF3EtUdcH1
         FiyZnw5yYZ7REX2f2q8hbbPIoukRhoG2hBIBoSNMbVrD1jOMO0IBGeeVssNLJRt5R+
         se/fDcx+G7U88lnkLkhrlfwuigVAFi09wPW1XhfFZP9uEsWzNVSicZKJ1t9fokknXg
         hKi/wlQ+Hn/L8jtxWiemO2lZbZolI3lAgc++6L+fSHBBNWLbao7+k5Jzl5RnVss2d5
         bjfReClrECYExzVI2rVvqgBS1hpUBCne3Gs1ynAzk0Zp4DepyP497LKS+5VpjOtQH8
         ZY6VFBT93j6fw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: mac80211: fix ieee80211_drop_unencrypted_mgmt
 return type/value
References: <20230929162059.205c236c9f3f.I9ed4c65ab6514aa9e3c8877ec79092a302b2089d@changeid>
Date:   Fri, 29 Sep 2023 17:33:21 +0300
In-Reply-To: <20230929162059.205c236c9f3f.I9ed4c65ab6514aa9e3c8877ec79092a302b2089d@changeid>
        (Johannes Berg's message of "Fri, 29 Sep 2023 16:21:00 +0200")
Message-ID: <87fs2x6ocu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Somehow, I managed to botch this and pretty much completely break
> wifi. My original patch did contain these changes, but I seem to
> have lost them before sending to the list. Fix it now.
>
> Reported-by: Kalle Valo <kvalo@kernel.org>
> Fixes: 6c02fab72429 ("wifi: mac80211: split ieee80211_drop_unencrypted_mgmt() return value")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thank you for fixing this so quickly!

Tested-by: Kalle Valo <kvalo@kernel.org>

I assume you don't mind if I apply this to wireless-next still today?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
