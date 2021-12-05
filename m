Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A6468AA9
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Dec 2021 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhLEL7U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Dec 2021 06:59:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50930 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhLEL7T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Dec 2021 06:59:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3DD4B80E1B
        for <linux-wireless@vger.kernel.org>; Sun,  5 Dec 2021 11:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F659C341C5;
        Sun,  5 Dec 2021 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638705350;
        bh=0STyjYmxvY7/1S64unB/r/tpzztEvqBC31sjLegZrWc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=B+/dS0qgCQuXQ0CzSiIhuF9kxpVVJOp78JBB8qCVgP5r/5RSNtrp4YZD9ThPSEXcq
         vuAHq05ZeCm9yBZRHOoxb74ynMbJYYWP+6qNXw8Mt6PmOZiOophsxqd7cS3catCJJN
         wlFA8KRf0gSmKqPFULNBuNQShoJsXJcuoCy/8mC7dyk4nOMRYMHcAD/ditSRJCh3j+
         WFHneQ44FWVUBifFIyzbYgTDSE5fnVIHJUP2ShA6x6GW1mKI92LbhXp+U+8EjR0irc
         j4i3E/g6+00N65VIhTt+hADdq2twgEmW41t4NJJ7LLX8i9XaXVq7A/dxIsUOPwhghZ
         Uk9G/OBIAKt7A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: iwlwifi: mei: fix linking when tracing is not enabled
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211201113411.130409-1-emmanuel.grumbach@intel.com>
References: <20211201113411.130409-1-emmanuel.grumbach@intel.com>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        luca@coelho.fi, Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163870534660.7494.4418786998373022628.kvalo@kernel.org>
Date:   Sun,  5 Dec 2021 11:55:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> wrote:

> I forgot to add stubs in case tracing is disabled which caused linking errors:
> 
> ERROR: modpost: "__SCT__tp_func_iwlmei_sap_data" [drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
> ERROR: modpost: "__SCT__tp_func_iwlmei_me_msg" [drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
> ERROR: modpost: "__tracepoint_iwlmei_sap_cmd" [drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
> ERROR: modpost: "__tracepoint_iwlmei_me_msg" [drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
> ERROR: modpost: "__SCK__tp_func_iwlmei_me_msg" [drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
> ERROR: modpost: "__SCK__tp_func_iwlmei_sap_data" [drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
> ERROR: modpost: "__tracepoint_iwlmei_sap_data" [drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
> ERROR: modpost: "__SCT__tp_func_iwlmei_sap_cmd" [drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
> ERROR: modpost: "__SCK__tp_func_iwlmei_sap_cmd" [drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
> 
> Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Acked-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers-next.git, thanks.

fe6db7eda930 iwlwifi: mei: fix linking when tracing is not enabled

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211201113411.130409-1-emmanuel.grumbach@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

