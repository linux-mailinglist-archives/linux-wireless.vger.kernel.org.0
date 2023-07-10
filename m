Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0BE74DAE8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 18:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGJQUj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 12:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGJQUh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 12:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A133F106
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689006000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oU9dd/7POY9KHuCZhBS03qm8E6hE7bjFjSpxgt7tws=;
        b=F1/VGkzkHomZN5Pet+DKf+TUqdMDTfeR4b/UnzgK0nqPZ8yUH27OmwdfwRTcP9r3gbVEhN
        csft2ddhaZQ+XD0OfdmfhMnVLipDxEPqn9CO7OAoyGqGfaOjlZ0HZBokV9/mbODOoiCkwi
        o2d6HUd/vRxOIwiQdODzXpViREUAaIA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-frSALtIVO26Hxztoi-w85A-1; Mon, 10 Jul 2023 12:19:58 -0400
X-MC-Unique: frSALtIVO26Hxztoi-w85A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-767b80384a3so55321685a.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 09:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005998; x=1691597998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8oU9dd/7POY9KHuCZhBS03qm8E6hE7bjFjSpxgt7tws=;
        b=KyjuJITt+THNsLdW3J4MoWlVRgb4hPtfekeOWOrXzSBvLxwsb02wQl0glg1h93pTgx
         M8H/lQE7VLz/EjAYKfG+liA24YvYKzfygQs+7JaOHagfIsi8u0RoU6sBAstZZfCZ6Fsn
         hkeqWYcEv+40BLU17Ps9kroHazLaVjrEm47k1AZl8jkfAUOTzDOW58D+DjTS+UmL/V6o
         /EBZS7L6o6e5DU9OYq2u6OjfabHJgSSTwYpA9NDwucUZvDGSZ2O4KaVWYRtqeX6jp+o8
         aRfCupZuhpZcSQ3XkYKM/mKlNHWnJayHbn8WAAD5Z9QruvU4S0HFGGE3fXku9gmQX2vr
         lYvw==
X-Gm-Message-State: ABy/qLaSo3yNxdUU1Yl1GmFTbvm0ZD3qT727iepqgEauvHsjY9X9BDBx
        WLgR2JCG36G3ffzLmC/thd0kUr3wALRPQdCeI+UOpBXNnocY30eF2jBOiqKJvZgnsApoxPBpuCZ
        +kt46YBhLortKTD/gwUtiZPdGeuQ=
X-Received: by 2002:a05:620a:4115:b0:767:614f:323b with SMTP id j21-20020a05620a411500b00767614f323bmr15991307qko.1.1689005997827;
        Mon, 10 Jul 2023 09:19:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxSEifmwjT/2xDynG2XZoP9m9TewbH/2teu+kLv5n8dRGAb9Yzq7ZCdvxmkMqx8rKYP0yfRw==
X-Received: by 2002:a05:620a:4115:b0:767:614f:323b with SMTP id j21-20020a05620a411500b00767614f323bmr15991294qko.1.1689005997518;
        Mon, 10 Jul 2023 09:19:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a136700b00767c961eb47sm7580qkl.43.2023.07.10.09.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 09:19:57 -0700 (PDT)
Message-ID: <770f630823c33f25ecddcbac19ef3acad82c2636.camel@redhat.com>
Subject: Re: [PATCH] net: wireless: cisco: Fix possible uninit bug
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     kvalo@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
        Jason@zx2c4.com, linux-wireless@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Jul 2023 18:19:54 +0200
In-Reply-To: <CA+UBctANALC+FdNf+0v+hFZS5RPry=44LF3HQWKMYCxibgb_vw@mail.gmail.com>
References: <CA+UBctBLWF14TsgT4OfanmnxTqbm9mNxyHhjJqpFo7c+kdjDsw@mail.gmail.com>
         <a8c6e741a9c704dad9b63e1e85136a8e6da09b44.camel@redhat.com>
         <CA+UBctANALC+FdNf+0v+hFZS5RPry=44LF3HQWKMYCxibgb_vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2023-07-09 at 19:52 -0700, Yu Hao wrote:
> I found that the related code is from Linux-2.6.12-rc2.
> In this situation, the 'Fixes' tag should be 'Fixes: 1da177e4c3f4
> ("Linux-2.6.12-rc2")'?

Exactly!

Cheers,

Paolo

