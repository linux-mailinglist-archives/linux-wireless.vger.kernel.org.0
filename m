Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD633B91AD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jul 2021 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhGAMgK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jul 2021 08:36:10 -0400
Received: from mout.web.de ([212.227.17.11]:36811 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236361AbhGAMgK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jul 2021 08:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625142818;
        bh=SbrldS2/0f5Tx1CKcyEieSdq+bVT5SR4tDAyrjbCm/w=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=JMUjiAynexchL/kUWGb81j0bdKbQb3evtE+g3qrJNPLEGsgnMcKMd8EZ8ovYyRpUk
         OudtqiSoUENrxdvje1kDvNQ/xWf/OLQydKnYRrExzNmUdpvW73rlvIgHYnbOwTMp24
         UxeWJuhufwvXNL+f7ozWe51SfZt1FCykz7y+EgdY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from schienar ([128.141.229.4]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgpVS-1lTODc0XPa-00oH7P for
 <linux-wireless@vger.kernel.org>; Thu, 01 Jul 2021 14:33:38 +0200
Date:   Thu, 1 Jul 2021 14:33:36 +0200
From:   Julian Wollrath <jwollrath@web.de>
To:     linux-wireless@vger.kernel.org
Subject: iwlwifi: AX200 wrong regulatory settings not changeable
Message-ID: <20210701143336.45cd5a40@schienar>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zv2+nSNYjMJq5G1/D/sziEh84MDwpoFvXtsapY0HVHe1Y0/bsbm
 DNpSLfIlDDbVmqPzOyW9mdtL/asyc1naD4fjKopBvKDWdSLV4GAevnmK8+Dlq9oGf+JGUY2
 m1SjrEJzXrw4f//c/ySheKVja6v62HZdgkQCLbiHHRrM5ZEibX4xHkPnoUfna4O7W3s2Iox
 74veSszcRyG1Gqg4tRcSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HV9uMNPWRgU=:Vi0anfvNWXQctkVqK/l07H
 8myh4RykYWEgCgRjmd3lLs0/63jFmBVHHlACWGxSYmXGToVbPb0fnR862KSOs6lnJdc1cW+v0
 essksUSt3IyKp0vhSunt0gZd2YFmm+jyGB1otzen0M5e76GYTzGdse+X9HW5um51dvl+6RRZJ
 uUvETukqDoI8GP6K/zymKOe/R/g60fkFAUqhDmGue0MnEBmByDNXju6JBnhJjJ1grJlXvUJfT
 agQKDhsHsObzjSXnPU3w69u38jucDrqHGQYThGiFKJzmTH5a2BFGRUApOAqc3vEkSfWtJZxbo
 iTbFnsImtxflUOvXQQt94b90nLlX2/LiQNopUqu3ns7p2Ojl0/wQclW+BI6+8PSuAVnigtkxc
 KzXLomzeyWaULsXALQ+w1Xhl++NFvlRq/+cZpdavXAVV/WKwNcgbCNXXMIsPCQkk9Qcmf2oRb
 j1eZjbUmO3qu66Dn6SNDivTcUwQpt0CzCtcUX3fUiVgpz+FEEPaCfSHhoiyWATkMFST/NTKly
 P94XO3ir+Wz/WKyzrkprUlfwG4h1i/+e9YurivaGLpZ/GKfiyqPv/KYQkTXaUguvaEx0ZC5dX
 TkvFABNLJGm1fRUk2FJNrM6+R9pUGN4UYRlyz0LLgOUYuTg8d7qDT3+ZntT/TEwnec+QK9nat
 uHFjF6Np8mjhhD+A+SdMhdKy3Iw6lZTUuyT2rzIwtfTmHuVXMlUqgp3K51nXGp1NAkLiSsJxP
 E48UW0j88ruGXlje6+SrcTmfND5yinl6k4oKlW5I1uctDZH6ghGR+tHxySV57HKVNHK/C3+ie
 zID5UE6NacFZkJgwdVwD0hadsQU+cMRuTpUUWLcfizildPhfCPpadcKM7j/fuUdiceX1wB2Du
 Nqpv4Pvavwpgxmm/gBzES08dvKXQXiSGKq9zV9jareYxjXZaucQHYetknDO+Do97yY9ArJzWY
 RbS9oNx8LGPj/RrVygLio5dW7RcXFTQZl6nV8Tusz2pW1WP828g6OYBtaf3Jcjkh954MFMcCP
 nVSiQtvARNs6tMSgLKmTRUmQrVn80eIguNDFN/g15rpkak136VjzNBVeoSbkAKjLmNpZTq6k2
 rommGLgaOALOQT/vSe1yqjwOcYRljDR2gWk
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am on kernel version 5.13 with a Intel AX200 (8086:2723) WLAN
adapter. I am in Switzerland, so the regulations as e.g. detailed in
[1] apply. I am trying to set the correct regulatory limits via

$ iw reg set CH

but apparently the device is self-managed and does not take these
settings into account:

$ iw reg get
global
country CH: DFS-ETSI
	(2400 - 2483 @ 40), (N/A, 20), (N/A)
	(5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
	(5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
	(5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
	(5725 - 5875 @ 80), (N/A, 13), (N/A)
	(57000 - 66000 @ 2160), (N/A, 40), (N/A)

phy#0 (self-managed)
country 00: DFS-UNSET
	(2402 - 2437 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS,
NO-80MHZ, NO-160MHZ
	(2422 - 2462 @ 40), (6, 22), (N/A), AUTO-BW, NO-80MHZ, NO-160MHZ
	(2447 - 2482 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS,
NO-80MHZ, NO-160MHZ
	(5170 - 5190 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW,
IR-CONCURRENT, NO-HT40MINUS, PASSIVE-SCAN
	(5190 - 5210 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW,
IR-CONCURRENT, NO-HT40PLUS, PASSIVE-SCAN
	(5210 - 5230 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW,
IR-CONCURRENT, NO-HT40MINUS, PASSIVE-SCAN
	(5230 - 5250 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW,
IR-CONCURRENT, NO-HT40PLUS, PASSIVE-SCAN
	(5250 - 5270 @ 160), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, PASSIVE-SCAN
	(5270 - 5290 @ 160), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40PLUS, PASSIVE-SCAN
	(5290 - 5310 @ 160), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, PASSIVE-SCAN
	(5310 - 5330 @ 160), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40PLUS, PASSIVE-SCAN
	(5490 - 5510 @ 240), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, PASSIVE-SCAN
	(5510 - 5530 @ 240), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40PLUS, PASSIVE-SCAN
	(5530 - 5550 @ 240), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, PASSIVE-SCAN
	(5550 - 5570 @ 240), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40PLUS, PASSIVE-SCAN
	(5570 - 5590 @ 240), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, PASSIVE-SCAN
	(5590 - 5610 @ 240), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40PLUS, PASSIVE-SCAN
	(5610 - 5630 @ 240), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, PASSIVE-SCAN
	(5630 - 5650 @ 240), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40PLUS, PASSIVE-SCAN
	(5650 - 5670 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
	(5670 - 5690 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
	(5690 - 5710 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
	(5710 - 5730 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
	(5735 - 5755 @ 80), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
	(5755 - 5775 @ 80), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
NO-HT40PLUS, NO-160MHZ, PASSIVE-SCAN
	(5775 - 5795 @ 80), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
	(5795 - 5815 @ 80), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
NO-HT40PLUS, NO-160MHZ, PASSIVE-SCAN
	(5815 - 5835 @ 20), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
	NO-HT40MINUS, NO-HT40PLUS, NO-80MHZ, NO-160MHZ, PASSIVE-SCAN

Unfortunately, the self-managed settings seem incorrect to me, e.g. the
full range from 5150-5350 MHz should be limited to NO-OUTDOOR use (see
the above settings listed under country CH and [2] for the official
text) but this is not the case for the self-managed part, so what the
device is actually using. Also the transmission power limits are not
always correct, e.g. 5725 MHz should be limited to 25mW (compare with
above, [1] or [3]) and not to 22dBm. Is it possible to change the
device to not being self-managed and to set the regulatory limits to
the one of the country I am using it in (as was possible with older
Intel devices as e.g. Intel Centrino Advanced-N 6205 which is using
iwldvm as driver).

Best regards,
Julian Wollrath


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.gi=
t/tree/db.txt#n317
[2] https://www.ofcomnet.ch/api/rir/1010/05
[3] https://www.ofcomnet.ch/api/rir/1008/12

=2D-
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
