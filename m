Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A06784CBF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 00:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjHVWPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 18:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjHVWPW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 18:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BCFCD0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 15:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D382063692
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 22:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C6BC433C9;
        Tue, 22 Aug 2023 22:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692742520;
        bh=X6fTjt67iWWbrFjW9gx10bA6iKhUv3TcJEHhFDRn9rU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ho3Cnh7MFrQ/OP+GbxHJmRT+Djohuih6MKHJvZpt8v7xp7WgcA722MaTDrwctI/rZ
         M7VJtzeMWkMCITumOGj61FhgjTS89aoUO0Z/nUcZadq7Bp7Vanwx9wI3waCN6GQcTu
         c/ZX5KksWeAtBCUsZGJTYxCOvP0LQ3G10LhcxE8Dz5eQjQMpEONw0zjgTxrEADCL4r
         TLNEc13OQIiAY/lI7AT9nUTjfPSwGbOnD96dUYjf3Zp05kbe+hx24iEIhaIDSrlEut
         zQszAvnI2VGkke7w1bwkGQBgkgOw920ydFB3IhMBwcZNkicKBW4dor9bMBi6Ej7rsN
         +wC6hg2yWC6ug==
Date:   Tue, 22 Aug 2023 15:15:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-2023-08-22
Message-ID: <20230822151519.3b3baf84@kernel.org>
In-Reply-To: <20230822124206.43926-2-johannes@sipsolutions.net>
References: <20230822124206.43926-2-johannes@sipsolutions.net>
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

On Tue, 22 Aug 2023 14:42:07 +0200 Johannes Berg wrote:
> We have two more fixes - one stack and one driver - for the
> current cycle. I think the Kconfig fix would be appreciated
> more than the other, but if anyone runs with UBSAN they may
> find this problem as well.

Pulled, thanks!
