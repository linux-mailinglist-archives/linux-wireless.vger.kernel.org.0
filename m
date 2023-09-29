Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7547B2EE8
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjI2JJS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 05:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjI2JJN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 05:09:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067D7CEA
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 02:09:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0699C433C8;
        Fri, 29 Sep 2023 09:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695978547;
        bh=wfl6ypqxXpzsB73dvy0nGzMg6Q0TrSyFS3x5+ngV/Ro=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EFYlNHtwEaNJihc0U7jRQFABRTp6nnaAjIR3G8BkJwQQLuT1RVNSwWq4j46oFK2Sh
         R/xP3e2I0s9nqqqXySQOFKTQT/slfUgqDFXXkQLnlUXkdPF5KtibazSrwTI2z33f3c
         LIGevQxQN2fe6xUSWVRVTTk7SA63rHwr354UjYx9jYPRbgg2sDsUQn80AqkwWImaSJ
         Csv3jqShapbhpEqMPRos3uhTIt3h9puTKY+VcKAEJoJZ0zwDG/3vpBTJiHtXH8Mdqy
         lJKb/kNbLGvqUQp+BPUY1QM6yuMs7cpETjJ7HcHAseRKNKDQzDorc5Ny+ccakajffV
         cFiIwvf+HLeTw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: move pci.ops registration ahead
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230807061749.9404-2-quic_bqiang@quicinc.com>
References: <20230807061749.9404-2-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169597854467.3479545.1030727333826913383.kvalo@kernel.org>
Date:   Fri, 29 Sep 2023 09:09:06 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> In ath11k_pci_probe() there is a switch statement that, based
> upon the PCI device ID, assigns pci_ops. After the switch,
> ath11k_pcic_register_pci_ops() is called to register the pci_ops.
> 
> Unfortunately, this registration is too late if any of the cases
> in the switch need to perform operations that require the pci_ops
> to already be registered. In particular, an upcoming patch for
> QCA2066 needs to call ath11k_pcic_read32().
> 
> To address this issue, call ath11k_pcic_register_pci_ops() from
> each case instead of doing so after the switch. That way the ops
> will be registered if any subsequent operations within the case
> processing require the ops to be present.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

I'll now drop these from my queue, please resubmit as v2 once we have
pushed the firmware to public.

2 patches set to Changes Requested.

13343062 [1/2] wifi: ath11k: move pci.ops registration ahead
13343063 [2/2] wifi: ath11k: add support for QCA2066

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230807061749.9404-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

