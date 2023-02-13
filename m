Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DCD694DDC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBMRYV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBMRYU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:24:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69837E048;
        Mon, 13 Feb 2023 09:24:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041C7611DE;
        Mon, 13 Feb 2023 17:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A3BC433D2;
        Mon, 13 Feb 2023 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676309058;
        bh=QBTjZ1GXTW8BThNCOkaRE7H2SIlQ/kEbAqp3JYbdLP0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Xv3KYgxBT0fPT/STveV+ySFw3qlAHQpEau2WDXALuisowuL+iKvLfdHrO6FH4H9b8
         DbDiM9I1dcQcDhkHHooFEzUYXleJNE7neVPBqBZo7MdUgO5wkfeHvH75etURAVn7mk
         Opl017av6w9aLw8RNxZHeC24y9zQ1Rk8qxDMhON8Gp1/UK+XokemdLEfixR7JdjNU+
         aVoCRUBfbmkNYewgaKHTbckjbKCqHRtShygc8LWFqPWoS1sWoaHY1hbnw/SvmiXdq8
         8P4AFetneMY3AV9ut/If92FKOQW6H5LWE/SK+7nHOknZUE377GfSJBXXQQ8cA3fg+J
         PNpXmn/0l6/AQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rsi: Avoid defines prefixed with CONFIG
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230118185353.2422-1-peter@n8pjl.ca>
References: <20230118185353.2422-1-peter@n8pjl.ca>
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     linux-wireless@vger.kernel.org, Peter Lafreniere <peter@n8pjl.ca>,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630905571.12830.2660289695202957081.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:24:17 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Lafreniere <peter@n8pjl.ca> wrote:

> Macros prefixed with CONFIG_ are intended to be defined only by
> Kconfig scripts. Here we remove the prefix from the
> CONFIG_AUTO_READ_MODE define to avoid confusion when reading the code.
> 
> This causes no change to functionality.
> 
> Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>

Patch applied to wireless-next.git, thanks.

c6e3dc99fd32 wifi: rsi: Avoid defines prefixed with CONFIG

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230118185353.2422-1-peter@n8pjl.ca/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

