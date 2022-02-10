Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3284B087B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 09:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiBJIdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 03:33:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiBJIdO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 03:33:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D8204;
        Thu, 10 Feb 2022 00:33:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88DBF616D6;
        Thu, 10 Feb 2022 08:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ABEC004E1;
        Thu, 10 Feb 2022 08:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644481994;
        bh=h5BAK9NL0LC0OjjGKnkej1s8XID/CDQC0NW9XJnwKa8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tLWE9ZoM7S6iOyF5P/mAPIaareQqJT6nPKu6EvgUzKaik4prlQ6FCFNfbsAKrysAA
         ePRLsVz1Qq4+JmgeAKxJWcxy7sO/CtNiLJb3Salm/n+ucJxGFE6Mba84WW8q8libEV
         ySorjJVhOB5xQpKsaetGkyeqN+rBDfHf74EVi11cbphMTpDlK7bGqlwQO+W6r6zjRP
         e6ZRilAIAZVTugTn0vyBeKKAF+xOiDXM3n5ChUn0MF3NRByMF3sPL9n9D0w9ClUDFl
         yuCEA8W8nC8oRSo8/jvqE/tY4CIX4m7tUZgm/2+Al9Gv3hv2/qzAGZUrYKMxGtDS+F
         7BOnfScbx2W3A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw88: fix use after free in
 rtw_hw_scan_update_probe_req()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220203082532.GA25151@kili>
References: <20220203082532.GA25151@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Po-Hao Huang <phhuang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164448199009.15541.16431602582392525909.kvalo@kernel.org>
Date:   Thu, 10 Feb 2022 08:33:13 +0000 (UTC)
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

> This code needs to use skb_queue_walk_safe() instead of skb_queue_walk()
> because it frees the list iterator.
> 
> Fixes: d95984b5580d ("rtw88: fix memory overrun and memory leak during hw_scan")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

a954f29aea5d rtw88: fix use after free in rtw_hw_scan_update_probe_req()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220203082532.GA25151@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

