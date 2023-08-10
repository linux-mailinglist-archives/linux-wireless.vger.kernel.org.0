Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E3B777E2F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjHJQ0d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbjHJQ0c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 12:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B682103;
        Thu, 10 Aug 2023 09:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18FEA659FF;
        Thu, 10 Aug 2023 16:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB52C433C7;
        Thu, 10 Aug 2023 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691684791;
        bh=PLPnIFk3ITvkeqRC6SfEJPLCPJ/y0ZeEHIWOWpjo5dk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QemTnpP0JmToWpYcZxplHbiGYvfYs4gybItzpa4gzs3eNSO3s2gDEWx+arnKQPgz3
         QJVZTTXuwONIoRucWygOE9x4wahbOuFqVX0mBjMb6D3rIzKqB6kg+dPL2EZH3PKRSG
         B+pr00mqquRjUR+sHHlgS6ravXh9nfKr5lM/ZODwCqi8bnVuQCDJNz7wUm/em+DF6b
         4a2ruuvveKre6aG8bZfAPol/F0LJUHiRDnyg9aaZN//b08Lb/wbp9wkUdx/pqNSqjT
         Mjj+BsF5xwlS8a/+vwUGNxDweJmVN0F7AOl3lj/Me/qApLvSQSYQARM5iOyY+Gh/LN
         5W+KwsBCntQCA==
Date:   Thu, 10 Aug 2023 09:26:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     <linus.walleij@linaro.org>, <alsi@bang-olufsen.dk>,
        <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <clement.leger@bootlin.com>, <ulli.kroll@googlemail.com>,
        <kvalo@kernel.org>, <bhupesh.sharma@linaro.org>, <robh@kernel.org>,
        <elder@linaro.org>, <wei.fang@nxp.com>,
        <nicolas.ferre@microchip.com>, <simon.horman@corigine.com>,
        <romieu@fr.zoreil.com>, <dmitry.torokhov@gmail.com>,
        <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/5] net: Remove redundant of_match_ptr()
 macro
Message-ID: <20230810092629.47d47537@kernel.org>
In-Reply-To: <20230810081656.2981965-1-ruanjinjie@huawei.com>
References: <20230810081656.2981965-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 10 Aug 2023 16:16:51 +0800 Ruan Jinjie wrote:
> Changes in v2:
> - Correct the subject prefix: patch -> PATCH 

Cool, now Linus replies to v1 with his acks and you've wasted everyone's
time. If only we didn't have rules about reposting.. oh wait:

Quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~
  
  Allow at least 24 hours to pass between postings. This will ensure reviewers
  from all geographical locations have a chance to chime in. Do not wait
  too long (weeks) between postings either as it will make it harder for reviewers
  to recall all the context.
  
  Make sure you address all the feedback in your new posting. Do not post a new
  version of the code if the discussion about the previous version is still
  ongoing, unless directly instructed by a reviewer.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review


I'm throwing your series out.
Resend next week with all the tags included.
-- 
pw-bot: cr
