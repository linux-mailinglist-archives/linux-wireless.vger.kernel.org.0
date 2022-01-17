Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914B74908C5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 13:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiAQMhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 07:37:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42002 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiAQMhj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 07:37:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E106B8104F;
        Mon, 17 Jan 2022 12:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA05C36AE3;
        Mon, 17 Jan 2022 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642423057;
        bh=P/4ypUvSVoNhfvCVlcs6PIj/nztszYxr3tJXDpKx0AQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kOv0sLKAWJuO36BaFW/clbJNKuy30V1303of+GpbLMpl4xrne2D+RS9TMJ98EtdSQ
         XIZFubm9zUuTnAPAttdoyJP1qu6XarL8Hr+gL9D9+wDt/WAjcMh9LGci5/m8XBUDrg
         zmFfsvkKG3gXwD+cm5SEmELvMby/J+CMj1l9Hg9fGZSP9aC2iEvV40pG25BU66kWao
         ryG8X2GUhMTKAPONFhpME76TTxQRcjkbilByqrIFFWwl/rHt/JyBgOfCFMfOCarcPD
         jdj8PkRoQr4/gIHeu4TWi6ik4WvwyLeOQjR/sETSJqgwjaKGE08qlUR4QK+lAljQOk
         +40GomMpyOnpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix error code in
 ath11k_qmi_assign_target_mem_chunk()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220111071445.GA11243@kili>
References: <20220111071445.GA11243@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Anilkumar Kolli <akolli@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164242305424.27899.2840074267453556270.kvalo@kernel.org>
Date:   Mon, 17 Jan 2022 12:37:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "ret" vairable is not set at this point.  It could be uninitialized
> or zero.  The correct thing to return is -ENODEV.
> 
> Fixes: 6ac04bdc5edb ("ath11k: Use reserved host DDR addresses from DT for PCI devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c9b41832dc08 ath11k: fix error code in ath11k_qmi_assign_target_mem_chunk()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220111071445.GA11243@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

