Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629381EDBF3
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 05:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgFDDyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 23:54:45 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:49554 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDDyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 23:54:45 -0400
Received: from [192.168.254.4] (unknown [50.34.197.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 386D113C2B0
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 20:54:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 386D113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1591242884;
        bh=PAbwMAxZBZ7pYVUGo3+dSf/Z45HvACfHzzbx9lIOx38=;
        h=To:From:Subject:Date:From;
        b=fgSkY6vdzsmBGVbnUcSvJ8AMRNZQqoQRVLEIya2ZCqUcHSYWd7d6fEE4b50zDNDLf
         JeM0eF4uWdRQJmIzatlnMp11tZH9XDwkmOWBj9kVZoijGf22wKl3mSO1Z1psC6siGP
         czCgXwXEiLPYyEhjm5dk61C1sEEbhxV1QmMNE2Ck=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax200 very poor performance in stock 5.7.0 and 53.c3 firmware.
Message-ID: <c2898228-836e-549b-85ee-8c2d24051912@candelatech.com>
Date:   Wed, 3 Jun 2020 20:54:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm testing an un-modified kernel for a change, and latest firmware that I could find,
but ax200 is still sucking.

UDP upload of single ax200 station gets about 1Mbps, and station disconnects
very often.  TCP download gets about 400Mbps on each of two radios.  UDP download stalls
often and averages around 1Mbps throughput.  TCP upload also stalls out.

Previous testing on other kernels has shown problems with other firmware as well.

I'm requesting 500Mbps UDP speeds.    Requesting only 100Mbps does not help (tested with DL direction only).

[root@ct523c-0b29 ~]# ethtool -i wlan2
driver: iwlwifi
version: 5.7.0
firmware-version: 53.c31ac674.0 cc-a0-53.ucode
expansion-rom-version:
bus-info: 0000:12:00.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no


Is there any way to disable OFDMA or /ax on the ax200 in case that helps somehow?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
