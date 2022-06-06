Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31453EC42
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbiFFOZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 10:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbiFFOZd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 10:25:33 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179942D9350
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 07:25:27 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id s8so14616146oib.6
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jun 2022 07:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KwwB4ln/N/Bn7+r9hLAHjw2DPwRWEtn/I1E8xiYuW8w=;
        b=fQWuMA5gZrd73XWWCiymGrVI7HMY17jcLkP39CobRpLu+55GxJNtkDdUqlLU3HIHLC
         Xd9j7KcqcLUzcV0z0Vzl5zTWiQ/DO2TA7Ky6Jmor4g02bQLiMHZeiI3MzBrHvzk0SW8M
         sEuUL9TIzTZ2bXwwS9Uv3MMi2D0hIn/F4B95VdVZTKhS/3MusFkNZV6/8EsiOE3xYL5C
         Ojap+fFX8Ia7SEDJ1lx8HQoJoe7VNnhQ9v9Y+e+X45NfwHDgUB2WrDlOfPAwewBSiPuY
         ZlJJFuG9WzpziXNInqXbzbWITTKbcazhrzEhLZy0ttlGgqVMVSqdFaEdPpMvdrG21ZW6
         u19w==
X-Gm-Message-State: AOAM53285xKx3NMQoAVtdngJereGVuP+gtq2daWvSIeg13eW2PMwPNQH
        /KtNNhEWml+eMcjaXrdaC165LTW/w0E=
X-Google-Smtp-Source: ABdhPJyF7c5xCF1bpmI+O0Y5P6PnONXBY/i8sVFSpaNnCraMbb6jLHMOY9FGP6Jhxi3BjaOxjzoXjw==
X-Received: by 2002:a05:6808:13d0:b0:32b:d458:4979 with SMTP id d16-20020a05680813d000b0032bd4584979mr27611719oiw.72.1654525526345;
        Mon, 06 Jun 2022 07:25:26 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:e98c:2dab:81ec:c18c])
        by smtp.gmail.com with ESMTPSA id w2-20020a9d5a82000000b0060603221240sm7918517oth.16.2022.06.06.07.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:25:25 -0700 (PDT)
Date:   Mon, 6 Jun 2022 09:25:24 -0500
From:   Seth Forshee <seth@forshee.me>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Dennis Bland <dennis@dbperformance.com>
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Remove AUTO-BW from 6
 GHz rules
Message-ID: <Yp4OVOe7oEgSoTBT@ubuntu-x1>
References: <20220527193149.127735-1-sforshee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527193149.127735-1-sforshee@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 27, 2022 at 02:31:49PM -0500, Seth Forshee wrote:
> No other bands are directly adjacent to this one, so AUTO-BW doesn't
> make sense. Remove it, and also fix a nearby whitespace mistake found
> while doing this update.
> 
> Cc: Dennis Bland <dennis@dbperformance.com>
> Signed-off-by: Seth Forshee <sforshee@kernel.org>

Applied.

> ---
>  db.txt | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index cf35883d1867..47850c051c9a 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -470,7 +470,7 @@ country DE: DFS-ETSI
>  	# short range devices (ETSI EN 300 440-1)
>  	(5725 - 5875 @ 80), (25 mW)
>  	# WiFi 6E
> -	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> +	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
>  	# 60 GHz band channels 1-4 (ETSI EN 302 567)
>  	(57000 - 66000 @ 2160), (40)
>  
> @@ -558,7 +558,7 @@ country ES: DFS-ETSI
>  	# short range devices (ETSI EN 300 440-1)
>  	(5725 - 5875 @ 80), (25 mW)
>  	# WiFi 6E
> -	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> +	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
>  	# 60 GHz band channels 1-4 (ETSI EN 302 567)
>  	(57000 - 66000 @ 2160), (40)
>  
> @@ -582,8 +582,8 @@ country FI: DFS-ETSI
>  	# short range devices (ETSI EN 300 440-1)
>  	(5725 - 5875 @ 80), (25 mW)
>  	# 6 GHz band
> -	(5945 - 6425 @ 160), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> -        # 60 GHz band channels 1-4 (ETSI EN 302 567)
> +	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
> +	# 60 GHz band channels 1-4 (ETSI EN 302 567)
>  	(57000 - 66000 @ 2160), (40)
>  
>  country FM: DFS-FCC
> @@ -607,7 +607,7 @@ country FR: DFS-ETSI
>  	# short range devices (ETSI EN 300 440-1)
>  	(5725 - 5875 @ 80), (25 mW)
>  	# WiFi 6E low power indoor
> -	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> +	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
>  	# 60 GHz band channels 1-6 (ETSI EN 302 567 v2.2.1)
>  	(57000 - 71000 @ 2160), (40)
>  
> @@ -732,7 +732,7 @@ country HR: DFS-ETSI
>  	# short range devices (ETSI EN 300 440-1)
>  	(5725 - 5875 @ 80), (25 mW)
>  	# WiFi 6E
> -	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> +	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
>  	# 60 GHz band channels 1-4 (ETSI EN 302 567)
>  	(57000 - 66000 @ 2160), (40)
>  
> @@ -1222,7 +1222,7 @@ country NL: DFS-ETSI
>  	# short range devices (ETSI EN 300 440-1)
>  	(5725 - 5875 @ 80), (25 mW)
>  	# WiFi 6E
> -	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> +	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
>  	# 60 GHz band channels 1-4 (ETSI EN 302 567)
>  	(57000 - 66000 @ 2160), (40)
>  
> @@ -1242,7 +1242,7 @@ country NO: DFS-ETSI
>  	# short range devices (ETSI EN 300 440-1)
>  	(5725 - 5875 @ 80), (25 mW)
>  	# WiFi 6E
> -	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> +	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
>  	# 60 GHz band channels 1-4 (ETSI EN 302 567)
>  	(57000 - 71000 @ 2160), (40)
>  
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
