Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25C95A6613
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 16:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiH3OTE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiH3OTD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 10:19:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA2AB411
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 07:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8884FB81C34
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 14:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ED1C433D6;
        Tue, 30 Aug 2022 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661869135;
        bh=C3esRepSdKPVLp+qFdnCtkoF1ceUqUwHJFtoqwlOh2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4hM+maTbt9et8J54Is9MKHF46kB1xzKYQI/vtMRAxRl4D72Suk6qZ20m7/EAt8tj
         pb2PGX5PTNzvyLeAe6HgF6PaVUFcEKwknU5VIzNVRwWoiAWGJCmikr0DEsC/JyelU+
         YwOqGuzTVZTd5EhXCM7GTS+2rK68B583cqtmG9iroM83w8Qu3XMbplK1gg49Myt73B
         YTgB63E/lg6Jkn3K/CYMXieWAzXghEiUTD80I3hsZqjGPMQjACYCSKuyR/8ATEGlib
         bMBl7Xm1CHohzsvkLyxjaQA7AT5IWjV+GDaBJHkR5N5Cp2rTxzNUYJ4wmILCmIfE8o
         dU0YYHt2YkNQg==
Date:   Tue, 30 Aug 2022 09:18:54 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] wireless-regdb: Update regulatory rules for
 Brazil (BR)
Message-ID: <Yw4cTotCZm7CH/v7@ubuntu-x1>
References: <271ca023-d574-7d84-a020-ec5950fb500e@cesarb.eti.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271ca023-d574-7d84-a020-ec5950fb500e@cesarb.eti.br>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 17, 2022 at 08:31:56PM -0300, Cesar Eduardo Barros wrote:
> The wireless-regdb rules for Brazil in wireless-regdb have no comment
> indicating where they came from, and haven't been updated in a long time.
> There have been some changes to the legislation since then, including the
> addition of the 6 GHz and 60 GHz ranges.
> 
> The relevant legislation can be found in the following three URLs, mostly
> the last one:
> 
> https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
> 
> https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
> 
> https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448

Thanks for the information, and sorry for the slow response. I have
limited time to review changes, and this one took a while.

I provide more detailed responses below, but in general I think your
suggested changes look correct.

> In the last one, the relevant articles are:
> 
> * Article 10 is the classic wireless ranges (2.4 GHz, and 5 GHz channels 149
> to 165), and the 900 MHz ranges
> * Article 11 is the extended 5 GHz and 6 GHz ranges
> * Article 22 is the vehicular (V2X) ranges
> * Article 23 is the 60 GHz ranges
> 
> 
> Here follows my interpretation of these rules from a wireless-regdb point of
> view, with the relevant article number in parenthesis:
> 
> Other than the article 22 range (5850-5925 MHz), these rules don't mention a
> max channel width, so VHT160 or even larger would be allowed in all ranges
> except 5850-5925 MHz.
> 
> For ranges 902-907.5 MHz, 915-928 MHz, 2400-2483.5 MHz, and 5725-5850 MHz
> (article 10.1), the maximum power output in the transmitter is 1 W (30 dBm,
> article 10.3.2), and the maximum antenna gain is 6 dBi (article 10.5).

Seems right.

> For range 5150-5250 MHz (article 11.1), the maximum EIRP would be 4 W (36
> dBm, article 11.1.1), but since the smallest channel size we use in this
> range is 20 MHz, and the maximum EIRP spectral density is 50 mW/MHz (17
> dBm/MHz, article 11.1.2), the maximum EIRP is 1 W (30 dBm); this range is
> INDOOR-ONLY (article 11.1.3), and requires either TPC (article 11.5) or a
> reduction of 3 dB (article 11.5.1).

This also seems right.

> For range 5250-5350 MHz (article 11.1), the maximum EIRP is 1 W (30 dBm,
> article 11.1.1); this range is INDOOR-ONLY (article 11.1.3), requires either
> TPC (article 11.5) or a reduction of 3 dB (article 11.5.1), and requires DFS
> (article 11.6).

Correct.

> For range 5470-5725 MHz (article 11.3), the maximum power output in the
> transmitter is 250 mW (24 dBm, article 11.3.1), the maximum EIRP is 1 W (30
> dBm, article 11.3.2), requires either TPC (article 11.5) or a reduction of 3
> dB (article 11.5.1), and requires DFS (article 11.6).

Correct.

> For range 5925-7125 MHz (article 11.7), there are different rules for APs,
> clients, and very low power devices. For APs (article 11.7.1), the maximum
> EIRP is 30 dBm (article 11.7.1.1), and it's INDOOR-ONLY (article 11.7.1.3);
> for clients of an indoor AP (article 11.7.2), the maximum EIRP is 24 dBm
> (article 11.7.2.1), and it's INDOOR-ONLY (article 11.7.2.3); for very low
> power devices (article 11.7.3), the maximum EIRP is 17 dBm (article
> 11.7.3.1).

Right, so in this case it's possible to use either 24 dBm, NO-OUTDOOR or
17 dBm and allow outdoor use. We've used the higher, indoor-only rule in
the past. But as you note in your replies there is a PSD limit for
clients which limits power to 12 dBm (since PSD limits are not currently
supported) and it needs NO-IR.

> For vehicular range 5850-5925 MHz (article 22.1), the base channel width is
> 10 MHz but they can be aggregated (article 22.1.1), the maximum EIRP is 23
> dBm (200 mW, article 22.2), and it requires TPC (article 22.3).

Looking at the documents you provided and [1], the only allowed use of
this range is for vehicle communication systems and not for WLAN. Unless
I missed something, I think this range should be left out of the
database.

[1] https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2020/1467-ato-4776

> For range 57-71 GHz (article 23.1), the maximum EIRP is 40 dBm (article
> 23.1.1) with maximum peak 43 dBm (article 23.1.2).

Correct.

> I'm unsure as how to correctly represent the rules with a maximum antenna
> gain in wireless-regdb. My best guess as to how these rules would be
> represented in wireless-regdb, based on the US rules which have some
> similar-looking ranges and power limits, would be (ignoring for now the 900
> MHz and vehicular ranges, since I'm unsure about their correct channel
> widths):
> 
> # Source:
> # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
> # https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
> # https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
> country BR: DFS-FCC
> 	#(902 - 907.5 @ ???), (30)
> 	#(915 - 928 @ ???), (30)

For these ranges I think you should use the same bandwidth as other
rules in the database, i.e. 2 and 16 MHz.

> 	(2400 - 2483.5 @ 40), (30)
> 	# The next three ranges have been reduced by 3dB, could be increased back
> to 30dBm if TPC is implemented.
> 	(5150 - 5250 @ 80), (27), NO-OUTDOOR, AUTO-BW
> 	(5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
> 	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
> 	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
> 	# requirements, we can extend the range by 5 MHz to make the kernel
> 	# happy and be able to use channel 144.
> 	(5470 - 5730 @ 160), (27), DFS
> 	(5730 - 5850 @ 80), (30)
> 	# This range requires TPC.
> 	#(5850 - 5925 @ ???), (20)

This rule should be omitted.

> 	# AP 30dBm, client 24dBm
> 	(5925 - 7125 @ 320), (24), NO-OUTDOOR

This range needs the adjustments from your later emails.

> 	# EIRP=40dBm (43dBm peak)
> 	(57000 - 71000 @ 2160), (40)

Otherwise I think these changes look good. If you can send a patch with
the changes I would appreciate it, otherwise let me know and I can send
a patch.

Thanks,
Seth

> On a quick look, the result looks sane and makes sense to me: 1 W (30 dBm)
> everywhere, reduced by 3 dB on the DFS channels since TPC isn't implemented;
> for 6 GHz the client is reduced by 6 dB, which is also the case at least on
> the US rules according to the comment there; and 60 GHz seems to follow
> everyone else in using 40 dBm.
> 
> -- 
> Cesar Eduardo Barros
> cesarb@cesarb.eti.br
> 
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
