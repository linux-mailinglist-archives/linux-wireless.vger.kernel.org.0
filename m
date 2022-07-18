Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C27577F39
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jul 2022 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiGRKCm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 06:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiGRKCl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 06:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5161AF27
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 03:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7D6608D5
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 10:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDBBC341C0;
        Mon, 18 Jul 2022 10:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658138560;
        bh=K2+Rg4IwZ7UtFKXFaxeaAVip/LVFwlROEd60n9RHjrg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jgvOpGtbRwbUsH6jMA4Gh9ANeY8g0ytyBj25Abgnb4Fsp05bo4w2guPr8oUzlDlfj
         lbl/IsxIZbhsYUIY/+ffAB/C2MoudwjU/woGUoJofmsP5o2bSELqqVr6HAWyXAknk1
         pYtqRpNSCAhnONypxgt2BdbVL8tS4qlxOktnj7ndCW3PwsB/4JoBQ9kNv6RF4yi+fd
         QZAarnf+2ob9IIIKstnHl1LoECXjMRylBqNkRJhBHd+ursPj2IJB5WXXtj/NKgd2bm
         IDFd4eTDCGthcTzQIepNgwLmjCKLfaxBpVn/RFwUtVzyHkno8V0EGVUbexlh75wdq4
         bB9FMChdDgMKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: mac: fix long line
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220708170052.28615-1-kvalo@kernel.org>
References: <20220708170052.28615-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165813855498.12812.2366239081191024787.kvalo@kernel.org>
Date:   Mon, 18 Jul 2022 10:02:39 +0000 (UTC)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Recent mac80211 API changes introduced a long line warning in ath11k:
> 
> drivers/net/wireless/ath/ath11k/mac.c:1404: line length of 92 exceeds 90 columns
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

fcc36be423a4 wifi: ath11k: mac: fix long line

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220708170052.28615-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

