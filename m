Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371D375B209
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjGTPIm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjGTPIl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 11:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8CD26BF
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 08:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 957C961B2D
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 15:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53F6C433C7;
        Thu, 20 Jul 2023 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689865719;
        bh=Yh4YUivO2UzaK+iT+9KnxrBkbvzqzn10k/6kDLIOdNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vw4vdc640qERtnvbB7eXSvt7jSIk4P3a06/bdL4+uHepNBdB1DGnmBsN5xBt4R3Dj
         7hFMgvnsx6H9MyzIWkkFUQ+LQP3U8RJl9Y9z14eo3usZ+5k+9JFxEOQhyiz/sDvNI5
         lzTkYNXE27sOQ1KenD6YsjGRHSVTJFTnLry9Nid9PKu5Fc4sMurnjYZ7C1WzGHvvV5
         dEJd5w179BfTA1fEEBSFau7nCUY3mKQSAQkBBLxgqVQRH7ERJj616XMck2mVccEQh+
         eKFjwbSMPkDFf1WANXTx3AdI7OOzmqUhn0TlYpOlbtfKgE71Vh4rWArEehmSEaD+Zb
         UVzHLE94x4v2w==
Date:   Thu, 20 Jul 2023 08:08:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Pink Perfect <pinkperfect2021@gmail.com>, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
Message-ID: <20230720080837.220cb1a5@kernel.org>
In-Reply-To: <87sf9j3wd1.fsf@kernel.org>
References: <20230713023731.2518507-1-pinkperfect2021@gmail.com>
        <CAKNAPeOvG1MVD0y5xuZpN8mSEzvrzcvRhdyrTJhju-_Z1nGV0g@mail.gmail.com>
        <20230713105644.49444826@kernel.org>
        <87sf9j3wd1.fsf@kernel.org>
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

On Thu, 20 Jul 2023 09:55:38 +0300 Kalle Valo wrote:
> > No empty lines between tags, please.
> >
> > You mentioned reporting the problem to chromeos, since mwifiex
> > "maintainters" seem to be AWoL, would someone from their team
> > possibly be willing to venture a review tag for the patch?  
> 
> We have four maintainers for mwifiex and total silence:
> 
> MARVELL MWIFIEX WIRELESS DRIVER
> M:      Amitkumar Karwar <amitkarwar@gmail.com>
> M:      Ganapathi Bhat <ganapathi017@gmail.com>
> M:      Sharvari Harisangam <sharvari.harisangam@nxp.com>
> M:      Xinming Hu <huxinming820@gmail.com>
> L:      linux-wireless@vger.kernel.org
> S:      Maintained
> F:      drivers/net/wireless/marvell/mwifiex/
> 
> I'm very close of marking this driver as orphan unless anyone steps up.

That seems more than justified at this point.
