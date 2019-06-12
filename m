Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8B41CFB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfFLG42 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 02:56:28 -0400
Received: from verein.lst.de ([213.95.11.211]:57293 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfFLG42 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 02:56:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8993E68AFE; Wed, 12 Jun 2019 08:55:58 +0200 (CEST)
Date:   Wed, 12 Jun 2019 08:55:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190612065558.GA19585@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi> <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net> <20190607172902.GA8183@lst.de> <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net> <20190610081825.GA16534@lst.de> <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net> <20190611060521.GA19512@lst.de> <5aaa600b-5b59-1f68-454f-20403c318f1a@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aaa600b-5b59-1f68-454f-20403c318f1a@lwfinger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 11, 2019 at 05:20:12PM -0500, Larry Finger wrote:
> Your first patch did not work as the configuration does not have 
> CONFIG_ZONE_DMA. As a result, the initial value of min_mask always starts 
> at 32 bits and is taken down to 31 with the maximum pfn minimization. When 
> I forced the initial value of min_mask to 30 bits, the device worked.

Ooops, yes.  But I think we could just enable ZONE_DMA on 32-bit
powerpc.  Crude enablement hack below:

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8c1c636308c8..1dd71a98b70c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -372,7 +372,7 @@ config PPC_ADV_DEBUG_DAC_RANGE
 
 config ZONE_DMA
 	bool
-	default y if PPC_BOOK3E_64
+	default y
 
 config PGTABLE_LEVELS
 	int
