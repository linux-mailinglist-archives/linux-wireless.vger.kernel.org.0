Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D861F477607
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 16:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbhLPPeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 10:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhLPPeH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 10:34:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D80C061574;
        Thu, 16 Dec 2021 07:34:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A9C361E3C;
        Thu, 16 Dec 2021 15:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216B0C36AE4;
        Thu, 16 Dec 2021 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639668846;
        bh=c9OVquxnCbPd7oE5qBrhnnxW3NX2Nl9yQXk5jMs/9Z4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IvvBTsBqRVXkFpkBp8KpqvGhL1Tfb07SBOZgGe7x37FwVM5+hrvLc2Rn4Uv4Moecy
         iWQA00vSWX0o/FdX0kglT+OXsWXtgKLW4GIbzB6hscfw2N7EwuCm8t35eKOuuelVsy
         TpQdy281lEiXNMb6nSuJ5TpdOPw5QhhkBgZapmfDqdZ3K9iEr8DxT/NQXEV5bMZ8mt
         w4YA7U8cQXWAGRnMOu03+DcQdfi0QBFsgYltFTtQqrHXhJ728yVuhG8SheU7DjEk0s
         ndj/jYXsjLclOpyahtFtfHM8Z8kzzt12jwfL80gdNFKPOZPnuQ1ISP/0bSyvLR1QXX
         8MZJtF3BpGpQA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 1/2] dt: bindings: add new DT entry for ath11k PCI
 device
 support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1638789319-2950-1-git-send-email-akolli@codeaurora.org>
References: <1638789319-2950-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163966884345.4646.11460460661865754904.kvalo@kernel.org>
Date:   Thu, 16 Dec 2021 15:34:04 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
> Ath11k firmware uses host DDR memory, DT entry is used to
> reserve host DDR memory regions, send these memory base
> addresses using DT entries.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

77a0a30bb507 dt: bindings: add new DT entry for ath11k PCI device support
6ac04bdc5edb ath11k: Use reserved host DDR addresses from DT for PCI devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1638789319-2950-1-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

