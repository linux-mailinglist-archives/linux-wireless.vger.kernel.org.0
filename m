Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C460F4A48E1
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 14:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiAaN5v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 08:57:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43880 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349081AbiAaN5p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 08:57:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AEC3B82ADA
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 13:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396A9C340E8;
        Mon, 31 Jan 2022 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643637463;
        bh=GDy5i71yvezvtbREtneGSnT9nz9OBz4VUrQ8qokdP18=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kBL8jqIONqJ/q2rZYU6QgLs06zcvzmwIYcOXZ/wfo9f09DQvOQiv5igrLfdJvh7/k
         yVLYH2vdLW5mQYbOmwnBOzeh4DiATpFWg/vrqQcnMEZrd8uKFN0u23scSDO/Cz6Apf
         St+amiHP+1045+mhHRTIcdOvgZOTVbE9ZBGTVLdLzi4pp/D3G3I2rNEKXysuksCJvX
         wwz0VoVmkH8eUoHQL4mg1CBFoCQF6jorN1pkGt/y6FSys/kyvw3V+J7EdXxou9UVkw
         /t7aHFqiIdP8dDCMS01rQGHvOcATazid0rJ6we8RkYsQ4mt/5Y21+suMlwNcVeN+rC
         p1KHa2egjwt9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Rename ath11k_ahb_ext_irq_config
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1642583893-21485-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1642583893-21485-1-git-send-email-quic_vnaralas@quicinc.com>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164363745873.22527.1638672653095490775.kvalo@kernel.org>
Date:   Mon, 31 Jan 2022 13:57:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <quic_vnaralas@quicinc.com> wrote:

> Rename ath11k_ahb_ext_irq_config() to ath11k_ahb_config_ext_irq()
> for just symmetry with ath11k_ahb_free_ext_irq().
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a76ed59163ba ath11k: Rename ath11k_ahb_ext_irq_config

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1642583893-21485-1-git-send-email-quic_vnaralas@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

