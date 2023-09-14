Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA7E79F9EF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 07:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjINFPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 01:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjINFPv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 01:15:51 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E331BCA
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 22:15:47 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:2481:0:640:e0:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 8797360089;
        Thu, 14 Sep 2023 08:15:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id fFYVPqGDTOs0-O6ZNxOco;
        Thu, 14 Sep 2023 08:15:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1694668542; bh=ox8S0AYBWW2vIsLEAJrgWtPvQJNpgJyGEPJ1NUjciHo=;
        h=Subject:From:Cc:To:Date:Message-ID;
        b=Lty76Epb2apKoBTQgFhWLobldjUD3msG7fyvF7qCxeCAkz9Tpv8TyDrYSrQa9k/KE
         buwexGnydGTRmWH1/J8KH5z9DGs4whOhmVzTwvfQjIIix+OcvGDdWADku1V+LGDTgP
         j482wHpKHAfJsE0wkIBj3DEf/zXNamUl7LPEoeqg=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <9485af8e-3379-f592-0e8f-0eaebf4fbc05@yandex.ru>
Date:   Thu, 14 Sep 2023 08:15:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: On status handling in ath10k_htt_rx_tx_compl_ind()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'ath10k_htt_rx_tx_compl_ind()',

int status = MS(resp->data_tx_completion.flags, HTT_DATA_TX_STATUS);

actually is

int status = (((resp->data_tx_completion.flags) & 0x07) >> 0);

which can't be equal to HTT_DATA_TX_STATUS_DOWNLOAD_FAIL (128)
regardless of the 'data_tx_completion.flags' value. This is most
likely a weird (but I have no clue how serious it may be) bug.

Dmitry
