Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1132779806B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 04:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjIHCDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 22:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjIHCDA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 22:03:00 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD9F1BD7
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 19:02:56 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45070739316so630992137.1
        for <linux-wireless@vger.kernel.org>; Thu, 07 Sep 2023 19:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694138575; x=1694743375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
        b=f5eyIIxd3AMpaxoLRsYl4V8eOkfTfw12fJZozOjo7CPPm9CI9L9jCD0hdEFAdXvwKM
         3bL3mJToI3Co5HpeQli+rM6ki+hYj+Wr/cYTr82029F/ntbzdcSHLrGff5TDv+Oucc1x
         rcMJpdmcnPY2kCSq9zIEclAP8i3h2+zhVJWio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694138575; x=1694743375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
        b=VdL3AfXJ2Q5LmD0xEVNtj6+OWAYh1qj9zPwCiNRINRaVVCmoScIJz4QBu7HNDtDxP0
         N09FuTf2Y8DXK9zN5clFVvWnhNKvjAlLB74Bwt0mw7Sikvs64mCeDqyQEz1sgTKsnuMp
         84HXf8D0qtHfsN3Nq+ZFb1i/ofimcPGT3TFXTbJ+gJ7bJDau4EclC5/YjsjzMzAtXi+y
         eBA9+Qlta8cFz8BwDckAJYZ9tE7mgFlTFLbc1AzjHbqhMfI5qJ8gJOALzRN+lAUf9eNp
         jWFC6ZxscjwbldF5Lt+v0kwffI+xcMVAiHj8fARV9RWaOC0rgFv5Gq65ttmTqZRKV8cs
         4nwg==
X-Gm-Message-State: AOJu0YwIiopb8etUuUd6j1cXuCcG4KCsUYdCEQN3q7+YJd4O/Vw5Crj2
        rm447mPZD4gkQp7tBUIMNR6Y2MR/rI6S6dGReSnZdA==
X-Google-Smtp-Source: AGHT+IHyI1+UjDzAz/EZqFtxqoQ3AvK6alN6pBhvAa3cuwihyqW9mDq6z/mA+rQoOxBUQabMw7vHgg==
X-Received: by 2002:a05:6102:e4e:b0:44d:5718:d72a with SMTP id p14-20020a0561020e4e00b0044d5718d72amr1623519vst.11.1694138575052;
        Thu, 07 Sep 2023 19:02:55 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id m6-20020a67e0c6000000b0044d4e63aa03sm146695vsl.25.2023.09.07.19.02.54
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 19:02:54 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-44e8d9e6ca0so630494137.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Sep 2023 19:02:54 -0700 (PDT)
X-Received: by 2002:a67:fc05:0:b0:44d:3bc0:f1ba with SMTP id
 o5-20020a67fc05000000b0044d3bc0f1bamr1510797vsq.26.1694138574367; Thu, 07 Sep
 2023 19:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <4b2ee1382896dd7ff27ecbef6e1ad496edccd3ad.1694129223.git.objelf@gmail.com>
In-Reply-To: <4b2ee1382896dd7ff27ecbef6e1ad496edccd3ad.1694129223.git.objelf@gmail.com>
From:   David Ruth <druth@chromium.org>
Date:   Thu, 7 Sep 2023 22:02:18 -0400
X-Gmail-Original-Message-ID: <CAKHmtrSRoAWa9bErAdE9dRcFk37L=LZW7T5bpOpF9aC_REiw1w@mail.gmail.com>
Message-ID: <CAKHmtrSRoAWa9bErAdE9dRcFk37L=LZW7T5bpOpF9aC_REiw1w@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix the wrong rate selected in fw for
 the chanctx driver
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        jsiuda@google.com, arowa@google.org, frankgor@google.com,
        kuabhs@google.com, abhishekpandit@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tested-by: David Ruth <druth@chromium.org>
