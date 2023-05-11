Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2336FF1CB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 14:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjEKMr5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEKMr4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 08:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EA45BB4
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 05:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B9D764C7F
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 12:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89104C433EF;
        Thu, 11 May 2023 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683809273;
        bh=tPwUoB1eUAkzOWyJR9Pkc+RIwyFTvmmQNSNoyMH/K4s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MU1O78WZ7qs9eAs1MIkoK2KczGp2oRScVXiAa5vmqP3nceZpHZa9c25MQzV3aoWgE
         O5xMQqri40ROwgXoPQPaMIw7iGQfVR+a56boJLYODU7b7Hxvul58wT3wVPexEeAN0q
         TSq1vGhq8OuYCTdTQXwMLt95DRJaian3Fanlkt6A5FJvesgorom3X0Pbf0nRR7FEaY
         YpEzffbVa5cDtOlOAVsG5cYMHqys/egdPgHVZYcaUu/U24ClYdgQ55EdOquwPg8rWa
         AU2pIyXt2JzkZExBAJyh64yYcKGgqIoyMSMwTC4f+Ob+XSPDMxXmbS/+ntJsumoMRd
         em1P6alyXNI1Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230421181005.4865-1-amisha.patel@microchip.com>
References: <20230421181005.4865-1-amisha.patel@microchip.com>
To:     <Amisha.Patel@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Amisha.Patel@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168380926993.27145.14944412754028351277.kvalo@kernel.org>
Date:   Thu, 11 May 2023 12:47:52 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Amisha.Patel@microchip.com> wrote:

> From: Amisha Patel <amisha.patel@microchip.com>
> 
> Mandatory WFA testcase
> CT_Security_WPA2Personal_STA_RSNEBoundsVerification-AbsentRSNCap,
> performs bounds verfication on Beacon and/or Probe response frames. It
> failed and observed the reason to be absence of cipher suite and AKM
> suite in RSN information. To fix this, enable the RSN flag before extracting RSN
> capabilities.
> 
> Fixes: cd21d99e595e :"wifi: wilc1000: validate pairwise and authentication suite offsets")
> Signed-off-by: Amisha Patel <amisha.patel@microchip.com>

The fixes tag is wrong, should be:

Fixes: cd21d99e595e ("wifi: wilc1000: validate pairwise and authentication suite offsets")

I can fix that, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230421181005.4865-1-amisha.patel@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

