Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BC972F405
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 07:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbjFNFOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 01:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjFNFON (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 01:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4C71A3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 22:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72A03637DA
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 05:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAFAC433C0;
        Wed, 14 Jun 2023 05:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686719651;
        bh=qOFPuW1TZIxflNqTXTJeY4nfkvbya/95RQmiLoMP568=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AfcxaBacICEKhGfoARI+Vhwhwwx1c0EJJBmgAfWgfVyvKPW9qnLsxCgQQA1eDkZrT
         AmVvwOPetk6GghXB9eWcLGnTZ7OQAO4CBPU1qhcSIWhD1iK34bEvM/EEOm1AW5EmMk
         m0mqgg2dYuQcv+AgquU39hW5FnfknnEWBr2gNiKQ62iIa9c3ZMFUrMy1CqhW8uLIh4
         5+L2iKkbyUXH4Dr5qbs15b2DKZ4KSAHW0pGcxbgG3WmwNXMooza35lrnZEwiwBkggk
         Kphd/DOzPpBQQ3v1XyJb4CbFnAMbZqzlMpaTACY5sCWZ7xSjLeV1frE8kVE81EORqk
         Pf2Bzt8dGfcSw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: convert msecs to jiffies where needed
References: <20230613134655.248728-1-dmantipov@yandex.ru>
        <87y1knw7ng.fsf@toke.dk>
Date:   Wed, 14 Jun 2023 08:14:08 +0300
In-Reply-To: <87y1knw7ng.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Tue, 13 Jun 2023 20:15:31 +0200")
Message-ID: <87pm5yd3rz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Dmitry Antipov <dmantipov@yandex.ru> writes:
>
>> Since 'ieee80211_queue_delayed_work()' expects timeout in
>> jiffies and not milliseconds, 'msecs_to_jiffies()' should
>> be used in 'ath_restart_work()' and '__ath9k_flush()'.
>>
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>
> I believe this warrants a:
>
> Fixes: d63ffc45c5d3 ("ath9k: rename tx_complete_work to hw_check_work")

I can add that.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
