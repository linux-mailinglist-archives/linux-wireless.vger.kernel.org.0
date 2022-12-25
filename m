Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97035655E34
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Dec 2022 21:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiLYUEF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Dec 2022 15:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYUEE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Dec 2022 15:04:04 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD89FDC
        for <linux-wireless@vger.kernel.org>; Sun, 25 Dec 2022 12:04:03 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1p9XDy-0003eb-1w;
        Sun, 25 Dec 2022 21:03:58 +0100
Date:   Sun, 25 Dec 2022 20:03:56 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Vishal Rao <vishalrao@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: Wifi 6E 6ghz not working on MediaTek MT7922 (AMD RZ616)
Message-ID: <Y6isrKS7zgMrNe3S@makrotopia.org>
References: <CAMWtyy1sSHc_DYQ3kq+FWMJKK5Wo3QEgO1yd6wQXx3x0Lp4Uog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMWtyy1sSHc_DYQ3kq+FWMJKK5Wo3QEgO1yd6wQXx3x0Lp4Uog@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

On Sun, Dec 25, 2022 at 08:19:15PM +0530, Vishal Rao wrote:
> Hello!
> 
> Using Ubuntu 22.04 LTS based distro elementary OS 7 with the latest
> available Ubuntu mainline kernel 6.1 RC5 build the wifi does not
> connect to the 6GHZ band (Wifi 6E) and it only even shows the 6ghz
> SSID name *after* I have connected to the 5ghz wifi band.
> 
> This is on a new ASUS ZenBook laptop model UM5302TA with the AMD Ryzen
> 6800U CPU platform which includes the AMD-Mediatek co-developed RZ616
> wifi chip I believe.
> 
> Pastebin of lspci -vvnn output: https://pastebin.ubuntu.com/p/QwM58ZkptG
> 
> Let me know what further information I should provide - happy to do so!


Please also share the output of `iw list` which will tell if we are
dealing with a driver problem or a regulatory/configuration problem.
Did you configure the wireless regulatory domain the device is located
in?

To have access to 6 GHz bands the regulatory region needs to be known,
I read that on Ubuntu it works like this:

https://askubuntu.com/questions/701709/how-can-i-change-my-wireless-cards-regulatory-domain-dbm-higher-than-30
