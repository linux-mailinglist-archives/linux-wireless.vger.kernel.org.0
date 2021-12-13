Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87558472634
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 10:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhLMJt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 04:49:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39428 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbhLMJrQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 04:47:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BF65CE0DDE
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 09:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBD7C341C8;
        Mon, 13 Dec 2021 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639388833;
        bh=8QlZsUgUz+MDqRFw1w/g6ysUSt3CDw1rJaN60QZatOw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cWBKru2xHo1icdrtfd4ZqxTyE7O3JomIvahvkb/nOuhTfWKUZwHcFWZEo/RYcilIp
         Y28Aw1xA1+E58gB44XJS3lnpLqAMpi2K+6HTmRLgY+KoY/6ht0RIEfN859Vg5NVL4c
         HEinVoEs2A/L+dM8mXTK7nw1ZVagIXR3xRxexEDnXyya7QnWZQhdjdRdO6Sp8iAKyc
         uIn/aIEcwzgwJAEVO/aNg/kRgbb1b5UNnZpNHNY1BPVCt9h3A3tR6Xw3B3QACYVMhg
         GQCZIfFUZcdMBeiUbVKJ1z+s3976XJXGfmt9LS4To5ZSWqXXSEI0NavQIomvOoVFeQ
         RN1uaNgnv+RZg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: support MAC address randomization in scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1638948007-9609-1-git-send-email-quic_cjhuang@quicinc.com>
References: <1638948007-9609-1-git-send-email-quic_cjhuang@quicinc.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163938883112.20609.15311677258587032214.kvalo@kernel.org>
Date:   Mon, 13 Dec 2021 09:47:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> The driver reports NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR capability
> to upper layer based on the service bit firmware reported. Driver
> sets the spoofed flag in scan_ctrl_flag to firmware if upper layer
> has enabled this feature in scan request.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9cbd7fc9be82 ath11k: support MAC address randomization in scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1638948007-9609-1-git-send-email-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

