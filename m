Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C36F7DF7
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 09:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjEEHdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 03:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjEEHdh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 03:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA418A5C
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 00:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F32C563B91
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 07:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70147C4339B;
        Fri,  5 May 2023 07:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683272015;
        bh=ZMxBL0ey/PALCfoC99IyMyvPyPbo+CXua2xUig9WP9s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BZCbZEivtZ643WOr9IEF7lO8rnxuqtc8DNL4ZulU24vZSjAcnK2zHe8JLvsVYpXai
         KRM++4L/dSLVyxMNv5r5CEFS30+LFQhj3U0oApobW/Aj2OhtCIeV7OQQDLm7CoHDmO
         F1nkKk4AblBVAsrFdUxUgMesYWTUUa2koQJjZ9kgCWli7BLFkDGKd6dwvDa6n3iBlV
         YTcoXsNMharb1K0Fc2cL3bnIDACw1tc1Z3MNHwp44ttoLPHJBHfzi95CM/p1bZ1yXl
         PrgD5ChytBBh2NpIZLN5ksA8ENzZqQRVIhtarXAZI9m9jAFZpPwkk5PevUCIfHVTP7
         UBqtJdMPPGbOA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Support USB RX aggregation for the
 newer
 chips
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <16d2d1ff-6438-10c9-347f-6e14dd358ccf@gmail.com>
References: <16d2d1ff-6438-10c9-347f-6e14dd358ccf@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168327201220.10202.2831812793766874008.kvalo@kernel.org>
Date:   Fri,  5 May 2023 07:33:34 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> The driver can receive several frames in the same USB transfer.
> Add the code to handle this in rtl8xxxu_parse_rxdesc24(), even though
> currently all the relevant chips send only one frame per USB transfer
> (RTL8723BU, RTL8192EU, RTL8188FU, RTL8710BU).
> 
> This was tested with RTL8188FU, RTL8192EU, RTL8710BU, and RTL8192FU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

6dc28456aa17 wifi: rtl8xxxu: Support USB RX aggregation for the newer chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/16d2d1ff-6438-10c9-347f-6e14dd358ccf@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

