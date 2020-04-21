Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263FD1B23B7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgDUK2f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 06:28:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57234 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgDUK2f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 06:28:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jQq8m-000MiO-HT; Tue, 21 Apr 2020 13:28:33 +0300
Message-ID: <f11a5f23e0bf6483bff8870466283c4c68ed53f1.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 21 Apr 2020 13:28:30 +0300
In-Reply-To: <87imhtqjrb.fsf@codeaurora.org>
References: <20200417102142.2173014-1-luca@coelho.fi>
         <iwlwifi.20200417131727.9c61e7e42b26.I5ede9cc25ee8de7b8d2b5c574f917a18971da734@changeid>
         <87imhtqjrb.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 02/10] iwlwifi: move API version lookup to common code
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-04-21 at 12:18 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> > 
> > The API version lookup is parsed from a TLV and should be in shared code
> > make make it reusable across all opmodes.
> > 
> > Also change the function names from mvm to fw, since this is not
> > mvm-specific anymore.
> > 
> > Additionally, since this function is not just a single line of code, it
> > shouldn't be inline.  Convert them to actual functions.
> > 
> > Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> [...]
> 
> > +++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/******************************************************************************
> > + *
> > + * This file is provided under a dual BSD/GPLv2 license.  When using or
> > + * redistributing this file, you may do so under either license.
> > + *
> > + * GPL LICENSE SUMMARY
> > + *
> > + * Copyright(c) 2019 Intel Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of version 2 of the GNU General Public License as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * The full GNU General Public License is included in this distribution
> > + * in the file called COPYING.
> > + *
> > + * Contact Information:
> > + *  Intel Linux Wireless <linuxwifi@intel.com>
> > + * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
> > + *
> > + * BSD LICENSE
> > + *
> > + * Copyright(c) 2019 Intel Corporation
> > + * All rights reserved.
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions
> > + * are met:
> > + *
> > + *  * Redistributions of source code must retain the above copyright
> > + *    notice, this list of conditions and the following disclaimer.
> > + *  * Redistributions in binary form must reproduce the above copyright
> > + *    notice, this list of conditions and the following disclaimer in
> > + *    the documentation and/or other materials provided with the
> > + *    distribution.
> > + *  * Neither the name Intel Corporation nor the names of its
> > + *    contributors may be used to endorse or promote products derived
> > + *    from this software without specific prior written permission.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> > + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> > + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> > + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> > + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> > + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> > + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> > + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> > + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + *****************************************************************************/
> 
> This doesn't look correct. You shouldn't have the actual license text if
> you have SPDX tags. Also SPDX claims this is "GPL" but the license text
> itself says "GPL or BSD" and they contradict each other.

Oops, you're right.  We weren't using the SPDX tags yet at this point
and I missed the fact that it was added (wrongly) there.  I'll remove
it from this patch for now.  We will start using the SPDX tags
everywhere soon.

--
Luca.

