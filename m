Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49457BA52A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Oct 2023 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbjJEQOF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Oct 2023 12:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240894AbjJEQNL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:11 -0400
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7127B19
        for <linux-wireless@vger.kernel.org>; Thu,  5 Oct 2023 06:38:17 -0700 (PDT)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
        by forward201b.mail.yandex.net (Yandex) with ESMTP id 77DEE4FC75
        for <linux-wireless@vger.kernel.org>; Thu,  5 Oct 2023 16:38:10 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4684:0:640:929e:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id B53906004D;
        Thu,  5 Oct 2023 16:37:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id cbYrC6jDbCg0-kuOQbEHo;
        Thu, 05 Oct 2023 16:37:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696513059; bh=N5VRIPfmv7DozMrS9MGtyXcWM5uVP+7SNgHdNTmB/NQ=;
        h=Subject:From:Cc:To:Date:Message-ID;
        b=mY7HsPn0zUIAUk4w0717/o57kfGNrgVAiorGOrMeigOP6hizEgbxXOn6YV0IPDh2P
         jftfPFo3AjNCWUAatJS6wKOMjicbFQOPTMCs5mGhNPfFXMbWTCzEHt9sbYY7BkcdyY
         xTjO+EW/gNvL02AOWMSOkyjr2I9akjOwFKBVN9OQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
Date:   Thu, 5 Oct 2023 16:37:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: On brcm80211 maintenance and support
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

Kalle,

what's an actual status of brcm80211 driver? It seems
that the relevant MAINTAINERS entries are no longer
useful, and [1] states that Broadcom is just "disappeared".

Dmitry

[1] https://lore.kernel.org/linux-wireless/9a544a1b9385a150f779ac35a780dbb50200a962.camel@sipsolutions.net
