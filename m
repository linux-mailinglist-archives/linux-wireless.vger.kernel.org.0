Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549C5A6629
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiH3OXG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiH3OXF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 10:23:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847CEB5A72
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 07:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27838B81C29
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 14:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E1AC433C1;
        Tue, 30 Aug 2022 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661869379;
        bh=vWuXz1hzDjwlJ8wgUN/2/LK+Hkimf6LxcI2rJlKbtok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUCbE+eGC+bZncIrN2VK+NbMdhVPl9op+1BYfQZaFOnDtBmXnBWCCEzFZc0ke8Ssq
         lI+EBS8rZA4kMnT5GsWqlxAyHBMG4uE8yOPWwewNtv3s+8mcDcQ0zdWINke9Qghl/o
         1I7yapsC+Q+0qYvf7ykExMNXM7Eo3hiMn9yMG9sXLGW+UAjiQxe4XEnKAetZ8X1pLV
         1q+mK7c4CKtwmGzHJeXjlOEuoS3dKXS4xnENz0wreCrBtdoZ46MzzL3Z6ydr18xWOS
         uXCGDCpkyYIHSXm7cC9+srfatlGrzdRFly3Rg4/N4LNTSQcGGdky4i4jQAymTJgvoU
         oEaPagxa+vYjQ==
Date:   Tue, 30 Aug 2022 09:22:58 -0500
From:   Seth Forshe <sforshee@kernel.org>
To:     Bernardo Donadio <bcdonadio@bcdonadio.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Message-ID: <Yw4dQl9/1xx4nx7N@ubuntu-x1>
References: <b68e876e-1555-4a37-762f-3b38d383722d@bcdonadio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b68e876e-1555-4a37-762f-3b38d383722d@bcdonadio.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 25, 2022 at 10:29:58PM -0300, Bernardo Donadio wrote:
> Hello.
> 
> I would like to request the following inclusion to the BR entry in the
> regdb, since Anatel (Brazil's telecomunication regulatory body) has
> officially licensed the WiFi 6E band in February 26, 2021.
> 
> It was defined as the 5.925 to 7.125MHz spectrum range, strictly for indoor
> use, limited to 30dBm EIRP for AP stations and 24dBm for clients.
> Requirement for NO-IR was explicitly waived, and no requirement for AUTO-BW
> or DFS was made. No specific channel width was defined besides the spectral
> power density limitation of 5dBm/MHz, so 160MHz channels are allowed if my
> math is right (I would appreciate if someone could double-check it).
> 
> The original publication regulating bands for local private use can be found
> here: http://www.ncc.org.br/img/Ato%2014448.pdf
> 
> The amendment that allowed the 6E band can be found here: https://www.in.gov.br/web/dou/-/ato-n-1.306-de-26-de-fevereiro-de-2021-306493325
> in section 11.7.
> 
> Allowing outdoor use is being debated, but it hasn't been licensed yet since
> 5G operators want to use the same slice of spectrum. There could be further
> changes in the next year.

Thanks for the information! This is already being discussed as part of a
larger set of updates for BR. See this thread:

http://lists.infradead.org/pipermail/wireless-regdb/2022-August/001372.html

Please let us know if you have any comments on the proposed updates
being discussed there.

Thanks,
Seth
