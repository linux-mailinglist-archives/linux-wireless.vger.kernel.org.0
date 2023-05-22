Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA270B3FD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 06:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjEVEFB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 00:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjEVEEy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 00:04:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83D3CA
        for <linux-wireless@vger.kernel.org>; Sun, 21 May 2023 21:04:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f606a89795so1726785e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 21 May 2023 21:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684728292; x=1687320292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+sTm0gTU6Kkz5BGhjgcQ8Or3h6CRXt7yGwZk37PhqA=;
        b=Pmz9jHbnDGb8si4Gd9V0PxUY7kHqCy19fYQm8dsnq/sWbShAx8QXQPOVHlEjMkpFh8
         bUbUaTGc7HNbTOk9a0W691zN37sNQOGVaYS81JwH9v//kOeWxyTvadwmyWLCQDVj6wpt
         7FIFEz8c8QjAaAtTeUWxNLjUgDoVOxSFDD73ZCXZDtjHvN3Ma+VUm9+SAOJ09OYJefdb
         1RWDf8qR9v1ty1b8WLlc7SlC85ea3yYfelAs4OyNMescbzPnwmE6SBqmZVD4vOvBwGVW
         66/C0TNMPB/DWMIz0PU5+q43/VXLP5rLKF6h66/aH3PcfGWYaHu8WTRcqXEh+ouGUSat
         WvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684728292; x=1687320292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+sTm0gTU6Kkz5BGhjgcQ8Or3h6CRXt7yGwZk37PhqA=;
        b=NW6XVAdj6WeiFGiBvGzGbGsR4yUBgp+TPqHwTJppFlTFRKni0WHTPn74wcIEmqqCyv
         vM6pXO0e6okIWosPYSP/5hIp9GDCE+x1NlMyWiS5HIru3rnaF9yreD5+oHAAiplS7E6Y
         jmoKREhfBtC3CApg7WDMt7z1Aq98S34Tv+7kIkOhXapC7XQ/cTSFDlhW2nBy7heQ+STi
         NpovkOiQBn734TS3CHet9g+CIoSm3zNTkwt83abCtx3Hpf3mizCuLgik+rbgM26LEhxA
         32WQliQxGd0LDfTIcMJSToBGn8P4MXMyiqdkk2PrBLyKFPHf6qGVXI0VGrrq+6tO6gSg
         G7ZA==
X-Gm-Message-State: AC+VfDzD6TgdFUZTYJOIcKSewO/TXrIuno2WZypB/UNwd8xWKBDjWNid
        +RhkSBrOuyKJoTiWmB0/dY7onf5PtPK/W6/QXeo=
X-Google-Smtp-Source: ACHHUZ4bVTG8PQ6vAbtWa8IY9kwGZJrGPsq97dgh3Gl5nRnifQJk8med69wGGAu7KtG0z8P02dIO5A==
X-Received: by 2002:a5d:68cd:0:b0:307:cf55:a7d8 with SMTP id p13-20020a5d68cd000000b00307cf55a7d8mr6725376wrw.42.1684728292122;
        Sun, 21 May 2023 21:04:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v16-20020a1cf710000000b003f4fe09aa43sm10178501wmh.8.2023.05.21.21.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:04:50 -0700 (PDT)
Date:   Mon, 22 May 2023 07:04:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [bug report] wifi: rt2x00: add TX LOFT calibration for MT7620
Message-ID: <a281398e-70cb-4a85-8d08-00695f55d613@kili.mountain>
References: <a5e29cc3-b56b-4233-94f6-0fb82b53dd61@kili.mountain>
 <CAKR_QVLsWEyCvRFDrdTps0haCgATsRbWjNg6ASuDCb6zcOMVTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKR_QVLsWEyCvRFDrdTps0haCgATsRbWjNg6ASuDCb6zcOMVTg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, May 21, 2023 at 08:23:53PM +0200, Tom Psyborg wrote:
> Hello
> 
> This was all taken from reference driver.
> i did not go through detailed debugging to see if the value is
> overwritten in vendor driver.
> 
> Maybe ask devs from openwrt who upstreamed these patches
> 

The code is clear enough.  We could either just delete the underflow
check or change the array to an array of ints instead of char.  It's
more of a philosophical question.

regards,
dan carpenter

