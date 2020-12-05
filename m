Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2982D2CFF6D
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 23:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLEV7u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 16:59:50 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:35370 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLEV7u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 16:59:50 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Dec 2020 16:59:50 EST
Received: from gw.sieb.net ([70.70.44.174])
        by shaw.ca with ESMTP
        id lfT2kAlcoktFklfT3kDPmO; Sat, 05 Dec 2020 14:51:50 -0700
X-Authority-Analysis: v=2.4 cv=NYRYa0P4 c=1 sm=1 tr=0 ts=5fcc00f6
 a=Q8z69UlXDO7VcdJOWsrNQg==:117 a=Q8z69UlXDO7VcdJOWsrNQg==:17
 a=IkcTkHD0fZMA:10 a=zTNgK-yGK50A:10 a=wGystFlnAAAA:20 a=lG7TRaMCAAAA:20
 a=PuvzptouIovCSvZbVdsA:9 a=QEXdDO2ut3YA:10 a=yaDoWP3BefgA:10
 a=e6k74qS2CMYA:10 a=VlZU0XKO32wA:10
Received: from worklap.sieb.net (worklap.sieb.net [10.0.7.2])
        by gw.sieb.net (Postfix) with ESMTPSA id A23E49024E5
        for <linux-wireless@vger.kernel.org>; Sat,  5 Dec 2020 13:51:48 -0800 (PST)
Subject: Re: wifi dongle connected to USB/pci card, seen in hardware, but no
 wl* device created; udev, driver, &/or config?
To:     linux-wireless@vger.kernel.org
References: <95c76758-485b-aad4-62d2-95ce24f1108c@gmail.com>
From:   Samuel Sieb <samuel@sieb.net>
Message-ID: <79883ce0-9313-10b4-214a-27be35888bee@sieb.net>
Date:   Sat, 5 Dec 2020 13:51:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <95c76758-485b-aad4-62d2-95ce24f1108c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP5tQ8i0ZeBiLjYKFlUzXjkxav3vs21i5hP4XEox5KYoBMdInkEfqgx98raddj43mrqIMXbmYkO+ynyxNGAY0I8goZz+l0gRD/fXbf5M2wRUeucf96sw
 6DnMI4hO7B3wBvmudi1/zBFRAdcmLs/qygoYyTxb7vsSzvccG7FP9IH6b/wVv0Q1ojmBH3JjUy7Ncg==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/5/20 1:25 PM, PGNet Dev wrote:
>      lsusb | grep 008
>          Bus 008 Device 003: ID 0bda:b812 Realtek Semiconductor Corp. 
> RTL88x2bu [AC1200 Techkey]

That chipset doesn't have a kernel driver.

There are a couple of available options:
https://github.com/cilynx/rtl88x2bu
https://github.com/RinCat/RTL88x2BU-Linux-Driver

> existing default udev rules aren't creating a wlan device; I'd expected 
> that they would ...

The device can only be created if there's a driver to create it.
