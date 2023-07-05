Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C80748F95
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jul 2023 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGEVMK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jul 2023 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjGEVMJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jul 2023 17:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CDC1700
        for <linux-wireless@vger.kernel.org>; Wed,  5 Jul 2023 14:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D2A6173A
        for <linux-wireless@vger.kernel.org>; Wed,  5 Jul 2023 21:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469FBC433C7;
        Wed,  5 Jul 2023 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688591527;
        bh=01RMltS+KFmzVXD7ibkTFhF/TPb3O/r3F/BwA+tJA6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t5p2ove9JAqnlG0uqaTTCj5UibMdty8UMcs8aASFjhDRQsmWfF7TiaJKEKy4i9bRk
         7eETZ3fBO7zmKs/4NPwQ1wvcSQjwAvefNx2FkWu2zND0td5S90bKsgz7Uug4tpTNxi
         4Yk2x5dKSCQOef9aR674xirL+ockTSeWhpvj1x48eo7BMxMd7LInSIO2keDevOPW4h
         pls6nkLQjdtKVffjk5Q2O4cFpE7pdsQLVNHgl7R0zM2Y77Uz3ZQLEzbgWOSL8Un4xw
         iYtRxk8Tk3nLep6zmFrL+cDMSId8ImCIbK+3MhHVkwUhapFGXN+idET2FZ1bzBFoIn
         3ApoQ9I33nqsA==
Date:   Wed, 5 Jul 2023 14:12:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     JUN-KYU SHIN <jk.shin@newratek.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: fix error handling when channel_switch
 on S1G band
Message-ID: <20230705141206.22a74fa3@kernel.org>
In-Reply-To: <20230626075818.1000-1-jk.shin@newratek.com>
References: <20230626075818.1000-1-jk.shin@newratek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 26 Jun 2023 16:58:18 +0900 JUN-KYU SHIN wrote:
> On the S1G band, even if freq_offset exists in the
> __ieee80211_channel_switch function, it is not treated as an error.

Sounds like e bug fix to me.

Could you describe the user visible impact in simpler terms,
and add a Fixes tag?
