Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ADC545F7C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347987AbiFJImN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347922AbiFJImJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 04:42:09 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEBA19FB4
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 01:42:06 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1654850524; bh=nbEIlIiU3mAbr1EqNtojKb6UhIN08z+QXcOPjceALwU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=loTD0bggCah9ORNH01g7RYF8L5/MFpIxDZFFoXqTZQ+Zcw2qkvbFk+uLMKcgxd4OQ
         H3Fjj1xFC7rmL9xtWFrXB5vwAxo22vWbwbzejpC2X/4mNBDujbMBVoYjSsnq4N8MID
         TO0rs4decLwtOk2F6HF3ry1F6Y7mCHkrdTLTINTc11wm/Lv/JLkRZFetM1ZRdFSVkN
         KUXkWu6QycTqOX/iNWX/K2VVX63KYqKCHW6FaeDRaX/sxEX3/euafhDXhImFKPH5SD
         tlrwKZmssThHEgk1/pyFltfqfFrvOqimoHbkq8XXXnREbThzK8EWROF62sIJoN2xPf
         n6/fFbLIgfpSQ==
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] dt-bindings: net: wireless: change Kalle's email
In-Reply-To: <87y1y5q6v8.fsf@kernel.org>
References: <20220610075944.23787-1-kvalo@kernel.org>
 <87y1y5q6v8.fsf@kernel.org>
Date:   Fri, 10 Jun 2022 10:42:04 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87k09o52qr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> My codeaurora.org email doesn't work anymore, so switch to my preferred
>> kernel.org address.
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>
> [...]
>
>> --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  title: Qualcomm Atheros ath9k wireless devices Generic Binding
>>  
>>  maintainers:
>> -  - Kalle Valo <kvalo@codeaurora.org>
>> +  - Kalle Valo <kvalo@kernel.org>
>
> Oh, I didn't notice this is ath9k. Toke, can I change it to your
> address?

Sure!

-Toke
