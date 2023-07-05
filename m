Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654D748F80
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jul 2023 23:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGEVDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jul 2023 17:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEVDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jul 2023 17:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476AF1700
        for <linux-wireless@vger.kernel.org>; Wed,  5 Jul 2023 14:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59B86173B
        for <linux-wireless@vger.kernel.org>; Wed,  5 Jul 2023 21:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7930C433C7;
        Wed,  5 Jul 2023 21:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688591020;
        bh=3EvtEtiLrA6t3lPXkQuDV4COAMRPOCKJUyVLxj3+a+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bp6Vy45KSvlS7Jru4eE3uJrXHxoBPKB0TbQ0GPNp4D24aPtbxUrgo+MEATenKAwEC
         OnRScefshKcEGwOxN6rJ4cT3MQj/xb4K5VR68mn8BMcFRqociaXaQV6YWWYjCoWXev
         y8vXWkrTJ9sWQ9wWlhi16FmOc0XKOHsJSYgHz5r7i/IWCA4nKtc7S8p6PKaMvWY4F6
         1WlJJUghNBp1PKA6hxEeBN0rZuhNxGG73kaV34SwlleCxmqBZkMPtXrNCEnLvtWQOm
         yqfRE3rVCKRUT8Xg6EdXEhA2/UvINvrcxKBvRg7LfXq/IzN0U/Wa9qeCvwOABJ8dMZ
         CVppk9RDcvxGA==
Date:   Wed, 5 Jul 2023 14:03:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Message-ID: <20230705140338.77896d11@kernel.org>
In-Reply-To: <20230630012136.1330784-1-ajay.kathat@microchip.com>
References: <20230630012136.1330784-1-ajay.kathat@microchip.com>
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

On Fri, 30 Jun 2023 01:22:31 +0000 Ajay.Kathat@microchip.com wrote:
> To inline the linux-firmware path with driver, the firmware path is changed
> from 'atmel' to 'microchip/wilc'. This path change will be submitted to
> 'linux-firmware' as well.

How are you going to make this backward compatible?
Users aren't required to update linux-firmware and kernel at the same
time.
