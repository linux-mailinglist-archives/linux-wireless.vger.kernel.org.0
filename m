Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E5C9A709
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 07:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392036AbfHWFXt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 01:23:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:38256 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392030AbfHWFXs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 01:23:48 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i1238-0003kO-KB; Fri, 23 Aug 2019 08:23:47 +0300
Message-ID: <d14184a6deb19637864fa7734354f64f387bf24d.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Wang Xuerui <wangxuerui@qiniu.com>, linux-wireless@vger.kernel.org
Date:   Fri, 23 Aug 2019 08:23:45 +0300
In-Reply-To: <20190223083543.6009-2-wangxuerui@qiniu.com>
References: <20190218150952.6889-1-wangxuerui@qiniu.com>
         <20190223083543.6009-1-wangxuerui@qiniu.com>
         <20190223083543.6009-2-wangxuerui@qiniu.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] iwlwifi: mvm: fix unaligned read of rx_pkt_status
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-02-23 at 16:35 +0800, Wang Xuerui wrote:
> This is present since the introduction of iwlmvm.
> Example stack trace on MIPS:
> 
> [<ffffffffc0789328>] iwl_mvm_rx_rx_mpdu+0xa8/0xb88 [iwlmvm]
> [<ffffffffc0632b40>] iwl_pcie_rx_handle+0x420/0xc48 [iwlwifi]
> 
> Tested with a Wireless AC 7265 for ~6 months, confirmed to fix the
> problem. No other unaligned accesses are spotted yet.
> 
> Signed-off-by: Wang Xuerui <wangxuerui@qiniu.com>
> Tested-by: Wang Xuerui <wangxuerui@qiniu.com>
> ---

Thanks! I have applied this to our internal tree and it will reach the
mainline following our normal upstreaming process.

--
Cheers,
Luca.

