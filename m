Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB37A4D01
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjIRPph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIRPpd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 11:45:33 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516A13E
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 08:44:06 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A0A9461E5FE01;
        Mon, 18 Sep 2023 15:46:06 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------Xnd4NhP4ZZPZet7I30eR0H3M"
Message-ID: <43e41620-c512-4569-bfb1-3dc82bbc0253@molgen.mpg.de>
Date:   Mon, 18 Sep 2023 15:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtlwifi: RTL8188EE: Unable to connect to Wifi network
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org, it+linux-wireless@molgen.mpg.de
References: <eb1885f2-abd9-1f1f-1c3e-c879372d8db0@molgen.mpg.de>
 <4899c9d3-acad-6cc0-e1ec-ab4b27754ecb@molgen.mpg.de>
 <fd317fc1-70e3-44bd-912a-07ce9aec0b86@lwfinger.net>
 <1f635ca8-28df-8762-4484-2b5daf896bb7@molgen.mpg.de>
 <61c69be4-daa3-95d5-47a7-856a5624fa9a@lwfinger.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <61c69be4-daa3-95d5-47a7-856a5624fa9a@lwfinger.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------Xnd4NhP4ZZPZet7I30eR0H3M
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Larry, dear Ping-Ke,


Am 15.11.22 um 23:21 schrieb Larry Finger:
> On 11/15/22 11:47, Paul Menzel wrote:
>>
>> Thank you for checking. Just a quick update, the user reported back, 
>> that Wifi is working fine at her home. So it must be some 
>> incompatibility with our institute Aruba access points/Wifi.
>>
>> Hopefully I have more time next week to gather more logs.
> 
> One thing that would be useful would be the in-the-air packets captured 
> with WireShark. That way we could see the actual probe and response.

I am sorry for not getting back to you earlier. The user worked around 
the situation at our institute with Aruba access points by using a wired 
connection, the laptop luckily still has.

The current stack is *linux-image-6.4.0-2-amd64* 6.4.4-3, 
*wpasupplicant* 2:2.10-15, and *network-manager* 1.44.0-1.

Remotely, I installed *tshark* 4.0.8-1, enabled the Wifi

     $ sudo nmcli radio wifi on

and started capturing.

     $ tshark -i wlp8s0 -w /dev/shm/20230918--linux-6.4.4--tshark.pcapng
     Capturing on 'wlp8s0'
      ** (tshark:106220) 15:33:22.465772 [Main MESSAGE] -- Capture started.
      ** (tshark:106220) 15:33:22.465887 [Main MESSAGE] -- File: 
"/dev/shm/20230918--linux-6.4.4--tshark.pcapng"
     63 ^C
     tshark:

`nmcli` showed the status below:

     wlp8s0: connecting (getting IP configuration) to MPI Guest
             "Realtek RTL8188EE"
             wifi (rtl8188ee), 54:27:1E:F6:B8:D3, hw, mtu 1500

Please find the capture attached.


Kind regards,

Paul


PS: Output of `journalctl -b -u wpa_supplicant.service -u 
NetworkManager.service`:

```
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.2283] 
manager: rfkill: Wi-Fi hardware radio set enabled
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.6391] 
audit: op="radio-control" arg="wireless-enabled:on" pid=106213 uid=0 
result="success"
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.6395] 
manager: rfkill: Wi-Fi now enabled by radio killswitch
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.6789] 
device (wlp8s0): supplicant interface state: internal-starting -> 
disconnected
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.6789] 
device (p2p-dev-wlp8s0): state change: unavailable -> unmanaged (reason 
'removed', sys-iface-state: 'removed')
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.6799] 
Wi-Fi P2P device controlled by interface wlp8s0 created
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.6803] 
manager: (p2p-dev-wlp8s0): new 802.11 Wi-Fi P2P device 
(/org/freedesktop/NetworkManager/Devices/9)
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.6807] 
device (p2p-dev-wlp8s0): state change: unmanaged -> unavailable (reason 
'managed', sys-iface-state: 'external')
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.6820] 
device (wlp8s0): state change: unavailable -> disconnected (reason 
'supplicant-available', sys-iface-state: 'managed')
Sep 18 15:33:21 brecht NetworkManager[842]: <info>  [1695044001.6829] 
device (p2p-dev-wlp8s0): state change: unavailable -> disconnected 
(reason 'none', sys-iface-state: 'managed')
Sep 18 15:33:22 brecht NetworkManager[842]: <info>  [1695044002.8271] 
policy: auto-activating connection 'MPI Guest' 
(c595bdf3-5106-4f32-a302-1ed03d93634a)
Sep 18 15:33:22 brecht NetworkManager[842]: <info>  [1695044002.8284] 
device (wlp8s0): Activation: starting connection 'MPI Guest' 
(c595bdf3-5106-4f32-a302-1ed03d93634a)
Sep 18 15:33:22 brecht NetworkManager[842]: <info>  [1695044002.8287] 
device (wlp8s0): state change: disconnected -> prepare (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:33:22 brecht NetworkManager[842]: <info>  [1695044002.8512] 
device (wlp8s0): set-hw-addr: reset MAC address to 54:27:1E:F6:B8:D3 
(preserve)
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2511] 
device (wlp8s0): state change: prepare -> config (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2515] 
device (wlp8s0): Activation: (wifi) connection 'MPI Guest' requires no 
security.  No secrets needed.
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2515] 
Config: added 'ssid' value 'MPI Guest'
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2516] 
Config: added 'scan_ssid' value '1'
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2516] 
Config: added 'bgscan' value 'simple:30:-65:300'
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2516] 
Config: added 'key_mgmt' value 'NONE'
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2521] 
device (wlp8s0): supplicant interface state: disconnected -> 
interface_disabled
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2521] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
disconnected -> interface_disabled
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2660] 
device (wlp8s0): supplicant interface state: interface_disabled -> inactive
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2660] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
interface_disabled -> inactive
Sep 18 15:33:23 brecht wpa_supplicant[73197]: wlp8s0: SME: Trying to 
authenticate with 6c:f3:7f:10:a4:12 (SSID='MPI Guest' freq=2437 MHz)
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2792] 
device (wlp8s0): supplicant interface state: inactive -> authenticating
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2793] 
device (p2p-dev-wlp8s0): supplicant management interface state: inactive 
-> authenticating
Sep 18 15:33:23 brecht wpa_supplicant[73197]: wlp8s0: Trying to 
associate with 6c:f3:7f:10:a4:12 (SSID='MPI Guest' freq=2437 MHz)
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2906] 
device (wlp8s0): supplicant interface state: authenticating -> associating
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.2906] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
authenticating -> associating
Sep 18 15:33:23 brecht wpa_supplicant[73197]: wlp8s0: Associated with 
6c:f3:7f:10:a4:12
Sep 18 15:33:23 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-CONNECTED - Connection to 6c:f3:7f:10:a4:12 completed [id=0 
id_str=]
Sep 18 15:33:23 brecht wpa_supplicant[73197]: bgscan simple: Failed to 
enable signal strength monitoring
Sep 18 15:33:23 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.3092] 
device (wlp8s0): supplicant interface state: associating -> completed
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.3093] 
device (wlp8s0): Activation: (wifi) Stage 2 of 5 (Device Configure) 
successful. Connected to wireless network "MPI Guest"
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.3093] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
associating -> completed
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.3106] 
device (wlp8s0): state change: config -> ip-config (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:33:23 brecht NetworkManager[842]: <info>  [1695044003.3125] 
dhcp4 (wlp8s0): activation: beginning transaction (timeout in 45 seconds)
Sep 18 15:34:08 brecht NetworkManager[842]: <info>  [1695044048.9884] 
device (wlp8s0): state change: ip-config -> failed (reason 
'ip-config-unavailable', sys-iface-state: 'managed')
Sep 18 15:34:09 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-DISCONNECTED bssid=6c:f3:7f:10:a4:12 reason=3 locally_generated=1
Sep 18 15:34:09 brecht wpa_supplicant[73197]: BSSID 6c:f3:7f:10:a4:12 
ignore list count incremented to 2, ignoring for 10 seconds
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.0350] 
device (wlp8s0): set-hw-addr: set MAC address to D6:0D:AC:C9:48:A4 
(scanning)
Sep 18 15:34:09 brecht NetworkManager[842]: <warn>  [1695044049.4456] 
device (wlp8s0): Activation: failed for connection 'MPI Guest'
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.4459] 
device (wlp8s0): supplicant interface state: completed -> interface_disabled
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.4460] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
completed -> interface_disabled
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.4477] 
device (wlp8s0): state change: failed -> disconnected (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.4730] 
dhcp4 (wlp8s0): canceled DHCP transaction
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.4731] 
dhcp4 (wlp8s0): activation: beginning transaction (timeout in 45 seconds)
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.4731] 
dhcp4 (wlp8s0): state changed no lease
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.4748] 
device (wlp8s0): supplicant interface state: interface_disabled -> scanning
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.4749] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
interface_disabled -> scanning
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.6257] 
device (wlp8s0): supplicant interface state: scanning -> disconnected
Sep 18 15:34:09 brecht NetworkManager[842]: <info>  [1695044049.6258] 
device (p2p-dev-wlp8s0): supplicant management interface state: scanning 
-> disconnected
Sep 18 15:34:10 brecht NetworkManager[842]: <info>  [1695044050.7163] 
device (wlp8s0): supplicant interface state: disconnected -> inactive
Sep 18 15:34:10 brecht NetworkManager[842]: <info>  [1695044050.7164] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
disconnected -> inactive
Sep 18 15:34:10 brecht NetworkManager[842]: <info>  [1695044050.7169] 
policy: auto-activating connection 'MPI Guest' 
(c595bdf3-5106-4f32-a302-1ed03d93634a)
Sep 18 15:34:10 brecht NetworkManager[842]: <info>  [1695044050.7183] 
device (wlp8s0): Activation: starting connection 'MPI Guest' 
(c595bdf3-5106-4f32-a302-1ed03d93634a)
Sep 18 15:34:10 brecht NetworkManager[842]: <info>  [1695044050.7185] 
device (wlp8s0): state change: disconnected -> prepare (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:34:10 brecht NetworkManager[842]: <info>  [1695044050.7424] 
device (wlp8s0): set-hw-addr: reset MAC address to 54:27:1E:F6:B8:D3 
(preserve)
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1519] 
device (wlp8s0): state change: prepare -> config (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1524] 
device (wlp8s0): Activation: (wifi) connection 'MPI Guest' requires no 
security.  No secrets needed.
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1525] 
Config: added 'ssid' value 'MPI Guest'
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1525] 
Config: added 'scan_ssid' value '1'
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1525] 
Config: added 'bgscan' value 'simple:30:-65:300'
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1525] 
Config: added 'key_mgmt' value 'NONE'
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1554] 
device (wlp8s0): supplicant interface state: inactive -> interface_disabled
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1555] 
device (p2p-dev-wlp8s0): supplicant management interface state: inactive 
-> interface_disabled
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1594] 
device (wlp8s0): supplicant interface state: interface_disabled -> inactive
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1594] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
interface_disabled -> inactive
Sep 18 15:34:11 brecht wpa_supplicant[73197]: wlp8s0: SME: Trying to 
authenticate with 6c:f3:7f:10:a4:12 (SSID='MPI Guest' freq=2437 MHz)
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1740] 
device (wlp8s0): supplicant interface state: inactive -> authenticating
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1740] 
device (p2p-dev-wlp8s0): supplicant management interface state: inactive 
-> authenticating
Sep 18 15:34:11 brecht wpa_supplicant[73197]: wlp8s0: Trying to 
associate with 6c:f3:7f:10:a4:12 (SSID='MPI Guest' freq=2437 MHz)
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1820] 
device (wlp8s0): supplicant interface state: authenticating -> associating
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.1821] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
authenticating -> associating
Sep 18 15:34:11 brecht wpa_supplicant[73197]: wlp8s0: Associated with 
6c:f3:7f:10:a4:12
Sep 18 15:34:11 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-CONNECTED - Connection to 6c:f3:7f:10:a4:12 completed [id=0 
id_str=]
Sep 18 15:34:11 brecht wpa_supplicant[73197]: bgscan simple: Failed to 
enable signal strength monitoring
Sep 18 15:34:11 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.2005] 
device (wlp8s0): supplicant interface state: associating -> completed
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.2006] 
device (wlp8s0): Activation: (wifi) Stage 2 of 5 (Device Configure) 
successful. Connected to wireless network "MPI Guest"
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.2006] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
associating -> completed
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.2009] 
device (wlp8s0): state change: config -> ip-config (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:34:11 brecht NetworkManager[842]: <info>  [1695044051.2022] 
dhcp4 (wlp8s0): activation: beginning transaction (timeout in 45 seconds)
Sep 18 15:34:55 brecht NetworkManager[842]: <info>  [1695044095.9885] 
device (wlp8s0): state change: ip-config -> failed (reason 
'ip-config-unavailable', sys-iface-state: 'managed')
Sep 18 15:34:56 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-DISCONNECTED bssid=6c:f3:7f:10:a4:12 reason=3 locally_generated=1
Sep 18 15:34:56 brecht wpa_supplicant[73197]: BSSID 6c:f3:7f:10:a4:12 
ignore list count incremented to 2, ignoring for 10 seconds
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.0232] 
device (wlp8s0): set-hw-addr: set MAC address to 06:9E:A3:55:38:AA 
(scanning)
Sep 18 15:34:56 brecht NetworkManager[842]: <warn>  [1695044096.4239] 
device (wlp8s0): Activation: failed for connection 'MPI Guest'
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.4242] 
device (wlp8s0): supplicant interface state: completed -> interface_disabled
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.4242] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
completed -> interface_disabled
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.4253] 
device (wlp8s0): state change: failed -> disconnected (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.4571] 
dhcp4 (wlp8s0): canceled DHCP transaction
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.4571] 
dhcp4 (wlp8s0): activation: beginning transaction (timeout in 45 seconds)
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.4571] 
dhcp4 (wlp8s0): state changed no lease
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.4623] 
device (wlp8s0): supplicant interface state: interface_disabled -> scanning
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.4623] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
interface_disabled -> scanning
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.5685] 
device (wlp8s0): supplicant interface state: scanning -> disconnected
Sep 18 15:34:56 brecht NetworkManager[842]: <info>  [1695044096.5686] 
device (p2p-dev-wlp8s0): supplicant management interface state: scanning 
-> disconnected
Sep 18 15:34:57 brecht NetworkManager[842]: <info>  [1695044097.6519] 
device (wlp8s0): supplicant interface state: disconnected -> inactive
Sep 18 15:34:57 brecht NetworkManager[842]: <info>  [1695044097.6520] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
disconnected -> inactive
Sep 18 15:34:57 brecht NetworkManager[842]: <info>  [1695044097.6574] 
policy: auto-activating connection 'MPI Guest' 
(c595bdf3-5106-4f32-a302-1ed03d93634a)
Sep 18 15:34:57 brecht NetworkManager[842]: <info>  [1695044097.6590] 
device (wlp8s0): Activation: starting connection 'MPI Guest' 
(c595bdf3-5106-4f32-a302-1ed03d93634a)
Sep 18 15:34:57 brecht NetworkManager[842]: <info>  [1695044097.6594] 
device (wlp8s0): state change: disconnected -> prepare (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:34:57 brecht NetworkManager[842]: <info>  [1695044097.6782] 
device (wlp8s0): set-hw-addr: reset MAC address to 54:27:1E:F6:B8:D3 
(preserve)
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0794] 
device (wlp8s0): state change: prepare -> config (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0800] 
device (wlp8s0): Activation: (wifi) connection 'MPI Guest' requires no 
security.  No secrets needed.
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0801] 
Config: added 'ssid' value 'MPI Guest'
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0801] 
Config: added 'scan_ssid' value '1'
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0801] 
Config: added 'bgscan' value 'simple:30:-65:300'
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0802] 
Config: added 'key_mgmt' value 'NONE'
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0806] 
device (wlp8s0): supplicant interface state: inactive -> interface_disabled
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0806] 
device (p2p-dev-wlp8s0): supplicant management interface state: inactive 
-> interface_disabled
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0939] 
device (wlp8s0): supplicant interface state: interface_disabled -> inactive
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.0940] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
interface_disabled -> inactive
Sep 18 15:34:58 brecht wpa_supplicant[73197]: wlp8s0: SME: Trying to 
authenticate with 6c:f3:7f:10:a4:12 (SSID='MPI Guest' freq=2437 MHz)
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.1071] 
device (wlp8s0): supplicant interface state: inactive -> authenticating
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.1072] 
device (p2p-dev-wlp8s0): supplicant management interface state: inactive 
-> authenticating
Sep 18 15:34:58 brecht wpa_supplicant[73197]: wlp8s0: Trying to 
associate with 6c:f3:7f:10:a4:12 (SSID='MPI Guest' freq=2437 MHz)
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.1140] 
device (wlp8s0): supplicant interface state: authenticating -> associating
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.1141] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
authenticating -> associating
Sep 18 15:34:58 brecht wpa_supplicant[73197]: wlp8s0: Associated with 
6c:f3:7f:10:a4:12
Sep 18 15:34:58 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-CONNECTED - Connection to 6c:f3:7f:10:a4:12 completed [id=0 
id_str=]
Sep 18 15:34:58 brecht wpa_supplicant[73197]: bgscan simple: Failed to 
enable signal strength monitoring
Sep 18 15:34:58 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.1329] 
device (wlp8s0): supplicant interface state: associating -> completed
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.1333] 
device (wlp8s0): Activation: (wifi) Stage 2 of 5 (Device Configure) 
successful. Connected to wireless network "MPI Guest"
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.1336] 
device (p2p-dev-wlp8s0): supplicant management interface state: 
associating -> completed
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.1343] 
device (wlp8s0): state change: config -> ip-config (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:34:58 brecht NetworkManager[842]: <info>  [1695044098.1354] 
dhcp4 (wlp8s0): activation: beginning transaction (timeout in 45 seconds)
Sep 18 15:35:42 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-DISCONNECTED bssid=6c:f3:7f:10:a4:12 reason=3 locally_generated=1
Sep 18 15:35:42 brecht wpa_supplicant[73197]: BSSID 6c:f3:7f:10:a4:12 
ignore list count incremented to 2, ignoring for 10 seconds
Sep 18 15:35:42 brecht wpa_supplicant[73197]: rfkill: WLAN soft blocked
Sep 18 15:35:42 brecht NetworkManager[842]: <info>  [1695044142.0358] 
manager: rfkill: Wi-Fi hardware radio set disabled
Sep 18 15:35:42 brecht NetworkManager[842]: <info>  [1695044142.0359] 
device (wlp8s0): state change: ip-config -> unavailable (reason 'none', 
sys-iface-state: 'managed')
Sep 18 15:35:42 brecht NetworkManager[842]: <info>  [1695044142.0530] 
dhcp4 (wlp8s0): canceled DHCP transaction
Sep 18 15:35:42 brecht NetworkManager[842]: <info>  [1695044142.0531] 
dhcp4 (wlp8s0): state changed no lease
Sep 18 15:35:42 brecht NetworkManager[842]: <info>  [1695044142.0548] 
device (wlp8s0): set-hw-addr: set MAC address to B2:A0:91:38:AF:39 
(scanning)
Sep 18 15:35:42 brecht NetworkManager[842]: <info>  [1695044142.0597] 
audit: op="radio-control" arg="wireless-enabled:off" pid=106337 uid=0 
result="success"
Sep 18 15:35:42 brecht NetworkManager[842]: <info>  [1695044142.0605] 
manager: rfkill: Wi-Fi now disabled by radio killswitch
Sep 18 15:35:42 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-DSCP-POLICY clear_all
Sep 18 15:35:42 brecht NetworkManager[842]: <info>  [1695044142.0616] 
device (p2p-dev-wlp8s0): state change: disconnected -> unavailable 
(reason 'supplicant-failed', sys-iface-state: 'managed')
Sep 18 15:35:42 brecht wpa_supplicant[73197]: wlp8s0: 
CTRL-EVENT-DSCP-POLICY clear_all
Sep 18 15:35:42 brecht wpa_supplicant[73197]: nl80211: deinit 
ifname=wlp8s0 disabled_11b_rates=0
```
--------------Xnd4NhP4ZZPZet7I30eR0H3M
Content-Type: application/x-pcapng;
 name="20230918--linux-6.4.4--tshark.pcapng"
Content-Disposition: attachment;
 filename="20230918--linux-6.4.4--tshark.pcapng"
Content-Transfer-Encoding: base64

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

--------------Xnd4NhP4ZZPZet7I30eR0H3M--
