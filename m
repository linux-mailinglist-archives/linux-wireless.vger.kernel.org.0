Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9326D2371
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 17:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjCaPD3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjCaPD0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 11:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AB81D90B
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 08:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D0E86274E
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 15:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637E9C433A1;
        Fri, 31 Mar 2023 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680275004;
        bh=uaiITQ8kYW6+FoE1YN45IE4JWf5jFfnkQFPSW1aNboM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Y3jFha66irRkM/klzdmhlYQeEMN1rylTojDTDe80/Cyu7vTJ/n/dE/RWu0uQ4laPa
         /td3+Xo6BfwAqTklq43LUGnZyodCS/2nodgoVBnDWYP6FyfM3xEjRcwoDFruqgWWRA
         HApqFW1CPjL1tOzDLr+w8iNcp/yqWfvBFtXasg9DIkbvp9HCEmJEmRdZR3OWAbDY0b
         ns1Hln6TpNBXtK/4onJz/ijDZociGqx3GtrrFgjhZRHSo5p1R5A8UHL0I24VWThbNZ
         5pZHQckFWbggHsHAJxGJAMQIxIRNVXHb6WHmsHzALGcipb041gpiAQH8IlE9SGpFC+
         4aouk7xnsOw6A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless] wifi: mt76: mt7921: fix fw used for offload check for
 mt7922
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <632d8f0c9781c9902d7160e2c080aa7e9232d50d.1679997487.git.lorenzo@kernel.org>
References: <632d8f0c9781c9902d7160e2c080aa7e9232d50d.1679997487.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, nbd@nbd.name,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        deren.wu@mediatek.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168027500158.3675.7066929700919582087.kvalo@kernel.org>
Date:   Fri, 31 Mar 2023 15:03:23 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix the firmware version used for offload capability check used by 0x0616
> devices. This path enables offload capabilities for 0x0616 devices.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217245
> Fixes: 034ae28b56f1 ("wifi: mt76: mt7921: introduce remain_on_channel support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless.git, thanks.

eb85df0a5643 wifi: mt76: mt7921: fix fw used for offload check for mt7922

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/632d8f0c9781c9902d7160e2c080aa7e9232d50d.1679997487.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

