Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E902B3D47F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 19:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406079AbfFKRsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 13:48:15 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:47535 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405625AbfFKRsP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 13:48:15 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45Nct32KfCz1rXhY;
        Tue, 11 Jun 2019 19:48:10 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45Nct20nSjz1rxRG;
        Tue, 11 Jun 2019 19:48:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2BFHBsK6aqSo; Tue, 11 Jun 2019 19:48:09 +0200 (CEST)
X-Auth-Info: HG913dC6nI3QeXdDWZOlZYfrTig6dgohUmdEi80BbIbGuJfv0F142LduSvY+GpMv
Received: from igel.home (ppp-46-244-178-52.dynamic.mnet-online.de [46.244.178.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 11 Jun 2019 19:48:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C6AC72C0D1D; Tue, 11 Jun 2019 19:48:06 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
        <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
        <20190607172902.GA8183@lst.de>
        <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net>
        <20190610081825.GA16534@lst.de>
        <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net>
X-Yow:  Hello...  IRON CURTAIN?  Send over a SAUSAGE PIZZA!
 World War III?  No thanks!
Date:   Tue, 11 Jun 2019 19:48:06 +0200
In-Reply-To: <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net> (Larry
        Finger's message of "Mon, 10 Jun 2019 11:09:47 -0500")
Message-ID: <87ftogau95.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Jun 10 2019, Larry Finger <Larry.Finger@lwfinger.net> wrote:

> I do not understand why the if statement returns true as neither of the
> values is zero.

That's because the format string does not make any sense.  You are
printing garbage.

> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index f7afdad..ba2489d 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -317,9 +317,12 @@ int dma_supported(struct device *dev, u64 mask)
>
>  int dma_set_mask(struct device *dev, u64 mask)
>  {
> +       pr_info("mask 0x%llx, dma_mask 0x%llx, dma_supported 0x%llx\n",
> mask, dev->dma_mask,
> +               dma_supported(dev, mask));

None of the format directives match the type of the arguments.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
