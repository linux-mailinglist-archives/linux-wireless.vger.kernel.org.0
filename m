Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4E729BA6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjFINce (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjFINcd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 09:32:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8517DA3
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 06:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AFCE61148
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 13:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DA0C433EF;
        Fri,  9 Jun 2023 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686317551;
        bh=VWtPK+NVPlTuC/kTVE/KyPcbrCeJD6EGJahYJ6mP0Ug=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=t847Ao8slT5+aUu/DkOUkfZ5+q8om2Iw4WxHZRE+Hn/9NmrWfKbi+TlRAWWtyiADk
         DHgw0bpbkMEj3q3F98xbrHtetkLhVll9/dlkFfES/lb1wpJGl2RSiaksA5sviqDw2Z
         p/d/x2F1hysxNWllCPPw5e9Bv0w51f1I7IrLRcINiHt2MWspHD+6C8T4k712EZVzXe
         9OmjKnHPw9rDv0fX6KzIdqr/pJY6jf/w4NbqCvX4uHwmt+J9zv9qzv7im/BkAiObMU
         r2vBLiozPBhZVrIpfB+GpriAEzO+hQRb1QfCPuk96NUW7dnOM+a3hynrG/on3kYpxI
         lVvYE9V7w3DOQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: check hardware major version for WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230518105741.1281424-1-quic_cjhuang@quicinc.com>
References: <20230518105741.1281424-1-quic_cjhuang@quicinc.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168631754869.7235.13448644597853055562.kvalo@kernel.org>
Date:   Fri,  9 Jun 2023 13:32:30 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> This is to check the hardware major version for WCN7850 so only
> supported hardware is initialized. Now only WCN7850 with major
> version 2 is supported.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3394b51c7d3f wifi: ath12k: check hardware major version for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230518105741.1281424-1-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

