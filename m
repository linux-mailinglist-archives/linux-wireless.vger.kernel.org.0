Return-Path: <linux-wireless+bounces-11509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1DB954135
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 07:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0EF1F21D10
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 05:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4011477107;
	Fri, 16 Aug 2024 05:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oMTSgH5z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFCA28DC1;
	Fri, 16 Aug 2024 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786354; cv=fail; b=ZwaRHaVpBau3x+QmSBAdDfLZR7bBNxDl4SsLqwYxFKa3Lz5UGhI2zXtgryJT6GcwO4Yd1D+mUnI5maDX6pq3bOVfZElbNeQwfrqcM8P2dDZ6EZDGsuHHGN+SY8SvB4lkz1xbMTBIwDjQ23X/zsvCY5aZ7UVHkEWgB2qaHhttLAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786354; c=relaxed/simple;
	bh=Yp87BxVTTCrbv1OnRnBxKZ2zK8EYH0wKMF5SEzWkSuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKVaqKqOrQh3IdHCc6d4Umr8zx9/9CCxZKdXokKohHRmUfElv40MLqxjX+qdlztmqwz39xqH2eG6V1GZ3i0rsKS+ftyHmkSdiq4rrPI3pJpFf+ZTLcDfXlB0OUVxodByW3P3oPplgvF3610ABZGRtnyJD/cAH6jc90LYZYL5hhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oMTSgH5z; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHRRjmgeN9pOr51XnsJcTDxQNxS5yYNqqbaLXhUGQIjoZlWh3UmdNysZf9x53Q3CCpxHITsafOC3VrtlNyj2m6bCqk7oYSAE4VLv2iuSfkrC+WA4BrKOylFd2+VshCDk9hXNxfjZrSmiU5bN6A0hn9L81a6twCCUd3aC919KYSQkbj2x0xWvtdppNU+SqPY97g4FVty5ZAHiPcj9DIakPOkg1wjfJBK465/5yXLW6BlD7uJLCIJ5cSrf7Qb9i6ubtbmbZkFyWiVwtX+FubFIgwO/1DT1R4PAVuRmczS4UMRvPLAdR4lLvc83Hfhffxo4ufdvNHxWU/BPP84uBqO4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp87BxVTTCrbv1OnRnBxKZ2zK8EYH0wKMF5SEzWkSuw=;
 b=a4pFpqhwymXJtlF28jdQFq0zJ9oGNVeqd09cAtya7Q9RItmU+xsWS/w1Q4TXdrrLdl5eyVT9ZRu4A8+NhXwyh+Ps91aLsHwXeEJu12agyc4erc0VElESqXgm9Voh1gxsHHjx3qxXVf/WiCafH6fWQioKpEaeR5esyhr54sY0SFTWnigqJJbPddUowuctb7vNPJThv0WVNlKPVYf5X7Tfg/+vEun6GZzHsskRNTOPwGHnh0Xmo+q7h6aeFs3rNyJSpVIE3HxFouOA4DdQyAn/mSe/+9yvFeaRQjNjTTwLmWIcFKgw8K09UXfOJcp4mFqEpSWF9KvrEObUk34FBrEhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp87BxVTTCrbv1OnRnBxKZ2zK8EYH0wKMF5SEzWkSuw=;
 b=oMTSgH5ze8f3Gf8TDdtwB6zGdvbMZnwEDiAUOiGpxtQ14m8JR8B8aWjR9Jf3bmAqVcdTgFoVwxR3dhNo6AjglCOqNpOj2Kd2tLwLpcFVkU0fzc0zsmHURY9o8HzccOPlr0IH9im99bo8RdqAeJ4dezqLIAXfdnup36e+zq+5hkVoMSl7JB3xD0zzpP39X9Zg9n7VWjx9S8qyH9i+/yeqne1D+llfV188MjWlkx2E6HjPekpmK89Rkokf+nGQ3TmJHGse9SnJjKyKCpy4Jl9Qa64ZZ5TKhBE7y1sGiyh03lx1PkevueSyhang1mEDiJnNUR4g8gRcwMmqEckaW0Chew==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8141.eurprd04.prod.outlook.com (2603:10a6:102:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 05:32:27 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 05:32:27 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHa6kDq7zFfRJGOz0Wel62W8Sr8T7ImJDCQgAH0TSuAAUy9AA==
Date: Fri, 16 Aug 2024 05:32:27 +0000
Message-ID:
 <PA4PR04MB9638824370878CB3BC426DBAD1812@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
	<PA4PR04MB963858E759C8F61402B2275AD1872@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <87frr6yvq0.fsf@kernel.org>
In-Reply-To: <87frr6yvq0.fsf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB8141:EE_
x-ms-office365-filtering-correlation-id: c6f90ba3-1f03-4dba-39fc-08dcbdb4d0c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XJM4d6jFx9ETa53/Sdbao7SSoKzXVBWQp9kc1TcHvasPN2Y4IRWAsvoFdCp2?=
 =?us-ascii?Q?04fLAO1R8MIAiOMSgEPrmTO0ZulgdZfKjBz3T2BSR2AwdzaCbBJkaZYWXioH?=
 =?us-ascii?Q?PyEqYFfPbJzeCuz7DJAeuBGv2WjUFdNiLscBah67bn7K0Gi482lhfUcYytrF?=
 =?us-ascii?Q?6yOKST+wQjQeC3m8kohdVSHln8RIxtMuicea2wiYZiXPqRGpJORJG+o3prmG?=
 =?us-ascii?Q?MqoFGHgBPG+YRAvkVUJxcWJ6fPwRdg9gitvcox5XxQjIpmyrvZ+dpxcrZ70c?=
 =?us-ascii?Q?2gO6i9WvLhhXhJ4w/1gMHW4zE+hTaXvljwC/tM1V/C9dVj1tSTMqv2UZ6jz1?=
 =?us-ascii?Q?fDWENd4JtalNacT8pcyp9RwflTKIDmLGaxQk7MmAZrOvcy0iS5TFNBmmpRZX?=
 =?us-ascii?Q?fau9f15TPmpczrt5p2/iwGEluv4Xm/yUzi4QHtQZFwaN4zjGEm4S/dnjTl2W?=
 =?us-ascii?Q?OHEzHMYBlG7Ie14qLVMm/p1OL842e58lnM1Rmdm2C5lcUaWC/429ix1vwe5I?=
 =?us-ascii?Q?LgUG/niGMMEs+gZg2hZeaqLuIajMTEFXPw3oqtcPrnUoBLp0kIjSU+0OLDhy?=
 =?us-ascii?Q?5ys0UKTcQntJJkFnH8u3nKjb5V7BICIfgJX5JQohdH0LScGeFdoEArxZC8zk?=
 =?us-ascii?Q?+LaqoKO/Il+jjXW5BzAqtc01DaHEydUGyFIzOkcvVtsRn+w5sdYM6+XVAHPU?=
 =?us-ascii?Q?NVt6YMFlkPtj56vNZUCpdzAT5QgZ8EhhHN5736mjZZhSFUEEqdxNTOti/GlL?=
 =?us-ascii?Q?+EBhb+KgOom8oEZifaMAqfupD3Pvc25DU8xbFdbN9aiGrkB/FdMI3DWcIT3x?=
 =?us-ascii?Q?4NQv0d39zHj7R+WIdJTWp6L1eqtl2fFX/ZAN9Tc6nuafucvZ0v5D4N0aL8aP?=
 =?us-ascii?Q?7FCWWpNnI4B/el0TVtdAjUj5ugtj+5jixwlHOMcjbTEKTIvWdicfR4gn331T?=
 =?us-ascii?Q?IbpEYtWRZc75bpF5Ml/m9OwKqR3UlxAvR2W9VQJo49/xwLCRue15pDAz4q9+?=
 =?us-ascii?Q?4zJON5hehoXtPhcVsyjYeI0dx9uTrox/19tdRjVbxTIAsu8Jisaum/mi2UEp?=
 =?us-ascii?Q?/QDeotD7TQxXqwX7ur5CGUCq1ZRjuzoFoOIeOpf0B7gNr8adfR8uwUHExQVa?=
 =?us-ascii?Q?1yAR9uQYTPH5z29L/g6fl1WwYrxZ+8dNbqkA9gA0Ks2qOGNBjaZ4kUW2URuW?=
 =?us-ascii?Q?CX/kW8YtaifVnoKSswNpZJqWthMHmiX6kaMkFqm0nw44vv1prX2j367ufot0?=
 =?us-ascii?Q?A/nCUzjUDj+5X3r/08ZTSaqyRlCNWjZke4kGG0jujOIZjGhaj9eMT4/ehxRe?=
 =?us-ascii?Q?5kTSKZhyULY6AzgkSL63A4HqESlKwIFLhF7tBKyjqMs+nkaR54y+6naNt9by?=
 =?us-ascii?Q?bMnd86OwlczpVp1656XrS5gvEhGWtSDgXIgYZKDeqJEUK4howg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s4zN0a+Jzeuj7goy02ra6/eviw86jmJWTRo9XICRYVMLbF0tj1CfjMWaEh/P?=
 =?us-ascii?Q?NUMKzG5PpqxwY/wINxrPYXIr73YBOuyju5IoZ3ZEfeCE1TT5P2Nsf+T6jTpC?=
 =?us-ascii?Q?cGk0Mnm7gzwGnCkjM6hNmnxdpk1sacOf4hsivEwxkUelk8Rwlys5F10NFlwq?=
 =?us-ascii?Q?Srj08EkIVA6emFdLcoQ5zHfC5x3ET/CLbDCj0XS+sLTgCun72IaSONTMSumw?=
 =?us-ascii?Q?3LQbtvGqRFrCtcSn9IWTmDhPOlWDBgYGiBXQsiJ58dxqLvaXvFN9Qv/QnRbz?=
 =?us-ascii?Q?x25wUmSRJEd1LaXy4PK4rrqK/uwibrakUAebKJDBMqYbfGU+2HvRC7ardXTf?=
 =?us-ascii?Q?Y+KEkkLUD4IHLnf2Ws5X1L1Su8ARtA4W+s6vH+GcfKMO8PoQVBW1pLXVsQC9?=
 =?us-ascii?Q?8msiDZlfi7rjoH7xVUKzsu9sQuEifzLBIfp+DLClkzp673OnrPmNZCyydwex?=
 =?us-ascii?Q?A0cegTpOT2ueGPaNwyZzoaJUQDJfMvlDbC4w/5WfREgtO7Rgy6Qq1DCNM2/Z?=
 =?us-ascii?Q?B1HXXKqjMWKSDbbgIy5sCDB8nyjNN4n0lU7MooysXXhfvGUQI+SYDbH+xI1f?=
 =?us-ascii?Q?40Ou9iiJ/4zf1bGonV/jdLA+621dvaCcxSHy11XxxqkZLJ34bvpwRfjijUb/?=
 =?us-ascii?Q?JFKTphYOn92OvvWr4PBmFWn7Y6ZV4npFFBYgubU90fQ6+h5MCnCqVjbdLQc6?=
 =?us-ascii?Q?fUe2nbClF1eSCTeHFNGVy9nwA2ihCX3iHoW9asBeMDGJF0o5QoAg8jAGyE1d?=
 =?us-ascii?Q?rjgdzJVV8FKWJ3ePiak9RVWVnsLYhfAI4FhDarMJeI8exqy+3JnXVIw9CXS4?=
 =?us-ascii?Q?ecJHRKKa8DXXH9L3UjqHPuqre5KHwJ2qaweN48F0BxbW0vQ/1aib7uqu7I5W?=
 =?us-ascii?Q?cup1Q/Vj/63k+11KXn5rZbYHqbc+mRb8+eNYk3jrhmzsCgCLyW9bQaaGGPl6?=
 =?us-ascii?Q?iICHV+awIEnvCQ1ZlKoqA9Z+82yDUev5cRVjGPZPWuFamffK7u+jaY5T4Hp9?=
 =?us-ascii?Q?kHYlB+EE3bfwaNq0qGNUs7vldiAFTfKCY5bk6dcRhLCngY9a45MoSRKzgtZv?=
 =?us-ascii?Q?rnMxXBTV4W1wXBtzmKEPcHepGPgbBCqf8Oe+4N81Jedsxs9w6BcYnwkgMb8l?=
 =?us-ascii?Q?DXKYrTGIRp93VWnD3ju4Vz/CqbYJimq/Is5RLbtvoeBv6iIzPQ5hv2u7okgz?=
 =?us-ascii?Q?Cwe9MaKi7Z2aaP3OZz6gIhjGBshZO9h04dh+ACfX/fpbHfO4uIKLxjUYHB1V?=
 =?us-ascii?Q?PYmEdPAYITOINAzfWTrPVwZ9fFU4l3NySnqA3TI6isTuOMVUNCyKjrAMD6fo?=
 =?us-ascii?Q?L3DD7gzUhPqJHzgXbPpNX2VCRZEYldMBp4m6EFmq5oFPZBR9k+uJuZOTosxN?=
 =?us-ascii?Q?LnLGWm80bzwzXNbI1RHUrHGpniMTkJS9eZgkwnwXxB044TrbcP3eUzY4Nv9q?=
 =?us-ascii?Q?eX6C0SuYtdVeyCm5swbL2PHK0/VhH2jIhA4oowr0tzlaOc6i5CXknkZdfTZ0?=
 =?us-ascii?Q?0NT4eqtfxztByW3VHF87ZcxAGF3LrgIpMOcvgCbBOQhR+cBi9cfStNdxSKTS?=
 =?us-ascii?Q?Rse1y8ZWnFeD7Os0Z6x5nWBT2ga5NWVH755YHc45?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f90ba3-1f03-4dba-39fc-08dcbdb4d0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 05:32:27.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7afjgVTo+3enJ7IoNYoDwm+D4KIEv3I84tk1mbO4wFAP4woLnjMJy6PJ8Uv9UXTm2/SuuTZ4Q7g9r2+wYrK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8141

> From: Kalle Valo <kvalo@kernel.org>
> Sent: Thursday, August 15, 2024 5:36 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> johannes@sipsolutions.net; briannorris@chromium.org;
> francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to supp=
ort
> iw61x
>=20
> David Lin <yu-hao.lin@nxp.com> writes:
>=20
> > I found Nxpwifi patch v2 is put in "Deferred" state quickly.
>=20
> The way I use patchwork states is described here:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
es
> s.wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fsubmittingpatch
> es%23checking_state_of_patches_from_patchwork&data=3D05%7C02%7Cyu-ha
> o.lin%40nxp.com%7C8d360234b61d4e2c13e108dcbd0da0a4%7C686ea1d3bc
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C638593113436356863%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D1XA1Ax66zhnU72efN0wAghLJ
> %2F3DR1%2B8PAxXkiHphA%2FY%3D&reserved=3D0
>=20
> Basically I try to follow the "Inbox Zero" method and keep the amount of
> patches in New state (my "inbox") low and the Deferred state is my todo l=
ist.
>=20
> > Patch v2 is mainly to address the comments from Johannes and it
> > actually took quite some efforts. We understand there are areas to
> > improve and we are committed to continue enhance/maintain the driver.
> >
> > Could you let me know your plan for reviewing Nxpwifi?
>=20
> Reviewing new drivers take a lot of time, at the moment I'm following wha=
t
> other reviewers say before I'll look at it myself. The process is so slow=
 and
> patience is needed.

Understood.

>=20
> The last thing I want to see that once the driver is accepted NXP disappe=
ars
> and we end up having an unmaintained driver. Way too many companies do
> that.
>=20

Yes, we are committed to maintaining nxpwifi.

> > Is there anything we can do to move this forward?
>=20
> Yes, get involved with the community and help us, don't just expect that =
we
> do everything for you gratis. Especially helping Brian with mwifiex
> review/testing helps us (we get a better driver) and also helps you (you =
learn
> how the community works and you gain trust in the community).
>=20

Yes, we will continue to help to maintain mwifiex, also we will like to inv=
olve and learn how
the community works.

> An excellent example is Realtek. Few years back Realtek was not involved
> with upstream development at all. But now Ping is doing an awesome job
> with maintaining ALL Realtek drivers, including the old drivers, and I ev=
en
> trust him so much that I pull directly from this tree. This is what NXP s=
hould
> aim for.
>=20
> --
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.kernel.org%2Fproject%2Flinux-wireless%2Flist%2F&data=3D05%7C02%7Cyu-
> hao.lin%40nxp.com%7C8d360234b61d4e2c13e108dcbd0da0a4%7C686ea1d3
> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638593113436367796%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D4ly%2Bien1%2FscxRSdEdN0C
> hvRMH%2Bh8kbYfEKbjxWyqodw%3D&reserved=3D0
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
es
> s.wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fsubmittingpatch
> es&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C8d360234b61d4e2c13e108
> dcbd0da0a4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638593
> 113436374405%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Dva
> i2UN%2BKu2I5wKfmUoL8LEk7qBXmIuIK0eB4rtwoRDs%3D&reserved=3D0

Thanks for the information.

Thanks,
David

