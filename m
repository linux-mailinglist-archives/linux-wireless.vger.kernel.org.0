Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254FE1F12A6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 08:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgFHGC0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 02:02:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:33219 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgFHGC0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 02:02:26 -0400
IronPort-SDR: Faqvk+x89ZZ3QUU8Zhf/vN0yjqQjv0sA8epBajzNEsVYGQTqjGlHVfnbG4GVUSFpizJvI/67vv
 xDdzO6T4T50Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 23:02:25 -0700
IronPort-SDR: V2sRU4L1ikXFDRporevFoZ/KT67fvcWfsrEb20Ao9MMb5RuNG3uQAhZOK0exY6mRZ+X9QMVABz
 qrG7kpznB6Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="259335932"
Received: from lethachh-mobl.ccr.corp.intel.com ([10.249.254.235])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2020 23:02:24 -0700
Message-ID: <a5e582be0727fb97dd8c0a4af2e0e0465d391709.camel@intel.com>
Subject: Re: [PATCH] iwlwifi: mvm: fix interface bringup on non-ACPI configs
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Wang Xuerui <git@xen0n.name>, linux-wireless@vger.kernel.org
Cc:     Gil Adam <gil.adam@intel.com>
Date:   Mon, 08 Jun 2020 09:02:23 +0300
In-Reply-To: <20191121074832.6978-1-git@xen0n.name>
References: <20191121074832.6978-1-git@xen0n.name>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-11-21 at 15:48 +0800, Wang Xuerui wrote:
> Previously the non-ACPI stub of iwl_mvm_ppag_init unconditionally
> returned -ENOENT, that in turn blocked flow of iwl_mvm_up.
> 
> Take the precedent of iwl_mvm_sar_geo_init, make iwl_mvm_ppag_init no-op
> on non-ACPI configs.
> 
> Fixes: 6ce1e5c0c207 ("iwlwifi: support per-platform antenna gain")
> Cc: Gil Adam <gil.adam@intel.com>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Signed-off-by: Wang Xuerui <git@xen0n.name>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> index d9eb2b286438..04ac47b7cae9 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -1169,7 +1169,7 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
>  
>  static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
>  {
> -	return -ENOENT;
> +	return 0;
>  }
>  #endif /* CONFIG_ACPI */

This was already fixed in another patch.  Thanks anyway!

--
Cheers,
Luca.

