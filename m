Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E044F46E3EB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 09:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhLIISF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 03:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhLIISF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 03:18:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501BFC061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 00:14:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5E3DB823CE
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 08:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87705C004DD;
        Thu,  9 Dec 2021 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639037669;
        bh=cI6fB8jYk7B5iWJUwkjsFL5eE4/I5EYnZxkDXmlOWpE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rNdb+jTFormIy9AOcRmnXdBITRxUWcHuJFNXw1JWr/n3bBiIjIj1ct1c5BL1YDcj1
         nUVWYisy6/QdFrtUFMg8wsR6Um8XjtT4jZCNczmWuTQVhTksSgkYUj+n82R3f9FkJ4
         R1n7/J5YGIbUuGQqAh7SYXsejz4QLvKP2QpddXm9J52qEATT/W04YNwY9iIbb79GLJ
         DGs3WVYj9j2AjciL2WSiKkJOvkCAG6GDkvyklMCqk8+IKAOr9C/y+L337zze29PAG3
         TnRnlPm/4Z2ybsVCgwyFCw7h+ydGw7SboZr2dLC5zMnfoSQoEjNvIb2fr7Mi//CRwl
         1+0Td6ogvsSGQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2 2/2] ath11k: add spectral/CFR buffer validation support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1637312901-10279-2-git-send-email-quic_vnaralas@quicinc.com>
References: <1637312901-10279-2-git-send-email-quic_vnaralas@quicinc.com>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163903766687.12588.9252504203114598638.kvalo@kernel.org>
Date:   Thu,  9 Dec 2021 08:14:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <quic_vnaralas@quicinc.com> wrote:

> Currently there is no validation on the spectral/CFR report
> over the db ring buffers from the hardware. Improper/incomplete
> DMA by the target can result in invalid data received by host.
> Due to this we may populate incorrect data to user space.
> 
> This buffer validation support fix this issues by filling some
> magic value in the buffer during buffer replenish and check for
> the magic value in the buffer received by the target. If host
> detect magic value in the received buffer it will drop the buffer.
> 
> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d3d358efc553 ath11k: add spectral/CFR buffer validation support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1637312901-10279-2-git-send-email-quic_vnaralas@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

