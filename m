Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B5F756F0C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 23:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGQVkD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 17:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGQVkA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 17:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47248136
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 14:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D985D612A8
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 21:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053B7C433C8;
        Mon, 17 Jul 2023 21:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689629998;
        bh=lNieLNHPJMBWOslqewKgNbPDmN8z4iXEH0fWnRwcZ6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jPAhRJGUNdRHvoAqbE5nGehEU7xa457OOB3CDzZfYqLGHBa906tS66PpdxrxsOO/M
         Kj7vI11+0RXbRKaMbT3tMZUCyXzXPeuQ9tXaMY8SM7iC1OozVJi4gt29NZtoHLW0qa
         ovbW4MADWy8DB5FgisYZQ7EvYt+cS07wL3vET2NMpv7phM6/x4u1DPFMh+6bW1QshD
         p43OEsBaaBQrZTJWiTlxqCVFR82E/vJMOmXe1ATBSr5UXaHEcnl6kKXQtOMEODcvsE
         mM5U7cCvUWiNzuxTZ7hzx35O4oYmqfE72SWNcMMfItyJ68km1Qrok8ziqhQOLfSxde
         wasCBpbIOJa/A==
Date:   Mon, 17 Jul 2023 14:39:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Polaris Pi <pinkperfect2021@gmail.com>
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
Message-ID: <20230717143957.24415029@kernel.org>
In-Reply-To: <20230717140232.3978004-1-pinkperfect2021@gmail.com>
References: <20230714224809.3929539-1-pinkperfect2021@gmail.com>
        <20230717140232.3978004-1-pinkperfect2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 17 Jul 2023 14:02:32 +0000 Polaris Pi wrote:
> Hi Jakub, 
> 
> This patch has been reviewed by chromeos wifi team, and review tag
> has been added by their tech leader.
> Could you please review it again? 

Looks fine, I'll leave it to the wireless maintainer to process
once they are back from their vacation. It doesn't look very urgent
to me.
