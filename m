Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D207153EDB8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 20:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiFFSRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 14:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiFFSR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 14:17:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB8764E
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 11:17:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a10so13457077pju.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jun 2022 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ve/NV1ckOlu2jPqjev5JshBgV1GTZxbSmQd/TWGleLQ=;
        b=WMYEtAIOZW1wS7jf4LMoDvMjFovF37vQzikwEpcVN01bkor5aiI/VOt96W7anZq0Lu
         AdX42cVBpeyrAC8xcQNL58huf8odAOclcg6/YIgG+tVUrjdCptdLutts59OnQ70goWDX
         im97fVc/JwjAJHtcaWzI6k7PMlMkaGTJZtuOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ve/NV1ckOlu2jPqjev5JshBgV1GTZxbSmQd/TWGleLQ=;
        b=LIrRWFaOEpo06/8GipSP2k/vymV5TPp3J3aFMyr+70YpQ2e37uV03DVLs3c0aQ5g34
         D1rL+3rdYXTSzIfnTvbyBpFwqatdSmzk79YdvmB8D8h2kn/WQlg4WbmAXGHxhJikGJpO
         mdYyyfeIStF0TvoG5/rygvt6G8b7FS3HzyrL4tkwRF4sj+5uy2By2+eJ7KHQUVOnX3tI
         ZwTjBlykYo9IO4jPadYcqwwLz+0b5R/JXDCAiT+xYEkz9TyQBPI3s3epl2co0ClG+La3
         nQ/Bw2vhyn/j6BYWAv/mqGL9w4xx7H007shH2/FDNlI60Ci+s/PHO+Gr+THe7jiyqJNo
         5/9g==
X-Gm-Message-State: AOAM532ta/ifb80OlF3nIL3slUSxKS9XLUQGk8a1NccagHkdG/gljNqM
        Jwshsm7WnZT7D2ckPwMZH6ixlw==
X-Google-Smtp-Source: ABdhPJzdxIEj7qFcRlL7LA6GiaVt6+Wd4Aj6FtIpSrTkotuHBxPyivdkm5v/euvUKTJbYhcx54CgOg==
X-Received: by 2002:a17:902:6b03:b0:161:51d6:61b with SMTP id o3-20020a1709026b0300b0016151d6061bmr25557467plk.23.1654539445550;
        Mon, 06 Jun 2022 11:17:25 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:6e63:c427:72dc:aaa8])
        by smtp.gmail.com with ESMTPSA id e16-20020a056a0000d000b0050dc762819bsm11084492pfj.117.2022.06.06.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 11:17:24 -0700 (PDT)
Date:   Mon, 6 Jun 2022 11:17:22 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitkarwar@gmail.com, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v5 1/2] devcoredump: remove the useless gfp_t parameter
 in dev_coredumpv and dev_coredumpm
Message-ID: <Yp5EstgFf/JdM2qV@google.com>
References: <cover.1654229964.git.duoming@zju.edu.cn>
 <df72af3b1862bac7d8e793d1f3931857d3779dfd.1654229964.git.duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df72af3b1862bac7d8e793d1f3931857d3779dfd.1654229964.git.duoming@zju.edu.cn>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 03, 2022 at 01:09:34PM +0800, Duoming Zhou wrote:
> The dev_coredumpv() and dev_coredumpm() could not be used in atomic
> context, because they call kvasprintf_const() and kstrdup() with
> GFP_KERNEL parameter. The process is shown below:
> 
> dev_coredumpv(.., gfp_t gfp)
>   dev_coredumpm(.., gfp_t gfp)
>     dev_set_name
>       kobject_set_name_vargs
>         kvasprintf_const(GFP_KERNEL, ...); //may sleep
>           kstrdup(s, GFP_KERNEL); //may sleep
> 
> This patch removes gfp_t parameter of dev_coredumpv() and dev_coredumpm()
> and changes the gfp_t parameter of kzalloc() in dev_coredumpm() to
> GFP_KERNEL in order to show they could not be used in atomic context.
> 
> Fixes: 833c95456a70 ("device coredump: add new device coredump class")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

For whatever it's worth:

Reviewed-by: Brian Norris <briannorris@chromium.org>
