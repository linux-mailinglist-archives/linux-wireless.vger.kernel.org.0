Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF3597A7F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 02:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiHRAHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 20:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiHRAHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 20:07:35 -0400
Received: from hm1480-n-203.locaweb.com.br (hm1480-n-203.locaweb.com.br [189.126.112.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64C5D9A962
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 17:07:32 -0700 (PDT)
Received: from mcbain0014.email.locaweb.com.br (189.126.112.17) by hm1480-1.locaweb.com.br id hvm1bg169rk3 for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 21:07:18 -0300 (envelope-from <cesarb@cesarb.eti.br>)
Received: from proxy.email-ssl.com.br (unknown [10.31.120.232])
        by mcbain0014.email.locaweb.com.br (Postfix) with ESMTP id 4A8D638028D;
        Wed, 17 Aug 2022 21:07:29 -0300 (-03)
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
X-LocaWeb-COR: locaweb_2009_x-mail
X-AuthUser: cesarb@cesarb.eti.br
Received: from [192.168.96.204] (unknown [200.187.114.14])
        (Authenticated sender: cesarb@cesarb.eti.br)
        by proxy.email-ssl.com.br (Postfix) with ESMTPSA id BF1F1440EDD;
        Wed, 17 Aug 2022 21:07:27 -0300 (-03)
Message-ID: <f0b68f02-a95d-93e6-6437-523f360e4eb6@cesarb.eti.br>
Date:   Wed, 17 Aug 2022 21:07:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [wireless-regdb] wireless-regdb: Update regulatory rules for
 Brazil (BR)
Content-Language: en-US
From:   Cesar Eduardo Barros <cesarb@cesarb.eti.br>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <271ca023-d574-7d84-a020-ec5950fb500e@cesarb.eti.br>
In-Reply-To: <271ca023-d574-7d84-a020-ec5950fb500e@cesarb.eti.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Em 17/08/2022 20:31, Cesar Eduardo Barros escreveu:
> For range 5925-7125 MHz (article 11.7), there are different rules for 
> APs, clients, and very low power devices. For APs (article 11.7.1), the 
> maximum EIRP is 30 dBm (article 11.7.1.1), and it's INDOOR-ONLY (article 
> 11.7.1.3); for clients of an indoor AP (article 11.7.2), the maximum 
> EIRP is 24 dBm (article 11.7.2.1), and it's INDOOR-ONLY (article 
> 11.7.2.3); for very low power devices (article 11.7.3), the maximum EIRP 
> is 17 dBm (article 11.7.3.1).

Thinking better about it, I might have miscalculated this one. Since the 
smallest channel we use is 20 MHz, and the EIRP power density for 
clients is limited to -1 dBm/MHz (article 11.7.2.2), if I'm doing the 
calculations correctly the limit for clients would be 12 dBm, that is,

(5925 - 7125 @ 320), (12), NO-OUTDOOR

It's unfortunate that we cannot represent that kind of rule in db.txt, 
and are forced to artificially limit the power by 12 dB (the full power 
of 24 dBm I had calculated would work only for 320 MHz).

I would appreciate if you could look over these power density rules, 
especially the ones which are in dBm/MHz instead of mW/MHz, since I 
might have miscalculated something else.

-- 
Cesar Eduardo Barros
cesarb@cesarb.eti.br
