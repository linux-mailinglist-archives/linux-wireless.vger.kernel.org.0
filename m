Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1547B23BF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjI1RWh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjI1RWh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 13:22:37 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A841AA
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 10:22:33 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3d80:0:640:1395:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id A18FF6041D;
        Thu, 28 Sep 2023 20:22:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id TMVMXK3uACg0-tJO1bq20;
        Thu, 28 Sep 2023 20:22:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695921750; bh=CKSzaldp3JpbeHm6oJmpWRnYA1nkbH6WLJrRWMqn9a0=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=Rfsd10zjlGJIy2ELEXaJMIPG4c/5/r/KMGnEh8fvMb3D60/Zmf5TwRNVTQlC6qX3u
         WWl/a1FfKTkumJXV1VBYKxHiEVgjYgwFb2QG8TPHJdQpWF97Y2SlaS++BMG2uU0Q7K
         swJO2O02ipVwD3+XTdvgQlbxO3P5Fky1FETS1rE4=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <30d83337-1311-19e8-47f2-391c5e5bd8bd@yandex.ru>
Date:   Thu, 28 Sep 2023 20:22:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath11k: drop NULL pointer check in
 ath11k_dp_rx_mon_dest_process()
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath11k@lists.infradead.org
References: <20230907083852.10775-1-dmantipov@yandex.ru>
 <169591601112.3096214.11174520645995155662.kvalo@kernel.org>
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <169591601112.3096214.11174520645995155662.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/28/23 18:46, Kalle Valo wrote:

> Patch set to Changes Requested.

Probably I miss something around your internal ath-specific workflow
but AFAICS this fix is not needed for ath-next branch of ath.git
(there is no redundant NULL pointer check there).

Dmitry


