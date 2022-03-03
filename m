Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4B4CC871
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 22:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiCCV5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 16:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiCCV5m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 16:57:42 -0500
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA63EA9B
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 13:56:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id CFE5810FDC;
        Thu,  3 Mar 2022 21:56:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hepIHg-mo5pd; Thu,  3 Mar 2022 21:56:50 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Thu, 03 Mar 2022 23:56:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1646344609; bh=SbINSSOH6dRRPTzQHICSty5PFkNthM6nOIOonL9arzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSUcR2pqUebnSnP1aQ9rlWX285jU7PojhrwHrBciqyT5p84cX3f542M9z68D8dxW1
         fNDTWuoJa2DpB8Rpb486bMd7X+0HVXSYoRwupT+c9QT+r5mNXBsUCr75+VImnOGQtf
         kG2Ga1RMYz+t+HogHzBDRioRjKM/vbddv7/5t7EymNA/nj4wjVzyLJoK6brHc31ion
         XDv2ZtYwG1tsjyB+E0OWQFuk+w5MXXfWLIbsx7Qo1cCMCU05ZZ3K9riQHpOACdALMg
         IAVD2YQnlGuyzIeMT4GM9hQ5ChfOuMlWVPSsl7pbeaUGflYWYg6FjbPxjdLw6ZRz5m
         YtPCU3kmGlvdA==
Date:   Thu, 3 Mar 2022 23:56:47 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 9/9] DFS: introduce radar_background parameter to config
 file
Message-ID: <20220303215647.GA33342@w1.fi>
References: <cover.1640014128.git.lorenzo@kernel.org>
 <3683c678668c4de0ee849974977cf56e64c7162c.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3683c678668c4de0ee849974977cf56e64c7162c.1640014128.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 20, 2021 at 04:48:24PM +0100, Lorenzo Bianconi wrote:
> Introduce radar_background parameter to configuration file
> in order to enable/disable background radar/CAC detection.

What's the use case for this new parameter and the configuration having
to explicitly enable this functionality? Is there a reason for not doing
this in cases where the driver supports this capability? It looks like
patches 1..8 were enabling this functionality automatically and it is
only this final patch that makes it depend on a configuration parameter
(which is default by default).

> diff --git a/hostapd/hostapd.conf b/hostapd/hostapd.conf
> @@ -143,6 +143,13 @@ ssid=test
> +# Enable radar/CAC detection through a dedicated background chain available on
> +# some hw. The chain can't be used to transmits or receives frames.
> +# This feature allows to avoid CAC downtime switching on a different channel
> +# during CAC detection on the selected radar channel.
> +# (default: 0 = disabled, 1 = enabled)
> +#radar_background=0

How would someone writing hostapd configuration know when to enable
this? Or maybe more importantly, when one should not enable this? Would
use of that dedicated background chain result in some other capabilities
getting reduced?

This is also a bit unclear on what happens if the driver does not
support this capability and radar_background=1 is explicitly set in the
configuration.

-- 
Jouni Malinen                                            PGP id EFC895FA
