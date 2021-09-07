Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570B1402849
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbhIGMNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:13:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56108 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229604AbhIGMNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:13:47 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mNZxu-0007a1-Oq; Tue, 07 Sep 2021 15:12:39 +0300
Message-ID: <b644e58618825e69788117e53fcf17dc4a81bda5.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, dan.carpenter@oracle.com
Date:   Tue, 07 Sep 2021 15:12:37 +0300
In-Reply-To: <iwlwifi.20210907143156.e80e52167d93.Ie2247f43f8acb2cee6dff5b07a3947c79a772835@changeid>
References: <iwlwifi.20210907143156.e80e52167d93.Ie2247f43f8acb2cee6dff5b07a3947c79a772835@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] iwlwifi: mvm: Fix possible NULL dereference
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-09-07 at 14:32 +0300, Luca Coelho wrote:
> From: Ilan Peer <ilan.peer@intel.com>
> 
> In __iwl_mvm_remove_time_event() check that 'te_data->vif' is NULL
> before dereferencing it.
> 
> Fixes: 7b3954a1d69a ("iwlwifi: mvm: Explicitly stop session protection before unbinding")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

Kalle, I assigned this to you.  Can you please take it directly to
wireless-drivers for v5.15?

Thanks!

--
Cheers,
Luca.

