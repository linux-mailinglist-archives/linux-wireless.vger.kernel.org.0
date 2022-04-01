Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7164EE896
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 08:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbiDAGoy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 02:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343662AbiDAGnN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 02:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3D719610A
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 23:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A860561378
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 06:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86538C2BBE4;
        Fri,  1 Apr 2022 06:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648795173;
        bh=9cwykFAY/9I//EOxgUeTUKalyqktenO7niYsB/0akxc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gOer88zG3WAQA5LQeUSU18DWoldjuQ36/BKOSYSKwE8C9CpNbFFQKyQBdh4zmoeRk
         d3Ofjb9t5NgrPC6DLkfRS1KPgA6Ai4vBGtRQWBhUB4OMM2wPEe+xbDLyArmFeK7Gj3
         aGvQOKHps2tIbE/nziaSDx80r6+/TL/y+5XzQHZkSlMaibflKQYMTJ99voL9SrMmHj
         D0tENv8sSM6bJl/vb+vXUIakVti24/722Z1YXBRE+90zVOfl15Ofv4SRQsSlIaFkkn
         xy59GSIoiUlK2rKxHPwZgPxnPWqQsemp4l+cEU25Iofg0gxm2KAqiFoP+SYU3JYMA1
         8lnSYYLQ14S+Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: mark wil6210 as orphan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220330144046.11229-1-kvalo@kernel.org>
References: <20220330144046.11229-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164879517031.20606.5530786259114022621.kvalo@kernel.org>
Date:   Fri,  1 Apr 2022 06:39:32 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Maya is not working on wil6210 anymore so mark it as orphan.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Patch applied to wireless.git, thanks.

61a891efbb10 MAINTAINERS: mark wil6210 as orphan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220330144046.11229-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

