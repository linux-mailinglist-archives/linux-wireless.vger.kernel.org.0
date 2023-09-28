Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ACC7B20AC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjI1PPS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjI1PPR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:15:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1A19E
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:15:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD954C433C7;
        Thu, 28 Sep 2023 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695914113;
        bh=kAJs4PHDj7FghUS9FI5ZgzxtTJ3kn3Onea5WYgB1/dY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ni2G6718aymVVuc6bnNUv6im/Be4Y0xPBDHOROtbwS/TIkwOxiPhSyaEZ7mlmylgB
         1dyeN/tzAAlIVKSD/RiJ249JLKLh3wgj9GUEBlT8zPJRMMDjxzRFlBDNX3z6XsUmaV
         h7qRxInzCQKdXfwEp/EoQfLjgqP7fg9eaUV801Ix8sM1wkMaOEcjYU0SGq4cpXEfl8
         pEpb1s+wIFVKEkadQCZrxpNzGY7y+EEXSFyLYodmlXgnZAu40SQ2wNfeUJ/k35CqEp
         DPe2YRKGNtQEqYzjHItNuKLKibsek+GqGwYEaP/Y4lOCvCdFKeqVUzcYz15PjldNaG
         GJkg8/BQx6cpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [v2] wifi: ath11k: fix ath11k_mac_op_remain_on_channel()
 stack usage
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230926042906.13725-1-dmantipov@yandex.ru>
References: <20230926042906.13725-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Tom Rix <trix@redhat.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591411089.3019228.2557633056821001389.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:15:12 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> When compiling with clang 16.0.6, I've noticed the following:
> 
> drivers/net/wireless/ath/ath11k/mac.c:8903:12: warning: stack frame
> size (1032) exceeds limit (1024) in 'ath11k_mac_op_remain_on_channel'
> [-Wframe-larger-than]
> static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>            ^
> 68/1032 (6.59%) spills, 964/1032 (93.41%) variables
> 
> So switch to kzalloc()'ed instance of 'struct scan_req_params' like
> it's done in 'ath11k_mac_op_hw_scan()'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4fd15bb705d3 wifi: ath11k: fix ath11k_mac_op_remain_on_channel() stack usage

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230926042906.13725-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

