Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B483F46E8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 10:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhHWIwT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 04:52:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59374 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235573AbhHWIwR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 04:52:17 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mI5fz-002KDV-1a; Mon, 23 Aug 2021 11:51:28 +0300
Message-ID: <5bb55d70a737a070042a1a6687197c1a1b8ecd3d.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Aug 2021 11:51:27 +0300
In-Reply-To: <8735r2ucb1.fsf@codeaurora.org>
References: <20210820110318.260751-1-luca@coelho.fi>
         <iwlwifi.20210820140104.b7e1bf6359b6.Ice4112c1910cf94babd1c2d492a3a3de9f7ee6cb@changeid>
         <8735r2ucb1.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 02/12] iwlwifi: mvm: add support for resonder config
 command version 9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2021-08-21 at 17:01 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Avraham Stern <avraham.stern@intel.com>
> > 
> > This version adds the following configuration options:
> > 1. Enable/disable setting the session id in the FTM frame
> > 2. Set the BSS color for the responder
> > 3. Set the minimum and maximum time between measurements for
> >    non trigger based NDP ranging.
> > 
> > Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> s/resonder/responder/

Thanks, I'll fix it.

--
Luca.

