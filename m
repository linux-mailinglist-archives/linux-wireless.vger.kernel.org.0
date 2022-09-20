Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC15BF188
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 01:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiITXv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 19:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiITXvZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 19:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795C3A153
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 16:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3BAF61AC3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 23:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11074C433D6;
        Tue, 20 Sep 2022 23:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663717884;
        bh=m7UKfFboQmNSIazcCyenHKoV2LMBka36TPbLGXyaABM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BweDgZwbwoF2ds/2mbl+1UI7AZu0dZqmQARyExH/rRbp2oia+WNxDHRApRyWEET6y
         pDknRWJJ9S5N62XXnBdo1d10bCUW4nc6i8BLbZJ86FS1GJU4hnb2SS+iEtqufClPE/
         VQoOk52vsM3zkLoR9CNiocjzQCc8B3E9VmJTGOtCFCCDKg+o//KW7SphdGzW42JuUw
         ZKLFuCY7EMmxwrPUMEL9/JLXMZuUejCpw7aIsiZH32+WInwuDTTYJV14ZV2hRoZdv5
         Vn8yXGDXYfZoBYKmivBR51mh/GQxIvSsUTeipad2ia24PMyxdx36cMk8U6ddacWcHi
         AWJUxjOU7Vh/g==
Date:   Tue, 20 Sep 2022 18:51:23 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        johannes@sipsolutions.net
Subject: Re: [wireless-regdb] [PATCH v2] wireless-regdb: Update regulatory
 rules for Brazil (BR)
Message-ID: <YypR+61mc7AAmyxq@ubuntu-x1>
References: <20220909223947.27277-1-cesarb@cesarb.eti.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909223947.27277-1-cesarb@cesarb.eti.br>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 09, 2022 at 07:39:47PM -0300, Cesar Eduardo Barros wrote:
> The rules for Brazil in wireless-regdb have no comment indicating where
> they came from, and haven't been updated in a long time. There have been
> some changes to the legislation since then, including the addition of
> the 6 GHz and 60 GHz ranges.
> 
> Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.eti.br>

Applied, thanks!
