Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9115BD1A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 11:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgBMKvq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 05:51:46 -0500
Received: from mail.bitwise.fi ([109.204.228.163]:34292 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMKvq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 05:51:46 -0500
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 05:51:45 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 35F6B6001C;
        Thu, 13 Feb 2020 12:41:48 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.bitwise.fi
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mail.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JjpL8dRIyRM1; Thu, 13 Feb 2020 12:41:45 +0200 (EET)
Received: from [192.168.5.238] (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 784D860084;
        Thu, 13 Feb 2020 12:41:45 +0200 (EET)
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     linux-wireless@vger.kernel.org
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: rtl8xxxu does not handle ampdu_action properly
Message-ID: <4c668c56-1c77-102e-2e33-8ea77f9dc57c@bitwise.fi>
Date:   Thu, 13 Feb 2020 12:41:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

Just a quick note that I noticed that rtl8xxxu does not seem to handle
ampdu_action properly.

The driver should react to a IEEE80211_AMPDU_TX_START by either calling
ieee80211_start_tx_ba_cb_irqsafe() or by returning
IEEE80211_AMPDU_TX_START_IMMEDIATE [1] or by just returning a failure
(ath10k, ath11k, wlcore do so for "fw-managed" case), but rtl8xxxu
simply sets ampdu_factor and ampdu_density via register writes and then
returns 0.
I didn't look through the agg-tx code thoroughly on what the end effect
of this is but looks like at least ieee80211_agg_tx_operational() will
never be called.

There is a similar issue with IEEE80211_AMPDU_TX_STOP_CONT and
ieee80211_stop_tx_ba_cb_irqsafe().

Quick grepping suggests all other drivers handle these properly.

[1]
https://www.kernel.org/doc/html/latest/driver-api/80211/mac80211-advanced.html?highlight=mac80211#c.ieee80211_ampdu_mlme_action

-- 
Anssi Hannula / Bitwise Oy
+358 503803997

