Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEBF75EE8A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGXI5Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjGXI5W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 04:57:22 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B23E7
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 01:57:15 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3faf:0:640:537b:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id 518725E748;
        Mon, 24 Jul 2023 11:57:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CvEKCdRWvW20-aYKosYZw;
        Mon, 24 Jul 2023 11:57:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690189032;
        bh=/EFQrrjbmw4lsyjn1bSXVPiLEIzh543F/yTao0mOqHs=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=p8zwMbKDipCb9V5tftp+0/yrNj3yaX92FidtNvqg61EexO84syctvqt9O2nE+HdDu
         8aoacUUgQ08tbTUdpK+/ksTTgPgm7sGJcufR+E0BKXoTMmPrlKB99/Q+xNMx6NX4wK
         +5PS87W2oZSRocGNBp4kjHzntkayNXWXrW4AgBiQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <ae49815a-c125-5a22-6757-b526d9712103@yandex.ru>
Date:   Mon, 24 Jul 2023 11:57:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] wifi: libertas: add missing calls to
 cancel_work_sync()
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Doug Brown <doug@schmorgal.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230724084457.64995-1-dmantipov@yandex.ru>
 <87cz0h3d1q.fsf@kernel.org>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <87cz0h3d1q.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/24/23 11:54, Kalle Valo wrote:

> 
> How have you tested these patches?
> 

No physical hardware so compile tested only.

Dmitry

