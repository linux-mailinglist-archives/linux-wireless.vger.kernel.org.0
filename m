Return-Path: <linux-wireless+bounces-24874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73244AFAD07
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FBC188E982
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 07:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F981F4191;
	Mon,  7 Jul 2025 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S9jkjlB2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA6277CAD;
	Mon,  7 Jul 2025 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873125; cv=fail; b=rryRYkhZlPWiTeytrt27xqylHzOetj3HgsysOQTaWmiu3mAY29tTlHx/sPnduLSA5F3sEqVNjNBikhjKkP7iItPKcPfV+CvpIjw70tp3+qQUAb7lYn+AO51mRUVyx/9+xlk5VfPnciuI+BLQN/Uo71Nx11SWGAgyvzySnHHmRO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873125; c=relaxed/simple;
	bh=3M//SkwAk8mZGQfa4vXQT1VvdMpqub6rK9boxeOoV2A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mJrDu1dovHRrq3xwh3iGP+8Of5YNEXJIxuEbXsQTU/3O9tTkJm6+FnrkfWl4OrGpem+hyxpXh0RL1R0qyKC/OTRcxizNY/GZUhx3G3tpTUXGTSo2iC+2mXIYEs5K8Ivbkq+LfwckIV08gDhk0V4DjS7wxYEeGIFCMibcXQB9dMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S9jkjlB2 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTedYXln9bRAOxmNNG9sNxrLi7gnXEZkjHFhauNu80LyHszF+sOnEFFhNjnGP7/NXPRF4HUfZWHO/tSIe6mg6dMpH18xipZdZAJqZbCASylTAOgTBUEwqOBMvWTKiKFn02+QmnI3VK2tfWjtL1JRtqhJ0ZiyWj5CIVL5vKky05RK6szU+blvwfNFeIix8xBWJD8iXG6GXx/IxaCYsD1yf0/9TyMX4xnZEeyyF/VNAZsuBmyjq6Ua1Ur+tylYN5eXH6UWXiDy1jH2lcceFqxGNM4jpcBbi7bOCAFu02Kou8OgV5gcxAZB55HbF+Pxsh8j9vNakQTC6Cmpp/cKFTWvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9QnnpL3w2829Ek3e6aKE8DLaFNLwVtBVoUfXkV7e3s=;
 b=fuOQitIsUmxTo3Y4eGG8KrQbKZYq1tw8O27hQBLP/TWcVQRwLgRtqM5R4WWdbj2Wb3pfCWbGca49JnRlr5uCOX/DyUrol6i3DmEvMnmojhMKFQbHBjKqvc8RQgfF9r36qZmTjO9+s4GIwDJzueGRCClXNgWT8syRas6dkvr7yxyBLNRGf4wsTF4u4UGWvhPWMN0tzZV4DHYw5LaL/hsIkFY4pVLZxpfeFvvLGNPSf5XOpO8hE9B5WI2GfGQh1LRu4w2bn/jwd3vY0MUnsTNKpiC+7RnBMK+fcX2MuOpC5BENkTennxDnqwn0CdVoXD4uvBJ6eV46W4Rw54hLVnLY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9QnnpL3w2829Ek3e6aKE8DLaFNLwVtBVoUfXkV7e3s=;
 b=S9jkjlB2+qCDmFSHR6XOXlzIEfD6E5H6DxfYVVR78D8W/Mueclaas3Mtu0LvgxhlXR/AIY5jDrlXl/GTHIAhU25YFVSt54pCdmiC1NjotuZH36BzvzomG8fAtYyzanWsYj8F5Sc+PIRBWuYn99+thnuVkCmZWhaSK7RZqcHAaQNLzWsEXt3NDRv9982HOZUT7N/pXC+RXaABNeTpbrY8QuVGchone3wLvlqZIWTY+C3lX0les4y62iWeobwB0q5U3u+352vmFeU7FB5+jo47e2Ke57X0H9w8fkFRDdZbw8Y66HTup4hy9IQqBcHSB1NsjHmhbJHDuU5KykLXC+bJwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5497.eurprd04.prod.outlook.com (2603:10a6:10:8a::17)
 by DB8PR04MB7148.eurprd04.prod.outlook.com (2603:10a6:10:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 07:25:20 +0000
Received: from DB7PR04MB5497.eurprd04.prod.outlook.com
 ([fe80::a12e:514d:8f94:e391]) by DB7PR04MB5497.eurprd04.prod.outlook.com
 ([fe80::a12e:514d:8f94:e391%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:25:20 +0000
From: jeff.chen_1@nxp.com
Date: Mon, 7 Jul 2025 15:21:37 +0800
To: Miguel =?iso-8859-1?Q?Garc=EDa?= <miguelgarciaroman8@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, francesco@dolcini.it,
	thomas.weissschuh@linutronix.de, tglx@linutronix.de,
	johannes.berg@intel.com, mingo@kernel.org,
	christophe.jaillet@wanadoo.fr, skhan@linuxfoundation.org
Subject: Re: [PATCH] mwifiex: replace deprecated strcpy() with strscpy()
Message-ID: <aGt1gR2cd2VACuB7@nxpwireless-Inspiron-14-Plus-7440>
References: <20250705133600.186441-1-miguelgarciaroman8@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705133600.186441-1-miguelgarciaroman8@gmail.com>
eFrom: Jeff Chen <jeff.chen_1@nxp.com>
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To DB7PR04MB5497.eurprd04.prod.outlook.com
 (2603:10a6:10:8a::17)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5497:EE_|DB8PR04MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 3626f16b-45d4-4684-2c37-08ddbd276df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|19092799006|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?kSuhWLzJh7IuVpflwpFoP/wMvMZ6fE6TzyuzZyKHoyi/nh0LBTeVBy7xem?=
 =?iso-8859-1?Q?bn2AMHNDfW4hZhM5v0sUu67IWG/bvBC8TCK0dwOda3uYqxamvR1m5tSUMd?=
 =?iso-8859-1?Q?UFMoPI7lS5d1I1PDLfe1IYb13BGI3oLEBTkmjbxNDIf550rM3sjWsyMNxK?=
 =?iso-8859-1?Q?QVgxTozWJ3U93SKD52+c4sfxwRl20k2BldHam/0Ioi2zksDNsoTRapzU9O?=
 =?iso-8859-1?Q?oQZIuJvXhHf00MnSWzprE3rOg+WdPE/x+x99mV/nWKmRKC9u6TfzjiU/RH?=
 =?iso-8859-1?Q?yxO/SzxjcB+QEAd+MNdeflca/xOatR2q33vtyZvXtsWuNoz0ZRjZnT1dk+?=
 =?iso-8859-1?Q?5LJSRsqAt8d/8Hx8oFGTSbLYQ0IOfZp5jcXaWCCR6S8acuvBXcxFkDgaZz?=
 =?iso-8859-1?Q?2AjzUFGPO1MsjzKNoFiitU2Gf/X23cvn5o3j1xfO1f7OPbKfvdeYtQIAUQ?=
 =?iso-8859-1?Q?htvn1shqee+/SHlJn9LaYx2dNzGjeV5eMsRS//ehVudpulF8sUZ8R8s+0o?=
 =?iso-8859-1?Q?r4ShNVu6qPpHCJGaPzMg0PN89mmcYhDS7Io9eN8JX4EvUd1qvzBLQWVqzV?=
 =?iso-8859-1?Q?g1r39ExNmHDspYqiaWUDO1HkCTOaR/hil3nlYjAzeF52qEzUb8mU0WEY01?=
 =?iso-8859-1?Q?dcu6uktxd52/sWch2RHGfUsB7q8qzZ98GFuyDCSviRy93dV08ovq9THgYU?=
 =?iso-8859-1?Q?zKKsGdpUy9aHA6wT7Trd/832XWbo8ZzmXTd2uCMOTh8yzld0qC577yA0Gc?=
 =?iso-8859-1?Q?kKOLy/75LJSJEpcXM82hmsjAv0waa7AiQvnVjXMFt6PrCzwc4kwRgH3d9L?=
 =?iso-8859-1?Q?K1aCw+46CsJ7ujhjYySnS/FvVL4tSMDWGqjTnRfzvwXEiUuY7jgUf0+0rH?=
 =?iso-8859-1?Q?Z1py9VO5MMnbQfbdDKvDy9UuFboMITJiUAjamGnM8Qblo15m1v8+skvuMa?=
 =?iso-8859-1?Q?I5k9FqmCj/SWuPjHx0cexsbNh77SiFo2I9T+hUviL8Gq4kPsOXJ09LX+Kj?=
 =?iso-8859-1?Q?hbG1R3HM0UZV7swvR0xpAy/zr7fnS31bCHZiDeBfC3VU3I9vXHKsNjCBlw?=
 =?iso-8859-1?Q?VSqo7SPkVHb3jo2ULHYyF4GBtVW2j2WM4rlIx5CTOFnCA+ejL2OTO4LMvw?=
 =?iso-8859-1?Q?AeKdHAgGz8aO0qlGrsiJwEbnk3pR1PaW3frY1DmiwVZSTSAZ6To0P7MHqk?=
 =?iso-8859-1?Q?hJa5w7yYuujTg/6fQ7l3ZQ6Aw+tJHKsMIqHi1fiqhHksVSlngHfAsOFWn6?=
 =?iso-8859-1?Q?YlA91hv2/YmYphV6znL6w7K4stwXM1PHITeebhYK8qfG0UAaBg8/JXI69F?=
 =?iso-8859-1?Q?oDh/M+Rz1Vl2DlXc/ygfFOSfbot3FFhE1Ke+lyXyM4U99phyhD8QfGjMhq?=
 =?iso-8859-1?Q?j9c8dkUOIbeP8vqvKgYsEpr9a0ZEcAyPPDLq03wvGo9ELaMcdaTpO+ws8s?=
 =?iso-8859-1?Q?45PZ8QI5ZIc0rOpk4Nx6WUhoBbLfM4KIKhFeVtJWBdLo34OUBTu9Y/5gJZ?=
 =?iso-8859-1?Q?V5BPBlQL+m7AGdBQ3C7q5zQWwsjI6hu1OJPLJr1pEeAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?3zF4GHxA2IfKZARnMxhCBSP1HzPmfAj98bTRAQkTCEBbV/C72EHAQF0xGV?=
 =?iso-8859-1?Q?vDshgQ1z6KriKbVmxUW4fzxcOvjWkKaHRfbYlFLG1BahYkAbUsOuFQ6qMs?=
 =?iso-8859-1?Q?3Na2lJfL9pNRFuAF/ZhwgZ8UkwKk7OVI2BhQCW/jQC1iSUh6A6P8mXwm1V?=
 =?iso-8859-1?Q?bHCbnAAXh1Gzakf+nNvoVekr+Y0+d5PoTnDRZBPFUpvA+8FxblZscml6sk?=
 =?iso-8859-1?Q?q9dNIpWd8pQhCaSlDClUB4UgP+cElOZvjMuGEH5Dy9p2ovbLFvfE0S5owN?=
 =?iso-8859-1?Q?PexZNap7z1eivdenDQvgVlI//LK1VVNtkhfFGty7GaoDIvNTw/6vrWuytm?=
 =?iso-8859-1?Q?nDrFsiJM9+v+rclZ4Gr8lJBsSD+pJkkyH+tgLHDzBiuBretnmGxx5prpiA?=
 =?iso-8859-1?Q?Qvi39J8Bovgri9+o2nsRwrC1xUqNHwzvz223pBjEWF5VJ6cSpKuliods71?=
 =?iso-8859-1?Q?d+fHl+aYbqb3Br0AI0F3SMGHtzZ32c9pkVhbnivqRRtIeW3KnNNXkRyh8C?=
 =?iso-8859-1?Q?eu4jmoeTq4PR7WQhheu/UP2sZtA0crkdy1Ardi+V94uYUDi6HrlFUdb4rZ?=
 =?iso-8859-1?Q?djEej4xFubOchcSUTYAmWToUreMECCrBUlXZqiqPiyz9MCgZB+J5+m5K5G?=
 =?iso-8859-1?Q?S73zLmAqTUZAc5Y++M9grOOzHczDkgOSfZ7S8/NDGkAZ9wYrf9GypmvHeZ?=
 =?iso-8859-1?Q?ABnSzhQh47E3VnEfRZ2MDIyg6pxg9gkWn7Wrb6RNDIbbxv9XjeByNMSz4B?=
 =?iso-8859-1?Q?BCocBPojUrWb9OmxmJDSeAiIw02kglJ1Gv+5EfAluiXaNwoyIdS+iv00mP?=
 =?iso-8859-1?Q?Fsf7o1SY9x7Z/5GIuMZgvsJLyrZrYwnB9WCq4p0MMk6KwiY0kGL7Ef5T/3?=
 =?iso-8859-1?Q?JhjTsRYiQXXBnOPgAWRCtDSZPwrIYj4rNJdxsn8Ao2dD1CA+s4EcSGXgTv?=
 =?iso-8859-1?Q?Xg77LjIJQVEJCFctK1FdJCXDxLei52x7TEZbTT4k62jKHHPGvXwDZyraWj?=
 =?iso-8859-1?Q?dkhVF97pX/57HzC4E97lwrk6JJy2TV2OGr3bWKhAFpjTMqYPybkaY0scbj?=
 =?iso-8859-1?Q?MhaYFjeQdLSUQ7ylfb18zRtzjrgo8NM41Q74S0bbFH3b62q03P68lGhmRK?=
 =?iso-8859-1?Q?cU+DR+KdGJUS7reZu4KcP7YLmtOSvJ3DAPTxTJK+MHeI+ZinuMVXRP4ixp?=
 =?iso-8859-1?Q?snAyxuC2LS745iLpLo1xuPnVNm5kFgLOQj6+Oa7mmKAOMLd5CgRNsIVW1k?=
 =?iso-8859-1?Q?0QGMpi5ndpustal5I/S0TcVUsPEnGtaE+CW9KY334tUs9GVLMg2Qfl7dbu?=
 =?iso-8859-1?Q?WITAuFhsh3QM8TtZNhgUsGqykxTf4I2lF6r2ndRaz488VOfHne1ACMD+vY?=
 =?iso-8859-1?Q?hUMN3S5UTi3mt/SEzQcEd8pjxQtQvSiQgxOW7fVwh1EfVVDubwSfF/VIzS?=
 =?iso-8859-1?Q?SZMYn6x8qLPMFymZXE0fL4hRGG33V+/LnGDGmvZzQLU55AEpwGDQmYumFo?=
 =?iso-8859-1?Q?CNK7A0q1aH9RO812n1Jm19KW3+WuxNttdnb4cuRhKx9WZCYrP6iFtzwCWL?=
 =?iso-8859-1?Q?i5kmtEYbRIqc1bcW/jYG494omlOswSw88unebn23J2qOXK8TkvWOhif+b7?=
 =?iso-8859-1?Q?r6yMJ+OybS1F0FQ95MMS/hpzBl//T9/XDM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3626f16b-45d4-4684-2c37-08ddbd276df8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:25:20.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meA6qOUTOanvtUea/iRGQnNIhB0AuolxMFFIvZHl3Nh+8F7E/cY0+XG8cjOvGrM2Wypyd2SYUSotNRcZDCQ2qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7148

On Sat, Jul 05, 2025 at 03:36:00 PM +0200, Miguel García wrote:
> strcpy() is deprecated for NUL-terminated strings because it may overflow
> the destination buffer and does not guarantee termination.  strscpy()
> avoids these issues.
> 
> adapter->fw_name is a fixed-size char array (64 bytes).  All source
> strings copied here are bounded literals or validated inputs, so no
> return-value handling is required.
> 
> Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>

Reviewed-by: Jeff Chen <jeff.chen_1@nxp.con>

