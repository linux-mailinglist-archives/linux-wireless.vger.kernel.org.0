Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07D472655
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 10:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhLMJuc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 04:50:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33810 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbhLMJsZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 04:48:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6B9AB80DE8
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 09:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A43C00446;
        Mon, 13 Dec 2021 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639388903;
        bh=DC68JIr84+fzw+mcTWgPsT98pQL6mGXd9SXDxnkaZQs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Rr08vn8oEzhh+Ch4EeiHxzgRhJ/B8TB2X4wuf2oy2EwEeF2kQShEtSRE8RyaESGPx
         HDJU/vfOdyx4cVmvsULpQ/WSgo+rcZlVm+iM4dUmxSeYfcsZQJIbXtmjpiZCNyaqqm
         dfZ5yt5n0uUhhZp2/m+x0yqmho+qjSAvZ7ud/ChNvRbfbq8PWPJcUDESy9r5NZbgyR
         Z3b0VMwLCs3uSxw9+8AcQp/NnszQ+ipztnvLIQBHoTBARiIVO798jBzprEX9vR5uIz
         k4ofqzLa1Pc37sTGizkfCir+YPNbxz9C0QucQ1PmG7iwYOazQHyKSuaDZs/dZof1X2
         PO/I/KdCI9zYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: set DTIM policy to stick mode for station
 interface
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1638948694-15582-1-git-send-email-quic_cjhuang@quicinc.com>
References: <1638948694-15582-1-git-send-email-quic_cjhuang@quicinc.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163938889725.20609.17596533691501536568.kvalo@kernel.org>
Date:   Mon, 13 Dec 2021 09:48:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> Set DTIM policy to DTIM stick mode, so station follows AP DTIM
> interval rather than listen interval which is set in peer assoc cmd.
> DTIM stick mode is more preferred per firmware team request.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

55e18e5a76ab ath11k: set DTIM policy to stick mode for station interface

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1638948694-15582-1-git-send-email-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

