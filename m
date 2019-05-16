Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814E620E81
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfEPSRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 14:17:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfEPSRL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 14:17:11 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hRKwG-0002vV-Kj; Thu, 16 May 2019 20:17:09 +0200
Date:   Thu, 16 May 2019 20:17:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: SPDX identifier
In-Reply-To: <b04655c7-5a6e-b510-5fcf-30ecca489882@broadcom.com>
Message-ID: <alpine.DEB.2.21.1905162015460.3196@nanos.tec.linutronix.de>
References: <b04655c7-5a6e-b510-5fcf-30ecca489882@broadcom.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend,

On Thu, 16 May 2019, Arend Van Spriel wrote:

> Hi Kalle, Thomas,
> 
> I added SPDX tags in brcm80211 driver sources. Although it is a no-brainer I
> decided to run checkpatch for the changes and quirky stuff started to happen.
> For all files I added:
> 
> // SPDX-License-Identifier
> 
> but checkpatch started complaining I should use /* ... */ instead of //.
> 
> WARNING: Improper SPDX comment style for
> 'drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h', please use
> '/*' instead
> #29: FILE: drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h:1:
> +// SPDX-License-Identifier: ISC
> 
> So I edited all patches and ran again. And again it started complaining.
> 
> WARNING: Improper SPDX comment style for
> 'drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c', please use '//'
> instead
> 
> So now I am in a bonkers state. It seems for header files we want /* */ and
> for c files we want //. For real?

See Documentation. This is historical because the older binutils choked on
'//' comments. Not longer an issue as we moved to more modern binutils by
now. So we can fixup the documentation and allow // style for headers as well.

Thanks,

	tglx
