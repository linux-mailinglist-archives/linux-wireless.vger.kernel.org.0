Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB05379A9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 13:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiE3LRn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 07:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiE3LRm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 07:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6081EC48;
        Mon, 30 May 2022 04:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B444560F34;
        Mon, 30 May 2022 11:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F60C385B8;
        Mon, 30 May 2022 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653909461;
        bh=aXeqGwfpDsm+9V51ELwmKYr8ivzqMiNTDnRJlO+qDCM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fvpYTaaIe4XjPNNpCgh3qZZo//VWQ/wCZNQuk8Bma72jOnbIOblldzV9g/JC8tukG
         w77bJqpztVa6AuJApCWfag4j6vAy7KTd33FmqHNbyK2ZEmM+1+187RM5I5Ihl7w3aP
         3hdtCKUk6LUvSsQkhp/vzTZDHNaZ1PrUnNMr3hXRzlr+N4Zmu6yXeNgX+ubdrld0Qn
         vOpmvsBqIcPYzpUuYVh8N183Z4qTJD7KMkywdbt/mwfx78eANwJuYYcjEplw4g04G7
         we6drBIjlAbezbEyXxV+ssP+ki4vssYmnONN1B1N9GrRPWtclA9DfE+4mgsScRGJGR
         XF1ZIyw0TCwBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtlwifi: fix error codes in rtl_debugfs_set_write_h2c()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <YoOLnDkHgVltyXK7@kili>
References: <YoOLnDkHgVltyXK7@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165390945770.29197.8369000797188953316.kvalo@kernel.org>
Date:   Mon, 30 May 2022 11:17:39 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> If the copy_from_user() fails or the user gives invalid date then the
> correct thing to do is to return a negative error code.  (Currently it
> returns success).
> 
> I made a copy additional related cleanups:
> 1) There is no need to check "buffer" for NULL.  That's handled by
> copy_from_user().
> 2) The "h2c_len" variable cannot be negative because it is unsigned
> and because sscanf() does not return negative error codes.
> 
> Fixes: 610247f46feb ("rtlwifi: Improve debugging by using debugfs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied to wireless-next.git, thanks.

b88d28146c30 wifi: rtlwifi: fix error codes in rtl_debugfs_set_write_h2c()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YoOLnDkHgVltyXK7@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

