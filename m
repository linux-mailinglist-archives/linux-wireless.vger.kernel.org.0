Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C445378162E
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Aug 2023 02:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbjHSA6Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Aug 2023 20:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbjHSA6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Aug 2023 20:58:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54F2A6
        for <linux-wireless@vger.kernel.org>; Fri, 18 Aug 2023 17:58:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99d90ffed68so544689066b.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Aug 2023 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692406693; x=1693011493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRRzUJqjkgfNbheyhNdC/Vm9rNr6Rw8N3Ecr7Eo0vGM=;
        b=MGj1dH32uMP9iacknpd8iWbmqozez+SlsWlEyjt92CATa21J7LVw8a6Uol8SqP7Vdd
         TSj2YE9iM9ABL+6pXUqigBQW4bd/VV30/rOlOO66b7Oi+FhQrOa/ZvJ7UC+rB19qjJR9
         B4trjPMBKNDYW0jstbfkuLww+zAz9qiELQZiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692406693; x=1693011493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRRzUJqjkgfNbheyhNdC/Vm9rNr6Rw8N3Ecr7Eo0vGM=;
        b=DG+eLnVnROfSTa82y6uefmGhIdPvLMlEchwtixLujIERHYVcut0f6PIzBU3jomry8N
         08lYcReu/e+dVTIziYoIuW57VZl4taNTfra8NvBPYdey1gRNj8K4hSKsp78EP5pc9MDO
         0wgEANHaP620FX+pSishw5WXphNoBmtSZ7kDZaYhlg5IDSeTkZ7U/jAzpk6tzSLEodFQ
         JKfACvKz7H5C+9w4ujKXxe6YdckYWv/JzxVKXLFJSrpIDEjzWb7ph61k9Y7bHBsZjwNn
         h03mwHqENLoCE7/qMmdtzQbNRqEGNiLrLhKj1oQcRWoddA0jj5GC5ii5AOAIbZ9ZklmO
         Aj4g==
X-Gm-Message-State: AOJu0Yzjrk60HtIL05d3yX91r2zzIsXkOWF94wK1ie8dk8cYfVQiMmMX
        eB242XEf3EabE6u2HGrmAnusu4MYp0dW/7tqVL9ztw==
X-Google-Smtp-Source: AGHT+IG2GwTIyj22CSv/gpz/y1vnzk4Y8uhXrtU8xtEm1XAWxaBdfdJjJVM97eXyVPj4s4toGaiiNw==
X-Received: by 2002:a17:907:3f93:b0:99c:572:c0e4 with SMTP id hr19-20020a1709073f9300b0099c0572c0e4mr688420ejc.7.1692406693117;
        Fri, 18 Aug 2023 17:58:13 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id w3-20020a056402128300b005222c6fb512sm1677593edv.1.2023.08.18.17.58.11
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 17:58:11 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99d90ffed68so544684866b.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Aug 2023 17:58:11 -0700 (PDT)
X-Received: by 2002:a17:907:3ea2:b0:99c:2e3:cad7 with SMTP id
 hs34-20020a1709073ea200b0099c02e3cad7mr796048ejc.5.1692406691127; Fri, 18 Aug
 2023 17:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230814142101.60308-1-dmantipov@yandex.ru>
In-Reply-To: <20230814142101.60308-1-dmantipov@yandex.ru>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 18 Aug 2023 17:58:00 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOVKQiH-owBBk8NgL_nz-65X--PX7JyVqzV_1jvzixFoA@mail.gmail.com>
Message-ID: <CA+ASDXOVKQiH-owBBk8NgL_nz-65X--PX7JyVqzV_1jvzixFoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: mwifiex: cleanup adapter data
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 14, 2023 at 7:21=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> Remove unused and set but unused 'dfs_workqueue', 'dfs_work', and
> 'scan_channels' members of 'struct mwifiex_adapter', adjust users.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

For the series:

Acked-by: Brian Norris <briannorris@chromium.org>
