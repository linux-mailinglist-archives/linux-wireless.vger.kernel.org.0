Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7CE116AFD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 11:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLIK2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 05:28:46 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:43177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLIK2q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 05:28:46 -0500
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1MCKJw-1iUsd00lIA-009Sxe; Mon, 09 Dec 2019 11:28:40 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: [RFC] Allow userspace to reset IBSS stations to fix aggregation issue
Date:   Mon,  9 Dec 2019 11:28:05 +0100
Message-Id: <20191209102808.12014-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <m34l02mh71.fsf@t19.piap.pl>
References: <m34l02mh71.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xkoUNVh51RZ4OCYKTkLdjrCqi72pLFG5n+EKMY8MM+Co99d1D36
 qDe5OaRLiJ8Lbqwc7PfuT5POuNBxOis3NIwNKOorB8w4t2xC+pCFWr2u96ZdWyMGfxiJW/d
 4YsOpd11UykzqfKbdsJmz/noIGwj1QrSWM8NgpBzYdpTQe1LbiKw+68V0kOAx6bA4nITzGD
 EnxUJND7hZ5/hWpqI8PJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jYu9PGAgPUc=:VDWVsgMF2o8P2EQGoJREPG
 y48hXly+yo0N/Bg4aCPVMjSwfYhfE85gxkxWOuAh8QDBvjE6M4cCV0z8g/xFYQMG4hocPxDFG
 PMX81rwM7PxcInHe5HH1VQNCtj3HRvsbVEAOTuQzYV2FB9macpkv2MWSgnO7vauqKERE5I+98
 GiPo0heqK6TeOp1yE8HIt4JjIfzzmtXxvpSxiBSLeM4bvHGdLWTyPDbzc+MHXF4NOT9uKWIY5
 EHnprQj9iePV73ZVzjhAaIoIxhWJkAOBlg2ser63t5S+MW4+TCi7AqaFC3f7QubrtxzSnzfR4
 uvD5+pDHGhoZYL8J4AMa8jXFruTgi4nkhLBDnbGRjQyKx4UEg4XS0bhQpT7dkLZDJkEg94Thf
 +SZKVz7nFxxZSTo+R3FUvsd91rI59VQ7QK9CtnZSxjlektQbwFpLsXFw8wwSFzV7cvxQ4YPxL
 zwu0VFZngFkHDQZd8cq9+nz+3VMv79YLkWS6F+wcnba8o+v82UsBXK1+b7slifKBLJaUao9Ru
 EpgdVos4Wt5WECVe1CWHuKOhn3lETf97NYYSSABCOEFrmHY1x+B6QfxkIv1WLel/7uXijA6ew
 hYoMk9LZ+K8hrZe8Dnrw0PFgVcIV7v8tRwI6ahHTiO8afYcjv4xNReTloHEL5uh4Mv3/kOSup
 Zr22eV57Q4B2nyfJRsPUTp3KS8Y0zbeslyT9xLFKZ/PRheBWr+kE3mGWkfrEr1Y/Lx5kJFhL+
 TCA1MpsTjJrFjEWEVK+nkhiqxOz+2lWrhSQVIurzpIDYRV2BLxWavrpLk1iZM371QYgEKSPN8
 AgKSWdrdQBf2XUqjW/fQereBsooY3F6tByW9cpWPK8+d9GDyEOYyt00KVmM0CHxhtqLuo7RwH
 WC0/llVc53QQCDXbYpo6j1NUQqX+jya5v1jCK26CApzJTv85MzBOD0FSZ3Nh6O
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I encountered the same issue in an IBSS-RSN network, where quick reboot
of a station would cause issues with aggregation because the kernel is
not aware of the reboot.

I figured out that since wpa_supplicant already detect reboots, the
simplest way to fix it would be for wpa_supplicant to reset the entire
state of the station in the kernel, instead of just resetting keys and
port.

This means extending NL80211_CMD_DEL_STATION to work in IBSS mode too.
My current wpa_supplicant patch tries this new API but fall back to the
old methods if an error is returned.

The changes required for drivers would be as follow:
- mac80211: will just work
- wil6210: does not seem to support IBSS mode
- ath6kl: need a patch
- brcmfmac: need a patch
- mwifiex: need a patch
- qtnfmac: no IBSS support
- staging/wilc1000: no IBSS support
- staging/rtl8723bs: already returns EINVAL in this case.

I made patches for ath6kl, brcmfmac and mwifiex that plainly reject
the request. If there is a better way, i'll glad to hear it.




