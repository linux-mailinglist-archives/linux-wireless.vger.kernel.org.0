Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7695AAA70
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiIBIpi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiIBIo5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:44:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D460C6FEE;
        Fri,  2 Sep 2022 01:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C963B82A07;
        Fri,  2 Sep 2022 08:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D0C433D7;
        Fri,  2 Sep 2022 08:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662108244;
        bh=6hdLK6PCwUeLXTcuhG+ltsWwMLR/FDMBIukZ9/RvQ2I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OgEUqXs/2QIL2tPFTWi8oBN6B75vtUJmNjvprfnxNzyLvWzQJ7/Hts3q0zi97Qd9q
         ZdUtt3VZTl2ZFFjsbV56bEnYXfYqTOzG9TZdEjtAK+QEv049U6z+SuE6D5FzIAwNAR
         /raLn1ucFfu5FY563mgveclCA5R/8JD0dV9tk2IbIJTmgRfzzDKyXA4Sjw7yHrOzSS
         sQg5DlE65TaB+hhDWI7rzBxuwR/yql9QNSyCeUs3gza6nZmKjRNCxgrX6vHwOBQ5/x
         xcuFaOocjWSFoPXACHbI1+inSKReRobqxWVHJw6HJUKirqsy0GWpaHMfbyPoB/r6Jf
         eNkUIq3SFf1pg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: tighten bounds checking in
 rtl8xxxu_read_efuse()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <Yv8eGLdBslLAk3Ct@kili>
References: <Yv8eGLdBslLAk3Ct@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210824025.24345.1875264756679909885.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:44:03 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> There some bounds checking to ensure that "map_addr" is not out of
> bounds before the start of the loop.  But the checking needs to be
> done as we iterate through the loop because "map_addr" gets larger as
> we iterate.
> 
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Jes Sorensen <Jes.Sorensen@gmail.com>

Patch applied to wireless-next.git, thanks.

620d5eaeb905 wifi: rtl8xxxu: tighten bounds checking in rtl8xxxu_read_efuse()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/Yv8eGLdBslLAk3Ct@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

