Return-Path: <linux-wireless+bounces-34942-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNAxHrdv4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34942-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:36:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 077AF41D8B2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BC81301952D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72F03A4509;
	Fri, 17 Apr 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rt/gaYxo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19B3815ED;
	Fri, 17 Apr 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447393; cv=fail; b=Hl7bWopHclBn01owgjL1XLkGUBOjANLjJ8WGjnR8xba5xlINsUn+qEKz6Z7K7vfvGSUlQcmMFMEY+z+waFCDo++16Fg73UBaDBd8KsRnu9phTPA7aLFVNqJLK9x2hJvwGfi0JZ8UagMe8EP0VrdM5dae+IAEMXLrKeZpmaqD3sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447393; c=relaxed/simple;
	bh=SqHfJhDGD1WqXDMlPR1xSHpj7qrf2TN9nD2mh1N6B7I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aGBH2YQR13RmHWNxsfK1xN39dJe/StPzWEFt1E1y/opjulHgMi2P0njUgml0w13SeQBGR2EmtR7kZ9CHwJ04bZvzpA6Sy1CQjHJkBPAp2WGsQYeKxlpr1zv79hnX3fmnHcRe16aCKM29wdiJdVYIPuKg/4oTbOO9OcrbbhUgb68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rt/gaYxo; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXwSDuCg1Tadswh/Z4jArsqAgAQGmWx7spMz+FFHUsMyMSoNIp/AAseqIXNBkqR6yc4EZDpR9+BJtMNxxDNSj5BQloDRRDmmGLzOsO81hzGOT+F7NS2RuG73LP48/YkpKr19Nk8Ar5+WDvGrYNCjN2EUuEDnDDjlkEum79J7Nn4AxJL5JJaQHK4p7vc1tR5/dX163UigineowklB5ltxGWZDgQVBwt40kgxYNaZztJEFyXc5AHoDfGl6K8NzWpDyIwTpjR1iUBzZ0GJDxMV0gv0MdREzAXkN1te3ncFgKsvcgb38RGZEdiwuPsLz2FxPQKHPgH9ZI1kyDDi/47Cckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mtZPGAcbPn3yYEX4G4NP+qTQrSh+h8BECbZbkUkcy8=;
 b=T1EjJCS4m/D/TXTv1tuS7V2MDGnFFRvAEWiZynPyyBWS2c1zqw63axVcSsuez1unqEjyX8pjhR2ctPeRCz/jIG+GeHNqMEwF7eMH8LrXn9Zh7dhCWmXuoCBwyl1nBEeCRFXE85X130FTumeA3z92JVrx/PTsLu+iha0FVh9p4mcyeMFBOu/Js1YTlwnEmtZ1RrSpUdLRt3XFrPFtKm+Xe+8XSPqKahbFmSypVU136iBZIlMne5t+laMzMCTLDNuTDhWuIME/fHdFpAcOBL3BooL7NinGhFc2W51XRI1n2Hun1GSRImAnFjySbmplnZdSa+nhrgZNzUA3Ka55w3Z/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mtZPGAcbPn3yYEX4G4NP+qTQrSh+h8BECbZbkUkcy8=;
 b=rt/gaYxo/KgL4aYPJpVIC76Bi7KJgS2slgNuao4iDlrjz7FBjg4Zg5cYdxyUdaz1o172PII3iE5FrsB0nel1XJp88AuYJh0IvjT1SiFieYHpEZozW2G+K2QTuB0tyHX2Qc3hp7Qr/iDBvfESKpiwnsGFPW6oFkSOF3QPCdSD1jxEekIP/yX6eEPkgcyxcL4VMQdvk5J45v6RW1j2Muvtfec3hadTffyXaofJKZsu7LRbi04mlX8Nqd8WdAw+bna6ALkQDU1Ppq47J3i3fsdaYkYG0XwPUzBpvPrHOKGO3M5dBPHjNblb0/Q3RYBsOeDMw81xfBDos1AYGK74ERaOiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 17:36:24 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:24 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>,
	Ben Collins <bcollins@watter.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 0/9] bitfield: add FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:11 -0400
Message-ID: <20260417173621.368914-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:408:ed::16) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1a0c4c-0c52-452a-3e61-08de9ca7d8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v15VP0RCKagmczcI8ZiGDhdz4kPdIp2UDUauA+EEmpG8DcWpj8QkausvqQSlPxKRJBCmTScCHBiDhFVx2m940k9cRSWSOB5cOe+QpFOx7t7/sCviEEGmAuGMwE3hD9ZHodPnvNIgs9SpNrzBvgL//V5XHPod1MfPxMqBD4d6qpKPLZ/AKU0wpwAQb53RT1KP6lN6VmpA49cU2gaYvoaQPCe2+3bCag2KJm4wQQGdpbY61Rnwavd0GItb1ob0c6FDVV3eYDb/p/rawn0t6+3o4eiDQUlaUXSRV+g4p9VY2gSRjbNZe81Lp62o5r2aovjkfqOTjhoRSjK6afbmjxL8k/U74XYrxv5QoIDy6mAy0z4CY/HUBIxQYpgsfP716Sh1pHNtQ6+sawB+YTd/22I0HY8kO4Gbj+YX/Kdm4F4/lcDfhnyH7nvwuL9nm+SQQb8ZTNryCwLD9z+H9IG7zEmRU5cXxT7JCJ9KU7bklWk2v7Bo2JSlehvR6lc9jGUZP+vMkA9jy0u1gYU+3s59gJLARhHGQHEcjBpDcIfv6Jh6ngoI2vLKwyuTTiuUGThJALQ4nW6duDGuBqr/yQNd1K1k9jMkibu1020EVfdALqadU9Fk4gLYCfEDcKZQ9QJVo+uiid4QiVtPtjT3di8eRbMeNIrzp+cmMnj916Ss+qeEm7OPXrCoDZ99Nre8gnp4p209MUxSQbHHe3sZ1xfYEL1iCJ2IL0QznMx/Wk42amcRZTHdWlrP8trNhowi1p1xZVI+6LIOeMrk1enFNI75yv+LTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WjeHYmvyrDcJbop9xWRRBsXJOBmv5aJRMSWDRoaEvWBiI5QMMlDwgidVA0Kf?=
 =?us-ascii?Q?EQkXQ2NprwwugrbSvpQGgK3wzIcPzLWXIekpbqqzahvgpU0a36PwHxN49vVj?=
 =?us-ascii?Q?aXoDRNKzDizomxrESqzMuw1JZvZfvy8aaV0It8ROYc1cXmsJn8VN2EJZIG/s?=
 =?us-ascii?Q?svxTwEM0V4je7ciHSRNXcKfF0xMAlbW0H3hQ8mpz0zrIk3QhoIF68T6P19pl?=
 =?us-ascii?Q?mvaC87JETrQaGvRaOl2CIcat6OSFD5Ytj/KcocgWkrftroT63xWSfkqB0AgA?=
 =?us-ascii?Q?yzx5iZcKWNQvYxFJXIu+XdFmUthm7S+LNuwK+/FHQy+Msk46Uf0KfXdhksvP?=
 =?us-ascii?Q?w6Wf4BkPALKHHbQBadqClBjlcNkm6tIsfv4GVLuzcWZsCfSbo7M9DbmJ5btF?=
 =?us-ascii?Q?yJrGZD/pibGRO0vMa7GNmKljIwxvJ4g5ITuqUc6gkGFTzW/fl2WYFc3r/BlO?=
 =?us-ascii?Q?j3/mzTO8pCtpSq6ygFl+PhzDszFvfYubcSiFq8ndqAHpb4uYIAhXUaecqsYz?=
 =?us-ascii?Q?xqXlAH8/m6ZWfQTObbZNX5nRVuqIBLoZ4EPMXtAu+n23se0Z2KXJ1FwlQ+C+?=
 =?us-ascii?Q?6MQQWFrBnreVRXnixOR51VUB7oeoXJlYfsK5oQZHMmhLykb8lYCNFvX10zy1?=
 =?us-ascii?Q?Ss8r019T5kVN8GpbRYO/pzLO213Bo94UxvvEjUVNuh7V9wVvyH/xLmZoCyK8?=
 =?us-ascii?Q?9OUHPvp82LinbWDlUFORlX9bXMJqmlx+48XukWpG8OwWdjEsbrGrjNzqJVfm?=
 =?us-ascii?Q?o9QTY7uHczBV37KwXgjyZFq96DjWpVnHj5qFdb5tnH9dC8BuWz015cLkE6BL?=
 =?us-ascii?Q?F8PRQuhmo/56Xg2hokn4AUBt7ouG3KkDb3VbAnH7Okfq6YFOkDTrsVKPt2OD?=
 =?us-ascii?Q?HqeoPzFtVOotckiD0QblsVBRqNb/j2Q67IwyAZ+8dvrYJ+0Ok0nuhCrifW9E?=
 =?us-ascii?Q?2SKowP/fAnLUYw9QjttEEYQNSL+uaWXKEaZ4k+HVXdEBILUbdVPNm+6RyLE0?=
 =?us-ascii?Q?NnYacl+9FUbKTNjrCh3zdCPLyrWVO4KGQexjCDVhdH5h6C8lAv7kQEjuVyKl?=
 =?us-ascii?Q?D8cHUrk1PnVsCrPUgOSvKoi/+rG04idySgX3c2KHhb0j1jnzA55GteEA66PL?=
 =?us-ascii?Q?xT6b7bTguTSOxXTuVfGJxmHH0nhUrXV5gDjqKpNFE8MHf5iZgGFHlNUkQ2FZ?=
 =?us-ascii?Q?uScdbvFKqh8Gb5XB2baGudbxbFuQrK1DxHtvBYccDMKdsLtGA9KH4Rh0UDxH?=
 =?us-ascii?Q?gOgM1ZaSVgkBAUK5iQr8FN8TIJ5KL6PB2Zb8iuv1Sg9zuWCKQpiklxFdCNg3?=
 =?us-ascii?Q?7N44R3UT81EQMu6YGB2ZX7i4fe6o7CQlLdKw8m7ADlMpQswKzU0/GlKd2ZWI?=
 =?us-ascii?Q?Kx2sQGgc51b8pOCG0AeMkQFfCWfUT0nZrHu88nl/sFbFPabW+rjtUQZmJZUe?=
 =?us-ascii?Q?VvmEil1dNV2Og6yl+uRjbooawo28IKrMwQS+cQdtzNkIqkOSjJS5aSdl8Ace?=
 =?us-ascii?Q?laKZXxzFSBz7oJcB9OA/pKRHVf0Up3/0mtMhffzlrbQwS/iI1C/xy6huONzr?=
 =?us-ascii?Q?1kAwD/tFfot7F7AhKh4sARgUGcdx7h28wVBLb5b3uEzv5/uFNQXyMKfRnLAR?=
 =?us-ascii?Q?wn1CgcvkbvRXqR6jFiHtU+oMY6s2UjhrGd/J91GJtCtwf9ZQotKSDZM/2IVL?=
 =?us-ascii?Q?f8bGX8XyES/bTI6Hf990vQ8uS3euKj6+8sKG03AwRDeMuRIop5PU/LN0LBPp?=
 =?us-ascii?Q?n3RBAwJF37R8HEQufjturwvhchNOncWKIlQN7OqayfHzmMR9SXVX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1a0c4c-0c52-452a-3e61-08de9ca7d8a4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:24.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfEajuzT7WcIurnVln7XKgRWQg+b6zRxSY2oKhMKxPkytayPE0WwBeYY8XgcU5UjLtarsUDuSe3c7JQZNFIPzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34942-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 077AF41D8B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bitfields are designed in assumption that fields contain unsigned
integer values, thus extracting the values from the field implies
zero-extending.

Some drivers need to sign-extend their fields, and currently do it like:

	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);

It's error-prone because it relies on user to provide the correct
index of the most significant bit.

This series adds a signed version of FIELD_GET(), which is the more
convenient and compiles (on x86_64) to just a couple instructions:
shl and sar.

Patch #1 adds FIELD_GET_SIGNED(), and the rest of the series applies it
tree-wide.

Yury Norov (9):
  bitfield: add FIELD_GET_SIGNED()
  x86/extable: switch to using FIELD_GET_SIGNED()
  iio: intel_dc_ti_adc: switch to using
  iio: magnetometer: yas530: switch to using FIELD_GET_SIGNED()
  iio: pressure: bmp280: switch to using
  iio: mcp9600: switch to using FIELD_GET_SIGNED()
  wifi: rtw89: switch to using FIELD_GET_SIGNED()
  rtc: rv3032: switch to using FIELD_GET_SIGNED()
  ptp: switch to using FIELD_GET_SIGNED()

 arch/x86/include/asm/extable_fixup_types.h       | 13 ++++---------
 arch/x86/mm/extable.c                            |  2 +-
 drivers/iio/adc/intel_dc_ti_adc.c                |  4 ++--
 drivers/iio/magnetometer/yamaha-yas530.c         | 12 ++++++------
 drivers/iio/pressure/bmp280-core.c               |  2 +-
 drivers/iio/temperature/mcp9600.c                |  2 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c    |  4 ++--
 .../net/wireless/realtek/rtw89/rtw8852b_common.c |  4 ++--
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c    |  4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c    |  4 ++--
 drivers/ptp/ptp_fc3.c                            |  4 ++--
 drivers/rtc/rtc-rv3032.c                         |  2 +-
 include/linux/bitfield.h                         | 16 ++++++++++++++++
 13 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.51.0


