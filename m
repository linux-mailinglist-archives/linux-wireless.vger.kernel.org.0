Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD89E754
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 14:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfH0MGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 08:06:24 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:36948 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfH0MGY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 08:06:24 -0400
Received: by mail-lj1-f180.google.com with SMTP id t14so18231686lji.4
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 05:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+aMcX5AAwNOaOk4+J9SArTma0t2Dc30ZWh7o/ydFFNU=;
        b=YRryFT2HNnf/jmSBwpsfw/WGnXWYIvUFlhWVBu7WW0BZzmy+gN9GtqoHPiljuODTC7
         YLwRnNpIyIHkqctyEduRpOesSMq7OtcX3kn5/puiV4MpBrQOdKVnQJdZ/0mjTku9IYeh
         XRpExEWDbnPq89e5IMA/CvT6MSlABnH3H0Gg8XV9x7d7e3c3DlaoeYGMYF+8Et3ocpIK
         Y1zrdFCKw+IfKYN20XIRDx7CCeS+aFPimgq8uOoY04fLj3dm3LsDvC89mzGxDKxxhaJ0
         JhFAB6rJMQytNpbXYOSTk2F+1JPGG/vqGqySvRtu+0T9TW6XqlQoBN/wsTEvNWQZEo/l
         Y0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+aMcX5AAwNOaOk4+J9SArTma0t2Dc30ZWh7o/ydFFNU=;
        b=C2fidHvyUEhQarXS0Pz6DfupCUcewZvRa9HlSfdxwj3HlpPN8bLYZDKXKynijcdyJz
         yPbx8uv8qd4FwLT8TJnvaapqXiR6pf+1V9i4fs9Em1rTFHRL6LQnTrBFJmFzmQxSOrXz
         gCURbjo35wfXEpAJhE62qPk2laLAKSjrLrg/QA2eJqNV11nN63RlzzQ9ZuRItRlnXWi8
         aEMPNuTdRnqmRQWCkZWeVyvCTWdJOzfJi8bK6zKpaY+V1EI2VNIQYopqhYFbuf3rd4dA
         iJNp0QlNGOclT1GljOt95h8pXR2e/MD+e7IJYrv9RTPFxbeBPo1w5WTDd4xeuZ57x+ih
         YcXw==
X-Gm-Message-State: APjAAAUWnSFpg+zV7QGn/1UGPc0Rw0fJbMm8q5WZpzFmHKa6Ck7nSNSA
        Zs7zAkVbnrNW4ncg4ioheKR67Ht5Q8xCT5fE58IeXC1MtPc=
X-Google-Smtp-Source: APXvYqwIdvOtMT6WBgbshCWVI3jxZXtCfaD/VlnYcjzZ66837s/bcziI11ZMfpHkUhGXL9ye+g7eBWERbblBR/fsCW0=
X-Received: by 2002:a2e:9216:: with SMTP id k22mr13264384ljg.184.1566907582117;
 Tue, 27 Aug 2019 05:06:22 -0700 (PDT)
MIME-Version: 1.0
From:   Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Tue, 27 Aug 2019 09:06:11 -0300
Message-ID: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
Subject: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

When I use 2.4Ghz band with -only one- AP (running on top of hostapd)
I get a (additional) list of frequencies at 5Ghz. When I do "iw dev ..
scan"

BSS 02:00:00:00:04:00(on sta1-wlan0) -- associated
TSF: 1566905272877856 usec (18135d, 11:27:52)
freq: 2422
beacon interval: 100 TUs
capability: ESS ShortSlotTime (0x0401)
signal: -34.00 dBm
last seen: 0 ms ago
Information elements from Probe Response frame:
SSID: simplewifi
Supported rates: 1.0* 2.0* 5.5* 11.0* 6.0 9.0 12.0 18.0
DS Parameter set: channel 3
ERP: Barker_Preamble_Mode
Extended supported rates: 24.0 36.0 48.0 54.0
Extended capabilities:
* Extended Channel Switching
* Multiple BSSID
* SSID List
* Operating Mode Notification

BSS 02:00:00:00:04:00(on sta1-wlan0)
TSF: 1566905274269230 usec (18135d, 11:27:54)
freq: 5180
beacon interval: 100 TUs
capability: ESS ShortSlotTime (0x0401)
signal: -34.00 dBm
last seen: 0 ms ago
Information elements from Probe Response frame:
SSID: simplewifi
Supported rates: 1.0* 2.0* 5.5* 11.0* 6.0 9.0 12.0 18.0
DS Parameter set: channel 3
...

BSS 02:00:00:00:04:00(on sta1-wlan0)
TSF: 1566905274269230 usec (18135d, 11:27:54)
freq: 5200
beacon interval: 100 TUs
capability: ESS ShortSlotTime (0x0401)
signal: -34.00 dBm
last seen: 0 ms ago
Information elements from Probe Response frame:
SSID: simplewifi
Supported rates: 1.0* 2.0* 5.5* 11.0* 6.0 9.0 12.0 18.0
DS Parameter set: channel 3
...

and so on (please notice that channel number and frequency)..
iw dev scan returns all the 5Ghz frequencies defined in
https://github.com/torvalds/linux/blob/master/drivers/net/wireless/mac80211_hwsim.c#L328
It happens only when wmediumd is being used. When hostapd is running
with 5Ghz it seems to work as expected, since iw returns only the AP
running at 5Ghz. In other words, the problem occurs only when hostapd
is running at 2.4Ghz.

I noticed that it happens from kernel 4.18. If I comment
https://github.com/torvalds/linux/blob/b55f3b841099e641bdb2701d361a4c304e2dbd6f/drivers/net/wireless/mac80211_hwsim.c#L2838,
iw returns only 2422Mhz. However, I couldn't find the reason for such
problem.

There could be some problem with mac80211_hwsim, or am I missing something here?

Best Regards,
Ramon Fontes
