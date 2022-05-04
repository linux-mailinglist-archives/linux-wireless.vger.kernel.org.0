Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1045851A548
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353312AbiEDQXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353255AbiEDQXH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:23:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E2246B13
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651681170; x=1683217170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=72pxP9bTkUbZJGrXlO31Do31M0Oar5HcVSM5xjDmNg4=;
  b=s4eKAzTe/XV/xTd/gq5X7yRdGl615i++8vYf3xuzoNUwJ06DfdaIqHJU
   3qiH18bonAoU63qhwV2weANUdw6RN5qXkGdUGHG95urUhLsoznNe27P96
   ps1llc8POao0eBUDhKfIPYjECAS6PMTUEbSE36M+dSZac89xP6Lw6mHJ9
   NK3q4fNwBPT1o6kxBewBut+p2rjy4hgygnbvKfZbyuiQSbpqRl/s3txBh
   zjatjXY/11Zo58FzlomZWajx2A2ezjsKCexshTaQbfVejWLTgpxVAdXwk
   5q7zTE1v+SH5Ps4AC6t0cM54wJCwiloVUy3jchDlUn925H3URfc+n43ok
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="94549834"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2022 09:19:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 4 May 2022 09:19:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 4 May 2022 09:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMncWExaTFy6EQWnhjozCXUkiBMZljFpiv76GZsdM/SSkJfMKRBp79VviHJgozmZ+KGp7SkPr5uy3foRozdUD8+SF6Ph3bGjiwCVm9f+kW2RVOnoKwkzjXTxtjcEkFv052N3KL6lQSe6NY3QYgyedDoOUNPBKagwCowaW0Ykm81vO2udf1e3mdvRaZa2eE7omr3dQ56nQo7/35EqldaFKVkTaA3IsBYQNFhTzAqqvtM92op7bUK4dk1AWso4IxKsuXrIr9q8r/9UsIs7YTaYpJfhL8oteC9dTsH6uABjn2FBNzFTexgF9RKuIjw/osr9BH3jkkBUYsitt2lRD8iHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwKWL7pLBEUVJfTAi8G8mj+L1+eIlv6eqN3fGqsJd9U=;
 b=CMZZquZdEIvijcO+JirIW6W/oF+dSvU5c9eo3qxTDHgLCO/yBnUwuvv4zlPq3l0SV5Juy9Sbi8bXz2UUZClQLzECw7sMRdXSSv3INX+s/H/jgtl1EKG475/cUrsVh40Gkms5ZIVrOG3+0/OHiIOFSJDnTbTHHRqcO7V4BJqDjOtvVeG0H35y7dejSWm93NKn8h5S0HkiEStTRHDibRdZNiYIDepaLOGYT6hwbfzPh3bAKs6vUfC3QcUUl3BgzjcOabAsSH52PwphTVmeO06ExRfAeq6sL/75RCGFEB90j/OMfXwgPODTzghqAJhloMhU3ba4pmkpziVIdCj6z6LQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwKWL7pLBEUVJfTAi8G8mj+L1+eIlv6eqN3fGqsJd9U=;
 b=t323kt1tHc9r2PzQVVxEgIwOyzUXFQodvq1c7Os2FJld0S6EnET/KkkNnvcckDCTSl2EYI1uoZwFkQe1xOoWt6oL+oEXaaz7Id72f1fco0cgWqGKzQw9/N4RqVbi5hyUVmoIsm6hdiiFKKqHNlnBkTo1q5QttUjCHQU4SeEf3ug=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB5597.namprd11.prod.outlook.com (2603:10b6:a03:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 16:19:27 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%7]) with mapi id 15.20.5206.026; Wed, 4 May 2022
 16:19:27 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 5/5] wilc1000: add valid vmm_entry check before fetching from
 TX queue
Thread-Topic: [PATCH 5/5] wilc1000: add valid vmm_entry check before fetching
 from TX queue
Thread-Index: AQHYX9K5v2GgK0DDa0m7VuNszJu7yA==
Date:   Wed, 4 May 2022 16:19:27 +0000
Message-ID: <20220504161924.2146601-5-ajay.kathat@microchip.com>
References: <20220504161924.2146601-1-ajay.kathat@microchip.com>
In-Reply-To: <20220504161924.2146601-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58bf1942-d966-4c2f-1c70-08da2de9dc81
x-ms-traffictypediagnostic: SJ0PR11MB5597:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB5597560ADF88A04CBEE83239E3C39@SJ0PR11MB5597.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1bwtPins34bIa3pneTctI+kieebj6KmRRuH0it30o0twNJ7toBwFinqlz7lfXNxA16EB2Rvw61Sui7qXjcadrFJ6ZKRS/CDGBOlj9l7GdukKSry35xv78iqPSzYGHVyM/aTEhNgcsr1TD0z88Zqh/bHaPLTk+ILlL7Lw89V/DF90+XaIh+yJXzbZIZEDbILSy51TxG2ZkBxHLu9lyqRadaqzuOLHZA8EKpAsLg2zI2VF91OavHMesvjdMYBsIx0EVKIrvBuMINOiNMUPZa/9SKA+IvW8Ddr/WYFnH4FJaEugGgHGYbaxBhVicFLZ0w8vtFHrEzG83D7LXFvn9Sa9zMrG6CwHdFv79tByKY+ktCEGs8N3XuS3TB+z/H2TdorUwGILftwQvijnQBUGTi+BYXC/d6N/wkdlPaKDXTpsD8YPAn/myG/Yam/Hs0hHc4JAoNvmmDbPumKJEuvQZBEeCUZme7ZPDkI4q6eqLAJ49ei7JVSW9kRMKeyIMYzmOH57O8HTFRhjhEIvk29l18u3+L9AxwPR7RC5bcZ9leN4BzXrZH6WYeF34y8tuFo/bxzbuvriCyQSZWGLxHKdgfPRd7WFHfwPWaugXU0DmeZSkK/omST1rJhfOtPGLdQlx5AzXwm8ip450ZXchYr3hAjKRAhFXEvTVBjDvEPc8wUTSA+m4DF35XZPCU1YBHlEdIgMr/1gWFTSi8lEU8YMoVX1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(38070700005)(38100700002)(6486002)(122000001)(2906002)(8936002)(6506007)(508600001)(1076003)(4326008)(86362001)(6916009)(186003)(6512007)(26005)(71200400001)(2616005)(54906003)(5660300002)(316002)(91956017)(107886003)(8676002)(83380400001)(64756008)(76116006)(66556008)(66476007)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/IgpJ3WuWnLgsOJeGyJN10C4dVCTfwZN4PkFak5Yz39xbRc3xD8Zp8qrhh?=
 =?iso-8859-1?Q?fpCKU7CSDwm9ENa60vIeze3rAB2GgxO0cuq8gYkF6p87ljCl2lGP+GNarY?=
 =?iso-8859-1?Q?l/pLC3++eLGAo1EgeyXVprMVjYu3XAduT7WHv0e9q4b0E9qSHzdNSQ+CI1?=
 =?iso-8859-1?Q?blR1Ix46yAc1xE+yW3rKb1SAvThNp6j6CylvZ8T+HeR+pBYAZ9sBpbWkKL?=
 =?iso-8859-1?Q?Y5hBsbkgecIZGnkeipmvMjv0SBp5DON5K02GsR1n/MZVG42npDnmCyJZu7?=
 =?iso-8859-1?Q?K83+ycW4h+qw611Eu4rcsh7qLTC23LOOb6YstdQ0EDwdgw2Bvzm3+sAzEK?=
 =?iso-8859-1?Q?6agQBiz3tZJ3yRr7Ct+kfDCzTbR/w/zk8MhO9I3XNIvaFo0Z1Kmiu1LbAb?=
 =?iso-8859-1?Q?q+fB4WbCdLshTKk8gOvi3Ms22ZsAsoyutRQaABhRP9o2VmOTcFOAHSV+8f?=
 =?iso-8859-1?Q?+doZwFg2T/HX3wYg4BxmwbR1OK6rfWjLUv2fCSXkiBJqwKv2oWZfdLCDar?=
 =?iso-8859-1?Q?TX0dAkeLq1MrgcMe/2PSZAV32pw1HCfqT1nWLwt4Iq13R5nn1cPbERpfng?=
 =?iso-8859-1?Q?kN4OFrmo3RlOc8Cws36etzh9KY46siVYK2CuPaiq9QkSbNU5oDRHl8ED5O?=
 =?iso-8859-1?Q?zVHatMe2slS1fmLJeaJzffGWYaMgzy8YcmiPsTvK9MZ8uXqAvJhQYNCR6x?=
 =?iso-8859-1?Q?tu0x5dsplr3lKxMGsxBKrElK5+tXkorzGVcia+26bZG2Ww6ZyC1JekpKTU?=
 =?iso-8859-1?Q?5IxPBKNMXe3+wEnf6/JkZKmu4pWTGh8UU9FLSbb95v4beJ8D9s8KbhOWAb?=
 =?iso-8859-1?Q?hl2+KzVLgPmHZlc9ssmzHR6vx/iuuXHXj++XXtMEGvYFp+0G51vz3PKDxN?=
 =?iso-8859-1?Q?YOyEQ1C/Pc0WN5KeClksEAG5tyVHvSPgESDCFaHV6uwUBT8d/kz6C059eI?=
 =?iso-8859-1?Q?N3kIYoGNyH64Ue9rhR8DKyzd+ZlREvsA3QLscsIFwGHX2F/+cZn2Oagg4+?=
 =?iso-8859-1?Q?dd3evkVmZScg3/M/exPF5UcsYJU8Doe8VyX92R7slc1vk3lJ3G3MJgyC7l?=
 =?iso-8859-1?Q?4f/Ysim6WY+KrEbG/Rs/Or6zRZNKVWuXDQ9ougJijcwKnUmapkzALQxtl2?=
 =?iso-8859-1?Q?7dhjyHc7LFvG3pUk6JBNfM4R3CMjtaGQ7gLMRK0W912HD3QL5f0dsBfVp9?=
 =?iso-8859-1?Q?LskFhuFlXC2s/G+hrccgcNYu1EQ4tgkIXUWz/gPPzCoQ8/M7hy54HnLoL+?=
 =?iso-8859-1?Q?fe2LyAIAgJFQ/rYuOCcqlrRKm+SHSGd8TFBjnpiZG7a5z+a+RgwF4srQH6?=
 =?iso-8859-1?Q?HJgBbaS4QDqup9fjzsWBtJdcaWrEpUNtE3MpdXbHJXrQ2nHmPxrrqEAcR9?=
 =?iso-8859-1?Q?KtQZ9ITHMs7s70xKgOoXX7LTrapEpLmGWlfty5udWdCs6AGpxr2mu0pVJ3?=
 =?iso-8859-1?Q?ugzljsJTGlGSKW+7OB2LV2pmws9nMFSYGayIsEfV9L0BAVeSwo2WLuxvGe?=
 =?iso-8859-1?Q?kgO4RsJdmBRS9MsSwdTSQyYS32yGzgT7wKaBUl/3HvuwBAkrLqCnhQREkI?=
 =?iso-8859-1?Q?eyhe4Y5SKyPxPy+zOtBZvfOSvtAoisK6buDk3X6o3uEM7vMDSm2/h3nM/5?=
 =?iso-8859-1?Q?LJkD2fyxE5EC+oA6QQLEupfi7/CV0Z6pmfBUeBS+K2rSFECehJLDBx71O4?=
 =?iso-8859-1?Q?6jLRCVPzEDnOUVwWPiWL77jmejkX9iAyVOY8JSKYezDie4pXbEkWRRbPd2?=
 =?iso-8859-1?Q?M7+mR23YN8f9HBCCGpOB4l+9AfEj5inWZisfeAgP6191eTL/IGozwp4i/H?=
 =?iso-8859-1?Q?vziQZWC4B8ty3oD/sOW5CW/y5TnjxONTXgCqCBXqi1lJdvnG86eU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bf1942-d966-4c2f-1c70-08da2de9dc81
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 16:19:27.5800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70/sOaXaVXlFBvlqNK1rYyBRoP+jzGeWSka5a1kdxrsal9PpgeGaU3aTDVCfnvmlfYkJlOUsoPBg1ol56lK+uePWOydUcAbGKHhJF95r8o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5597
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

'vmm_table' array contains the size of data buffer length including host
header length. In 'vmm_table' array, the Zero value means the end of
vmm_entries that needs to transfer to firmware which is calculated based on
VMM free size in firmware.

Use 'vmm_table' valid entry check before fetching the entry from TX queue t=
o
only copy valid number of entries to avoid possible NULL pointer exception
observed sometimes during large file transfers.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index fb5633a05fd5..48441f0389ca 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -875,14 +875,15 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_=
count)
 		char *bssid;
 		u8 mgmt_ptk =3D 0;
=20
+		if (vmm_table[i] =3D=3D 0 || vmm_entries_ac[i] >=3D NQUEUES)
+			break;
+
 		tqe =3D wilc_wlan_txq_remove_from_head(wilc, vmm_entries_ac[i]);
-		ac_pkt_num_to_chip[vmm_entries_ac[i]]++;
 		if (!tqe)
 			break;
=20
+		ac_pkt_num_to_chip[vmm_entries_ac[i]]++;
 		vif =3D tqe->vif;
-		if (vmm_table[i] =3D=3D 0)
-			break;
=20
 		le32_to_cpus(&vmm_table[i]);
 		vmm_sz =3D FIELD_GET(WILC_VMM_BUFFER_SIZE, vmm_table[i]);
--=20
2.25.1
