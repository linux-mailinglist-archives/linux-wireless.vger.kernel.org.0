Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB40149275
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2020 02:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbgAYBIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jan 2020 20:08:54 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:45553 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgAYBIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jan 2020 20:08:54 -0500
Received: by mail-il1-f181.google.com with SMTP id p8so3038948iln.12
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2020 17:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ghrZ8c0g7Oxdf70uCqow1KGB1+WkgE4xtyjIPr6hI9I=;
        b=ORhH8UCcpoNXQX3zCMQsefXhy9EAhFQVqsWyCrZ9VY7gbyXE0ExgBQjn9T+jftE7vl
         gTfdY1UTVQOY9QQsEPb+NC8iTPlsJvrR+lJuTVk5jf1WCyxnpRQGw02cc2zsxsTCO5Aq
         ekR7wAemh3ck83OlTEv2O0/T/2RhvV7+Nq4XLZHliu476fQVS8BwoiaUuFUaQiyF9tud
         K/OEBSZjiDOqsFwxjO3swXRnIFP5qI6nP19ADglkk4Lg0B5bxSLkmzHn12ttZpZK/GVN
         x8rFFBdI35P7tU5wHZ4q6jwSl3xLwQLb+xEHP10FWw7//yOdfAnYknIfglnZ8G4mG+Mh
         3L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ghrZ8c0g7Oxdf70uCqow1KGB1+WkgE4xtyjIPr6hI9I=;
        b=HDrAn3nVxTdjWhjfh9QxJV5PlwIYK+H3dHV8colX/MO6bp2qM+034LpXTtixkJxo6+
         rlCVgntBgxjOe0Wp7dOmNiyG3WkkQg/aTJ2D9UbQivHlwTiJJ9CqbadCQKAhMMWkt2YE
         4YvcgBC8QIhZZ/f3I27p8DvBgQJZrBnMFDFG4GAPdmnMkm9rCWIoBQYEas/VUAQvhqef
         1eiWfbI+LR7dLHwqRGt8iInagX0q/MxQf1b+KC98fwTXQz7TTjqCWMGPvRiOS/dAYlk2
         REGua5xTreGbpLi1/Ei7jNr9BkWRillc6Gn17mF9iPZooAxHeoOn3F+vtsMo0Vv8JPIx
         CLtA==
X-Gm-Message-State: APjAAAXX5SxhFOaCYhSiMza4iGqCo+Qr/WxgnP3/zduEbF4rHHCFmB30
        7lVXDqkAvQIgXTZc9MaD2PSw4OgEpyPVn/vfd1IEXcbZ
X-Google-Smtp-Source: APXvYqwCLFaqzhtpOBVk1dOO3kkdptwnKwFby3QbpM0dTEJAx2ub7Gszo913/RP4wvdEqq0GpggKlYBi2LqK71WmAnI=
X-Received: by 2002:a92:ce85:: with SMTP id r5mr5832573ilo.301.1579914533607;
 Fri, 24 Jan 2020 17:08:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Fri, 24 Jan 2020 17:08:53
 -0800 (PST)
From:   JH <jupiter.hce@gmail.com>
Date:   Sat, 25 Jan 2020 12:08:53 +1100
Message-ID: <CAA=hcWTouQAnc+uZjj2fb44Z3=T0gSqjwcW9CiRpOJJxGcx=Hg@mail.gmail.com>
Subject: Why the mwifiex_sdio frequently disconnected and connected?
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have been running mwifiex_sdio for a uBlox 4G LTE SARA-R4  and Lily
WiFi module, it seems that WiFi connection is stable, but the LTE
connection is often connected and disconnected.

Looking into the kernel messages, there were many messages to
disconnect and connect it again every half of an hour. The device did
not set IPv6 which is understandably that IPv6: ADDRCONF(NETDEV_UP)
link is not ready, but why it often doing mwifiex_sdio mmc0:0001:1:
info: successfully disconnected from 34:08:03 and what that means?

root@solar:/var/backups# [ 2045.955013] mwifiex_sdio mmc0:0001:1:
CMD_RESP: cmd 0x23f error, result=0x2

root@solar:/var/backups# [ 2250.000008] mwifiex_sdio mmc0:0001:1:
info: successfully disconnected from 34:08:03
[ 2250.081497] IPv6: ADDRCONF(NETDEV_UP): mlan0: link is not ready
[ 2250.206977] IPv6: ADDRCONF(NETDEV_UP): wwan0: link is not ready
[ 2251.417295] mwifiex_sdio mmc0:0001:1: info: trying to associate to
'JupiterIoT' bssid 34:08:04:12:b1:a2
[ 2251.521866] mwifiex_sdio mmc0:0001:1: info: associated to bssid
34:08:04:12:b1:a2 successfully
[ 2251.666834] IPv6: ADDRCONF(NETDEV_CHANGE): mlan0: link becomes ready
[ 2251.743352] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2


Also, the 4G LTE SARA-R4 uses USB interface and protocol, but it seems
to me that mwifiex_sdio managers both LTE and WiFi connections, right?

I am currently debugging the LTE connection stability issues, it
ofoten connected to LTE, then in half hours or hours randomly, lose
the LTE connection. I try to narrow down the cause, whether the USB
interface or from mwifiex_sdio caused LTE connection stability. When
the LTE lost connection there were following errors which I am not
clear if related to the mwifiex_sdio  or not. Appreciate your advise
and comments to diagnostic the issue and to fix the LTE connection
problems.

 1019.130834] option 1-1:1.0: device disconnected
[ 1019.142012] qmi_wwan 1-1:1.3: nonzero urb status received: -71
[ 1019.147909] qmi_wwan 1-1:1.3: wdm_int_callback - 0 bytes
[ 1019.153254] qmi_wwan 1-1:1.3: wdm_int_callback - usb_submit_urb
failed with result -19
[ 1019.228197] option1 ttyUSB1: GSM modem (1-port) converter now
disconnected from ttyUSB1

Thank you.

Kind regards,

- jh
