Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C80876E7E5
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 14:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjHCMHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 08:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjHCMH2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 08:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192124218
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 05:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF48361D70
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 12:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741A7C433C8;
        Thu,  3 Aug 2023 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691064434;
        bh=FcIAQJvi0f9nEdlH2bPIyuovN6cCDxSxeq8EJZOtn4c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ex5qXPsXeanTJ8vTG1/9sIF08mg3dsnT+Jbzx8Psc5AXhwY9kj28ysYjdNXc5qJkL
         rCyNbYPj7ZtzfYFi03+pomh/A3slMuRfsAqFbUm4IhiZc7bNofFMpKwLRHq/fWWOYc
         UGJRrBRvsnr8EzAX/V8q0wiEb9WTJtE8SdHoCGkUhp3Glf6hFq9z2iTN/AMV9tO729
         ug8z6a21lCV9/64kVlYA3mScnQqQgHwfjOlmKcM1M60KutzoIs9KsXyGmtSK53UxIq
         1u8gdlsUyE59a70Ig+8hTuachmJvxJ7hdg4aK9dHxzFtlvL9YgTF+qyJEbWhTTc0fK
         KLP2pyp0l7vLg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/8] wifi: rtw89: recognize log format from firmware file
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230801021127.15919-2-pkshih@realtek.com>
References: <20230801021127.15919-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169106443111.1024854.4401575962601802805.kvalo@kernel.org>
Date:   Thu,  3 Aug 2023 12:07:13 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Firmware log format is an element of multi-firmware file
> and used for firmware to provide log with formatted text.
> Driver needs to recognize it in advance if it exists.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

0520841960de wifi: rtw89: recognize log format from firmware file
cad2bd8a136c wifi: rtw89: support firmware log with formatted text
1b073b350d24 wifi: rtw89: introduce v1 format of firmware header
12b1a12548eb wifi: rtw89: add firmware parser for v1 format
7d112665982b wifi: rtw89: add firmware suit for BB MCU 0/1
a337d4331fd6 wifi: rtw89: introduce infrastructure of firmware elements
894747206893 wifi: rtw89: add to parse firmware elements of BB and RF tables
dd59c6a32b71 wifi: rtw89: return failure if needed firmware elements are not recognized

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230801021127.15919-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

