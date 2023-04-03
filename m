Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437336D45F5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjDCNjF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDCNjE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 09:39:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBA26A9;
        Mon,  3 Apr 2023 06:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3F16B81ABA;
        Mon,  3 Apr 2023 13:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D49C433D2;
        Mon,  3 Apr 2023 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680529140;
        bh=WCFvnKJDN1ldCJrZMZbHk+9WKFAoxGDQHk9tIhXqgwo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bQx4o3H71KLPaOm6ptTMMh0RvtxCrxsDEkwm4PMtWC9GyNKGMDETnrLnj0Jy5rBJh
         e0AykclcdzyEyZQ2gD3hFOeO71+vIbBx050ZL5UKjSm6AYMU5sd1xtKJkngBkWiWea
         zezUPu7foE6Ydwgy28xzGHwitbzYq3KBeU2ofvrgNbum+sb57y8rS1HcQ1Fv5D9I3z
         SINpMH6zoFjI5DY/CEIdgFJtEOqZeg/j+2e6yJjNEEZ+XKrf3xIWyVuyxsMnRwRefw
         W7rOtuUijJaa4wa0s+pPOVo0A1CbWWFud7YdBH9KG/hBsvFYwZp9ZIwdaicVe4fsQ0
         erF1GlQuqxuIw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/5] wifi: rtw89: Remove redundant pci_clear_master
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230323112613.7550-5-cai.huoqing@linux.dev>
References: <20230323112613.7550-5-cai.huoqing@linux.dev>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     cai.huoqing@linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168052913602.11825.8401946165259356841.kvalo@kernel.org>
Date:   Mon,  3 Apr 2023 13:38:57 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cai Huoqing <cai.huoqing@linux.dev> wrote:

> Remove pci_clear_master to simplify the code,
> the bus-mastering is also cleared in do_pci_disable_device,
> like this:
> ./drivers/pci/pci.c:2197
> static void do_pci_disable_device(struct pci_dev *dev)
> {
> 	u16 pci_command;
> 
> 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> 	if (pci_command & PCI_COMMAND_MASTER) {
> 		pci_command &= ~PCI_COMMAND_MASTER;
> 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
> 	}
> 
> 	pcibios_disable_device(dev);
> }.
> And dev->is_busmaster is set to 0 in pci_disable_device.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

5995f7463101 wifi: rtw89: Remove redundant pci_clear_master

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230323112613.7550-5-cai.huoqing@linux.dev/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

