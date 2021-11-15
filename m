Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17B450289
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhKOKbc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 05:31:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:13945 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhKOKb1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 05:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1636972113; x=1668508113;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=IKiNf2Ev7LR796gOOjfVlW8bulTs1otmwqXbAWKd5FU=;
  b=evdQngSsGlrC9G8gUZc8+KiofkVueNQ9MqDx/mG8v0+ua8AlMUHsWFfm
   xdDqAHcmBTSdgLKI4lPjtzWGRVw6xet8+MnWPmp50tL87aBaREhmEZR8c
   9noaIBOb0Q9PcDMr4KtA9O+vb3n6hf6qfXEdcaiQPHFNKaxxrnLC8DGva
   ni2NgCVCk49apigN49L6sXMfyDdHx1WLZXvf95DseMZrIi8tjZfPB1CmT
   h86cYyVPbKLO9CYP3twQUoUVcJ5mY+ll0sn7+BU1uLgV0Hs0AEeuQcjDc
   n3jiGJpWQV7ZyZwOa7ZEnkfmyNXNUpdiXjfPTkjUY9FbADf177HBJ76qq
   w==;
IronPort-SDR: K8lFOuy1cIbVV9BY36io3INw+E2X4JWd0ojm3v9G1w+QFBQ8c5FYH1L6MJnTbxxrN7CvMa4u7p
 UFpxJ9oGIIESBX10FOXp6BhlwaBh5ZVooIANsZFMGvZtJn4U/iebHPEMmKZqim22JUdCF/SeVy
 ZW0vr/YMpohUmJwC+I9NiAysTifzoY85fVuLI21bA7tCzonmfRdCWxC/ntz13Q4eGNEhl0aJDS
 wh5n6+oJjFla2nWe+HpvM2WAV/VIpfv4WUUB7G6lh5qqOSrpx7mbCw4Q84OZGBEeajT8uVCScm
 nF/yZMKBavFEgCaQKpILD1J4
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="143348669"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2021 03:28:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 15 Nov 2021 03:28:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 15 Nov 2021 03:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjhwpuOALmDhwm4/DZGpfkdEFWtq7zf6bDhelVJRxbV6vb/VQQ2lJiWCB/lDdE+FAMI1cnPOcQ97eGDy1e4s3dSIkY4u9gN8JisdyakVgdAAHOVjc4CWjtbnCNryUPRGiKWLt8SZrWqiBlWDzO8X5YdqRie3pQb4r7AfG6ehQBJcJ3tkUhUvVat5h01WXRXoumgvyiq8mdFnA12hUv9W6ue5c8mjAuv7RYQXaK/C+L3H9ztz8rEmkc2DcH0OSqZTTGKdNKa8jEWRMtoWfCAfGtwIHdUM2vEqupcnli9eXKDnZjQSskJ6SIZnv1gZOwly86e3aZHCX/jQGPpwKe5WAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyhaPn7Z+7QbanCA6xvcqkV/1c8p30YotL/7cWl7Tys=;
 b=NV81LX8yPtqWsc9sdwud6aROWt4wxkmQn05iOb3jHM8tMCb4jnjQtPf+DHs3PSddpVK2C93QHhLIHgcOL3H+zlWelRf1RVL4bUaGLD+du+/QEQnGCDb8b4MA38KIFIJyE8UOVO8/LQQQXL/azjsgsVCjDwfSKuSbX42fEThSr7DEyXU0bIDZXkQAOLqf3+TNhwHgcnqzop77kKJGYniZLcLnONHO6HYnpNoUC5wJljrO5G+Lbrhy0v2W72oxerM0hExVUCwiKyCOsSkG7JMFbJ6Tsyp58tbgjE9mGyXS1+ZssWe4TIskOKk8niWorU6Qt5+AaszNcd1JGETPob9ZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyhaPn7Z+7QbanCA6xvcqkV/1c8p30YotL/7cWl7Tys=;
 b=pEoTYXPmYiiaf7rjiAXkG2MTFwbnvr+GjPG1xj/xLAiIP29VyLKRsA1QaAvrv9N312G9q/vJdekapk0w5NlEnL1tTCw2Hx50F7MZ6J/Y3j0ubefzqoUJnZh41Ufw/YcUQViV5aBZrd11gc92oI1dBaIxRACbLJGQVufMzyxxSI0=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB2584.namprd11.prod.outlook.com (2603:10b6:a02:c8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 10:28:28 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::e8c6:e7d5:83a4:324]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::e8c6:e7d5:83a4:324%6]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 10:28:28 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <kvalo@codeaurora.org>,
        <Ajay.Kathat@microchip.com>, <lkp@intel.com>
Subject: [PATCH] wilc1000: remove '-Wunused-but-set-variable' warning in
 chip_wakeup()
Thread-Topic: [PATCH] wilc1000: remove '-Wunused-but-set-variable' warning in
 chip_wakeup()
Thread-Index: AQHX2guHYNVeeG/YB0eNDEl04/YNKA==
Date:   Mon, 15 Nov 2021 10:28:28 +0000
Message-ID: <20211115102809.1408267-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5f98fe4-df7c-4242-6df0-08d9a822aa1d
x-ms-traffictypediagnostic: BYAPR11MB2584:
x-microsoft-antispam-prvs: <BYAPR11MB2584FA68065E7A1A1BBF1025E3989@BYAPR11MB2584.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2+Y28Z4utLWOqMIw/UW1UQGOpBL1i3ql2bTVpGPKveXIB3cPfvXZOKb+ms1/w7+1QJtfZBpVesARGDnmzaNl7nr4Wq5o9D0GSSIVMWKGVmQoBZIavYATfzwEj15DP8IOC9bDo/Bi3rSXwhIN1oreMbq4mmGKFizj1/2CagDD9wFuRbnWnsMRWxm+D7e4n7FaRHWXViBSDOUsvx1cZs5dgayV8MOn+WyrP1q0/ZHBP9SypRq7yOfHEy5P3b/+2Z4Ov1YwjwZWPy9DyU6OMzvS1uGmpAPiYBcotd8LZJaKDpD/TM0yRgG4IM0YBpxT9W9AKoWHWNHAfIwp5DwY6MbniGQ18Nfblg01qIHO4VukgeHv4xCWDxZExobE0bptzDCwV89S0cyA2on4qLQIVIiWtV3vU8tq2Nds+fqy9XSQg9oAQfTSR5OwMwe8XmbDD0BFlKw0o6nbumh8xb57H6b0TGthCR0eKcbUf4Dok0ueYYCSvmSqx4YK9vB3DiXaZtBuLtiIB2EiBUgf2AJV/+3soSTxF9tv0BLpajHqQ+IixVey9DZa31EwjhuQ7iIjZl+bqye0IH2XB5LO6D55Xt7/JP8lFp670X3cNI8pvTIHsr05nOiJpbyVTEdpuSjYvupWCt4Iylaj8DBqE5w9G2Q4XnkzNoT9QMErflu93oFxh3WxlS7TN9NkXJrbKdnNmDViQn+vVNVjrbxmy6xdvOVkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(66946007)(6486002)(8676002)(91956017)(5660300002)(64756008)(66446008)(4326008)(66476007)(6916009)(8936002)(36756003)(26005)(38070700005)(6506007)(55236004)(186003)(66556008)(6512007)(508600001)(54906003)(86362001)(1076003)(2616005)(71200400001)(2906002)(38100700002)(122000001)(83380400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c/0sgHTF/Vatt3WtyX9yaZVQp7JqL1/EdKEMzGi0ek1s3QvbP5dzNAdMfw?=
 =?iso-8859-1?Q?wV3cus30XESNKZwbxHDvzQjrzBpLk6UoKatmHTqezYemr+4UV/mqM5q1af?=
 =?iso-8859-1?Q?6VsJG0/xhHJWRYewUB2IBYs/f8l+8bnbM40sjP7lasv5dDLJaRKaIxKblB?=
 =?iso-8859-1?Q?jsLzh8QPJvZOIF52pTmNQH/0BIEijz/ISIGQ39ojdw+JYDq0OptT9K2rm8?=
 =?iso-8859-1?Q?rNoVmVV/AcpEc2t4dlVne1tI2mdUgxfnXoPgXm6aCaE2byT8fWkw0+4SEP?=
 =?iso-8859-1?Q?d1uzp5PDu0ZbGsQYMx1n0mFXbb7EG+JpbnLhJhLn7CSC6+QZUtUeL1yCUw?=
 =?iso-8859-1?Q?7coctvLqp/rM0GTQdjiH3iIzskRDdRfNxBAIF5t7h53XrxmGgc2smg4GD8?=
 =?iso-8859-1?Q?g9FxkqbSt62kl1ei84dreXgHC8lIDPbFbM2TObAbzZ4ZWFfK+1BM9wkuGX?=
 =?iso-8859-1?Q?1/xvpmJthkevnTpFpT/qul7XDpqeeLIKsbctrGr6+7CGhfxh77o9Weu1dt?=
 =?iso-8859-1?Q?a4aZ0huZZhqJLK/JNZbfxjmrO4pZr1OmHheQpjZ8Sw/eyGgDiovhWbtj+g?=
 =?iso-8859-1?Q?SL4SdYtojtBFt4+TYJtPBkbVdQ5FWWSLLbl/I3ppWLo9bMFzyne4Gwz6Xq?=
 =?iso-8859-1?Q?Sge9lPHk2+C3kzUDiZQhmj9NWGQ8X9Zccoj+XnnM+o43PjM1AD3zzcD4ii?=
 =?iso-8859-1?Q?rNxKJv6X64IpOxGH92wIsGMfswMoBIWHtG630I/JqJN84oJg0TgtaETpFL?=
 =?iso-8859-1?Q?DQa3auYQJNJuFCojojbMtG8DdX3X6Gd6wZeNPyfiOj9oEhuYH5KvXx2/3X?=
 =?iso-8859-1?Q?UhRLqCS9dPFZdnH6L5nxJVZDvmFZstNN20Xtpw9CnLDui5P5/fKEnYrsaV?=
 =?iso-8859-1?Q?6uVjz+N3yETv+qlWEABj7d621rbxlm5eLm01MRgzEOV+p23dlAvptR+NVQ?=
 =?iso-8859-1?Q?7TOYeXPqBydSgtyOMFiLiz+1ncPVmhJJ/r6KCH+jbA/SnEQrjuOOn5O/L9?=
 =?iso-8859-1?Q?DggEfEPPDNuG5SElnBV56PUL88ReN1w3UaJL5VvVRzEIcfTKl4ln7aKhir?=
 =?iso-8859-1?Q?GxUZHGAJWlC5AQwlfRPbkY1DM80g2jKtdaqx/BFpDcvDYFNyI0RVTu4BFj?=
 =?iso-8859-1?Q?PzLFuYp/w5eLEDuAFC+vJyO1njN2FlhBAZ2xdMX69K4k8qVfs32t6N+X9g?=
 =?iso-8859-1?Q?S6XLNXk3cDVCUBeYbpqiFiGsMhmJOK13eQ+hfEQ4djvsZZz2u8PPOB9aaq?=
 =?iso-8859-1?Q?IOaUf8vndSt+U7GwpU33+XYNr8+26NrUndkDBgCb1VqWRpnSva1uUscBg8?=
 =?iso-8859-1?Q?g8dET11vJgZ0K5O44GBQGiOsIJAr9cE+6ixuVopCXOG7pBNP50lUdOiBYc?=
 =?iso-8859-1?Q?KUFEXXLPvUgCjfuu7KLJ7DhpQG07zfPZSgxetz0X4VdOoH3eRuRH8tQiXs?=
 =?iso-8859-1?Q?uvxiW2Lc0IyMh20drIWsF5DCc1moIKnggR5wdD7S4ebLMknDgNzm2HZDtg?=
 =?iso-8859-1?Q?6FFZJrqGh6jZZe9jSa5pl4HXwuh/bm7z0Fy4VvI+x0WsdaCdzw/TM4rveI?=
 =?iso-8859-1?Q?ZIXtcLi/DGulj/cONpsv2/UlaTEPeESjV4BvrsB7RQN6zpS7plxyUu99i5?=
 =?iso-8859-1?Q?hHbAUBhtiS5qiDIzLsQiOlKJw/iCEMyBJVxztb+fDX8YzetFySO2x0kSFe?=
 =?iso-8859-1?Q?Wbq77EnstIYtg7PEO3gX9MVDFZmW03xpCUa9R3gaSxyiBbmSwJOxwQS5Ix?=
 =?iso-8859-1?Q?MWggoryuhnW6SDd0n31hH930o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f98fe4-df7c-4242-6df0-08d9a822aa1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 10:28:28.4721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7YoCf8hMbPSqPei4XeZJWFKiBYikRjduRK0Mbwydxk1MCVvp70tOcVbttvFtzeVMS1RjeVFfvzFMs35SDXOr7qMOQwRRc2ZBMMoxArTe2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2584
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Remove unused variables to avoid the below warnings:

   drivers/net/wireless/microchip/wilc1000/wlan.c: In function 'chip_wakeup=
':
>> drivers/net/wireless/microchip/wilc1000/wlan.c:620:34: warning: variable=
 'to_host_from_fw_bit' set but not used [-Wunused-but-set-variable]
     620 |         u32 to_host_from_fw_reg, to_host_from_fw_bit;
         |                                  ^~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/microchip/wilc1000/wlan.c:620:13: warning: variable=
 'to_host_from_fw_reg' set but not used [-Wunused-but-set-variable]
     620 |         u32 to_host_from_fw_reg, to_host_from_fw_bit;
         |             ^~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index ea81ef120fd1..82566544419a 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -626,7 +626,6 @@ void chip_wakeup(struct wilc *wilc)
 	u32 clk_status_val =3D 0, trials =3D 0;
 	u32 wakeup_reg, wakeup_bit;
 	u32 clk_status_reg, clk_status_bit;
-	u32 to_host_from_fw_reg, to_host_from_fw_bit;
 	u32 from_host_to_fw_reg, from_host_to_fw_bit;
 	const struct wilc_hif_func *hif_func =3D wilc->hif_func;
=20
@@ -637,8 +636,6 @@ void chip_wakeup(struct wilc *wilc)
 		clk_status_bit =3D WILC_SDIO_CLK_STATUS_BIT;
 		from_host_to_fw_reg =3D WILC_SDIO_HOST_TO_FW_REG;
 		from_host_to_fw_bit =3D WILC_SDIO_HOST_TO_FW_BIT;
-		to_host_from_fw_reg =3D WILC_SDIO_FW_TO_HOST_REG;
-		to_host_from_fw_bit =3D WILC_SDIO_FW_TO_HOST_BIT;
 	} else {
 		wakeup_reg =3D WILC_SPI_WAKEUP_REG;
 		wakeup_bit =3D WILC_SPI_WAKEUP_BIT;
@@ -646,8 +643,6 @@ void chip_wakeup(struct wilc *wilc)
 		clk_status_bit =3D WILC_SPI_CLK_STATUS_BIT;
 		from_host_to_fw_reg =3D WILC_SPI_HOST_TO_FW_REG;
 		from_host_to_fw_bit =3D WILC_SPI_HOST_TO_FW_BIT;
-		to_host_from_fw_reg =3D WILC_SPI_FW_TO_HOST_REG;
-		to_host_from_fw_bit =3D WILC_SPI_FW_TO_HOST_BIT;
 	}
=20
 	/* indicate host wakeup */
--=20
2.25.1
