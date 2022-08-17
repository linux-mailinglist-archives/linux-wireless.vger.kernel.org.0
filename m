Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3737597A71
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 02:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242201AbiHRAAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 20:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbiHRAAZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 20:00:25 -0400
X-Greylist: delayed 1388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Aug 2022 17:00:19 PDT
Received: from hm1481-46.locaweb.com.br (hm1481-46.locaweb.com.br [189.126.112.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECCC396FC2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 17:00:19 -0700 (PDT)
Received: from mcbain0006.email.locaweb.com.br (189.126.112.72) by hm1481.locaweb.com.br id hvm0gg2n8lg0 for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 20:36:57 -0300 (envelope-from <cesarb@cesarb.eti.br>)
Received: from proxy.email-ssl.com.br (unknown [10.31.120.232])
        by mcbain0006.email.locaweb.com.br (Postfix) with ESMTP id 07CFB6C023E;
        Wed, 17 Aug 2022 20:30:55 -0300 (-03)
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtshNbNEFEr50bJd7dBHU4DI0-ihG9l-wm_qzOmHE6FhA6NUhNRdIbGKKronYtwwdhjaiVaRxzmjoZmIuLaaVDIwjYdIW-u3xzi3rsrIv4KYw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
X-LocaWeb-COR: locaweb_2009_x-mail
X-AuthUser: cesarb@cesarb.eti.br
Received: from [192.168.96.204] (unknown [200.187.114.14])
        (Authenticated sender: cesarb@cesarb.eti.br)
        by proxy.email-ssl.com.br (Postfix) with ESMTPSA id EFE0D440E83;
        Wed, 17 Aug 2022 20:31:56 -0300 (-03)
Message-ID: <271ca023-d574-7d84-a020-ec5950fb500e@cesarb.eti.br>
Date:   Wed, 17 Aug 2022 20:31:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
From:   Cesar Eduardo Barros <cesarb@cesarb.eti.br>
Subject: wireless-regdb: Update regulatory rules for Brazil (BR)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The wireless-regdb rules for Brazil in wireless-regdb have no comment 
indicating where they came from, and haven't been updated in a long 
time. There have been some changes to the legislation since then, 
including the addition of the 6 GHz and 60 GHz ranges.

The relevant legislation can be found in the following three URLs, 
mostly the last one:

https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita

https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680

https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448

In the last one, the relevant articles are:

* Article 10 is the classic wireless ranges (2.4 GHz, and 5 GHz channels 
149 to 165), and the 900 MHz ranges
* Article 11 is the extended 5 GHz and 6 GHz ranges
* Article 22 is the vehicular (V2X) ranges
* Article 23 is the 60 GHz ranges


Here follows my interpretation of these rules from a wireless-regdb 
point of view, with the relevant article number in parenthesis:

Other than the article 22 range (5850-5925 MHz), these rules don't 
mention a max channel width, so VHT160 or even larger would be allowed 
in all ranges except 5850-5925 MHz.

For ranges 902-907.5 MHz, 915-928 MHz, 2400-2483.5 MHz, and 5725-5850 
MHz (article 10.1), the maximum power output in the transmitter is 1 W 
(30 dBm, article 10.3.2), and the maximum antenna gain is 6 dBi (article 
10.5).

For range 5150-5250 MHz (article 11.1), the maximum EIRP would be 4 W 
(36 dBm, article 11.1.1), but since the smallest channel size we use in 
this range is 20 MHz, and the maximum EIRP spectral density is 50 mW/MHz 
(17 dBm/MHz, article 11.1.2), the maximum EIRP is 1 W (30 dBm); this 
range is INDOOR-ONLY (article 11.1.3), and requires either TPC (article 
11.5) or a reduction of 3 dB (article 11.5.1).

For range 5250-5350 MHz (article 11.1), the maximum EIRP is 1 W (30 dBm, 
article 11.1.1); this range is INDOOR-ONLY (article 11.1.3), requires 
either TPC (article 11.5) or a reduction of 3 dB (article 11.5.1), and 
requires DFS (article 11.6).

For range 5470-5725 MHz (article 11.3), the maximum power output in the 
transmitter is 250 mW (24 dBm, article 11.3.1), the maximum EIRP is 1 W 
(30 dBm, article 11.3.2), requires either TPC (article 11.5) or a 
reduction of 3 dB (article 11.5.1), and requires DFS (article 11.6).

For range 5925-7125 MHz (article 11.7), there are different rules for 
APs, clients, and very low power devices. For APs (article 11.7.1), the 
maximum EIRP is 30 dBm (article 11.7.1.1), and it's INDOOR-ONLY (article 
11.7.1.3); for clients of an indoor AP (article 11.7.2), the maximum 
EIRP is 24 dBm (article 11.7.2.1), and it's INDOOR-ONLY (article 
11.7.2.3); for very low power devices (article 11.7.3), the maximum EIRP 
is 17 dBm (article 11.7.3.1).

For vehicular range 5850-5925 MHz (article 22.1), the base channel width 
is 10 MHz but they can be aggregated (article 22.1.1), the maximum EIRP 
is 23 dBm (200 mW, article 22.2), and it requires TPC (article 22.3).

For range 57-71 GHz (article 23.1), the maximum EIRP is 40 dBm (article 
23.1.1) with maximum peak 43 dBm (article 23.1.2).


I'm unsure as how to correctly represent the rules with a maximum 
antenna gain in wireless-regdb. My best guess as to how these rules 
would be represented in wireless-regdb, based on the US rules which have 
some similar-looking ranges and power limits, would be (ignoring for now 
the 900 MHz and vehicular ranges, since I'm unsure about their correct 
channel widths):

# Source:
# https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
# 
https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
# 
https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
country BR: DFS-FCC
	#(902 - 907.5 @ ???), (30)
	#(915 - 928 @ ???), (30)
	(2400 - 2483.5 @ 40), (30)
	# The next three ranges have been reduced by 3dB, could be increased 
back to 30dBm if TPC is implemented.
	(5150 - 5250 @ 80), (27), NO-OUTDOOR, AUTO-BW
	(5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
	# requirements, we can extend the range by 5 MHz to make the kernel
	# happy and be able to use channel 144.
	(5470 - 5730 @ 160), (27), DFS
	(5730 - 5850 @ 80), (30)
	# This range requires TPC.
	#(5850 - 5925 @ ???), (20)
	# AP 30dBm, client 24dBm
	(5925 - 7125 @ 320), (24), NO-OUTDOOR
	# EIRP=40dBm (43dBm peak)
	(57000 - 71000 @ 2160), (40)

On a quick look, the result looks sane and makes sense to me: 1 W (30 
dBm) everywhere, reduced by 3 dB on the DFS channels since TPC isn't 
implemented; for 6 GHz the client is reduced by 6 dB, which is also the 
case at least on the US rules according to the comment there; and 60 GHz 
seems to follow everyone else in using 40 dBm.

-- 
Cesar Eduardo Barros
cesarb@cesarb.eti.br
