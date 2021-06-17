Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928903AB818
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhFQQEr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:04:47 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232382AbhFQQEp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:04:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvvxvDS1/z3FmgymxAdk7DHMCqSjLxedzCMhO+CWpSqxs9Ha0UYbXYHnLE+pcWeHYTVc5ha0syryalD8Xfnaxq2+B6VgEEUPfTLKdDDphTnj5D6XncBu2mc4u22L491qWTC4yWZavYiiopci+wYAviL0v4SG2b+aQmpOvEuEbEQhmGq3bZ0MU2+jPaaNYUeX2gbaGGEh0qXLCScK0FY0rfMMXcIlrs48wyR85itpZLNAAyTYP4gkrdYn8Rdv1h605JCeruqfIAcw67ClWSAuUkEgWGIaPizMSGyr5Pi2ePYyzsIdFFPlIl3fXcALMGe+I2kcWqPZN8gjOzHYxAOfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3PLb5kQsUp8RdxGKsGyY7zK7vSRn3UpvWSESg8R2EM=;
 b=fifjtjVVFQxWlSdECv6crR9BY5SuFsgZJfUm/r9JhTU6tbtI92nyvfyGZs0Jeif0oOZh9fGDH4xpnQ4RTBnDZycUDKIIUzC4HgEYyf7K/4DcTmgropU53KYEfz/qvX7BRi/cJK6G2GyCKt6k50YMCOtEmIdCK/pWg+CRr7y8xmj0PZ6FIVzdsEKANpIt7Dj41E0gXM/ZzdGVEmemY7WPkXOovFY3W1kxZkMjNi1uYIudpMtrsO2Y5Kfo3yTpNpvo8WvuXCNLS+ssgKuEI8X+jnFCUgwC/LEsOgBbzMZhrE0L0R0frtFaZcR2ddMipHvBY0XDJxnhOn/ymxuXfAXbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3PLb5kQsUp8RdxGKsGyY7zK7vSRn3UpvWSESg8R2EM=;
 b=PySZ1zAoRxT1aii7SSWpVoGQSuI6kUfTdokZJveh6/bNU17FLKbtTUFuocrUSymIUmZU/IaalY42dJXV8RiuH8ciGLKKVUn1vrSAL1R8HOFpBRK9jH5lO0Km2UfIovIId8GGgFPSTCxvPD9Bnt92O09rM5244+25zcESxUZVoq8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:33 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:32 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 000/256] wireless: cl8k driver for Celeno IEEE 802.11ax devices
Date:   Thu, 17 Jun 2021 15:58:07 +0000
Message-Id: <20210617160223.160998-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 735ecf34-a41a-41a9-8dfc-08d931a950e8
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1412224389546D93C99B190AF60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaqR/Dl3qbdyz9Ul+UdamhqV1a00Q0ICUyxfHIk67khCSEA+dy2pb4A+2XcwhFj5ITbQm4yVOkC5/XL87jiQPpz8IwG3R/a9cXduv7hBFn5ILz9leGgUtwqR+OSTiYu6EwHr9VV5DuVJlRD2KNRy6eMCw9X4KpQbPtqYstED9NlcPSZ7wWlZBNwFEHhbakWgBXBkZ3TFZPdL1Z/cwBVAdOx5IeLFr5keHhXkVdkVza60mAjrDF0Zk6fmiLsrNZPr7BZMjkSavokbxJtoZJwkQDMB1oRrOjbeG2J6aoKbxa2i37DVxmLx1JFWSgffO9XjsTZJFVgp6izIkh2hbg/f5H/uaoo1fDAeYgyVKEuaR4+L4mho4lgyobqeUXP5PGRy/xpWM1Fti9HQHbpc1eexkm9o0uq7oy4n3q3gIRMGyptc5qG0ZDlzfoILuUwIuSsPeHorgG/A9bKAyA7GYGfHhqwp7D35fGUQuBaBdw80Cys+rxLvrvTLR0jfdaXddLF0WOpgLr0bdimNOjQUky1Xnh6vnitoqu78fcsofozMCbKto318CIafB156S3uzG2409w853cwiwLjgIYCAqrYThcUqC+TmzmAFavnO1GOxw7T3IfVnDJMb1clmT/0fTci6zBfomPhfmOeZxdKF7Icz8r9zEcuNRZJS0IggaDg4foI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(30864003)(6916009)(54906003)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGdlMmtYZVJxZHJ5c2Jzc1d1V2JERzRVMWlUYUorMk1oZSsvZHBMZTgzOFd6?=
 =?utf-8?B?d2I1ZDVDNDhLcmdSVllMcU5FbWdPUUxDazNEMXRGUDAycFAydnk2MWFsTWJ6?=
 =?utf-8?B?VXlaWFFkZzlYWnAxSFdPSXZMZlVvSHdDS2xhNHNRRkdyTGtYY0pFSDI4R1hx?=
 =?utf-8?B?UUlRK2JXeG1tTGU0Q3lqQXRQWHRZL2sxTW9wZG1pcjlCalVEZXo2cURBNGlP?=
 =?utf-8?B?cXcyMmFhVUhJdjFoQ1VCUnFtLzFQdG1kMzdHN3k5Qks4TTBHMGI1b3prM0pq?=
 =?utf-8?B?STBFVDVMVnFGY0dabFkyU1ZGUUhQcEcrb3NOQU5FenFOWkxjMXp5blZQZzc1?=
 =?utf-8?B?NGxSQ2lNdkhvL2JPUEc4dTlLVHRYVEs2NlBFNFo3SnpjWE5vbmJqcldlN3dv?=
 =?utf-8?B?am14N2xuS3ZPZ0dZRzRIUTB4b0FJOHA1bUlsbzlJMHkrQzRuMjdhOFNOTE5q?=
 =?utf-8?B?ZXpxM1AyeFU0cmZFcmdTc1JMLzdaSVBIMC9WZndUQ2lEU1Vjb05HV3IvZ1lI?=
 =?utf-8?B?WEw0V09aMDVST00wVlYvb2tmTDhPUEk1UTlyNkcwcWlZbmUzajkwNEwraVYy?=
 =?utf-8?B?bERMd3dPMWFIM2U2OEhIUWV1cHcxQi9BY2xWUGljSXJEMkppa051b1kvaHVR?=
 =?utf-8?B?cXlGdWZKUzZqUTAvbFY1N0VlMDBwQ2tIZVZsVHR5NUJua2lKcVdndUZCNTk4?=
 =?utf-8?B?Nkk3MXBYazVGUFZWNmxiUHdsNHBjemR2NW1uTUhZRVdKUVVTRkthOTN0bDZy?=
 =?utf-8?B?SHV2SzM3TklhNEJJUGdjNnRWQktxeTJtbmxDbGdLVUkvRU1NRUwrQWl5Zmgw?=
 =?utf-8?B?VEdwckZjWElxSFFwNUNPdCtPNmFzOGd4MTNqQk42YnRVdXJSWTNSd1E3ZjJF?=
 =?utf-8?B?S0VmNEhxdTR4Nmd0Q282elNXTytMWENHNFRZUjFEWmM4KzBVa1d2U0M2cUIz?=
 =?utf-8?B?QlBHM1FvR0RQenVjTXZMMTFaSEFWRVpJdEJqQUEzekdQMnV4eC9MRlpIY0Rr?=
 =?utf-8?B?eDZJOUtKN2dTdGZVNGtKa0gvaVhsZmxGZ0RUdFZzVzF5OWhrZ00wMk5TNW9B?=
 =?utf-8?B?eFNUc0paRlM1MEpFdGdDOFZ2YWVQV1lNeHVrQ1R3TndodzcxVUpKUFhEWEJJ?=
 =?utf-8?B?UFQwQ0pmVmw2MFJkN0ZGWiswaHIweVpOVGdoVGNRZTR4eW1wOU4wdEZBekhX?=
 =?utf-8?B?WDZNWVV5MEJSQ2p3VSt2c0x5ZGpWalVySFB3cFQyUmVDSHZxSDNxTkhqR2Nw?=
 =?utf-8?B?Q1QxZmdFNmQ3WVZORmpTTDBucmVSb3MyUGVNVVBHN0V3SGM4eXZCbnpsbk5M?=
 =?utf-8?B?UHF2SUVKMWNCVXFIQ2F0T1FGYkFXTnBUNXVJTWNIZi9HdGxScnZMYVJXRFlR?=
 =?utf-8?B?K3FLRFBSRjd0YSt5a2N4QU96emZJdFQ2THNVTloxaEhRWUtVZ1Y1cnNpTHp4?=
 =?utf-8?B?NmV5YTF0OGwwT1VKYVRCa2ROV1ZZWVY4a0tsR21wNjhoL2ZSSCtOWHFPMW80?=
 =?utf-8?B?RDIwMUlXbWJUYzVuTjhIa2hxSWpQUFl4WGZXYnluM2UvbnBvbGNpRmg1QlZ1?=
 =?utf-8?B?cGRsK1pVSjhjcmd6ZVBtaGFvM25jSllJL2U4YjZveHMya0ZnVlNMV0Q4NWtq?=
 =?utf-8?B?QmJWUzlqM3NITmF5YlpCcE1CUG04TFdGVUMzZ0dWR0ZDdU5KQUhQOHp6VE9z?=
 =?utf-8?B?aUUweFpnbGVITU1TbUZBTjRSKzZGVWRPUERJcGhkUllQNGIzVmVYTW9lOCtj?=
 =?utf-8?Q?PN9kqx01X0rKflysjqtYjALGSsMZZj8lX57vfl4?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735ecf34-a41a-41a9-8dfc-08d931a950e8
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:32.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4n1KVq5b4e0UBgYzB6c4JnHqBOMxk+hIv9VDXA5p+Oc9hCWJSpffY8CMEGj9JHXhoGskgAkHjMy0NMf9DG8Hfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

Celeno Communications publishes to the opensource new wireless driver
for an own 802.11 chipset family - 80xx. The main chip supports multiple
simultaneous bands functioning (2.4G/5.2G or 5.2G/6G) over PCIe 3.0
dual-lane interface. Basically, the chip is dual-band concurrent up to
8x8 in total, and up to 6x6 per band, including 802.11ax 160MHz support
and functioning of AP/STA/MESH modes. The driver architecture is strong
SoftMAC.

The current patchset is considered to be published in form of RFC
(Request for Comments). If there are any suggestions/propositions - we
will be glad to fix them and eventually share the driver with the
community in form of an official patch (including the firmware
binaries).

The RFC is divided into separate patches on a per-file basis to simplify
the review process.

Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
Signed-off-by: Eliav Farber <eliav.farber@gmail.com>
Signed-off-by: Oleksandr Savchenko <oleksandr.savchenko@celeno.com>
Signed-off-by: Shay Bar <shay.bar@celeno.com>
Signed-off-by: Viktor Barna <viktor.barna@celeno.com>

Viktor Barna (256):
  celeno: add Kconfig
  celeno: add Makefile
  cl8k: add Kconfig
  cl8k: add Makefile
  cl8k: add afe.c
  cl8k: add afe.h
  cl8k: add agc_params.c
  cl8k: add agc_params.h
  cl8k: add ampdu.c
  cl8k: add ampdu.h
  cl8k: add ate.c
  cl8k: add ate.h
  cl8k: add band.c
  cl8k: add band.h
  cl8k: add bf.c
  cl8k: add bf.h
  cl8k: add bus/pci/ipc.c
  cl8k: add bus/pci/ipc.h
  cl8k: add bus/pci/irq.c
  cl8k: add bus/pci/irq.h
  cl8k: add bus/pci/msg_pci.c
  cl8k: add bus/pci/msg_pci.h
  cl8k: add bus/pci/pci.c
  cl8k: add bus/pci/rx_pci.c
  cl8k: add bus/pci/rx_pci.h
  cl8k: add bus/pci/tx_pci.c
  cl8k: add bus/pci/tx_pci.h
  cl8k: add calib.c
  cl8k: add calib.h
  cl8k: add cap.c
  cl8k: add cap.h
  cl8k: add cca.c
  cl8k: add cca.h
  cl8k: add cecli.c
  cl8k: add cecli.h
  cl8k: add chandef.c
  cl8k: add chandef.h
  cl8k: add channel.c
  cl8k: add channel.h
  cl8k: add chan_info.c
  cl8k: add chan_info.h
  cl8k: add chip.c
  cl8k: add chip.h
  cl8k: add chip_config.c
  cl8k: add chip_config.h
  cl8k: add config.c
  cl8k: add config.h
  cl8k: add coredump.c
  cl8k: add coredump.h
  cl8k: add data_rates.c
  cl8k: add data_rates.h
  cl8k: add dbgfile.c
  cl8k: add dbgfile.h
  cl8k: add debug.h
  cl8k: add debugfs.c
  cl8k: add debugfs.h
  cl8k: add debugfs_defs.h
  cl8k: add def.h
  cl8k: add dfs/dfs.c
  cl8k: add dfs/dfs.h
  cl8k: add dfs/dfs_db.h
  cl8k: add dfs/radar.c
  cl8k: add dfs/radar.h
  cl8k: add drv_ops.h
  cl8k: add dsp.c
  cl8k: add dsp.h
  cl8k: add e2p.c
  cl8k: add e2p.h
  cl8k: add edca.c
  cl8k: add edca.h
  cl8k: add ela.c
  cl8k: add ela.h
  cl8k: add enhanced_tim.c
  cl8k: add enhanced_tim.h
  cl8k: add env_det.c
  cl8k: add env_det.h
  cl8k: add ext/dyn_bcast_rate.c
  cl8k: add ext/dyn_bcast_rate.h
  cl8k: add ext/dyn_mcast_rate.c
  cl8k: add ext/dyn_mcast_rate.h
  cl8k: add ext/vlan_dscp.c
  cl8k: add ext/vlan_dscp.h
  cl8k: add fem.c
  cl8k: add fem.h
  cl8k: add fem_common.h
  cl8k: add fw/fw_dbg.c
  cl8k: add fw/fw_dbg.h
  cl8k: add fw/fw_file.c
  cl8k: add fw/fw_file.h
  cl8k: add fw/fw_msg.c
  cl8k: add fw/fw_msg.h
  cl8k: add fw/msg_cfm.c
  cl8k: add fw/msg_cfm.h
  cl8k: add fw/msg_rx.c
  cl8k: add fw/msg_rx.h
  cl8k: add fw/msg_tx.c
  cl8k: add fw/msg_tx.h
  cl8k: add hw.c
  cl8k: add hw.h
  cl8k: add hw_assert.c
  cl8k: add hw_assert.h
  cl8k: add ipc_shared.h
  cl8k: add key.c
  cl8k: add key.h
  cl8k: add mac80211.c
  cl8k: add mac80211.h
  cl8k: add mac_addr.c
  cl8k: add mac_addr.h
  cl8k: add main.c
  cl8k: add main.h
  cl8k: add maintenance.c
  cl8k: add maintenance.h
  cl8k: add mib.c
  cl8k: add mib.h
  cl8k: add motion_sense.c
  cl8k: add motion_sense.h
  cl8k: add netlink.c
  cl8k: add netlink.h
  cl8k: add noise.c
  cl8k: add noise.h
  cl8k: add omi.c
  cl8k: add omi.h
  cl8k: add ops.c
  cl8k: add ops.h
  cl8k: add phy/phy.c
  cl8k: add phy/phy.h
  cl8k: add phy/phy_athos_lut.c
  cl8k: add phy/phy_athos_lut.h
  cl8k: add phy/phy_common_lut.c
  cl8k: add phy/phy_common_lut.h
  cl8k: add phy/phy_olympus_lut.c
  cl8k: add phy/phy_olympus_lut.h
  cl8k: add power.c
  cl8k: add power.h
  cl8k: add power_cli.c
  cl8k: add power_cli.h
  cl8k: add power_table.c
  cl8k: add power_table.h
  cl8k: add prot_mode.c
  cl8k: add prot_mode.h
  cl8k: add radio.c
  cl8k: add radio.h
  cl8k: add rate_ctrl.c
  cl8k: add rate_ctrl.h
  cl8k: add recovery.c
  cl8k: add recovery.h
  cl8k: add reg/ceva.h
  cl8k: add reg/reg_access.h
  cl8k: add reg/reg_cli.c
  cl8k: add reg/reg_cli.h
  cl8k: add reg/reg_cmu.h
  cl8k: add reg/reg_fem.h
  cl8k: add reg/reg_io_ctrl.h
  cl8k: add reg/reg_ipc.h
  cl8k: add reg/reg_lcu_common.h
  cl8k: add reg/reg_lcu_phy.h
  cl8k: add reg/reg_macdsp_api.h
  cl8k: add reg/reg_macsys_gcu.h
  cl8k: add reg/reg_mac_hw.h
  cl8k: add reg/reg_mac_hw_mu.h
  cl8k: add reg/reg_modem_gcu.h
  cl8k: add reg/reg_otp_pvt.h
  cl8k: add reg/reg_ricu.h
  cl8k: add reg/reg_riu.h
  cl8k: add reg/reg_riu_rc.h
  cl8k: add rf_boot.c
  cl8k: add rf_boot.h
  cl8k: add rsrc_mgmt.c
  cl8k: add rsrc_mgmt.h
  cl8k: add rssi.c
  cl8k: add rssi.h
  cl8k: add rx/rx.c
  cl8k: add rx/rx.h
  cl8k: add rx/rx_amsdu.c
  cl8k: add rx/rx_amsdu.h
  cl8k: add rx/rx_filter.c
  cl8k: add rx/rx_filter.h
  cl8k: add rx/rx_reorder.c
  cl8k: add rx/rx_reorder.h
  cl8k: add sounding.c
  cl8k: add sounding.h
  cl8k: add sta.c
  cl8k: add sta.h
  cl8k: add stats.c
  cl8k: add stats.h
  cl8k: add tcv_config.c
  cl8k: add tcv_config.h
  cl8k: add temperature.c
  cl8k: add temperature.h
  cl8k: add trace.c
  cl8k: add trace.h
  cl8k: add traffic.c
  cl8k: add traffic.h
  cl8k: add twt.c
  cl8k: add twt.h
  cl8k: add twt_cli.c
  cl8k: add twt_cli.h
  cl8k: add twt_frame.c
  cl8k: add twt_frame.h
  cl8k: add tx/agg_cfm.c
  cl8k: add tx/agg_cfm.h
  cl8k: add tx/agg_tx_report.c
  cl8k: add tx/agg_tx_report.h
  cl8k: add tx/baw.c
  cl8k: add tx/baw.h
  cl8k: add tx/bcmc_cfm.c
  cl8k: add tx/bcmc_cfm.h
  cl8k: add tx/single_cfm.c
  cl8k: add tx/single_cfm.h
  cl8k: add tx/sw_txhdr.c
  cl8k: add tx/sw_txhdr.h
  cl8k: add tx/tx.c
  cl8k: add tx/tx.h
  cl8k: add tx/tx_amsdu.c
  cl8k: add tx/tx_amsdu.h
  cl8k: add tx/tx_inject.c
  cl8k: add tx/tx_inject.h
  cl8k: add tx/tx_queue.c
  cl8k: add tx/tx_queue.h
  cl8k: add utils/file.c
  cl8k: add utils/file.h
  cl8k: add utils/ip.c
  cl8k: add utils/ip.h
  cl8k: add utils/math.h
  cl8k: add utils/string.c
  cl8k: add utils/string.h
  cl8k: add utils/timer.c
  cl8k: add utils/timer.h
  cl8k: add utils/utils.c
  cl8k: add utils/utils.h
  cl8k: add vendor_cmd.c
  cl8k: add vendor_cmd.h
  cl8k: add version.c
  cl8k: add version.h
  cl8k: add vif.c
  cl8k: add vif.h
  cl8k: add vns.c
  cl8k: add vns.h
  cl8k: add wrs/wrs.c
  cl8k: add wrs/wrs.h
  cl8k: add wrs/wrs_ap.c
  cl8k: add wrs/wrs_ap.h
  cl8k: add wrs/wrs_api.c
  cl8k: add wrs/wrs_api.h
  cl8k: add wrs/wrs_cli.c
  cl8k: add wrs/wrs_cli.h
  cl8k: add wrs/wrs_db.h
  cl8k: add wrs/wrs_rssi.c
  cl8k: add wrs/wrs_rssi.h
  cl8k: add wrs/wrs_sta.c
  cl8k: add wrs/wrs_sta.h
  cl8k: add wrs/wrs_stats.c
  cl8k: add wrs/wrs_stats.h
  cl8k: add wrs/wrs_tables.c
  cl8k: add wrs/wrs_tables.h
  wireless: add Celeno vendor

 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/celeno/Kconfig           |   17 +
 drivers/net/wireless/celeno/Makefile          |    2 +
 drivers/net/wireless/celeno/cl8k/Kconfig      |   16 +
 drivers/net/wireless/celeno/cl8k/Makefile     |  149 +
 drivers/net/wireless/celeno/cl8k/afe.c        |  737 +++++
 drivers/net/wireless/celeno/cl8k/afe.h        |   20 +
 drivers/net/wireless/celeno/cl8k/agc_params.c |  683 +++++
 drivers/net/wireless/celeno/cl8k/agc_params.h |  151 +
 drivers/net/wireless/celeno/cl8k/ampdu.c      |  344 +++
 drivers/net/wireless/celeno/cl8k/ampdu.h      |   45 +
 drivers/net/wireless/celeno/cl8k/ate.c        |  841 ++++++
 drivers/net/wireless/celeno/cl8k/ate.h        |   90 +
 drivers/net/wireless/celeno/cl8k/band.c       |   60 +
 drivers/net/wireless/celeno/cl8k/band.h       |   40 +
 drivers/net/wireless/celeno/cl8k/bf.c         |  556 ++++
 drivers/net/wireless/celeno/cl8k/bf.h         |   32 +
 .../net/wireless/celeno/cl8k/bus/pci/ipc.c    | 1278 ++++++++
 .../net/wireless/celeno/cl8k/bus/pci/ipc.h    |  135 +
 .../net/wireless/celeno/cl8k/bus/pci/irq.c    |  331 ++
 .../net/wireless/celeno/cl8k/bus/pci/irq.h    |   15 +
 .../wireless/celeno/cl8k/bus/pci/msg_pci.c    |  101 +
 .../wireless/celeno/cl8k/bus/pci/msg_pci.h    |   12 +
 .../net/wireless/celeno/cl8k/bus/pci/pci.c    |  210 ++
 .../net/wireless/celeno/cl8k/bus/pci/rx_pci.c |  219 ++
 .../net/wireless/celeno/cl8k/bus/pci/rx_pci.h |   14 +
 .../net/wireless/celeno/cl8k/bus/pci/tx_pci.c |  434 +++
 .../net/wireless/celeno/cl8k/bus/pci/tx_pci.h |   14 +
 drivers/net/wireless/celeno/cl8k/calib.c      | 1682 +++++++++++
 drivers/net/wireless/celeno/cl8k/calib.h      |  237 ++
 drivers/net/wireless/celeno/cl8k/cap.c        |  928 ++++++
 drivers/net/wireless/celeno/cl8k/cap.h        |   21 +
 drivers/net/wireless/celeno/cl8k/cca.c        |  518 ++++
 drivers/net/wireless/celeno/cl8k/cca.h        |   30 +
 drivers/net/wireless/celeno/cl8k/cecli.c      |  354 +++
 drivers/net/wireless/celeno/cl8k/cecli.h      |  112 +
 drivers/net/wireless/celeno/cl8k/chan_info.c  |  852 ++++++
 drivers/net/wireless/celeno/cl8k/chan_info.h  |   32 +
 drivers/net/wireless/celeno/cl8k/chandef.c    |  152 +
 drivers/net/wireless/celeno/cl8k/chandef.h    |   14 +
 drivers/net/wireless/celeno/cl8k/channel.c    |  373 +++
 drivers/net/wireless/celeno/cl8k/channel.h    |  187 ++
 drivers/net/wireless/celeno/cl8k/chip.c       |  241 ++
 drivers/net/wireless/celeno/cl8k/chip.h       |  143 +
 .../net/wireless/celeno/cl8k/chip_config.c    |  290 ++
 .../net/wireless/celeno/cl8k/chip_config.h    |   58 +
 drivers/net/wireless/celeno/cl8k/config.c     |  121 +
 drivers/net/wireless/celeno/cl8k/config.h     |  392 +++
 drivers/net/wireless/celeno/cl8k/coredump.c   |  190 ++
 drivers/net/wireless/celeno/cl8k/coredump.h   |   76 +
 drivers/net/wireless/celeno/cl8k/data_rates.c | 1019 +++++++
 drivers/net/wireless/celeno/cl8k/data_rates.h |   30 +
 drivers/net/wireless/celeno/cl8k/dbgfile.c    |  438 +++
 drivers/net/wireless/celeno/cl8k/dbgfile.h    |   23 +
 drivers/net/wireless/celeno/cl8k/debug.h      |  121 +
 drivers/net/wireless/celeno/cl8k/debugfs.c    |  957 ++++++
 drivers/net/wireless/celeno/cl8k/debugfs.h    |   28 +
 .../net/wireless/celeno/cl8k/debugfs_defs.h   |   36 +
 drivers/net/wireless/celeno/cl8k/def.h        |  269 ++
 drivers/net/wireless/celeno/cl8k/dfs/dfs.c    |  977 ++++++
 drivers/net/wireless/celeno/cl8k/dfs/dfs.h    |   26 +
 drivers/net/wireless/celeno/cl8k/dfs/dfs_db.h |  107 +
 drivers/net/wireless/celeno/cl8k/dfs/radar.c  |  116 +
 drivers/net/wireless/celeno/cl8k/dfs/radar.h  |   55 +
 drivers/net/wireless/celeno/cl8k/drv_ops.h    |   28 +
 drivers/net/wireless/celeno/cl8k/dsp.c        |  611 ++++
 drivers/net/wireless/celeno/cl8k/dsp.h        |   27 +
 drivers/net/wireless/celeno/cl8k/e2p.c        |  664 ++++
 drivers/net/wireless/celeno/cl8k/e2p.h        |  166 +
 drivers/net/wireless/celeno/cl8k/edca.c       |  265 ++
 drivers/net/wireless/celeno/cl8k/edca.h       |   47 +
 drivers/net/wireless/celeno/cl8k/ela.c        |  227 ++
 drivers/net/wireless/celeno/cl8k/ela.h        |   38 +
 .../net/wireless/celeno/cl8k/enhanced_tim.c   |  216 ++
 .../net/wireless/celeno/cl8k/enhanced_tim.h   |   24 +
 drivers/net/wireless/celeno/cl8k/env_det.c    |   32 +
 drivers/net/wireless/celeno/cl8k/env_det.h    |   36 +
 .../wireless/celeno/cl8k/ext/dyn_bcast_rate.c |  182 ++
 .../wireless/celeno/cl8k/ext/dyn_bcast_rate.h |   18 +
 .../wireless/celeno/cl8k/ext/dyn_mcast_rate.c |  125 +
 .../wireless/celeno/cl8k/ext/dyn_mcast_rate.h |   14 +
 .../net/wireless/celeno/cl8k/ext/vlan_dscp.c  |  658 ++++
 .../net/wireless/celeno/cl8k/ext/vlan_dscp.h  |   37 +
 drivers/net/wireless/celeno/cl8k/fem.c        | 1271 ++++++++
 drivers/net/wireless/celeno/cl8k/fem.h        |   32 +
 drivers/net/wireless/celeno/cl8k/fem_common.h |   79 +
 drivers/net/wireless/celeno/cl8k/fw/fw_dbg.c  | 2686 +++++++++++++++++
 drivers/net/wireless/celeno/cl8k/fw/fw_dbg.h  |   30 +
 drivers/net/wireless/celeno/cl8k/fw/fw_file.c |  485 +++
 drivers/net/wireless/celeno/cl8k/fw/fw_file.h |   13 +
 drivers/net/wireless/celeno/cl8k/fw/fw_msg.c  |  135 +
 drivers/net/wireless/celeno/cl8k/fw/fw_msg.h  | 1656 ++++++++++
 drivers/net/wireless/celeno/cl8k/fw/msg_cfm.c |  316 ++
 drivers/net/wireless/celeno/cl8k/fw/msg_cfm.h |   35 +
 drivers/net/wireless/celeno/cl8k/fw/msg_rx.c  |  349 +++
 drivers/net/wireless/celeno/cl8k/fw/msg_rx.h  |   10 +
 drivers/net/wireless/celeno/cl8k/fw/msg_tx.c  | 1800 +++++++++++
 drivers/net/wireless/celeno/cl8k/fw/msg_tx.h  |  141 +
 drivers/net/wireless/celeno/cl8k/hw.c         |  166 +
 drivers/net/wireless/celeno/cl8k/hw.h         |  797 +++++
 drivers/net/wireless/celeno/cl8k/hw_assert.c  |  129 +
 drivers/net/wireless/celeno/cl8k/hw_assert.h  |   13 +
 drivers/net/wireless/celeno/cl8k/ipc_shared.h | 1445 +++++++++
 drivers/net/wireless/celeno/cl8k/key.c        |  197 ++
 drivers/net/wireless/celeno/cl8k/key.h        |   19 +
 drivers/net/wireless/celeno/cl8k/mac80211.c   |   17 +
 drivers/net/wireless/celeno/cl8k/mac80211.h   |  310 ++
 drivers/net/wireless/celeno/cl8k/mac_addr.c   |  331 ++
 drivers/net/wireless/celeno/cl8k/mac_addr.h   |   67 +
 drivers/net/wireless/celeno/cl8k/main.c       |  584 ++++
 drivers/net/wireless/celeno/cl8k/main.h       |   16 +
 .../net/wireless/celeno/cl8k/maintenance.c    |   80 +
 .../net/wireless/celeno/cl8k/maintenance.h    |   17 +
 drivers/net/wireless/celeno/cl8k/mib.c        |  437 +++
 drivers/net/wireless/celeno/cl8k/mib.h        |  286 ++
 .../net/wireless/celeno/cl8k/motion_sense.c   |  458 +++
 .../net/wireless/celeno/cl8k/motion_sense.h   |   47 +
 drivers/net/wireless/celeno/cl8k/netlink.c    |   41 +
 drivers/net/wireless/celeno/cl8k/netlink.h    |   28 +
 drivers/net/wireless/celeno/cl8k/noise.c      |  499 +++
 drivers/net/wireless/celeno/cl8k/noise.h      |   15 +
 drivers/net/wireless/celeno/cl8k/omi.c        |  214 ++
 drivers/net/wireless/celeno/cl8k/omi.h        |   31 +
 drivers/net/wireless/celeno/cl8k/ops.c        |  889 ++++++
 drivers/net/wireless/celeno/cl8k/ops.h        |   59 +
 drivers/net/wireless/celeno/cl8k/phy/phy.c    |  272 ++
 drivers/net/wireless/celeno/cl8k/phy/phy.h    |   17 +
 .../wireless/celeno/cl8k/phy/phy_athos_lut.c  | 2069 +++++++++++++
 .../wireless/celeno/cl8k/phy/phy_athos_lut.h  | 1049 +++++++
 .../wireless/celeno/cl8k/phy/phy_common_lut.c |  143 +
 .../wireless/celeno/cl8k/phy/phy_common_lut.h |   21 +
 .../celeno/cl8k/phy/phy_olympus_lut.c         | 2189 ++++++++++++++
 .../celeno/cl8k/phy/phy_olympus_lut.h         |  777 +++++
 drivers/net/wireless/celeno/cl8k/power.c      |  946 ++++++
 drivers/net/wireless/celeno/cl8k/power.h      |   37 +
 drivers/net/wireless/celeno/cl8k/power_cli.c  |  878 ++++++
 drivers/net/wireless/celeno/cl8k/power_cli.h  |   12 +
 .../net/wireless/celeno/cl8k/power_table.c    |  218 ++
 .../net/wireless/celeno/cl8k/power_table.h    |   25 +
 drivers/net/wireless/celeno/cl8k/prot_mode.c  |   53 +
 drivers/net/wireless/celeno/cl8k/prot_mode.h  |   30 +
 drivers/net/wireless/celeno/cl8k/radio.c      |  171 ++
 drivers/net/wireless/celeno/cl8k/radio.h      |   24 +
 drivers/net/wireless/celeno/cl8k/rate_ctrl.c  |  276 ++
 drivers/net/wireless/celeno/cl8k/rate_ctrl.h  |  106 +
 drivers/net/wireless/celeno/cl8k/recovery.c   |  264 ++
 drivers/net/wireless/celeno/cl8k/recovery.h   |   27 +
 drivers/net/wireless/celeno/cl8k/reg/ceva.h   |   44 +
 .../net/wireless/celeno/cl8k/reg/reg_access.h |  197 ++
 .../net/wireless/celeno/cl8k/reg/reg_cli.c    |  277 ++
 .../net/wireless/celeno/cl8k/reg/reg_cli.h    |   11 +
 .../net/wireless/celeno/cl8k/reg/reg_cmu.h    |  379 +++
 .../net/wireless/celeno/cl8k/reg/reg_fem.h    |  102 +
 .../wireless/celeno/cl8k/reg/reg_io_ctrl.h    | 1223 ++++++++
 .../net/wireless/celeno/cl8k/reg/reg_ipc.h    |  157 +
 .../wireless/celeno/cl8k/reg/reg_lcu_common.h |   32 +
 .../wireless/celeno/cl8k/reg/reg_lcu_phy.h    |   92 +
 .../net/wireless/celeno/cl8k/reg/reg_mac_hw.h |  490 +++
 .../wireless/celeno/cl8k/reg/reg_mac_hw_mu.h  |   33 +
 .../wireless/celeno/cl8k/reg/reg_macdsp_api.h |   66 +
 .../wireless/celeno/cl8k/reg/reg_macsys_gcu.h |   94 +
 .../wireless/celeno/cl8k/reg/reg_modem_gcu.h  |  628 ++++
 .../wireless/celeno/cl8k/reg/reg_otp_pvt.h    |  219 ++
 .../net/wireless/celeno/cl8k/reg/reg_ricu.h   | 1326 ++++++++
 .../net/wireless/celeno/cl8k/reg/reg_riu.h    |  902 ++++++
 .../net/wireless/celeno/cl8k/reg/reg_riu_rc.h |  115 +
 drivers/net/wireless/celeno/cl8k/rf_boot.c    |  354 +++
 drivers/net/wireless/celeno/cl8k/rf_boot.h    |   12 +
 drivers/net/wireless/celeno/cl8k/rsrc_mgmt.c  |  279 ++
 drivers/net/wireless/celeno/cl8k/rsrc_mgmt.h  |   29 +
 drivers/net/wireless/celeno/cl8k/rssi.c       |  320 ++
 drivers/net/wireless/celeno/cl8k/rssi.h       |   28 +
 drivers/net/wireless/celeno/cl8k/rx/rx.c      | 1108 +++++++
 drivers/net/wireless/celeno/cl8k/rx/rx.h      |  173 ++
 .../net/wireless/celeno/cl8k/rx/rx_amsdu.c    |  257 ++
 .../net/wireless/celeno/cl8k/rx/rx_amsdu.h    |   20 +
 .../net/wireless/celeno/cl8k/rx/rx_filter.c   |   88 +
 .../net/wireless/celeno/cl8k/rx/rx_filter.h   |   91 +
 .../net/wireless/celeno/cl8k/rx/rx_reorder.c  |  335 ++
 .../net/wireless/celeno/cl8k/rx/rx_reorder.h  |   14 +
 drivers/net/wireless/celeno/cl8k/sounding.c   | 1432 +++++++++
 drivers/net/wireless/celeno/cl8k/sounding.h   |  148 +
 drivers/net/wireless/celeno/cl8k/sta.c        |  536 ++++
 drivers/net/wireless/celeno/cl8k/sta.h        |  241 ++
 drivers/net/wireless/celeno/cl8k/stats.c      | 1402 +++++++++
 drivers/net/wireless/celeno/cl8k/stats.h      |   27 +
 drivers/net/wireless/celeno/cl8k/tcv_config.c | 1463 +++++++++
 drivers/net/wireless/celeno/cl8k/tcv_config.h |  333 ++
 .../net/wireless/celeno/cl8k/temperature.c    |  858 ++++++
 .../net/wireless/celeno/cl8k/temperature.h    |   74 +
 drivers/net/wireless/celeno/cl8k/trace.c      |    9 +
 drivers/net/wireless/celeno/cl8k/trace.h      |  203 ++
 drivers/net/wireless/celeno/cl8k/traffic.c    |  315 ++
 drivers/net/wireless/celeno/cl8k/traffic.h    |   57 +
 drivers/net/wireless/celeno/cl8k/twt.c        |  455 +++
 drivers/net/wireless/celeno/cl8k/twt.h        |   58 +
 drivers/net/wireless/celeno/cl8k/twt_cli.c    |  359 +++
 drivers/net/wireless/celeno/cl8k/twt_cli.h    |   11 +
 drivers/net/wireless/celeno/cl8k/twt_frame.c  |  385 +++
 drivers/net/wireless/celeno/cl8k/twt_frame.h  |   39 +
 drivers/net/wireless/celeno/cl8k/tx/agg_cfm.c |  219 ++
 drivers/net/wireless/celeno/cl8k/tx/agg_cfm.h |   21 +
 .../wireless/celeno/cl8k/tx/agg_tx_report.c   |  196 ++
 .../wireless/celeno/cl8k/tx/agg_tx_report.h   |   92 +
 drivers/net/wireless/celeno/cl8k/tx/baw.c     |   74 +
 drivers/net/wireless/celeno/cl8k/tx/baw.h     |   26 +
 .../net/wireless/celeno/cl8k/tx/bcmc_cfm.c    |   64 +
 .../net/wireless/celeno/cl8k/tx/bcmc_cfm.h    |   14 +
 .../net/wireless/celeno/cl8k/tx/single_cfm.c  |  214 ++
 .../net/wireless/celeno/cl8k/tx/single_cfm.h  |   18 +
 .../net/wireless/celeno/cl8k/tx/sw_txhdr.c    |   40 +
 .../net/wireless/celeno/cl8k/tx/sw_txhdr.h    |   45 +
 drivers/net/wireless/celeno/cl8k/tx/tx.c      | 1325 ++++++++
 drivers/net/wireless/celeno/cl8k/tx/tx.h      |  109 +
 .../net/wireless/celeno/cl8k/tx/tx_amsdu.c    |  483 +++
 .../net/wireless/celeno/cl8k/tx/tx_amsdu.h    |   43 +
 .../net/wireless/celeno/cl8k/tx/tx_inject.c   |  364 +++
 .../net/wireless/celeno/cl8k/tx/tx_inject.h   |   39 +
 .../net/wireless/celeno/cl8k/tx/tx_queue.c    | 1620 ++++++++++
 .../net/wireless/celeno/cl8k/tx/tx_queue.h    |   48 +
 drivers/net/wireless/celeno/cl8k/utils/file.c |   52 +
 drivers/net/wireless/celeno/cl8k/utils/file.h |   18 +
 drivers/net/wireless/celeno/cl8k/utils/ip.c   |  140 +
 drivers/net/wireless/celeno/cl8k/utils/ip.h   |   51 +
 drivers/net/wireless/celeno/cl8k/utils/math.h |   18 +
 .../net/wireless/celeno/cl8k/utils/string.c   |  235 ++
 .../net/wireless/celeno/cl8k/utils/string.h   |   25 +
 .../net/wireless/celeno/cl8k/utils/timer.c    |   72 +
 .../net/wireless/celeno/cl8k/utils/timer.h    |   30 +
 .../net/wireless/celeno/cl8k/utils/utils.c    |  388 +++
 .../net/wireless/celeno/cl8k/utils/utils.h    |  104 +
 drivers/net/wireless/celeno/cl8k/vendor_cmd.c |  377 +++
 drivers/net/wireless/celeno/cl8k/vendor_cmd.h |  116 +
 drivers/net/wireless/celeno/cl8k/version.c    |  129 +
 drivers/net/wireless/celeno/cl8k/version.h    |   14 +
 drivers/net/wireless/celeno/cl8k/vif.c        |  143 +
 drivers/net/wireless/celeno/cl8k/vif.h        |   44 +
 drivers/net/wireless/celeno/cl8k/vns.c        |  505 ++++
 drivers/net/wireless/celeno/cl8k/vns.h        |   36 +
 drivers/net/wireless/celeno/cl8k/wrs/wrs.c    | 1159 +++++++
 drivers/net/wireless/celeno/cl8k/wrs/wrs.h    |   45 +
 drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.c |   99 +
 drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.h |   13 +
 .../net/wireless/celeno/cl8k/wrs/wrs_api.c    |  212 ++
 .../net/wireless/celeno/cl8k/wrs/wrs_api.h    |   30 +
 .../net/wireless/celeno/cl8k/wrs/wrs_cli.c    |  852 ++++++
 .../net/wireless/celeno/cl8k/wrs/wrs_cli.h    |   12 +
 drivers/net/wireless/celeno/cl8k/wrs/wrs_db.h |  386 +++
 .../net/wireless/celeno/cl8k/wrs/wrs_rssi.c   |  444 +++
 .../net/wireless/celeno/cl8k/wrs/wrs_rssi.h   |   22 +
 .../net/wireless/celeno/cl8k/wrs/wrs_sta.c    |  360 +++
 .../net/wireless/celeno/cl8k/wrs/wrs_sta.h    |   20 +
 .../net/wireless/celeno/cl8k/wrs/wrs_stats.c  |  242 ++
 .../net/wireless/celeno/cl8k/wrs/wrs_stats.h  |   24 +
 .../net/wireless/celeno/cl8k/wrs/wrs_tables.c |  774 +++++
 .../net/wireless/celeno/cl8k/wrs/wrs_tables.h |   76 +
 257 files changed, 77223 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/Kconfig
 create mode 100644 drivers/net/wireless/celeno/Makefile
 create mode 100644 drivers/net/wireless/celeno/cl8k/Kconfig
 create mode 100644 drivers/net/wireless/celeno/cl8k/Makefile
 create mode 100644 drivers/net/wireless/celeno/cl8k/afe.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/afe.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/agc_params.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/agc_params.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ampdu.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/ampdu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ate.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/ate.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/band.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/band.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/bf.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/bf.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/ipc.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/ipc.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/irq.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/irq.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/msg_pci.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/msg_pci.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/pci.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/rx_pci.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/rx_pci.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/tx_pci.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/tx_pci.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/calib.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/calib.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/cap.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/cap.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/cca.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/cca.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/cecli.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/cecli.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/chan_info.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/chan_info.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/chandef.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/chandef.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/channel.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/channel.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip_config.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip_config.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/config.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/config.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/coredump.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/coredump.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/data_rates.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/data_rates.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/dbgfile.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/dbgfile.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/debug.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/debugfs.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/debugfs.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/debugfs_defs.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/def.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/dfs.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/dfs.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/dfs_db.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/radar.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/radar.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/drv_ops.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/dsp.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/dsp.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/e2p.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/e2p.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/edca.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/edca.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ela.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/ela.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/enhanced_tim.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/enhanced_tim.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/env_det.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/env_det.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/vlan_dscp.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/vlan_dscp.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/fem.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/fem.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/fem_common.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_dbg.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_dbg.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_file.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_file.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_msg.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_msg.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_cfm.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_cfm.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_rx.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_rx.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_tx.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_tx.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw_assert.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw_assert.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ipc_shared.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/key.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/key.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac80211.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac80211.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac_addr.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac_addr.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/main.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/main.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/maintenance.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/maintenance.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/mib.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/mib.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/motion_sense.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/motion_sense.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/netlink.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/netlink.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/noise.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/noise.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/omi.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/omi.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ops.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/ops.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy_athos_lut.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy_athos_lut.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy_common_lut.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy_common_lut.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy_olympus_lut.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy_olympus_lut.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/power.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/power.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/power_cli.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/power_cli.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/power_table.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/power_table.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/prot_mode.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/prot_mode.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/radio.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/radio.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rate_ctrl.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rate_ctrl.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/recovery.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/recovery.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/ceva.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_access.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_cli.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_cli.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_cmu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_fem.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_io_ctrl.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_ipc.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_lcu_common.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_lcu_phy.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_mac_hw.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_mac_hw_mu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_macdsp_api.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_macsys_gcu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_modem_gcu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_otp_pvt.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_ricu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_riu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_riu_rc.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rf_boot.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rf_boot.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rsrc_mgmt.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rsrc_mgmt.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rssi.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rssi.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_amsdu.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_amsdu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_filter.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_filter.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_reorder.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_reorder.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/sounding.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/sounding.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/sta.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/sta.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/stats.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/stats.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tcv_config.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tcv_config.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/temperature.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/temperature.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/trace.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/trace.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/traffic.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/traffic.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt_cli.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt_cli.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt_frame.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt_frame.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/agg_cfm.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/agg_cfm.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/agg_tx_report.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/agg_tx_report.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/baw.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/baw.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/bcmc_cfm.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/bcmc_cfm.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/single_cfm.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/single_cfm.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/sw_txhdr.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/sw_txhdr.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_amsdu.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_amsdu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_inject.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_inject.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_queue.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_queue.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/file.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/file.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/ip.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/ip.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/math.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/string.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/string.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/timer.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/timer.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/utils.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/utils.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/vendor_cmd.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/vendor_cmd.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/version.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/version.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/vif.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/vif.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/vns.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/vns.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_api.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_api.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_cli.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_cli.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_db.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_rssi.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_rssi.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_sta.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_sta.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_stats.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_stats.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_tables.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_tables.h

--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

