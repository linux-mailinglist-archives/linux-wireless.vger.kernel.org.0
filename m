Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7735A74929B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jul 2023 02:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGFA2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jul 2023 20:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjGFA15 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jul 2023 20:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D219A9
        for <linux-wireless@vger.kernel.org>; Wed,  5 Jul 2023 17:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2B466178D
        for <linux-wireless@vger.kernel.org>; Thu,  6 Jul 2023 00:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EB1C433C7;
        Thu,  6 Jul 2023 00:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688603276;
        bh=pZ5zZNzHJxKbBKdaV7Vr4F3wsYvwnSGwvWeGRxOZPkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aGh1x3K9aIKST/DLmHOfUb55pCEE2+W0uSYlxyXRxbgi6aeAFL/bgDvpytdFgxUpj
         YOz5fh9cwi8CJFXt40VW4Gr9oyAdMxfio2mbSGHKHJPkUzVc4Gu6wuRFIfuv6rXJ+I
         eoG7WGPtoCXq6OmEiS5wGxy0KvBZLejcCxD5Wpn6mngCf/pouvUIaz8xPqN9+Cte2C
         H+4wkyYMpYhRLlqBFWCSZ5mzqrfa1h2NqYne0H5Rnrpz36ku/PrJHN7GvLhIpLzT6k
         ajmss3gB4yD9SL31NufqTyCieSt+Cr23zPvmTd3zpIgSOCIgUBSjZMNFDpXQHjHssa
         FAGbdBafJQZ+w==
Date:   Wed, 5 Jul 2023 17:27:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Message-ID: <20230705172754.61ca21ae@kernel.org>
In-Reply-To: <5500a007-4e52-f8dc-2535-3baa7decfe52@microchip.com>
References: <20230630012136.1330784-1-ajay.kathat@microchip.com>
        <20230705140338.77896d11@kernel.org>
        <5500a007-4e52-f8dc-2535-3baa7decfe52@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 6 Jul 2023 00:12:32 +0000 Ajay.Kathat@microchip.com wrote:
> On 7/5/23 14:03, Jakub Kicinski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, 30 Jun 2023 01:22:31 +0000 Ajay.Kathat@microchip.com wrote:  
> >> To inline the linux-firmware path with driver, the firmware path is changed
> >> from 'atmel' to 'microchip/wilc'. This path change will be submitted to
> >> 'linux-firmware' as well.  
> > 
> > How are you going to make this backward compatible?
> > Users aren't required to update linux-firmware and kernel at the same
> > time.  
> 
> Thanks for pointing it out.
> 
> I think, the changes are not fully compatible for upgrading the kernel
> and 'linux-firmware' individually. After the driver changes, the
> 'linux-firmware' upgrade is necessary.
> 
> The kernel and 'linux-firmware' can be upgraded independently, so two
> combinations are possible for the upgrade.
> 
> updated driver : uses modified path(microchip/wilc) to load FW.
> updated 'linux-firmware': FW file is at modified path(microchip/wilc)
> 
> 1. updated driver + old 'linux-firmware' : incompatible

Ah, totally missed that combination.

>   - The updated driver will look for FW file in '/microchip/wilc' path
> which is not present in older 'linux-firmware'. Though the interface
> format is compatible, the driver will fail to load it because the file
> is not present.
> 
> 
> 2. old driver + updated 'linux-firmware': compatible
>   - A link is created from new path to old FW path so the old driver
> should be able to load from linked path.
> 
> In order to address scenario#1, a fallback method that loads the FW from
> the older path(/atmel) can be added in the driver. I think that change
> will make it compatible for scenario#1.
> Please suggest, if there is a generic/recommended approach to handle
> backward compatibility for FW path change.

I'm afraid you need to request from both new and old patch for some
time. Push the change to linux-firmware, but make driver be compatible
with both for maybe three full releases? Then the risk of someone still
having stale linux-firmware goes down quite a bit.

TBH renaming FW paths, much like renaming drivers is usually more risk
than reward.
