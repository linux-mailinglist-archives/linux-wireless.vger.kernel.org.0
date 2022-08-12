Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3E591326
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiHLPgp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbiHLPgm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 11:36:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D3E6E2F1
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 08:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 11845CE2495
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 15:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E686C433D7;
        Fri, 12 Aug 2022 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660318597;
        bh=HnupT5kL8Fgu2rStLPqKQ8Iy5JQSpNixVqBC54hqVTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUq3MsxlzqBxr9zttPSWIthiYZpLCMgMGaWYvIW3sBw0p9qZtpPjVsvbW1GP9+91e
         fGHpl7NPz2kCzXyXs2oQC7JmME7bp8WQ04WVgBRUNByQ4bXDKVxu2nerZHRGBKuF2q
         u/UTXDr6vv/Ytu0izPNPC+FMvwmJvlF6h1oWpf5v4dqHO4TtfRqrBKFlbyYJ/Jd2lv
         HM3wfDf7SteNYT+R7uBMC0oAR0bojpSir7qvimkEOjyWbRNhEUdn/w52hPrmdHuMC8
         rAKPZHlLxhLOTJaNjnA+EO4ejLzqrYN/FvAN5LxMH1twcUaikOQeotmBwE7e60rWKB
         N3OhLijhD3N4g==
Date:   Fri, 12 Aug 2022 10:36:36 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: add 5 GHz rules for GY
Message-ID: <YvZzhIK/cLhzyUlS@ubuntu-x1>
References: <20220805141709.106684-1-sforshee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805141709.106684-1-sforshee@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 05, 2022 at 09:17:09AM -0500, Seth Forshee wrote:
> Add 5 GHz rules which were provided by a representative of the Guyana
> Telecommunications Agency. There is no published document which can be
> used as a reference for these rules.
> 
> Signed-off-by: Seth Forshee <sforshee@kernel.org>

Applied.

> ---
>  db.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/db.txt b/db.txt
> index 16b38b7cb2b2..16abf2951e77 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -732,6 +732,9 @@ country GU: DFS-FCC
>  
>  country GY:
>  	(2402 - 2482 @ 40), (30)
> +	(5170 - 5250 @ 80), (23), AUTO-BW
> +	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
> +	(5490 - 5730 @ 160), (23), DFS
>  	(5735 - 5835 @ 80), (30)
>  
>  country HK: DFS-ETSI
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
