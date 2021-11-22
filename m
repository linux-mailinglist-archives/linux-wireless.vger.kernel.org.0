Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229C9458A1C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 08:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhKVHxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 02:53:11 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:37540 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKVHxL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 02:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1637567403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0gdg1FSFGyxW0lvWu+LflLbkR/UOZICZKnBsBMx7Ppo=;
        b=uWEtgS76KE/QI07Ra2SNxC/vxT/VL4ThaAe5RuLGXe2gg+NgATAq/pu9zrqANgZqiLh2kK
        EDTTvSIwpB07wI+zfiYg9aAmo1GAxHsA0aqqFMsFjz5L1DGKRh6Aw89F1fw/zfwWAhPeeN
        0j7Z1Ug5Ca0QpQvjEqpCD0KNF6HuX/A=
From:   Sven Eckelmann <sven@narfation.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v4 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
Date:   Mon, 22 Nov 2021 08:50:00 +0100
Message-ID: <2802525.9g7TWp2vRq@ripper>
In-Reply-To: <a6f4fd77b1f8729368fee13a435fe652@codeaurora.org>
References: <1637504521-30997-1-git-send-email-akolli@codeaurora.org> <1724585.GBsqGgcNsD@sven-l14> <a6f4fd77b1f8729368fee13a435fe652@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Monday, 22 November 2021 07:12:27 CET Anilkumar Kolli wrote:
[...]
> >> +			start = reg[0] + reg[1];
> >> +			size = reg[2] + reg[3];
> > 
> > See my messages for v2 [1] and v3 [2]
> > 
> > 
> Thanks for the review,
> 
> Here addresses are always within 32-bit.
> so I will change the API to read only 2 integers and update start 
> addresss and size.

The size of address and size depends on the reserved-memory node - not the 
qcn9074 node. So please don't make such assumptions in your code.

Kind regards,
	Sven



