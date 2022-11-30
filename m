Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9563E290
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 22:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiK3VTp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 16:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiK3VTo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 16:19:44 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444BA8B1A3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 13:19:43 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ADD725C018A
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 16:19:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 30 Nov 2022 16:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669843182; x=1669929582; bh=inXZ/uXk27
        HzY0eJdLhVRKWqX76UW9OXbzETCuPuoBA=; b=3BM0xYLuVe2d4/ztstiS/Vitbq
        xPPm1FNZqeGRta0ZVcHoB9lX/wEHdDH5Iyy5ur5hiM2+mcuKNgpvAmi2S0XRsl8g
        jsQOwegBgSzvh35ilaWuzrB/dKFt5g5QZsmgA9kxEapDbqN8EyRFpBm1RfD7dXeo
        A3uVbH/ssVqS1K4e7qoutiOu5w+t7McP7qZHaUBkMSwZ55dVVeuU6fcGmPuoE1Wy
        Kg0TpvIMNPBv2qRofYgVHKizD4abZkZo3tDDi5M+inhiM0qYv1XSHAOpTe7YrztS
        T+Q/EDUg7ATU4yKrDm+iFvBjNLw7ZTxi1o37ZNHe1/Wq9SN45W0z/T9X7d6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669843182; x=1669929582; bh=inXZ/uXk27HzY0eJdLhVRKWqX76U
        W9OXbzETCuPuoBA=; b=ZmQ+FYtW1dzHF8vYibFZ2VgMJrlrNbgdI+VVOa8asw3b
        6O8FBvVHopdnG1y14vLR3Hk0A2kZYXu3bRc799Qhjf1JENi1XP/gzR009wDAw88c
        CrOvQtasGb2PEmoe4eYyGpoZ+XN2GihLgCmdKXeZ+Ir9+oOA4d08xZ+okbFpwd1T
        X6Sl2svUO9hhAiXtY7IN/wtpqRMhhkrMmok2JclwU/5VoZPK8hw0Jv+A5MGjBk8M
        9Wtu2q5/8IlWCURv8ZnFsx8F18VpS35BISeJXp+61HYQl1VZneOGNsi9R5iQB184
        L8c5CYodXgLMYlCVnNmC4Gxg2RtwNwZGjdSQgMeTLg==
X-ME-Sender: <xms:7siHY3JdDyNkd5TiKTvjyc6RbIW62wd7j5kVuVLeT7gEvxUaX5qSDQ>
    <xme:7siHY7JRjQQKgj25hKgR4clAn2K9G5Tfa2Ou4c6UuHSlR49lMkLUbSbTD5OLW__a6
    7D7OOCSqT3JATGM>
X-ME-Received: <xmr:7siHY_sMCourNW6I3MPjs5pD7pDFs1oPFKlAz_1V4AkZU1fE8xeLzy7fhszRG9U_1fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertd
    dtfeejnecuhfhrohhmpeeurhhunhhoucffrghnthgrshcuoegurghnthgrshesrghirhhp
    ohhsthdrnhgvtheqnecuggftrfgrthhtvghrnhepueejteduieetteekiedvffefteeftd
    evgeehleffjedugeffudfhgeegkeefleeunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepuggrnhhtrghssegrihhrphhoshhtrdhnvght
X-ME-Proxy: <xmx:7siHYwZ1OCFPfzUMjCkWITImPxSExFQYhKkuCUYiMqC8hHtGzpekqA>
    <xmx:7siHY-b7-C_pVYCK4SMZjTUNQrKwjjTdkWWX70TSfwbnpQt78GtcUQ>
    <xmx:7siHY0CBQkzPhZ3tLJpzd2Iqd1VLvwoE1HcKX1_yJyUxYubTqIczIQ>
    <xmx:7siHY81IcyjaBhx5mcbakzKlR_pk_TmlaRD5f9-KGqSQm-AW_tU89Q>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 16:19:42 -0500 (EST)
To:     linux-wireless@vger.kernel.org
From:   Bruno Dantas <dantas@airpost.net>
Subject: every other wireless scan shows bogus (too low) signal strengths
Message-ID: <b48efa92-9eee-d491-1149-a7cee08300c0@airpost.net>
Date:   Wed, 30 Nov 2022 16:19:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have an X230 ThinkPad with coreboot and Intel Dual Band Wireless-AC 7265 card, which uses the iwlwifi kernel module. Module's wifi power saving is off (the default setting).

When I scan for wifi hotspots at the command line, every other scan gives me bogus (too low) signal strengths and every other scan gives me expected signal strengths:

bruno@x230:~$ sudo iw dev wlan0 scan flush | grep -e 'signal:' -e 'SSID:' | head -10
	signal: -69.00 dBm
	SSID: donkey_2.4GHz
	signal: -81.00 dBm
	SSID: donkey_5GHz
	signal: -79.00 dBm
	SSID: Spencer
	signal: -80.00 dBm
	SSID: wattslolahome
	signal: -82.00 dBm
	SSID: wattslolahome-guest
bruno@x230:~$ sudo iw dev wlan0 scan flush | grep -e 'signal:' -e 'SSID:' | head -10
	signal: -42.00 dBm
	SSID: donkey_2.4GHz
	signal: -64.00 dBm
	SSID: donkey_5GHz
	signal: -80.00 dBm
	SSID: Spencer
	signal: -80.00 dBm
	SSID: wattslolahome
	signal: -84.00 dBm
	SSID: wattslolahome-guest
bruno@x230:~$ sudo iw dev wlan0 scan flush | grep -e 'signal:' -e 'SSID:' | head -10
	signal: -69.00 dBm
	SSID: donkey_2.4GHz
	signal: -78.00 dBm
	SSID: donkey_5GHz
	signal: -80.00 dBm
	SSID: Spencer
	signal: -80.00 dBm
	SSID: wattslolahome
	signal: -84.00 dBm
	SSID: wattslolahome-guest
bruno@x230:~$ sudo iw dev wlan0 scan flush | grep -e 'signal:' -e 'SSID:' | head -10
	signal: -43.00 dBm
	SSID: donkey_2.4GHz
	signal: -61.00 dBm
	SSID: donkey_5GHz
	signal: -79.00 dBm
	SSID: Spencer
	signal: -80.00 dBm
	SSID: wattslolahome
	signal: -82.00 dBm
	SSID: wattslolahome-guest
etc.

The problem is distro-agnostic (I use Devuan x86_64 and Tiny Core Linux x86_64 and both are affected). Problem is not specific to iw (if I scan with iwlist I see a similar pattern). The pattern is always the same: First scan after a fresh boot is always bad, second one is good, etc. 

Does anyone know why this happens and how to fix it so that every scan shows the expected signal strengths?

