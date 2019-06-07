Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B052039331
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfFGR3a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 13:29:30 -0400
Received: from verein.lst.de ([213.95.11.211]:57638 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbfFGR3a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 13:29:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2E5C868AFE; Fri,  7 Jun 2019 19:29:03 +0200 (CEST)
Date:   Fri, 7 Jun 2019 19:29:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190607172902.GA8183@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi> <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I don't think we should work around this in the driver, we need to fix
it in the core.  I'm curious why my previous patch didn't work.  Can
you throw in a few printks what failed?  I.e. did dma_direct_supported
return false?  Did the actual allocation fail?
