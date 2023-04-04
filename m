Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25406D686F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjDDQJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjDDQJM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 12:09:12 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B954685;
        Tue,  4 Apr 2023 09:09:09 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 50FA12003B4;
        Tue,  4 Apr 2023 18:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1680624548;
        bh=m4kLlVdfx4CPshc3rsvvK75Jls1tGv0nt9joXO6qw+0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WtFGeqKJRt410YiomYnRep3xygMlOdQLzsmxsRiOfYEYEanEvkvQiCrPDtR9mJVV+
         Bxf5573yX/Tar0WRz87MotbJdGFOpT2ZXQfGIkmiZPlp8LswiRRtD25X81vvE2ZNLM
         lVEb5vhxlJut/rmBcMufp4OCRdWhGq2phrQDYueyNyOw8N+KhNm+Guh7pOQ+xxDZU/
         U5U2To6IYgcetbe4q53zxjST+f6bnfnbtYu4k3AGUxURvuERHtV101QzOiSVmsVP/S
         0cQM8idCEmwLgcS6CdoA3CisrCxmfhoZqBv4zpliW6dWOqt/kyKmtA59Iv0iQ20TK5
         0EBJT4Iu7FAGQ==
Message-ID: <0bb1e3b3-6823-ddb5-001b-72ee1b63779c@free.fr>
Date:   Tue, 4 Apr 2023 18:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Performance regression] BCM4359/9 on S905X2
Content-Language: en-US
To:     Christian Hewitt <christian@hewittfamily.org.uk>
Cc:     Linux Wireless <linux-wireless@vger.kernel.org>,
        MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pierre-Hugues Husson <phh@phh.me>
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
 <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
 <EEE9FD80-C106-4A9B-AA8D-5C151E540CFD@hewittfamily.org.uk>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <EEE9FD80-C106-4A9B-AA8D-5C151E540CFD@hewittfamily.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[ Trimming recipients list ]

On 21/03/2023 13:26, Christian Hewitt wrote:

> To Jerôme's point; unless you've tweaked it upstream will be running
> at 100MHz and the vendor kernel will be 200MHz, and maybe with other
> high-speed modes activated.

As far as I could tell:

For mainline, arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts

	bus-width = <4>;
	cap-sd-highspeed;
	sd-uhs-sdr50;
	max-frequency = <100000000>;

For vendor, common/arch/arm64/boot/dts/amlogic/mesong12a_sei.dtsi

		bus-width = <4>;
		cap-sd-highspeed;
		cap-mmc-highspeed;
		max-frequency = <100000000>;

vendor DTS has the following child node:

		sdio {
			pinname = "sdio";
			ocr_avail = <0x200080>; /**VDD voltage 3.3 ~ 3.4 */
			/* max_req_size = <0x20000>; */ /**128KB*/
			max_req_size = <0x400>;
			card_type = <3>;
			/* 3:sdio device(ie:sdio-wifi),
			 * 4:SD combo (IO+mem) card
			 */
			dmode = "pio";
		};

Maybe the vendor kernel uses the above information to "boost"
the performance of the SDIO-based WiFi adapter?

> Most upstream device-trees are running a
> conservative/safe configuration at 50MHz to avoid past speed-related
> issues. As stability has improved over time most boards could be run
> at faster speeds, but 'performance' is such subjective topic that it
> would probably need a large amount of testing to convince people to
> change the current defaults. That said (FWIW) I've bumped all boards
> in my tree that consume the gx-p2xx-q2xx dtsi to 100MHz without any
> attributable issues being flagged by users.

