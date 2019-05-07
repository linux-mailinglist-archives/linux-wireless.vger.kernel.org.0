Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178841660A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 16:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEGOwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 10:52:10 -0400
Received: from mail-eopbgr800095.outbound.protection.outlook.com ([40.107.80.95]:14060
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfEGOwK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 10:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpi.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxih6qH2XUn8dI57Ak5Cj6pCDmwzHZjwQhZDY3ZRYZ0=;
 b=pPVQp3EKVGIK0XvxevElBKTVRCKUwLESImdhPG/ziK/u+EUe2A7DtO/dCD3W6P8V7WezvYt5rZhUle3RlkG0N8s64s36d2SVCaedsy86K8HVniFculA4dgCpuFCnZsttl4Z5hwDfr31tlb5Sbjr3Y0biJi0BDoJKkgSOvjJdEyA=
Received: from BL0PR01MB4706.prod.exchangelabs.com (20.177.147.204) by
 BL0PR01MB4548.prod.exchangelabs.com (20.177.240.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Tue, 7 May 2019 14:52:04 +0000
Received: from BL0PR01MB4706.prod.exchangelabs.com
 ([fe80::69aa:9b29:e42b:d37b]) by BL0PR01MB4706.prod.exchangelabs.com
 ([fe80::69aa:9b29:e42b:d37b%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 14:52:04 +0000
From:   "Anderson, Charles R" <cra@wpi.edu>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: ath9k on ASUS X202E hangs after 4.20.13
Thread-Topic: ath9k on ASUS X202E hangs after 4.20.13
Thread-Index: AQHVBORvk4SGYDgW1UGfSbqDFFKraQ==
Date:   Tue, 7 May 2019 14:52:04 +0000
Message-ID: <20190507145201.xcu4dv7rjc3a3nhg@angus.ind.wpi.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR22CA0037.namprd22.prod.outlook.com
 (2603:10b6:404:37::23) To BL0PR01MB4706.prod.exchangelabs.com
 (2603:10b6:208:77::12)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=cra@wpi.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2607:f5c0:8040:8021:21e:4fff:feb3:7d64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87e1332d-05c1-42b3-9db5-08d6d2fb914e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BL0PR01MB4548;
x-ms-traffictypediagnostic: BL0PR01MB4548:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BL0PR01MB4548557A2ACFD06A55941A40BE310@BL0PR01MB4548.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(40224003)(6486002)(8676002)(6512007)(6306002)(6436002)(81166006)(5660300002)(2501003)(66574012)(8936002)(1076003)(86362001)(71200400001)(6916009)(68736007)(2351001)(305945005)(88552002)(7736002)(478600001)(966005)(14454004)(46003)(186003)(53936002)(5640700003)(476003)(99286004)(486006)(81156014)(6506007)(386003)(102836004)(52116002)(71190400001)(25786009)(256004)(14444005)(75432002)(73956011)(66946007)(66446008)(64756008)(66476007)(66556008)(6116002)(786003)(316002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR01MB4548;H:BL0PR01MB4706.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wpi.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: olA4z89/kqpEJmbdcFMqqxBnVhV+2mhSPQPXyOAizatKHdbHHG08nXSZjYmn2vEdHWdfM/q4qAkXq75A9DUWYX6i3sjW/NWpbKc2fVUPe0Ng2AFBb7e3UibKyeE/+1oCm+Fh2iQ9EiPwccsXzFJTlkEDD6bDS1CAJD9A3XaPlXAE8ggEg79ILI19lOAI8w+L4KFdmneHQm54NCasxkABtP6Jauu5w26MrK0FifYPl/lPWgEFV61zJYtwwIR0M0+UeKu2EZKXUrH2NUaRXUaxoN4ig94ETxjwG7ZtzJKxVbAkgsT4VP2YdDN1MvmJ9NHGrtoj+nr5g7a4GJBA2ldqsukcxpkxyNSvAxOYqKL7h3VfjDJjlp6azt/vzV5/29plr6YDF/ONXQFofUfDxozI2NqpBboNrUIEUNoVom0zFF0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E37BE6592B06A1439DF2FB1EF32D0E5B@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wpi.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e1332d-05c1-42b3-9db5-08d6d2fb914e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 14:52:04.2662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 589c76f5-ca15-41f9-884b-55ec15a0672a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4548
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please Cc: me on any replies since I'm not subscribed.  Thanks.

I'm using Fedora 29 with their kernels.  4.20.13 is the newest kernel that =
works flawlessly on my ASUS X202E with the ath9k driver.  On 4.20.14, all 5=
.0.x, and 5.1.0, wireless hangs after being moderately heavily loaded--larg=
e downloads, rdesktop session, SSH. =20

I opened a RH bugzilla here with no response so far:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1700110

My test case has been:

- Boot kernel 4.20.13
- Make sure Wi-Fi is connected and wired ethernet is disconnected.
- Repeatedly run this: rm -rf evince ; git clone https://github.com/GNOME/e=
vince.git
- The git clone should finish to 100% every time.

- Boot any kernel 4.20.14 through 5.0.11 or 5.1.0.
- Make sure Wi-Fi is connected and wired ethernet is disconnected.
- Repeatedly run this: rm -rf evince ; git clone https://github.com/GNOME/e=
vince.git
- Usually after 1-3 runs, git clone hangs at less than 100% complete.
- Ctrl-C and rerun the git clone.  Now it hangs right away.
- Sometimes "ping" stops responding to the default gateway (wi-fi router).

I tried to look at the code differences between 4.20.13 and 4.20.14 and the=
 ones below are the only ones that seem relevant to wireless or ath9k to me=
, but these areas have changed a lot in 5.0.x and 5.1.0 making it difficult=
 to find any relevant changes there.

Can someone make suggestions on how to debug this further?

Thanks.

diff -urb '--exclude=3D.git' kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux=
-4.20.13-200.fc29.x86_64/drivers/phy/qualcomm/phy-ath79-usb.c kernel-4.20.1=
4-200.fc29/kernel-4.20.fc29/linux-4.20.14-200.fc29.x86_64/drivers/phy/qualc=
omm/phy-ath79-usb.c
--- kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux-4.20.13-200.fc29.x86_64/=
drivers/phy/qualcomm/phy-ath79-usb.c	2018-12-23 18:55:59.000000000 -0500
+++ kernel-4.20.14-200.fc29/kernel-4.20.fc29/linux-4.20.14-200.fc29.x86_64/=
drivers/phy/qualcomm/phy-ath79-usb.c	2019-04-15 17:47:40.605610254 -0400
@@ -31,7 +31,7 @@
=20
 	err =3D reset_control_deassert(priv->reset);
 	if (err && priv->no_suspend_override)
-		reset_control_assert(priv->no_suspend_override);
+		reset_control_deassert(priv->no_suspend_override);
=20
 	return err;
 }
@@ -69,7 +69,7 @@
 	if (!priv)
 		return -ENOMEM;
=20
-	priv->reset =3D devm_reset_control_get(&pdev->dev, "usb-phy");
+	priv->reset =3D devm_reset_control_get(&pdev->dev, "phy");
 	if (IS_ERR(priv->reset))
 		return PTR_ERR(priv->reset);
=20
diff -urb '--exclude=3D.git' kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux=
-4.20.13-200.fc29.x86_64/include/linux/if_arp.h kernel-4.20.14-200.fc29/ker=
nel-4.20.fc29/linux-4.20.14-200.fc29.x86_64/include/linux/if_arp.h
--- kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux-4.20.13-200.fc29.x86_64/=
include/linux/if_arp.h	2018-12-23 18:55:59.000000000 -0500
+++ kernel-4.20.14-200.fc29/kernel-4.20.fc29/linux-4.20.14-200.fc29.x86_64/=
include/linux/if_arp.h	2019-04-15 17:47:40.889617050 -0400
@@ -54,6 +54,7 @@
 	case ARPHRD_IPGRE:
 	case ARPHRD_VOID:
 	case ARPHRD_NONE:
+	case ARPHRD_RAWIP:
 		return false;
 	default:
 		return true;
diff -urb '--exclude=3D.git' kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux=
-4.20.13-200.fc29.x86_64/net/mac80211/cfg.c kernel-4.20.14-200.fc29/kernel-=
4.20.fc29/linux-4.20.14-200.fc29.x86_64/net/mac80211/cfg.c
--- kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux-4.20.13-200.fc29.x86_64/=
net/mac80211/cfg.c	2019-04-15 17:43:06.394863881 -0400
+++ kernel-4.20.14-200.fc29/kernel-4.20.fc29/linux-4.20.14-200.fc29.x86_64/=
net/mac80211/cfg.c	2019-04-15 17:47:41.034620519 -0400
@@ -1494,6 +1494,10 @@
 	if (params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER))
 		sta->sta.tdls =3D true;
=20
+	if (sta->sta.tdls && sdata->vif.type =3D=3D NL80211_IFTYPE_STATION &&
+	    !sdata->u.mgd.associated)
+		return -EINVAL;
+
 	err =3D sta_apply_parameters(local, sta, params);
 	if (err) {
 		sta_info_free(local, sta);
diff -urb '--exclude=3D.git' kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux=
-4.20.13-200.fc29.x86_64/net/mac80211/rx.c kernel-4.20.14-200.fc29/kernel-4=
.20.fc29/linux-4.20.14-200.fc29.x86_64/net/mac80211/rx.c
--- kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux-4.20.13-200.fc29.x86_64/=
net/mac80211/rx.c	2019-04-15 17:43:06.397863955 -0400
+++ kernel-4.20.14-200.fc29/kernel-4.20.fc29/linux-4.20.14-200.fc29.x86_64/=
net/mac80211/rx.c	2019-04-15 17:47:41.038620615 -0400
@@ -231,7 +231,7 @@
 		struct ieee80211_hdr_3addr hdr;
 		u8 category;
 		u8 action_code;
-	} __packed action;
+	} __packed __aligned(2) action;
=20
 	if (!sdata)
 		return;
@@ -2720,7 +2720,9 @@
 	skb_set_queue_mapping(skb, q);
=20
 	if (!--mesh_hdr->ttl) {
-		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_ttl);
+		if (!is_multicast_ether_addr(hdr->addr1))
+			IEEE80211_IFSTA_MESH_CTR_INC(ifmsh,
+						     dropped_frames_ttl);
 		goto out;
 	}
=20
diff -urb '--exclude=3D.git' kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux=
-4.20.13-200.fc29.x86_64/net/wireless/reg.c kernel-4.20.14-200.fc29/kernel-=
4.20.fc29/linux-4.20.14-200.fc29.x86_64/net/wireless/reg.c
--- kernel-4.20.13-200.fc29/kernel-4.20.fc29/linux-4.20.13-200.fc29.x86_64/=
net/wireless/reg.c	2018-12-23 18:55:59.000000000 -0500
+++ kernel-4.20.14-200.fc29/kernel-4.20.fc29/linux-4.20.14-200.fc29.x86_64/=
net/wireless/reg.c	2019-04-15 17:47:41.086621763 -0400
@@ -1255,7 +1255,7 @@
  * definitions (the "2.4 GHz band", the "5 GHz band" and the "60GHz band")=
,
  * however it is safe for now to assume that a frequency rule should not b=
e
  * part of a frequency's band if the start freq or end freq are off by mor=
e
- * than 2 GHz for the 2.4 and 5 GHz bands, and by more than 10 GHz for the
+ * than 2 GHz for the 2.4 and 5 GHz bands, and by more than 20 GHz for the
  * 60 GHz band.
  * This resolution can be lowered and should be considered as we add
  * regulatory rule support for other "bands".
@@ -1270,7 +1270,7 @@
 	 * with the Channel starting frequency above 45 GHz.
 	 */
 	u32 limit =3D freq_khz > 45 * ONE_GHZ_IN_KHZ ?
-			10 * ONE_GHZ_IN_KHZ : 2 * ONE_GHZ_IN_KHZ;
+			20 * ONE_GHZ_IN_KHZ : 2 * ONE_GHZ_IN_KHZ;
 	if (abs(freq_khz - freq_range->start_freq_khz) <=3D limit)
 		return true;
 	if (abs(freq_khz - freq_range->end_freq_khz) <=3D limit)


ath9k drivers in use:

ath9k                 155648  0
ath9k_common           24576  1 ath9k
ath9k_hw              503808  2 ath9k_common,ath9k
mac80211              933888  1 ath9k
ath3k                  24576  0
ath                    36864  3 ath9k_common,ath9k,ath9k_hw
cfg80211              770048  4 ath9k_common,ath9k,ath,mac80211
bluetooth             610304  32 btrtl,btintel,btbcm,bnep,ath3k,btusb,rfcom=
m

02:00.0 Network controller: Qualcomm Atheros AR9485 Wireless Network Adapte=
r (rev 01)
        Subsystem: Lite-On Communications Inc Device 6628
        Flags: bus master, fast devsel, latency 0, IRQ 17
        Memory at f7d00000 (64-bit, non-prefetchable) [size=3D512K]
        Expansion ROM at f7d80000 [disabled] [size=3D64K]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] MSI: Enable- Count=3D1/4 Maskable+ 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
        Kernel driver in use: ath9k
        Kernel modules: ath9k
