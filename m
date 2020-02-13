Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA3315C010
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 15:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgBMOJC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 09:09:02 -0500
Received: from mail.bitwise.fi ([109.204.228.163]:48348 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbgBMOJC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 09:09:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 2392060084;
        Thu, 13 Feb 2020 16:09:00 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.bitwise.fi
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mail.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c6A4FDPQcPQt; Thu, 13 Feb 2020 16:08:57 +0200 (EET)
Received: from [192.168.5.238] (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 126266001C;
        Thu, 13 Feb 2020 16:08:57 +0200 (EET)
Subject: Re: rtl8xxxu does not handle ampdu_action properly
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <4c668c56-1c77-102e-2e33-8ea77f9dc57c@bitwise.fi>
Message-ID: <a58eedd2-3bea-0783-f7ba-cda8f92dd6c7@bitwise.fi>
Date:   Thu, 13 Feb 2020 16:08:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <4c668c56-1c77-102e-2e33-8ea77f9dc57c@bitwise.fi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13.2.2020 12.41, Anssi Hannula wrote:
> Hi!
>
> Just a quick note that I noticed that rtl8xxxu does not seem to handle
> ampdu_action properly.
>
> The driver should react to a IEEE80211_AMPDU_TX_START by either calling
> ieee80211_start_tx_ba_cb_irqsafe() or by returning
> IEEE80211_AMPDU_TX_START_IMMEDIATE [1] or by just returning a failure
> (ath10k, ath11k, wlcore do so for "fw-managed" case), but rtl8xxxu
> simply sets ampdu_factor and ampdu_density via register writes and then
> returns 0.
> I didn't look through the agg-tx code thoroughly on what the end effect
> of this is but looks like at least ieee80211_agg_tx_operational() will
> never be called.

Looking slightly further, there is a commented-out check for
(tx_info->flags & IEEE80211_TX_CTL_AMPDU) in rtl8xxxu_tx(). Commenting
that out may be working around (by always enabling ampdu?) the issue of
ieee80211_agg_tx_operational() call never having been made.

> There is a similar issue with IEEE80211_AMPDU_TX_STOP_CONT and
> ieee80211_stop_tx_ba_cb_irqsafe().
>
> Quick grepping suggests all other drivers handle these properly.
>
> [1]
> https://www.kernel.org/doc/html/latest/driver-api/80211/mac80211-advanced.html?highlight=mac80211#c.ieee80211_ampdu_mlme_action
>


-- 
Anssi Hannula / Bitwise Oy
+358 503803997

