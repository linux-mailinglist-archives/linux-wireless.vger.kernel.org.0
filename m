Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A456B669
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2019 08:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfGQGNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jul 2019 02:13:47 -0400
Received: from picapica.im ([159.69.34.17]:60850 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfGQGNr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jul 2019 02:13:47 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 02:13:46 EDT
Received: by picapica.im (Postfix, from userid 1000)
        id 1C03A3E8AB; Wed, 17 Jul 2019 08:06:09 +0200 (CEST)
Date:   Wed, 17 Jul 2019 08:06:09 +0200
From:   Anton Sviridenko <anton@picapica.im>
To:     linux-wireless@vger.kernel.org
Subject: RTL8188ETV chip, r8188eu module and power management
Message-ID: <20190717060609.GA21298@picapica.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hello

we are using FN-8112MET PCB module having RTL8188ETV chip on it.
Device is running customized Linux version based on Linux 4.19 release.
Driver module "r8188eu" is not modified, taken from vanilla sources as
is.
Wi-Fi connection is used occasionally, and rest of the time it is
preferable to have minimal power consumption. 

Such situation is observed:

1) Linux kernel is started, driver module is not loaded
2) module "r8188eu" is loaded manually with parameters "rtw_power_mgnt=2
rtw_enusbss=1"
3) device starts consuming more current (+20mA)
3) after the module is unloaded, current consumption remains at the same
level

We still have to double-check this, but looks like driver module does
not leave the device in the same state on module unload.

Few questions:
1) Is "r8188eu" driver from the mainline kernel the best possible option
available for this chip?

2) Where can I look for some documentation about kernel module
parameters related to power management and their meanings? 
Source code is not very descriptive, and I was not able to google
anything better, looks like this chip specifications are not available in
public.

3) Is there some option to completely poweroff this chip using software
and then bring it back when needed?

Anton

