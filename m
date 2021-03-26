Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2555534A5E9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 11:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCZK4P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 06:56:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43358 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229882AbhCZKzq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 06:55:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lPk7z-0003GI-CH; Fri, 26 Mar 2021 12:55:44 +0200
Message-ID: <ef176384b168e31159293ed1f6a7197bc43fc2f7.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Mar 2021 12:55:43 +0200
In-Reply-To: <20210326103035.206088-1-luca@coelho.fi>
References: <20210326103035.206088-1-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH for v5.12 0/7] iwlwifi: fixes intended for v5.12
 2021-03-26
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-03-26 at 12:30 +0200, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Hi,
> 
> This is the first patchset with fixes for v5.12.
> 
> The changes are:
> 
> * A few locking fixes;
> * Fix a workaround for devices of the 22000 family;
> * Fix the position of a bit in the regulatory capabilities;
> * Add support to some devices that were missing.
> 
> As usual, I'm pushing this to a pending branch, for kbuild bot.  And
> since these are fixes for the rc series, please take them directly to
> wireless-drivers.git, as we agreed.  I'll assign them to you.
> 
> Cheers,
> Luca.

Oops, I misinstalled my hooks and ended up sending all the patches with
Change-Id tags.  Sorry for that and thanks Johannes for noticing.

I'll mark this series as superseded and send v2.

--
Cheers,
Luca.

