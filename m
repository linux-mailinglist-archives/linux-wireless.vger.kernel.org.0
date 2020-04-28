Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EEE1BB760
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 09:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgD1HVT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 03:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1HVS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 03:21:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C48C03C1A9;
        Tue, 28 Apr 2020 00:21:18 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so16056847lfc.0;
        Tue, 28 Apr 2020 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MyZF0gR7G2RwwOHtBGhIolt3MxmcatoBV0DNBa4Flvs=;
        b=DpJLVYbNL2U7q9i5Ua1Sc/UtU7NXfJ8et3ifSKceQTyvMDXb6Lo55O/JS/wMl7+gZu
         4ksOJe6lKS2iubcXkSjMQzlW6mk04RQjVnMgPz92aL9OMMMZdhh2H7cySAyDspt3FnIQ
         aYXg4NG4UGp2euVFxsblsYTw0BEXDTdbxMQwRD+h+TxgKDZCZ2vIBiHm9X0fm6tmw3RZ
         J1iRLT+YU5sJuTfLov6Wudbl4TB3CbfycHal846bY4KKvXunlfvPkpQApcWeSoboTmmW
         zuGBHjyGKKT3WgmH+IYK8pa4UJnJF7cd+hTD7gRxolR+lTq/uzrAnJyCt2nZ/NEQksTL
         hKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MyZF0gR7G2RwwOHtBGhIolt3MxmcatoBV0DNBa4Flvs=;
        b=j/rkpi1XcKHyKi75N2YtDKEqnJRF4uTSshTXP7ELDN0IrQhYawHYn0Oxo4L7jk3POs
         GyyVCl3RnAfpa1zUN1HyXOnGsXJ5G91HWxFPNDmiHiTl5gWKESF1JEaxI8U3MY1IiUJ4
         XxP15aOeTYTst4p51YW14Uq/vqaYVK75B9PApJsIU/Fn+eh8JLV3nGAjB8uofv1QEhTy
         PleMI25c5vk+abUx1GQOYrcrhHydDpGOrJRuumUoLjRGQY2k3xxqaMcBWt2eZFob4/wm
         ho9p9KBFJabdZ1lqvRFueNh7eIfr8DtSQA9FLc/pCxJqHYhfbLm8NpHEVIVubXu+wci+
         Wndg==
X-Gm-Message-State: AGi0Pua4nTKjP4oqD2PE8GM3e+k2C6LLCAMmDo7z2LtEJRq3FknV+wUp
        FHsF8OBy69t67K2OU1t1y54X7oP7
X-Google-Smtp-Source: APiQypLL/Dg7X7LovFPFbXbOa31lCQw+VCqT78rpBx9Bbu6kTXWsTs2PsLfQL44m5GPU/O/8HSIN8A==
X-Received: by 2002:ac2:5684:: with SMTP id 4mr17761854lfr.88.1588058476508;
        Tue, 28 Apr 2020 00:21:16 -0700 (PDT)
Received: from curiosity (ip-195-182-157-78.clients.cmk.ru. [195.182.157.78])
        by smtp.gmail.com with ESMTPSA id p13sm11919237ljg.103.2020.04.28.00.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:21:15 -0700 (PDT)
Date:   Tue, 28 Apr 2020 10:25:43 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mac80211-next tree
Message-ID: <20200428072543.GA2630@curiosity>
References: <20200428122930.51b6a9c2@canb.auug.org.au>
 <c3922c972277ff627c0308a94dfe3f25ba3b333f.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3922c972277ff627c0308a94dfe3f25ba3b333f.camel@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 28, 2020 at 09:01:30AM +0200, Johannes Berg wrote:
> On Tue, 2020-04-28 at 12:29 +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the mac80211-next tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > Caused by commit
> > 
> >   6cd536fe62ef ("cfg80211: change internal management frame registration API")
> 
> Yeah. I forgot about staging. I guess I'll throw in a quick fix.
> 
> johannes

Hello Johannes,

Could you please take a look at the following fix for this issue:
https://patchwork.kernel.org/patch/11509497/

Regards,
Sergey
