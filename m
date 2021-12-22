Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF85947CCC5
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 07:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbhLVGDY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 01:03:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52442 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbhLVGDX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 01:03:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74EF5617F0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 06:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35F9C36AE8;
        Wed, 22 Dec 2021 06:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640153002;
        bh=PlsFc8W7aK+8N7MO3x46ipD5VZxjQyDnFawGUFk0RYA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WOOIgTpKTfRyxKKdKskgF5p1x2+FVjd0OUiQPTOvEcXurgbI1UKoYh5Rqqk2AJ4Ic
         JIPWUlCBE1YSIZZisj0klrYRzfI31q3yn7YwhURgxyUgrXkfbYPIWv+kH1NG+XfwrK
         yS54mqz8Uk5/cDwtLAZKMFwpLkgXtllEVA8pNPRg19NjFUOcoyFD3DhYjCkE+Jq6Zx
         SKBwWmoD2MtDlIpAQX0E9UMkijhCAVGWu94sz7MDVc+ttbG0jEnLFCqu/b0Biza9SP
         CZjzlIPhUmcb76bui4BVI9bwKz3YwzrpVpF8Vrk87t+lXkrP4PSjHqMN2+tzwJTPaC
         ZkM22nu8zvT0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: add support of firmware logging for WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211220121053.357087-1-quic_chengwan@quicinc.com>
References: <20211220121053.357087-1-quic_chengwan@quicinc.com>
To:     Cheng Wang <quic_chengwan@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_chengwan@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164015300023.20356.3611729757458723636.kvalo@kernel.org>
Date:   Wed, 22 Dec 2021 06:03:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cheng Wang <quic_chengwan@quicinc.com> wrote:

> Host enables WMI firmware logging feature via QMI message.
> Host receives firmware logging messages on WMI_DIAG_EVENTID, then
> sends logging messages to user space via event tracing infrastructure.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Cheng Wang <quic_chengwan@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

42da1cc7bd53 ath11k: add support of firmware logging for WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211220121053.357087-1-quic_chengwan@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

