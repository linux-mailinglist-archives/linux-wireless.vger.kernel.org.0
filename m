Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527F149FD44
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349775AbiA1P6D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:58:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52878 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349768AbiA1P54 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:57:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAA67B82630
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2DFC340E7;
        Fri, 28 Jan 2022 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385474;
        bh=N/5p0X1Jz7WuX9DCTycV1w05lEaIDIp/K1o48q3CS8s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eZ4fGFxfRDykYWJTL9xXxE3Svyal3OWEKGwOhSYONRfdSuiAM1rpbnoF1TurAYsbx
         iuVumMJnlNnytL+DO+CTmAGRlvnH8kN0zZhlj9wWMHsCVNd1fYb/7QalnrJLy7xlT8
         YI6NIC46YW900deSDWC3DPKXMxPUlN0mS6C2NfykkyUOKqvuTuDo0qHQEuDFbXjZUE
         VTCj1BXjZPTFR/l5ULDCiaUnayq8ahPV5M9VKQslSAyCRsbZGE7ZZqN2IYYDrkxNYT
         xbMRk/SBs9x9++NsLuZtJ+FaqoG0Mkqis3OqimfylD4Z79Vq+yMgtR379meY2Xcr2Q
         +3FvXsX8i2NKg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rtw89: fix maybe uninitialized `qempty` variable
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220113094253.73370-1-ihuguet@redhat.com>
References: <20220113094253.73370-1-ihuguet@redhat.com>
To:     =?utf-8?b?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        =?utf-8?b?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338547212.19531.3599554444244239620.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:57:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Íñigo Huguet <ihuguet@redhat.com> wrote:

> Call to dle_dfi_qempty might fail, leaving qempty.qempty untouched, which
> is latter used to control the for loop. If that happens, it's not
> initialized anywhere.
> 
> Initialize it so the loop doesn't iterate unless it's modified by the
> call to dle_dfi_qempty.
> 
> Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

89e4a00ff3c0 rtw89: fix maybe uninitialized `qempty` variable

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220113094253.73370-1-ihuguet@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

