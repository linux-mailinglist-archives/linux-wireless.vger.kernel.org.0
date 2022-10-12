Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A765FC0CD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJLGkw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 02:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJLGkv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 02:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F40221E28
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 23:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44B9661435
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 06:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B739BC433B5;
        Wed, 12 Oct 2022 06:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665556849;
        bh=xwJ1C/ciPsPwu3x1Vfv0XWcrHHmo/rCtbUjdAczdcH0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=q2zliXVXXm5LuFTtySM1n8EXKCT3v2F6yiZLrc9KVDYyVdRnI+pa7RDyxZFmDl4FI
         C4mjGJ9svLFC0mBrVb3yrTZuuYoS2f/F8aQOZlJTBIGjxE2jmT4RqOjbLfX08BIBjP
         QKv2RRo4+qUGbO0Chev/CdKOFEKyGb+GPkm+5z1lhpuswS/q8kEG9o1WRHWjopqwUv
         llWPPzzftm9Ve9wwzZnRROACZKpTnkVie2Ubkzb/nqJskCEed0ZHxfUUFTfDG97cvd
         WPOAvs4zggEaxvpToksgKb81yeLXQM+J1GiAGRk5RM6e9jPOnva3xAblc/uWKJ61RD
         4jQ4nC89OLzEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: suppress add interface error
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221006005842.8599-1-quic_periyasa@quicinc.com>
References: <20221006005842.8599-1-quic_periyasa@quicinc.com>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166555684456.24262.12415945639167628856.kvalo@kernel.org>
Date:   Wed, 12 Oct 2022 06:40:48 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> In the VIF (other than monitor type) creation request, we should not
> throw the error code when the monitor VIF creation fails, since the
> actual VIF creation succeeds. If we throw the error code from driver
> then the actual VIF creation get fail. So suppress the monitor VIF
> creation error by throwing warning message instead of error code.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00760-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

638b26652b04 wifi: ath11k: suppress add interface error

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221006005842.8599-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

