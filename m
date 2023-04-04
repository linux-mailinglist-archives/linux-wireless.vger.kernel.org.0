Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110456D67C5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjDDPnH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 11:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjDDPnC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 11:43:02 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B738448F
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 08:42:44 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 65C4A20041F;
        Tue,  4 Apr 2023 17:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1680622950;
        bh=HItSdPUax6WKV/Lpedrt10334waYiJbsMWf9mWy6eSY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=m44J8b57Oo06NoK3IMh15caYJJOAxxx4cQcKDiWpTL70GfjsMa5jrwvTXXhdGAqY+
         eci25GJkpO+8AaJ7g2/SgO7N8sAq0V3RqwihJgJzlfBXRPkU/ORdD2Q0n1jgByBSQg
         0RgNmJmvJrm+vFKRXkoes33J/MKjO0JXAd4BiQP6ECkY8bngOybvunPw4FB8E303yq
         xqbdnYPyTStu8ZD16AxY+BXrCH87EDWdnBjZoVj6oi7gPNJjIVq7Lg+PoloZJUGVRM
         5z5rY6cHBPve60ZPGVuzL+vQ6+tpEPhEt+EyLrAG/d/ebXb6NuRNmH8DKEUikmU0v3
         j0jpYV3gS+w4w==
Message-ID: <620b5ce8-8c87-5b45-2389-3eb99e15b8cd@free.fr>
Date:   Tue, 4 Apr 2023 17:42:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Throughput & CPU usage of WiFi download
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     linux-amlogic@lists.infradead.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Arnaud Vrac <avrac@freebox.fr>
References: <cbbd4a70-850d-cd1e-9809-1d115378fe09@free.fr>
 <f2344e2e-2b53-9f57-d15a-25e5b03b3029@free.fr>
In-Reply-To: <f2344e2e-2b53-9f57-d15a-25e5b03b3029@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 04/04/2023 14:54, Marc Gonzalez wrote:

> 2) SDIO is clocked higher on vendor system, but could
> lead to instabilities on some boards?

Apparently, I remembered wrong.

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

The vendor DTS has the following child node:

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


Thus, it seems that the performance delta comes from driver architecture
and different HW setup, rather than clock difference.

Regards

