Return-Path: <linux-wireless+bounces-30026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA0CD3180
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578E5300FE27
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CC61A3179;
	Sat, 20 Dec 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leoniogrp.onmicrosoft.com header.i=@leoniogrp.onmicrosoft.com header.b="X2WR7kMv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023083.outbound.protection.outlook.com [40.107.44.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EC3A1E60
	for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766243841; cv=fail; b=ZAXgOCFigweNP60Yk8wissa6sSINZhFoMNHbFf/0MTyWF/feexvTX/usInzHVZDnTDZOB1OO/0yuMPshcfuvkK6jmcWgv6eQ0It6ekpXTRTt0CVvH9NjOoafsaxUBpFTp+WdfZUHgMFxmitpoJ/EEKjQag2+zpKPmPJxhJB2NpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766243841; c=relaxed/simple;
	bh=k445qmdCarRYY2A1micM1ybQEfwz99HEPlEP4docMRc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OvQAl9aSo/Wl9mxTEmyKFnW2PR3JSyRQg+qanDBqfoncxMWRdsnY6gDkkG1OO+WK7/9lVY2mlJM2AoarAUF7lLcEVK3BOCNXSGyQD79d24aMKLJ0LN1ofhiQXRsvkYWb6WXuWq9F6HlBuY9ods64GCKk69RRdPBcSiSRo4xuOr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leoniogroup.com; spf=pass smtp.mailfrom=leoniogroup.com; dkim=pass (1024-bit key) header.d=leoniogrp.onmicrosoft.com header.i=@leoniogrp.onmicrosoft.com header.b=X2WR7kMv; arc=fail smtp.client-ip=40.107.44.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leoniogroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leoniogroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0LUdZEBAkT2tudDtRhmed54lfaYm3o6Xctrkdr4gjUZRDgPxyxDU13OB3KFxfiYLjy+EEwNapPG6DVXs0d62bKfx0nadVTu+ygeBLkR5ZhKcD9BznxirCwJSex/wk2lZDlu5gJ3LSR0IyJBvHQf11fTdE45fCRYMYQWxO9Q2ytZh+6PqgbQLTa2KFg21Xk+CL6xgMsvv9E8oQ3jUZycCWIdLv2io8VsI3G8IPUO+NwXxovl6pMOUJQUROOmQm03fr+K7VoXT/0cL3eLFSriPczrUrODmn0Hn1VAaqvZdBFkWHhBpc/eljT+rGDYT8NlxgS3eRL6GHx+2HjMiyDbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5deXUVpp519fuV8iWO0EGcKUvuYK5v1Jf82ynfl8AWQ=;
 b=jbPSj65/R/wGbZxfnGTXY4tLwO6OnQE2BcbGeWh/zfjAAktwsK8jMDHhtxFG4cG6ZxCbCF0v6zFNNBAPPaGP3ITbMZ9VdMYVVkp/4R0kqPdLC1CIbzgogDQf//mqWwMigFCjVU3O1+Pe24yk0e1Qre5/leFiv605K6dwKIXtk+nrTMrdtdYdSlrfVONb0OqCmOflXDuy/ZHxuZUZ5Zscth0AbiBzWIJJrB863VELt8VncUQT5CUImsmTxLpzy1D3L/tymoAmckl0hy3BTfuPvRIA2+kLoAFvs6Cr6Gs0BPlH32aEOLpXowuffDB2wB0RYwqjRvdbFe9RLpZ7mbZKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leoniogroup.com; dmarc=pass action=none
 header.from=leoniogroup.com; dkim=pass header.d=leoniogroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leoniogrp.onmicrosoft.com; s=selector2-leoniogrp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5deXUVpp519fuV8iWO0EGcKUvuYK5v1Jf82ynfl8AWQ=;
 b=X2WR7kMve0ksz9pX1eJxAuyeuTJNYPOacLraqbG1nZkhAtViAy3Kb/rQsSANeylTXenFckBy5WfRF+iDN4zhpl0paf7JAN3VutmW1q2H3isj6sQO1+l/54Yw725psR8iARyB9w90DB7S4AuPYpMAzm0r50DIQoglSVXyhbPPRe0=
Received: from KL1PR0401MB6441.apcprd04.prod.outlook.com (2603:1096:820:bd::9)
 by KU2PPFD5EC1216D.apcprd04.prod.outlook.com (2603:1096:d18::56b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 20 Dec
 2025 15:17:08 +0000
Received: from KL1PR0401MB6441.apcprd04.prod.outlook.com
 ([fe80::43ed:f1aa:2704:6c8b]) by KL1PR0401MB6441.apcprd04.prod.outlook.com
 ([fe80::43ed:f1aa:2704:6c8b%4]) with mapi id 15.20.9412.011; Sat, 20 Dec 2025
 15:17:08 +0000
From: Noe Cagomoc <npcagomoc@leoniogroup.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kernel@lists.fedoraproject.org" <kernel@lists.fedoraproject.org>,
	"devel@lists.fedoraproject.org" <devel@lists.fedoraproject.org>
Subject: [iwlwifi] Meteor Lake PCH CNVi WiFi probe failure -110 on Dell
 Latitude 5450
Thread-Topic: [iwlwifi] Meteor Lake PCH CNVi WiFi probe failure -110 on Dell
 Latitude 5450
Thread-Index: AQHcccLv43kGbcZVlU25x31aZYFRvg==
Date: Sat, 20 Dec 2025 15:17:08 +0000
Message-ID:
 <KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6A@KL1PR0401MB6441.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leoniogroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6441:EE_|KU2PPFD5EC1216D:EE_
x-ms-office365-filtering-correlation-id: e4cd6eca-728e-471d-af8e-08de3fdad798
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|4053099003|8096899003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8cEO9vyBSfDQkh0tVTiiwMmjWrQJ234n9QFXY1yney+/g/ADzWypm6Rj5P?=
 =?iso-8859-1?Q?vuQXX7Wgwov0TolfWfuWQaR38m6sCkZiTGIr3r0PU6siZ0uicwV/slHgWm?=
 =?iso-8859-1?Q?ZiiQLSz4wkeJgsAPh/7p0SVFNuN8CvveTDfw1f8dLwjm+bZgnyP1GW0WXU?=
 =?iso-8859-1?Q?jy0hwPZSqSLfzKDFDf+ohr3rUETZQLP5SgFCZQqHFHOjRyyZjePE6prcsP?=
 =?iso-8859-1?Q?so4qtLkYZ0iLkzTqlXN0FuEC0Ox4ChJ1N3jxSFA+lQYgviyOyPdsKb78FL?=
 =?iso-8859-1?Q?qIPTjKlzB9pi6vwWrxQo7lmnxcG5ts+O8g+3X141VaYYk7FHS/umxVRcTY?=
 =?iso-8859-1?Q?vLDiUIu9t6aJoCokOnYZFQQM3f8wiW13Nb6l8CM0Wdw5Wj9qfdOpkmd6Jv?=
 =?iso-8859-1?Q?Zo1KcFS4538EfnBinvEdVnXjOxBNCGrdglPByxpD6nRyyWBF5CTOw6+uEi?=
 =?iso-8859-1?Q?ezIMSsi4CYPv4Q4tTfgQrqj6XcvAOlUbY2AD2nc3Dna8aLrc0IulXDOP1S?=
 =?iso-8859-1?Q?BSTNavUOQMrRFhHGqmlfY6TZ1tqVLYI0//kBnuq58uqb4yD7qFfXkIy5rD?=
 =?iso-8859-1?Q?QlRzzwSxjwKn9UgFbfL0jsJvHSP65HD5dCkMDY3/yT+ZxPfpGYxkiCWWp5?=
 =?iso-8859-1?Q?gQscCZRBY+jWjIowmMVbKSuO2s6vLq/CgrLZFb26JnPXyQWJYOSJl+WIKp?=
 =?iso-8859-1?Q?gJ6ZorMOC9zIolUwLmkkxaqRmyIoPbQ0J+xCiCnJFV8bHFvaGAul6A4bs+?=
 =?iso-8859-1?Q?U9eFM81he6cRPA9XextBIRXeUNf02wvgV9/CEz/9YMDI3qzMOpOEfFMly1?=
 =?iso-8859-1?Q?jwT5wYDDIjGk5dxqq6qigDWGrf7eARcBx9AcssETQE7hhTh0CkwZnncy1p?=
 =?iso-8859-1?Q?ujROKsVTrCH2mPGzI4O0C2y/02+qD5C8fsItXqRKIqriGzy3H94WuQgoUA?=
 =?iso-8859-1?Q?4wuvWKpKVU/Eqplo3Nw2ZN7hWlaXmUOHTajDZ09ZoyMjHRIhoCGTJCjEha?=
 =?iso-8859-1?Q?1JP1QBwZKfTXx53xRmmXxUaKMxskVoI5C1DEd7RivalmkqGoKFrp/oXN2I?=
 =?iso-8859-1?Q?dzhUkWdZdHm91gHAlp74XiFflJKqtWeTyT7O9oXb5eatyngs8MbvQmSTF8?=
 =?iso-8859-1?Q?jEnSPte9Hvc7cpQkEhp9Lm46EWzsDF6cS1DQRXaZIO5e6CnDIGJrQf2ZRk?=
 =?iso-8859-1?Q?t0xwORtTKusUsItbUd+Q8NTbku53MQglyKeaOygVeM93NoE7mmfCqgPEb1?=
 =?iso-8859-1?Q?646mz+X2Y7xEQip87033YAQvQCx7JxRUUCAiYwWHZ/flg1pzNZNZIn0AWi?=
 =?iso-8859-1?Q?Xj9D0rbZcvV5OomHXMAl0l4OqQHLPBFp8BZih5YoYT/e9dAW/1MP/p2Pvc?=
 =?iso-8859-1?Q?UyRt8oFQBmLrC3jIa6XZ47UcPvSa2OWfDVEDap2aaTcvnJ9EsCBD+glBtD?=
 =?iso-8859-1?Q?B7+404uMVAsemUcqjX3CnYg7LSkhQuYCn9yyisjqdjeVU0oVyscwz9NUm0?=
 =?iso-8859-1?Q?8Qp07GNCbYOHtRwoM/P4hRy8IrGa864BAWV+LvG0R42Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6441.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(4053099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZuiY/a6BkIrVlQD7lzcolgQTUoQO9LnE2VBnQinwWmCrZGTevlAXODrSUg?=
 =?iso-8859-1?Q?Y8jRnYweecQcaU6/4YsdGfm7VsPdNNO33GU/6NaCsKArxLSulTTZzgq6Zc?=
 =?iso-8859-1?Q?b/OqdxeJ/g+hcgwAX36WH2gS2PPZUtLpIisSuOI9sS4anRe+LkT1D0vCB/?=
 =?iso-8859-1?Q?1H3I14jYQRd4v0bIBYqODzFW/2j3aDgxFJJoogj/Jx0XPIB30PVH+uTGep?=
 =?iso-8859-1?Q?6oeCM9hFaq+ejdEe4ihlNYiFiVMdkxuQzxAJaHkOpEh+1OEzGv/zFVdx1e?=
 =?iso-8859-1?Q?kmbgKpq0Ew6QeZJTn/ZGH4sHEyYWjQT31qbFUTYBZLC/2EQDd3HhdlDd9q?=
 =?iso-8859-1?Q?cFAcu/mJ1BBFry8auUqbrqdfbHIcNl6EVT9sOFnBxqppFHfXknQrdWyXo9?=
 =?iso-8859-1?Q?DX7XAVcPRY2u/S0DSKnP2KcoYF8uYY6u0YIyBeqqxGoX9p8TkHWUgBvD8+?=
 =?iso-8859-1?Q?lPTxpbJHFfq7Z+LnJ2FnkHTb33mHy0+dSOuHQoqjFnejRyuLrf60p7mMa6?=
 =?iso-8859-1?Q?OdTlPlNvsvgOx3ESSM1BKjXD3o0eX+/VkNbLi3tS3a8gSgOC6+5mE8YPnG?=
 =?iso-8859-1?Q?rCeaPtSiqHMMLAhuByi/aLUerWkKq99l5wmzUq+AH4Kvb6eaSTROP5l8Gn?=
 =?iso-8859-1?Q?54wGF0r9sZXZDS+gMa+1Y9CbcFapXMogz3iWnpb1eRQhQBU6YB6g1RjIxk?=
 =?iso-8859-1?Q?/0i5du01FTpsa7GgU323lzN81MS269qrhZTTnE1Yyrd3/voDQfp51JAOYC?=
 =?iso-8859-1?Q?b7DnQfwTp8ooE6MhZgBVjptCtUoqaAjZU7ZtQmv1MyT9fS5KW+LjRa6owQ?=
 =?iso-8859-1?Q?b7N+/ML5wiuNr1iMUzU2mE6agJ4Z7rgKdRL7qG8KQk6XYTuPySiuOr3y/v?=
 =?iso-8859-1?Q?ovCcarvwbmYAus3dyMWPARXsbxxg2pweXMys7meb7lPQW7tW9ihRNXyJQK?=
 =?iso-8859-1?Q?yh9GFbOgfnreAfBbqjPyRjS5k2E5oAFoqka91pXC0ereunLn4zlOpCPE6w?=
 =?iso-8859-1?Q?ddDUDqMFY8L3Z2SZjr4KOlWRJRhGEudhRKYTlLuaHub099B3l1DQj6XLgM?=
 =?iso-8859-1?Q?7ybm/JzxQpPrxN+87wAJvTP3vmoyhnPaX4Dhl/g9b4k43OoCEay6Z1SbAR?=
 =?iso-8859-1?Q?mC62ZGluCNGc7m9mH1TdsFt7VpjoxgaZFBMJ1ti6qOZ8wH5S62xr3FBcd1?=
 =?iso-8859-1?Q?gqLqsPcqDvpPigGV2OZMMbhY2GELHujOFEuldeS4b7736lRQYgGwfJneAs?=
 =?iso-8859-1?Q?eCnufPHM5w//cmNakhGsH0o7wRwxeo5di9nw3pMzfaMG5G0dJimlOMXm6b?=
 =?iso-8859-1?Q?teZKxZGAyS7Sck3+dWfVP6gJpCYa3vYZlu+upiMEESS7QrCAbsu0NtqXmY?=
 =?iso-8859-1?Q?z+8f77xrX6KZ9DK+KMkajU//iGZ3flgFdJVKtZjTy1iQ8Ut8YwThKxOwmo?=
 =?iso-8859-1?Q?neRr81TlitMnl+nkZNeUq1fskCmUyE3fvhkn5wgB8cUggnEb0CWC75tZ+n?=
 =?iso-8859-1?Q?631DxJdqTEU68ha4gOeTYZZ1UOy7uffwdzCvpkgKvnjk7gVSw9ehfkG4Wt?=
 =?iso-8859-1?Q?TxGqHGbmnDrSltU0I0+DwSZUZ9ARekccPnQU9I9fKNvTdgwEUmT9slq76l?=
 =?iso-8859-1?Q?5dI3ArE7yvqLtVzg7G0JePK2cdMYwy1O7wgp7yZgw4XG9NsB04l+vtxXMV?=
 =?iso-8859-1?Q?3wm16U9K0LDm3+r+UCYfLzQDekegy8mlwcCcrwxbtj/oNud1aM0odobSQG?=
 =?iso-8859-1?Q?Rx3P7IgUiYXGdfImuIi1Xzz5OuKH8AtmAX4IXi9JccpxFbOsC6W1Lr5opo?=
 =?iso-8859-1?Q?Tokpkhtgww=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_006_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leoniogroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6441.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cd6eca-728e-471d-af8e-08de3fdad798
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2025 15:17:08.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 30b4fb15-b829-4b02-b74d-7558a46bf22b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Mb5QqtzfUWs2D/XMzVW3oHewl7sanpZespB8q+3pPVFf/XRRjjg3tj2GPuufWdAmNv7uF2hZYK3aVy8/f/XSG/YxsCaTJPCQhLRK/ludIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFD5EC1216D

--_006_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_
Content-Type: multipart/related;
	boundary="_005_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_";
	type="multipart/alternative"

--_005_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_
Content-Type: multipart/alternative;
	boundary="_000_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_"

--_000_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

 I'm experiencing a WiFi initialization failure with Intel Meteor Lake PCH =
CNVi WiFi on Linux.

 Hardware:
- Device: Dell Latitude 5450
- WiFi Card: Intel Meteor Lake PCH CNVi WiFi (8086:7e40)
 - BIOS: 1.19.2 (latest from Dell, dated 11/04/2025)

 Issue: The iwlwifi driver fails to initialize the WiFi chip with error -11=
0 (timeout). All "Host monitor block" values read as 0x00000000, indicating=
 the chip is not responding to initialization commands.

 Tested Configurations:
- Fedora 43 with kernel 6.17.12
- Fedora Rawhide with kernel 6.18.0
- Intel backport-iwlwifi drivers (release/core101 branch)
 - Latest iwlwifi-mld-firmware (20251125-1.fc43)
- Secure Boot disabled
 - Various kernel parameters tested

 Key Observation: WiFi works perfectly on Windows 11, confirming the hardwa=
re is functional.

This appears to be a Linux-specific initialization issue.

 Error from dmesg:

 iwlwifi 0000:00:14.3: probe with driver iwlwifi failed with error -110

 Attached files contain:
 - Full dmesg output - lspci detailed output
- BIOS information
 - Firmware versions
- Module information

 Please let me know if you need any additional information or logs. Thank y=
ou,

[cid:9618ec79-63f3-4cd1-890a-72ca6b85ff7d]

--_000_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hello,&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;I'm experiencing a WiFi initialization failure with&nbsp;Intel Meteor=
 Lake PCH CNVi WiFi on Linux.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;Hardware:&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- Device: Dell Latitude 5450&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- WiFi Card: Intel Meteor Lake PCH CNVi WiFi (8086:7e40)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;- BIOS: 1.19.2 (latest from Dell, dated 11/04/2025)&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;Issue: The iwlwifi driver fails to initialize the WiFi chip with erro=
r -110 (timeout). All &quot;Host monitor block&quot;&nbsp;values read&nbsp;=
as 0x00000000, indicating the chip is not responding to initialization comm=
ands.&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;Tested Configurations:&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- Fedora 43&nbsp;with kernel 6.17.12</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- Fedora Rawhide with kernel 6.18.0&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- Intel backport-iwlwifi drivers (release/core101 branch)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;- Latest iwlwifi-mld-firmware (20251125-1.fc43)&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- Secure Boot disabled</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;- Various kernel parameters tested</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;Key Observation: WiFi works perfectly on Windows 11, confirming the h=
ardware is functional.&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This appears to be a Linux-specific initialization issue.&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<b><br>
</b></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<b>&nbsp;Error from dmesg:&nbsp;</b></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<b><br>
</b></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<b>&nbsp;iwlwifi 0000:00:14.3: probe with driver iwlwifi failed with error =
-110&nbsp;</b></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;Attached files contain:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;- Full dmesg&nbsp;output - lspci detailed output&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- BIOS information</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;- Firmware versions&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- Module information&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;Please let&nbsp;me know if&nbsp;you need any additional information o=
r logs. Thank you,<br>
</div>
<div class=3D"elementToProof" id=3D"Signature">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"direction: ltr;" class=3D"elementToProof"><img style=3D"width=
: 395px; height: 144px;" height=3D"144" width=3D"395" data-outlook-trace=3D=
"F:1|T:1" src=3D"cid:9618ec79-63f3-4cd1-890a-72ca6b85ff7d"></div>
</div>
</body>
</html>

--_000_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_--

--_005_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_
Content-Type: image/png; name="Outlook-zm24pqst.png"
Content-Description: Outlook-zm24pqst.png
Content-Disposition: inline; filename="Outlook-zm24pqst.png"; size=47060;
	creation-date="Sat, 20 Dec 2025 15:17:08 GMT";
	modification-date="Sat, 20 Dec 2025 15:17:08 GMT"
Content-ID: <9618ec79-63f3-4cd1-890a-72ca6b85ff7d>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAxgAAAEgCAIAAAC4qULaAAAACXBIWXMAAAsTAAALEwEAmpwYAABH
P2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0w
TXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRh
LyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxMzggNzkuMTU5ODI0LCAyMDE2LzA5LzE0
LTAxOjA5OjAxICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMu
b3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJk
ZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFw
LzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9w
aG90b3Nob3AvMS4wLyIKICAgICAgICAgICAgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9l
bGVtZW50cy8xLjEvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNv
bS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5j
b20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6c3RSZWY9
Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiCiAgICAgICAg
ICAgIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIgogICAgICAgICAg
ICB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyI+CiAgICAgICAgIDx4
bXA6Q3JlYXRvclRvb2w+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTcgKFdpbmRvd3MpPC94bXA6Q3Jl
YXRvclRvb2w+CiAgICAgICAgIDx4bXA6Q3JlYXRlRGF0ZT4yMDIxLTA2LTA5VDA5OjE4OjExKzA4
OjAwPC94bXA6Q3JlYXRlRGF0ZT4KICAgICAgICAgPHhtcDpNZXRhZGF0YURhdGU+MjAyMS0wNi0w
OVQwOTo1ODo0NSswODowMDwveG1wOk1ldGFkYXRhRGF0ZT4KICAgICAgICAgPHhtcDpNb2RpZnlE
YXRlPjIwMjEtMDYtMDlUMDk6NTg6NDUrMDg6MDA8L3htcDpNb2RpZnlEYXRlPgogICAgICAgICA8
cGhvdG9zaG9wOlRleHRMYXllcnM+CiAgICAgICAgICAgIDxyZGY6QmFnPgogICAgICAgICAgICAg
ICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgPHBo
b3Rvc2hvcDpMYXllck5hbWU+S0FZRTwvcGhvdG9zaG9wOkxheWVyTmFtZT4KICAgICAgICAgICAg
ICAgICAgPHBob3Rvc2hvcDpMYXllclRleHQ+S0FZRSBDVUVOQ0EgU1lTVEVNUyBBTkQgQVBQTElD
QVRJT05TIEFETUlOSVNUUkFUT1IgIExlb25pbyBHcm91cCBvZiBDb21wYW5pZXMgKzYzIDk2NiAx
NjAgODgyOCBrY2N1ZW5jYUBsZW9uaW9ncm91cC5jb208L3Bob3Rvc2hvcDpMYXllclRleHQ+CiAg
ICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5
cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgPHBob3Rvc2hvcDpMYXllck5hbWU+Tk9F
PC9waG90b3Nob3A6TGF5ZXJOYW1lPgogICAgICAgICAgICAgICAgICA8cGhvdG9zaG9wOkxheWVy
VGV4dD5OT0UgQ0FHT01PQyBURUNITklDQUwgU1VQUE9SVCBTUEVDSUFMSVNUICBMZW9uaW8gR3Jv
dXAgb2YgQ29tcGFuaWVzICs2MyA5MTggOTM5IDI5MjEgbnBjYWdvbW9jQGxlb25pb2dyb3VwLmNv
bSA8L3Bob3Rvc2hvcDpMYXllclRleHQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAg
ICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAg
ICAgPHBob3Rvc2hvcDpMYXllck5hbWU+RVJJQzwvcGhvdG9zaG9wOkxheWVyTmFtZT4KICAgICAg
ICAgICAgICAgICAgPHBob3Rvc2hvcDpMYXllclRleHQ+Sk9ITiBTT0xJUyBEQVRBQkFTRSBBTkQg
U0VSVkVSUyBBRE1JTklTVFJBVE9SICBMZW9uaW8gR3JvdXAgb2YgQ29tcGFuaWVzICs2MyA5NDkg
ODg5IDEzNDUgam1zb2xpc0BsZW9uaW9ncm91cC5jb208L3Bob3Rvc2hvcDpMYXllclRleHQ+CiAg
ICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5
cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgPHBob3Rvc2hvcDpMYXllck5hbWU+SEFS
VkVZPC9waG90b3Nob3A6TGF5ZXJOYW1lPgogICAgICAgICAgICAgICAgICA8cGhvdG9zaG9wOkxh
eWVyVGV4dD5IQVJWRVkgUEFQQSBORVRXT1JLIEFORCBTRUNVUklUWSBBRE1JTklTVFJBVE9SICBM
ZW9uaW8gR3JvdXAgb2YgQ29tcGFuaWVzICs2MyA5MjggNTU5IDc3NDMgaHNwYXBhQGxlb25pb2dy
b3VwLmNvbTwvcGhvdG9zaG9wOkxheWVyVGV4dD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAg
ICAgICAgICAgIDwvcmRmOkJhZz4KICAgICAgICAgPC9waG90b3Nob3A6VGV4dExheWVycz4KICAg
ICAgICAgPHBob3Rvc2hvcDpEb2N1bWVudEFuY2VzdG9ycz4KICAgICAgICAgICAgPHJkZjpCYWc+
CiAgICAgICAgICAgICAgIDxyZGY6bGk+YWRvYmU6ZG9jaWQ6cGhvdG9zaG9wOjQzYTc3NWQxLTc0
OTUtMTFlYS05NjVhLThkZjM4YTU0ZWY2ODwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpCYWc+
CiAgICAgICAgIDwvcGhvdG9zaG9wOkRvY3VtZW50QW5jZXN0b3JzPgogICAgICAgICA8cGhvdG9z
aG9wOkNvbG9yTW9kZT4zPC9waG90b3Nob3A6Q29sb3JNb2RlPgogICAgICAgICA8ZGM6Zm9ybWF0
PmltYWdlL3BuZzwvZGM6Zm9ybWF0PgogICAgICAgICA8eG1wTU06SW5zdGFuY2VJRD54bXAuaWlk
OmU2MDMxNzk3LTU3ZmEtN2I0NC04ZjMzLTA0MWJhYWVmMjg1NTwveG1wTU06SW5zdGFuY2VJRD4K
ICAgICAgICAgPHhtcE1NOkRvY3VtZW50SUQ+YWRvYmU6ZG9jaWQ6cGhvdG9zaG9wOjM0ODlmM2E3
LWM4YzYtMTFlYi04NDI4LWViODZmODVkM2QxOTwveG1wTU06RG9jdW1lbnRJRD4KICAgICAgICAg
PHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD54bXAuZGlkOjAyMmE1MzlmLTA4MGUtMDg0OC04ZjNl
LWZlOTFmMWM5MTFjMjwveG1wTU06T3JpZ2luYWxEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06
SGlzdG9yeT4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRm
OnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNy
ZWF0ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+
eG1wLmlpZDowMjJhNTM5Zi0wODBlLTA4NDgtOGYzZS1mZTkxZjFjOTExYzI8L3N0RXZ0Omluc3Rh
bmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMjEtMDYtMDlUMDk6MTg6MTEr
MDg6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50
PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE3IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4K
ICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNl
VHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9z
dEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6
YjdjZjRjNjEtZjBlZS0wZTQ5LWE3ZmYtYjIyZTAzMDdiYjNjPC9zdEV2dDppbnN0YW5jZUlEPgog
ICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDIxLTA2LTA5VDA5OjIwOjEwKzA4OjAwPC9z
dEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQ
aG90b3Nob3AgQ0MgMjAxNyAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAg
ICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAg
IDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNl
Ij4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmFjdGlvbj5zYXZlZDwvc3RFdnQ6YWN0aW9uPgog
ICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOjM4Y2EwN2RmLWViMjYt
ODA0Yy1hYjEyLWU1MjZkMGNlMzc1NDwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAg
ICAgPHN0RXZ0OndoZW4+MjAyMS0wNi0wOVQwOTo1ODo0NSswODowMDwvc3RFdnQ6d2hlbj4KICAg
ICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIw
MTcgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICAgICA8c3RF
dnQ6Y2hhbmdlZD4vPC9zdEV2dDpjaGFuZ2VkPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAg
ICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAg
ICAgICAgIDxzdEV2dDphY3Rpb24+Y29udmVydGVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAg
ICAgICAgIDxzdEV2dDpwYXJhbWV0ZXJzPmZyb20gYXBwbGljYXRpb24vdm5kLmFkb2JlLnBob3Rv
c2hvcCB0byBpbWFnZS9wbmc8L3N0RXZ0OnBhcmFtZXRlcnM+CiAgICAgICAgICAgICAgIDwvcmRm
OmxpPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAg
ICAgICAgICAgICAgICAgPHN0RXZ0OmFjdGlvbj5kZXJpdmVkPC9zdEV2dDphY3Rpb24+CiAgICAg
ICAgICAgICAgICAgIDxzdEV2dDpwYXJhbWV0ZXJzPmNvbnZlcnRlZCBmcm9tIGFwcGxpY2F0aW9u
L3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nPC9zdEV2dDpwYXJhbWV0ZXJzPgogICAg
ICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBl
PSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0
OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDplNjAz
MTc5Ny01N2ZhLTdiNDQtOGYzMy0wNDFiYWFlZjI4NTU8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAg
ICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMjEtMDYtMDlUMDk6NTg6NDUrMDg6MDA8L3N0RXZ0
OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rv
c2hvcCBDQyAyMDE3IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAg
ICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9y
ZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5Pgog
ICAgICAgICA8eG1wTU06RGVyaXZlZEZyb20gcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAg
ICAgICAgICA8c3RSZWY6aW5zdGFuY2VJRD54bXAuaWlkOjM4Y2EwN2RmLWViMjYtODA0Yy1hYjEy
LWU1MjZkMGNlMzc1NDwvc3RSZWY6aW5zdGFuY2VJRD4KICAgICAgICAgICAgPHN0UmVmOmRvY3Vt
ZW50SUQ+eG1wLmRpZDowMjJhNTM5Zi0wODBlLTA4NDgtOGYzZS1mZTkxZjFjOTExYzI8L3N0UmVm
OmRvY3VtZW50SUQ+CiAgICAgICAgICAgIDxzdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ+eG1wLmRp
ZDowMjJhNTM5Zi0wODBlLTA4NDgtOGYzZS1mZTkxZjFjOTExYzI8L3N0UmVmOm9yaWdpbmFsRG9j
dW1lbnRJRD4KICAgICAgICAgPC94bXBNTTpEZXJpdmVkRnJvbT4KICAgICAgICAgPHRpZmY6T3Jp
ZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+
NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlv
bj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRp
b25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+
NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjc5
MjwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4y
ODg8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9y
ZGY6UkRGPgo8L3g6eG1wbWV0YT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0i
dyI/PgWpZgEAAAAgY0hSTQAAeiUAAICDAAD5/wAAgOkAAHUwAADqYAAAOpgAABdvkl/FRgAAcA9J
REFUeNrsnXlcU1fax8/NnoCAEFDUVEUMKgouIMoiLljca20pWq211da2dpnWrtPaTmv7dtqZ2mmt
7djWaceqgFj3LYIosiiLC6AoAUG9yA5ChCyQ3Pv+caZ3MkkIlxCW4PP9+Afc3Hvu2fD88jzPeQ5B
0zQCAAAAAAAAOg8HugAAAAAAAACEFAAAAAAAAAgpAAAAAAAAEFIAAAAAAAAgpAAAAAAAAAAQUgAA
AAAAACCkAAAAAAAAQEgBAAAAAACAkAIAAAAAAAAhBQAAAAAAAICQAgAAAAAAACEFAAAAAAAAQgoA
AAAAAACEFAAAAAAAAAgpAAAAAAAAoPPwoAuAB43QlRONf83cfQX6BAAAALANsEgBAAAAAACAkAIA
AAAAAAAhBQAAAAAAAEIKAAAAAAAAhBQAAAAAAAAAQgoAAAAAAACEFAAAAAAAAAgpAAAAAAAAEFIA
AAAAAAAgpAAAAAAAAAAQUgAAAAAAACCkAAAAAAAAQEgBAAAAAACAkAIAAAAAAAAhBQAAAAAAAICQ
Avo/Bkrf0FyTdDURugIAAADodXjQBYCjQNGUTq/Jv5N58krcfU393PEx0CcAAAAACCkA6ACapina
UFpTeDI//lZtIULIzckTugUAAAAAIQUAHaA3tNWo7qYrj2WVJCNEczk8mqa4HJi6AAAAAAgpAGgf
A2Vo0alySlNOX92radXweHwCEQghiqYEXAH0DwAAAABCCgAsQNFUm6G1sDz7WN6u+vuVPC6fz/uv
cqIRoggaegkAAAAAIQUA/wNN03qqlWy4eTJvT0l1AZfg8rlC01nL4RkMbdBXAAAAAAgpAPgveqqt
vrk6/cbRzBIFQjSPw7csthDNgRgpAAAAAIQUAGAo2qBt02TfPJ10NV6j0/C4VmcmTfEIPnQaAAAA
AEIKeNChaVpPtd2ouKTI31157w6Hw+tARSFkoCgBXwRdBwAAAICQAh5oEdVmaKu4dyv52t7Cu7kE
4nC5rOxMNE3xOWCRAgAAAEBIAQ8qBkrf0FydWaxILzpqoAw8bieEEY8r0LZpoA8BAAAAEFLAAwdF
G9S65oLyC8ev7G7WNvK4vE6pKIQQQSAaUdCTAAAAAAgp4AECh0MVVV45VRBP1pXwuDy+TXk1aZrm
cSAhJwAAAABCCnhgaDO01qrunr72++Xb6RwCGSfY7CwGyiASiKFLAQAAABBSQP/HQOnvaxsvlJxK
LkikaKqzjjwzCAOtF/FBSAEAAAAgpIB+DUUbWvW6q+VZRy//plLXc7k8HuJ2uVSaS/DbILM5AAAA
AEIK6K/gcKib1VdP5O26U3+Ty+F22RBlNGu5vDZDK3QyAAAAAEIK6Ie0GVqrm8rPFR2+VJaKEM3n
2jnnE00bzA/gAwAAAAAQUoBjY6AMzdrG7NLTZwr3a1s1PC6/e95CSQQS6G0AAAAAhBTQT6Boqk2v
u16ReyJvT43qLo/D7yYVhRAyUHpnkRv0OQAAAABCCnB4aES36Vvv1BefvrrvRuUlLodjW3Yo1hA0
jTgEF3oeAAAAACEFODZthtaG5upM5Yn04uOIQt0sof6j3EQCSUNLTZ/qh7qGutqG/6mSp7uX1F3a
4YN37t6+qszHP4+XBzw0dDj7l+Jni8puqJpVxtddnF38Ro7x8hgcFBDMvqgWTQv7VzuJnTpVVRsa
MsZn3GDPwcEBIRJxJ9y4ufk5NfVVxle8PAaPG+3fqULaq2FlTUV5dbnFrrb5FXYcRIvzkP1U7KbS
7NvAbp08AABCCuhRDJShRae6WHb2RP6etjYtnydAXKJnXk0jisvpQxap3PycV794zvz6ayveiV20
wvoasPztR4yv7Ph4z1jfcdZfp9aoz144naiILyKvWb/T03XQkshlj8x9zPrKd/zMkU9/3tTZVmfu
vtLFfrPeEEXWEfzD2iUvzg2fx0a3JRyN+ybuC/Pra5e8uDZ2vW1K4nRm0p7jv9Y2VXd4c8yclfNm
LOxw+LppEBFC10sK393yusWqRocsfuu59zqlKnYkbN9x+AeL9dn6/o8dDkd3NLBbJw8A2AxB0zT0
AtApKJrSG1qv3s1Oyt9b1XSHx+ERBKdnNZw+zG/hsqDnbHs8dOVE+wqCr//1t8TTuy1+9MG6zQtm
Lbay8q396MlOCanc/Jxte/7R4eLUqWp8/O0mZuFhT/yXh7qyPl0vKfzy58/YN+TzV7+ODJll/Z5H
XopuT/Ek/5zZWeOEbfqSjWTpjkG0In2Yin306maW70rNOvPet6+392mH3xC6qYHdOnkAwGY40AVA
p4xBrXodWV+8M/1vuzO+rr1fzucKelhFIYTaqFYn4YC+0ykmPgtjtid+p9ao7fWi42eOvPrFc51d
nxBCn/68aUfCdvu2ulOuQPN1eu1HT3aqIVbWdWbxtmI3ysnPYv+uuoa6N/7vFRtUFLaFnL1wulcG
0cTtaF6xO3dvs3zXrwd+tvLpjdLCXpyl3TF5AACEFNAT6A1tdferTuTt/k7xbmH5RS7B5RC94Bom
EGEwGCQCJ4fotNqmauvLancbSP5rrjj8Q8LRODs2jaUPq7PWDut2CCuf5l2/ZOXTS9dyWb7lzt3b
az9YeeFams09c7+luW8O4vnLmSx7wAYZ1DMN7KbJAwBdAWKkgI4xUAadXnOpLDXp6l6V5h7PPie9
2AiNaCFfpFLfc5Te+/TnTVMDp9sW7Wu8DFhcn3B8ie8IuZfHIHyljLxZVHbDoqvxm7gvAsYEshFA
0SGLgydMtXKDk8TZtobcuXu7vYXQT+Y/L3zRACdnL4/BNfVVlTUVh1P3swlOwhxO3W/l08TTu9ev
2NChd0+tUf/j339v76Vrl7zo7TVkpGwUcwX39tncZONHKmrK+8IgmrPn+K/WXXKYpPSTJtVjOQrd
3cDumzwAAEIK6DbVQtN6qrWo8srJ/Li7DaU8Dq9H9uV1NGs5fE1biwN146Gk320LdmZW9y9//syi
3Nmw6jUTiTbWd9yCWYvnzVhoMYjky58/++Wvuzt8Y/CEqSyjVTrLP/79d4sL7RtPv2sexbI2dn1q
1pkt//4rXhGdxE5WDBUmq6b58p+Tn9VhoMz2uG0WbVGvrXhn8ZxHzHUY7u3Xn30rNz/n2NnDONTM
b+SYvjCICKGYOSuNxUptU3Vufk6Hu+RMJOmSyGVWQq96soHdNHkAoIuAaw9olzaDrrzhZtz5b/6V
+nnlvVu9Eg5lEYo2iPh9d1ezp+sgkys7Dv9Q11Bnc4FnL5w2X2xi5qz86NXN7Rm6xvqO2/bRT+Y1
KSKv9aKPIzXrjLlMwbvA2pM4kSGz4r46EDNnpafrICux7SaeOz+Z//qYl027MSulQ4OKRRvJ569+
HbtohXVrVlBA8Eevbt7x8Z7okMVeHoP7yCBO9g8yuWLdAWpRkgaOndwXZmn3TR4AACEF2B8Dpa9v
rjqZt+cbxTtXbmXwODwupw8ZL9sovaQvBZubrl5jpvrJ/E0u/nbwF5sLTFTEm1zxk/mvX7HB+lMS
seSvb3xtfj3zYlpv9cyh0xa8b5te+NT6IicRS15/9q1D3yus2EJMBNC88EVTA6eb3KbIOmJdzu49
HmdRRbHf8DXWd9xHr262aPLplUH08hg0zT/CRNNb3/1gIklj5qx0kjj1hVnaTZMHAEBIAfY39qhb
m3NKz3yX9P7ZwkMEgbrvpBdbIQyGVmeRa1/uxjWPrjNdZk7vts0UZDHyd82j69hs5h/rO85kHUUd
xRJ1H3UNdeYWheiQxV3Mx4gs7cibPilU6i41b3t23nkr/WyeA2Ltkhftsm2+FwcxavrDHXaX8RiZ
SFJzm1avNLD7Jg8AgJAC7AaNaF2bpqjyyo8pHydc+K5Zc4/L5RGI6INV5RLcNn1bX+7M4IAQc4eF
RYNHhzB5z03Kt3kdrW2q7oqf0WYsipiZIbO7XrK5Xw9bKczbnnz+VKf6+ZG5j9ml7b04iOaWOSsb
GE3GyNN1EEsd2d0N7L7JAwAgpAD70KrXVTXe+T1n+47UT8mGYj6X30fCoSxKPiHfqbGPHRFjgkQs
MY/RUWQdscEolVOQbf5FnH1uSeMtZv9dpRp6ofeKym50Za1tD4t+vfY0xIVrae3pD/N+jpmzsot7
LfvCIErdpTFzVhpfSTy9u71OMHHPLYlc1kca2E2TBwBASAF2wEDpG9V1KYX7vj7+Rm7pGQ7icom+
vpeTQgY+T9jHKzlz2hxzo9RPe3/obDm3KkpNrozx6cTW9+FDR5hfLCNv9nyH5CuvmFyZ5h/R9aPQ
zNN0TZ8UymgI9t49c7+exc13ttG7g2junrPYCddLCk3ccyzDzHuggd00eQDALkD6gwcXijZo2zTX
y3MVBXvq7ldxOby+Fw7VTs0NerGgr/8fio1SJml1LlxLS80606mwG/PQkwFOzp2qhg2V//TnTVbS
KrI5EJBNQ2SDH+p6P5t46xi/HiZq+sMmsTWJinjzzA4WLTQWzSQdnu5s8UzfXhlEBnPLTfL5U+ad
YBLf7SfzZx+B1N0N7KbJAwAgpAAboRHdqtfdrr2RdC3xZvVVguDw+kB2KPa0UW3OooF9v54zp80x
P1T11wM/dzF+2eZkmPaijLxpc1rz/1mqu2zyMY9BZvx6GHPvXhF57c7d2yZbvSy6yczNJGqN2uSQ
aZuFZk8OokQsMUkodeFamkknqDVqk/huk57sa7PUjvZCAOgi4Np74GgztFY3lR++9K+fzn5SWnON
x+FzCa4D1Z9ABEUZBFxh36+qRCwx375XRF5LzTrTlWKZ9NAORDclrzJ3UTF+PYxF7x7Lk1LMzSS3
795iKTT72iCae/dMOiEnP8skfZRJT/biLIXTXQAQUkBfwUAZ7msb024c3XL8jUzlSYSIvh8OZQ6N
aInAufZ+pUPUNjJklnlOKesnwgLsse7Xw5jvCDuZfvRB6yhz755JJ5hkK7XYkwAAWARcew8EFE21
GXTKyrxjl3fWNJVzuXy+Q/nyTCAIjoFqc5Tarnl0nckBYdgoZbODz16eNStYP2vP3F/WIZ7uXnav
ZId+vfZqa9G7Z7F8k2gnizHRfXYQjTH37hWR15jjYuoa6kxi7WOil/edBnbH5AEAEFIAW2iabjO0
kg0livy44so8LpfH4wkcvlGIdpS4eIRQZMisaf4RJkt+1yOluteAYe+z9izmESgqu9GVt5zOTDK5
YtEbhb17Jv2flH6yw9MPaxtqTKotEUu+feenmvoq44s5BdnmO/76IBFBM03yRORdv4SFlLmH1Aat
3H10x+QBABBSACvaDK3196vOl5zKVB6nENX3UwawV1J8jiPJweeeePHCR2kmRpHUrDO2xZHcb2lm
f7PF+BKL+9F6HrLqTlceN/fQ/fK7ZZ/pPVWDyZXDqfuNhZRF24lFm4rFjWw2CKmeH8SggGCTg5wP
p+5fseQpiVhikj5qmn9E1xNodXcDuzh5AMCOQIxU/4SiDC06Vaby5PfJH5y7cYggOI4YDtWejKIR
xXccixRep6NDTL89s4yUMn/wRmknYm9r6qvNL/aKr8S8IReupVk/980KFs8kUWQdsfjP/M7apurc
/BzjK+ahbFbSoHe97b0yiCYJNmubqnPys8zTRz0yZ1lfa6B9Jw8AgJACrKsMqlWvvV5x8Z+nPzx0
cYemtYXPFfazNhKI0NMGx6rzEwtWmFwpIq+xOXp22KBh5nKB/RJifh6In8zfXgm7O4V5Q5DVc9+s
w3LnnRXyrl8y/jV80gzzpdpe+8X6yCCaJ9i8dC3XfBLakDG8uxto38kDACCkgHZp1etu1xXvOf/1
jtRPKxpv8bh8giD6UwNpRNOI5nK4HEdr11jfcSYndSCErt282uGDviPkNi8h5mfQoi7nB7IZi2my
bd7A2PWddyZpkyxWz7bjEfvsIGLvnvGVxNO7TfohZs5KG/J/dncD7Tt5AACEFGABvaGt7n5l0tW9
3ye9n3/7Ao8j6Ee+vP+qKEQTzkK3iDFL/LwnOVz9n1r6jLnNo8OnLJoHfj3wM5uv+9t2fWN+sYv5
gWxm3Gh/8zNzishrx8+wCjAyTj5u7o2ygdqmauOEXkEBwebePUXWEZbVc5RBND8+zyR9lHnGqb7Q
QDtOHgAAIQWYQlEGte5+dunpf5x4K6lgr2PtaGMvoggaifnOIb5RL8z5eOHEp9wkUodrg9RdunbJ
i519Cm9cN19Ctsdts/7gjoTt5kHQ0SGLeys/kEQssXgI7qc/b7KeobSuoe7jbzcteSWKWQ7NvVEf
rNucufuK9X/mOsnEo2SePRVXL+FoXNfb3kcG0frxeZ6ug2zbTNrdDbTj5AEAEFKAkbig6Va9tqS6
4MezH++78L1OrxbwhP3Ll0fTNE3RtJjvFDA8dP2cjx6f+sIgV5njtueRuY/Z8NS8GQvNLyae3v3G
/71iMYgHLx47Dls4IPmZx9b1bvPN7QoIofe+fX1HwvY7d2+bXL9z9/aOhO1LXonCay1zkIuJNwqx
265v7g5LPL3b2GQSGTLLPKgZIfRN3BfPvLsyNeuMuX2lrqEupyDbgQbR3LtnjEWx0kdmqb0mDwDY
HUh/4Ki06nV19ytOX/v90q1zBMHpB9mhLGgomhILnH0G+Uf4LfQdNKEfNErqLv1g3WYr5wFbZKzv
uNdWvPNN3Bcm1y9cS7vwUZqfzD9APhEfPVZZU3Ht5tX2PIYfrNvM0pKRqIi3rg9cnF1ef/YtG5pv
fpDzfywTh3/YcfgHT9dBk8f8JxHopRvZJl4nTG5+jsl1ltv1p08K/cbMtJSTn2Vsg9mw6jWL7y0i
r+GsqlhpBU+YmlOQ3dTcyMY521uD2B5PLlhjXg2MdXtV7zbQLpMHAEBIAQghZKD0TZqG7JunT19N
NFAGh85RbllCIZqmaT5POMrLf9bYpT6D/AnUf8xsM6fN2Z74XWf/l18855Gs/EyLa08ReY1NwNDa
JS+yT2DIpsx5MxbakLp6wazFlTUVFu0QCKHapuoOczKZ7LZDlg6BschDQ4f7yfxN2nXpWq6xkJK6
S7e+/+Mrnz3f3gDh6tmWgbOHB7FTghIh5Cfzt5glq+80sOuTBwC6A3DtORIUbdC1aS7fTtum+LMi
fw9CRD8Lh6IRTdEGHlcwwtPvqbCNz0a+N2rQ+P6kohBCErFkfczLNjz16etfmJ+/y5LXVrzTYSLv
HmNt7HobYsU8XQfhE1ps8+v9R/x15N3Demvr+z/a3NV9fxCxoGTTOX2wgV2cPAAAQurBhUa0rk1z
o+LKjymf7Mn8uknbwOf2v3AoisPhDnUftSzo+fWz/jJuaBCH4PbL0Vwwa3F7i42T2MnKKrXlz1s/
WLe5U+/yk/l/+85PsYtWWLnHxdml57XUt+/8ZCVYx4Rp/hFb3/9RIpbY7NfDWNzsZr5L/6Ghw3FX
s68hQ3TI4pnT5vT8IHYKi5rJLts5e6CBNk8eWEeAbgJcew5Am6G17n5l6o3DOaUpNE3xOP3Kl/cf
Rx6H7+YsjRizePKIGSK+g/2XN8ZnnLFPwWLyQBM+ff2L7XHbTNLnvLbinQ7DXxbMWjw1cHp23vlE
Rbx1X0nMnJWT/YPYbMJ6LPqJfOWVTiUU6PpX/KCA4LivDpy9cDr5/CkrkUYxc1ZGBM204nJ6ctHq
ThljzM/da1E3t9fVM6fNycnPOpuV0qHPCB/zPDVwOhtV1x2DiBAKnjDVuJ5+Mv/2xmhO6NyT6UeN
Xx0zZ2V7c8/T3cvEJWrlQOtubaDdJw8A2AWCpmnohT6LgdLf1zReun0uqSBB16btf448GtEcxJUO
GDx5xIypo6JcxAN74L2hKyca/5q5+4pdisX7hnoyuYBao75991YZedP4opPE2ctjkA3RS72IeUOs
t6Kuoa62oWb40BE2mxnu3L3domlxEjuxH6/rJYU19dUmqmukbFSnCumBQcSdw/LZ6yWF7Ot/vaTQ
092rsxnVu3uWdnbyAAAIqQcFiqba9LrCilxFfnxV4x0+l08Q/ccP+58E5QTXWegSMio6VB7tLHLt
sbd3k5ACAAAAHkDAtdcX0ek1d+qUyVf3FVflERyugNefDsvDyp0YIHKdPGJG6Oj5Hs6DYMQBAAAA
EFKAHWgztN5rqUkrOna+5BRtMPD6VWoDmqYRQSAnwYCxQ4Nmjl06yHUYjDgAAAAAQgqwAwbK0Kxr
ulh6NqkgXqfXcrl8DrffjA52INNivsRvyOSIMYse8pDDiAMAAAAgpAA7QNGU3tBaXFVw9Mq/qxtJ
LofbnwxROEG5SOA8evCEcPmCUYPGw4gDAAAAIKQA+9Cq15Y33Dx7/VABeYHD4fSnfXk4r4GAJxzl
5R8xZvHoQQH9K/EVAAAAAICQ6j30hjaV9l5m0YlzRYfbDG396aQXGtE0TfF5oiFuwyPHPuI/dCqX
w4URBwAAAEBIAXaAogyatpb8O5kn8+NVmnoeV9BvVBRN0zSieBz+ILeREX4LAx6aLuCJYMQBAAAA
EFKAXXQGpdNrS2uuKfLj7tQV87hcPrefpDagEU1TNI/Ld5UMDB29YOqoOWKBE4w4AAAAAEIKsA+t
el3FvbKz1w8VkJmIJvi8fiShaJpLcAdIBs4Yu2jSiBkDRG4w3AAAAAAIKcA+6A1t97WN2TeTT19L
1BuofhZRzkGEs9h9ysjIMPl8V4kHDDcAAAAAQgqwDxRt0Laq88nzivy4e+o6PlfA6yfZoWgaIYIg
JPwBU0bMCPNbCAnKAQAAABBSgP2EBqJ1bZrbdcpTBfG3aq8TBFfQb8KhaJpAyEnoMmbo5Aj5wqHu
Pr3SvQTq58kUWlpaEEJOTk5QMZNX981u6YP17JVq9MF522f/lAAQUkC7tOp1tfcr0m4czi5NIWiC
2198eTRN0zQtFjqPGzJl+ujoEZ5jeqUaWp2mRdPi4Sbt3d7YsmVLTk6O9Xvi4uIQQpmZmVu3brV4
w3vvvRcQEGB8JTMzc8+ePUlJSUqlEiG0fPnyZcuWxcTE4E8VCsWvv/4aHBz8xhtvmJe2YsUK5qXG
lfTw8Pjwww+9vLw6vN9K+dYrZkxNTc1rr72GEIqKilq7dq35DdZbYRH89m3btuFfN2zYsHjx4ujo
aJO2mPen9Z4xvic4OHjp0qU+Pj7WR9nibUzDd+3alZOTEx8fj68sX748Kipq+fLlJqu4+ZTw8PCI
jIxcsGABcyf7CWZDd7Fs14cfflhcXGxevvnYtbS0xMfHJycn47bPnj07LCxszZo1TIHWB33Hjh3J
yckIoW+++cZ8oiKEXn755fr6+vbG12LhuEp79uxJSUnBVVq4cOH69eudnJzy8/M///xz633b3vQG
ABMIfHgHYC/0hrZmXWNu6dmkgoQ2QxuvH0koiqbEQskorwmRYxb7ePn3SjXa9G33VA1b93wtH+73
1OJnbCskdOXE/1lydl+xrZwVK1Yw66VF5HJ5UVERXiTWrVtn8Z68vDzjhWHLli0bN25k1uBLly4x
qgUvmbgo5leTlczZ2Rkh1NzcjBdj5gpeSr/77jvr91spv8OKmSyKuL1MD1i8weKzFlEoFPPmzcNr
IV5lcc8zvce0JSMjIzQ0tFM9Y8LevXuZ5ZPlbZjExMQPPviA6Rasq/ASLpfLT5w4YaxR2psSs2fP
/umnn/Cd7CeYzd1lc/NNplNpaen8+fNx2/FLmZqfPHkSCzjrU3fy5Mn4cfOO7XB82yuc6UA8HHjS
4ppnZmaGhYVZn3UWawIA5nCgC+wFRVPaNvXFW2e3Kt49duU3iqb7h4rCEkrAE8oHB6wKe3NNxNu9
oqJoRGt12nO5Kes/fnrfqbi+4NWLi4trNgJfzMjIYK6YLHLLly9vNsNcRcnl8r179zY3N8fFxRUV
Fd28eXPTpk3x8fGMm8YG5HL5tm3bMjMzbba9dapie/bswe1VKpUKhaLrXf3qq6/ihe306dNxcXFx
cXE3b97csGHD4MGDu1gyM17V1dVfffUVQuiJJ54w76gOb8vMzHziiSeUSuVXX31VXV2NK3n69OmM
jAzcD/PnzzfvKOMpge9MSUnZsmWLbRPMhu7qbPMZLKqoTZs23bx5E7+0ubl57969s2fPLi8v73AU
jh8/rlQqsdzZv3+/Xf48ExMT4+PjZ8+ezQxHUVHR3r17J02ahBAKDQ01bs7PP/9s/hcKKgpgCbj2
7CM1dHpNxb2yUwWJyqrLHILbPxJs0jSNEM3nCYcOHBkqnxcgC+VyemfCtLa1VtSU7zy040jqAYQI
oUDIIfrEdwDGkGO8RloJxbDyUWZmJjb5/PLLL8bfuX18fD755JPHH3+8KxEeb7/99rp16zZt2nT6
9OnOPtvZiuXn56ekpGzYsCEyMjI+Pv7IkSPGHiUbyMzMxLaKBQsWGL/dxMDWxUF0cnJ64403SktL
t23bdvLkSXOzh/XbNm3ahBD66quvTPxWoaGhgYGB2DQVHx9v7uhkeg8XFR8fv23btjfeeAMbpTo7
wWzork41vz2djS09n3zyifH9MTExCxYsYPMFIDU1FSH03nvvXbp0KT4+vj3/XafAguzJJ580dhQa
ayOLLYI4KgAsUr1Am6G1uok8fPmX75L+rKy8zOPw+8ga33UrFI/LH+QiWzpl7fOz/zJp+IxeUVEU
RTWr7x8/d3jtppUHU/bxuHwBT9Avw8yxFWfTpk0WPRddXFcWL14sl8tTUlISExO7u2L79u1DCEVG
Rk6ZMgUhtG3btpqaGkcZBWyusBgVZOU2rB0RQqtWrbK4Nr/wwgtMT1ohMDAQ/1BVVdWXm2+im3Ek
lsXIJycnJ4sBT8Zg9TZ79uyAgIDY2FiEEA6WAgAQUv0fA6VXae5dKFZsVbx7QangcXj9wJdHI5qi
KQ6HO9ht2IKJq16c++nUUVG9ZWDT6jTXbha8/uVLH//w/n31fZFQQhAEjfphVF9LSwtejTqM27DZ
6PLpp58ihD744INOuQhtqFhCQgIWUj4+Phs2bGDsDTbj6+uLf9i+fXvfHD4ctb18+fL2RAPWlCkp
KaWlpVbKuXnzpkmT+353MW23GH3PhosXLyKEFi5ciBDCoV3Hjh3resWCg4MRQl9++aX1PgcAEFK9
A0VTOr22gDz/Q/IHv+dubzXoeFwBcnAzyX8kFOK6STwenhD74pxPI/wWOQkH9I5INRgamhp2Hfn1
uQ+funL9klgo5nF5yPElVMv/wlzPy8szNgmwIdMMphCLxMTEzJ49W6lUWo9fNqGzFVMoFDhWBkuK
yMhI1OWoFy8vLxzCsnHjxpdfftnmSC82XL58mVmD2d+GLShRUVHt3T9o0H+yrFkxNdXU1OB9ZEzv
9Xx3WWm+xXnLtL3DHrMCnh5Lly5FCIWGhs6ePTslJaXroXXr16+Xy+U4Om3Hjh1dCTEEABBSdkbX
pimrLfwt46ud6X+ruV8h4IoIwuElFI0oAhGuYo/IsUtefvjzOf6POQldeqsyak3LxWvZL3+29oe9
3yKE+Lx+svMxPj7e+X8xd7SxDNGIj48Ps4T1pzZv3oy/o9uwqLCsWEZGBjIyX2EhFR8f30WrwNq1
a7E42LZtW1hY2IoVK7pDTiUmJmLzG17Uu3gbGy5durTiDwYNGhQfH79p06Z33nmni8Xa1l1W2hUW
FmY8b/38/ExucHV1ta2qpaWl8fHxxgYtbJrCE6krODk5nThxAkf6r1u3bvLkyVu2bAE5BXQHEGze
CdoMrU3qunM3DmcUK2jKwOsfEeWIJhCSCF3Gy6bPGvuIh/Pg3uxhfevdmrv7FHHxJ35DiBDyhf1p
/syePfvJJ580voI9PjYgl8snT55sUWBZeSo0NHTDhg3btm374osvjOOC7UVNTc3mzZvlcjkTXe7l
5YXfeObMGZtdP4w4mDVr1q+//rp58+b4+Pj4+HjzyG4b2Lp1K87nxCR02Lt3r3lVWd7WWZRKJS4N
YxKv3QPdxbJdmzZtGj58OPOri4vdvmUdPHgQIbRs2TLmCjbsJSQkvPPOO10M/fbx8YmLi1u2bNk/
//nPlJSUjRs3bt++3SQPBQCAkOohDJRB09pcQF44kbe7WdvE5fIILtfRFRSNEE3TzkKXcUODp8uj
Ze6+vVgbiqY0Wk3axTNf//uLmnvVIoGIIPqbudTLy8tidkobmDx5ssVkPB267Z5//vlt27Zt3rx5
zZo1jL/JXuBYKBwvzBAZGblt27Y9e/Z0ve14n+CaNWuwPti4caOrq2sXi2V6bPbs2bGxsY8//rjF
uH6Wt3WW5cuXY9NRXl7eM888s23btkmTJtlrkrDpLpbtmjdvnsWtBl0Hh0MZf6MICAjA3r3jx4/b
JQFBTExMTEwMk+Vr/vz5ly5dgt15AAipnpQblLZNU1JdkHR1L1lbzOX1i4hymkY0LRY5jxk8OVQ+
r7cSlDNoddo7Vbd+TNx25kIyj8cTC506Doci+tXGPSbBz82bN+2yQrdHQEDApk2bNm/evGXLli++
+MK+FcNCKiMjA6cRNyYlJSU/P98uTcP6YPjw4evWrfvyyy/ZyA4rDp2MjAy8V876ymr9ttGjRyOE
bt++3d7j1dXV+AfzKHJcYGho6C+//BIWFrZu3bpZs2bZ0WRivbtYNt8KuO04uKqzZGZm4t2O77//
vvF1nHoqNTXVjpmcYmJiIiMjIyIilEqlvSQaAGAgRsoaOr32dp1yb9b3/077692GUj5fyCEc2xCF
I8pFAvF4Wcjq8LefDPtT76oovUHfdL9xf3LC0+8tP5OdLBAKuFxuhyqKpmkOt19NXR8fn9mzZ6M/
9kB1Ky+//DLOz5menm7HiuFN7HK53DxQGpdg3z3ts2bNQggplUrmGDWczvH+/fvmN5eUlOBqtJc6
iI2MsHLbhAkTkNWwHrwxjckzbhHseEUInTlzxu6DbtJdNjS/PXDbk5KSbAg/OnnyJPoj7bgx2G1t
98QZXl5e2FyqUqlgdQPsCFik2lvgW1Wae5klJ8/dOKLX63lcnqOnLqIRTdOUiC8e5j46csySMUMm
9brvrEXTcuXGxZ/2/ZB345KAL2AdEUWg/nhi8ZNPPpmSkvLll1+an8uGbSr2ckZ4eXnh/Jy//vqr
HSuGtUJsbKx5lE9iYmJKSsr27du7HtLEYL79DZtGMjIyzPN/XrhwAXVbaglklN0gMTHR4vEm//zn
PxFCOJuUFbAblKWZrYvdZS8WLFiAN8dZTDdqferiTBmfffaZuQUOpzC1r1EKdTJFFgCwBCxSplCU
oVnblH3z9FbFe8kFv9M0zeM6ttykEU3TNI/LH+k59rHgF5+btWns0Cm9q6L0+rbK2rs/Jn638csN
14qviEUibidjzvqfkFq+fDlekNatW2eyxy0xMXHy5Mn5+fn2fRfLPAgsK4a1gkWxEhMTg0uwbU/7
jh07duzYYWycaGlpwcaMDRs2MIs0TkG0efNmk72QiYmJODM7vqE78PHxweerfPDBByZtLC0tXbdu
XUpKyvLly41TjVuE6Sgb8qZ2trvshZOT09tvv40QWrdunUm1S0tLX3755fY2ISYmJuJjYSz6MbHo
tDlxRktLi3nqh8zMTDznu5KsAQDAImVVcNC0Tq++VVt0In/PnTolh8MV8ASO3iIaUQKe0N3Ze7rv
3GCfOQKesNerpNVpsgrOb/nl84qauzw+n9+/tuZZAe91N7n4yiuv4DBevFt7/vz5eI8V4+/A26nk
cvmoUaPsuPh9+umnTzzxBMubO6wYTu1tvF/PhNjY2M2bN5uYi8w7JDg42Nxq1dTUhJXQ8uXLo6Ki
bt++nZGRgV/34YcfMreFhoZ+9dVXGzdufOKJJ5YvX44Xy5ycHLx27t27t5vCpTHr16/H75o3b97y
5ctHjx49fPjw5ORk/PbZs2d/9tlnbETM+vXrN27c2BVLDMvu6hTM5j6G0aNHM6bHtWvX4pc+8cQT
xvtJcdtxNL05OKLOeL+eMdjIFx8fb2KvMq+JxfNkcCJZnDA9LCzMeCy++uqrbg1DBEBIPbi06rU1
qrvpRceySpMJmuPoh+XRNE0jmsfhuzsPnu4bNXnkzN5KrWmMrlVXXVf5475tJ9KOcDhcgdB2CUUj
qm/2PD6j3oRhw4Yhs73uGOOFxMfHJy0t7bvvvktISGDMRXK5/Kuvvlq/fj1ehju189zJyQlbOCwa
P3BiArlcbrzAWyy/w4rhCCqT/XrGzJs3b/PmzZs3b8Z72q10iEVt4erq+uWXX2Ilhy9u2rTp5Zdf
Ngk5euONN/z9/U3uXL58+Zo1a0wUnpWeseE2fGdcXFxUVNSePXuMTX1yufztt98294q2N45Lly7d
uHHjtm3bPvzwQ4sBVRYnWGe7i33zly9fblwOA457M+55mUy2f//++Ph4ptgNGzYsXryY6XnjJjMZ
89vLAILT4jOJM6zU5JVXXjHvTy8vr4yMjD179mzbtg3Hs+M6v/DCC1YUqoeHByyFgA0QNE0/4F2g
N7Q161Q5N5OTr+5rNWj5XMc2kGBHHpfguji5h/jMmT56Xm+l1jTGQBk0Ws3xtENb92xRq9UCge3n
5RGIaNY0b3ph8+MPL7ethNCVE41/zdx9xS5tZKKerXxqca2yeD0/P7+5uXnw4MHmjg8rQScW62D9
/s7GY7VXsQ6juEzqZrFDrJdQWlqKY30CAwNZ3unr62slvptl5FlnA9RqampweLvF4euw2PYmkvUJ
ZkN3sW8++5Fi2m7xpcZvZNMckxpar0l7kxln57c+FsiuYYgACKkHCIqmdG3qq+XZJ/P2NLTU8Dh8
h85Rjg+hIxAxQOQ2ZeTM6aOjBzp59oWKaXWa66XX/pn43cWr2Vwul8vp0s5HAhHNatVHL32+bO4T
tpXQTUIKAAAAeAB5QF17NE3r9JryhpITeXtu1d7gEP3Bl0cQaIDQzV8WEiZfMMh1WF+old6gb2iq
P3r20PbErXpDm5AvtM+JhARB9VXXHgAAAABCqp/TqtfV3r+bXnQspzSFohx+Ux7GSTTAb/DEcL9F
Mg/fvlEjulndfOn6xe/j/lFUVigUiIR8kf3K7oe79gAAAAAQUn0dGtEqdUPurdTkggRdm5bL5fG4
RL9oF7V40popI2f2Fana1lpdX7nz0I4DpxMRIsQiid1fAUIKAAAAACHV0xgMbSfz95wvVnA5/eGk
l/8KKRql3jhCIMJvyKTeDS2naEqjVSefV3y35x/1jXVCgYAgQPEAAAAAIKT6R2u5gsWT1ng4e2ff
TG5SN1DI0D8MGxyCU95w87fMLVNHzpozPsbdyatXZKJGq75VUfbjvm3ncs9wCI5I2H37H2nQZwAA
AAAIqV5AIhwQNf7xwIempxUdKyAvtGibaKI/+Il4HB6N6OzS03nkhceD148ZMtlJ6NJjasNg0Dc2
Nx06vW/H7//U6DRCgbAbX02gBz5lBwAAAABCqlfxdBm6LPj5ANm0s9cP36q7odNrCLxEOzIEIvhc
YZtetztjS+DwsLkTYr1chvbAbsQWTfPV4vyte7Zcv3mNx+WJhKLufiONEBikAAAAABBSvYzv4ACf
Qf7ZN1Mylcdr71fqDW39wGHE5XA5HE7e7cyr5dkxIS+OHRI0QOTWTe1q07fVNtQkKHbtPvpvhJBQ
IIS/KAAAAACElKOia9XV3qsRCUSuA9z4PFZBQhyCO8137rihQWlFx67cOqfS3KNoytHlFIEIPk9A
0VRc5tYxQyYumvS0l8sw+56yR9FUa2trxuVzf/v1s5q6agFfwOH01CnINHj3AAAAABBSdoWiqGZN
86mM49sTtroMcHsh9pUg/xBXZ1eWq7uLeODCiasmjwhPKTxQVHlZo2tGiHB0OcUhOAKeQFmV943i
rUUTn544PMJF7EYQdpA7ulbt7cpbu47869i5I1yC0wO+PBOdiEBFAQAAACCk7IVa21JWXrot7usL
+Zk8Dq+ppemdr/8UFfLw04+sGz7Ex0nixDKW3NttxMrQ16+WZ58tPHD3XpmBavtj3XbkAebwKZo6
ePHnfPL8ksnPDHYbLuTZrnsoimpW3z+ZfnTr7i3NmvsigbhX5CaNaA6XC3+9AAAAAAipLtGmb2to
qt+fnPDLwZ8MBoNI8B+JwOVwT19IOpN9esXC1Y/OifGWDmFvNRk/bOroQROybiZfKD7ZoK4xGKh+
YJricIW3am98e+rd6AmxoaPn27ahT61tuV567cfE73Kv5vB5PLHQqRdNQ5CQEwAAAAAhZTsUTTWr
m7PyMr7ds+VuNSngC3j8/7aFIAihQEjR1O6jvx5PPbj2sRejwxYOcHJhGTgl5ItnjFk8ftjUtKKj
eXcy72sb+8GePi6HR9PUiSu7iivzV0e8NUA8sFOCtel+496Tu/596F8G2vBHUDk42AAAAAAQUg6I
Vqe5VVG259i/T5w7ShAEY4gygUNwhHyhSn3/yx2fHTt3+NlHn5s0NtjV2Y1l4JS786BHpqwNfCjs
TOH+strrmjY1cnBDCEFw+DxRae31+uZqZ7Ebm7bQiG5uab50PWdb3DfFd24IeUJB3zjdGdIfAAAA
ACCkOo3BoL+vvn/k7IHv9nzd2qYTCzs+xI3H4fFF/KLS6xv/9sqsoLlPPfKs70OjnSUDWPq2RniO
eTrinYu3zmYUHa9uumugHT5wSsgTcjmsxl3Xqq2oubvz8L+OnN1PEByJQEKDFQoAAAAAHFFIYdPI
tZK87+O/yVfmiQQiidCJ5bpOI5rP5/MQP/ViSmZ+2qNzYh6dEyPzHi4Witk8zuFwg33mjB0SdKH4
VFZpskpdT9EOfEQJmy7DntNTGcd+iP+u8X4Dn8fncDigogAAAADAIYVUa5uuouburiO/HDqzn6Yp
J5ETjejOrusEQkKBkKKovYo9x84dXrvshUWRj7g4u7IMnHIWuUZNiBk3LDiz+GQhmX1f14QQckQ5
RdMUjWicjckiGq36duWtbXu+uZCfjqPN4O8EAAAAABxSSFEUdb9Fde7imW92/r1BVY8PceuKaYTD
4Qg5Ql2r9h+/falIP7p6ybPBAdPdBgzkclhtpx8ycMTjU1+4MSwk9cYhsr5Yp9cgRDhQ4BRNU1yO
QMQXW6yy3qBvaKo/kXbk+7iv9QYKJBQAAAAAOLCQUmvVxbeLvtuz5eK1LB5XIBaK7eVd4nK4EqFE
ebvow+/enTYxbM3S50c/5DfAyZll8NOYIZNGD56QU3rm7I2D95rrKFrvKNv6aEQhAvE4lo1w+cor
n23/8CZZIhIIhQI+/HkAAAAAgEMKqda21oam+gOnE3858CNFUSKhBCFk3xgdGtECvoCm6czL6dkF
5x+dE7N8wWqvgV5ikYTN41wOb5rvXD/viRnFJ67cTlO1NNAE7QimKQLRNEVTFj/77fC/bt0tEwvF
BGyKAwAAAABHFFIUTak1LWkXU39I+IasvCMSinjcbqwkQRACvoCiqfgTu4+ePfTso+sXznxkoIs7
y8CpgU6eiyauDpRNP1N4sKQ6X9OqRkQfT5FAUAi1J6QGew7h83jwVwEAAAAADimkNDoNWXnrX/u3
J59XcDgciaiH9ttzCI5EKNHpdVvjthw+u//lJ18PHDN5oIs7y8ApmcfopyLevHwrLVN5suJeaRvV
1pc9fQSi6XaEVG19NYfLhc15AAAAAOBgQkpv0Kuamw6e3vfTvm2tbW04zLkn99vTiOZxeDwBr7zq
zttf/SnYP2RdzIvy4WMGOLE6TYVAxOQRM/yHBp8vUZwvPtWkrjVQffRsGSsbHoUCAYEIR0hzQCM4
IgYAAAAAIYXX9RZ18+Ubl7YnfHvj1nUeh9e7m8X4fAFN07mF2Zc3X3xk9mMrFq4e7DGYZeCUkC+e
OXap/9CpGcoT+WTGfU0jQkRfk1M0TbRnkXIb4E7RNOr7WbJoGoK4AAAAABBSSNemIyvvJCr2/H4q
geAQAl4fOX6EEPAFFEUlnoo7nnbo2UdfWBj5iLurB8vAKU+XIUuD1o6XTU0p3H+nvljXpkF95mwZ
AiGEKIqiLNp0BDw+TVMOkc2BIDjw1wsAAAA8uEKKoqhm9f3kC4rv9mxpvN8o5Av7mhWEw+FIhJK2
Nv22+H8cTtm/YeWfJo0NYh845TtownCp3+Vb59KLjler7lKUvm80kEBEu8Hm91T3+Fy+gTL0/YlL
0xDJBQAAADyoQkqtaSksvfbTvm05BVkCvqC9U4d7f7VGNJfL5XK5d2vK3/7qT9MDw9c8+pzfiDEu
Tq5sVBGfK5g6KmrMkClpyqNXytJUmnsU3fuBUzSNhZQFk9QAZxeHmbng2gMAAAAeQCHV1tbaoKo/
cHrfLwe2txn0IqHIIbqJz+fzaF52fubFa1mLZj0a8/AK2eDhTmInNs+6iAcuDHxq4kNh564fUVZd
adY29W7gFIFoirZsc5K6edKIph3iJEEwSAEAAAAPmpC633L/Qn7GV798VlVXKRY5ifl8BzoHlyAI
gUBEUYaDp/cdO3vw6aXPLYpcOshjkIDPKjR+6ECfFaGvXbubfa7wEHmvTG/Q/UfV9LyMotv1i+na
dIQjHXgDAAAAAL1Mj0bspl08u2nrO7X3asQipy4emddL0BwOR8gXIoR27PvhxY+fPpVxou5erd6g
Z/m8/9Cpa2d9uCBwlYezN4E4PR/oQ/xHS1mOkdK16jgcbt9XUhSNOByQewAAAEDv06MWqTnTHh7o
MjD+xK5rJQXN6vsEQTjoUSQcDlcg4Nbcq/nwu7enBUSsXPz0+NEBLAOnBDxhuN+CMUMmpV4/fL0i
t0ndgBDqwX4g6P+kkrIglyRiieMEcYOQAgAAAB4wISUUCKdPDA+eMC35/MnfDv96p6qsTd9GIEeV
Uzwun8cVZF3NzL56YcnspbHzVskGPyQRsQqckg7wfmzq+rLaGWcKD9yqLVS3qnusHwiabj+PlBtC
yDFipAAAAACgD9ALyXh4XN688EXfvr/9ucc3eHkMJhDhyFvZaSFfyOfxDp3ev/q9J+KO/VZRU97a
pmP58EjPsWtmvLtkyrqhA314PL6VnOP2rDFBtPcOg8HgKO5WEHoAAADAAyqkMB6uHquXPLvlrW0P
hy90cXalKMpx5RRBEEKBkEDE1t1bnv/L0yfSjtU0VLMMnOIQnKCRM9fP+cvDE2LdJZ49EDhFtK+V
1Fo1h0OAOQoAAAAA+rqQwvg+NPovL3329toPJo8LEgqEDi2nOByOk8Spur7qkx/ef+8fb2RcPtd4
v7G91JcmSATOs8Y+uiby3em+UU6CAd1rmmp/156LswuYegAAAADAYYQUZk7Iw39789vnHn9pmPdD
XC6XpmnaMdME0TTN5/EFAkF+0ZW3/vbq1zv/eqO0UK1pYfm4t9uIR4PXPzF9g4/nOCFPRCGqO/qB
RkR7WZgGDvCgKcgZDgAAAAAOJaQQQk5i55WL1nzz7j8fmxvr4eaJULtb9Ps+BCL4PD6Xyz1y5uDa
TSvjjv9GVt3RtbINnBo3NPjZyD8/HLB8kMswLsHtBl1DGyi9RS2lbdNCWgEAAAAAcDwhhRnqNez1
1e/832t/mzFllpPYmaIdO3BKLBRTNPXt7q/W/2XNkbMHauqrWAZOCfniGX6Ln5v1Ybh8oZvEw4oz
rtMaCtEEInhcgcVwba1OSxAcCJECAAAAAJbw+mCdAvwmjR8deDLjaMKJXaV3S9vaWh00RQKNaC6H
6yxxrr1X/dmPHyn8pz61+NkJ8kC3AQPZNMdNIl00+enA4WGpNw4pq/I1umbU9YxTNEIcxOPwLX7o
5T6IgPQHAAAAAODQQgohxOFwFkQsCZkQuj95ryLjeEV1OUVTHILjiF2MA6f4PP6lwpz8oitR06NX
LV4jGzzcWTKAzeMyD9+VYW9cuZWeqTxx915Zm6GVwOnJu1Qly25TD1cPGhHYagV/GwAAAADQsWLp
y5XzcJM+9/hLW97+bl7EIrcB7hRNOW7gFEJIJBBzOMSJ9KPPbnry14M/l1ff0bZq2TxIIGLSiIhn
Z74fHRArHTCo6ykSaGS5G5s19wnkCIft0QhsZkAPoNPpdDod9AMAAFbg9f0qPuQ94sMXP824lPrb
0V+Ly663aNUOerYMjWiC4IgFYj2l//n3fx5MTlwX82LU9HkDBwzkcjseCLHAKXLsUv9hISnXDtyo
uHhfew/Z6vFsT4e1trVyOBxH6FvYWNjB8k+SpK+vbzcVjhASCoX9vg+TkpLy8vIQQhKJZPHixWz6
8wHpnB6YZgAAQsr+hE2OnOw/9ejZA/uT996pvG2gDI7q6UM0l8N1Ekua1E1f/uv/Dp3Z/8qTb/iN
GDvQ1Z1Ni6QDvJ+Y9lJJdUFK4X6yvkTT1tJZG5IVDeLhJoUYqc6SmJio0WhmzZolk8n6SJUSEhJI
koyMjAwPD7dXmVevXr1+/Xp5eblarUYISaXSoUOHjhgxYvz48f1yWLGKkkql/v7+paWljY2NVm4u
KSm5fPky0zkymWzcuHFBQUH9e+Z3xzQDABBS3YtYKI6JfjJ8ysz9pxIUmcdr62sQ4aguHpqm+Vw+
n4uKbxW99vn6GVNmrX5krY9s9AB2gVO+gyaMkI65dCs1rehYnapST7ex11IEQlQ7FqkBTi4EgSBG
qlNfypVKJWOK6K9tPHz4MG6mRCLBerG+vj4vLy8vL+/69esxMTH9r9XFxcUIoWXLlnl6eloXCsnJ
yVlZWfhnmUxWX19PkiRJkoWFhatXr4a/EQAAIdXn8JYO2fDk65FT5/zr9+1XS/JULSrHPfYYISTg
C2iaTs09k3H53JMLn142N1bq5ikSijoeOS5/6qioMUOmnC9WXLqdeq+5jqapjvsBW5zaEVL3murp
LmwMpGmapmkOhwN/V71LbGysvXwuOp0OGx6kUmlYWJix/amkpOTGjRt5eXk6na6fObN0Oh22Lbm4
uFi/E6soiUQSERExYcIE3A+1tbVZWVn9sme6aZoBAAipXmC8b8AXG78+feFU4sk45Z0ivb4NIUe1
ThEEIeALKIr65dBPh88efPbR5x4OXeA2YCCP1/HouIgHRgcs9x82Ne3GEWXllWadChHIuj2JRkR7
weY0jTp8vD0JRVGURCSRDvSqbqjU6/Xwp9WLCIVCey1vSUlJJEnKZLLY2FgTTeDr6+vr6xsSEvKA
hASZU1JSgm1RJhFUnp6eixYtCgwM7N89Y8dpBgAgpHoHPk8wL3zRtICw35MTjp87XFlb4dDBPRwO
RyKQqJobt/z7iyOpB1+KfW3cqPEDXdzZGHiGufusCH2t8G7O6Wu/VzbeaTPoELKsh3DmhPYsUgNd
3TkEt7PdSFEURVHenkMejYqZNDbog2/frGus637noCMNNA4w0mg0CCF3d/cxY8aYr0A6na6goKCw
sBD/avG23NzcwsLCpUuXCoXCtLS0iooKhNCQIUMiIiKM12x82/z58z09PTtVvgkkSeJo61mzZrWn
CUxecfjwYW9v7/Dw8PT09NLSUoTQ0qVLsV2nUw00NgWpVKqDBw/6+PgwLrbc3NyysrLo6GjjfnB3
d58xY0aHNqQOq5Gens78nJOTgxASiUQWA54uX76MEAoMDLTYjSYxcx2+17j3cD8ghMRi8cyZM3En
40gsjUYjFosnTZpk/KxKpVIoFCNHjgwKCjKebBZDtbApsaGhAf/q4+MTHBxsPn9snmbMI7gCjKHO
+MGysjJcwyFDhkydOrXDUQMAEFLdiJvLwLXLXpgd8nD88d8yLqbWq+oQQoTDxqHzuDzEpYtvFb3+
xYvhk2aufuRZ+YgxLDNOjRsaPNJzXE5pSlbJqbr71RQytKNm6D/+mSIROREEh32MFE1TNI0kInFI
QOiaR5/3GzG2rPymXm+AvytjGO+Ph4cHQgiHFkVHRxuvcLW1tbt27WJClXGcTV5enkkkb2FhIUmS
SqUyLS0N34zlTkVFhbHFCN9WVFTErHAsyzehqKgIISSXy1nG0eO6aTQarVbLhA3V1NS4uLh0qoH4
EeZiTU0NSZIIIeZOfNvIkSNN+qG4uHjVqlXG67oJHVZDp9OlpqYy9+OfZTKZuRxhwuNGjBjRYc+w
ab7F3kMIlZeXP/7440VFRcYXlUrlI488wnhaa2pq8LONjY3Gt5Ek2djYGBUVxVw5evQoFsd4THE4
V2lpqfn86co0YwLpFApFYWGh8VMmfw5ZWVn37t3rl2F2AAgpB2PkUJ/3nvsoMzg97tjOwpsFaq0a
IcdNNUQI+AKapjIup2bmpT+1aM2CyCVDPIeKRZIOnxQLnGaMWTx+2NS0omNXyy80tTTQyMS8RCC6
3WDzhqY6ima3HZJGFG0gCGKol2zVkjWLZz7K4/IQQlqdhkYUohFEqzPmjaysLGPXGEmS+/btUygU
w4cPxyuQTqfDy09ISAjz7Tw3N1ehUKSmpg4ePNjE4KFQKGQy2apVq1xcXFQq1f79+0mSLCgoaG+b
WGfLZ8B2BW9v7041Ga/N0dHREyZMwG5BmytgHeN+0Ol0Bw8eJEny7Nmz7a3KbKohFArffPNNhNDf
//53hBD+2aI1Dms7hNBDDz3UoQ2MffONe0+n0507dy4vL2/fvn1qtToyMjI4OBghlJaWlpWVlZGR
YbJl0vhZhFBBQYFCocjKyhoxYoTxKyIjIwMCAnA1VCpVXFycxflj8zQz/pKAZVNSUtKiRYvQH9Fj
Uql0zZo1TDzZ7du34T8KwKHpV3HBoRPD//bmty+vfOMh7xFcDpeiKRo57lF9HD5fwCGIfx3Yvv4v
q39PSqiur2IZe+TuPOiRKc+umP6a/7BgicCJRv8TXU78xyhlAS6HS9AdKyCKpgwGwwCJa+z8p/7x
3g+Pzonh/ZEHq0XTYjD0TNJUx1Bq2Dc0f/58ZjGWyWR4ncP2HrzgqdVquVweFRXFWGKCgoJCQkLQ
H/4jY7As8/T0FAqFnp6eU6ZMweaB9urQ2fJNGDx4MPOzSqXa+b8YO8IYQkJCgoKCcAyNUCjsYgXa
w7gfXFxc5s+fj001jMSxrR9MZFOHcU4d3tDZ5mMhghsVGBiIEMLqJDw8XCgUCoXCqVOnIoTq6urM
94oyzwqFwqCgIPy48SsWLVoUHh7OVMPFxcXf3x8hZJ7fwbZpFhgYaKy0cFVx3D1CqKmpCSEkFouZ
TvP09Oz3eSIAEFIOhkgoenROzNfvfB87f9UgqTeiacqRk6FzOByxyOm+uvnrf3/52ucvpF9ObWiq
pyhWLfLx8n8q4q0lU571HjiCx+PT9H/ceTQi2pOXbi4D+XyelfJpmqYMBj5PEDhu0sevfP6np96S
Df6fr+Ot+rae0q4OIJFJksRuDhNnE3YG4RAiZnEaOXKkyeP4NqVSabJe+vj4GC/ebm5u1qvR2fIZ
6uvrTa5gL5sxqamp5o9HRETYpQIdzPD/7QdPT0/sUaqurrZvP3SRzr4X62yMl5eX+UUXFxepVGps
FbP4LPMKJhzKilBmoppsnmZlZWXIzNHp4uLC+BCZ5pAkmZubC6sv0G/g9ctWDfEa+srKN6KmR//7
4E+Xb1xqut/ooMnQsWLgcrhcIfcmqfzTX1+YF7YoZt6T8uF+A5w6Ds/kEJwpI2f6eU/MLTt7oeRU
Q3M1TpFAtaNCBHwBgYj2NApFGQwUNcxr6MKZj65YsNpJ7GR+T4vmvgEZesRc5ACjiRfI+vr6nTt3
WrkNR92aL1T2yvBpc/keHh5qtdrYVuHr64u9XXg5TEhI6NYK2IZWq+0L1ejW94rFYlZfLEUixnbF
qCLsTWPCve3bzEuXLl26dKk9Oe7i4hIdHa1QKBQKxcWLF6dMmWIeig4AIKT6EGN9/D9//evTF07t
Pvpr2d2bulYdcuDAKcTnCfhcwanM4ynZSU8uXL10Tswg90FsAqecRW4zxy7185509vrBoqorLZom
mrIcD97U3KQ3GDgcrrkhiqZoicQ5yH/qC7Gv+AxrN6KloakBUXQP9LEDDaNEIvHx8TH/uo9XVp1O
V1dX161izuby8WpdVVVlfLGzy153N7C3quHq6op/qKmpsSKJ+kjzGXBsVvfJR3d3dxPJiCc/87qg
oCA3N7fLly8rlUqFQpGWlhYREQHePQCEVN+FIIio6dFTA6YfTz30e1JCeQ1J0ZSDni2DrTBiocRA
G349+POB0/vWPfbCw6EL3F09+Dx+h496uw1fMf216xW5irx4DodLW4oH53G4XC7XeNcezrFJEMTw
oSOffWz9nJCHeVaPBWxtbTXQcBCeqRyxsjNOKBTKZDKSJM3tKCqVqutv70r5I0eOVCqVeXl5bNIK
9FYD2zPDdHc1PD09pVJpXV3d7du3rYiSnm++OVKplInsxioqNjaWCT8vKSlhaVlkQ4c5NdAfGchU
KlV2dnZWVlZaWhrYpQCH5oFIQu3i5LJ8wVNfvPGPpbNjpG6eFE05buAUjWgOwXESO2k06r//8n+v
/t/zZ7KT6hprDRSrpANjhwQ9N/vDUV7+FtNTcThcAV+I/lBCOKh8oKv78gWrv3v/p+jQBbyODlc2
0AaKomjQUkZGC5IkrS+Z7u7u5oYfhBDezSSXy7u4xthcflBQEI7FOXfuXM9UwOKd7Z1zZyJNVCoV
DsQZNGhQz/QzDtPOycmxGFzFXOzu8bX4UsytW7eYCqA/Yr1lMll3JNLEb8FvZPXfsotLVFSUTCZT
q9Xt7Q8AABBSfQsfme87az/46KX/Cxo31UnkRNEOvN7TNM3j8ZwlA26SJe9sef2vP3+SezWr6X4j
m12KTkIXiXCA5UxRBOIQHJpGNE0bDAYeTzAtIGzzK1+8tmqjp7sXm4pRBgOiIY/Uf40WcrkcIZSd
nW3yUW1tLbPmjRkzBiFUUFBQW1trLAvS0tKQpSBlG4wENpcfFhaGEMrLyzt69Kjx46j9UKSuVAAH
PjNh+MjIFWVOVlaWccxyfn4+tr60Zx+yez8HBwdLJBK1Wp2QkGDSObm5ud9//z3WB909vsYcPHiQ
mVcqlaqgoMD6K3Q6XWZmpr1sUebNxDA6qba21uRTHFkF5ijAoeE9aA0OHh8yQR54Mv1YwonfyqvJ
Nn2b4x7VR9M0Pqrv9IVTablnls1dvizqiWGDhrEJnGrP3mWg9IhAFE0N9vReOjsmdv5KSWdKa9G0
0OhBTCKVmZlpsiDNmjVLJpPNnDmzvLwcZx1kEjJVVlYqlUrGvYIPWsnKytq1a9fo0aPd3Ny0Wi3e
TI7zCHSxbl0pf/z48VqtNi0tDecRlclk7u7uGo1Go9Hg1VEikXS4CrKvgFwuT0tLI0ly586dPj4+
jY2NeXl5gYGBOIekCRKJRKFQlJWVeXt74y5llJ/d+8EiQqFw1apVu3btIknyxx9/ZARcfX29Wq2W
SCR4k1p3j68x9fX133//PZNHCm8aZV4hk8kkEglJkkePHh0xYoRWq7148SKTctOO02zChAnYwarV
am/evCkWi/H5zUVFRampqYGBgTiOqrKysq6ujn3GVwAAIdVXEAlES2c/Fjox/GBy4rG0w7UN1Q59
tgxBEBKhxEAZ4k7sPJF2eN1jL86ZFi0d6MkmcMp0NnB5iEBikVNk0Kynl6wdOWxUZ0tQtahYZmfo
HzARMOa+CWwY8PT0XLVq1dmzZ5VKJV7psQIIDAw0XjyioqJEIlFOTg6jGCQSiXnacRz9bRIDZK5j
zG9jWb5FgoKC5HL5uXPniouLjVsqlUpHjRqFEwUZ18SitGJZARcXl1WrVuHcjyRJ4nuCg4MtCimc
nTI1NRV3rPmxyuZ0qh/YaERPT8+1a9cyncM8GBISYnygCpv3Wuk9K9PP5Mrjjz9+5swZJrl5YGDg
3LlzTZTf/v37sSzGynXFihVbt2413gbY9WlmnF1dJpNNnjwZ/+zn51dZWWk8miY1BACHXIUf8HCW
ayUFe47vzC3Ibmq+58gpEhBCiECEnmrTtbb6PiR/7rEXJ/sHu7t6cM224FmzJ6mbv/zXp1P8gxdF
PsrmjD9z/rLtz4rMYwih7jtrjyCIe00NX7/7Q3TYAttKCF058X+MSbuvdLFKFkNkTBYelUpVU1OD
EHJ1dbVyhglJkninenvf0Y33sVu5aPE2NuVbp7a2FsfZeHl5WQw/b++9na0Avo0J5TEpdufOnSRJ
YiGCO7azLbKtn9mU2ZXxbW9wLeoY45uZgPE333xTKBTit7Q3RuZVZTl/OjvNsIoyv4H5W7BSQwAA
i5TD4O874dNXvki+oNiftPd66TVtq9aBPX2I5nJ4TiL+rYrSP3/zZtikGU8tecb3Ibmby0CWskYo
FL373EdiodjmOrRoWziI47gJ5W22S3V4j4uLC5s1o0M1YPFd5hfbq1IXfSienp5WVAKbrmBZAZPb
rBTLsmPt0s9db5r1e1gOboc17LAmHXZvt04z24YMAEBI9WFDDsGZO31+aGDE4bP7DyQnlteQFEU5
tJwS8AQ0TadfSr2Ql7FgxuKVi9YMHTRMInLqeDZweR3uy7MCRVOIoiiaQkQ3WqQAAAAAoO/AgS7A
OEmcVyxY/eWb3y6JfNRr4CCaRg59tgxBEGKhmMPhHD574JkPViSc2HW3pry1rbVbX6rX6++r7xOI
ABUFAAAAPCCARep/GDFk5LvPfZRz9cKe4zsLblxp1jQ7buAUjWgOhyMWiFvbdN/u/vr35L0vxLwS
PGGa50BPTmcCp9hDUQacVMKhQ82Avk9oaGhVVVVAQAB0BUYmk0VHRyPIIwAAIKT6CMHjpwX6TT6Z
fnSfIu5WRWmbXo8c9mwZGtE8Lp/H5VfXVX78/Z+njA95PmaDz9BRri5udrcb6Q16basWEXQP5D8A
qfYgg1NjQz8wCIVCOGUFAEBI9S0EfMGSWcvCJs2IP7Hr9IWTlbWVjn22DEJ8noCm6dyrWRevZi+a
+cjyBU/JBj0kETvZ9y26Vl0PZZGC3OkAAABAHwBipKzh4SbdsOJPn7zy5fwZi9wGDDRQBofOFkEQ
hIAv4HK5h88ceOb95Qknd1fVVeKznO0zmTictra2HugiGoFJCgAAAAAh5SCM9w3YtP7TN9e8Fyif
JBaKKdqx5RSHwxEKhAYDtXX3lmc2PXky/WhVXSXLo/qsc6/pnrZVC3MKAAAAACEF/A8EQURNn/f1
u98/s2z98KGjuFwuRVEOnS2Jy+WKhKK6hppPfnj/w2/fvnQ9556qwS4CkaDBVgQAAACAkALMcBI7
P7X4ma/e/HbJzEe93AfRFO3oeeH5PL6AL7x04+KLnzz7zc4vr5cWqrUtNpem1rYYDHqYJwAAAAAI
KaBdhg166O21mz5++a+hE8OdJc4URfWDwCkeh3ck9dCzm5bHn9hVWXvXtsCpNn0bAUHgAAAAAAgp
oEMmjZ3y+etfv7j8tXGj/Hk8nqObpnDgFE2jb3d9tf6TNcfOHaquqzQYOhc4pdVpDBQIKQAAAACE
FMACoUC4LOqJLW9/v2rRM0O8htI0TVGUQ7eIy+E6iZwqa+5+uv3DD797N+fqhXuqBvahYA1N9Qba
0CPZD2iH3rSn0+ksnnNscoP1e2wr2fhONkV1Ux1YltytncC+njbUAQCABwfII9VV3FwGrn/i5RlB
s3Yd+TXvem69qp5GyHEzTtGI5vMEPJrOLczOuXrhkTmPLYuKHTHEZ4DTgA6fbdW30hRF0HBCTLvk
5uYWFhaSJIkQkkgkw4YNi46ONj7A1fgGhJBcLp82bVqHZ9CqVKpz584VFxer1WqEkEwmmzx58vjx
49sTB0lJSXl5edHR0RazOJrXYezYse2V1qk64Hvu3r1bV1eHEJJKpf7+/uHh4V1pjvFT2dnZN2/e
tEvhubm5ZWVlSqWS6YSZM2e2d2Dz1atXMzIyEELr16+HSQ4AIKQAWxjr4//Za3/LvJz225Ffrpde
1eq0jnu2DEKIIAghX0jR1MHT+xRpx5YvfGpZ1BPSgV4igcjKU/ebVTSiQUW1J18SEhJIkpRIJIww
UiqV3t7ezGKfnJyclZWFV3eEUH19vVKpVCqVsbGxVhJ519bW7tq1S61Wy2QyDw8PhBBJkiRJarVa
c52Um5ublpaGNYRWqzUvDdcBV3LIkCEVFRW4DhZL61QdVCrVjh071Gq1VCrFDSRJMjU1tbKyMiYm
xrbmGMsjXDjuvfr6+rq6utTUVK1WGxUV1dnCmYGQSqVisZgkSaVSWV5evmrVKhMtpVKpFAoFo7d0
Oh0c0gIAIKQA2wmdFBHgN/FUxvH9yXtL796kDJRDyykOwZEInQyU/pcDPykyjj+z9PnQiRFeHoN4
XMvTRm/Q0xSiEZikLHD48GGSJAMDA+fOncustSqVynjdraioiIyMDAgIwDYqRntdvnzZipDav3+/
Wq0OCQlhFENubq5CoUhLS5swYQJTvk6nO3z4sFKplEqlw4YNY9Z+Y0iSxCrKWDEwpVnRMWzqUFNT
4+HhsXjxYqYt+B6lUkmSJCMuWTbHhJqaGolEEhERwdyDxVBWVtaIESOYN7IsvKKiIjAwMCQkBHcC
SZL79u1Tq9Vnz5411nyMKg0JCcHCCwCABxCIkbIzzpIBy+bG/u3NrY/NeWKw1NvRA6doRHM4XIlQ
UlNf/en2D9//5q2MS+camuop2kKjmtXNNEIPrIpKT0/fuXOnSqUy/6ikpAQrmEWLFhlLARcXF+Nf
V69eHR4eznj6hELhuHHjEELl5eXtvbSkpKSurk4qlRrbXYKCguRyuVqtLigoMBZJ5eXl0dHR69ev
9/b2tlhadXU1QsjDw8PY7jJhwgSEkFqtbi9UiGUdfH19V69ebawIg4KCpFIp895ONccEX1/fNWvW
BAUFMf0ZFRUlkUgQQlVVVZ0tPDY2dtGiRUwnyGSyiIgIbEE07oTCwsJhw4Y9//zz+FMAAEBIAXbD
23PIxmf+vPmVLyKmRLo6u1IUZVF5OJCc4vP4TiKnguLLG//28tZdXxUUXbnfYqoYDJThQU5/UFpa
SpJkTU2N+Uc3btxACE2ZMqWzZYpEIoQQFgQWwSpBLBabzkBvb4RQWVkZc0Umk7300ks2HG2LpYNE
ImnPGsS+DuaYPNWVosyrh513NhRuXpSbm5v5G+fPnx8TE9Ne4BQAACCkgK4yQT7x//605dXVb/mN
HMvnC2jasTNO0YgW8IV8nuBASuKLm5/91/4f71Te1rX+N86Gw+X24HGEjmT3Ki4uRggNHz68sw/e
unULITR06NDOPjh48GCEkEajMRYHHYbv4BqSJJmbm8tczM7ORn/YpbpYBxNqa2txSHuHPdNhURap
r69nxGgXC29sbDRXkyChAABAECPV3fB5/IURS6YHhB05e+Bo6qG71XcoiuJwHFi/EgRyEjsbDPpf
D/14KvP4s8vWh04M93QfxOPymlT3EI0gPsoEnU6Hg6CFQmFubm5VVVVDQ4NYLB45cqTFoB9sAdLp
dPn5+Xl5eRKJZMaMGe0Vbl0ldFZ5eHp6RkdHKxQKhULR2Njo5+eXl5eXl5cnl8uteK86WwfcQJIk
MzMzEUJMKJJ9m0OSJO52RqV1pXBsrxo9ejTMZwAAQEj1Au6uHk8/si504oyEk7+dz8toaKxDCBGO
myKBxoFTTjUNVZv/uSnQb9Kzy56fOGaKXq+nEdVTWqqv2PbMI4eYK1gkMXkEmG1lGKVSmZaWZrIR
jNkvhpHJZEuXLjXOj2CCsQ2JcdvV1tZiU1ZdXV1n95EFBQWJRKKMjAwcqY2FjnFQUVfqYLy3Dht4
TFIw2LE5Fy5cQAjJ5XKme20uHIe4IYTGjBkD/5sBAABCqtcYPVz+wfrN5/PSdx399XpJgUanRQg5
7p4+nHFKwBNeKyl48++vLopcev3mVYLmEETPRIP1fr/pdLrvv//eWBshhBISEpifTVTC6NGjR4wY
ga0aKpXqxIkTJEmabARzc3Nj9q/hnflxcXHLli1rz4vk6ekZGRmZmpqqUCguXryIA4AY6SaVSm3Y
jd/Y2IgbJZVK6+rqCgoK3NzcrARXsa+DUCj08PDAoUv19fVqtRqbvhihZq/m5ObmKpVKLNS62Fc6
nY6xnFnZOwkAAAgpoIeYHhgeIJ94LPXQwZR9tytvGQwGAhEOLacEfAFFU0fO7Ofx+I6bidQ2GFnA
KAMryTONEx94enrOmjVr586deCMYcz0oKMjYWJKVlZWXl7dr1661a9e2Z5cKDw93c3O7fv16Q0ND
fX29h4dHSEiIm5ubQqEwD6zukMTERKVSyeSfxDv8TeSOzXUQCoWrV682ljtpaWnY7sUU3vXm1NbW
pqWl4Q436TQbCk9LS8PZGayb5QAAACEF9BxOYucn5q0Mmxz5+6m4MzkplTV3aUQ7tAThEBwB/4HL
Q2giC3bu3KlWq0NDQ03sFq6urhYf9/LyYixPFk0dnp6ec+fOxTm48/PzzZN0M4wfP94kNzeOFnd3
d+9Ui9LT05VKZWBg4KJFixhhN3z48F27dmVlZVm3S9lQh6CgIK1Wm5qampWVFRERwajJrjSHSbkZ
HR1tMRl6pwrHnlapVBobGwv/cQEAYHkFhC7oLYZ6DXt11VufvPzXWSFRrs5uFEU5+lF9gEUYo4jF
FFPI0mZ744+wxau0tLRTL8Vb/fF+NPbk5OQgs0ggT09PvGWPSchkxzownzIutq40R6fTMSk32Sd6
aK/w3NxcnJ502bJlkK8cAAAQUn2UCaMDP331b39a/fbYUeMFfCFFOXaKBMCiGML+vtu3bxtfxxmn
jE+MsYKPjw/7N6pUquLiYolE0qmcBczuQnM6zCBgcx2YY2qsdALLonAi+Lq6ug6j49kUjjOemyR5
BwAAACHVF+FyuPPDF3399rYXlr8i8x5BEARN0yCn+hNYBhUWFhpv8cvLy0NGO+pVKlV6erqJ1So3
NxebaqwYY0y2Dep0uoMHD6rV6uDg4E7ZURjBZ2J50ul0165d63odcnNzS0pKTG67dOkSQkgulxsf
ZWNDc5jjdKyrKJaFg4oCAIA9ECPVV3BzGfjkgtVTx0+LP7n7/JW0+nt1jh449aAxbtw4sVhs0bIS
HByck5NDkuSvv/7q7++PELp27VpdXZ1MJps7dy6+p6amJjU1NTU1VS6X41zblZWVeNe9lf1iOp3u
73//O/NIY2MjjqkKCQkxialSqVQHDx7EP+OcSdeuXcMeQx8fH3zz5MmTmYOEmWNkmKq25yxjWYfC
wkKSJKVS6ahRo0QikVarLSgoUKvVEolk5syZnW2OCbh7EUIVFRU7d+40+RSnkGBZuE6nUygUCCGJ
RHLixAlzTczcnJ6ebuJyZfZsWk9aAQAACCmgu/B9SP7B8x+fyU4+kJx4raSgRdvs0Hv6HiiMN9yZ
G3tWrVp19uxZpVKZmpqKL5ocYOzr6xsdHV1YWKhUKpkThaVS6ZQpU6yE+wiFQrlcbvJIcHCwueyo
qakxiUOqq6tjfsb34yjsS5cuGRcokUhCQkKsJORkWYelS5eeO3euuLjYOFGWXC6Pjo42Pl6QZXNM
YJyPFmOtmpqa8LGGbAoXCoUSiUStVhv3D4Px5j58KJDxp8yvNTU1IKQA4AGBABdS30Sr0xw+s//g
mf1kxa02QxvIqf9OWYJoaKr/9s8/zp0+z7YSQldONP41c/eVHqu8SqXCoVEymaw9RxVzj6urK0u/
EstH2jt12LwmTIGMv89edcBqA9ekvU6woQestM6kgfbtK/ZdCgAACCmgF6iqqzyQnHjq/PGq2goa
IfD0ObqQAgAAAPoZ4Nrr0wyWer+4/NXpgWGHz+7PuJzeeL+BQ3DANAUAAAAAIKQAtkwcOyXAb2JS
5sn447+V3i3VtWoJAjx9YEkFAAAAQEgB7OBwuNHhC4MnTDtwem/yecWdilsGigI5BQAAAAC9vEBD
FzgQ7q4ea5e9+NfXv35kzuOe7l4UTVE0JEMHAAAAABBSAGuGDxn59rMfvL/+4/CJM5zEAyAZOgAA
AAD0FuDac1SmBYRNGhN0Mv3o78kJpWSJXq8HTx8AAAAAgJAC2CIUCB+Z/djUgOkHT+9LPn+yvJok
aILgEAR6EOQUSEYAAACg9wHXnsPjLR3yYuyrH7/819lT5w50dYfAKQAAAAAAIQV0jvG+AZ+99ve3
nnl/ot8UIV9IUQYInAIAAACA7gZce/1IFHM4s0PmBo0POXb24NHUg7cqywwGA5wtAwAAAADduPhC
F/QzXJxcVixc/cUb/1gW9cQg98E0TVMUePqABxorx/ABAAB0EbBI9U+GDX5o49PvhU2asU8Rf+XG
pfsaFQfB2TJAv9JGKpWqqakJIeTl5eXi4tLenYmJiUqlMjo6OigoqBcrTJKkSCRifwYzAAAgpIDe
Z1pA2ES/KSfSjhw883vp7eI2Q1s/SZEA4V8PMLm5uWVlZUql0viiRCIZNmzYpEmTfH19Te7XaDQI
Ia1W24t1LikpSUhIQAi9+eabQqEQBhEAQEgBDoNIKHo0KiZ0UsQ+RVxqbgpZdYeiDASHQ0D6AMDR
IEny+PHjdXV1EolELpd7e3szH5WWliqVSqVSGRISEhUVBX0FAAAIKcCeDPIYvOHJ16NC5+06+uul
a9l1jXUEQXAIh46QAyH4YJGbm6tQKCQSiUUnXXh4eElJSWZmZlZWFkKor2kpX1/f1atXi0QiMEcB
QP8Dgs0fIPxGjN388hdvP7tpythgkUAEZ8sAjkJtbW1aWppEIlm1alV7oU6+vr5Lly6VSCRZWVm1
tbV9rQkymQwCpACgXwIWqQeOyODZk8YFHU89dDT1UGn5TYoyPDDJ0O2PTqc7fPiwt7d3eHj41atX
r1+/rtFoxGLx2LFjx48fb3wnjuyJjo4WCoVpaWkVFRUIIXd39xkzZpgHSuObcXDPkCFDIiIiGEuG
TqcrKCgoLCzEv4rFYouBQbm5ucw9Q4YMEYlE+Ofw8HDmnpKSkhs3bjQ0NOBfx40bN2HCBGOTCS5k
6dKlCKFz587hO318fHAhOp0uJyentLQUXwwODjY3t3T4ig7bizl79qxarY6NjcVapKSk5PLlyxqN
xt3dfe7cuQUFBVVVVYsWLXJxcZkwYUJWVtbt27c7VC3MeOGBGDNmjHk3mvS2+W0sJwC+beDAgSam
sg7LZzOaxnVIT0/HI7J06VI8r9i8ghlo46moUqkOHjzIDHdn57A5KpUqOzsbP2Xxb6QHJiQAgJAC
7IOLk8vyBU+FTZ6RcGJ3xuVzFbXlBOJwOGCe7DQkSSqVSo1Go9VqsVMJo1QqtVqtse2ksLCQJMmR
I0empaWp1Wrm8eLi4lWrVjGrPl4UcSS1VCqtq6sjSbKgoGDt2rUuLi4kSe7bt0+tVkskEg8PD41G
gytg4u3C+9SkUqlYLNZoNMYVY1aX5ORkfB3fRpIkSZIXL15csWIFsyjiOiuVSpM6a7VaPz8/HK7E
XCwtLV29erVx57B5hfX2MuurUqkMDAzEyz/28WEbT15eHrPuYkaMGJGVlVVWVmZ9jx6uG+5GhFBe
Xl5eXp5JN9bW1u7atQs3XCaT1dfXkySZl5cXGRnJaAuWEwDfhhAy1ohsymczmhbrUFNT4+LiwvIV
eKDxI8zFmpoakiSNxTfLOWyR3Nxc5impVIrrXFVVxSjLHpiQAABCCrAzssHD33zmzzOD5+w6+u/r
pflN95uQ4wRO9SkDGv5PPzo6esKECQihnJyc1NTUtLQ087VcoVDIZLJVq1a5uLjodLqDBw+SJHn2
7NmYmBh8Q05OjlKplMlk8+fP9/T0xOaEtLQ0ZpEz2ZuGVcXFixeZd+Xm5iqVSrlcvmTJEmPNhKuH
r6Snp2MZsXjxYlxUbW3tiRMnSJJUKBRMZczrTJJkQkJCVlZWQUGBh4fH6tWrvby8ampq9u3bR5Jk
bm4uUw2Wr+iwvQihGzduIIQCAwNxIThS6vHHH5fJZIyyxJ8yYDtTe+C6yWSy2NhY3CG4HIVCMXz4
cCwIdDodliAhISFTp07FlcG9nZqaOnjwYGOjDvsJYGyLYlM+m9E0rwNJkjKZrFNNYE+Hc9hiY7H0
YapdW1ublZWFrVM9MyEBoPsAI8SDTtD4kC83/uOVJ98c6+PP5wkgcMo2sDFDKBQKhcLw8HCpVKpW
q0tKSkzFq0yG/VNCodDFxWX+/PnYeoG/+uM1GCEUGhqKl3OhUBgUFPTSSy/h1UUmk8XExBivf3jl
rqurU6lU+EpZWRlCaOzYscwq6+fnh7/NM1fwW5hFCyHk6emJPSbGlTGvs6+vr1wuRwhJJJLY2FiZ
TCYUCmUyGa6GcYoBlq+w3l5McXGxVCqVyWTYdIQtMfhXmUwWHByMEBo8eDD7wcIvnT9/PtMhTBOK
iorwlYKCArVaLZfLo6KiGEkXFBQUEhKCELp8+bJtE4CBZflsRpMhJCQE18HX11coFHa2CWy/gHU0
h600FlcPT4ZFixbFxsb22IQEABBSQDci4AsWzVz65ZvfPv/4S8OHjKARJEPvNPg/bgaxWGzxNh8f
H+P1z9PTEwuC6upqhFBJSYlarZZKpSamAiuhHnjZQAjV1NQYG2OYMBqTn628xcXFBRd1+/ZtK3XG
SQf8/f2NL7q5uSGEcHgK+1ewaS9Jkmq12t3dHf+KbRgBAQHMDXixxBVgGDJkiBXzoVqtNg/9HjFi
hHETcFDRyJEjTR7HtymVSpNs6SwnAAPL8jscTWMiIiJseEVnsT6HO9VYXE4PTEgA6FbAtQf88R/i
QK+nljw7NWB63LHfcgrO1zfVI4QgcKpnwGqgsbGRzRp89erVqqoqxi1SX19v/Om4ceNIkqyqqmKW
JWxlYbSIlbf4+PhYsStYwUTHsHwFm/bixR4vljqdjiRJqVRqHMqD+wGvuAihqqoq8/qYF1hfX79z
504r78UKxrwc5kVdhGX5HY5mLzbB4hzuVE16bEICAAgpoOfwGzH2wxc/PZOddOB0YmHJVbVWTRCI
IEBO9Zycsq4qEhISSJJkoqTNGT58OEIoNTW1srLS29u7sbExLy9PIpHMmDGD5Vt6oCHsb8OrbHvG
Hp1OV19fL5VKGWsENkLgTrCCRCLx8fExX7bxAqzT6Ziw5e6AffkdjmbXX9HddFgTcMABIKSA/gaH
w5kzLTokIPRE+tGDyfvK7pZQFAUpEroV7K/p8Gt0UlISSZKBgYFz585lpMPOnTuZHUzojyiiwMDA
4uJivFNMLpfPnDmTseJYCScyVy22wfIVbMwG5qssY4HD+/PxHkZ8JTc3F/dPh7kPxGKx8bY1E7DD
FG8HM/mIiUXrCuzL73A0e6sJ7c1hKzXp4mwBABBSgIPhLBkQ8/CKaQGhB5MTU7KTK+ruEjQBnr4u
YrKqqVQqvMAMGjQIIeTq6ooQIklSpVJZXCnxVv8xY8ZYiZoqKCiQSqWLFi1Cf7ixTG628pa7d++y
Med0CMtXdNhek+VZKBTK5XKlUrlz5053d/fi4mIPD4/AwMC8vLzExESEkFKp7NBaw+alCCF3d3fs
UzPJdYTjdeRyeRdzFLEsv8PR7PorjO80jlJqT8RYn8PtyVaE0K1btyzuE+yBCQkA3Wt9gC4ArCAb
PPyVVW9+sP7jyMmzXZxdDAZDH9nT56AbC7OysnJzc5lf8/PzEULMljSZTCaVShFC2dnZzD06ne7o
0aPGX+iNVzJsgzF+hUQiqaurO3r0aHp6Ot4SX1JSYpzp29PTE290Mn4LQig9Pb2uro6pTFdg+Qo2
7cVWq8rKSvzrzJkz5XI5SZJ3794NDg6OjY2dO3cuVlfl5eWBgYHGCag6VTeEUG1tLRN/PWbMGKxj
jLtOpVKlpaUhS3HTnYVl+R2OZtdfwdiEjEOzmWRdnZ3DCKGSkpKdO3emp6cz9+B3mdTk6tWrR48e
7ZkJCQBgkQJ6mSn+IQF+k5POn9yflKC8dV3X1sohOATRm54+B/UySiQShUJRVlbm7e1dWVmJnTVh
YWHMDWFhYYcOHcrKyrp37563t7dWq8Vbx3GeJBx7m5SUpNVqRSLRrVu3cMSMsWtvwYIFO3fuxC4h
Y4xzEc2cObO8vBwn8sGhQrgyEolk2bJldmkpy1dYby9CyNfXVyKRKJVKbK7w9PSMiYnR6XTGhhnz
Kyzrhl+KL+LqxcbGYquJr69vSEhIVlbWrl27Ro8e7ebmxtQNZxnoYv+wLJ/NaHbxFbi0tLQ0kiR3
7tzp4+ODI7Gwqc+GOXz58mWs+Zjsr0FBQTiX5q5duyZMmCASifCDWD/1zIQEABBSQC/D5/EXRCwO
mTB936n4lOyk2xVlNEVD4BReJyQSicmS1t5ONJz0KDU1lcnlHRYWZux5wT9nZGQolUrmnrlz5+Iv
5eHh4Th7NbYW4BN8tVptamoqUwG8qyskJATvckcINTY2FhYWKpXKpKQk7CTy9PRctWrV2bNnjZP0
4OAb4+gi3Aor++1NMG41y1dYby8Gn/py7tw5XHlkyb1lRVKYt8K4bviluDMDAwON3xsVFSUSiXJy
chg9IZFITHKCs5wAFm9jUz6b0WyvDixfgRBycXFZtWrV/v37sQDC9wQHB1sUUh3OYW9vb5xk1bg+
sbGxSUlJeXl5TO51HOrXqdnSlQkJAN34xR6yLwKd5SZZnHBid8aVtLp7NQTq6cApgiAaGuu2vv9z
1PRo20oIXTnR+NfM3Ve6Up/2bCEm13fu3EmSJF7DVCpVTU0NkwLKIiRJ6nQ6V1dX87hp/Dg2OZi8
CxsVZDKZyeEYtbW1P/74I0LozTffNK4VU5SXl5dFj5jF1rG/yOYVHbaX2asok8lCQ0PN42xw9LSV
wjusm8X3mtStvfFiOQGs2MzaK5/9aHZokLPeBJPbzOdVZ+dwhx1uIrN6ckICAFikgN5nlGz0n5//
y5ns5N+T4gtvXmvRNnNQL3v6et0oxf46XvI73HVlZcEzf9z4SGOLjzQ1NVlcvTqsicVWsL/IsrHW
2ysUCmNjY/GRfAkJCSapHzQaTV1dnbmVpWfqxn4CWJkP7ZXPfjQ7VAwsw4xMbrN5Dtvc4T0wIQEA
hBTQV5g1NWrqhOkn048eOrP/Jqk06PUE8eDKqT4CswEqPT19+PDhXl5eKpXq9u3bOL548uTJjqtW
Y2JiSJIsKiqqqKior6/HYWFYVIWEhBjnOofRBAAAhBTgGDiJnR6bGzstIPRgyr7TF07drSnvqRQJ
hMPu2+tePD09o6Oj09LSUlNTja/jaCqTbfAOh0wmY0wmnc0FAKMJAEB3LUgQIwXYhbwbl+IVuy5f
y22834gIxOm2ZOgEQTQ01n/7/o9zp8+zrQT7xkixpKSkpKqqKiAggI0vyV6vwz8PHjzYYv4ewFHo
I6PZw3MYAEBIAQ8cbfq2E2lHTpw7XFhWqNVpuilFgoMKKQAAAKBfAq49wG7wefwls5bNCJp1MHnf
iYyjkCIBAAAA6PdAZnPAzrgNGLjm0ec+e/VvS2c/7unuRdM0RVHQLQAAAAAIKQBgi+9D8nfXffjO
s5uC/adJRBIDZQAnMgAAAND/ANce0I2ET4mcNC7oZPrRY6kHi8pu6Ck9B1IkAAAAACCkAIAlOEVC
2KQZiYo9qbkp5ZV3aILoauAUKDEAAACgbwCuPaAnGCz1fmXlxo9e+r+ZU6MGurhTFEXREDgFAAAA
gJACANZMGB346Wt/+9NTb00aM0UoEFEUZWPgFERbAQAAAH0DcO0BPTvhuLzo8IVTA6YfTT14Mu1Y
2d2bBsoAgVMAAAAACCkAYMtAF/enFj87PTD896SEzMvnquqqCKIzZ8sQCKxSAAAAQF8AXHtAr+H7
kPydtZvee+4v0yeGSyROBspAQ+AUAAAA4FCARQroZaYFhgWOmXz6wqn9SQlFt2/o9W3g6QMAAABA
SAEAW8RC8aLIR4L8p+5LSkjLPX274hZNExwOAXkOAAAAgD4OuPaAvsJgqffLK/70lw2fzw1d4O7q
QdGUtbNlIEQKAAAAACEFACaM9Rn/lw3/96fVb40fHSgSiikazpYBAAAA+i7g2gP6HFwO9+HQBcHj
pyVfUBw6/XsxWYQoBIFTAAAAAAgpAGDLQBf3mIdXTPSbvC8pPivvfGXtXUQgLocLPQMAAAD0HcC1
B/RpRg/3e2/dR39+7qPwKZEDJC4GgwHOlgEAAAD6DmCRAhyAqQHTA/wmnslO/v1UfPFtpcFAUQjk
FAAAAABCCgDYIRKK50csnuI/9WDK77sP/wJmKQAAAACEFAB0Di/3Qc8sfY7P5bk6u0BvAAAAACCk
AKBz8Hn8Zx59HvoBAAAA6AtAsDkAAAAAAAAIKQAAAAAAABBSAAAAAAAAIKQAAAAAAABASAEAAAAA
AAAgpAAAAAAAAEBIAQAAAAAAgJACAAAAAAAAIQUAAAAAAABCCgAAAAAAAAAhBQAAAAAAAEIKAAAA
AAAAhBQAAAAAAAAIKQAAAAAAgAcbgqZp6AUAAAAAAAAbAIsUAAAAAAAACCkAAAAAAAAQUgAAAAAA
ACCkAAAAAAAAQEgBAAAAAAAAIKQAAAAAAABASAEAAAAAAICQAgAAAAAAACEFAAAAAAAAQgoAAAAA
AAAAIQUAAAAAANBt/P8AMDRLL4DD6MYAAAAASUVORK5CYII=

--_005_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_--

--_006_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_
Content-Type: application/gzip; name="wifi-bug-report.tar.gz"
Content-Description: wifi-bug-report.tar.gz
Content-Disposition: attachment; filename="wifi-bug-report.tar.gz";
	size=35767; creation-date="Sat, 20 Dec 2025 15:15:51 GMT";
	modification-date="Sat, 20 Dec 2025 15:16:03 GMT"
Content-Transfer-Encoding: base64

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
BiIK18BhrY/BYDAYDAaDwfiP+AVBcYDIAFgCAA==

--_006_KL1PR0401MB6441C2A3E3EDDCBFC3AA02BAB1B6AKL1PR0401MB6441_--

