Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB97C6E15E0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 22:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDMUcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDMUcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 16:32:04 -0400
X-Greylist: delayed 404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 13:32:02 PDT
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F45D1999
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 13:32:02 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2faa:0:640:7793:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 0E66F5F0AB;
        Thu, 13 Apr 2023 23:25:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id DPe7UZ7DfGk0-gp1uXjq1;
        Thu, 13 Apr 2023 23:25:13 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass
Message-ID: <000cae34-88be-9ac1-84c3-d7d0e6748b18@16depo.xyz>
Date:   Thu, 13 Apr 2023 23:25:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [wireless-regdb] [PATCH] Update regulatory info for Russia (RU)
 on 6GHz
Content-Language: en-US
From:   Kirill <me@16depo.xyz>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
In-Reply-To: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, Seth. Is patch for activation of 6GHz are good? Do i need to 
provide some additional links?

On 25.03.2023 04:04, Kirill wrote:
> Update regulatory info for Russia on 6GHz in
>  accordance with current regulatory rules.
>
> Source: https://docs.cntd.ru/document/1300597464?section=text
>
> Signed-off-by: Kirill Matvienko <me@16depo.xyz>
> ---
>  db.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/db.txt b/db.txt
> index 915a3b9..7f338b2 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1500,11 +1500,12 @@ country RS: DFS-ETSI
>      # 60 GHz band channels 1-4, ref: Etsi En 302 567
>      (57000 - 66000 @ 2160), (40)
>
> -# Source: https://docs.cntd.ru/document/902048009?section=text
> +# Source: https://docs.cntd.ru/document/1300597464?section=text
>  country RU: DFS-ETSI
>      (2400 - 2483.5 @ 40), (20)
>      (5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, DFS
>      (5650 - 5850 @ 160), (100 mW), NO-OUTDOOR, DFS
> +    (5925 - 6425 @ 160), (100 mW), NO-OUTDOOR
>      # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order 
> №129_22042015.pdf
>      (57000 - 66000 @ 2160), (40), NO-OUTDOOR
>
