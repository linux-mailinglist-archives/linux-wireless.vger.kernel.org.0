Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5307F6F2BAB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 May 2023 01:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjD3X5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Apr 2023 19:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjD3X43 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Apr 2023 19:56:29 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0031BE65
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 16:56:26 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-446ed123287so689103e0c.1
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 16:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682898986; x=1685490986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9htLooF+mJdVnHMpJuacP6i1vkkjNcgv0Bl73sCu1mI=;
        b=kswS7FBfW19nA/lRYVOlVH4hvU147zrmR1a3+rEDzZDNKfd/1WjarX4LRy2CLQatVf
         8f1nmlwFRqvZApIACbqDfSUTKV5+ACCwE8wOaivkyepNVvSnstzL0QXMq0bexOwaqXKA
         FLpviUA5riQDs9TIMdCqm3A4o1/Ue4Z/T/ap9dcJjUUwsp8i2ydgOz9iacqQzPHLftEQ
         /N8S1YbJc3xOEaYbKWQsCFIaHs+izXnliLRuw63LNb2r6VV4ZT/3oyaBuqXqWCd1vs3m
         +8i1hpF21mNsVSaYo/DCE5tINTtGcpvrIVYPo5r08fJY1AFtlcY/te8yeyBG2n8l6qtw
         yhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682898986; x=1685490986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9htLooF+mJdVnHMpJuacP6i1vkkjNcgv0Bl73sCu1mI=;
        b=ABR2qlvQgDNRLhkyHiiPMMSoRwI+69d42uLRXZM7wdmTS2XPnv4+Tei5WyZOHEylqB
         20ip1xheIxBvcq2/m3h6I697ZvB9w0kK8fbPlQdg0mezg5CY+B6WbCKfTw6F+iJ0JDYx
         kJ2U9BpM350wzYGnQSu14gu8aJnWSw/3CGbD7O41iwpNW5R/QbiDIJg6NtwOn9tydYuX
         r0+8h3P8BnwTViPjw2nz/9QiuwjG3PgS0a6VmTiq7PnWT2hrIdKTqIyz41GINo4rTWYv
         RIVnXILP978mdCoFWaEVs2NVqX+bnG2bICNqEQPq391p8xpYep+nNiyvza65tbL1A1rd
         Uq3A==
X-Gm-Message-State: AC+VfDxjhhGRmWI2t3M18N6tw4PLURhmLlqqzZOXtdBkwa0ZpTGVG0KF
        fFM5ix3AVLkdukG+aZOjfQe2nLLu/0wEThs2mKc=
X-Google-Smtp-Source: ACHHUZ5y48SvQd4L2uobW3X+NZ2OKjsAXY/n+e2P8eYIHTClE/ABDaTsTx2LiaiDeUqozSwtVsgQQyUgfiu7TpNy2dk=
X-Received: by 2002:a1f:5d83:0:b0:43b:ef4d:f6c0 with SMTP id
 r125-20020a1f5d83000000b0043bef4df6c0mr3778369vkb.0.1682898985644; Sun, 30
 Apr 2023 16:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230430201830.2f8f88fe49f6.I2f0076ef1d1cbe5d10010549c875b7038ec4c365@changeid>
In-Reply-To: <20230430201830.2f8f88fe49f6.I2f0076ef1d1cbe5d10010549c875b7038ec4c365@changeid>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Mon, 1 May 2023 07:56:14 +0800
Message-ID: <CAAJw_ZuFaE-oYWQWQ+k0Lz_GcJH+adF6SZuwaKpV8UB0XGqVzw@mail.gmail.com>
Subject: Re: [PATCH] wifi: iwlwifi: mvm: rfi: disable RFI feature
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 1, 2023 at 1:18=E2=80=AFAM <gregory.greenman@intel.com> wrote:
>
> From: Gregory Greenman <gregory.greenman@intel.com>
>
> This feature depends on a platform bugfix. Until we have a
> mechanism that can verify a platform has the required bugfix,
> disable RFI.

Greg,

Patch applied and worked! Thank you!

Jeff


> Fixes: ef3ed33dfc8f ("wifi: iwlwifi: bump FW API to 77 for AX devices")
> Reported-by: Jeff Chua <jeff.chua.linux@gmail.com>
> Link: https://lore.kernel.org/linux-wireless/CAAJw_ZvZdFpw9W2Hisc9c2BAFbY=
AnQuaFFaFG6N7qPUP2fOL_w@mail.gmail.com/
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
