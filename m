Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B969B6C31D0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 13:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCUMiR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCUMiP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 08:38:15 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B934481;
        Tue, 21 Mar 2023 05:38:04 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 20C1B200410;
        Tue, 21 Mar 2023 13:37:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1679402282;
        bh=ayjhC2BQbFfTl1beiJuuMQv5sxjmgYk/0tf5p8b9j6w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XQYu/zDw/QM4lEqMWZJqO06dILPiNz57BlD6PhZT+iRSxi/S5ZOsNttxSsPUPc0Dl
         PKsz2R6kOuTNFU2spJ6v35Hsao9DYOBXz+3OH6T1+K7Mb1g5tL3Bd84fIsxNvzG5hS
         0NSDwh3MIgCn8qt/0afWl+7YhXB0uhZ00Ut4M6FsNRndcsOg2zblL3MopRR2NTJvxg
         IHL/J+8NTvmNgCGkunFRlQkK7x6hqmDJJ+wFwpomMAPfhGtqZ7vwU6DYuprwXnzFNe
         8nqcoe9PDphcKclH/guELoHOG88DC23na0ete6Byx66yrUkTNoPmtZ8MwjB2ZluzNh
         zTI9GoSsLW60g==
Message-ID: <ce0bd9a5-e44d-b30b-3434-9d5fd36e251a@free.fr>
Date:   Tue, 21 Mar 2023 13:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Performance lower than expected with BCM4359/9 on S905X2
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-wireless@vger.kernel.org, MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Pierre-Hugues Husson <phh@phh.me>
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
 <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21/03/2023 11:46, Jerome Brunet wrote:

> On Tue 21 Mar 2023 at 11:40, Marc Gonzalez wrote:
> 
>> I've been benchmarking an Amlogic S905X2 board.
>> It provides a BCM4359/9 WiFi chip connected through SDIO.
>>
>> There's a large performance gap between vendor kernel and mainline.
>> (Downloading a 1GB file to /dev/null from a device inches away)
> 
> The title is misleading. You are comparing different sources. This is
> not a regression. This is merely a difference.

I have changed the subject line to a (hopefully) more accurate one.

> If we are talking about mainline, then which board is it ? What is the
> corresponding DT ? What is the MMC configuration in both case ? Have
> you checked you are running with the same clock configuration to begin
> with ?

Perhaps my initial request was unclear, my apologies.

I was asking whether anyone using any S905X2 board had noticed
such a performance discrepancy. (Neil seems to have provided
a full explanation for the situation.)

For what it's worth, I'm using an sei530 board, which appears
to be a minor variant of the sei510 (down to the schematics).

>> # curl -o /dev/null http://192.168.1.254:8095/fixed/1G
>>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>>                                  Dload  Upload   Total   Spent    Left  Speed
>> 100 1024M  100 1024M    0     0  27.5M      0  0:00:37  0:00:37 --:--:-- 28.6M
>> vs
>> 100 1024M  100 1024M    0     0  11.0M      0  0:01:32  0:01:32 --:--:-- 11.0M
>>
>> Line 1 = vendor kernel (4.9.180 amlogic android)
> 
> This cannot help identify a downstream kernel, and the infinite number
> of forks and patches associated with it.

I was not asking anyone to reproduce my exact setup.

I find it confusing that some assume there is something different
about the board I'm using. The more likely hypothesis is that all
S905X2 boards have the same behavior.

Regards

