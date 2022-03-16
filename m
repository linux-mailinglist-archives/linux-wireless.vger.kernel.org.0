Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE774DB550
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 16:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349954AbiCPPuy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiCPPux (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 11:50:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A8056406
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 08:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 017CCB81B08
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 15:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35321C340E9;
        Wed, 16 Mar 2022 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647445776;
        bh=gFyBLM689s1UbAA3Xq+a+Uhc+T5lWsKNcnLqW4l5YaA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PQlqGCzPJtu+doxBbjFeCTU6viQgKdrgrtizKqat5wKORIu/egii2e2mdUFsuBuQ2
         XtJAykYAIGWducwIAPlGFtgev5pNmsknB/SQPeVfikZfKKKz8SbmjlYyYw/fCfh8cv
         qkYo2zBrlXz9felJ1iBafPUwgao5fK/kVbz4WyIJn4LjqxOA7mbCT5ENZZQLhCg4Fg
         5fJbwzc12dKUUgD5PGhnb4ay6/yHKalyRLY912WbhYWxIz0ApMImQZUjKMd7/WVTDR
         4fwd6DS9PmBjamTGl4h/5nCfAGG3iruZL95YanHKDhu7iB79mjVqla7fmluAy1wmkk
         MKsfsYFFTgU0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: fix uninitialized variable of
 rtw89_append_probe_req_ie()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220311020007.20414-1-pkshih@realtek.com>
References: <20220311020007.20414-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164744577414.16413.6515643180765548773.kvalo@kernel.org>
Date:   Wed, 16 Mar 2022 15:49:36 +0000 (UTC)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> smatch reports that:
>   fw.c:1997 rtw89_append_probe_req_ie() error: uninitialized symbol 'ret'.
> 
> This can be a issue only if no band is supported by the chip, but it is
> impossible. So, it is still safe without this patch.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

d179c1f1c370 rtw89: fix uninitialized variable of rtw89_append_probe_req_ie()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220311020007.20414-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

