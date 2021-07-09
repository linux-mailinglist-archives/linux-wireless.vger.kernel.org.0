Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53D13C2711
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jul 2021 17:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhGIPvY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jul 2021 11:51:24 -0400
Received: from smtp.aic.fr ([195.13.32.122]:43980 "EHLO smtp-out02.aic.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232248AbhGIPvY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jul 2021 11:51:24 -0400
Received: from webmail.cube-technologies.net (unknown [93.191.42.150])
        by smtp-out02.aic.fr (Postfix) with ESMTP id 52F8D52A
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jul 2021 17:48:37 +0200 (CEST)
Received: from Cube-mail.cube.local (192.168.3.242) by Cube-mail.cube.local
 (192.168.3.242) with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 9 Jul
 2021 17:48:21 +0200
Received: from Cube-mail.cube.local ([::1]) by Cube-mail.cube.local ([::1])
 with mapi id 15.00.0847.040; Fri, 9 Jul 2021 17:48:21 +0200
From:   Vincent RUBY <vruby@cube-technologies.net>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Kernel crash when scanning for APs in huge WiFi environment -
 Ath10K - ARMV7 - Linux 4.14.73
Thread-Topic: Kernel crash when scanning for APs in huge WiFi environment -
 Ath10K - ARMV7 - Linux 4.14.73
Thread-Index: Add00g30B+V1wjYvQ12HCt8vs0rm9wAB60sA
Date:   Fri, 9 Jul 2021 15:48:21 +0000
Message-ID: <e23f3f12dcab42ea9ab4b7384080cdf2@Cube-mail.cube.local>
References: <1cef8054e4e447f2ba02d1de1e6afdf8@Cube-mail.cube.local>
In-Reply-To: <1cef8054e4e447f2ba02d1de1e6afdf8@Cube-mail.cube.local>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.3.53]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I apologize in advance if I am writing at the wrong place.
We have developed a custom embedded board based on ARMV7. On the board there is a Telit WE866C3-P Wifi module (based on ath10k).
Linux : 4.14.73 (YOCTO/poky)
Microcontroller : SAMA5D27

The board is working perfectly in a normal Wifi environment (e.g., at office).
But when the board is put in a huge Wifi environment (e.g., 350 APs with 2 antennas each with more than 600 visible BSSIDS) the Linux kernel crashes when attempting to connect to a Wifi network using wpa_supplicant.
When the Wifi antenna is attenuated with some electromagnetic obstacle (e.g., hand or metallic shield), the board connects without any problem.

The problem is the same when running a scan from wpa_cli .

Do you have any idea where I can find some clue to resolve this issue?

Many thanks in advance !

VinceCube
