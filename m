Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B195367A3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352617AbiE0TpD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 15:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344479AbiE0TpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 15:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AEE3BBC3
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 12:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C96061EAF
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 19:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0A1C385B8;
        Fri, 27 May 2022 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653680696;
        bh=lXSksNhhxS6wVSQc8mjtMd3gxscsWFnEp9uTMt+wlfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtEnNqE33DvOmVfBsIaLjt07zRjwlu5i+xg+W/hBltIlsDGp5O0VjgUJPW0/mmEGG
         QkGacIsnTC0X146eiYXXKAbqvGwgAOYYw/bNY+M0SpWDtMV3FGe+IH+cmnBY8xGb8C
         clOu+Y6METgvIdO6/2LKmUuttj5JJjrgjSBL0zJV87d6iAUcY2uMYoSowk17Ajztt1
         +ETJK9NfbPTaZI8t7lMeJ5bEoo71k3aRq6xftIJI9O803+0AXw6FlhyC1Z7EhskxP4
         B9Cajd/DfJjaOLRqzuzAFaQHcmLMpGfUvRbR04nIe6OPkykDS+eHID8b1SCosx17AA
         GeNo52wCAJxHQ==
Date:   Fri, 27 May 2022 14:44:55 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Stijn Tintel <stijn@linux-ipv6.be>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Petko Bordjukov <bordjukov@gmail.com>
Subject: Re: [PATCH] wireless-regdb: update regulatory rules for Bulgaria
 (BG) on 6GHz
Message-ID: <YpEqN6hwBoGIEuhb@ubuntu-x1>
References: <20220525133609.1740457-1-stijn@linux-ipv6.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525133609.1740457-1-stijn@linux-ipv6.be>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 25, 2022 at 04:36:09PM +0300, Stijn Tintel wrote:
> Reviewed-by: Petko Bordjukov <bordjukov@gmail.com>
> Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
> ---
>  db.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/db.txt b/db.txt
> index fcdc74a..0d24e96 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -219,6 +219,10 @@ country BF: DFS-FCC
>  # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
>  # BG: https://crc.bg/files/_en/Electronic_Communications_Revised_EN1.pdf
>  # BG: acceptance of 2006/771/EC https://crc.bg/files/Pravila_06_12_2018.pdf
> +#
> +# Amendment of the rules for free use of radio frequency spectrum
> +# (Изменение и допълнение на Правилата за свободно използване на радиочестотния спектър)
> +# https://dv.parliament.bg/DVWeb/showMaterialDV.jsp?idMat=168250
>  country BG: DFS-ETSI
>  	# Wideband data transmission systems (WDTS) in the 2.4GHz ISM band, ref:
>  	# I.22 of the List, BDS EN 300 328
> @@ -232,6 +236,8 @@ country BG: DFS-ETSI
>  	# short range devices (ETSI EN 300 440-1)
>  	# I.43 of the List, BDS EN 300 440-2, BDS EN 300 440-1
>  	(5725 - 5875 @ 80), (25 mW)
> +	# WiFi 6E
> +	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI

Applied, with a small change from 200 mW to 23 dBm both to use the same
units as the regulations and to keep the rule consistent with other EU
countries. Thanks!

>  	# 60 GHz band channels 1-4 (ETSI EN 302 567)
>  	# II.H03 of the List, BDS EN 302 567-2
>  	(57000 - 66000 @ 2160), (40)
> -- 
> 2.35.1
> 
