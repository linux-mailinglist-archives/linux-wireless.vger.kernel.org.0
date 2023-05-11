Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1056FF1ED
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbjEKMyT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 08:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbjEKMyQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 08:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3DA2122
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 05:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A831B61997
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 12:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A9EC433D2;
        Thu, 11 May 2023 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683809654;
        bh=oErLAYzXtNscTQF6VwnYLkgmb1yL2n5t+Yy5yCcICSw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OxFxGeuf+/4AU+wMvewaq+lk0cB8d4c/Erbo6vndEZeQPuhwn7lXsEUjqCbyVwGgd
         503jw5rdB3cTMFr5vXm1nGIvp0DpmdgrWAjrjKj35CQkN/xCX02KX3e1XMsLwpY7o4
         Z4/DSt4Xodam9vgCgopSuWGWLffKRSGMevOSMg0KrAZ+Q/aId1cxpQ8LsKi7zvTOpK
         OBABba2UmskF/44RJOsgPWZmoRe+3nGapY0eJJHWggNInaXTY3dH3Rrt8vYsqT8SF6
         +xW6Ib3D12yxNlPLy5AOmq9+XHxbZI5OlnHg2QPntAEYVPoZgOke8QriiNTM38DWDv
         8Zv5nxEJzRI7Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: wilc1000: Increase ASSOC response buffer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230509172811.4953-1-amisha.patel@microchip.com>
References: <20230509172811.4953-1-amisha.patel@microchip.com>
To:     <Amisha.Patel@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Amisha.Patel@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168380965081.27145.2836151555917122467.kvalo@kernel.org>
Date:   Thu, 11 May 2023 12:54:12 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> In recent access points, information element is longer as they include
> additional data which exceeds 256 bytes. To accommodate longer
> association response, increase the ASSOC response buffer.
> 
> Signed-off-by: Amisha Patel <amisha.patel@microchip.com>

Patch applied to wireless-next.git, thanks.

7acd69507088 wifi: wilc1000: Increase ASSOC response buffer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230509172811.4953-1-amisha.patel@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

