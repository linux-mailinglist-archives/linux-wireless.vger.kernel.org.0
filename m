Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7917B73F773
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 10:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjF0Ifo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjF0Ifd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 04:35:33 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F05B8
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 01:35:30 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1380:0:640:6985:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id CCE96600DC;
        Tue, 27 Jun 2023 11:35:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id RZGYc36WrOs0-vvuISYYa;
        Tue, 27 Jun 2023 11:35:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687854927;
        bh=hakL7BjN+BcGr7YlsiDRREnVAT8x3VowUe+Fkt4Ncr0=;
        h=Subject:From:Cc:To:Date:Message-ID;
        b=TRJQmjVdeQNFxKUe31/Tfj2bIYFSqQ6mJSOQbPlOvAf6iqszxLCuarfjE3ayE6hzp
         vOY/Mycp3wDBovRL8OlC561iSDxj3klkiW5DPq0+GWDyXpBVSSDe4B3BBKWr+YgmHX
         XorMc0hFXJhSUH+uPmZLMsxNeUxqbOo7wNN5QjHM=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <bc4cb44d-4c8a-f672-b82d-0ae601bb04ff@yandex.ru>
Date:   Tue, 27 Jun 2023 11:35:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: On CORDIC arithmetic in b43
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To everyone still interested in b43 driver:

In 'lpphy_start_tx_tone()', how 'CORDIC_FLOAT((sample.i * max) & 0xFF)' may
be non-zero? Basically it is (<32-bit> & 0xff) shifted right by 15 bits.

Dmitry
