Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD996BB1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 23:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfHTVp3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 17:45:29 -0400
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:58168 "EHLO
        resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729900AbfHTVp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 17:45:29 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 17:45:29 EDT
Received: from resomta-po-02v.sys.comcast.net ([96.114.154.226])
        by resqmta-po-10v.sys.comcast.net with ESMTP
        id 0AK5ien1yELdD0BofiXRgQ; Tue, 20 Aug 2019 21:37:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1566337041;
        bh=UhDBttiLRJbW+K/1QYuR4RJzGSjujyufOihg+1sy1Wk=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=RaaUaR3zdmEaLOCoTbFYzgs4s5Wg79dRm7ZSTrg6ARb+Q2K65zaFAjmvmU+YtdZCm
         UKshhRi4BQWVbaLFSlt3sR3N0G6wsTTA6FQbvaqhVBP+LaAH9X4k67avzM2ysKSufF
         1SKaZpmErgwfIBkC2GhUovpQsUapTyp69ERzk4M+AhUIbPAUKITVzXELIfSbMr0J3u
         yCphvqJoMHpf3vZ2oHZ5vrf6oYNcxrpi6jdpijWaiyGs6a1+nuN6NM5+/+Bn1EMFmz
         MMimiIsn8xWS9bbFJMnWQYGh9RLaMPGPzIevk7QxWYhhuU+2eYxVGQ1iI+nQC6a2HZ
         s8hGxdwGwRrmA==
Received: from touchy.whiterc.com ([IPv6:2601:601:1400:69b3:e5f4:286a:2b22:968c])
        by resomta-po-02v.sys.comcast.net with ESMTPSA
        id 0BoeivRXmSllN0Boei58Jt; Tue, 20 Aug 2019 21:37:21 +0000
X-Xfinity-VMeta: sc=0;st=legit
To:     linux-wireless@vger.kernel.org
From:   Robert White <rwhite@pobox.com>
Subject: ACS for ath10k?
Message-ID: <cfd40fca-11f1-d123-956b-ab6a8ab291b5@pobox.com>
Date:   Tue, 20 Aug 2019 21:37:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For a brief shining moment several months ago the ath10k board I kitted 
up for my access point... worked. I wish I remembered the details. 
Anyway, now days hostapd ACS fails with:

Configuration file: hostapd.conf.experimental
wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
ACS: Automatic channel selection started, this may take a bit
wlan0: interface state COUNTRY_UPDATE->ACS
wlan0: ACS-STARTED
ACS: Survey is missing noise floor
ACS: Survey is missing noise floor
ACS: Survey is missing noise floor
ACS: Survey is missing noise floor
ACS: Survey is missing noise floor
ACS: Channel 52 has insufficient survey data
...
ACS: Survey is missing noise floor
ACS: Survey is missing noise floor
ACS: Survey is missing noise floor
ACS: Survey is missing noise floor
ACS: Survey is missing noise floor
ACS: Channel 144 has insufficient survey data
ACS: Surveys have insufficient data
ACS: All study options have failed
Interface initialization failed
wlan0: interface state ACS->DISABLED
wlan0: AP-DISABLED
ACS: Possibly channel configuration is invalid, please report this along 
with your config file.
ACS: Failed to start
wlan0: AP-DISABLED
hostapd_free_hapd_data: Interface wlan0 wasn't started
nl80211: deinit ifname=wlan0 disabled_11b_rates=0
wlan0: interface state DISABLED->DISABLED
wlan0: interface state DISABLED->DISABLED
wlan0: AP-DISABLED
wlan0: CTRL-EVENT-TERMINATING
hostapd_free_hapd_data: Interface wlan0 wasn't started

In dmesg I get about 200 (if I include the suppressed redundant 
messages) copies of
ath10k_pci 0000:03:00.0: failed to parse chan info event: -71

preceeded by:
[  389.383439] ath10k_pci 0000:03:00.0: unsupported HTC service id: 1536



Relevant info:
[   15.279360] ath10k_pci 0000:03:00.0: limiting irq mode to: 2
[   15.279446] ath10k_pci 0000:03:00.0: pci irq msi oper_irq_mode 2 
irq_mode 2 reset_mode 0
[   15.834892] ath10k_pci 0000:03:00.0: qca988x hw2.0 target 0x4100016c 
chip_id 0x043202ff sub 0000:0000
[   15.834900] ath10k_pci 0000:03:00.0: kconfig debug 0 debugfs 1 
tracing 0 dfs 1 testmode 0
[   15.835488] ath10k_pci 0000:03:00.0: firmware ver 10.2.4-1.0-00045 
api 5 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 ccbd5104
[   15.913439] ath10k_pci 0000:03:00.0: board_file api 1 bmi_id N/A 
crc32 bebc7c08
[   17.022617] ath10k_pci 0000:03:00.0: unsupported HTC service id: 1536
[   17.043897] ath10k_pci 0000:03:00.0: htt-ver 2.1 wmi-op 5 htt-op 2 
cal otp max-sta 128 raw 0 hwcrypto 1
[   17.100699] ath: EEPROM regdomain: 0x6a
[   17.100701] ath: EEPROM indicates we should expect a direct regpair map
[   17.100703] ath: Country alpha2 being used: 00
[   17.100704] ath: Regpair used: 0x6a


Note that if I manually select a channel the AP runs fine, so everythign 
else seemes to be good except the parse error or firmware issue.


lspci output:

03:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac 
Wireless Network Adapter

Am I just SOL?
Is there a way to check/dump the channel info event that cannot be parsed?


--Rob.
