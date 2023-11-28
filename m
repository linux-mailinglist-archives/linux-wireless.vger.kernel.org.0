Return-Path: <linux-wireless+bounces-174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48687FC46D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 20:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29625B2150B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A97046BBE;
	Tue, 28 Nov 2023 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eb8Ib6Up"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2072.outbound.protection.outlook.com [40.92.15.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E210F0
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 11:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOPtkXWQ+uGHajV2k39gfcaIEiwYlLvlYKJD79cAp7UxwiH0oIKzdrcn4dxDsrBCpdrPfitKuWeGg94Okp4/ssFcrav0j2uwxJTWbbPxwY4F4pS0ExBfrr70pE2EstrenpaBdczAK0NNEXsTwX6fspdoTRpiGy8Xr4CAu+59EHoAGqfMh5YdBjFaKpnvWe/WS9I0pXQBoAPH5mCc+SjRohlq0MPcr7E3oHeMPhOJ4Ku45qGQgu0RYSaFiX9jm64ZZdlJ6qW0lRHsSP+XFYgbCBuurKswfgwhd2jnWGUkL8krxyo6229c4d6MTYb+B8CKciFfKs1qWXVfvre7j2/J4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSSJLwcaGzRw+qIFY/LlzrQFma0xS6yW7T13zFHfSlU=;
 b=NM6d/RTuTco2XNNQfjQvPmnQDs42m5NWO3Kv+MMOTaoSEAMu4Bz3kOsbbLmxqdlktxJAhO/yIRqYPUSnqjWRg8psYRJhf2pDWvrZr7pUHkgZIAv2WA2rZ3xvrv5KIcd8V7jJHujkF9fp9fLy6aXjDIT+C5+DHMmxD58Jafr8/gVZw/XfbLW9Tt/zmEdEZ1Rnn3vzP9gNbTECP7ZjIDcSJUgnpFPagDOS4xN2I1hdHmCBEO1goMAgcSe5DrojcxWCnksEHhIi7Cov6xWtie6BXP7WA4GVuLknha6BIN1VSBam9F38fE2sO2U9nzxmpyG0AaVZimHTq9RDsiccQlpsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSSJLwcaGzRw+qIFY/LlzrQFma0xS6yW7T13zFHfSlU=;
 b=eb8Ib6Up+Iy/+tSl3GNNtYSp6CwN3E6L7BEOg3LFj1NitPU7aC41cK0zuuE+umezfZvhPNngcu+IqhQtUA5Td8Vt5L+XjK5bwuYkvSTagbxXgFbGiwjmH8U+EaSc2KPUiBAZBVQ9+pZfBMXQOUJEtNwEgPZJjOBF4jsnG7S1lowfQHi1x53c+xZ/U4ozqIFLot2MDBc/C2JhdY+c9+sQypj2scYZ1tFmVDuTt4UFZcmSnWd5h6SdwvUH+DfvEOeCIid8lK9i18Tw3qazP9wS6l9unFLtzhKHQJ2qy+L1LXBVNBCvDOtShkcxFwTIoia/uP7B0Vu44cDNg+2M8HZprw==
Received: from IA1PR20MB5049.namprd20.prod.outlook.com (2603:10b6:208:3a7::16)
 by BL1PR20MB4633.namprd20.prod.outlook.com (2603:10b6:208:390::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 19:49:34 +0000
Received: from IA1PR20MB5049.namprd20.prod.outlook.com
 ([fe80::6d06:82ec:16e5:ede5]) by IA1PR20MB5049.namprd20.prod.outlook.com
 ([fe80::6d06:82ec:16e5:ede5%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 19:49:34 +0000
From: Jay Sweat <jjsweat@outlook.com>
To: Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Realtek 8822ce p2p support
Thread-Topic: Realtek 8822ce p2p support
Thread-Index: AQHaHJ6/35nL8BzLVE+iP+/w63/TCrCFjBhAgAEOZs2AAHCucIAJI5ta
Date: Tue, 28 Nov 2023 19:49:34 +0000
Message-ID:
 <IA1PR20MB50496D7A5578AC9DC1AE7370A8BCA@IA1PR20MB5049.namprd20.prod.outlook.com>
References:
 <IA1PR20MB5049CDB1D4CBA0FD5B68F15DA8BBA@IA1PR20MB5049.namprd20.prod.outlook.com>
 <16c31bac7aaf4c20917f500d6d2a52c2@realtek.com>
 <IA1PR20MB50490BFFD9F797722C9688BAA8BAA@IA1PR20MB5049.namprd20.prod.outlook.com>
 <5ffd01e6c8a1464795d612de1c6fa8a4@realtek.com>
In-Reply-To: <5ffd01e6c8a1464795d612de1c6fa8a4@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [xGaPa7px4cYb+YfTYo6+TGcSuQJNeCQbQSn0HfDUIxZwiNkJz1mPpq+N336KolIAJfk5qV0IVhI=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR20MB5049:EE_|BL1PR20MB4633:EE_
x-ms-office365-filtering-correlation-id: 068392ca-de3b-4dc5-b571-08dbf04b254f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xWhf3DoOfg9fdpvZ7j+qwzGqXtQNNTFWDgdD7eYPJfNOrP2awSidbvRLQucCRntCxJfbst505DcXObod7aX51ezM6BcUkuHIPztyAaPM+iDH5oUkDBr6GgXNkgGj/7qKvbGDyNq156hTxZfsC+hr7AzPcNryV7kS6RhW6Pr0DVVbuDMpGBw0QIAwNCicvR9Dj+eBht2Fek+PvNDnsfxDiHLTqShywyQL4GjM2GHjrJJ5WQfOEbP+eqyoeSu4rt3144f1F9wMPaktAU+mZbY3SNHE4CS5UaMP8PRFgtTiOwjACmEGtwu5xdUb5HQLxmUCjh0ujrhghCrDX8LgSL79NPKDacltRzLOAR5oMaMg+aHRoJzBvLP7/Yg0Cm5rsSPxR35xQG6koPg5UFCKSJERfLc8mhnJOdm13SpXnzXN4+W1lmpsh4cQZhVdCSntnnBHSTKqCKwCjNwtycOHG8pXGilviEwoqteDmOTs27CMDVJ4g9c8dlomkFI0hSFi9MQep0PDt5HOCdYAuKYyH1g2gVWJn4Zc6cvQ7hs9ZB9KYx0Dc1GECH1XI61tZ9ZyRJ/J
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nVKHB3WOZ2AM8mHlc69/c1OuyEK9YYOcJw07Hyz7ybfaHb3tr23J6sNd93yg?=
 =?us-ascii?Q?authIYjI3s/bW0QO+Gl8AEqP1430hp/GfzOAwMIFaPtJmMJ/MurllLpjo8q9?=
 =?us-ascii?Q?0iHvMvRxc5QWdkghGxVwEr04urT4vUUbw/RQigR3XF15sxzsJ9KwTC2lwYff?=
 =?us-ascii?Q?GSqv3kzEMuQTMS4dQATWTYlCD5C++yiR0sSZeiQOW2GgyQotTU6kVbd7P6Cc?=
 =?us-ascii?Q?2NSfCgAkbgtN09f4XQ73T9y+goJhV04rNJ7lOBLx7f3gOB/DK3dRuvnmqoqK?=
 =?us-ascii?Q?KJt9TpPAzfzZlFzKnAyKKX5/ZVXqia1KgZjS/jqVPiYVa8e3UPqRNI7YbgiY?=
 =?us-ascii?Q?XEasoiQKmZq/mQXvDm+Cbtkqf+nkENGAsb7USsKBW/LNMv0H/bBivq5vU9al?=
 =?us-ascii?Q?QPs75p5psn14kFQHU043+Jn+CGKfLAVJ9RXRk7M+p9LixpXdGRhgPOmSKTMC?=
 =?us-ascii?Q?11MBzQrXkA5KuiXGjZxe96C15Tb+s+beo9U9zGu+BoWevcWU4PfQZcdKdpV3?=
 =?us-ascii?Q?Y6iKm6AL3y6unhxcDRd1E69PmkEI70tI7lz5Jxq67bEB+XjXQOmVuCdv/SCB?=
 =?us-ascii?Q?kBgWjNTj903giBq6eeoAf6Qw33z+xkKnhcX84bSn9PBNHCl6xq7p3oHpiEUj?=
 =?us-ascii?Q?QzkiojPUGYfDHB64FUosf2eZGSq8QZIe80igT5QnlSzTCMsLt3egIt22ApIx?=
 =?us-ascii?Q?oNSRaSL5kBwlZ6NVhpLRooZf6xx4zvuiEinY8BTcCIAk3rblH/k+9uQonwjo?=
 =?us-ascii?Q?AmMkrEEOaFi3T15aWqtiFB4VTr6/nqVpcPovLG09ANk3C5Le/kTVgDLzKYdG?=
 =?us-ascii?Q?cZMgaVKFLghzCcJ+899HeIFR7cHWQXuutZ2H721ZLhBc/mo3vaY110YLXH+Z?=
 =?us-ascii?Q?ACMHGPUoczvOzhLdMxtadTK/Y8i1GNyPzALVxK6519t2Cua+pERHCBz6WW6V?=
 =?us-ascii?Q?1Fmf4gfGD1PCAyfAgttr77yhx7ag640LIMYifVfZFys+K+ypNAmBhgRbnheh?=
 =?us-ascii?Q?kht90HNTxTKpVFm1n6uM0M8mfX1KtUOfITzDRQdiI3fVt2mhXLtEWnnpAqMy?=
 =?us-ascii?Q?uLJ21gP2lOggQBjnXL+5F88JiiLA9TbPejReBCfoYw1TwUcvji2KA01aRnGR?=
 =?us-ascii?Q?y4qR9X7XMEK51pgPRBHjwtdJYmGHNSmjtky4yjE0BylTgKBsnkSjIzmsysxL?=
 =?us-ascii?Q?LgGOhCa9PM75UoLtG3BFBopkH72qXsD0Ix0D3w6dYYSl873w0yUZW3GJ2XuL?=
 =?us-ascii?Q?VsITSq10QYENpNWpBzQQttPY8geqYH9prhA4UUbzAg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB5049.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 068392ca-de3b-4dc5-b571-08dbf04b254f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 19:49:34.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR20MB4633

That seems to have worked. P2P is now listed under supported interface mode=
s and gnome-network-displays works without issue. Havent noticed any other =
changes or any issues with P2P, but I only have the one app to test with.=

