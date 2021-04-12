Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D9435C3B9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 12:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbhDLKXB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 06:23:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44588 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238845AbhDLKWy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 06:22:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVtiD-000Kw4-2V; Mon, 12 Apr 2021 13:22:34 +0300
Message-ID: <f190363d8432f2b0bfbba38a32fe3b455c34c7f6.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 12 Apr 2021 13:22:32 +0300
In-Reply-To: <iwlwifi.20210331121101.5b807533b0c0.I07b58a5c9238f75413a91198452ba1268ee79425@changeid>
References: <20210331091452.543321-1-luca@coelho.fi>
         <iwlwifi.20210331121101.5b807533b0c0.I07b58a5c9238f75413a91198452ba1268ee79425@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 05/12] iwlwifi: pcie: try to grab NIC access early
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-03-31 at 12:14 +0300, Luca Coelho wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Sometimes some NICs may fail to initialize, but if we have
> such a scenario we may only see an alive timeout (i.e. the
> firmware doesn't send us the alive message), and that will
> only cause us to fail the interface up.
> 
> Try to once grab NIC access during device probe to ensure
> we can properly talk to the hardware at all, and to do all
> the potential workarounds in that function.
> 
> Since we now finish NIC init here, we can remove it from
> the later potential read of the RF ID.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

This patch is included in Emmanuel's iwlmei series, so I'll drop it
from this series.

--
Cheers,
Luca.

