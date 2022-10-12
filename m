Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D85FC0CA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJLGjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 02:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJLGjj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 02:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC08B0B10
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 23:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EB2C61341
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 06:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2915DC433C1;
        Wed, 12 Oct 2022 06:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665556771;
        bh=fMFXHr+GPfCQ+8nQzyiH7Ub/oCaoETpUDx4tv0b6SeU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ikVm1TllATOXuW0FlVvlDL1rM3JWxPjlmQ9RqCL2l8Le9XOh72z4VFvuMgTLsuASU
         4tuf+sLaBUM5yPgpVWdtsENYVXWtZ1Zq6TpHWH1VO4dbublzkWC/9dKmYPXke0jk9l
         MD9c5ZNlOhFJ/CTkpAqu9KdQEeQDwDawSU5mSKX2YitnWWXW9irbUm3bxqgd+ZY3Ec
         rCUhDalk5oJX+7ABs8sv+MNw0w5/hRyNFi9KRbwAQZSoDA4Do6sAzJyB1G9nhjHBYZ
         7T2QfyUOVBWtEREb5VTRXKWLCsYtZceR9RRXOo+CAkySStSsr3zEmEfwf5K4loFiqU
         QoYxrOmbV6VVQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix firmware assert during bandwidth change
 for
 peer sta
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221005095430.19890-1-quic_adisi@quicinc.com>
References: <20221005095430.19890-1-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166555676816.24262.18337479750869695639.kvalo@kernel.org>
Date:   Wed, 12 Oct 2022 06:39:29 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Currently, ath11k sends peer assoc command for each peer to
> firmware when bandwidth changes. Peer assoc command is a
> bulky command and if many clients are connected, this could
> lead to firmware buffer getting overflowed leading to a firmware
> assert.
> 
> However, during bandwidth change, only phymode and bandwidth
> also can be updated by WMI set peer param command. This makes
> the overall command light when compared to peer assoc and for
> multi-client cases, firmware buffer overflow also does not
> occur.
> 
> Remove sending peer assoc command during sta bandwidth change
> and instead add sending WMI set peer param command for phymode
> and bandwidth.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Fixes: f187fe8e3bc65 ("ath11k: fix firmware crash during channel switch")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3ff51d7416ee wifi: ath11k: fix firmware assert during bandwidth change for peer sta

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221005095430.19890-1-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

