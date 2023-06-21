Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874C1738A11
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 17:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjFUPrh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 11:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjFUPrg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 11:47:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D0C2
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 08:47:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6687446eaccso3172631b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687362455; x=1689954455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyICK4Grh5eQSb5+l1W72v1ZtWzYkP88D3f/vUEv1+c=;
        b=Icow9X5/qqi7Mef62VwiI44ALoVFFCQb0WzRmtLHJWSFCMEAbczVVhF5MgwYNOyj6H
         k30XYSvhg9v2s808Y1TQpIDckZz1GXrXqR1u747ODhEQN2cTNHGRihOouP3GWRE5xvsy
         EC9NGZplM/1DAJKAm7DYOBmSPk+JrsENo210Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362455; x=1689954455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyICK4Grh5eQSb5+l1W72v1ZtWzYkP88D3f/vUEv1+c=;
        b=fGJgbhA3al96Ya8p7p2uvI4C/rOswdhuqBI04FqVXvbAaSou3IowuNcP8Zz/8l+Ibk
         3y6XkkektMFmk02vMUaXqAov4dSU/ILLs9cLYM8Dft2xHe6eMpvMsvSpbOmzruMG+q6j
         fglFOSA08sAv/sJnXIdixN2e8iRA26BzbFu6iEmI2C2fR6Gf9U4oYZar+EGYaM4itr/A
         zzdotdX8xXsIBtjw3WNzNIYXMYjhOnNNP3lQproJFnEr5xAzhfLBwc11JpeWjGIn+JHK
         jzQA2AAu4Qx9wctlyOxEvIt4hmroEkFx00vv0Q3na413E1lchZ8qDKwe3ZgBuDFOOyP8
         EByQ==
X-Gm-Message-State: AC+VfDx4IP3nrQPCmdu0Bhc006k5h5ODNBb98tQM/iJ4nQkRoKQyUTZM
        PEF3Fi/2a5z4//CfskFwJmKQFQ==
X-Google-Smtp-Source: ACHHUZ5qn06rNwVkGAt+8IejIMsYjjaop+zDacA9ACfbUuEy24y4a2BKLdy2mFP2+39IOe7gFpJhDg==
X-Received: by 2002:a05:6a00:1798:b0:66a:2771:6c42 with SMTP id s24-20020a056a00179800b0066a27716c42mr5423370pfg.0.1687362455200;
        Wed, 21 Jun 2023 08:47:35 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:566c:67e8:1803:3438])
        by smtp.gmail.com with ESMTPSA id j17-20020aa79291000000b0065dd1e7c3c2sm3063820pfa.184.2023.06.21.08.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:47:34 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:47:32 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] wifi: mwifiex: fix fortify warningg
Message-ID: <ZJMblMdEOQ6/ps2J@google.com>
References: <20230620100803.519926-1-dmantipov@yandex.ru>
 <20230620100803.519926-2-dmantipov@yandex.ru>
 <ZJHTLhQNM4oj40Zn@google.com>
 <a1f55197-6138-68d0-9e4f-8e53840d5d90@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f55197-6138-68d0-9e4f-8e53840d5d90@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 21, 2023 at 11:32:25AM +0300, Dmitry Antipov wrote:
> On 6/20/23 19:26, Brian Norris wrote:
> 
> > This invocation seems a bit suspect, as it uses a 'sizeof' of a field
> > that doesn't match the actual pointer (it's off by 1 byte), but that's
> > not your fault. I suppose it's no wonder we had so many problems with
> > TDLS support on mwifiex...
> 
> Hm, ieee80211_prep_tdls_direct() seems takes this byte into account.

Presumably it's part of the standard packet format. (I haven't
checked.) But in this case, we're talking about the firmware format that
Marvell firmware expects -- which isn't documented at all. Usually it's
at least related to the IEEE spec, but it isn't guaranteed to be laid
out exactly the same.

BTW, mwifiex doesn't actually use those ieee8021_*() functions for the
most part, because it's not a mac80211 driver.

> But
> do you know why 'u.action.u.tdls_discover_resp' is ended with a flexible
> array, e.g.:
> 
> struct {
> 	u8 action_code;
> 	u8 dialog_token;
> 	__le16 capability;
> 	u8 variable[0];
> } __packed tdls_discover_resp;

Not without more guess-based investigation. My poking around this driver
is more often based on code reading and problem investigation, not based
on any private knowledge of the mwifiex firmware or hardware.

But my guess is that it's supposed to reflect the dynamic amount of
additional IEs appended to this frame, before the body -- such as what
is copied in mwifiex_tdls_append_rates_ie() (or
ieee80211_tdls_add_ies() if we're talking about a mac80211 driver?). The
field itself doesn't actually matter, because it isn't used in the
driver AFAICT.

Brian
