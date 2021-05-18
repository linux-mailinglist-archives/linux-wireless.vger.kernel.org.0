Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD22387028
	for <lists+linux-wireless@lfdr.de>; Tue, 18 May 2021 05:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhERDKJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 23:10:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4654 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhERDKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 23:10:09 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fkgqx23mWz16QB4;
        Tue, 18 May 2021 11:06:05 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 11:08:50 +0800
Received: from [10.69.38.207] (10.69.38.207) by dggema704-chm.china.huawei.com
 (10.3.20.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 18
 May 2021 11:08:49 +0800
Subject: Re: [PATCH 06/11] net: intel: iwlwifi: Demote non-compliant
 kernel-doc headers
References: <20210517050141.61488-1-shenyang39@huawei.com>
 <20210517050141.61488-7-shenyang39@huawei.com>
CC:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
To:     Luca Coelho <luciano.coelho@intel.com>
From:   Yang Shen <shenyang39@huawei.com>
Message-ID: <25451c77-b3c0-9880-9c33-f8c022d12537@huawei.com>
Date:   Tue, 18 May 2021 11:08:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210517050141.61488-7-shenyang39@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.207]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema704-chm.china.huawei.com (10.3.20.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello:

I'm sorry for getting wrong maintainer information.

Best Regards,
     Yang

On 2021/5/17 13:01, Yang Shen wrote:
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/net/wireless/intel/iwlwifi/mvm/rfi.c:11: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  drivers/net/wireless/intel/iwlwifi/mvm/rfi.c:14:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>
> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/rfi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
> index 0b818067067c..f1ed73c9f3dd 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
> @@ -7,11 +7,11 @@
>  #include "fw/api/commands.h"
>  #include "fw/api/phy-ctxt.h"
>
> -/**
> +/*
>   * DDR needs frequency in units of 16.666MHz, so provide FW with the
>   * frequency values in the adjusted format.
>   */
> -const static struct iwl_rfi_lut_entry iwl_rfi_table[IWL_RFI_LUT_SIZE] = {
> +static const struct iwl_rfi_lut_entry iwl_rfi_table[IWL_RFI_LUT_SIZE] = {
>  	/* LPDDR4 */
>
>  	/* frequency 3733MHz */
> --
> 2.17.1
>
> .
>
