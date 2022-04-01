Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE63B4EE61E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 04:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiDAClG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 22:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiDAClF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 22:41:05 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C920437A1C
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 19:39:15 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z8so1512515oix.3
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 19:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forshee.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BjTHLhmpYCYQ0PpoBjmla79tTLcmiaAbrm5pPyI7YWI=;
        b=SIc+vhlOh5ttYc/ya6FB5DzsAfi6SYDUsbVbixAlfe4jzYCYfa/3ygswSRyHX8641r
         FfqYLVHK3BQ+mr9I33NY/aSjEtc86mIEIFpc86bKE/SEiFM6dw+kp1Z1g4uUwUI+gSwo
         tvOso8LxS4/5hrCzyUFmMKNSbSofwGI0dd/652XS796UWUMa/CJPZ8IHhyGgwZrDWd4W
         JeogF2Y02Lpyq86e8/Eo3yq+vxq3Irncw+z5QdeJt1SWD6MaSYsPE9muTDq7mwOsFzkr
         TXz5MQMW+pRBqTW5C/i4uJBoP7rRSqg90UTM2FIuN0b1yZj47+gXeHTJc+56f7MODWig
         EaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjTHLhmpYCYQ0PpoBjmla79tTLcmiaAbrm5pPyI7YWI=;
        b=KQ2b9amVrmA30jFhOs5hTa53nAu7xP1hKzpD2zklHZpzfL6/ITqWFXKkXSA1LwBLJv
         Zfk2HKMLsFbB1O2P4eWAU7Mxy+jtbSGkLbJzIcbRSJIx4OADtn7BlNAxxj4Jqo+ZbX4t
         jWwUZn7UGGjkWP98klHLPbJONSHs26UAh5S2qIG4qHNOdySA41HhVW0/kk+eTgspIJNN
         GsngPMolsgb7S3CGkz5LM9bEXMArhySZELVVvh89t5lWF5SCOztoZ+/l0jKt70tJxF+Y
         FAId719noezT79zvWDEBeycuE8jrfFswHA//hV/CTPQArW0nobppa0psPatQExZvXUoo
         0oRg==
X-Gm-Message-State: AOAM533rNvZpvk+yuM294KfGC3WFnlgdRIfhFCan4yCses2sP7cmiioZ
        gAYh02qnjnAgD5ftE6IvY3S8AqzLhVGggg==
X-Google-Smtp-Source: ABdhPJw6HSFn/A8VOqN1+nyAG03yVR4wQlmi2qwVV10en5PPn2XYY+YSnK1U/zPmdI3O1R/9dcjNiQ==
X-Received: by 2002:aca:4b15:0:b0:2ef:1e2a:99be with SMTP id y21-20020aca4b15000000b002ef1e2a99bemr4023290oia.242.1648780755179;
        Thu, 31 Mar 2022 19:39:15 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:24bf:e24b:6157:4a8a])
        by smtp.gmail.com with ESMTPSA id n66-20020acabd45000000b002ef6c6992e8sm486320oif.42.2022.03.31.19.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 19:39:14 -0700 (PDT)
Date:   Thu, 31 Mar 2022 21:39:14 -0500
From:   Seth Forshee <seth@forshee.me>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: add missing spaces for US S1G rules
Message-ID: <YkZl0gw40Htwpu5t@ubuntu-x1>
References: <20220323194134.169332-1-sforshee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323194134.169332-1-sforshee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 23, 2022 at 02:41:34PM -0500, Seth Forshee wrote:
> The rules lack spaces in the frequency range definition, which works
> find for building the database but causes problems for some external
> parsers. Add the missing spaces.
> 
> Signed-off-by: Seth Forshee <sforshee@kernel.org>

Applied.

