Return-Path: <linux-wireless+bounces-13285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE7989A8F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717D81C208B7
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C606184D02;
	Mon, 30 Sep 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MGsj9UZj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E07462;
	Mon, 30 Sep 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678247; cv=fail; b=emXGAG0rlt9YLtl4Kl9gXJO/8Py8s7YleqfqvJxspF8fNnu6IjOzCLSqyr/e2Iluo+X1c9j/hQ7IYv5jrhfLfOapMDRxc/TEjg78kox3JGlKDoeng78AjYbNfGtoetzJmYY9sgSfSDgHnAMVllXmSVKCOQ5JxeGqR5bTNJhuUEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678247; c=relaxed/simple;
	bh=adHIQ0ur0/ukUXkIdfVoonIlaLFlUQpCNZdTapF6Oqc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OVm3LVl4yE/8w37rjfIGXybsaN81SlerjOebRKlNLqBYC4wvDy/3S6aiEAfhuxCzyX8qUJhVjQy4DVQHjsLUPh1Ab06B6uIXKVVNJwxSyl+AxE/9Re+Db47miSQU62dvlX8iMQ0QDPKkFzorCnrsIRO32zObKtUcOjjiyhU5xB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MGsj9UZj; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZcnDG57yhoaO99v77E3yTBjTiNIugTz6gVFLDY1SBwPoc345mTHiKkP4UHb5uUOA3yVohpTYGvxrrl5dM5g7e8RHKcjiwotHlpjtsrhoQGW+7gZskpgD1uyufZIvMz25LG7ZwSbdkiB9bC0hySaNSUxAciUY22Vz+LtkDkRdg9Rc/1huRw82xEIN95JQ/dIhIXin1XDuUX9gj91WJoLXjObYHu7t1jF2bTEDxNZ6hLGkWZarik5Mte3WZDj/FOh3nfKh0ILhG46yHYSXQJGcpUxMRBkkgkpbni11vj+x8Qep2gV2iLxiP4K/R3cx7jMiDIE5MYm7Bv8mwTSh4NxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyLa7bCxh3tYF07AkH8rgjaDjwf9jksfb6DF/3T9VNg=;
 b=GiHMHZqsrsymwfpiiIGGK6tbZzmW9iqnhKjE3hKKVwh3XfQ2DYejKHRwfEUrd+giTJPVp2b+7jkCATbPfuP91kW8RzNaXQjUu5Vqa4Gq6JCX4TI6ZQnPAV+DCaZuLpaasj8h1b3SMBHvB8tg0U0yN0W/F9cfxgl7DXdQIxgE2zcJIOvM3m3GoC54PHGj8EfHaML0eZFjewG3UiwCM2Xy+z9/lhbUiZwUBbYpQcKW6N38m+zr+vWW3rJyH7vUGBZGYhkYYjLoDrgLQU39bjOho0AzgWqi+SqHHrTxZ6Bmw0y4PpTrpfF0IxghYG8tB+hSDwZN+oWVhc3zMeibP4onjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyLa7bCxh3tYF07AkH8rgjaDjwf9jksfb6DF/3T9VNg=;
 b=MGsj9UZjk8h6fCyiXGM+yW4j4zS/EVre5/ZvIwjY4dxWeMFwuWMXzwjIPVMj+zQKnEhMKm1Iqh+kcELorhFjPT0Wug2vgPHdH2xiLczihRMvWMFoSobQILGjRZh1RuP4uVDC/qm4fdPIFQlgPzeeNpyAQ7Ce0GCZzhxWxKha1wjJu+guN2AdHez39Fx0xQ4aN9M34FEGsBvw1ILtBv6CvskvWiiuwTWTUaS6327c4HlCOR+SuWAyz+Rs/tNvxA6KTQO1w/M3GsapXbkPdA7wgVwhONLD21I9SPCdnjTLB21o1rA/SkrHWM85WRCTBLj43iCYN4h1D03QJbamlKL/vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB9000.eurprd04.prod.outlook.com (2603:10a6:10:2e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 30 Sep
 2024 06:37:19 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:37:19 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Date: Mon, 30 Sep 2024 14:36:39 +0800
Message-Id: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DU2PR04MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a9b72e-86c8-49b1-d11f-08dce11a5510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hSogs0SUYWvw61Tt6VmGTy5h/5moOL645niArqsJdx2DgJkLR5i8Xv9eKSIK?=
 =?us-ascii?Q?TmIeri5ZwVPnXUN5Y7BSnik1+PtJr9sGaLgcpnpprfpM2cVivDit+g5zkf1c?=
 =?us-ascii?Q?jNN7uTOFAZam8TSrxRkClYpGGtjLmkc+4ThJdK+2JBd0ycG15moWHu254nWh?=
 =?us-ascii?Q?LZs6umxZI5o1PzYeFUf2hAFjVDcXMfz/8IaQTii3am8vVPfj6UJQ21Ttg0hr?=
 =?us-ascii?Q?ojJ86d5AK5QWLlMzckl3wbCBAqSN0UQgicHb2lydTI9+q1Se450FVga00gc4?=
 =?us-ascii?Q?fCHXKdfjpfUWXylTAD8Hru25gADAJUdOYPMQ58XkNNGnCIRLGPTmDsNYDqUD?=
 =?us-ascii?Q?hudUDyEluAfsI++mtfoKll4rz6T+/KGVWGoJEoL3q9gOiD8ooylw0LxeL7Z5?=
 =?us-ascii?Q?p0QI9NTgfwzqJIHl/G4ndxEMgCdpMG35rPbsVoFJh7ex7XtPeUUZl4jrvBpH?=
 =?us-ascii?Q?tAX543BFS+prdAbnpxhBi35M3UXUFUmnS5DjgGBH1JGSVFzMmQdHldSHp4Kv?=
 =?us-ascii?Q?bNKTfEMqyZmIQ9N3KuJG1+wgdykV0iIOd/uRkgnbRReJ3uykEwdeNdnKrAWb?=
 =?us-ascii?Q?T07PNj6ecmHIQ8nABGll+/lXiRN9zF8S2AEyxuyVjTJeWn83rlOcLTdAfaMt?=
 =?us-ascii?Q?/te6eMk527d5tupIAzmFFX8jjBLN0P3yNHrOITqsFyCkAs5Aob2HPNgRmssR?=
 =?us-ascii?Q?AJBKTLwqBmPO34/wj85DP3UyOlbUx7bqkYtKR173r7N7zUYxjEG6IEPer94x?=
 =?us-ascii?Q?2A1t9gdUSRnCDzsSFjkdl1CuHQPKjbcuLsEHiT8SYSSM6WYkSvZYC/6DId5p?=
 =?us-ascii?Q?1cQSwgnE6NyUvJm8WAr/cjijNLBbz712xx5GmU3DC7XqPY0KJ56AXKg0oynf?=
 =?us-ascii?Q?gi1bTG2oTW5Jg+JgfEge9qYBNHlqkx8QUAqPk/YXq8g/pSmC898qNKpFl1UI?=
 =?us-ascii?Q?euP9JBiuLNX9juXduu2e/hKMis3qlhG8JuNcVKGw261N2bYHmT2P/4fXODxG?=
 =?us-ascii?Q?gzeW9uMXQEaPd5bHk+XG2fs2fVKnxOOpTFDQvnofJcfl6wMd+uXAgGrp8wVl?=
 =?us-ascii?Q?XN/7cuZxcVHmb9u7tpQj0hLoJOCJpP7BtmmMB4s/1kzti6JTe6/dnOBWDZuH?=
 =?us-ascii?Q?+ZRroLNE3iLGSGA5dQ1E95gp1BcGk5cM9cn38MlYY6kzHEUqNaugvEkCevPS?=
 =?us-ascii?Q?sz4ytSARWjjNdSIYRxEzGEF/gTWg1bW4PDcD6vX7Y27ULUiySZqaD14Cxfr1?=
 =?us-ascii?Q?oqBe4wXymaiNPHVqRt7FuBx2BeBryvxPU2TeSgca+QxEKd7urUvkr51HFnxT?=
 =?us-ascii?Q?p77U7HMSbK7Ry3gj+2jw+7K+4BaSYHtIqkho0JVd6nc1WA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X70Eo3hc68YwzQQ2XTO+TcGXMQyFCz1So4ss80OKlgKyq3QLwM8d800Rw5os?=
 =?us-ascii?Q?UhbOxNZW5bVtuUGs6j+nc6EGeYS51rGjGiPqjFeg0TCv0PeVnXVaXggGkFxF?=
 =?us-ascii?Q?L7tWjrAf9lKIiMJYQv43B4AbU2Ng0gysLDxp+OnIhVbQ1HWe1YBdMkX8Noec?=
 =?us-ascii?Q?dwylRLg6mDswLubd+bDpBEYzSgvpPpjV8gvjWx2WFkwe8JalKi9y/ZDaPIvb?=
 =?us-ascii?Q?rg813nPxj8iCB7kz8C6IVa/UR/Q0GuueBz7VrDlG9e9wty/x9YWFhHREHx0H?=
 =?us-ascii?Q?ah97ZR8KBXY1xkUpxr3LkbJelHIe5c2K/woYYwng2xr3AqEjBg81mgo0MbE4?=
 =?us-ascii?Q?Yhw5ldJjJx1AmC7Ajs4o/zM7TcMX2KORkp4KIsvCBS9Swqdb4CJYK8goVkQ8?=
 =?us-ascii?Q?XziESGMJvrduxJaOK6FVBsEpPPoIwBQfJ/Ve3KmuqyQiLONZUXoLfIUO2zDB?=
 =?us-ascii?Q?aVdBYzMf84ZbCVjtbpQVgIJl+uX0i4s2SaYtXUWYpgS/HmTif6DuK1W2jub8?=
 =?us-ascii?Q?vSS0tDsC5pf+dPfN+UHiVAhFFDn2K9iolvhQABf0L/r/mmctzDdAoFVNIUlU?=
 =?us-ascii?Q?IxPUYZ29r68Fkk9vs+KjwPEONux7SZc6y6o41XKf1DIRIuVAG6ReSGx6Nycx?=
 =?us-ascii?Q?x98vBRiHo6rgTg9kWtYIRV37im+Z+BGlr5E4gScfhperL8fL9uQ3/V9evqo6?=
 =?us-ascii?Q?daSUKaj2e6OKb8NVghqquQwDb1UU0JHCp1oY5A9DNSXwoKQvrCik4D4erHCm?=
 =?us-ascii?Q?kE6NE+KoPtoYuuz7jCaI6rgGtAkKqErZ9R6KmXHfxnUXAFqXUi0JwWXl4/Bh?=
 =?us-ascii?Q?oowHTvvYaTjOnJcGrQVH5pjOXoCLrtU/ne7WRK0s54WBlqN9RF/o+/RWIOBl?=
 =?us-ascii?Q?wQVigzfOaCQMoDzxw7QK1qccMA+CYDV0rWZ4X1Zz2ZGEqOYvuYr6H5O1z0h3?=
 =?us-ascii?Q?M/W0+yoe3+jxVwiw5NfLf5LMB2oFUUQY3NrEOjo4fE2PtxK2JEdaoeT+HszY?=
 =?us-ascii?Q?gzMW1G0Y04b63lxMPm6nXAVOOJDkK/k3s8/36/i1a1v4K3UEZZRpaA0oAlRr?=
 =?us-ascii?Q?lNZOR/1dvmkPXBJkg6R5d1cX20rkMni9+CXMWzV9U74mWt4PTmh1HR28M7AA?=
 =?us-ascii?Q?1vIW697350jWu9ssJ5vhO0iEbjiHwamrDS13qvZRd/RCX5Ig0Mhb59Zq6tMh?=
 =?us-ascii?Q?P9qn5bimnzOht+qC+P3+O3o/i2AgjBpVLeYZN2twRD99TsP6eKiPFTEXgyD0?=
 =?us-ascii?Q?DzkkdsbXUvZDsEi0uSqobF8Oh6IpJglSGg1Heez3PHlWaHT6I2KPBXrIpbV5?=
 =?us-ascii?Q?f02fmwNuq8y25KG2caqGQEQFEGLCJthxh9X3IYliqmx5iwlSmBzwMIT3aBqD?=
 =?us-ascii?Q?58Z+EKjujdRiKYNBwnPf8CAbKpIHCX0UmphaCbINt2CCAYXNbNoomjJAZ7qO?=
 =?us-ascii?Q?geTp9KuESX3ikJbGodUtqn6yiGjbln7iaJHmx4TwsEDDa/uBcRsXUfsT9Dwx?=
 =?us-ascii?Q?3wSPHFodEj7LfDtxoJpMoAlbdDWStQlH73JHEp78lv6ALTNgj6AlMQ4BLAVx?=
 =?us-ascii?Q?Bw/aXIwJMisSqLYSYEteTal60XG0nrqjd+0hHbAr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a9b72e-86c8-49b1-d11f-08dce11a5510
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:37:19.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4LdkByW9oNmf7zNS4PR4SV0rqGi9Zr+KGaNdpjqWm27DLuqzRq04b6C3GMi7GlSrBzeLrtyDtpgJPStM4PfKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9000

This series adds support for IW61x which is a new family of 2.4/5 GHz
dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4
tri-radio single chip by NXP. These devices support 20/40/80MHz
single spatial stream in both STA and AP mode. Communication to the
IW61x is done via SDIO interface

This driver is a derivative of existing Mwifiex [1] and based on full-MAC
architecture [2]. It has been tested with i.MX8M Mini evaluation kits in
both AP and STA mode.

All code passes sparse and checkpatch.

Data sheet (require registration):
https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
4-plus-802-15-4-tri-radio-solution:IW612

This patch intents to add new driver nxpwifi for NXP IW61x and future new
chips/features support. 

[1] We had considered adding IW61x to mwifiex, however due to FW
    architecture, host command interface and supported features are
    significantly different, doing this on mwifiex will carry a lot of
    burdens. The effort of making sure no regression is also a huge effort.
    We must create a new driver nxpwifi. Subsequent NXP chipsets will be
    added and sustained on nxpwifi only.

[2] Some features, as of now, WPA2/WPA3 personal/enterprise are offloaded
    to host wpa_supplicant/hostapd.

v3:
   - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
   - Extend driver verion string with hotfix number.
   - Remove Rx mlme work.
   - Remove all useless check of netif_carrier_ok().
   - Merge decl.h to cfg.h.
   - Remove unnecessary check for wiphy parameters setting.
   - Synchronize following commits from Mwifiex: 
     wifi: mwifiex: replace open-coded module_sdio_driver() 
     wifi: mwifiex: Fix interface type change 
     wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id() 
     wifi: mwifiex: increase max_num_akm_suites 
     wifi: mwifiex: duplicate static structs used in driver instances 
     wifi: mwifiex: keep mwifiex_cfg80211_ops constant 
     wifi: mwifiex: Fix uninitialized variable in 
                    mwifiex_cfg80211_authenticate() 
     wifi: mwifiex: remove unnecessary checks for valid priv 
     wifi: mwifiex: Fix memcpy() field-spanning write warning in
                    mwifiex_cmd_802_11_scan_ext() 
     wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq() 

v2:
   - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
   - Remove useless header file semaphore.h.
   - Use static variable for cookie.
   - Modify nxpwifi_register to use ERR_PTR, IS_ERR and PTR_ERR.
   - Use error number for error code.
   - Remove unnecessary private ie definitions.
   - Remove mutex async_mutex and related code.
   - Remove unnecessary work queue.
   - Add the support for PSK SHA256.
   - Use tasklet for Rx.
   - Remove unused functions.
   - Remove compile warning.

David Lin (22):
  wifi: nxpwifi: add 802.11n files
  wifi: nxpwifi: add 802.11ac files
  wifi: nxpwifi: add 802.11ax files
  wifi: nxpwifi: add 802.11h file
  wifi: nxpwifi: add WMM files
  wifi: nxpwifi: add scan.c
  wifi: nxpwifi: add join.c
  wifi: nxpwifi: add cfp.c
  wifi: nxpwifi: add configuration files
  wifi: nxpwifi: implement cfg80211 ops
  wifi: nxpwifi: add host command file
  wifi: nxpwifi: add command and event files
  wifi: nxpwifi: add data path files
  wifi: nxpwifi: add debugfs file
  wifi: nxpwifi: add ethtool.c
  wifi: nxpwifi: add utility files
  wifi: nxpwifi: add initialization file
  wifi: nxpwifi: add core files
  wifi: nxpwifi: add sdio bus driver files
  wifi: nxpwifi: modify sdio_ids.h
  wifi: nxpwifi: add makefile and kconfig files
  wifi: nxpwifi: modify MAINTAINERS file

 MAINTAINERS                                   |    7 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nxp/Kconfig              |   17 +
 drivers/net/wireless/nxp/Makefile             |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c       |  288 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h       |   32 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c       |  388 ++
 drivers/net/wireless/nxp/nxpwifi/11ax.h       |   61 +
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  432 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  848 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  161 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  275 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  910 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   72 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h        |  874 ++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 4003 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  475 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1286 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   98 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1041 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2322 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  501 +++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  680 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  910 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1649 +++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1477 ++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2831 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2646 +++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1311 ++++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3309 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  861 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  243 +
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  208 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  357 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1254 ++++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  491 ++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  498 ++
 drivers/net/wireless/nxp/nxpwifi/util.c       |  999 ++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  121 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1369 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 49 files changed, 35890 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h


base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
2.34.1


