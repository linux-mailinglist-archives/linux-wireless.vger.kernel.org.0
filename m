Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0977680041
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Jan 2023 17:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjA2Qii (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Jan 2023 11:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjA2Qih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Jan 2023 11:38:37 -0500
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7D51027E
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 08:38:35 -0800 (PST)
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:38956 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps  (TLS1) tls TLS_DHE_RSA_WITH_AES_256_CBC_SHA
        (Exim 4.96)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1pMAhL-0003ly-2x;
        Sun, 29 Jan 2023 17:38:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID; bh=EDuGK5DRPV6olilbrnUjkFBePslkJenv16XEfIKygL0=;
        b=JXsEnExx30obKYc1OH5whi8cTAFrf/nMUmq8f5bogDBiO5cXZlFjmhg/c2JkI2grrM1rRbvAduqxC8XyQfh+LFl/ee+bdVFUoQ+XEqFxh9CH4MjG+1fdGLTHkFJJi01hahHsvVjNwx5oFKwJR907gSjkNJlW7irG7ZDPGmueJQk=;
Message-ID: <2efd8b66-9e0e-f907-7daa-93bed9f2a723@newmedia-net.de>
Date:   Sun, 29 Jan 2023 17:38:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:110.0) Gecko/20100101
 Thunderbird/110.0
Subject: Re: wireless-regdb: Regulatory rules for Russia (RU) on 5GHz
To:     Eugene Konev <uejikov@gmail.com>,
        wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <CAO7DJoDCV_NnKqR==GYmtFnMdJrbEvz7UzTQjydWPs4RnaCkpQ@mail.gmail.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
In-Reply-To: <CAO7DJoDCV_NnKqR==GYmtFnMdJrbEvz7UzTQjydWPs4RnaCkpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [81.201.155.134] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1pMAhL-000B3c-Ns; Sun, 29 Jan 2023 17:38:31 +0100
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

russia is ETSI. yes and TPC is always combined with DFS

Am 29.01.2023 um 11:16 schrieb Eugene Konev:
> Current regulatory rules for using 5GHz bands in Russia are the following:
> 5150-5350 MHz: Max EIRP spectral density 20 mW/MHz, max EIRP 200 mWt,
> indoor use only, automatic transmit power control.
> 5650-5850 MHz: Max EIRP spectral density 20 mW/MHz, max EIRP 200 mW,
> indoor use only, automatic transmit power control.
> (rules in russian: https://docs.cntd.ru/document/902048009?section=text)
>
> Does automatic transmit power control requirement means that DFS
> should be enabled on both bands? If so, which DFS region should be
> assigned? DFS-ETSI?
>
