Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5128074B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 20:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgJAS5e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 14:57:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53646 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729047AbgJAS5e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 14:57:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kO3lj-002NCD-Tg; Thu, 01 Oct 2020 21:57:32 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20200926002540.a451fdd0a0ab.Idd8f59a49816d8484fe7dea3f1cec7a36cbf86f7@changeid>
References: <iwlwifi.20200926002540.a451fdd0a0ab.Idd8f59a49816d8484fe7dea3f1cec7a36cbf86f7@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.8.6
Message-Id: <E1kO3lj-002NCD-Tg@farmhouse.coelho.fi>
Date:   Thu, 01 Oct 2020 21:57:31 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/15] iwlwifi: dbg: remove
 IWL_FW_INI_TIME_POINT_WDG_TIMEOUT
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> This timepoint was removed from the FW, so we remove it from here too
> for consistency.  It's now marked as reserved to preserve the
> enumeration.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

4 patches applied to iwlwifi-next.git, thanks.

4c447cfadd6c iwlwifi: dbg: remove IWL_FW_INI_TIME_POINT_WDG_TIMEOUT
ba8f6f4ae254 iwlwifi: dbg: add dumping special device memory
e27c506a985c iwlwifi: regulatory: regulatory capabilities api change
22852fad9c17 iwl-trans: move dev_cmd_offs, page_offs to a common trans header

