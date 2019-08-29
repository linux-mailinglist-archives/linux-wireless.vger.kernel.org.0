Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442D8A1E14
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfH2O5D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 10:57:03 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37672 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfH2O5D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 10:57:03 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3LrB-0002n2-KK; Thu, 29 Aug 2019 16:57:01 +0200
Message-ID: <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ramon Fontes <ramonreisfontes@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 29 Aug 2019 16:57:00 +0200
In-Reply-To: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com> (sfid-20190827_140626_444621_C34D25FA)
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
         (sfid-20190827_140626_444621_C34D25FA)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> When I use 2.4Ghz band with -only one- AP (running on top of hostapd)
> I get a (additional) list of frequencies at 5Ghz. When I do "iw dev ..
> scan"
> 
> BSS 02:00:00:00:04:00(on sta1-wlan0) -- associated
> TSF: 1566905272877856 usec (18135d, 11:27:52)
> freq: 2422
> beacon interval: 100 TUs
> capability: ESS ShortSlotTime (0x0401)
> signal: -34.00 dBm
> last seen: 0 ms ago
> Information elements from Probe Response frame:
> SSID: simplewifi
> Supported rates: 1.0* 2.0* 5.5* 11.0* 6.0 9.0 12.0 18.0
> DS Parameter set: channel 3
> ERP: Barker_Preamble_Mode
> Extended supported rates: 24.0 36.0 48.0 54.0
> Extended capabilities:
> * Extended Channel Switching
> * Multiple BSSID
> * SSID List
> * Operating Mode Notification

I guess this is the one you expect?

> BSS 02:00:00:00:04:00(on sta1-wlan0)
> TSF: 1566905274269230 usec (18135d, 11:27:54)
> freq: 5180
[...]
> BSS 02:00:00:00:04:00(on sta1-wlan0)
> TSF: 1566905274269230 usec (18135d, 11:27:54)
> freq: 5200

and these are garbage.

> and so on (please notice that channel number and frequency)..
> iw dev scan returns all the 5Ghz frequencies defined in
> https://github.com/torvalds/linux/blob/master/drivers/net/wireless/mac80211_hwsim.c#L328
> It happens only when wmediumd is being used.

Since you cannot reproduce this without wmediumd (and neither can I) I
assume it's a wmediumd bug, in the sense that it's reporting the frame
on all the channels, or perhaps without any channel information, or so?

Or possibly the hwsim code that handles this is broken, maybe you could
see what wmediumd does (does it have any log files?)

johannes

