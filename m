Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D43797AD3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 19:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbjIGRuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjIGRuP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 13:50:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2682133
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694108992; x=1725644992;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Go1uEwOSwEu8HwadXnApTBjc0WZnXT2nT+MDhG1O3og=;
  b=Rb4OM4Qd24mFeDLBe0d1ngLxiO/+584eXVV2fqLpRIL6ljN+5TDF8Htr
   V/sZBTUtqR1p+5yBzz21Io4Q0utluHnA84mw2GIgbcXAFO0A4NnqPZefe
   JHjCkiyHGaeanOb2JiN1HAwPlbI3Jjw0bQ6/Nnnrn8qHf0baoNipzVuI4
   JKPjvzeudwo04PKNINzGQj4tZsCsl4lEYprut+j9ib3ytzGStJ2k0vo33
   LBhIfT5sihey6fVK1dN4ZsTc6bRugNRdTZOs1JXE3YPMlhzds2Z+IbRMW
   SNzBXWC4FYQT6KS5EtwIJg4wV/ByUdkrnenhfWFq/5v831UhZea8Y77zY
   A==;
X-CSE-ConnectionGUID: 2ciiRttiTXKiKJj5P8oZrg==
X-CSE-MsgGUID: LJnGp1biQqyu6SQ/5LMPqw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="3477518"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2023 10:08:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 7 Sep 2023 10:08:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 7 Sep 2023 10:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Adz18sjNM6KxoDMP8IUY8dAsoOVLnSKE0mCDXm1dtTMi6ET5YutMJuY3OV+1KZyLJWwTp3CvMJ4NlKowCDmqCYfQ3NLS26mHLDv6dhDyAa8EYP1B2wNrkkA9eHzCl5bowKGeNufNo+Mk6KyW01qzqzOOkjakx+zVqgGpYTVAREeHFRvGInJoLh0SadwY6J7eqvWeWTdfiu3Kmb6/KHinbSfyO0L853PJdr0PSaSAgiwgD+fUGBOK7iupNSKfMAHvcdsrU39NZg6FkV9r1Z9Zn24qGZESFQ30AT/zNQ2mtX/+x/PY6zSil0bb5IYJCAXY+gtADceaqCL+F7Ji7AGLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2NoFgKl9Y7xJhIkeS3MzmuGrEWuccq/x6WJGZ5Q6Qs=;
 b=WHCgCk4gMzKcxrCI8hE+ydopu51jdpjitoXHMdjW5HBMWtvuYXfitNh3viZAwvt5JzOcvgzJr+NdP4z4W8n83BOzIzsuvHwly7x4aHZwqdZQ1059ghpJ8FI1HPMeBc4WewsE5hblqQt/bYmXbNYn1pHutyIgyewzPgWpn48LNLruvMz0hcu3S/sK/RRxrpdhIIdvZi6XCsfSld7W5ReZvXeDDvIun5lByNima4xcKz414fihUSfi/68NbTRimputsOtD/FM59LB7wdEWoqMrLzhZv2H09TlI+yUyf7gH+leyBBnhBYp8UbALR+oRurAFJU2VGb8BL35pvpN7k1TClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2NoFgKl9Y7xJhIkeS3MzmuGrEWuccq/x6WJGZ5Q6Qs=;
 b=KC5CqrpUNyu9hTd/fQvXn4fR5Wo6wuAb2XuUzwKsrlaQHp+jWRgjEV1QVftXJ+oYwXKn3i7+onf77bLGPqB1SeaspWe+b9F9LlSyQQWrE9QhDrqhSuMtnAbErnq4YliCO5dq6bTxoksW8/7KXPPihX14n1aP1Jpcf/zWQCAFG0M=
Received: from DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) by
 DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 17:08:53 +0000
Received: from DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2]) by DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 17:08:53 +0000
From:   <Prasurjya.Rohansaikia@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <claudiu.beznea@microchip.com>
Subject: [PATCH v3] wifi: wilc1000: Added back-off algorithm to balance tx
 queue packets.
Thread-Topic: [PATCH v3] wifi: wilc1000: Added back-off algorithm to balance
 tx queue packets.
Thread-Index: AQHZ4a36H8g8Ibgqk0++EZxK8R8Jfw==
Date:   Thu, 7 Sep 2023 17:08:53 +0000
Message-ID: <20230907170851.178834-1-prasurjya.rohansaikia@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6336:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: ccd0ea1d-6389-495d-639e-08dbafc51d4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: getnzcTOb9QIQcb5zZFj5tjla4lemDaiFjYTlS/VZ+E9PADZ5lZtoLVQBwKgbzokhbSrKbnNh944+hus/unZosDjrgzmJ3Zv0qx8wgPYM6OD2ErXrDBerqhFtinumqwyP5+kzPAMOBnFq0/tpRKtU7LIBhhv0DfyDH8wFiKvFr6ZsIU/hnn+HO/lAzMvbc6Ye2qPUqbDpYgg0QcudtVzFV3HpOVgh0Zqe+V6qmZIMEvqTjEtNSPAX1Hf0y20nyVHeeIYY1fLLW0xVW3KNkgTPuLirYXXdKQ4R00utX82ZJOVTvD9MMDoCqvG8wbPUmejS1sLvPHoYd6GtuG4u6br0LfCHB9+1oH41s2HMNHGhCK77JCp0hXOdDsQxzvW9VwHMWh2dAf7/fuoHkZ4WC1eZeXrBs7RlabJurmwEJkNdh8A/iOI65AWczGR4zyruTzjL1FDeZUzLHAIZ6Rc16GYP6o3dRndebgx9sx0P8Kl/1dbFBKaS7fOjMjbOJn3Ce4Mwwl4D3qfAsNYPqbCYMlM8z1W2gPJoRarAM2fJhpAYsmYei4rj2VZi/W/WNAghc0IFFNC/8ov1aDmajyySMCxsoTY2+Qh/GUrxhoKrLd2gdh4OHspfGGmUTFiPPrSLxI3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6336.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199024)(186009)(1800799009)(6486002)(71200400001)(6506007)(6512007)(83380400001)(2616005)(26005)(2906002)(107886003)(91956017)(76116006)(54906003)(316002)(66446008)(6916009)(64756008)(66946007)(8936002)(8676002)(66556008)(66476007)(5660300002)(4326008)(478600001)(38100700002)(1076003)(38070700005)(36756003)(86362001)(122000001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cnkLWlDNbOjz30pArsm0H4fgq6hKvyfK24QevVTOL5NgaTjWwyzAuNJWRB?=
 =?iso-8859-1?Q?V3kzvys53C9QvI/vvwBNC238gOTZc3a4TxTAE5ym1xskN2nTEm9Cobhgee?=
 =?iso-8859-1?Q?nAtS+4Ekb0jYgHuPOcRPn4Dx3JTyJL5667zlwrouQ1ElxJaBbK3GX+vabI?=
 =?iso-8859-1?Q?OlZuzhxBsVrdiLI3W+CLIYjRebfv9V45CfmXSOnpTtx1z7JcXwfxkFp0JS?=
 =?iso-8859-1?Q?6s38idT7i9ee5K+RrOz2vurMvsogQ+4q11ZO5QS2+uMZMdk1gdEoIyyDaz?=
 =?iso-8859-1?Q?Oj0dtlz2oIjPNOckbOO4YIzcQXwzjRcpQsExXjgTUTq/zJ6FGyVxlme3hL?=
 =?iso-8859-1?Q?taPPadixyzeI/c908lskG8PvrPfgEekuy9iWbNOi4uBfb/pPh/pYZXEPDd?=
 =?iso-8859-1?Q?b6Thq3ZAmR9qU8krxONYu9UWb6c3Ovz4JKT/d6xdolL/uijuS+4kkBb5cg?=
 =?iso-8859-1?Q?PemNqoFYDmAaKQ5DKMthsHRBiCBEyZwewbfj3b8WqyOb1B0wkWKt1pfQtn?=
 =?iso-8859-1?Q?VrWuIdBqsE2Q8wqAQOKwdpxNSvsvQhdoeoze7K8r9kIz6RnGRelJtNlkXI?=
 =?iso-8859-1?Q?t0jPKx6XlpY2I4L9H2WVZBX14Wo6mtPIs+LIwAB78jRWE+sJjmmkUiK491?=
 =?iso-8859-1?Q?qJTXGtvZw3e2P5LRuUvImp5CooR247K25N2iPdSrr5PwUYCFSvsU1EANo0?=
 =?iso-8859-1?Q?bCHXEyKsKeR75UEdpMh0B6D2XWfJycPx8hEyi9UeBfgD2LftiUiPrlKSZG?=
 =?iso-8859-1?Q?ia/JLFH7LU0K/gwckzF4SpIpUJDfnAYLax2Tsz0crupt1iIvZz6HMUSRgT?=
 =?iso-8859-1?Q?J7foW0XSQ8GbS8b7OuzC11pEyFJWlpaTsUY0jHDxjbiKhAzjUlFn1GD9c5?=
 =?iso-8859-1?Q?d/rCf0l7gufB/bBMsUmxUGAykFeQea13fIVcTlp3V9qCB5Mbzwjq8OLufY?=
 =?iso-8859-1?Q?uNKjU3Xpk+1uiW5VpYWxW0bnWU/ykPi/oCjk3F88XpTIMX/WBXDlnP57y3?=
 =?iso-8859-1?Q?gwX3c5bNNdSgNbsZwOreWfM5zBHYwHLKE/AWc4QZtcFqDtchEPLczHMcEv?=
 =?iso-8859-1?Q?IBiKwtNo1pwn6Ke59yj/GVRj+pdWK+u1GhUmpTjy8yf1YkhwdnbxV1DZ5S?=
 =?iso-8859-1?Q?GM+yPj+OGRnsVpywfujpOex//4Pl2ecUyzJ6p7JR14eIMDHZnKGM8S9XKg?=
 =?iso-8859-1?Q?Fmt9Vep3iA3mcd7r1FUo2/d+4Pvvx6Xa7YXq+k5tcq4GUSuB5MRqpRJQlk?=
 =?iso-8859-1?Q?UpRiPidrO2jpyK/qqyYUe/Z1+ApJSZs12r+6cpIPSoGhRsFCfuonQ0ZOmw?=
 =?iso-8859-1?Q?UKFVuHIVAkrHJnIFPhTuObujPujs98mNs++NJsARkk1POQ1o8gTcJZm3e2?=
 =?iso-8859-1?Q?MxaqmnKDem8btlZYYjQpwL136n1ruaCuEeyi9YdrpkdAS4/F5/sLZ7iz3r?=
 =?iso-8859-1?Q?HZ6RgntOE43rdNKBAsEgOM8JGNykC75JQRNOPbYh/ZoPDTeBmOYFD1Q9Xt?=
 =?iso-8859-1?Q?TxVJ7nulM3W8cAXIjpFfKfjJMqO1cotDeNYdgOt8VaHLVa+Zny775jw0Wq?=
 =?iso-8859-1?Q?gaLunzQAuRVr1FJKt9GG8s07ogd1nTYfpPYrY3mtI2yUAGzkCG5JNVdFyq?=
 =?iso-8859-1?Q?oHAHcI97pJA8/eioWB7c0acSDmdRNTr0S6xb3Py0jU5fVCbGILZ18tZ1Te?=
 =?iso-8859-1?Q?+PlCh8cD9n/J4P5V4c4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd0ea1d-6389-495d-639e-08dbafc51d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 17:08:53.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOu0oN75EztOVP5Obj07yQtKzsh346foGfwkLNCmQNk2Rk3mSWZcOADGkFI+RqwljXYh27FNy61AB/fJGnpT2YfXYK+S5n7LRldKzib6lYxQpOKO6a1giSy7ezb5F+Zj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
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

Added an algorithm to backoff the Tx Task when low memory scenario is
triggered at firmware. During high data transfer from host, the firmware
runs out of VMM memory, which is used to hold the frames from the host.
So added flow control to delay the transmit from host side when there is
not enough space to accomodate frames in firmware side.

Signed-off-by: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
---
v1 -> v2: Removed the unused `timeout` variable.
v2 -> v3: Replaced schedule_timeout() by schedule_timeout_interruptible().
---
 .../net/wireless/microchip/wilc1000/netdev.c  | 21 +++++++++++++++----
 .../net/wireless/microchip/wilc1000/netdev.h  |  2 ++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..f6bec17bfd0f 100644
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
@@ -166,12 +166,25 @@ static int wilc_txq_task(void *vp)
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
+			 * schedule_timeout_interruptible will allow RX task
+			 * to run and free buffers. TX task will be in
+			 * TASK_INTERRUPTIBLE state which will put the thread
+			 * back to CPU running queue when it's signaled even
+			 * if the timeout isn't elapsed. This gives faster chance
+			 * for reserved SK buffers to be freed
+			 */
+			schedule_timeout_interruptible(msecs_to_jiffies
+						       (TX_BACKOFF_WEIGHT_MS));
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
