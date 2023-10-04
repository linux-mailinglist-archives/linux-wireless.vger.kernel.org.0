Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF317B7750
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 07:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbjJDFEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 01:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjJDFEc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 01:04:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE83A9
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 22:04:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F12C433C7;
        Wed,  4 Oct 2023 05:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696395869;
        bh=r+H4bH6Wkf05V8nL3m4zJERWeGZQxIY/3XMujV/trDw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ixW7krCB4P9rU3aU9FO246UUCB8JVuOYh+Y1tF/+HaKQTCLR94vSVqICb/sHGm9tq
         xe+0da0mrfQHvVVsmKPuV0Oz0lufES18yeGt60KizCgvIu2Xmt4200WT1sHY0mOnVe
         YHOwutj50R/7T6zyP9ieyw6jQDp6asRuPCYryCzAKBrtuMO5eyTcFsqW5+Qva7RW5+
         m+dPruQY5U0jz46oA0qO02rkhFvNt4lx6RzTFwcv2Y+3gXixCHIE4Xxl8ojguqahWl
         zfXReriJ047auq7cV7S/Cl67wBq0eoFYOUk8wQQuYWc0DkBw4NW+vvFfRKsQZMOQca
         dsbHR5aYvAGGQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: wifi-7 + MLO: wlan is not seen in /proc/net/wireless
References: <db9ef851-5784-c6a5-d3d5-5747ef21e0b6@candelatech.com>
Date:   Wed, 04 Oct 2023 08:06:45 +0300
In-Reply-To: <db9ef851-5784-c6a5-d3d5-5747ef21e0b6@candelatech.com> (Ben
        Greear's message of "Tue, 3 Oct 2023 12:09:20 -0700")
Message-ID: <87zg0zgemy.fsf@kernel.org>
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

Ben Greear <greearb@candelatech.com> writes:

> I'm testing a wifi-7 radio against MLO AP.  I notice the link-0 debugfgs links
> show up and STA is associated and acquired DHCP, but wlan is not in /proc/net/wireless.
> I'm in 6.5.5+ kernel.
>
> Is this expected?

wext doesn't support Wi-Fi 7, see:

https://git.kernel.org/linus/52fd90638a72

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
