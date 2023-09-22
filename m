Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938C7AB31E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjIVNxr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 09:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjIVNxq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 09:53:46 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B18197
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 06:53:37 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:582e:0:640:b911:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id 058C646D06;
        Fri, 22 Sep 2023 16:53:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XrLkiS3DWa60-HMQkVqdi;
        Fri, 22 Sep 2023 16:53:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695390814; bh=3SliNyoWEQYbJ+VEDX5ZeC65TJuG6HK8uCkIhcIKvs0=;
        h=Subject:From:Cc:To:Date:Message-ID;
        b=qM2mXGY0ltuQcuur8wWF3cVvzkKjXnvrKaWh/hxa8GhisutiQAiDyrQ72AXgATXyq
         xvSxffIvWtOn803gHyb9stQv6OSn5Pbq2o5Fd8Vg8WxvYFNwm6fDGP1p8HJrlq5E3d
         pXzoVdMPmGyvE6rOawnHKA4/bWIF/FSQ0/hnHb6k=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <16576ef1-55a1-5efd-9f0e-1a0d8aa8cada@yandex.ru>
Date:   Fri, 22 Sep 2023 16:53:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: On spatial multiplexing power save in rtlwifi (rtl8192de)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shouldn't 'rtl92de_update_hal_rate_table()' avoid hardcoded 'mimo_ps'
but rather extract it from 'struct rtl_sta_info' like it's done in
'rtl92de_update_hal_rate_mask()'?

Dmitry
