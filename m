Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECCF72442D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjFFNSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjFFNSK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 09:18:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB9B10FB
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 06:18:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso26536905e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jun 2023 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686057486; x=1688649486;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2ILQHD+UhlWflevq/PDJLXm2e0GfEsoncwJAA8aH3s=;
        b=JW2vC+xHC+JP/o+vSKtL5ckLtwFIal8dPNj6f1IsTA1T4nNN06CbQc6t6E1/bENElA
         GY8Hf9kESMcC/4LWLTpKAd/xfrdUIHVQRYifJa1VjQaAm6OJiJDVEwF0mn3TiDCHAGkX
         Fg5/jXOUofxKCI4YcX7RAOKnR4tUqQEHzjdgWvs/JAGurDfUEpCwQmJz45qqcOin67hL
         77+QS+js/B4NETYPm4v+9tN0129MqHgTf88oDgU0q5qf1Wm5wfu9u4o0aivxIoQ63CDJ
         90AMBxTALqv+l9qvT7qdST/XzaycNNAjm8Cydjprnv8R+/njipxIY50b+ZahYwq/f50f
         05cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686057486; x=1688649486;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U2ILQHD+UhlWflevq/PDJLXm2e0GfEsoncwJAA8aH3s=;
        b=EawYlmQ2K3jVrDXia7JHsu1GWJHRQl65SCsZYShXLiAtJueCFZ1iZ7jskqXgmgr5IT
         AFc97A778SObngzlQEZfA9VrGEaP6tjzj8JbDRFaGTluItm2Ph6FjsM/oXrAjarS1SpC
         lQnNseWrQ2eFa1ryqdt4xVY64H2S23bnPjCgdkgLqecUC+h52tb1LIJyCRjNq0cmQbAG
         zHAjU8dklQtmyw2RHyr6Fofq+jCN5ur38gKW1p548yJ7ip3G/Sw7J0aItWlQHG1xkMXa
         x4IEr6utyMpkswu+O+GbwH89BFN1MutPukUVv4mbk6fp+HqdpA4jqlzI+K6nJUuxaaIk
         APAw==
X-Gm-Message-State: AC+VfDzikwExR+/eti1Z2pzwXMkZoSwk6KMy5mJEpL72adzitG5eYze/
        xt0Av2r0mB6RZtDtj/y1+1E=
X-Google-Smtp-Source: ACHHUZ4DtUeeJrPSaVrdSKccwbesRhfKVCP59ru1RVkUe5cpj7GC4jH6mI3WWpeUueBAmAOwMHJVZg==
X-Received: by 2002:a05:600c:2947:b0:3f7:3991:e11c with SMTP id n7-20020a05600c294700b003f73991e11cmr2322172wmd.8.1686057485889;
        Tue, 06 Jun 2023 06:18:05 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id a14-20020adfface000000b0030add836194sm12575728wrs.65.2023.06.06.06.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 06:18:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 15:18:05 +0200
Message-Id: <CT5LHVPA2Z4A.2SI6YNBBYRGD9@syracuse>
Cc:     <linux-wireless@vger.kernel.org>,
        "Anjaneyulu" <pagadala.yesu.anjaneyulu@intel.com>
Subject: Re: [PATCH 13/16] wifi: mac80211: remove typecast in a call to
 ieee80211_config_bw()
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
X-Mailer: aerc 0.15.1
References: <20230604091128.609335-1-gregory.greenman@intel.com>
 <20230604120651.1b01fef7c81f.Ib6492fe29fe31807b2fe31a84734b55d74b5c314@changeid>
In-Reply-To: <20230604120651.1b01fef7c81f.Ib6492fe29fe31807b2fe31a84734b55d74b5c314@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun Jun 4, 2023 at 11:11 AM CEST,  wrote:
> From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
>
> Make "changed" to be u64 as implied by the corresponding enum size.
>
> Fixes: 61513162aa2d ("wifi: mac80211: mlme: shift some code around")
> Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>  net/mac80211/cfg.c         | 2 +-
>  net/mac80211/chan.c        | 2 +-
>  net/mac80211/ieee80211_i.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 7317e4a5d1ff..49f5122189d3 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -5,7 +5,7 @@
>   * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
>   * Copyright 2013-2015  Intel Mobile Communications GmbH
>   * Copyright (C) 2015-2017 Intel Deutschland GmbH
> - * Copyright (C) 2018-2022 Intel Corporation
> + * Copyright (C) 2018-2023 Intel Corporation
>   */
> =20
>  #include <linux/ieee80211.h>
> diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
> index 77c90ed8f5d7..a7e204de5d54 100644
> --- a/net/mac80211/chan.c
> +++ b/net/mac80211/chan.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * mac80211 - channel management
> - * Copyright 2020 - 2022 Intel Corporation
> + * Copyright 2020 - 2023 Intel Corporation
>   */
> =20
>  #include <linux/nl80211.h>
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index e67c5c754be1..886244d42f04 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -5,7 +5,7 @@
>   * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
>   * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
>   * Copyright 2013-2015  Intel Mobile Communications GmbH
> - * Copyright (C) 2018-2022 Intel Corporation
> + * Copyright (C) 2018-2023 Intel Corporation
>   */
> =20
>  #ifndef IEEE80211_I_H

Hi there,

Did I miss something or there's no code in this one but just copyright upda=
tes ?

---
Nicolas E.
