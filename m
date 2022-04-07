Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBAE4F7464
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 06:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiDGEMk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 00:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiDGEM1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 00:12:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659E52F2
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 21:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C915B81DD7
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 04:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE890C385A4;
        Thu,  7 Apr 2022 04:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649304625;
        bh=kPBaRgLP+ZciT4BrZrMgvgf/nwvzoxFW1dbKDnLNmuI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=A/hyPnef4a6ADpKALDpbbzcdV+a8Y3nZs/k4oijj7LFVDlkV5Yo0tcepmqPhfG6+g
         nJZAYZoC7NafTlAtBsXdc7AtbANWd1WXU1hRcs18zvExm4yF+wdrGfHFReI9JJDe5D
         U/T+570joX9Ow7qqdBw3CTutI3o8IUoHyMBsn1dkDdKYNBHo0iXX0mL9sdBvlznu/o
         Z1+OPKC+aaIRD8/WQRT4BcDSl3qJTG5aOnN3h6Ho9WjBKBLDuJQozd9qUXUY6UPzS/
         ZmjgxkKbyeTATZAmsaTz7oyCVgO2Mi5lYMRrEe7T1BadhWxsag1LBhTsNJ0aE3LZN/
         hp3uuXw4jNwRQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/7] nl80211: add RX and TX timestamp attributes
References: <20220406120924.979792-1-luca@coelho.fi>
        <iwlwifi.20220406145756.40cc8312dd81.I78d5704923b6e1a9f574ad5da1705d276352e298@changeid>
Date:   Thu, 07 Apr 2022 07:10:19 +0300
In-Reply-To: <iwlwifi.20220406145756.40cc8312dd81.I78d5704923b6e1a9f574ad5da1705d276352e298@changeid>
        (Luca Coelho's message of "Wed, 6 Apr 2022 15:09:18 +0300")
Message-ID: <87ilrlsfdg.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Avraham Stern <avraham.stern@intel.com>
>
> Add attributes for reporting hardware timestamps for management frames
> RX and TX.

Here you talk about management frames...

> + * @NL80211_EXT_FEATURE_HW_TIMESTAMP: Device supports timestamping timing
> + *	measurement and fine timing measurement action frames and their acks
> + *	on TX and RX.

.... but here you talk about action frames and their acks. Why the difference?

> For TX, these attributes are used for reporting the frame RX time and
> the ack TX time. For TX, they are used for reporting the frame TX time
> and the ack RX time.

You have "For TX" twice so I can't understand what you mean.


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
