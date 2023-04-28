Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD086F1163
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbjD1Fkl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 01:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345054AbjD1Fkk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 01:40:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED431BC5
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 22:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5492463F9B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 05:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EADC433EF;
        Fri, 28 Apr 2023 05:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682660438;
        bh=Z6NUqTrlWX5VBE5oRjZuHIG9wfGp1DFGIcVkDpuGTfQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=sBDZPzys/tD7jgEOxzC6LLL/GIRgSqOJptkcw25m44BTW0nq0yOSg3fXaSb7fzORy
         rICmSfY0MNSZkdDu7QNbsKSVK9NkMWL1SiIfRVd7j0uxoDd+1kPpUnlPR3sOzDWdOy
         FMl1u/czxdGoQKMd7E7eFDhARbmZdQDSxVSjQ/GiK3PsjiF0aExUnlGeIDKBVxf/H+
         5+iAZIscW0d6nXHMp4TE4Tj4AZ0wPujljMJJYRnbDtqKztI1zH8DQ0/QCDBdMIIFa9
         56QlecN2LbUrJE1pwn2CscRqtX2gLFpwoMBN/UoKDFTanb3RJVC6hkAIeW8QNqjS7y
         3rzMKy6lq30kg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kevin Lo <kevlo@kevlo.org>
Cc:     linux-wireless@vger.kernel.org,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: 8188f: no need to initialize interrupts
References: <ZEswqUHBXPHC/znL@ns.kevlo.org>
Date:   Fri, 28 Apr 2023 08:40:34 +0300
In-Reply-To: <ZEswqUHBXPHC/znL@ns.kevlo.org> (Kevin Lo's message of "Fri, 28
        Apr 2023 10:34:17 +0800")
Message-ID: <87ildgpnsd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kevin Lo <kevlo@kevlo.org> writes:

> There's no need to initialize interrupts for RTL8188FTV like the vendor driver.
>
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>

Why do this, what's the benefit? Or is this just a theoretical fix. The
commit log should explain this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
