Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D0846BF2A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 16:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhLGPYN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 10:24:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42670 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhLGPYM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 10:24:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7961B817EE
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 15:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F14C341C1;
        Tue,  7 Dec 2021 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638890440;
        bh=xThCXqS9vt3UdmlM3luV8ZihBgMS1KXQQ6vBmJY3ZEo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KYOpsO0hIfbNqOXrZ2uG2yr7Cn6+rwmfhm3LBxzsfue0fCnn6RnpRSTYqjqZ6H9GK
         /nHtWAF6y3FyO2UfCD59sME/uHc4UsqhUTZ8X/UDUA6wWJPExJM+0wYjiezOoV+Mm1
         fClwHYs1BvjsA5AhOW3MkFFNj6qeH87pLfLCdp+c+AgDayO7LvqIcwEdxlJ9uoUAab
         qdcTTdykK6XgAVjhPKGYVwehggMmB6JJezDr7bGohOFUekrN2Q4rqbuqbfoUIYIZfd
         VV5eLJqpjhK0kJRuvYAnf3iO1pMn/o4Z3SIyI8DUMn5ZxUnNWFWG1keA1gxYtUNbtq
         0oTRfM5b1UWGg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: change to use dynamic memory for channel list of
 scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211129110939.15711-1-quic_wgong@quicinc.com>
References: <20211129110939.15711-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163889043476.23771.17333304212606374426.kvalo@kernel.org>
Date:   Tue,  7 Dec 2021 15:20:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently there are about 60 channels for 6 GHz, then the size of
> chan_list in struct scan_req_params which is 40 is not enough to
> fill all the channel list of 6 GHz.
> 
> Use dynamic memory to save the channel list of scan.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

cea7f78d85f3 ath11k: change to use dynamic memory for channel list of scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211129110939.15711-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

