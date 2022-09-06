Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2975AF7CC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiIFWW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 18:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIFWW1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 18:22:27 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA63AA4B06
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 15:22:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 78so11827321pgb.13
        for <linux-wireless@vger.kernel.org>; Tue, 06 Sep 2022 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9+9emoww3hJUz6+xI7xquY0LNL2jhluEPZeZV1SQ388=;
        b=CJoqjIKy0n86oTWooLaNgt0B7dRumeuzRd6gmAHFNpfPLW5bZlCr/KeRLEI5Ag0wRu
         gjTT8dDdgxxRnFhTaZvQ/hUqfoCYtRwMcc4MGdlTSL34jBWzvJd/nZtwzNJXG9vLU/f2
         GWKhrx96p/IBfo04UwsHOi861ni6tj89b4zSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9+9emoww3hJUz6+xI7xquY0LNL2jhluEPZeZV1SQ388=;
        b=78mEJfms/rDkD2vpJNnyRqE7V5ieoEp5O7Q4d5dXrRXQ5J8YQHBuNes6Tls1LqCzRR
         /JiinBkDJXtTJzRjjxYFhE76rkQrxPGy7OotBHKJswGdP+XXzgswFtmGo8hCuAJYuixD
         YXF+JnIMd+mdG6NWIPvn3Ztl/FjAib8tWss4S4V1PWfe2odmnIKbISn4KvibLrsEgG/g
         6LuLEHG6gGdWjn+iom/Z65rXw4GiXheQqJPNENw2ekKFw0fFegRk3BTlYZfPQBE8zU30
         LKIdzcDM9ikejsluYEdBODvmPJ84zMPmjfkTn9M4LBapOFDjop7ZIoMg9iawVri2JZSL
         Pk8A==
X-Gm-Message-State: ACgBeo1GUFv+SzBTC0IFTddysnvroaYJNLCMLG+HybgQnPchoeMRUsoO
        pGLiaI19Pvr7QHexIxcHxuyZXcRn8URDEA==
X-Google-Smtp-Source: AA6agR7ilPxmdWUzY3L0SNMrYcQlwXL5L8pAxgfe+k44KwJXlgQcPacExLWWqIergq6euaS16zzrmA==
X-Received: by 2002:a63:a1f:0:b0:434:dd36:c639 with SMTP id 31-20020a630a1f000000b00434dd36c639mr668234pgk.165.1662502946402;
        Tue, 06 Sep 2022 15:22:26 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:922a:25d3:a5a:7290])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b0016d692ff95esm6103983pln.133.2022.09.06.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 15:22:25 -0700 (PDT)
Date:   Tue, 6 Sep 2022 15:22:23 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 08/12] wifi: mwifiex: fix endian conversion
Message-ID: <YxfIH1x6hdTMfM1V@google.com>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
 <20220904212910.a32e45adb2b2.I8c966b07c0bf7be4485967b044d9dad3f4772a27@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904212910.a32e45adb2b2.I8c966b07c0bf7be4485967b044d9dad3f4772a27@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Sep 04, 2022 at 09:29:08PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Clearly the value should be converted and then compared,
> not the result of the comparison be converted. No binary
> changes on x86.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>
