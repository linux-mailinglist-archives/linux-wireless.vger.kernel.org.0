Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542C54E25A6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 12:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346927AbiCULxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346989AbiCULx1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 07:53:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EF9158DBA
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 04:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647863512;
        bh=lxADk2EV2QllEtm2/sm8fX9tATP3DX9MemLjuUyejt0=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=EGkMcwkvvBeNQEuCq23R0RnFJzipxvTP4ok6LhJUBcNo4SBGHu5dOOtfcrBLKvMdL
         h3rlSe1cWbyj1vZs47cfUwG5SCtxWec1dcR63seNehGtjI76abUt0OXUXxjsEVsgm+
         NXumBkJcKnE9NO2G2xgNjN4nXVeDSS5aJ3pTaT+4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from t460-skr.localnet ([194.94.225.5]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1nZlCf1XbB-00YTch for
 <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 12:51:52 +0100
From:   Stefan K <shadow_7@gmx.net>
To:     linux-wireless@vger.kernel.org
Subject: rtw89: unstable connection
Date:   Mon, 21 Mar 2022 12:51:49 +0100
Message-ID: <2127068.tFZMq15b3B@t460-skr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Provags-ID: V03:K1:F13RnWFf3q/YKCABavXYYxz6/McP8fIVwM3ill1BZdBNbqJDT0M
 QAWr6FxsrjaxQE+/dww+CBGGk17z0UhRsiK1zrBiAcFyVudjmUo4yevDbeSQPZBNrnKOqFJ
 nlXMAI7ruIQ03J7BnonGIaqjA6tFsjw1xblC1M6lGzLi21hEGv8ZLXotawYgOCz21TyINr0
 glVbfDqHjA6dTvgYQAB2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+FqRcfNojNg=:4cO5tFD9ZP4RnhcmteVZY2
 1YYONNu26KiHrc0WDKgqgUJ9nK4gtOkgsKnHt/qrfdtPvKz0WNs2GJ7Z01hA5TYRN1jXGD0GH
 tAl4FCvY0Fh16MogWhC1+wa+CTfhk57JWaWzOftojd9e7MpvLFryy385pdRHPwwLzBvPN+Dj7
 QTyUDfxUIvV4PCfjKdz4kZbZgE2vksQqKUHtCnSY0IsaOtYfCuCb7ANybUusiniwtwcLMConH
 h3KMVJsZID47d4A1stT6Z3fCdIg1pgQCdLwikFY3DXfYVGCcwkHo4GVt6GD/Qc+dA9+mLDDwF
 m8iEIv18AGWPkDsU0Hjr16CSK9tjUI0Kk9LyQr8h1OCf9T2/SG2CabeJuT2cpTKfFNe234Cpt
 nEeS31UDriUmZ25J0OOaSU8fACS7iLyKwnE42NF7Pu94pyyb2IFnEk6CrBJiH6xzFh3tyUpZ7
 0A64lRbEMX99ivPpTCKhERRDnmYRL8j1p89NknlVEyiMHESHy7e73/wZd8UuRh0ciQ7sLjF1i
 UUwRiRl9DnOC1LAWDt/X0WXdlG1W5PUJZ3rT0Rp8TS5tcgv0gorjgriW8Tv67I1A8YWI86XHc
 2hm8po06U277h8mE+J9WOJbnCfTZoZwVvIs+IUl7qtjFF2OgAAVEs8MH/rV+xf6qPf/COtp1M
 PwObw1uHn/u6GeWQI659s8/2JbQKAx3pM10Xw5E2/pKdGn2bUSPktPGgp1d7FHoz7JtbKDWrS
 BXiwpMtDnTbo2osdONIGK2IPVdw0ub+Cem0i31sYzTUS8ntzvp04fvePPKgHMD5mZ93qCXu56
 6cO0fJnW0Gi3URQcerrsUcJ4pqpnA0SFfy4nL+7cBc5wE7uZMmVf0fpcd+fNeyoSzEl8Eibn/
 qlDLnqgGfa8BFaHYngY3zo7jgGmeoYiCeSiByRSlTfLkEDBRTzB4Ch5YVnPa5zVZ5JpIx8oyb
 J/6HvbAddqYjHESd31WOO15hfTm9GxifHUcsKRWDifyUzUKAV5onFyc14Sm1qfTo/amP8xAYS
 Y7cGP0M80eS4icDS1xq4c2bYxU1WCoqsh9X8oC/+SxrqpjoAdH7kZY7TmFNSpnIhqkkoEImY0
 8/qoGj2mzkWAbU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I got an new Laptop (Lenovo T14 Gen2 AMD) and it has RTL8852AE chip, it can=
 connect to WiFi, but its very slow and unstable:
=2D-- 8.8.8.8 ping statistics ---
100 packets transmitted, 60 received, 60% packet loss, time 99514ms
rtt min/avg/max/mdev =3D 578.297/4515.244/10612.149/2763.037 ms, pipe 11

I'm running on Debian bullseye with backport Kernel Linux 5.16.0-0.bpo.3-am=
d64

I reported this on github (https://github.com/lwfinger/rtw89/issues/133) an=
d I added the following (as recommended):
cat /etc/modprobe.d/50-rtw89.conf=20
options rtw89_pci disable_aspm_l1=3Dy disable_aspm_l1ss=3Dy

but it still unstable.

Here are some sysinfo, and also some (dmesg) logs:

BIOS Information
        Vendor: LENOVO
        Version: R1MET43W (1.13 )
        Release Date: 11/05/2021
        Address: 0xE0000
        Runtime Size: 128 kB
        ROM Size: 32 MB
        Characteristics:
           [...]
        BIOS Revision: 1.13
        Firmware Revision: 1.13
System Information
        Manufacturer: LENOVO
        Product Name: 20XL0012GE
        Version: ThinkPad T14 Gen 2a
        Serial Number: PF3JWH2K
        UUID: 1a13b84c-2a59-11b2-a85c-9fa8ddbef6b3
        Wake-up Type: Power Switch
        SKU Number: LENOVO_MT_20XL_BU_Think_FM_ThinkPad T14 Gen 2a
        Family: ThinkPad T14 Gen 2a


lshw -C Network
[...]
  *-network
       description: Wireless interface
       product: Realtek Semiconductor Co., Ltd.
       vendor: Realtek Semiconductor Co., Ltd.
       physical id: 0
       bus info: pci@0000:03:00.0
       logical name: wlp3s0
       version: 00
       serial: e0:0a:f6:69:05:5b
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress bus_master cap_list ethernet physica=
l wireless
       configuration: broadcast=3Dyes driver=3Drtw89_pci driverversion=3D5.=
16.0-0.bpo.3-amd64 firmware=3DN/A ip=3D192.168.178.56 latency=3D0 link=3Dye=
s multicast=3Dyes wireless=3DIEEE 802.11
       resources: irq:109 ioport:3000(size=3D256) memory:fd800000-fd8fffff
[...]

modinfo rtw89_pci rtw89_core
filename:       /lib/modules/5.16.0-0.bpo.3-amd64/kernel/drivers/net/wirele=
ss/realtek/rtw89/rtw89_pci.ko
license:        Dual BSD/GPL
description:    Realtek 802.11ax wireless PCI driver
author:         Realtek Corporation
alias:          pci:v000010ECd0000A85Asv*sd*bc*sc*i*
alias:          pci:v000010ECd00008852sv*sd*bc*sc*i*
depends:        rtw89_core,mac80211
retpoline:      Y
intree:         Y
name:           rtw89_pci
vermagic:       5.16.0-0.bpo.3-amd64 SMP preempt mod_unload modversions
sig_id:         PKCS#7
signer:         Debian Secure Boot CA
sig_key:        4B:6E:F5:AB:CA:66:98:25:17:8E:05:2C:84:66:7C:CB:C0:53:1F:8C
sig_hashalgo:   sha256
signature:      14:B0:E0:87:29:FA:6A:84:2B:1E:A4:F3:5C:C7:D8:66:85:8C:08:4C:
                3F:A7:57:93:3B:2C:0F:D4:EA:C6:D0:9D:92:23:3E:D3:99:EE:BE:6B:
                0B:FB:64:BD:9E:8D:08:64:B0:42:E4:E1:FD:E5:39:96:42:DC:94:C3:
                75:4E:A6:CB:77:4E:7D:19:E1:E3:7A:D2:E2:B2:04:E5:FA:52:65:17:
                39:7D:09:AA:F6:33:AD:7B:96:B7:F2:AE:ED:76:5F:03:00:AC:E6:03:
                17:6B:63:55:55:BE:E9:66:EE:F2:89:C6:0E:8D:C6:28:2C:FD:8E:31:
                91:E6:B4:5A:56:33:BC:3B:12:6B:F4:A1:21:F1:1D:33:C2:FA:5C:F1:
                89:D2:0F:1C:69:52:24:B9:F7:9E:26:98:E2:26:3D:66:3E:DD:22:36:
                DA:15:02:C8:4E:BB:B6:82:97:13:F1:74:18:C4:01:F9:95:77:7D:56:
                E5:73:EF:33:41:6C:C3:2F:C0:7B:8E:4D:27:0D:F5:7C:E9:4B:B2:0D:
                73:CB:10:13:36:49:6B:E9:43:EE:50:A2:AE:2B:52:A0:86:D2:0B:7D:
                92:3B:7E:B4:79:B8:59:35:E2:9E:D1:BD:D3:5A:56:3B:04:0C:B7:CA:
                91:99:83:52:77:17:0D:DA:B4:E9:28:D7:DA:AE:0F:89
parm:           disable_clkreq:Set Y to disable PCI clkreq support (bool)
parm:           disable_aspm_l1:Set Y to disable PCI ASPM L1 support (bool)
parm:           disable_aspm_l1ss:Set Y to disable PCI L1SS support (bool)
filename:       /lib/modules/5.16.0-0.bpo.3-amd64/kernel/drivers/net/wirele=
ss/realtek/rtw89/rtw89_core.ko
license:        Dual BSD/GPL
description:    Realtek 802.11ax wireless core module
author:         Realtek Corporation
firmware:       rtw89/rtw8852a_fw.bin
depends:        mac80211,cfg80211
retpoline:      Y
intree:         Y
name:           rtw89_core
vermagic:       5.16.0-0.bpo.3-amd64 SMP preempt mod_unload modversions
sig_id:         PKCS#7
signer:         Debian Secure Boot CA
sig_key:        4B:6E:F5:AB:CA:66:98:25:17:8E:05:2C:84:66:7C:CB:C0:53:1F:8C
sig_hashalgo:   sha256
signature:      37:79:5C:38:36:11:42:5D:E7:5B:6A:49:94:98:88:84:D9:83:AC:27:
                2C:33:27:35:1B:67:78:FF:8E:B5:58:5C:E2:0D:EF:DE:CD:86:7B:4D:
                8A:43:22:D8:AF:BC:B2:96:C6:14:D0:2E:C5:D3:B1:48:78:1F:16:36:
                88:84:67:6C:BA:9B:9B:0A:31:80:C8:38:DB:53:20:B9:3D:15:07:67:
                88:44:5D:8F:25:42:79:54:FF:18:50:E2:A2:C9:DD:72:54:09:BB:30:
                0E:EF:4B:CF:FE:15:3C:C2:3B:8A:95:4C:35:50:6C:B2:34:0B:FC:42:
                9A:B0:73:9F:D3:84:C5:8D:4D:6D:3D:FB:CD:F0:A9:5E:A0:D3:7E:D0:
                30:41:54:34:47:B4:DA:DB:C3:B9:11:9E:48:FD:41:1B:87:E1:8E:1C:
                E2:8D:F8:13:6C:CC:59:BD:91:4F:38:67:E9:E2:A2:17:EE:40:DC:0C:
                D0:7A:95:27:B7:FD:7D:67:47:E3:9F:DA:3E:14:BE:9A:83:71:49:0F:
                F8:6C:43:7C:54:74:1B:24:A9:27:65:FF:53:1F:C3:84:E9:3E:E5:99:
                BB:BD:05:28:F8:E7:2D:2A:CC:3C:E2:5B:91:37:0E:BE:08:23:16:F8:
                1D:2C:B8:D6:E3:17:3D:F5:72:4D:C9:4A:F2:5C:4E:FE
parm:           disable_ps_mode:Set Y to disable low power mode (bool)


dmesg
[ 1532.499712] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1532.600273] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1532.700650] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1532.806014] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1532.806038] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1533.398877] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1533.499233] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1533.599538] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1533.699889] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1533.800254] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1533.900582] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1534.000633] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1534.101214] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1534.201533] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1534.301885] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1534.402465] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1534.502509] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1534.602803] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1534.703138] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1534.725183] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1534.725206] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1535.401467] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1535.501547] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1535.602014] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1535.702482] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1535.802844] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1535.903198] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1536.003188] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1536.103822] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1536.203911] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1536.304272] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1536.404867] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1536.505156] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1536.605485] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1536.705826] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1536.805591] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1536.805611] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1538.822049] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1538.822083] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1540.710036] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1540.710059] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1542.728595] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1542.728615] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1544.998036] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1544.998058] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1547.818933] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1547.818952] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1549.798995] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1549.799018] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1551.719098] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1551.719119] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1553.735425] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1553.735447] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1555.717518] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1555.717536] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1558.055504] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1558.055522] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1560.870232] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1560.870253] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1562.822255] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1562.822278] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1564.709816] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1564.709847] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1566.719238] rtw89_pci 0000:03:00.0: firmware failed to ack for leaving p=
s mode
[ 1630.115623] rtw89_pci 0000:03:00.0: timed out to flush queues
[ 1630.320105] rtw89_pci 0000:03:00.0: timed out to flush queues
[ 1631.320158] rtw89_pci 0000:03:00.0: c2h reg timeout
[ 1631.326248] rtw89_pci 0000:03:00.0: FW does not process h2c registers
[ 1631.736114] rtw89_pci 0000:03:00.0: timed out to flush queues
[ 1631.939589] rtw89_pci 0000:03:00.0: timed out to flush queues
[ 1631.945124] rtw89_pci 0000:03:00.0: FW does not process h2c registers
[ 1631.951214] rtw89_pci 0000:03:00.0: FW does not process h2c registers
[ 1632.066140] rtw89_pci 0000:03:00.0: FW does not process h2c registers
[ 1632.072099] rtw89_pci 0000:03:00.0: FW does not process h2c registers
[ 1632.484043] rtw89_pci 0000:03:00.0: timed out to flush queues
[ 1632.690538] rtw89_pci 0000:03:00.0: timed out to flush queues
[ 1632.696117] rtw89_pci 0000:03:00.0: FW does not process h2c registers
[ 1632.702281] rtw89_pci 0000:03:00.0: FW does not process h2c registers
[ 1632.818230] rtw89_pci 0000:03:00.0: FW does not process h2c registers
[ 1632.824559] rtw89_pci 0000:03:00.0: FW does not process h2c registers
[ 1633.234620] rtw89_pci 0000:03:00.0: timed out to flush queues
[ 1633.443416] rtw89_pci 0000:03:00.0: timed out to flush queues
[...]
[ 1709.105241] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1709.205584] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1709.305926] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1709.406305] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1709.506643] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1709.606994] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1709.707394] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1709.807912] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1709.859452] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode
[ 1709.859469] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1711.735583] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1711.828543] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1711.929152] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.029366] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.129845] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.230162] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.330218] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.430876] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.531080] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.631579] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.731702] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.832295] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1712.932433] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.032640] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.133232] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.233374] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.333912] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.434260] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.534650] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.634930] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.713215] rtw89_pci 0000:03:00.0:  [FWBB][WARN]Ttlen =3D 0x0018, macid=
cfg =3D 0x4e  0x00  0xe0  0x81
[ 1713.735048] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.835606] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1713.935949] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.035943] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.136497] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.237004] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.337285] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.437632] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.537901] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.638311] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.738646] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.839027] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1714.939089] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1715.039401] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1715.139861] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1715.240011] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1715.340797] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1715.440742] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1715.541131] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1715.641829] rtw89_pci 0000:03:00.0:  [FWBB][WARN][CMW] No specific sta c=
onnect
[ 1715.750333] rtw89_pci 0000:03:00.0: firmware failed to ack for entering =
ps mode


I hope someone can help me to fix this issue
Thanks in advance!

best regards
Stefan Kr=FCger



