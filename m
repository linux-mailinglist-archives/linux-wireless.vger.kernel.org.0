Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FBE46CF36
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 09:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245016AbhLHIlp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 03:41:45 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49500 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbhLHIlp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 03:41:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC740CE2047
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 08:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A65C00446;
        Wed,  8 Dec 2021 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638952690;
        bh=031cFlVIWHAdjAyO7ac8QoUiJkrzGitfCrvbYxsd4K0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WlTu2E5yPbnvJbA6UbtJ0yNDzq7MY0gBlwJWLJIYoDv4z68P0Y20T3RTQ8QSxGq/Z
         1+cGNrBuqjxazyaSQ6Wfvbx6NbdiLtxF/Oz+txei1pNOY4d4eU2t3+1eKlJcuYuhCh
         FhQ7DhVE9HNJKZnOqyexfseyu1IK/utdjpBpxRAhKy0NO9Vh1EEqABPnv2rpgkxLyR
         UDjIvc4BU2JCzWrgEVutC1nfA87GHr4/9lf2VvDeOFn+YAxLVxu/iyhbpnnePBKBxb
         k7yVZnuPn1JnoI4T95d+dBcE3USnsxKZwIScGcehDtIv8yPSGuaE4q0ZNzFFH38voc
         P6Q9wRbFLlRnA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix tx hanging
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20210505085806.11474-1-s.gottschall@dd-wrt.com>
References: <20210505085806.11474-1-s.gottschall@dd-wrt.com>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163895268758.29041.1351445152557933914.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 08:38:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Gottschall <s.gottschall@dd-wrt.com> wrote:

> While running stress tests in roaming scenarios (switching ap's every 5
> seconds, we discovered a issue which leads to tx hangings of exactly 5
> seconds while or after scanning for new accesspoints. We found out that
> this hanging is triggered by ath10k_mac_wait_tx_complete since the
> empty_tx_wq was not wake when the num_tx_pending counter reaches zero.
> To fix this, we simply move the wake_up call to htt_tx_dec_pending,
> since this call was missed on several locations within the ath10k code.
> 
> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e8a91863eba3 ath10k: Fix tx hanging

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210505085806.11474-1-s.gottschall@dd-wrt.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

