Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F587897DF
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Aug 2023 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjHZPxb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Aug 2023 11:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHZPxS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Aug 2023 11:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D121BCC;
        Sat, 26 Aug 2023 08:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3F360A1D;
        Sat, 26 Aug 2023 15:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8408FC433C7;
        Sat, 26 Aug 2023 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693065195;
        bh=jRp5J5zfBMQENdgSowokFSlTIvvrIvYSssKqh8Hw7C0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWeC7YdLlOfWmW9hf4SWWtktwWX8R7IW/D5JH/PvI7Yd51paYleLvUIvzA2QCIUbW
         06Z5bcXAFTj3y8Ur04h4ew+JcDSB7hrkVZv8RT+vlWPiaxEKGyUPghLlCjahtQRD6K
         SHEDpNidSXNPPR8vP2zIkX2CIj+esuy/SMsoXlLyZ3ofuteWHh3Re10WJmOQd3e4Ym
         LXAalMWJFXf4OM95urH+pJDtYhugleVYvBu+LI4WHLutS0koLb7uPJlImSMrs1Nqib
         nU9yLCDLkX5nD+Sp0ARk/tRvwuF8jQ2Wk7vE4HlcdGFVxUpQRozb/mH9lkmAjEeLt0
         oVXq9iHyNQG1A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qZvbA-0000QB-0P;
        Sat, 26 Aug 2023 17:53:16 +0200
Date:   Sat, 26 Aug 2023 17:53:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Revert "wifi: ath11k: Enable threaded NAPI""
Message-ID: <ZOof7EE0tXAt0YN7@hovoldconsulting.com>
References: <20230809073432.4193-1-johan+linaro@kernel.org>
 <ZONpkVU1ORHj-zFH@hovoldconsulting.com>
 <87o7izi6br.fsf@kernel.org>
 <ZOS7zdWNaqmfCHet@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOS7zdWNaqmfCHet@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 22, 2023 at 03:44:45PM +0200, Johan Hovold wrote:
> On Tue, Aug 22, 2023 at 03:56:24PM +0300, Kalle Valo wrote:
> > Johan Hovold <johan@kernel.org> writes:
> > > On Wed, Aug 09, 2023 at 09:34:32AM +0200, Johan Hovold wrote:
> > >
> > >> Disabling threaded NAPI caused a severe regression in 6.5-rc5 by making
> > >> the X13s completely unusable (e.g. no keyboard input, I've seen an RCU
> > >> splat once).
> 
> > > Any chance we can get the offending commit reverted before 6.5 is
> > > released? 
> > 
> > The problem here is that would break QCN9074 again so there is no good
> > solution. I suspect we have a fundamental issue in ath11k which we just
> > haven't discovered yet. I would prefer to get to the bottom of this
> > before reverting anything.
> 
> Sure, ideally we can find and fix the underlying issues these next few
> days, but since this regression was introduced in rc5 in an attempt to
> address the QCN9074 issue which has been there since 6.1 I think we
> need to revert otherwise. 

I've managed to track down what causes the hang on the X13s after
disabling threaded NAPI. Turns out to be a severe regression in the
genirq code that causes the software resend tasklet to loop
indefinitely.

I've just sent a fix here:

	https://lore.kernel.org/lkml/20230826154004.1417-1-johan+linaro@kernel.org/

I've also made some progress on the QCN9074 hang, but keeping the
threaded NAPI revert for now is indeed the right thing to do.

Johan
