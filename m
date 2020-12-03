Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE402CD453
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 12:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbgLCLKq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 06:10:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34170 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387582AbgLCLKq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 06:10:46 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kkmUp-0038Jd-BM; Thu, 03 Dec 2020 13:09:59 +0200
Message-ID: <669fa3662d8a882545810884ba7c4318341078d8.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 03 Dec 2020 13:09:57 +0200
In-Reply-To: <iwlwifi.20201129151117.9c66af9f5dda.I86867c273bb3d00e31e13857d4a013f5503c17ea@changeid>
References: <20201129131442.1857561-1-luca@coelho.fi>
         <iwlwifi.20201129151117.9c66af9f5dda.I86867c273bb3d00e31e13857d4a013f5503c17ea@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 12/12] iwlwifi: mvm: set station HE capabilities before
 authentication
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-11-29 at 15:14 +0200, Luca Coelho wrote:
> From: Avraham Stern <avraham.stern@intel.com>
> 
> Some 11ax APs send the authentication response frame as a HE frame.
> Since the MAC_FILTER_IN_11AX flag is only set on association, the
> frame is being filtered out and the association fails.
> Fix it by setting the station HE capabilities before authentication.
> This will result in setting the MAC_FILTER_IN_11AX flag for HE
> stations before authentication and filtering in the authentication
> response.
> 
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

I'm going to drop this one, since this implementation already went it
in another patch for fixes.  I apologize for the noise.

--
Cheers,
Luca.

