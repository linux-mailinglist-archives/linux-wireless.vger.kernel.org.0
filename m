Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB29D1ADB1C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgDQKdy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:33:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56644 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727874AbgDQKdx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:33:53 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPOJj-000Ke3-9J; Fri, 17 Apr 2020 13:33:51 +0300
Message-ID: <444594a5c7f83fb93a89fb2d4cbd4768ff37c700.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:33:50 +0300
In-Reply-To: <20200417073738.2049606-1-luca@coelho.fi>
References: <20200417073738.2049606-1-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v5.7] iwlwifi: fix WGDS check when WRDS is disabled
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-17 at 10:37 +0300, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> In the reference BIOS implementation, WRDS can be disabled without
> disabling WGDS.  And this happens in most cases where WRDS is
> disabled, causing the WGDS without WRDS check and issue an error.
> 
> To avoid this issue, we change the check so that we only considered it
> an error if the WRDS entry doesn't exist.  If the entry (or the
> selected profile is disabled for any other reason), we just silently
> ignore WGDS.
> 
> Cc: stable@vger.kernel.org # 4.14+
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205513
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
> 

[...]

> @@ -741,9 +742,14 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
>  		len = sizeof(cmd.v4.v3);
>  
>  
> -	if (iwl_sar_select_profile(&mvm->fwrt, cmd.v5.v3.per_chain_restriction,
> -				   prof_a, prof_b))
> -		return -ENOENT;
> +	ret = iwl_sar_select_profile(&mvm->fwrt,
> +				     cmd.v5.v3.per_chain_restriction,
> +				     prof_a, prof_b);
> +
> +	/* return on error or if the profile is disabled (positive numeber) */
> +	if (!ret)
> +		return ret;
> +

Oops, this should be "if (ret)" instead, as someone pointed out in an
internal review.  I'll send v2 in a sec.

--
Cheers,
Luca.

