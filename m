Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55DC7E8FAE
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 12:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjKLLy5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 06:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLLy4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 06:54:56 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6851A2702
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 03:54:53 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so5868820a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699790091; x=1700394891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2DZbbvQgZ3WGZG+hH0YvUjerJussWDHwFzqgXHTwen0=;
        b=jJ+Q+DxK/2tsG1QQA37HlDaudR0aqx3jtjoL+Ckus8tsuzosEmWQHdDL+T7bszF5QW
         yAdL0G3RdR3BhuPPVQbyPHkywv9oRjpYkgOVBsWQ8xkZ9yjvyFOVzZW9dNSHHDp54D7g
         8Iz/eB0BRKp/BzJyiQZx0uoR415jHI4EayJErTjwd9vAkpGYir6C4Xcb3zNeQpSuBJEG
         DFCMFFw9I6ahKZhEL0xmq2xWE/fSKWn5I+CycX1GeDieqUV4CcpxHW3gJTxJc29I8sap
         yL6P7D3z7/8KeZ+XZX/7dZh37cHpoCWHcnpg1i8WA7rw1YRoR3q3PX9qAYbKWEx5QobC
         0gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699790091; x=1700394891;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DZbbvQgZ3WGZG+hH0YvUjerJussWDHwFzqgXHTwen0=;
        b=M9rtVN2b90KTRSclUhrCpZTNJTEU3coKolQAgEVmNeAWLV1iOxDP5TRmKFo2UYkfR6
         TtQSW1x+aQb3fK7ofYaa+/yeevkcu1KBzvfQ6keCtpjdkrgXs+MFJL2RL2gpPy4ufuli
         u8WBUZGG4f2FVhT00aHxl2dsmvphX9XGapHC43vH84odO44nli8nzNo6mTLzdg78F933
         2/yDP3SOZMwL9qQKIOhV5kCW/e3J9U57Xkee7vmAFM7FTw0j2rj5sFXzsHlsASO3EKju
         /DzUh044/HEYZmifRSe/6su9mp+UB3edeIcb9DJjtr/ZCCzXVSJiuSFC81s6Qaadh/8Z
         XOtA==
X-Gm-Message-State: AOJu0YzlhDrTobnLj4gm0FETiPaLi5bCbPwLpQCMFk+Lm5IFLx/H9kEy
        /7g6RUb55xiXhFP5dzCSB9aKBnq44xlJ/0kl1yA=
X-Google-Smtp-Source: AGHT+IGeouhye8hOkIIwNqntNBKkmAGudSvoanGUnWnqspWDkeYGSyKkEl4Uj8n81JKNTSDHCzJ6+dxOtU4FTHHDYw0=
X-Received: by 2002:a05:6402:12c1:b0:543:8498:fda5 with SMTP id
 k1-20020a05640212c100b005438498fda5mr2913662edx.14.1699790090541; Sun, 12 Nov
 2023 03:54:50 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= 
        <pinkflames.linux@gmail.com>
Date:   Sun, 12 Nov 2023 13:54:34 +0200
Message-ID: <CAG+bWs3MJcKe15+5kO6qS4rji5pcVGbDDkkMgQThqcif+3t32A@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: iwlwifi: fix system commands group ordering
To:     emmanuel.grumbach@intel.com
Cc:     bagasdotme@gmail.com, gregory.greenman@intel.com,
        johannes@sipsolutions.net, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com,
        pagadala.yesu.anjaneyulu@intel.com, regressions@lists.linux.dev,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have tested the v3 patch and the stack trace is gone. Since I only
use the Bluetooth functionality, I can't test, if the Wi-Fi is
actually working.

Sorry in advance for any mistakes, I do not use e-mail or mailing lists.
