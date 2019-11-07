Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA451F2F38
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 14:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfKGN1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 08:27:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55172 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728172AbfKGN1a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 08:27:30 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iShou-00010Q-2I; Thu, 07 Nov 2019 15:27:28 +0200
Message-ID: <a83688d756bf51225be51865d96b72452f88aead.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 07 Nov 2019 15:27:27 +0200
In-Reply-To: <20191107115149.10709-3-luca@coelho.fi>
References: <20191107115149.10709-1-luca@coelho.fi>
         <20191107115149.10709-3-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v5.4 3/3] iwlwifi: check kasprintf() return value
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-11-07 at 13:51 +0200, Luca Coelho wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> kasprintf() can fail, we should check the return value.
> 
> Fixes: 5ed540aecc2a ("iwlwifi: use mac80211 throughput trigger")
> Fixes: 8ca151b568b6 ("iwlwifi: add the MVM driver")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

Let's drop this one from v5.4.  This is extremely unlikely to fail and
the real reason for the crash we have observed was fixed in Johannes'
mac80211 patch (2/3 in this series).

--
Luca.

