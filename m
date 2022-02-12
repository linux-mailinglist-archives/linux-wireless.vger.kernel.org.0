Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9174B35EA
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiBLPsQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 10:48:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBLPsP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 10:48:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A4C240AF
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 07:48:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2865560B3A
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 15:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EEEC340E7;
        Sat, 12 Feb 2022 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644680890;
        bh=wdO2zfMgIWAo32D+i8APtdcwmrUAuCjFi5NUKDnaU3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBxwkkW1G/AT9CrUYYkF1PpZt4f/V3iFAS4Om1W5shJKpkxl3AYXgwJW+3DxiN3pP
         9ucl3JB5UdlBFo07K9YROYmqaOanuZcB8HFl7AQW2WaWoa6m2Kn+YAU52c2MBlWjH4
         OTN/R6r30Glbg5Or2HhwYrvlRk0lS9WmBMCACSu6sOe5taz/pPN5jbipQYqZn3uIQ5
         wUs3mxdeimHrM4DaV8JhpWQryZxy0FRai6DghDs/rBt0XPMbVU4fgEfrOYU8ehE7t7
         iNm9kfNIFnU2nKn2EHTeo6oVcxW+BTU0tks1PevydlDflIlog6huTVKjtCQmmMiyD7
         r76R+Rj0u6bzg==
Date:   Sat, 12 Feb 2022 09:48:09 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for China (CN)
Message-ID: <YgfWuV8E+xHZGeqh@ubuntu-x1>
References: <9a460b85-4e1b-40b2-8691-3f999331c76b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a460b85-4e1b-40b2-8691-3f999331c76b@www.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 04, 2022 at 03:19:29PM +0000, Jiaxun Yang wrote:
> China had updated regulations on ISM frequencies by
> "工信部无〔2021〕129号".
> 
> The new regulation effectives from Jan 1 2022.
> 
> Update regdb accroading to it's attachment "2400MHz、5100MHz
> 和 5800MHz 频段无线电发射设备射频技术要求".
> 
> Announcement: https://wap.miit.gov.cn/zwgk/zcwj/wjfb/tz/art/2021/art_e4ae71252eab42928daf0ea620976e4e.html
> Attachment: https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/d125301b13454551b698ff5afa49ca28.pdf
> 
> Those documents are only available in Chinese.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks for the patch. I'm looking at a machine translation of the
document, and based on that I think one change needs to be made, see
below. If something was mistranslated or if I misunderstood, please let
me know.

> ---
>  db.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 6dbda3c..e6fd657 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -346,11 +346,12 @@ country CL: DFS-JP
>  	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
>  	(5735 - 5835 @ 80), (20)
>  
> +# Source:
> +# https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/d125301b13454551b698ff5afa49ca28.pdf
>  country CN: DFS-FCC
> -	(2402 - 2482 @ 40), (20)
> -	(5170 - 5250 @ 80), (23), AUTO-BW
> -	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
> -	(5735 - 5835 @ 80), (30)
> +	(2400 - 2483.5 @ 40), (20)
> +	(5150 - 5350 @ 80), (23), DFS, AUTO-BW

It looks like this range requires TPC, and if TPC is not supported the
max EIRP needs to be lowered by 3 dBm. Since Linux does not support TPC,
we need to reduce this power limit to 20 dBm.

Thanks,
Seth

> +	(5725 - 5850 @ 80), (33)
>  	# 60 GHz band channels 1,4: 28dBm, channels 2,3: 44dBm
>  	# ref: http://www.miit.gov.cn/n11293472/n11505629/n11506593/n11960250/n11960606/n11960700/n12330791.files/n12330790.pdf
>  	(57240 - 59400 @ 2160), (28)
> -- 
> 2.34.1.windows.1
