Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5E7A2542
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjIOSBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjIOSBL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 14:01:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF5AC
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694800866; x=1726336866;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bwgZKh74ttz8rTjM0zhza7B4NSCqMEdo/CJ64uyHeWw=;
  b=luNN5t8m/01gkMf1zH8pG6Pg3i4mpnGyZ1g3Rsv5lvrG1c/cgMnXNMgO
   KDUbWb4C4OdUv7qIEJca9psjyE7zcImaTpouU3yXYoz5tY2a0Q1nk5Q00
   r/TU1EP3+e8xN5xt1OUm2vNrk7RL+oq1/g+QrLsqh+Of4SSMlWiRWlU60
   UBOlaymim9+X7wbjPfuzLI2whB1epAPqAehGvQEkxTbjxVndAldPnUB1k
   mXc60HrSxs40Y39r52IRkxRbSx9aEH/CHK3p0R4H0zcxmyoIB19c4Z6IN
   9W4d257+EEGGzEj24acGAhWJDP3EZqNwgongGvM7drjRc+ZJ1YuaqBdv5
   A==;
X-CSE-ConnectionGUID: pLBK8dEeQ/yqN3Liu7TzcA==
X-CSE-MsgGUID: sGk67MDIQqWP2HynwSg1YQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="4787621"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 11:01:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 11:00:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 15 Sep 2023 11:00:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cjp1OH5RCQMaKm3ZyJRk8nvdG6jj/qw6XjYDBLX47sW0j0/0cu0B8Nvc8WL0cc1JVisqr5U4/5mMuOPFqIoV2LM/0p5+6+Ny3v+lwqAQXTj1r6djG43XNJgQKGZg238cgQzGXGEHX/QH7wSlhIDepocmtbsOaSBl1bLXsykeUmDhAM7SxDOSgMLlpOzIp4uZjiZLkypaQIZ+Y1dgUwGf4bv10by3YdFLFbKsKJSIEZI7GsAlfQByzOlp4kZWV5JmcI2Mh6yt5FQfuZa6Jf3Cmrlinxo7qAMrGAeQpbwKhJuQz69pE+B70WZCwdmg4IrVHCc7pCyDLo8rCWOzB2adxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo8PMiHNYLRGQkjTqUi0e/DImAE++MEmZmTtb3wEkp8=;
 b=HIux7QNXih10LRvDRUVg7jHI1tzswJqmoWYINbF8iErDdl9qokTFc7p4jVRlXCHA1fVPJoH7DQQnCtQeqCFUow8/Vr4ZYDDjVx2vtz7aWOc+eedejo5tv1xQIbt4wujinwctYqGDjgXtDeqMssV7LqlSKVHaNxDauQrnXk4/b2arufcqaCeFCnIm7x3qzG7yXeV2654WoJn5TJ3AzSiuZygeEeI+qufp67mCo25EdF4fF0GnH6erC08Uz7XRazHFrkpLJTBm5T6ptnVl4BOWvx837me7mXdZT3aeu8HSedlNwEqq4bg1pxylWLYf/tdc0RKNqNa3g3JnG6O5HFekJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo8PMiHNYLRGQkjTqUi0e/DImAE++MEmZmTtb3wEkp8=;
 b=akxATcm8iFMP/ClmAlxUGQlpEJ5bXcuwEyqvzBf41nZC2uUQA78D3r5J3hdJRd8GAaz/XXRfmwJQxtDsgp521te+EztccstGzj1o36ToCQ5n1aoTwmwo9X/KdM0Czz8bcW9wBkw8X+XB6Cw2272h7QujwgMzdiKGvCMJuZvmx7M=
Received: from DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) by
 DS0PR11MB7483.namprd11.prod.outlook.com (2603:10b6:8:147::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Fri, 15 Sep 2023 18:00:40 +0000
Received: from DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2]) by DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 18:00:40 +0000
From:   <Prasurjya.Rohansaikia@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <claudiu.beznea@microchip.com>
Subject: [PATCH v4] wifi: wilc1000: add back-off algorithm to balance tx queue
 packets
Thread-Topic: [PATCH v4] wifi: wilc1000: add back-off algorithm to balance tx
 queue packets
Thread-Index: AQHZ5/6Jc1ibUt2jf0mdH6PjQte6ng==
Date:   Fri, 15 Sep 2023 18:00:40 +0000
Message-ID: <20230915175946.4361-1-prasurjya.rohansaikia@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6336:EE_|DS0PR11MB7483:EE_
x-ms-office365-filtering-correlation-id: 27dbbb33-8991-449f-30a5-08dbb615ac20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXlYfH7M4RApCx6PsKVAxN1SJVJvBgFLYjl1EQcHCfMXhIMLC/4i6xisbdf9G3tfEuQ+CqvnBGuDJumJNVfaOLLhZtnH5kXXllrkqNxydgDKIIEhjjFVkCzVHBDFLNhts2Uyxec+EoJA0nJCKkA5I/OnCb7wNiAkJOOjvPV8oIcZnskCpPraAVAekhWy3jvsHvSG9sUhiWatadiB73rTj34XOsa667bHbP2ZZWbfgK617tOCN180D2VY/VrjCBaTlcVh24vdoAxMG4/FKuQL5PKSaIrzVF0Gl6cWP38C4XseLnCr3qicmIHrvWpSisFq58V/pkFce9NDeOee+KfuhgjFyNzn9L1JkB2qVqPlZRvLJPKlXXTMPioYmPtWbf7qwEKja3n2YwIN7CStjm6mWV/cdsniGaraUlIvjdDT3gb417q1DKVjeW5Kq0byKrkheM88cCIsvJE10GqNpINwBs563HEieIZycG2pQ4S5PF0H/8cY5sU9ilRsfZN2phrKVlfdd9eE+lcIHce14C493zZk9MA46YSBK1fTPepycigOgQTomuFyv7z+qRl5wnsXVkaWLQfAxgPp+qyuqNya9k8nxKUE9AtfswqIR58CIHQ/N5H/5ozHw+aj0FpiijNF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6336.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(186009)(451199024)(1800799009)(6506007)(8676002)(91956017)(5660300002)(4326008)(8936002)(54906003)(76116006)(316002)(6486002)(66946007)(26005)(66446008)(66476007)(41300700001)(66556008)(6916009)(6512007)(2906002)(478600001)(71200400001)(64756008)(1076003)(107886003)(2616005)(83380400001)(38070700005)(38100700002)(122000001)(36756003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mcb3YF0nRN3aMIyWahW0cJAJvzv56FqmRulURMWX9toETSSGtgDv/rabvt?=
 =?iso-8859-1?Q?jPIGgccHjq6AD0J/Y7Re7xjJsdInAF6s4c33vHSxzsDcCa0gOc6lzmq9CV?=
 =?iso-8859-1?Q?PE0sXXqm71j/bkh97Wh2VSVKRy0/SKkTDzYlWp0DEUVZLZquv/dxcJqjvX?=
 =?iso-8859-1?Q?vsn6xIIF3Slk/0cLW/gP4d/2xq6UKByJUUZTjQBSK8ErmYyyS6y8U7+voh?=
 =?iso-8859-1?Q?KL9NIY6hBxnuoRfUqaNxHAE7k+haJqLM9zdQ3AV3vvKwTeqzc73qxXlx6U?=
 =?iso-8859-1?Q?arPI8Yfd+fBMdrSiPkBoExhcozdQOBBXQ+vv2az7g32vYSyO+U+pa3PG6f?=
 =?iso-8859-1?Q?B0uXXQLRVcUdvAjpIGxyXM1tjvkqEYz3k81Ge3pyT8QuLHmVWiEmL7mz7g?=
 =?iso-8859-1?Q?jCiJYoKrGYDjcz3mkFnbGdDN97Aiegiq6Yb//QWRK3JkKQLUgcFVB4+UdK?=
 =?iso-8859-1?Q?0PUe6KBDOPq/0oYUYLS2YRkHaG/jw48Jlnp3hBUb43tginmUi3eCDapIbh?=
 =?iso-8859-1?Q?NQfsKoNWkpOcnoeQ/ngUWR9ZaaKGnqJfRbcajB2hXQ/X+46vVS4GttPfOL?=
 =?iso-8859-1?Q?5WirqZPxdx3OZuyHQsj7ZHqFic/8DOaNFmra8auKWC+Kx84gKya9ezYIrd?=
 =?iso-8859-1?Q?ZzZcTgH19ofACXhvY1dwSyaFx9xDSCFGgHcOhIY8Ffm3+OOXojwhc0lYua?=
 =?iso-8859-1?Q?tHpM7gEFOhb6JuC7Tot2jEHD1TfbMbhS5YYGsWNoJt6fcupWbY1fBKTOyc?=
 =?iso-8859-1?Q?n8SCHcRfzOYpP1+mXDtZWPrbbxjsaUGnYm+1/Qvyz2TzBBJLwOQQRO3YSk?=
 =?iso-8859-1?Q?HOj1pZbxK93w1DQrTbc+dw30SohuoQENYwuFecGzQWc5MI3zkApCVWt3Ue?=
 =?iso-8859-1?Q?EAjTAJYoAYqLXm5ST0dt4Xc8aSiBer1cZcvAJH4089oA49Q8BULL8CwLNg?=
 =?iso-8859-1?Q?tCpoEn+7EN6y+eU8pB5WEkZKnNu3cCZhonKANtPWv4Hrgl+hx5TMyscQah?=
 =?iso-8859-1?Q?zg0ZWLVJ5q2Va0KlDHuGq//soMb/ay+Gq5ZwMYZ8xRRHmeitaAoOxPMwMH?=
 =?iso-8859-1?Q?5/9iw4dTO7iCtTbNX8NFPi1oMYq5qbA1OWVb2ZcWLDqKXxiHKiiRg0ZcNW?=
 =?iso-8859-1?Q?Xu6abw9B60iWEY3PX4VrooFf/5Jmfapq9JY559Ka0dULDkIVv4NIe2k/FN?=
 =?iso-8859-1?Q?3CMIvy+MYs1XcfWQCYbjvqf+PvIXNrjgNVW1Frw/ctFQOiQRXxWFVQiGoF?=
 =?iso-8859-1?Q?mdZ7w+MQ5dUj+4+SWqv4RtheXIRZVEXNxHr/gxMBTniauzxuTF71BBOYmD?=
 =?iso-8859-1?Q?3imeWqLIcZh2BtQTCK0aPMNBWv7PW4B/xV4uGWWcaCVJNAOaKCVde57hMa?=
 =?iso-8859-1?Q?6SOy5PhGdydmjuoW871sO820hmMwv3vKnJhD50xaOhDX3lfK1H382LrrVm?=
 =?iso-8859-1?Q?KJl0HJSaOam8hihrKuYheldNWJTwTAAZhKqJQkYup72zlhkUdPJV9qISm5?=
 =?iso-8859-1?Q?upbGaFLTA+mCRZXwQoJ3/RNlBqAzzYLP8JLzT2ZMnOcwu22jFiOIxfWXQr?=
 =?iso-8859-1?Q?3WfR9wkMQ5KSf5vNo9VMGIg9+4m/dGlZSA3DhC4uMTk67ZRN2Kso1n/WQF?=
 =?iso-8859-1?Q?Rk7Jq1j+zic8QqLuivH7PMPo5FirfxvrU/SEKeVQvhLgR2QWwSsL542woG?=
 =?iso-8859-1?Q?18TbM2xp17pIjdNfTVuC0QqNlt1guuuZbJ3tZG0p?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dbbb33-8991-449f-30a5-08dbb615ac20
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 18:00:40.1114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFt0rwxvvr9wYjHCjTv0RQBs/3j9EVW6oQxkVPRxIczhcJL8439KTzmFYyhI3wZQf0vVzyIHbNsvUjemcpx8JV0QvhLJqWvZeW2sXPeE4BgJDtbBA3FyAa9kgk8HTl+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7483
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>

Add an algorithm to backoff the Tx Task when low memory scenario is
triggered at firmware. During high data transfer from host, the firmware
runs out of VMM memory, which is used to hold the frames from the host.
So, adding the flow control delays the transmit from host side when
there is not enough space to accommodate frames in firmware side.

Signed-off-by: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
---
v3 -> v4: As per review comments, replaced
schedule_timeout_interruptible() by msleep_interruptible().

v2 -> v3: Replaced schedule_timeout() by
schedule_timeout_interruptible().

v1 -> v2: Removed the unused `timeout` variable.
---
 .../net/wireless/microchip/wilc1000/netdev.c  | 20 +++++++++++++++----
 .../net/wireless/microchip/wilc1000/netdev.h  |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..91d71e0f7ef2 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -148,8 +148,8 @@ static int wilc_txq_task(void *vp)
=20
 	complete(&wl->txq_thread_started);
 	while (1) {
-		wait_for_completion(&wl->txq_event);
-
+		if (wait_for_completion_interruptible(&wl->txq_event))
+			continue;
 		if (wl->close) {
 			complete(&wl->txq_thread_started);
=20
@@ -166,12 +166,24 @@ static int wilc_txq_task(void *vp)
 				srcu_idx =3D srcu_read_lock(&wl->srcu);
 				list_for_each_entry_rcu(ifc, &wl->vif_list,
 							list) {
-					if (ifc->mac_opened && ifc->ndev)
+					if (ifc->mac_opened &&
+					    netif_queue_stopped(ifc->ndev))
 						netif_wake_queue(ifc->ndev);
 				}
 				srcu_read_unlock(&wl->srcu, srcu_idx);
 			}
-		} while (ret =3D=3D WILC_VMM_ENTRY_FULL_RETRY && !wl->close);
+			if (ret !=3D WILC_VMM_ENTRY_FULL_RETRY)
+				break;
+			/* Back off TX task from sending packets for some time.
+			 * msleep_interruptible will allow RX task to run and
+			 * free buffers. TX task will be in TASK_INTERRUPTIBLE
+			 * state which will put the thread back to CPU running
+			 * queue when it's signaled even if the timeout isn't
+			 * elapsed. This gives faster chance for reserved SK
+			 * buffers to be free.
+			 */
+			msleep_interruptible(TX_BACKOFF_WEIGHT_MS);
+		} while (!wl->close);
 	}
 	return 0;
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index bb1a315a7b7e..aafe3dc44ac6 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -27,6 +27,8 @@
 #define TCP_ACK_FILTER_LINK_SPEED_THRESH	54
 #define DEFAULT_LINK_SPEED			72
=20
+#define TX_BACKOFF_WEIGHT_MS			1
+
 struct wilc_wfi_stats {
 	unsigned long rx_packets;
 	unsigned long tx_packets;
--=20
2.34.1
