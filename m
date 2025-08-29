Return-Path: <linux-wireless+bounces-26877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165D1B3C56E
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Aug 2025 00:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AD9A25FAF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83A32D77E6;
	Fri, 29 Aug 2025 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n+Tn1Rck"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE53A2459DC
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508331; cv=fail; b=ThWK0WsVxAgCy4vVXPgbNw138+2sp5sU8lAxU1WJm2dlaiXwdJLQI6TvOpUBb7Qi+4Vii/1iZON2suhvNq9yTj2RpOak5hQ/v2DTzmwLaqCgCW6MHI/lz+D1L4shxyUZ5BUPnERYoYjLLBdhPBagqxxYI8Okz4lONUa6aETOjVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508331; c=relaxed/simple;
	bh=k7j+6x/m6tapHKqUyHsOax66giyLjKR/10w2LOm/f3U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m9Rkr4vgCGNvN3iiXPvVZSn4Q1MI8HsgW20Y9fm0/AfoP4kR5fMrczwnNKZLukYkAEZWEcGMN/aQ4imTEQMV0VHuAFKghcTqvocma3xqKP9G2oZP0u+VlFCEY0w9fi9AGcc48I7cNQMOJt0yOI2gcHGRk7YFEuZSYeBUeZj232k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n+Tn1Rck; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkoeVDda16s/Xnok1XgcrCYpYZEwZBcRIAkxb3C6TJE7zX+mf33iulgJM4mtXAlN2BebKvD4Mvbkw3s2Dqxa3lbyJzJod1IDscjYgnCUsok+MVS+/UAJjivsqo97ItfooKpRnprfnHNlfc0W0wSNy10cmD2CGdBkQXeQTQiJPiUNgAzGNKHY6yeCF3vh3gJSkR7xcYQ/Ia2Os8diW6TnkK5TNT9fcSN8fOzAnyz9+mtsiPNPLwQr84lG0+ym+C957pgERmZgS4i1MrnMhKsZ0GVum1KnyornWJRPBZnGtZKrp7sMDEwJsCIeVdv9gyCLY0LhaoMmMzpLV2fWocmPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIaVUwF2w5s5IRGc0ahozSVbl8BwbJZMNgFmwp7AcGo=;
 b=zVjea+epnGZgtEhv1KjDittcXIdBoMDa9lqyTxF9nV4u7quXSlDLZzg9wKlI9B/DfZSrWRxtprDp7q3yF+loB3C4URQnVIS74IdxpygD2oR73AiVs2enWfWRljfYyO7mzoFvJNjGB/2Gspew+cV5IE3PgxiAbnFxw7sgC5a/E8w8nSXdsP3pNEYdvA5rhULuLbYt4F/edbxRpsoO7v/4DmWDDqjPQoLqD9Q0gY1V9vDJihzrtnCv7g4vylCBBo7lqy3AREpfM9rhjFrX6O7povMleq+pA/TWMOT1g4sMadQYwgdaAEgyrm/6+TKpYRNXf0YPdEnx1/F25lSNTINl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIaVUwF2w5s5IRGc0ahozSVbl8BwbJZMNgFmwp7AcGo=;
 b=n+Tn1RckjBxZNFZgS/RtxxD0z+DUPEWzllWdFFJAL2O+JgzzHiqbcyArTCapioDluXbyH+B4yJWwHWbzTDnvL2b97pwuhRRvwWy5WzY60IIqdMpLN5VelS90Ro5PotES64885+jOvpXpLDj11Adrn4myahRBCRFcD2Pi9jLAraB1gNFDtDCCKgXLt+AYoDWHxms4UMo3tRyFLA2S0hbQji1of6OIGxkbeBeLPZYmRXBIqjVL+kdc9lu9EU0TpvYNftgIltfrIegvNsSOAiBbvcK4oLEJNk5z34oVFbsG1kprTABpbEVR171vtRZmvVjhaO+t0rTjXxPHzTPB+3CSmw==
Received: from DM8PR11MB5752.namprd11.prod.outlook.com (2603:10b6:8:13::15) by
 PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 22:58:43 +0000
Received: from DM8PR11MB5752.namprd11.prod.outlook.com
 ([fe80::6ad7:8f77:89fe:bc03]) by DM8PR11MB5752.namprd11.prod.outlook.com
 ([fe80::6ad7:8f77:89fe:bc03%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 22:58:43 +0000
From: <Ajay.Kathat@microchip.com>
To: <linux-wireless@vger.kernel.org>
CC: <Ajay.Kathat@microchip.com>, <dan.carpenter@linaro.org>
Subject: [PATCH v2] wifi: wilc1000: avoid buffer overflow in WID string
 configuration
Thread-Topic: [PATCH v2] wifi: wilc1000: avoid buffer overflow in WID string
 configuration
Thread-Index: AQHcGTh3AsN0HE7nsESyfiyvZaN7Vw==
Date: Fri, 29 Aug 2025 22:58:43 +0000
Message-ID: <20250829225829.5423-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5752:EE_|PH8PR11MB6731:EE_
x-ms-office365-filtering-correlation-id: 84c05aee-66e8-4763-bdea-08dde74f9a5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?GDVONHfuEiy8xVSJiYtqL0/kZiaygOSI4A9M9XhDO0FSOoak4MO7QBGtFu?=
 =?iso-8859-1?Q?95dqTO+CX3+zQusZN1wgdMRMZ72vga/3KtrElQ8fuCfGBBMIxAlOgN9RPj?=
 =?iso-8859-1?Q?wqDQVvwt2IGGs5lhg1lkE7ZgiWjfWjBSIb5+gMYg2j+QuRkMmFcRFMVbCx?=
 =?iso-8859-1?Q?058qGiHziyJF5UDxDtrUDLRekWIXmWLgYTOhl4JDsjQ8/lWfcduuEc+OsU?=
 =?iso-8859-1?Q?y4LV3m/4/CL5K6XrLn/5VTfb4ZV6BKmaQV6TALrT2IasiFzm0ZmnjtQoix?=
 =?iso-8859-1?Q?AfJOxdC4fxRxUS6543u+XlUsA9rhMw5tw277/iZ/Jg6gv3dtYz3OsYKR6v?=
 =?iso-8859-1?Q?CtFGMENZP4ClVqRJSwzBW7BsZqohH7sqPOzqJUIRM8kKEd93cBayrlRArY?=
 =?iso-8859-1?Q?hwt1zFYxF5iB4t1lr3OToBS8ZSB4VBakzwm9NDcfowL1clA2DNwgomIlu/?=
 =?iso-8859-1?Q?XNw/GBUNblpVRVAr8uwfFvAqzqDgI5+EfcG9zjWlrjI4D4GvsZ/uYiAghp?=
 =?iso-8859-1?Q?sCdjqZCOzUg1ojYDE89dHrVgYH5ap21ZlC80L7ETS0Dl04V1CyVMLcJQYx?=
 =?iso-8859-1?Q?qTAysDCaOtzx7bdgKy+lmdM+XQwEbq3r5VJlq4Z1jrKke1qXTEg63eLaF1?=
 =?iso-8859-1?Q?3GhKcUGs8I4Lpjrfbr/8ZrLvbOBpVIlHN5aMnmN8XUE+cukQJNTYvqFCiR?=
 =?iso-8859-1?Q?34B51yIt5U/jS+tlH10J0NeQOS9xoBnQIPt1nGPVXKJQseLPwAzqD49t5K?=
 =?iso-8859-1?Q?JFAdUlKKSQRGhdHLxeuaiPnZ5lunk2iS29Yh494Wg35/priqosWnyyBmvc?=
 =?iso-8859-1?Q?xM13j9jg6xfOZPZZJynMp72Nq2kZNCoK3f/3ktZwhPe1zieVcD9xQhBNiR?=
 =?iso-8859-1?Q?OgIE8n38nNQoRxk0c5geGIvVOujdOmxJmAN3DE8psCcWZDkLxl54weVFzJ?=
 =?iso-8859-1?Q?pDW7870qd8p66hs8nVAHDjfoK4DI9QUCms6MKFdSLF81WXidwBy2DJmDay?=
 =?iso-8859-1?Q?slkfhgJ7sTUmUEOTpunwZDG15g5GpYLUlsMve9SvCKM790DlDIoCf/DnE0?=
 =?iso-8859-1?Q?9QNRD3CRaQkZ/WnElth9sIJH08kW3iEs/84EsltN5s5aYWuAHVM6hoZMKy?=
 =?iso-8859-1?Q?Y1AZpiwlEW2lhcB5RFk4c+gQpqxc76S305o8Lcmx/Id4Y0805Djj5L8ibq?=
 =?iso-8859-1?Q?PJSUcjTp8wqbkr4rR43A5vVfBFHSyCCOgxG25f+HyLwAdgDTxWpup3CR/A?=
 =?iso-8859-1?Q?5Vv1X9ZEJHwOAV1jgxE8RF59t1wI55JvZhwwZsB96CRt1hJqUsFBRNvpOT?=
 =?iso-8859-1?Q?jJ+ZxBWIHyxZUkQpA5ize5c+lWbkVwoq4i9Y+w0m3U4BxslD8fmaSs2N8w?=
 =?iso-8859-1?Q?ozxEq8twn4YHsred9EoVAGhEydPfXLxZCxqeRaTD3Ooo+u3iczb0lXDf9/?=
 =?iso-8859-1?Q?vjRRdiPCZ4kkXDnrxRpmTh0z1IN1pRHyuk7n/bhESc1aCNj9QAh8e7njk0?=
 =?iso-8859-1?Q?lBUlnb7Ey1Jahw68212w3fWQu5CEjfhUxJs+01NPAvqBvoPYtSDRYDA2eY?=
 =?iso-8859-1?Q?4kcc7OA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p7qCSQS1eqqiD4uHcVx535rcrUTSkSjxPoCPu6uGjWCEkupCoToZjKbVC9?=
 =?iso-8859-1?Q?WHNUQNX0iqRTxc2maII1rkp2ROf/tcEd9xFF/B0HMLhFdaVDtFcsJdoT1R?=
 =?iso-8859-1?Q?xbKr6SD5QihM4Ng2CGZWBmW12qozcUdMhgRbW2ZgvRRjthXCQEz2sPyPpY?=
 =?iso-8859-1?Q?g4+s3c2VGW+IgczKeH78G5g5gbox8YCdTl8ag6fkejILO/X6ZL0BSZiq1z?=
 =?iso-8859-1?Q?DuXjRAS3j7OFVxgtYlKuMMDCskBN7yXPi9Hw3/7iig/4TsDLYjaQXLE7Y/?=
 =?iso-8859-1?Q?h3Fr4eo0dXZmwDR90dZTpwYKj9j13xONzelwuCDmhP0wRDInj+RJwBtw1w?=
 =?iso-8859-1?Q?jpMs6ti7SL9hUjfjEiayLCQbmwTgLP3K1oNqtKZ1Ser754LJm7K1ItVf6g?=
 =?iso-8859-1?Q?DrsBAqAuKSHOeFXATAg7Fh8D6OtRYlfkXEtN4sFrgJ5RPL2Aw42OjAalZh?=
 =?iso-8859-1?Q?tbGnEvNzgA9DqlAVti6Gg4XKnp8c2K2zVLGp8KmsB1+jJwDVU61KjHRvGI?=
 =?iso-8859-1?Q?1GUBSx1R3djf8SOzaBVJHRoUAeBeA91cqjSLcnms6s/HzeKM6PN1ElJtHN?=
 =?iso-8859-1?Q?1rRE55gEzOvTZBJm+uj9dyAUab37Bs1jkyRrMCN651WGwdbc3vK8EvcJeE?=
 =?iso-8859-1?Q?zsuLbUtb+y7rQ+DI1oidSxjQuMdvm+qokf9Pj/3zthGKeXWM7Zg1EdR60z?=
 =?iso-8859-1?Q?4uekaPlOXIJUPuue8NStOXWX1Kk19/2fXKDh3uP38MnK1CKIlpfM6/SN1o?=
 =?iso-8859-1?Q?fI9wpYcrmCCLII5tUZQnNLOdWCjRGx5/5Ae4GGMM6wuSbq4YLdflxBFeBw?=
 =?iso-8859-1?Q?VGFtiLVRqXziNQpqNtA1OY2JI+IE5OapZxNP8+pya5d/HDh0oVt44YRHJK?=
 =?iso-8859-1?Q?RtqFUxVMPW/FuZNNHnlPE58RRNCIK6CWvXZtMph00+IdRq+ykrmKU3OeiU?=
 =?iso-8859-1?Q?t5+FMhK1smXYRu0wa1s4p2P6MgbHoDFNXoZwaBp/lCIpm3LiSbVa4OocYf?=
 =?iso-8859-1?Q?0GTeXJM/9O/LZ7U4/qzEbtPAKweRVDR4mM2sDze954oK/eMYFFUjQ3L4IT?=
 =?iso-8859-1?Q?Kyd5W5Puk63PIO5CIadxRsa+q+LFxRi2MczV4ki3dFUEzcfqFL1fYlQWoK?=
 =?iso-8859-1?Q?uks+nMv2F8TUvlZucko0lwHSwJ1QKB6nFeGv9SQtU50RiQ6RB5a2OEacLz?=
 =?iso-8859-1?Q?N48x91hXRT0kGK7SffUbQQF9RWpdzAkI+apOH74MS63hPdJRFLe56RfSF4?=
 =?iso-8859-1?Q?7OvUcpHnMASKT8Tm6tnHKC8YsDDsZOmI4EjDgYP141IxaF/Cn1UdZOX3aZ?=
 =?iso-8859-1?Q?xRhfeXDHWXS3QInG0Oo7NbMlWHXHAPI9YQSf91UskKoea+lDcDSWJ4esT4?=
 =?iso-8859-1?Q?H0hJ6wBrWnoBBmb9v3LsnkBGpiRtzi7T7gwA8whWqi9iVn+eMYMtoNOxW/?=
 =?iso-8859-1?Q?CODaqiPGmb0oOudIN41VAVzowaddsV0NE+yXHk5mPhoztbzPGm1LLP8NCP?=
 =?iso-8859-1?Q?BNQ2k0qaaCZd3kTQNHll7n4Kfa+XDdACr+u9GrTsj8Uq2+MpxeyKS0LmLc?=
 =?iso-8859-1?Q?qwXV78A/ulDYrJLDCT7qUcvb1A6zhM8NRXziNL0PkCaidQW7gppn5wnLoZ?=
 =?iso-8859-1?Q?qN+bQprGzn9dCV2F5nFlS4tBCNJhJpcoNtK/r5/Cwf8vzSmHIxTh4Ylw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c05aee-66e8-4763-bdea-08dde74f9a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 22:58:43.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSxi6Nvvb2ztl5hEKwPtCcpDqQgA5KxaQLWioROX5HkoOloAKzxnQWwLHKC+YrOn0DpKyxHzBu2tvkc8xkhkMh8/fcrylOeY8eqdbobE7H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731

Fix the following copy overflow warning identified by Smatch checker.

 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c:184 wilc_wlan_parse_res=
ponse_frame()
        error: '__memcpy()' 'cfg->s[i]->str' copy overflow (512 vs 65537)

This patch introduces size check before accessing the memory buffer.
The checks are base on the WID type of received data from the firmware.
For WID string configuration, the size limit is determined by individual
element size in 'struct wilc_cfg_str_vals' that is maintained in 'len' fiel=
d
of 'struct wilc_cfg_str'.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-wireless/aLFbr9Yu9j_TQTey@stanley.mou=
ntain
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---

v2:
 - change the limit check for WID string
 - use even sizes for WID string buffers

---
 .../wireless/microchip/wilc1000/wlan_cfg.c    | 37 ++++++++++++++-----
 .../wireless/microchip/wilc1000/wlan_cfg.h    |  5 ++-
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.c
index 131388886acb..cfabd5aebb54 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
@@ -41,10 +41,10 @@ static const struct wilc_cfg_word g_cfg_word[] =3D {
 };

 static const struct wilc_cfg_str g_cfg_str[] =3D {
-	{WID_FIRMWARE_VERSION, NULL},
-	{WID_MAC_ADDR, NULL},
-	{WID_ASSOC_RES_INFO, NULL},
-	{WID_NIL, NULL}
+	{WID_FIRMWARE_VERSION, 0, NULL},
+	{WID_MAC_ADDR, 0, NULL},
+	{WID_ASSOC_RES_INFO, 0, NULL},
+	{WID_NIL, 0, NULL}
 };

 #define WILC_RESP_MSG_TYPE_CONFIG_REPLY		'R'
@@ -147,44 +147,58 @@ static void wilc_wlan_parse_response_frame(struct wil=
c *wl, u8 *info, int size)

 		switch (FIELD_GET(WILC_WID_TYPE, wid)) {
 		case WID_CHAR:
+			len =3D 3;
+			if (len + 2  > size)
+				return;
+
 			while (cfg->b[i].id !=3D WID_NIL && cfg->b[i].id !=3D wid)
 				i++;

 			if (cfg->b[i].id =3D=3D wid)
 				cfg->b[i].val =3D info[4];

-			len =3D 3;
 			break;

 		case WID_SHORT:
+			len =3D 4;
+			if (len + 2  > size)
+				return;
+
 			while (cfg->hw[i].id !=3D WID_NIL && cfg->hw[i].id !=3D wid)
 				i++;

 			if (cfg->hw[i].id =3D=3D wid)
 				cfg->hw[i].val =3D get_unaligned_le16(&info[4]);

-			len =3D 4;
 			break;

 		case WID_INT:
+			len =3D 6;
+			if (len + 2  > size)
+				return;
+
 			while (cfg->w[i].id !=3D WID_NIL && cfg->w[i].id !=3D wid)
 				i++;

 			if (cfg->w[i].id =3D=3D wid)
 				cfg->w[i].val =3D get_unaligned_le32(&info[4]);

-			len =3D 6;
 			break;

 		case WID_STR:
+			len =3D 2 + get_unaligned_le16(&info[2]);
+
 			while (cfg->s[i].id !=3D WID_NIL && cfg->s[i].id !=3D wid)
 				i++;

-			if (cfg->s[i].id =3D=3D wid)
+			if (cfg->s[i].id =3D=3D wid) {
+				if (len > cfg->s[i].len || (len + 2  > size))
+					return;
+
 				memcpy(cfg->s[i].str, &info[2],
-				       get_unaligned_le16(&info[2]) + 2);
+				       len);
+			}

-			len =3D 2 + get_unaligned_le16(&info[2]);
 			break;

 		default:
@@ -384,12 +398,15 @@ int wilc_wlan_cfg_init(struct wilc *wl)
 	/* store the string cfg parameters */
 	wl->cfg.s[i].id =3D WID_FIRMWARE_VERSION;
 	wl->cfg.s[i].str =3D str_vals->firmware_version;
+	wl->cfg.s[i].len =3D sizeof(str_vals->firmware_version);
 	i++;
 	wl->cfg.s[i].id =3D WID_MAC_ADDR;
 	wl->cfg.s[i].str =3D str_vals->mac_address;
+	wl->cfg.s[i].len =3D sizeof(str_vals->mac_address);
 	i++;
 	wl->cfg.s[i].id =3D WID_ASSOC_RES_INFO;
 	wl->cfg.s[i].str =3D str_vals->assoc_rsp;
+	wl->cfg.s[i].len =3D sizeof(str_vals->assoc_rsp);
 	i++;
 	wl->cfg.s[i].id =3D WID_NIL;
 	wl->cfg.s[i].str =3D NULL;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.h
index 7038b74f8e8f..5ae74bced7d7 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h
@@ -24,12 +24,13 @@ struct wilc_cfg_word {

 struct wilc_cfg_str {
 	u16 id;
+	u16 len;
 	u8 *str;
 };

 struct wilc_cfg_str_vals {
-	u8 mac_address[7];
-	u8 firmware_version[129];
+	u8 mac_address[8];
+	u8 firmware_version[130];
 	u8 assoc_rsp[WILC_MAX_ASSOC_RESP_FRAME_SIZE];
 };

--
2.34.1

