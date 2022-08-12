Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54887591328
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiHLPhC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238345AbiHLPg7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 11:36:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3037494120
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 08:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B0BCB82447
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 15:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F64FC433C1;
        Fri, 12 Aug 2022 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660318612;
        bh=gY1P8nxIlbQB9jeZnDM+nQ2iHpLt3YEQ7SuFPK2EXrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgjvG1fSzxk+GodgEUW/OKSWNM7M+ZkOPPyk2MGIkmjhSC6pjkEMSqOm0orMeZc32
         TwcfK33AsDnMWAvOowsuENNJM3PC885u6K1PMkluHW++zli8+1X+g2cp2vkipxvKP6
         uMHjuvQNw1jnWwlK2ePs1nBCGDuxb96sjF3fA0y/9Hp7/bSWCSwhYwpvMrDlXqdQTs
         BeJ3EYhNnL9yaJv6OKtPrgok6MP6QYa5u6l4qOUHjnqDJUtmPXVOW+goQkcuTWTtZR
         v9C/braiy+6rG2Dez1ddoznFwNfARvknxf8QlUVepanM2o2/tCDsxCV7M4P3hZbPlO
         GkGYutMgAhAXg==
Date:   Fri, 12 Aug 2022 10:36:51 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Murtaza Saeed <mnk.saeed@gmail.com>
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: update 5 GHz rules for
 PK and add 60 GHz rule
Message-ID: <YvZzk7r5/PlZ5v23@ubuntu-x1>
References: <20220805170207.121080-1-sforshee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805170207.121080-1-sforshee@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 05, 2022 at 12:02:07PM -0500, Seth Forshee wrote:
> [1] contains updated information for 5 GHz in PK as well as information
> for 60 GHz use. Update the rules to match.
> 
> [1] https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-2022.pdf
> 
> Cc: Murtaza Saeed <mnk.saeed@gmail.com>
> Signed-off-by: Seth Forshee <sforshee@kernel.org>

Applied.

> ---
>  db.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 16abf2951e77..07cdf4a29e49 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1362,8 +1362,14 @@ country PH: DFS-FCC
>  country PK: DFS-JP
>  	# https://fab.gov.pk/type-approval/
>  	# https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocations.pdf
> -	(2402 - 2482 @ 40), (20)
> -	(5725 - 5875 @ 80), (30)
> +	# https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-2022.pdf
> +	(2402 - 2482 @ 40), (100 mW)
> +	(5150 - 5270 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> +	(5270 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
> +	(5470 - 5610 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
> +	(5610 - 5725 @ 80), (200 mW), AUTO-BW
> +	(5725 - 5875 @ 80), (1000 mW)
> +	(57000 - 66000 @ 2160), (40)
>  
>  # PL as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
>  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
