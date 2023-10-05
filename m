Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA0A7BA203
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Oct 2023 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjJEPLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Oct 2023 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjJEPKI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Oct 2023 11:10:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD95E9029
        for <linux-wireless@vger.kernel.org>; Thu,  5 Oct 2023 07:42:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE5EC433AB;
        Thu,  5 Oct 2023 06:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696487063;
        bh=yzON0/8AzdJNaPS9HT17ZwhuFj1fWIAt4MvZ47s8buw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sItvzO2qI36HAyZ/ml0DUgZDqxB5P3WoYpvmYVF+TQnoVwtaSniu/fBPEf9YcLgIj
         MlWtQN8y8m+uYlZHGrUS9W9CyqM9AeK7w08w0Gp00LFo1VlP+ySoBPQ0Kv4r29mcgH
         VkLZTHPOupRFiTRGT/dCBJSSSJ7uAoKbeJV6Q1kcEQjpQqzGcifyIBtUuw6r1MNAf6
         C7BuxsZb/0QQ8ERyuAthmu/jNrGJm9TlyfVVI2AdIiUL0e2rXzi59y6B/dwja0TREY
         srC6MwJKnXLoEDu6nSQy8xD8f0Bj8mhVmI7RyS2007V1shs8BTs9ZBki8EfWr9motz
         9kZGFmbTWN5ag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix debug messages
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231003150132.187875-1-kvalo@kernel.org>
References: <20231003150132.187875-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169648706024.444191.15030535746469071290.kvalo@kernel.org>
Date:   Thu,  5 Oct 2023 06:24:22 +0000 (UTC)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> In ath12k the debug messages were broken, no matter setting what value to the
> debug_mask module parameter would not get the debug messages printed. The issue
> is that __ath12k_dbg() uses dev_dbg() to print the debug messages which requires either enabling
> CONFIG_DYNAMIC_DEBUG or DEBUG symbol in the driver.
> 
> ath12k is supposed to use debug_mask module to control whether debug messages
> are printed or not. Using both CONFIG_DYNAMIC_DEBUG and debug_mask parameter
> does not make any sense so switch to using dev_printk(), just like ath11k does.
> Now it's enough just to debug_mask module parameter to get the debug messages.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

453a62a3ee65 wifi: ath12k: fix debug messages

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231003150132.187875-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

