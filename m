Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E21B6504
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfIRNuj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 09:50:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43446 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726618AbfIRNuj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 09:50:39 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iAaLs-0008Sw-Pv; Wed, 18 Sep 2019 16:50:37 +0300
Message-ID: <7b7a8949caae37c0b0dcbc18823dbaf360d482ec.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Mao Wenan <maowenan@huawei.com>
Date:   Wed, 18 Sep 2019 16:50:35 +0300
In-Reply-To: <20190918134903.10103-1-luca@coelho.fi>
References: <20190918134903.10103-1-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v5.4] iwlwifi: mvm: fix build w/o CONFIG_THERMAL
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-18 at 16:49 +0300, Luca Coelho wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Without CONFIG_THERMAL, the driver fails to link as it calls
> iwl_mvm_send_temp_report_ths_cmd() unconditionally. Fix this
> by making that function available, but do almost nothing but
> send the empty firmware command to enable CT-kill reporting.
> 
> While at it, also fix that function itself to not error out
> when the thermal zone hasn't been initialized, but instead
> just send the empty firmware command in this case as well.
> 
> Fixes: 242d9c8b9a93 ("iwlwifi: mvm: use FW thermal monitoring regardless of CONFIG_THERMAL")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

Kalle, please take this patch to fix the THERMAL thing instead.  I'll
assign it to you in patchwork (and mark the other one as superseded).

Thanks!

--
Cheers,
Luca.

