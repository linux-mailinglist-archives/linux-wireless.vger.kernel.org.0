Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA7A6E76A8
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjDSJs1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjDSJs0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 05:48:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFFB5FFD
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 02:48:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u3so28021355ejj.12
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681897703; x=1684489703;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kSXXaZaIcY99eEmoMkVq8yMSYfMAETq99X9bytSxadU=;
        b=VEDrjN7Ks7NOj8DL5cUIaUJEVHbwqBnuz1lDBSBnnPdXpQYfx5ZC8xncRUS4oc74bn
         DjweFiM8pTbB41BBWfsFGtocKYw39r7BjRaEM9ZM/Sbz/hH9Ou5wy4fQNDzdvtO+nSK2
         +bNy814HBjkcvgX/vv6F9fDHPO0ZTEIWNUDYEzu0Xs582lhTuFaWVMnCfIeomv1NY66S
         XvKCdjR+IV/iTi5/WIgUNJ/0fMKHifm31PTVSIgucyfG4PMd3dd3u5qBhXwhuefv5zyz
         J7ETYZu+MuVCFNZN3ILmV2Dly+UJbsTADkeehzcBNDW5Fw1gNzst13GZh8AxbG8PNEKX
         bemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897703; x=1684489703;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSXXaZaIcY99eEmoMkVq8yMSYfMAETq99X9bytSxadU=;
        b=H7NBQeuHnE9OCOqFYsZFsDgUNK2RF8iwZ6bxTdSEVDAY71VCjpiceKjSmUDIR0Iq52
         zuRc3Fq4M/fINW3XZ6poyZ3PO6DQM2c0kPfyU5xg/t67DykAtuc6Qv6Wb/K+0HYdTT0j
         bvo78/u5FQ7cIYFoPYX6t6nTn9/eTx7Ajhb/kxJwU0lVvrwvg8wR9vSMJovp/G3g2Asm
         D2KoADE2LXXAuDy2SQ1AaLRw3D9u0azNPOtJiHZh+TPNXJvxO+2HEkU/CSKiY8uNMtsq
         CbiEB9Q8XQohWUFEyuwiywnxElOWUWjLh9pl8VI46wKULlayDGJb1BxmbTzlFLjCl9tv
         p50g==
X-Gm-Message-State: AAQBX9cuGKlcGo4dPVFs9ONa+EUL+fHBwP5C6Le9HV+bNYjUK+GMLWi8
        AKeQ3TAOLCn6K5ZkqVY3Ov4cTS2vEXFqnv5N6ZSWgbO3T3pAFg==
X-Google-Smtp-Source: AKy350YWIKjCKZSF/xwIvoYLNyIcLKVLapngO3pWE13h6ux+yXIYb/iRrTaZUXKW/3Dg+8ocjmsn4yLk71Px/qNiXMw=
X-Received: by 2002:a17:906:f6cb:b0:92b:3c78:91fa with SMTP id
 jo11-20020a170906f6cb00b0092b3c7891famr13714914ejb.28.1681897703416; Wed, 19
 Apr 2023 02:48:23 -0700 (PDT)
MIME-Version: 1.0
From:   Andrei Chalapco <andreichalapco@gmail.com>
Date:   Wed, 19 Apr 2023 11:48:12 +0200
Message-ID: <CAK0jaL10rXgu_3qwQfsarQKj5Jx_ULA0Lyf+vRCcd7JEMGL8Hw@mail.gmail.com>
Subject: rtw89 (realtek drivers)
To:     linux-wireless@vger.kernel.org
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

Hi,

I've recently bought a new laptop (Hp pavilion with the Realtek
RTL8852BE WiFi 6 802.11ax PCIe Adapter) and when using Fedora 37 it
won't find the wireless adapter. (still with a 6.2 kernel version).

Already found the rtw89 drivers on the linux kernel but they don't
seem to work and I also don't understand why a github repo
lwfinger/rtw89 seems to work.
I was wondering when this chipset will be supported by the linux kernel.

Thanks
