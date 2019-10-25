Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C8E425A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 06:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbfJYEVa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 00:21:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfJYEVa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 00:21:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F81D60F78; Fri, 25 Oct 2019 04:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571977289;
        bh=+utTc/SmQbvEWQyvz16EME9vpx8QNUQyRQdLp/TXff4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=o85WzxNij2g1kznLYay424ug3MqdFRfUiN0yOzIfRHhMspxulZXk1ceFG6awz1l3s
         1dHo9uu8828V0dqFP95gfShW/m7VSRmiLrmcStaCiJiWAqbjYuEwZl6KaCauJWMvT0
         3/EnPtlUZcp5SkRytLd3nDOMlhzyrV2ZRvOcaDTI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B55D260F5E;
        Fri, 25 Oct 2019 04:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571977288;
        bh=+utTc/SmQbvEWQyvz16EME9vpx8QNUQyRQdLp/TXff4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FDwB5RjmsJG52dfHMa9eqo2UIw9VThufu2AIGPCYtz+BaQ4AWCyHQB/rld9DYBByK
         guV7VrSmvKS+a84Yx991X2YDKvxOYVb+O4bczHryvOJuIHL0j/yqVo6PrBy7EgiWRE
         oREIGb8/tPB9d0HhCOLzvTpBdD446PrEMkWEqZOE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B55D260F5E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Tzu-En Huang <tehuang@realtek.com>, kbuild-all@lists.01.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Chris Chiu <chiu@endlessm.com>, linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:master 89/97] drivers/net/wireless/realtek/rtw88/rtw8822b.c:1440:6: sparse: sparse: symbol 'rtw8822b_pwr_track' was not declared. Should it be static?
References: <201910250727.FvcwI0W2%lkp@intel.com>
Date:   Fri, 25 Oct 2019 07:21:23 +0300
In-Reply-To: <201910250727.FvcwI0W2%lkp@intel.com> (kbuild test robot's
        message of "Fri, 25 Oct 2019 07:55:48 +0800")
Message-ID: <875zkdjvzw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Tony, can you send a followup patch to fix this as well?

Kalle

kbuild test robot <lkp@intel.com> writes:

> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git
> master
> head:   b298800dd8ee7250bf04b4dbd151e1a971b6df91
> commit: c97ee3e0bea29827f4b44276fc792bd32977edb0 [89/97] rtw88: add power tracking support
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-dirty
>         git checkout c97ee3e0bea29827f4b44276fc792bd32977edb0
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/net/wireless/realtek/rtw88/rtw8822b.c:1440:6: sparse:
> sparse: symbol 'rtw8822b_pwr_track' was not declared. Should it be
> static?
> --
>>> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1008:6: sparse: sparse: symbol 'rtw8822c_pwrtrack_init' was not declared. Should it be static?
>    drivers/net/wireless/realtek/rtw88/rtw8822c.c:2871:6: sparse: sparse: symbol 'rtw8822c_dpk_cal_coef1' was not declared. Should it be static?
>    drivers/net/wireless/realtek/rtw88/rtw8822c.c:3112:6: sparse: sparse: symbol 'rtw8822c_dpk_track' was not declared. Should it be static?
>
> Please review and possibly fold the followup patch.
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
Kalle Valo
