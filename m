Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76B817A203
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 10:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCEJHc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 04:07:32 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34392 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCEJHc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 04:07:32 -0500
Received: by mail-wr1-f44.google.com with SMTP id z15so6029794wrl.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2020 01:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=pveQNqjQrDxjxctTRbcArEI0/9cLLRZ+RHHbjAxefrg=;
        b=Rtmnhz4nM7wCRYWgwrg9LX3V/n2xMK6NPTNst09JDb3miyVqOdoUt7TLwaY37mP53A
         jI0zz0OaLai4A8nPkMB0Qz1r/QZeQWANHegF04voHF6f8c+ZvrXWJ8tCxkp6E36wsD/n
         Lgh5pj4k8+6RiPf1BD4OLwcoSU1cljz57F3Evw11g61eaoeCDwXeCpmQi/acz1er8NiZ
         dgIcDnwT+HABn/q7jnkzWqWROblmmDg9Rpmjx1xt6a7ftWh8lGzT0zqo8Baku1C36jLk
         Y2J8bUe3WGbi66S2C1utsJhXuuC4y/YBU9DChgkd2Ym+ZJmBKN8d5mgITJaKX+FU/Bmn
         YU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=pveQNqjQrDxjxctTRbcArEI0/9cLLRZ+RHHbjAxefrg=;
        b=tTI7pxwmmFhfiPThPKY9JoigCMzcokUcySTmfbUh6tPNNP/6/VyM59TrPfPPppPkvN
         AhSdu6NYqtF9JYyh4adJN9OAVDODUKzUS92M7F4NdQQtz/uDNj4/x8EjCtsXLz/a6Xjz
         SUxRghBgjl/4rslRj07dlSTtro/fWW71KbPI2/O9kxWKOAxakfeOvE6TzNZbQ/wbf4NJ
         7ryIMoc8IMQHnePB4E2ClIik85xLR1980hUM9k/oTeZ75/BDp+vTg+XJGMu5Pjr4wsF+
         ldZHsnhWrYXxlfHIDU0zp9Otm0aiHhfkBbXY3qIULIYiPD/59E0oCpBQYfVKnENZ3WX/
         R10Q==
X-Gm-Message-State: ANhLgQ2rRGjWIDUrRSSiWt4OQW28xk/crOATk2nxAR0I/kccKnNdB3Pk
        chtwsAErZxFMcu9nZ3M2C7Y=
X-Google-Smtp-Source: ADFU+vuunH6rG3DQkxMXaASoBBl/PXwhAMwYFEbF/SllIj51RhGKJed7TKVp+UIRmg4UuAOkMts+aA==
X-Received: by 2002:adf:b317:: with SMTP id j23mr77835wrd.413.1583399250014;
        Thu, 05 Mar 2020 01:07:30 -0800 (PST)
Received: from [192.168.0.240] (178-117-183-57.access.telenet.be. [178.117.183.57])
        by smtp.gmail.com with ESMTPSA id f127sm8639116wma.4.2020.03.05.01.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 01:07:29 -0800 (PST)
To:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
From:   Wei Liu <wei.liu1011@gmail.com>
Subject: Precise time synchronization via wifi interface (intel AX201 iwlwifi
 driver)
Message-ID: <032f07e2-2771-619b-52b4-a25c8cd10f86@gmail.com>
Date:   Thu, 5 Mar 2020 10:07:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am trying to achieve precise time synchronization via wifi interface.

I used intel AX201 card, certified with TimeSync, 802.11v, mc. So I 
assume it has the capability to do hardware time stamp when running 
applications like linux ptp (http://linuxptp.sourceforge.net/) and gptp 
(https://github.com/Avnu/gptp). However I get error that seems to 
suggest the timestamp mode is not supported.

After reading some source code, I discover that the /ptp4l/ application, 
or /gptp/, or /ethtool/ /-T/ , they all use a system call /ioctl/, which 
uses ethtool_ops call back to determine whether the hardware can do 
software/hardware timestamp.

However when searching in the driver/net/wireless/iwlwifi directory, I 
don't see anywhere /ethtool_ops/ is being implemented in the driver. So 
this most likely is why all user space tools I tried seem to determine 
the card cannot do hardware and also software (driver level) transmit 
timestamp.

Can someone tell me how I could run ptp like application to fully make 
use of the Timesync feature of intel card?

Some more details below:

root@localhost:/debug/tracing# ethtool -i wlp2s0
driver: iwlwifi
version: 5.4.6-050406-generic
firmware-version: 48.4fa0041f.0
expansion-rom-version:
bus-info: 0000:02:00.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no

root@localhost:/debug/tracing# ethtool -T wlp2s0
Time stamping parameters for wlp2s0:
Capabilities:
         software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
         software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
PTP Hardware Clock: none
Hardware Transmit Timestamp Modes: none
Hardware Receive Filter Modes: none
