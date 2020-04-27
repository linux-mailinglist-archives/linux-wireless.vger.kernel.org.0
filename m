Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CC91B9FE2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 11:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgD0JaR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbgD0JaR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 05:30:17 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A9DC0610D5
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2020 02:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=azUS39h967mw2zfzfieldn3MfnrPxsQMKL6tBEy2Xvg=; b=RCxNeH0Rm8NpcYUudaUUr/7L0
        fDZTX4+eI17WoI56qWwxchTydxwMPApH2rci+QSeCtteBZu2YuDVZO+NPp5BK6qbj0cCvTxG6qa4S
        +NZVVLyUu3eM+8fs2zrCpl+pG6sb3f+IQjNfB5L4PD5B2VdyG1qRgJOqQCN3L9i8eodIVaM8277zL
        mwsUqy6tbapNL1wtX9YL4wQz7M+7VG7AO5RUbWkzgjYfCPeyta685IWh3/dv666frhwBQM07154NK
        cawv5bORY/prt9mdKqzY8I/HDEBxP9wEiqK0jO4+ydY7H936dgQy+qq/C+wzu9UVxTOrFcKd8wKQK
        BfjwSIIfA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:52068)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jT05X-00023w-Qv; Mon, 27 Apr 2020 10:30:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jT05W-0006YC-I6; Mon, 27 Apr 2020 10:30:06 +0100
Date:   Mon, 27 Apr 2020 10:30:06 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     linux-wireless@vger.kernel.org
Cc:     Jon Nettleton <jon@solid-run.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: wlcore: ERROR Tx stuck (in FW) for 5000 ms. Starting recovery
Message-ID: <20200427093006.GC25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Having had lots of problems with Broadcom BCM4330 hardware apparently
misbehaving (monitoring the wifi traffic shows lots of retransmissions
eventually resulting in disassociations despite a signal level of
around -40dBm) I decided to replace that machine with one which uses
TI wl18xx WiFi - I have another also using TI wl18xx and that seems
to be doing fine, although has less (and different) clients on.

I'm seeing the following from 5.6 kernels when running wl18xx in AP
mode. I'm not sure what's going on, only that it seems the firmware
is somehow dying.  Does this look familiar to anyone?

wlcore: ERROR Tx stuck (in FW) for 5000 ms. Starting recovery
[removed useless drivers/net/wireless/ti/wlcore/main.c:795 backtrace]
wlcore: Hardware recovery in progress. FW ver: Rev 8.9.0.0.79
wlcore: pc: 0x0, hint_sts: 0x00000020 count: 1
wlcore: down
ieee80211 phy0: Hardware restart was requested
wlcore: PHY firmware version: Rev 8.2.0.0.242
wlcore: firmware booted (Rev 8.9.0.0.79)

Does anyone have ideas how to avoid it?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
