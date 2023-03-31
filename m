Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462666D2367
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 17:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjCaPBc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 11:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjCaPB0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 11:01:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE41FE053
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 08:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55074B83035
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 15:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E514CC433D2;
        Fri, 31 Mar 2023 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680274881;
        bh=2xZdzRAuLUerdkuoZqPN6cKExCCDywGDTjQ2X8rwjTw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZxUr1+bmchoU0vyLpxSMW/Mae58LRLCKVoemoV7REalc5VikQQkZPybfglCncxGT6
         tUY6wpXxsgIRLmmfuNTrRd28pr+Zc+HSAaq9PiBV2KPoOtaTdwWOhJ2gJm8ugwAuSd
         uydxUrdNSLvRfvjQFMirtK5QknOsQ9LjPDHf+X14LK/PiGJNzrzDCXE7bnh1ELrP5T
         6LqbrOASo4iAzCO3ur2vtC///+RRsNraJTKUOVneF7VcsHS/FkQq0VcYyzGWcuXuJ1
         /WYHp18aVYuGajiz2Uj01INq/vKKLTLls1R9t1uz6eeMTgzj0qbgphu3qj455b7ntS
         jUw/dhaqvRvKg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] wifi: mt76: mt7921: Fix use-after-free in fw features query.
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <51fd8f76494348aa9ecbf0abc471ebe47a983dfd.1679502607.git.lorenzo@kernel.org>
References: <51fd8f76494348aa9ecbf0abc471ebe47a983dfd.1679502607.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, Ben Greear <greearb@candelatech.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168027487819.3675.4308323171224302056.kvalo@kernel.org>
Date:   Fri, 31 Mar 2023 15:01:19 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> From: Ben Greear <greearb@candelatech.com>
> 
> Stop referencing 'features' memory after release_firmware is called.
> 
> Fixes this crash:
> 
> RIP: 0010:mt7921_check_offload_capability+0x17d
> mt7921_pci_probe+0xca/0x4b0
> ...
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless.git, thanks.

2ceb76f734e3 wifi: mt76: mt7921: Fix use-after-free in fw features query.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/51fd8f76494348aa9ecbf0abc471ebe47a983dfd.1679502607.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

