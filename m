Return-Path: <linux-wireless+bounces-1183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B0E81C111
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 23:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F332B2137C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 22:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7B6519C;
	Thu, 21 Dec 2023 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="EloYgwQs";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="Jju5VGpR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638777F23
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLMNZDN003999
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 23:29:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=12052020; bh=gDDm50Pa
	FOgcSPcPJt7awimuQj3XVFDdqsl2w3GMZzU=; b=EloYgwQsAbptxWmdnMAHVzia
	vWBabK49zbyYqKYEcrvsYjV7zhILpWsTkxZLYs0/31YxNNXOAGJ58z1lKATyze1W
	xBmCASTrrHH+GT+Z+EoBUOUHpqT5XR/gtOVW4cIjKewV1Y34a9U6ugr4NFAE8wpv
	9opASyYA1IDsSDJa9vWO/UPl8dXAjROre9I4oH8apnHsPW1uB5FeAxM3ARBAiDdC
	v2uABK02kJMtHMDILtRps4AxBODIKs6BA/cIXDG0u7quIFxdks+poPoa5qR8ovlL
	bwKpJ/TiLYIuV7mgHMw0roX1oVnZnAzhweolciVmDSRvMVSJtFfNFMF0SoMDww==
Received: from mail.beijerelectronics.com ([195.67.87.131])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 3v10s3xjv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 23:29:13 +0100 (CET)
Received: from EX01GLOBAL.beijerelectronics.com (10.101.10.25) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17; Thu, 21 Dec 2023 23:29:13 +0100
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (104.47.11.232)
 by EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17 via Frontend Transport; Thu, 21 Dec 2023 23:29:13 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRwrxQ8YFKWg5/CGgDmubv5mxYvHzcW8W48F9ouBQAkTPzWnscSBpn1t6+3Mb2kj0rL/be9t5DtQHDxecL3C/n9t7yQv4xrCHt21GgS6pNEFDYx4Tyt4JPliiP7WwF7VjyZyYdAUs3CUcpvHInZVLFfFe43Pzuuu7ktLnRQKgOtIeljyB5F5IJAuST1u/Cjq/JfKulzYqPxhtbX6iyJSN2cHhn9iDbPYn0XbtU/A1YLMQAEkqT6ZRljJblJ9yfwUj2WoVkU/gMUKAcesgfsDBCHfZNbtr71TA//LHmE8NCa5RFKsF8G+jrGOcwuHNZ+oryfk/1Crp3eLuOrSd+CAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDDm50PaFOgcSPcPJt7awimuQj3XVFDdqsl2w3GMZzU=;
 b=nRWXveg5nL3NsigHq5yq+SQk61sHASjsBJQHITH/2DWZDfqljuiFnsgpJ8vC4PbzZYaipvWe9l2W68d0mmRys2Xr0ON1Lo2sPpBjbNr1w6A2Jb5TwOvUUpE9AiRlChHNTNgQ6y7NfRs7HjBkXjWtL+GUG702GJJzsj6OQ1mmSYUCpPhIM4IzRxpcNYM6ZsiJ7Kt4yMupjoPI/KQC+2Am5234OB671UDXct52zrg4K6+lebM1zBwcuBR4kaQd+Z5alpG9IgiCM7p3lO7YVz05QseASn7eRR58VC/l5d1RW7OiIGuyy7Yp62W/XSOSjhG1RA/xgXKfh4eTvgEJo7yJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDDm50PaFOgcSPcPJt7awimuQj3XVFDdqsl2w3GMZzU=;
 b=Jju5VGpRiGvesZ2Ifs9K6jo0xVkeWbbdt8B3X+m7HzDM2VujsPnqZY/5u6Co+QsyduqVB1kjS2ptW6FKFCghPXtoWGbdqZu90iVk+OsItjMgOPvFmXfJ5CyZgPxCjWEb3ifOnXrmYA/WCYgiQKnCGtUyUOmYkIOvkD++CIOXe2A=
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:296::18)
 by DBAP192MB0938.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 22:29:11 +0000
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::634:bcfc:47a9:2139]) by DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::634:bcfc:47a9:2139%6]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 22:29:11 +0000
From: Matthias May <Matthias.May@westermo.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Matthias May <Matthias.May@westermo.com>,
        Zefir Kurtisi
	<Zefir.Kurtisi@westermo.com>
Subject: [PATCH] iw: strip NLA_FLAGS from printed bands
Thread-Topic: [PATCH] iw: strip NLA_FLAGS from printed bands
Thread-Index: AQHaNF0ezoZiAIUSEkeOjKb9CRHPvg==
Date: Thu, 21 Dec 2023 22:29:11 +0000
Message-ID: <20231221222842.1310957-1-matthias.may@westermo.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.39.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P192MB1388:EE_|DBAP192MB0938:EE_
x-ms-office365-filtering-correlation-id: 7235a028-1bbf-4a83-b16c-08dc02744140
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6khpfp6uuNCVOXhYgVGxSE9z19bJrgldbe8Lgk4vljA4h0tAksg0KYLw6D72tHPzcCEXTdQODbIgIAQFaouwrgGriV12Gra6TEVPoib2I026S6y50elq/ZUTmFu29ZZpN7CJ5mUvDiDfkClrCq7t7SLVQl3l7PYgbys5QU4tlFrxjAC4K9xXb8UXNn/g8VhJ1gQKygRJ4AulsxrwldtYTxshWWI+eM144L4QB7ROf6/X2C5NPHr/oOxVYMoVG18OulI780xk59QD/1944a8wb9V0kbnZm0EL544iZeRFcaPtsABWHn8kupbxjEuZc0cKfULjlDNou7qhbwZiNnQK5gg6+yOtefNrs/G9ul3Uu+J8WjAAz72ER7p0LMTZlNosEVRS9rdWSrzp7uvxNGnBQ+qoe5djdadV6mMuHhERRz28Y52PT4r3QfJFELsYE0b6dBgTTkmhOgyG0dTp9L9If1VHX5ulapMMCguLBUegCwt25GDKXsvktDsJ8AD9pqYaUy49ROO3p/DEum2jlP8E5MhUfURoEIvGuHnYq3VzTva1+Qg42KR4FgAZbAeaY3kwXWYsr+oH8hp2I87YamFc/kxzS3bJATlJQe9LaqRxxJMprwvKgcVZqolc/+U0G/5A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB1388.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39850400004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(38070700009)(86362001)(36756003)(38100700002)(122000001)(26005)(107886003)(2616005)(478600001)(1076003)(71200400001)(66946007)(6916009)(316002)(66476007)(66556008)(76116006)(6486002)(6512007)(6506007)(91956017)(64756008)(66446008)(54906003)(4326008)(8676002)(5660300002)(8936002)(2906002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8YUwfUF++cwcWMRecLQyuMk8EiM0NIQFSL9G3UjjoJL1CTYGbqwMDa4+h2?=
 =?iso-8859-1?Q?V/x+6LnONFLwbo/HgsE5acj3MgGDK0uOf84GD2Qa/nlujYTWgLneYrhL7D?=
 =?iso-8859-1?Q?i61dM8fO3GvfQ5F25ZtLqDnfHTw1tSa5+EZkmnJaFajklFW/lqs4F7Q7ij?=
 =?iso-8859-1?Q?F7wc3PeTVCV/2O6cQXXBmlp297EVs2UtH0YePHrHb1X9nPewDzFBp08nL9?=
 =?iso-8859-1?Q?AEUEh8EOOX54ft/GMNEXgljNi3DAXKZ+xVCQ0Dfgsu5S11BNiuc07az5W9?=
 =?iso-8859-1?Q?G5sgKqfG40zt9WMnsp+l1RHYqLJCok2/+d+gBstncML4MdWlWtdyg0jYq4?=
 =?iso-8859-1?Q?kbXvK7JMaOjH+w0HiX3x7nYtx5MNcSI/CKbgxDg66Kqfg4ZA9dI3tjd4kt?=
 =?iso-8859-1?Q?ESsfyYDuSxOdILpzUXcyyul9BrzbB8b/jg2m1bQ8dvxvLZkSQ0YKtpfjd1?=
 =?iso-8859-1?Q?AZNRJfW/O5eKFyCjEj8xQfA6K2EYK3tg+cwlqOb7CRaKBsX5AURUu1Fu9M?=
 =?iso-8859-1?Q?w51kF3UatRrM+MxlHJp9yh/wO0imASLb25LhOPsUM39/erjvBHOnoHZHNy?=
 =?iso-8859-1?Q?ecHHAyQQ3qLTnGQy+FjUedWjSnt59wqUi9+nP3CEBvCay+w+IZb/0U7C7y?=
 =?iso-8859-1?Q?IexsgImYlytTFrRy/xoe9YV+RQeplm77KEZx5I0hR84aMllec+YMRSmAeR?=
 =?iso-8859-1?Q?Y8LuDk+Eejka69N7dsJVg3pVAxkUyV1NCO9UrXcYkZaxKsff6IToUv2aDU?=
 =?iso-8859-1?Q?0P6xKz6a0tAzPhAHVtaYhoQeijG9W9+IGk96sIe1X6HpORINWgL4PjMBLR?=
 =?iso-8859-1?Q?3ByOOgFA9U5YAhneyXdyKKb50Cov4FckfkXU/j4qfgzblUHwlvGMx4MMaX?=
 =?iso-8859-1?Q?SxMbvchMQCotIzXoCyXKq0vplH8GgJlZj+DG24KzJvihgbAM+FVNgWIJwy?=
 =?iso-8859-1?Q?VkMLODygvShIYLQE0HFg9mKvGgp/j0ZaKn5RS/IhJKqVtMd9/l/8q9Urtf?=
 =?iso-8859-1?Q?fdXkdC7Y7hHfQo/juy+hBRUR5uV2qIh8qefQNR9YzKyqJqtoxV31gIRysb?=
 =?iso-8859-1?Q?i/iA6uBq4Iku63CEzYocJ9HtPd3z12dHN/XX7NhPZUlRZ7wM6B8yChp/0d?=
 =?iso-8859-1?Q?SW2bpRDdbZvTpYVT2ZLdOhimZvB/9SJlxVsRl6NZhn+wmWEvsM5SR26BV/?=
 =?iso-8859-1?Q?OxsAfDmH1TaNgaHI40ag1PK207q72yFTOMZp13TceUbsydqowxyFUw63TV?=
 =?iso-8859-1?Q?xuGeDZQbOnRCaQADmTEzZOtCXlOAylUHT1kSLWRIL/KLfos2jY6JSeJ31T?=
 =?iso-8859-1?Q?7Gih0N/2y+Tx8RYRuyNLZUTRikQFSaYRBxJiKOcYCF+SoOwH0koyFKwCZw?=
 =?iso-8859-1?Q?oTj0cZ0hAxeeSBiEWbvF7XYhLBZFIS3FL4r+TvjwUCd6G3oMcLzpIYwL1q?=
 =?iso-8859-1?Q?vEs/EGCGsxS+p+2j4IwGhlrYvj3HLehlOAyuAgP2Da9pDIDXhnB6Q1Aebs?=
 =?iso-8859-1?Q?jHUzHDCp4OwuttnFg9B816gn4D1/mXHO3AfNe7U0xt0rW7K4esrLh0qGcj?=
 =?iso-8859-1?Q?spoAxZKtGJA+Jvc0cdaD6OJPRF1DsdqhxLLfOxbjxelgfoq6YIfG3P37Mu?=
 =?iso-8859-1?Q?iovwjxUJK3GH194n44hhEbILzyg2GBTT46?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7235a028-1bbf-4a83-b16c-08dc02744140
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 22:29:11.3534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eXWgFfgpW+/G951kpog1Ij+3s879RZzv4FAvxP2GD3pTWhRD6KlZkVd1/+yZWS7faF9OS6Hn1CHRY1ujmG0uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB0938
X-OrganizationHeadersPreserved: DBAP192MB0938.EURP192.PROD.OUTLOOK.COM
X-CrossPremisesHeadersPromoted: EX01GLOBAL.beijerelectronics.com
X-CrossPremisesHeadersFiltered: EX01GLOBAL.beijerelectronics.com
X-OriginatorOrg: westermo.com
X-Proofpoint-GUID: c3BfxIUJcWdq1DOZSIda7IpP3JRaJ4vX
X-Proofpoint-ORIG-GUID: c3BfxIUJcWdq1DOZSIda7IpP3JRaJ4vX

nl_band->nla_type might have NLA_F_NESTED (0x8000) set,
causing 'Bands' to be displayed with an according offset
when used directly.

Use the nla_type() macro instead to strip flags for
printing.

Signed-off-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Signed-off-by: Matthias May <matthias.may@westermo.com>
---
 info.c | 2 +-
 phy.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/info.c b/info.c
index 317e7a3..5334436 100644
--- a/info.c
+++ b/info.c
@@ -354,7 +354,7 @@ static int print_phy_handler(struct nl_msg *msg, void *=
arg)
 	if (tb_msg[NL80211_ATTR_WIPHY_BANDS]) {
 		nla_for_each_nested(nl_band, tb_msg[NL80211_ATTR_WIPHY_BANDS], rem_band)=
 {
 			if (last_band !=3D nl_band->nla_type) {
-				printf("\tBand %d:\n", nl_band->nla_type + 1);
+				printf("\tBand %d:\n", nla_type(nl_band) + 1);
 				band_had_freq =3D false;
 			}
 			last_band =3D nl_band->nla_type;
diff --git a/phy.c b/phy.c
index 4722125..ebd7289 100644
--- a/phy.c
+++ b/phy.c
@@ -52,7 +52,7 @@ static int print_channels_handler(struct nl_msg *msg, voi=
d *arg)
 	if (tb_msg[NL80211_ATTR_WIPHY_BANDS]) {
 		nla_for_each_nested(nl_band, tb_msg[NL80211_ATTR_WIPHY_BANDS], rem_band)=
 {
 			if (ctx->last_band !=3D nl_band->nla_type) {
-				printf("Band %d:\n", nl_band->nla_type + 1);
+				printf("Band %d:\n", nla_type(nl_band) + 1);
 				ctx->width_40 =3D false;
 				ctx->width_80 =3D false;
 				ctx->width_160 =3D false;
--=20
2.39.2

