Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42917D9B62
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbjJ0O2t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345877AbjJ0O2s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 10:28:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A78DE
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 07:28:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CCAC433C7;
        Fri, 27 Oct 2023 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698416925;
        bh=pvAlIgjUUqdF9V7h0tznOJsjCCDdWmdtSRxZOhkOF28=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iLw1AJyHDn7R+rTWBw+LINZGzxu4ylfJ2zjSmzjGYEKM4Q+3f958buMA/pyt8dQWf
         MtsUaMzhRHw4QM8gVr7OVOCNKC4J3t0jrhXe7mBJeWYbn566y/6HuR0Z9EnCbRMuU7
         5cF5iLRlkvYNEIonCIYv5gYxQhQ6JUKGbT5qq7i7ZpZM+Jhih6kqdQlTWYjQv5KtcZ
         TRsc2bpzmi3GkMlUbAIkWNoW1BscwhhmfjABCg4gWN6UYuW7l1ApnmKf+VHKyidOH0
         bqxiZIKVEYkiec+8iPoIOW8C+/D4T1s2nHLiwe7KGW6kkhBwdJKTdP8kB/go3hWNi9
         pd8aPp3dpgF/A==
Date:   Fri, 27 Oct 2023 07:28:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jonathan Bither <jonbither@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: fill in MODULE_DESCRIPTION()s in
 kuba@'s modules
Message-ID: <20231027072842.41c4ca60@kernel.org>
In-Reply-To: <323e1669-e145-21bc-a124-923303ad2138@gmail.com>
References: <20231026190101.1413939-1-kuba@kernel.org>
        <20231026190101.1413939-2-kuba@kernel.org>
        <323e1669-e145-21bc-a124-923303ad2138@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 27 Oct 2023 10:15:02 -0400 Jonathan Bither wrote:
> > +MODULE_DESCRIPTION("MediaTek MT7601U USD Wireless LAN driver");  
> Did you mean USB?

Ah, I do, thanks!
