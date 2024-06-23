Return-Path: <linux-wireless+bounces-9461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6804913751
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 04:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13C61C20A9B
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A779DF;
	Sun, 23 Jun 2024 02:21:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524042F5A;
	Sun, 23 Jun 2024 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719109308; cv=fail; b=PzQJKFvSWlF3jM6bydZ/KPXb7ihS3xKw6rk3mziP96wbjtUIlBcG22XNwo6jVqPs8ITSbv4cHXoACrfstfyClYWHZVnYbLoFhf29S5Nj8SjKdhZAEWpCrV1AoFp8UvhX8JCv7OJvds3wL0teiAbGfS88An6DNpZsFto1ebjtMtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719109308; c=relaxed/simple;
	bh=a5CXsmIt6J/B60XAPDbiGAWk+Sz4cw/QF4BaSm+sNaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fKaJMTfHlGIpPS+4fDxEBAYmkaHjkUu2/LkP/zOevKYbqj20ymUzD1+fEeOdYJLGli5yOvuSJhT70NmH/gi5K9KjGotw/NNEXMC8mc99MxZ6KH0IHHwSklkXF+J2gs0sYwoqSVFj8dWzthK8v3sOT+qZXJBR9YXbFbWgggS2Pjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUFzaB5/d2EmrMgXJOxwPVakQ7Xyzcy3oeFHQWpUmQTOgi++WYKZCuX/x+sV7bjOTwuBVfC4DM7aDk31C5SMCo+82xoq6uYbQJjMmPllz9zR9f4cQVhKh1uV2+Gs802sVdw6VbsGk5QmGCrhEb7ptLqVu5ZmtHdbtNvNfiVeju7+2S8+J+pUj7g7zjFYBlaybyJmDjLcxpPVgwisvSQBRde5e3TDhbQ2KkfJT3zdi9WkQg3UZ546Ub17lUHuzWGUNeqNKHny2V/S2rvXYlj39NHc1eWLNjhsHHJrnFnNmPRi66cNEzMrZlFuh1peedsjzaAvQK4kARtCNvM3kghBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5CXsmIt6J/B60XAPDbiGAWk+Sz4cw/QF4BaSm+sNaw=;
 b=edFQDRVjmo/Lj4c6JtWb8UOblFyLvqYXSQv5Ynn7jz630e34OLfB/98egafl4I7vubHrk3TCy1nYDyxVP/w0wVn9ed9p/OTduPn1DlUDjpDBK+1cL+z//L9bM1oA0aInkxQ+uEjC3Cwz8cr8eti2YXPkos1LGjrBnoauHSC4zAhpV/jpJMoVOhrj83fPjJBlUZyVGqebbWAQoMprbtS9QjAWo0mztZHnzKFX5StIGhWfBPXhlEKRZIE42t54qLmc4x/9uKgLiVFzkdvwPuKd/z1KzgIGKMnQbhYGFoSxowG6H7uWz0kplMLIAR7NleOCA5I+7XMVhQNJ8k9RlMOVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB6959.apcprd03.prod.outlook.com (2603:1096:101:9e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38; Sun, 23 Jun
 2024 02:21:39 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Sun, 23 Jun 2024
 02:21:39 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
CC: "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "duoming@zju.edu.cn"
	<duoming@zju.edu.cn>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>, Nick Xie <nick@khadas.com>,
	"efectn@protonmail.com" <efectn@protonmail.com>, "jagan@edgeble.ai"
	<jagan@edgeble.ai>, "dsimic@manjaro.org" <dsimic@manjaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] net: wireless: brcmfmac: Add support for AP6275P
Thread-Topic: [PATCH v1 3/3] net: wireless: brcmfmac: Add support for AP6275P
Thread-Index: AQHawrWkSZjILdfElUC6XOD5DUOw1rHS7xyAgAGnXp8=
Date: Sun, 23 Jun 2024 02:21:39 +0000
Message-ID:
 <TYZPR03MB700154AE39D44B8D166344BF80CB2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240620020015.4021696-1-jacobe.zang@wesion.com>
 <20240620020015.4021696-4-jacobe.zang@wesion.com>
 <fro2xcwsnvbxmpszny6g2p36z4zwoq4kegmpvww4twxir5piez@a3c2nbwitmab>
In-Reply-To: <fro2xcwsnvbxmpszny6g2p36z4zwoq4kegmpvww4twxir5piez@a3c2nbwitmab>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEZPR03MB6959:EE_
x-ms-office365-filtering-correlation-id: 65198ea4-1916-4e53-b573-08dc932b3713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|376011|7416011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?+P9aQxqiB8YckZNSbz7yk9eq6BZVbzGA/9m16anB9DH8nWWo5fj9zMWuGQ?=
 =?iso-8859-2?Q?Cnkz2/OkiGMXq2MKagNm7+F+Dwkq0uLKLnI/lTn2Sck+8MU8RZQTNN9EWn?=
 =?iso-8859-2?Q?4AeWh2LfnBbFJ6NEMn2HW5T17jsakpTtvYh6mDWnK+X8/NW15X2Et0Jcs7?=
 =?iso-8859-2?Q?FCHMDsSk4UynIUPzzjagQu60BmKdsr4uSJINuK9zHxr9SUQ+JQz7BxfXDp?=
 =?iso-8859-2?Q?/WGY4kIPsYrZNKK0Xa3/WzQq9Lb1Or5C0GjIHONP29RsmBWL/QlDuiWhom?=
 =?iso-8859-2?Q?2RBlhfVU0Hvw/6VeARQZ8XPqjaS93HU0A1FL+bxJukE0tDsuhEno6u6Sw9?=
 =?iso-8859-2?Q?GXe06iSBIKlnTFFjos6+bZyVR96BJqFoxAD4qrd+EPoL6PmJmhYXHE/pQ+?=
 =?iso-8859-2?Q?ZMVY+9bQnImBuFtQpb+CQ+R3hoPs6GR238V7xZhnpm35ZvHSFhmC/E8IZd?=
 =?iso-8859-2?Q?Q4NJwvlmfTXcFpGgZV/mRbcvSZcD9oPhcfyx210DI4rFjWy/Yudr/b3aIN?=
 =?iso-8859-2?Q?rD2PNdodMM7A3gv0IEjFKW7nLHYPROXkXY/SROEg2XDgOT7Lu5WP8Iv2lv?=
 =?iso-8859-2?Q?ZF00Eqnf6H9kJle6fknICv7Z3oVkHFHcFBAgg4blrjlPXMXtW1zoX5s/IY?=
 =?iso-8859-2?Q?ReGVM84VDM7FlXZzgocjtycQTdlxNYyuzSIyINcV2OCaodW76SlkPMXVky?=
 =?iso-8859-2?Q?tcIVmUo3RS5bi7nMDHpZ4l7Dhy4+B31h55JpKJJvMjCYgGQCix/HPgxAsy?=
 =?iso-8859-2?Q?E6Ul7iAjzrjxBNwp7gMqVYGMirwOB5m5FRpPs/upK2PSCqndgLM5zgkFAy?=
 =?iso-8859-2?Q?YEpms98nPQP3ZNRW7GYw/N8W3/e7oKXmKY0IUugk4wTl52t2WXL832f6G1?=
 =?iso-8859-2?Q?1iEqyhpjIaby0CLx729ZhS9AcCxf0rEeQxnO4zcmHejoVVKP9xxsMR4XbW?=
 =?iso-8859-2?Q?foUw9iPrwO9BFJsKdMRAMwkkzY/kLEuyfFkZVTUVsiSq3yCmYcga08kRI8?=
 =?iso-8859-2?Q?rwe9ip7FxFOOrLoBqQZbryVl9vpOA+/ChNKiya1u9mRXcA0u6FZQ2+prDk?=
 =?iso-8859-2?Q?gq+jG6Xfm2zCWv1lVD5dh5uQeZ7YbxPRK8GxHKjfZd25R7mnzsUZLLXMbt?=
 =?iso-8859-2?Q?Dpr76QQvDT14u9ICC5K8O22N6CEzrm/Nhyt40bIIf2GIJCzv8Z19jo+qMq?=
 =?iso-8859-2?Q?oQxRX+JRKUv4ItDteMnspVgDApc4dwnnmSlzoA1girtwz5PlgpwZnD64ob?=
 =?iso-8859-2?Q?yIUTKiKwWSWOb+vGM+RzPu/buO4pklZgO2gIi+89VammtYlWSgqpkUtyU4?=
 =?iso-8859-2?Q?NcGCGiPIhSRBUlLpVxm9uLJJ/m8i2OqDGrul18+83g7mE36SGS99fcZ3W1?=
 =?iso-8859-2?Q?XIGwdDdl4t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?2T0GhOv8LpeAV1n0UJzP71hgaIM0WGN7qnP0MJcaqKPcbAP44FOarCGgyi?=
 =?iso-8859-2?Q?clHK1OHmNfQMFbs4UVv/+k05/1qcghDpOl6qNTgYdlxAkPGD4zQfuyeiTr?=
 =?iso-8859-2?Q?GnrUq4lyAjwngC8IJAmcYcRKN3Dto/zT2eCX1kMBTtJH6kf5SIXDEZQ/kC?=
 =?iso-8859-2?Q?wQdSL+j8a5MLvd+QvYPu/O1NRkdF2sZTHjuXtSc2lpxDLsHM1pWO61/E4w?=
 =?iso-8859-2?Q?Gs/f0YsKmT0yfOc8RZkU5C+bs3Gm8u7k9pdGs5DUoXjzfsc8qqumTtKBlw?=
 =?iso-8859-2?Q?nJKuFA58qSTws/jWMo2gi1Eb+0OKXfx0YIOgS9LIGMoG5chzgCjZHBkgt0?=
 =?iso-8859-2?Q?kyrCNMtM5niTIQnQCdTqKRZ+1fSyFYt/trmbtsDXHQXQjN+BR61w/Ek2ep?=
 =?iso-8859-2?Q?SV1ECEu5v66dzeolb34yq2xaqb/rjiF24Ny3INSH9UiAUlv4X2REHOeTEO?=
 =?iso-8859-2?Q?wbWjH4qvJfAEtbX+cGBdOAoQoCdqRs6qA03xv5XdWpzW4sSUoFBOMTGlJw?=
 =?iso-8859-2?Q?7MX40n7bD/1m6PabVmO50DkDHfkG+95/WQvdzp0lPg0Kk8DmIhQ9EcWNL/?=
 =?iso-8859-2?Q?KF7/74rsdrHIJLoq1Z3CO3pkxWiLvSHbj6KYrZSshJkCBOXtk28qcB9R5t?=
 =?iso-8859-2?Q?/p46BesAHUIPmecKXmREMKA+MhhPuqKpurKwH0Lr6KgLPhaB0ad0FuV0UE?=
 =?iso-8859-2?Q?5XONoBqIthyckTPLCJToocvg3WbrSbsoUzRebne/WmsQA30h/sJQF4V0Xe?=
 =?iso-8859-2?Q?Ig/ceIMCusq2fJueqXjLou0VDYqUAPO6qFyin8sACPdFZWnPi0kvR0fgZA?=
 =?iso-8859-2?Q?+ORkIfCCQIbpx8m33o+3KZQ0cuQ4+if4M8ienuSWpPF39rPKkXqx1Ol2HA?=
 =?iso-8859-2?Q?/LtN7OSNjds1fWFYUDvT8xYQUge+cSRU+7juxkuGj0tJmj6NIpurl29wkA?=
 =?iso-8859-2?Q?PQsl6lajuadQyJE0fhmC0onLtCx+8Utb/pUvXfhEnhcGgN8vMTPec3otCc?=
 =?iso-8859-2?Q?/ZIFY22EgPa07SP80EdBDWf0apbcE6ZElZ4pyZxtZ7uXB//YVDjmSIo32D?=
 =?iso-8859-2?Q?59fiTNR3xB8Ay0jmkR8iZquv5lC1tikeQKpiqKZ8mfV7lp8u1GTEcrQfWY?=
 =?iso-8859-2?Q?qk32pAG3rYFwJig7C9ynfBLGxtubVk/TM8qYvsiAJQCTFSJ0ryzoWHDRct?=
 =?iso-8859-2?Q?fkFQZoKhWUsrlRD6XlNTiRBNE21RPPLNNUmiQIgoGXF8Yp1Y3vGNc01tPu?=
 =?iso-8859-2?Q?lruo0JjRsKq7T5h3zjLh71zxwFoXJEQCdcULCk9/d023B8GkwgLzhnX3Ef?=
 =?iso-8859-2?Q?vFcysyYm/m38ZTWjxsnT4N74EU5Th3AmiyqCBvNo9xDblZeDUmlmAuNu+a?=
 =?iso-8859-2?Q?OyQ1IUzUnz+t+75De/RsjHruvdAecJNZ3pT4yPBI0yRioXpx4vyLattl/0?=
 =?iso-8859-2?Q?lLE1VvHc1EPgzSo2D63SShct/acijgs+riVud6KRzPWbiiNkD8qjEwtGtL?=
 =?iso-8859-2?Q?4LVzaCOi8M0bjlEwAjcW7hhziUveiR0zZXQPdEh1VjTg6qmoTM9gBzl6rV?=
 =?iso-8859-2?Q?Z0CE47gzT3c5lAomEsIywPGy8S6kt4/ifLlKYibdml8Q+7JwLg7zjntVyl?=
 =?iso-8859-2?Q?9GDcYjBsVFmHiK5gAVVDNUhWbQsZgFmH85?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65198ea4-1916-4e53-b573-08dc932b3713
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2024 02:21:39.6253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dtdgPWT4WDK7WKKX/zEaRa+tAtZflqoHSM2RqoTxbjwXs7pVfVctWmtOkxXM88zaPxFMI23oJS1yMbZzAzBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6959

> Any reason to strip info about origin of the patch, my SoB and=0A=
> present this work as your own?=0A=
=0A=
Sincerely express my apology to Ondrej. It's really my mistake. After getti=
ng your permission if I could submit the patches. I jsut think if the autho=
r and submitter is not the same person is strange so I changed it. Next tie=
m I will avoid this mistake. Apologize again.=0A=
=0A=
=0A=
> I sincerely hope this is just a rookie mistake so please carefully read=
=0A=
the URL below:=0A=
=0A=
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html=0A=
=0A=
Thanks for the guidance Arend. After reading the document I realized what a=
 stupid mistake I made.=0A=
=0A=
BTW I have another question, except the SoB of the real author, should I al=
so post the original link in commit message?=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

