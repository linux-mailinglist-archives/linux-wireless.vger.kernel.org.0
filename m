Return-Path: <linux-wireless+bounces-34949-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHkbELdw4mnR5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34949-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:41:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A4A41D9CD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A5D03090863
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977123CF674;
	Fri, 17 Apr 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BkliRu42"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DD3CD8AD;
	Fri, 17 Apr 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447426; cv=fail; b=aUDAaMJ0DtTfOHkJbjdWiFco6PMAXyAVhReGZMByvZIiouVZ1BtlDwiS/Dly263mc2r8IUs5mjRryoz+/XDh6GsH0J/gS8tzotK83/GaPnN63RmOxntdpTQ61e1Rf9N4IvhmVC/0hH1/dNTOs6XKvqWifzpnzIeY6OobSC63ptA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447426; c=relaxed/simple;
	bh=ovpyBT1toFoBrtcZwM7HDP57bnXY0i2teEo8KarSOGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZsUuKYUIQUMqd5372z0BibNf5ZqFDFFdrLMhnWiCryRj/V0X2SI+x5L3AD3CEbySpVpadFCcPS7ADNoyDoa7aL54YGX8hJhMP7DLFKGD+7FzNTWrYgb18pjDoohMANGqIJrn0zYoVhTjZMui35yarR+zDQlbZG5o7Ub2h4JQLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BkliRu42; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQboQeZouyavOvrvX2rZJ8BZ3WNYlyOfy8G3bR7P7YjCqYJAeQiTul0ip4X7eBBo5fVhWisBiEJ8dSoqaHEZSJdD8MqyUJ9bxA1PLWLEBBXWf7VnPoyRb47BBv3LZBN5u18VvpU3/hLLh0xYINVduCeUfP4D/MxeXx8mMo6+POFm1CZzLqSNxld1O95VASnDo/ynT3HgUEetGMwUPUE5otXQP68IGLKtwp9cjTXlP3mCVuNmz1DSXA7AcXoeUQTz/XaF2MZI2iyHinpc5foGd5jyeJCngXTsU5vnY1pgzOIHOXmOgmb9SnN8y7K9z4uFwTDHK21LbJpJ8mPyCthcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOHhf6Ig4iwrCvj1GYrRGyWlJb1IiTSBRXBihGkBf2c=;
 b=knDBEXlE5pyAEH0wUVOBYlaNRNOVnEhCWaM836DCaC43mp/3XGUetO9t1UxrXdq2X8mOIO8S2/vf2+ybNA1nFruA2HdsPUKSW/44/dKtLvXEF7Vu60N6JabpZ5Rf3UkvdUUCzBj+ytnCTkyAias+eW3YOheyOdNgZ074VyAGcNp1VHbfGzPhe+6EsIxMIHpp6ffc82i8aHyJ8Pa0+VEoQx+A37VHuiFkmJj0akM7CEgiR2R8477wLeHbzua3CiTAlUjHMW2A0oZqNy8xqVUalObaWhM5VS+RwsShOET4Qmkl7V2DAXB0/59AMvbQdc0phZ3e7J1ZwuUv0944/oWjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOHhf6Ig4iwrCvj1GYrRGyWlJb1IiTSBRXBihGkBf2c=;
 b=BkliRu429uSiWk/srEc4PtY4alpmPZzxj/wn1yII7zetYgAb4WbtQLIpTezCPFG+PqqujmQhqYoWDw485QmHhSWFgB34AYTRBsw28a9j7aVTCcdWfdgQ5jihHhNWHlvaBNSxJO7d2GGaM0Ykzk44jSLYXiJUHjME1nXP8ZXxrwxjcqn7xowlhinhf1f5x3/SyaMai1uBS5lSQpuZTpj6Z4puN0unksU6GmLqh19KOC75x4Jz2DNR9c7DpAJeQ4/o4B+TR2TPgAaOOAv44HCzZCxajjyKR/sAjRRuW7sDY4IDb2q2uCEdIhGemdNmV/NrUF5cP6vs5GCP/xys2FUAiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 17:36:40 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:36:40 +0000
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
Subject: [PATCH 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Date: Fri, 17 Apr 2026 13:36:18 -0400
Message-ID: <20260417173621.368914-8-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417173621.368914-1-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:408:142::21) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ab6a23-8235-4752-a9e9-08de9ca7e1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YI2uWgIigHp58pEeGC0RkkjfS8t6gTenP1cg1mXrk+GFQ+msmRp8oW2dFfMt8PwXksVSGvw5kAEh0aFiDIkxtKuhtyV1x9l937/ZpFub1HZgJoLd/pQWqUMIr69Qvjm3l0XS5f80Ndg4elRIva6UQ8KhIp9aDMt2QfBG+yqe8R3B8A5WZ1/o8CJeG0qwr1vE+i8EHqaCbiGJ1gjEm+VAhOHao4urOQB1wdai7YZ5HXzp8x3hRWm0wRIswVsY6rNww3XsCUgZrkZnKeIUqEE3sNzhdhS+ILPL6Xr87HUBVCqLGr79Mjv8SjzRGcJF34TPTyY0bzkJnYrjNNuyPRSjDuET0bM5pA7sRGBG0GWBQ8CnxuDYyKZxsAkb2KZg7YShfAgzfIObeaULXPkwUJJjyky1giQ8C0sw56k7GQTce880xnLCV12cgxfdvsb2ECnL7uMhV5noggxyVQiN0VMuxadmH43PgP8odgiQ3h019wCXZPmRZlE3p1OaXqc3234xqm30rVqi5IFINZJ1MyI1oKrojkp9pFoY6tjc9BTIzv1EYIhX5hFnrbELCrOMOahNHjmneo6XPAcTm/zslopNmeWdx+bWKOxb6Rl0ViL5dZgTYn06dRnLghJDKk48cBpZBkx3PKFwbx7gIUKfbsKXeCnuIrO7QG2YgzzEdv2O1RjpgMe0GAB8u7j16L08lSGAb1Tl+jb/qWsdrUSgkKn5NXdZVXd8RmkIQ74dZkyZhEYeF20qEPdQ777T2yXXKSFxiZg0Jtwl21ycGArT+trNug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WBNq6xFD4Bu9GPWFk9LatLLFZuz7QaPyb5+h3i3CBmLpNiIlyeWkDQyzno65?=
 =?us-ascii?Q?fr+Uq6QNvDwoXhQxhuQUWEzEHKgs970TkkCa4JS5UWGub03kSKIuvF/+K+bG?=
 =?us-ascii?Q?yrw3jmCTNHK9X2g0j5tr2XYZSYCtkOjSHLdnvLom8CIlKs0IhbhPzD/+7JPy?=
 =?us-ascii?Q?/UC0AEpBf/pstKIETI13biCkjrmGSGqwKh8Q6DkP8nIsWpQIzCiuzz/47SSg?=
 =?us-ascii?Q?i/GiCMkarMgJpxn2VNWJfIDuYskwmVLPEse+xgKBBkBpOz/dFHPcQmamlttK?=
 =?us-ascii?Q?TCAAOVRj2qeltlbihuSu4fxrNUMlM8JNMX1zQEkzIlKh6MmJmeiUhyoSoZZZ?=
 =?us-ascii?Q?LpvbnD0LOpOjfh16hsM5xOc4RLxd0WAPFI7eFH5YH8kPXlmwDUF/rFOj9kd/?=
 =?us-ascii?Q?aB1h3pN/cM39ZYN0u+6ynFeLHeZ5pXUmu9g7dW99/HGI8mtdErsWwEcTCe1h?=
 =?us-ascii?Q?QrX4SygLRlbm21DkSie9nS2Mfrmhk9T2PzALT/03bNVxCmTZ2LozzDgZz3tj?=
 =?us-ascii?Q?4mB3WGvZ/gzBIammua3Jv3oAV3mzvM0b/jmmjtcSKu8TAR4ZyOhPyF9WMMTI?=
 =?us-ascii?Q?O0zWOpuq80YXRYrfF10ap1YgC1TRSpV7dT5uP4WSyQIYmw2UmUruMmH0w/E8?=
 =?us-ascii?Q?z1Rfd0oSF8MfVSXO3ZvrANhNvQD8fvLtBgnS3ZT2ovW06BQiFzlxqZKJKcgD?=
 =?us-ascii?Q?HRoBy6NzLnk5o/HpmesLHUBt8KCvV33MyU9NQmUdVE3I29JBPKOP7+AFyEQy?=
 =?us-ascii?Q?T22zFANsaR/O7sxBrSUiAg8RKxsyHeVea0z8DxmpTh1REiV+++kWYZx0p+Lk?=
 =?us-ascii?Q?dcMOOCo6JP5NbGFDI9/WKxRdRW3bqge1lzWRBYAWxJZ8KeWFRkmzUcVxxbqA?=
 =?us-ascii?Q?0jbWY1inTJr5m+sNLJEsFlNJsTGit9d3LnmTV4cV5cf5w2jO2O8SPq5NIAVr?=
 =?us-ascii?Q?EkY4WOlANqO31Px+IHxNcvcO4Y/GXiKEwGoyQW7A3Zp344PLh9lZmLdWPR1r?=
 =?us-ascii?Q?oX3nPLLbuqLqbLeWx01x6vhpefMN2F6piaHVVIedUYeKLrBzBeELmV2jO/6F?=
 =?us-ascii?Q?0u+G3aKo/AguqzXUrjvdX6skAWtl0QzGpe59XmGBM8dt6XMrSDe9tTF2ahFw?=
 =?us-ascii?Q?Sngqg+6VJsyy8nYDKLM+c/n1k2M0WS4k9DlR/en/pL9HWSA3wNtzNhTl9YdY?=
 =?us-ascii?Q?AEce9thTxJt0dwBX6Uc6Ec+XLLdH1ILVj62cdRd6Mcnxpm57KAhN/4MeRSUf?=
 =?us-ascii?Q?wLyffKIrVU8T/0AnHVwWv5LrfSHAd80ldYPGijRpUucKTdNTduYPyhbUyThz?=
 =?us-ascii?Q?zsn1zB69wnVUJuJTeXHtKXD/dUo6t4nLN89EJIqWOJt/AzBGGHqhQpVQw1HN?=
 =?us-ascii?Q?4c+TEwuR0cHOsmre3AFdzxxz3O/0Wicu+ZIBmU6Kxgl3G5dQknoIn40oUzTX?=
 =?us-ascii?Q?s2KNgMB2lDZlsgOWV97WwycsbV4eAFZfaT+DPRzz89Kdj6iJmz1WRglm0FqX?=
 =?us-ascii?Q?zm9H4rfuT+GSHIhRBKZTM+eeT3On/TWrSk1byt3lPfrMLTlRH5fywYb78+vH?=
 =?us-ascii?Q?tnlkjqmNRQ5u7jucdov+4VKFmhUnquuev8rNbxOLGfFUx/jUsccZ87zderKA?=
 =?us-ascii?Q?LKHl9YdAn5QdouuYTfKzLcMlidw8CK5Q8cb9rak7Znl6DJ6vHDGvJsSZWAG6?=
 =?us-ascii?Q?9LIQu/H6PMOJ5q6RIDT1Fx2OGk8LVSItt7lo+8mLqUpW1k4z9H7aARalmhod?=
 =?us-ascii?Q?CWSYf8xFDi0H9828M7FPeazZyd6pk/duMzun62PfzDDfpFDHT6r3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ab6a23-8235-4752-a9e9-08de9ca7e1fb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 17:36:39.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3v33GAa7gMU9MtcshLV8QfyABmCWOXJpfMylQMnd/49ZSeXgsb5HR1SxUtrKE0g/c0/4IuFjqaoOuvZdAKANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6
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
	TAGGED_FROM(0.00)[bounces-34949-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: B5A4A41D9CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c    | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852b_common.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c    | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c        | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 463399413318..8679b21fd3fd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -334,8 +334,8 @@ static void _check_addc(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 
 	for (i = 0; i < ADDC_T_AVG; i++) {
 		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
-		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
-		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
+		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
+		dc_im += FIELD_GET_SIGNED(0xfff, tmp);
 	}
 
 	dc_re /= ADDC_T_AVG;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 65b839323e3e..7894834091fe 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -206,9 +206,9 @@ static void rtw8852bx_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
 {
 	if (high)
-		*high = sign_extend32(FIELD_GET(GENMASK(7,  4), data), 3);
+		*high = FIELD_GET_SIGNED(GENMASK(7,  4), data);
 	if (low)
-		*low = sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3);
+		*low = FIELD_GET(GENMASK(3,  0), data);
 
 	return data != 0xff;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 70b1515c00fa..8db6ea475128 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -497,8 +497,8 @@ static void _check_addc(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 
 	for (i = 0; i < ADDC_T_AVG; i++) {
 		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
-		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
-		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
+		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
+		dc_im += FIELD_GET_SIGNED(0xfff, tmp);
 	}
 
 	dc_re /= ADDC_T_AVG;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 40db7e3c0d97..528f9f4b1fc3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -517,9 +517,9 @@ static void rtw8852c_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
 {
 	if (high)
-		*high = sign_extend32(FIELD_GET(GENMASK(7,  4), data), 3);
+		*high = FIELD_GET_SIGNED(GENMASK(7, 4), data);
 	if (low)
-		*low = sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3);
+		*low = FIELD_GET_SIGNED(GENMASK(3, 0), data);
 
 	return data != 0xff;
 }
-- 
2.51.0


