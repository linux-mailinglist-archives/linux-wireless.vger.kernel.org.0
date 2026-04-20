Return-Path: <linux-wireless+bounces-35097-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKfOFttp5mnBvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35097-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:00:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A145432648
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 093CE3020ED0
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B239F160;
	Mon, 20 Apr 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L0wkrmI2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76F35E930;
	Mon, 20 Apr 2026 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707994; cv=fail; b=taqexAWm4Pc9AZ5vuUdMEsSkn9e5Kxb+kHZ9JJljoN9q0z4uhxpQV2ap1uSB17MlY6LwNPp1ulXacJ2iztLj0vMKzY86LZK260r9FbX73TgeTvMXvdRRd0mswcdZ9y+VpjNJ2gJQxnzFHCKsZfhTeDrFdFnKIb3T6CeCEdR8A/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707994; c=relaxed/simple;
	bh=cRzFBp/tkI7/FhtDBiSUrUgSocOwPl2Dj7+Eu799uBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U/WbmsUHjUbs6F66xQhRwtxDg1T3yPU9tQnDSuNMHSqlWt4waPb7dBFTvNM0CwpfwpQFBimfQl1R+5lP3bEGJI3vwazrlu6oK+w34UVzaDy6+cbHvydAi4Hz46TB2pjcGnLULM2yojqjJaeIVAHZNN10xwnY/MLnOopuK58ZBFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L0wkrmI2; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHeuR+s3nKgQHZinoY3BDEymtbCBVa9M2sJWXDKeN/qE5wyCiDvoowIzf8sPp+p0/zsHClu9p+mc+eq6AwkBfUJix6RaNg0RvwDKut3Hm+M33rvpY8e2NkG0raIYBUSX9b3tDbAYa4Ks0efQ+32TTuxvVW21qQEtnRIgtVLNjSR4Te42HTun5bTs3gfepb7USzBhvSlaRFTOAN6MLVxdpJWU3a1O2eNvIvpL/8VSEdSd/Lc9MWHt1q+GQKDdPDH4IfgrHZLhHmoG+iewJjEec+lta8OgaRpsbgfepbqAi6Gv19eYaz62XS9TdrTmEes3Ea4il5ax4T1kfoFWgqvF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7aQsDugQg5PF0+fNzpm2HcJKGQixkrcGCTxHlak6kA=;
 b=blqlB45oCFtXKsGmRlBIpLyDnVp9vlLElt2D/rNq+blXy/ZPVP3QoruHELQ9Qlzmeeop7SJnNNlin2lSzbgcOvuqhrym/n4rWZoL0Tz7vXFB+2yGtbXahIjaIxShThw/+2pSwZ7KZpvXLA5QzNXJNtxtIlyyda5riIFA+EvR+ieRDkXtE90K09jZ9lRShdXQGaW4SiUjuExUpb/rW8gylGN6WaKBPIbas0N81hAO9JFVWPGhkXYq1hE4a6xM+QHg4VY+dOLNjvX2tPcW5vfH9RG22fn7m8E9lodT4OoRdw0nikpBwSh95IMhKGwcNWG2vtNsflXNMXynVgVpM4kvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7aQsDugQg5PF0+fNzpm2HcJKGQixkrcGCTxHlak6kA=;
 b=L0wkrmI2rulvMUI5F9KWvj3vJO4jQ6RpsAljybBrZ5qrwdk7YsI98IKgLeFrpu97WueVKfrPWkjDjXg7i/VflJJdl2SC0VKo289BtSHfipwrEdJO+PNYOTFatrNaJqyD9dpDdNzdzRCXx2sXc80vwz5MaWmeOe5jx295D8tvjMO1FSi7kQ1gubwthOjXPKQUMcTdPdclaxsgaOAVe93H4hnO8HUvvSdqGlfLjmUEuID3pTrgAL7i5pI2XcXkXuqNF77IqQ84D786+0MYM0/1dgxNeoCvvzXaKoYCE7vp1c5tDrftKq+q7IIOwa/g4x68g4YEUI49ha4lLndFUdxNvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 17:59:44 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 17:59:44 +0000
Date: Mon, 20 Apr 2026 13:59:42 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@stromeko.de>,
	Ben Collins <bcollins@watter.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Message-ID: <aeZpjhVL-a6QqNdX@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260417173621.368914-8-ynorov@nvidia.com>
 <5fea4ea146404b55919037594ab85f1a@realtek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fea4ea146404b55919037594ab85f1a@realtek.com>
X-ClientProxiedBy: BN9PR03CA0763.namprd03.prod.outlook.com
 (2603:10b6:408:13a::18) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: c8eaf44d-7645-405b-daf1-08de9f069a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fS+wzOrNlK82B8nCt4Eo0g5++jAdIGyz6SdVD/PPAxur2s2C5xNXfQi1XGfgk+6UIc85YeFEjvQ76cQ0iKHOXuX1+h8IYeJAUxGiROcIcUmMBGBCU8zOhZzTH13cz0xKI3cwJGIZZG/DDj94RLcQ+R1dtbPOfoS6uBnjzdkDFC/md/qNmqvB6SlRc0YnWi4LL0aNv6iqdgILeLIeboLays12XdfPQ2TuMtrwXXpPLyGlSiGix+UViG4cCOB6bYXErzu5GT4a96ySRM7wgTs+ZF7PWJOK3W08cDjqPeINkyISeeEVxaLIt+NOvPt0WtiNf943irTfqlObWfIYk7AiGecRcxv0rAxw+irYaS58SsmG/vKe0PU4gepuw8SIT1xFDYA7iPnvweqt4D1xK3DkPVL2/lS1tfxehG2rwen4GcEwKtpFCuGOn/jhml6woj0SbzOLNCYC2UZBvGwpEcniSDAfrxtpUAHRess+xOygkyavcCsY5c5xFru7jxE69aN/ki9FORR9/sU2G+mbQjrXOUlEF7JDk+AvxBExs5JdhVqbjdkxeC7w2ADJOg3CSJifDnQ04VeYXnT1BXh+bD4HTDktzMRaVshMKUF5ku0XJl2AEVY32sZomCKZiMAONSsRDzbBG/VBXPuN53/o7tBHXKMay5Z4z4nO8hi/82HKmB+nRSy5Gr237yvNGQmyZDsoa20kum8OtURlli0y4+z+/ZGwgSmVJB7mFI9HaQ3SMeM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngwMc291uZ+p04GvJQH43+9iAljb0BlRCVH6sKqvAIXX5QBjq4DPPbwaQt8l?=
 =?us-ascii?Q?vw1ghZmceRFIM5EWnxunG/zQ9GOGlY2pFfCBlPKXVqHPIixxLsmIs9uHf8et?=
 =?us-ascii?Q?+xBSnfVtZPMuNNFt9HVyQ6K3ieZsbf9iKZFIjtRZzKLRCF8rEAfaNDXkls6k?=
 =?us-ascii?Q?Y1q9CkCEV4kmA+X/xdVbcPmf8WD6WSbMMCBaNAJhtLElwMXC3vAxoQejFpG9?=
 =?us-ascii?Q?DAVHZj1AZQsUXiQdjkwm/5AwmUlD7FacnzczmqQ+rSsdyRf9c36s5GZoW+lS?=
 =?us-ascii?Q?D9h36HhRKy+3SxnjDPwZBZrnUjrLig5nBFtkzaWjdYCEIjjvp/Mqxc/8ghmk?=
 =?us-ascii?Q?O01/hHPCpLfyMRB6fsxa+mgbqLwqgqBsNMQ3ClKzXHxsWK0B5hQ7PJQi6HbG?=
 =?us-ascii?Q?GTkVrDUP2DJzS3E5zmdGSVnOuoTP0z/dsu/nrUNSOQmTXQEtuHR47EOTNkh6?=
 =?us-ascii?Q?jzQMZfoOejL+JW5I+yltuYxH6I0ZaNbg0mpIzvgutynyy4eSj7LDoNLhnxDi?=
 =?us-ascii?Q?ouR8FDfHfIUhx/nmc1c1E4+MyhfmIdoZj7ZlnlK98IYpum0AtRDcSJZAt1Q/?=
 =?us-ascii?Q?XGTKvTEoZdUGOnr3RU873o/EERcsoOtnN/zOnS2mjD8aUROwliFC0zVwsy0R?=
 =?us-ascii?Q?zXK3FlQcp9clMstj7ON2hQ9IS5TFPDyIOz9ucMwjf/EACplgsYF1Bhw4ZB1I?=
 =?us-ascii?Q?OTrYeQLRekeISpRTH2M1xEulb/WDf6y9xfCfPQ6wvuYadeSfoLM6QtgBZHwd?=
 =?us-ascii?Q?vSNme5SQJ77OU/j5pm6bkoZ9RkhW1TXb6dvCZNcOvXDD1++WWS/pDKwRX85O?=
 =?us-ascii?Q?F2NhAo6A/XXGge1RVZwQTzSorJsIbei7kjlC5hEk29AX04LrsU1oAyef/gVX?=
 =?us-ascii?Q?TJte2uaXiAkBuLtYOYE3m8n/11wp/txsC4ps7H+8O4kwnAahGhT/lq43CPCL?=
 =?us-ascii?Q?cRulUIAQ4qSGKhClghWhPbleW2EFgZDM0/jandGIOoZLWlWqrfp6dopSZaea?=
 =?us-ascii?Q?i0SCdtVd0uN9zri9xQeqRCo2WuDp+e+SomZwWSpUZ4O9FLvGRa5A0RUyH5za?=
 =?us-ascii?Q?DKowvXYN7QrKzP2/57nMYPpEPvWOK/cVWTvsvmMpebm866qoUJgX9VGfJDwz?=
 =?us-ascii?Q?Bk2ToShzsEZY0ERYsahPyzV6WAhtlGm8paBu5ky25pPJUVoPtPVJ1PSxxS9h?=
 =?us-ascii?Q?pbnZUg+x1T5YIc01frQRP8F0cC2VrMHgmKY8Dv2+DRaGHILWYe7PYRrqli5X?=
 =?us-ascii?Q?SCnlKU2NfgUa/AFX2/P4e9xw5IgAbHLs0usUAWUeabXCije5eTSx/E46md5v?=
 =?us-ascii?Q?NK90ML+FY2VmE8/aOAozv/Or+RIZWS8Ozx+AYgGegdvKpubil0D/863KKVgH?=
 =?us-ascii?Q?NQcoXTA3xP3z5hL1YWxQWiQdDPODOJo3/T1jn3NZE3Wqy9EFJzYmF5RPsc3Z?=
 =?us-ascii?Q?mA6rDMjASHsit0nuKy17SCyt8fDljtIaq8tVL9V5jbjpsE3irqFp97fLjBJt?=
 =?us-ascii?Q?9ZoHdoA3o4f+6f5b5PbFWAZvH0q4qybxvoyQmV11+58HxtVcAoqo0WU9EoOQ?=
 =?us-ascii?Q?SB13HEWKbQcQ4W44LZ7iVEkJbuS1iKGsiQs5nGPDUoWrVji8NjIk9gXNyWRP?=
 =?us-ascii?Q?p7XSHDGmgoIsPK+fQysdvBX9vMjfD9jccjvurXJ1JySYxH8RX3iWmp6nlAUt?=
 =?us-ascii?Q?bCN4eoqJD6us+TtHuN4wE9/oHvl7BsVhjTw34O7e3AEZcaeC8FFIVki+WKHS?=
 =?us-ascii?Q?tXpfIrh5WdJbLWxxz7BD4lSxX/2TmN51JzP5AiGa1jWKt5QL+B0w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8eaf44d-7645-405b-daf1-08de9f069a95
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:59:44.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffbwgXhU17WWCJBNKoX53SL1GFCZwOROIiUt+IkqP56l5y8GDFByJ0JoK9/3xaVxncJwj47MD3QoXCHpb2XnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35097-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 0A145432648
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 07:49:19AM +0000, Ping-Ke Shih wrote:
> Yury Norov <ynorov@nvidia.com> wrote:
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
> > @@ -206,9 +206,9 @@ static void rtw8852bx_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
> >  static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
> >  {
> >         if (high)
> > -               *high = sign_extend32(FIELD_GET(GENMASK(7,  4), data), 3);
> > +               *high = FIELD_GET_SIGNED(GENMASK(7,  4), data);
> >         if (low)
> > -               *low = sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3);
> > +               *low = FIELD_GET(GENMASK(3,  0), data);
> 
> FIELD_GET_SIGNED()?
> 
> > 
> >         return data != 0xff;
> >  }
 
Ah sorry. Will fix in v2

