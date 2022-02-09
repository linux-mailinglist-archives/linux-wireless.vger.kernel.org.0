Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34C14AF5B3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 16:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiBIPqw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 10:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiBIPqv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 10:46:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AEDC0613C9
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 07:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644421614; x=1675957614;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=2rvFv4VXo+KxQFR5XHuS6GIvh/FbhkADSCHKuXrRy60=;
  b=lke/+8DsNmYBloJRAyuh8fDySX2gxvl6rK9mMIjTWSt0ydJlcMB35MKH
   do3Wufc03ctsUtKDgn7eitbPg5Z9W5+vTmKkAqqnyXylQ+ueb6KBK7yEC
   eTdZ1ziIfF2hYZjrzniHDNeYo2VnmTuE20s8AUx90cHWchED2AeVaduyq
   yTlNH/I0B9RO8irk7C2+38okL2YjS1Q02epj8+d2lIQbnrb6XWoXBj5Jm
   ckAimqqDdSC+x79a3XMETDgSdwA9WDkWdWNJZRjNbsgWzFF1AaOs9REjJ
   jS0tofxATB16PDRAAcEQk61AX7VI6fWFm0o31P3i7ixPZfdDQ5heyKlSo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249179437"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249179437"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:46:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="482365061"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 09 Feb 2022 07:46:53 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 9 Feb 2022 07:46:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 9 Feb 2022 07:46:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 9 Feb 2022 07:46:52 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 9 Feb 2022 07:46:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnYSOYf2nbeyek6Dgf54JacgYEkYHavaWf7LK+aH5NI00WheS37fa/HN/lDw7kTv42xA6Aqg/uuxYOdzFfvbaXP4z0Kzq2XKohMklDHzVcPiZkrEUtDk317Bg+R5TzHWF13RjHIhWI/WRMcFx8Hf768HuUMRYUhK86PV33I3+izPD9oGRsbohfv0moxS/k4qrRM7Cq2PdeCVJqF2kdzl0CLAbnH+klWwGKCeKmJ3+y3cIhDOBrmS813nPNBSfcmwUpuA0FqyK85r8JMD1X68hMnPhHhT1JpLvh15Wi7N6MSYdIOVkuGShciWs9lcWE/ytz18dHdi+AzGawrW0TBVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6iqiB2f1uykw+zrdoXeFvnjVIZjJSjNFfDDk5KrlSs=;
 b=CfrbHR8oTO/4Afm5OfdD1czyGPQLwUIKaYXBpbMG74CijoohZ63V7P8sKKjP7IMeZQbs3P9gbItPz6WE7jXxp2EDCx1eY07fVutl8fdAgAw5SYUm7kb18RWrrV6MWNorkM9mVK3ySE28847RsI0l2ITJPAKXffqbScY3fb1ZjbEcHKsT5ujvd7vfMf99AqYd+Os+bQ72UerU6tu9tct336qZoNb1VOnYT9lfyz4nlu6OEcI9Lw183EKge8GnGh/bsjKUtIOwvRepLnHLBpvJGmhl5dqhDiwkbqPJxkxJl6rPCedKvFH1CS4rCa4mz/7hpr5Rn5IcVo50e0rO8K6klA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21)
 by CY4PR1101MB2198.namprd11.prod.outlook.com (2603:10b6:910:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 15:46:51 +0000
Received: from CO1PR11MB4785.namprd11.prod.outlook.com
 ([fe80::7107:7896:df86:5e10]) by CO1PR11MB4785.namprd11.prod.outlook.com
 ([fe80::7107:7896:df86:5e10%8]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 15:46:51 +0000
From:   "Zhao, Jiaqing" <jiaqing.zhao@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [PATCH] brcmfmac: Add BCM43454/6 support
Thread-Topic: [PATCH] brcmfmac: Add BCM43454/6 support
Thread-Index: AdgdyNktBl6FUa/ORoCKxIrRZ0MVpQAARQig
Date:   Wed, 9 Feb 2022 15:46:50 +0000
Message-ID: <CO1PR11MB47859B51BCA88613D1582EB88E2E9@CO1PR11MB4785.namprd11.prod.outlook.com>
References: <SEZPR04MB5947C9CF870F97421997350A9D2E9@SEZPR04MB5947.apcprd04.prod.outlook.com>
In-Reply-To: <SEZPR04MB5947C9CF870F97421997350A9D2E9@SEZPR04MB5947.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 801f32c7-d672-4f0c-8383-08d9ebe3639f
x-ms-traffictypediagnostic: CY4PR1101MB2198:EE_
x-microsoft-antispam-prvs: <CY4PR1101MB21982880C275D210496C45778E2E9@CY4PR1101MB2198.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vYD33yM+SUYlzWTFOAaiBGkqWWwvslxxFbe+JLlBBe+jkYPbolkYKUnRo4BDkdfS3YT+WiY+GHEPjopbSDKTMCMleHqsCpNRg377iVwrSP9Rpuce7fYaVSHnt7+yW8y0GjfYChup59Hul3ksbftgJ02teUiU/nWG5KNifSUNq2h20zGgCkx+WKYqtf8sI7Hudh+wPafntl9sqW9cksdg0W/TgotRkBx6bopk1gJXBA14lvmoNzN/9si7DWZwFEJd7rOPvQvfnwv6zr5rWK+B27uFgP4HsBObVUaba4dwEVqpx1szwywqFuRcLnGywLKiYvc/4X4zKOQMd3b+AcxlgMVgwMTPeB5qJGLR83It92/Gj/G6Jzozd6danDKzocIFyYZTxbeWKrYZzmXy0bn/LNIl98M8FHmYHSECkIjOXT6HWjEULGzSATdKiIbwSm6ZxSHLN0ViF0n7LsKgRRwypeuVHHjMViv48CfatMyb8r0U2XrxBAwfK7pmYP853xO0N/Sdj4a1WR9r1BAe0668uIvIesqKB3yH13wYHDaJtYCv3To3t9L5YAmkc6/al9/iHcLDrtRTTdjfbqAiHkByvjb+GPYd/6poohPd4zY5HOZiPi2gTJRQeIsgPfYwZf0YPST3xk+bD+ETv5rSAM6OwDLruMmxt9wh7+b3i9Pxbv/Wf0Roo0VLCplEx6XERVtiwFAIiGN0JO6SvGsCcAV06g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(82960400001)(33656002)(38100700002)(6916009)(83380400001)(186003)(26005)(2906002)(316002)(66556008)(66946007)(76116006)(66476007)(508600001)(6506007)(5660300002)(7696005)(64756008)(8676002)(9686003)(52536014)(86362001)(66446008)(55016003)(8936002)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bIb1Bp+9zzqSNM5381IBq2ZxisaRbHoNBFDVGvv6+gSGoGIDXFmNcx2lrMxI?=
 =?us-ascii?Q?7UzFO1FtWC1mSBFjSw7JL4KnrxSh3dy9wWY4+tFBXKzAFss9ErDoqZdTYhuo?=
 =?us-ascii?Q?cyto0ARB93LQOYlaLbalQdzlogyXMcw5w6MwwtnibKwvrqCU/dChVF2Bb7Wr?=
 =?us-ascii?Q?8Oa4+Q8oQDxHtbr0r927ezty6LPJHPw5JM8hoE+XanIttTogfc/cm+4hZuiq?=
 =?us-ascii?Q?O+cCAnzsrgz4UnLvRZPPPR1Y0huUxXygD3iA4jPOQmdn0JYxRsntuGu8teg5?=
 =?us-ascii?Q?xF6nlHMLpvJHxVn/OzrbH3/bdL3JJrwRGJ0bFYCd1TEww1s6aH2NfL1OG6kI?=
 =?us-ascii?Q?BdTP/WIol3wMb7MHj2mAjuB6NzKPSpEER3WMWjE9PYCngGiIdlyp8pz042P4?=
 =?us-ascii?Q?nRbmvKC9Cbh9HkHTvBctYymNhg07TTHiCmw6B7p0FPM+5ZtIqSlf44KH9nUn?=
 =?us-ascii?Q?hSfkF59TVtXA/IJ6gFiaPdrjCSesV9q1cpIdIOGB03ZEC2EX7uJXvZDWRo/M?=
 =?us-ascii?Q?KtBzGgsjMqaS1Up/nlj6tqAnFTlp7EpGLsR56DQ46HjDCP3vefL/cGDKf6RH?=
 =?us-ascii?Q?KlO9odYg4b3wzNNolJx0G9BxgHUAin1c97qtsmqbu+AZb/Snj/N/NVprQOoi?=
 =?us-ascii?Q?/dwuC3S4RIRAXdAVExFK4NMqrpNlfJuEv61D68vIul1pd8sXrUaEJR6k+UR5?=
 =?us-ascii?Q?AZbPcF6hUja9gL124x0P+mPZDddbTac2awwCE0+Kndg0cRbsZxQELtaiCgyo?=
 =?us-ascii?Q?N2rv3cE8HWYjwwIC97aOdXRYpmNw/20PXtxR/0DVChyZq+/CZYDPn/nXeHb9?=
 =?us-ascii?Q?Ut5tcvPESolDufJOy3C0j335bCoWLDIAhxC6ECwVlR4C75zUtza2Im7Kj+Qn?=
 =?us-ascii?Q?M1wsrPYU2KALeA4ZR6MOfOKw+RzIxqEHSUYUTXx5lRqIOUn4gx3y6cJteZIA?=
 =?us-ascii?Q?jn0Iiw+PVd1l5v3MkH9TGfUjHAudU6MAh5UNBImI4iXm9TATSZqLDosr4mr+?=
 =?us-ascii?Q?0fgLqDRq9BmJwQ6zaeEx/tfvLH2M/eCZ0HyCGF+zwbwO4/SNT72fAW3orMnN?=
 =?us-ascii?Q?eeVcRqJl2jk0uO0lFmmqJLi2uPqvr3l/NK90UGmfpbjFyCBlMiZm1lYUvgA5?=
 =?us-ascii?Q?odNC6hGfNV2lFgaiIiSOhaus1qTU3aNH3pYWn6RSCuO76eaNr2lKlsC1RG3f?=
 =?us-ascii?Q?UReD9yhxKXVNOvoULSGxGejVOUZP51QZySYgdT2zuX3q6oEN3JUgb8OWCZJZ?=
 =?us-ascii?Q?pDaEXsCJ6AWOzwxtJwt1TISYbmODyid8TNfeuFK3LKqMRhheoN/e1BN9gNIv?=
 =?us-ascii?Q?nS5915p4U3Zkld4wQPmjveX0qsZ3dJKxLxq7G8f2TJL4e52+WQtm+ogMy3Sq?=
 =?us-ascii?Q?/HGWaU44FMi3zcBS/yMxOY0D6Hr+1N20BvIO3amRIHwOtq9Vky/Ql+ivQ3Nl?=
 =?us-ascii?Q?ZN0kk9KPTiVhIsP0lhcIf3XgSGcL8CB8O32tMJGG1HTWzHQzv1MYJvz0LrHo?=
 =?us-ascii?Q?Twblf3qEzGlw883JG9f1XbVqV1IxqUpMrK0O6l15AEVd0wByHA9b0FpL50Ag?=
 =?us-ascii?Q?dOaMetbXpn70OE1cdk3BwObxoQtYvNF2siSlSHz0y+88bakKoy//sADQBBq6?=
 =?us-ascii?Q?pJa/HUUL3CnqzvFgwNF8MGk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4785.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801f32c7-d672-4f0c-8383-08d9ebe3639f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 15:46:50.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/ngIJSXhzTCrBthMSS8+MFPPCAtmwdE9Cb4mnUEDQlbo+N5oBDVKoZnrdqodAAmL3lgThnBfraX4oUo8uhwOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2198
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BCM43454/6 is a variant of BCM4345 which is exactly identical to
BCM4345/6, except the chip id is 0xa9be. This patch adds support
for BCM43454/6 by handing it in the same way as BCM4345.

Note: when loading some specific version of BCM4345 firmware, the
chip id may become 0x4345. This is an expected behavior, and it will
restore to 0xa9be after power cycle.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@intel.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 2 ++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c    | 3 ++-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c       | 1 +
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 1ee49f9e325d..4ec7773b6906 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -704,6 +704,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_pri=
v *ci)
 {
 	switch (ci->pub.chip) {
 	case BRCM_CC_4345_CHIP_ID:
+	case BRCM_CC_43454_CHIP_ID:
 		return 0x198000;
 	case BRCM_CC_4335_CHIP_ID:
 	case BRCM_CC_4339_CHIP_ID:
@@ -1401,6 +1402,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 	case BRCM_CC_4354_CHIP_ID:
 	case BRCM_CC_4356_CHIP_ID:
 	case BRCM_CC_4345_CHIP_ID:
+	case BRCM_CC_43454_CHIP_ID:
 		/* explicitly check SR engine enable bit */
 		pmu_cc3_mask =3D BIT(2);
 		fallthrough;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/d=
rivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 7c68d9849324..d2ac844e1e9f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -248,7 +248,8 @@ void brcmf_feat_attach(struct brcmf_pub *drvr)
 	brcmf_feat_firmware_capabilities(ifp);
 	memset(&gscan_cfg, 0, sizeof(gscan_cfg));
 	if (drvr->bus_if->chip !=3D BRCM_CC_43430_CHIP_ID &&
-	    drvr->bus_if->chip !=3D BRCM_CC_4345_CHIP_ID)
+	    drvr->bus_if->chip !=3D BRCM_CC_4345_CHIP_ID &&
+	    drvr->bus_if->chip !=3D BRCM_CC_43454_CHIP_ID)
 		brcmf_feat_iovar_data_set(ifp, BRCMF_FEAT_GSCAN,
 					  "pfn_gscan_cfg",
 					  &gscan_cfg, sizeof(gscan_cfg));
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 8effeb7a7269..8328caaa2f96 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -652,6 +652,7 @@ static const struct brcmf_firmware_mapping brcmf_sdio_f=
wnames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0xFFFFFFFC, 43430B0),
 	BRCMF_FW_ENTRY(BRCM_CC_4345_CHIP_ID, 0x00000200, 43456),
 	BRCMF_FW_ENTRY(BRCM_CC_4345_CHIP_ID, 0xFFFFFDC0, 43455),
+	BRCMF_FW_ENTRY(BRCM_CC_43454_CHIP_ID, 0x00000040, 43455),
 	BRCMF_FW_ENTRY(BRCM_CC_4354_CHIP_ID, 0xFFFFFFFF, 4354),
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_4359_CHIP_ID, 0xFFFFFFFF, 4359),
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h =
b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 9d81320164ce..a0fbdaacd71e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -32,6 +32,7 @@
 #define BRCM_CC_4339_CHIP_ID		0x4339
 #define BRCM_CC_43430_CHIP_ID		43430
 #define BRCM_CC_4345_CHIP_ID		0x4345
+#define BRCM_CC_43454_CHIP_ID		43454
 #define BRCM_CC_43465_CHIP_ID		43465
 #define BRCM_CC_4350_CHIP_ID		0x4350
 #define BRCM_CC_43525_CHIP_ID		43525
--=20
2.32.0

