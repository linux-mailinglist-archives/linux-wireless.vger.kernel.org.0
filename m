Return-Path: <linux-wireless+bounces-38767-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TnUJLg02TWqYwgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38767-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 19:23:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3371E3F1
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 19:23:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gehealthcare.com header.s=selector1 header.b=ix3arFIJ;
	dmarc=pass (policy=quarantine) header.from=gehealthcare.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38767-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38767-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A695B3013713
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38743786F;
	Tue,  7 Jul 2026 17:18:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B443786C;
	Tue,  7 Jul 2026 17:18:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783444695; cv=fail; b=LUp9oi2ZIOnGLrnOXTWJSqO44WKCjRHGGvec55DOj5OW0Lsb2ZSDTy6eXTBVjo7ZoCugUS7rsEIL1/35pxhr/7XNQkdfp1WRoUGcbHQaZVbor3x/pfATyc8sNjXV5Bkdn5Yvnv1CGE5o3CifEXsPdKQ8oKXyI0dz6Eo6xedlBgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783444695; c=relaxed/simple;
	bh=4U1cM35t6N8R55xReJWaYtdHoTcPrd48+nU3RLcGjiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OchIvCvFGo+RgW81BudkcmTj2D6fEI2xFDNMB/XLKbB7d0m2CGBgRUIOIGovV+SvNfD94UUKvLck0o/bkl/Z3F/7O8HPcfJfELI+c7xYiTPIClkevO0Pw5/T96dSY1+p+OhfUnAnSC2WT7RIBZdAdqJc2nY1tt6MoCTnWPYZ7dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=ix3arFIJ; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR+G/jmfRWUunVcyab/4ouUur6ZighgnXlDSZhwdNW7Hl7E29pAnVF8q56DckO40seGdKGZPKdWyAjbky5FUU9V7XrzUtIL0wm51c9FQQ2GOYb5mNv3+N8KPdzdqmM3hp0RNdvd7OfJ5n4fFsR7eog94032NXb3kHnBALIQ9qWMe3b+AB+OM+YG+Amcvl/jlVN4uMkTjP3Oz4Rj0gcho6U7O7DgZUSgohyAxYRxOd0/ey0E1Dpij6Mkf5PuqkQhTgTWTbJ1fm+2yQqpb51d9PAHCRRdt0HiMkhisJkOL+3s6yQ0jlSX8LwIoLaNGKrvZ3+qWQ41JKM/UQ2MSTENfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMt8M6tY+dej2y5q1v8ojbTbK8iDJcfKd3u5E0qbTNo=;
 b=u/wFmY6Lg2CBWeIEbCvKFHECzA5M051nM57fQd8WywZUUKlf2Y2p6BXCAmeJ3GlMns1uYlv+nQlccJBu7mS07v5qCSj7sDB5AXQ8mjrAbnWW4JgVV4fgKzRxNg0RvMpeavnFdQF/2DP5JEar5EOTyrx9xY0y061LbtFzBTX/e8apvmFvtN7OsQEOsn51A3BT/eSt9QCCw6P6Y0oFrecKsRkZWdC5Yy+vsJXs2wX6LwbKmhZgUgJa0JWFNdAXYNwIInFvke7h4bCbHenoAGHi7Ya8dfhwbGknPK1ri+fZEYyWkBja/9X/orxh7FztJnE/kUCA7JKCbYK+ktV47xL3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMt8M6tY+dej2y5q1v8ojbTbK8iDJcfKd3u5E0qbTNo=;
 b=ix3arFIJKO0WMzG9EPN6R/w+/uhk6uNolmnNaPLwf/VZywTYFSFJAaA2qnGMb9Se71MKnrpRSoBbN09+59IJiUPmqOxK14kDu0oU2a3twELOUtrEnoSgoUv00j14N+OP7hK7+f/2y6/jd/Byr+gbYq/vFoSkytxi/mITu4nRPxzlAgo6GDFgcI3Wj3GDiV83uE5umex/M+bltX/dKjZNDDhZ0w2g2IUKMB8oHtyK1IG3DwsIlfp1SM90czYBlVThikeYcxP2ImnE6wVIMPhJCLBhi1+BBW8ZY7MzmCkBVKaFwy1R7dINIvSOxpocLEkFLdkJTJlklp7pfq6prDde7w==
Received: from BN9PR03CA0972.namprd03.prod.outlook.com (2603:10b6:408:109::17)
 by EA2PR22MB5019.namprd22.prod.outlook.com (2603:10b6:303:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 17:18:05 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::68) by BN9PR03CA0972.outlook.office365.com
 (2603:10b6:408:109::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 17:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:18:05 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 3E2811290D;
	Tue,  7 Jul 2026 20:13:02 +0300 (EEST)
Date: Tue, 7 Jul 2026 20:13:02 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: David Heidelberg <david@ixit.cz>, Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Greer <mgreer@animalcreek.com>, Carl Lee <carl.lee@amd.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tomasz Unger <tomasz.unger@yahoo.pl>, oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v1 08/12] nfc: Unify style of of_device_id arrays
Message-ID: <ak0znruBO6M7Ough@zeus>
References: <cover.1783091699.git.u.kleine-koenig@baylibre.com>
 <583375dcd834f5edf6241b09cdd75ad4f32af668.1783091699.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <583375dcd834f5edf6241b09cdd75ad4f32af668.1783091699.git.u.kleine-koenig@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|EA2PR22MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: f8eb5f05-4da9-4655-0703-08dedc4bb550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|30052699003|23010399003|376014|36860700016|82310400026|22082099003|18002099003|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	n+2m7oQPgGlM5UCP1liI+ne65xnAzWAiAeTpgTe51oz00Td54Fsxn5+rQwKkwx3UjmXTg9Ck8j7jtme7QZmHvrpnaX+0NGQNdrtLXu2kj0D/CRiopWKq9F6C+xfpROKk3EAWrSQbJf/SyHMGUyylKJ9fVquhLFbgv35/IfXDARzYq7+xj4j6unQNHoNhAYRFvVa/pU1Sy6nnqPQBd0Q652EuYB3QG8oXwjoh0coc3t6sLhMp3lpx0XfFlkNFW253M9PAkdtKGGCRYWz9A5dFlEXsxkiIqWqxYggUxt1aCTfp4dg8NF9rPqJyxjiB7qUOaFeONtmWxDm6Qaa5j24hnkwBjCitgaj/Yg++YlXUqcj1Up922UsJ34PwDe5XTXXSRtJvwKww9u4cP03kfyCZzfxs5kxdIh3oDDH2/L/Pg4v7q6dDIjLkIN74JA7mBR0fMMpUEz0Vgwq46i2ys85tWnVpPkJgCnbloUOq/WdULV26ybN8/cONpQU/lojJHY4x3uU/vh6fSeR9kIJnlkgO1p9HyzeJEkOInOVUiT3x06AMkJ9F6hr86f8mr+UYU9ruNHT1JLRY6TQsS06EsgMvRDd8hG1TnbI7dJOcKQWtoZEWJzPyMvfo/0PbBiMCqr7i7tzTMvHGCwE7s4KQhGH20ueajqLoTkB3L+Fz0SbbVbXr1bQLILxTUx4KkJXx7sNNFF220uIMBfoLnHQgpbkipA==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(30052699003)(23010399003)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LwxiCg/qDFDJFdqC4j9k6Bp1f1rrXpId99muEv9XqFpwLEEZqiWndBbw163DrkjnQM2ITJ3hrXm4FT+V26ec3SHOrxEBvNiX0hRWiSM63L+n+I0NIRz5Dlz/+uBof2NVmRS+tP9hvig7bAbJBOVpdYnjUg+YAAUa8hS3UQnYtwO3geF48a435CG4Q1zrb/8GM9I3plGYJjdBGo6HX5W0FZcxsDJSDuZGOEMo6BHl26KrekVqR4Qrp9BYngHX3BzDNXXfNN7Il4g8whTo64v4098tZW8L/CFmdwBjw+ou1XgJwev0RCPmHTFnGC3lbsyZjoYJ6zdRWojOWAAq5JkTeKNSYYoU0ZAODGY19OmESPsYgDbvNDj+/ByoQWxKjpb7/TVJN52af/25KiqPOkqpjoArAERA4TFTivwU2pR6YX5Ups7ORlf9akvr6JcR1WU7
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:18:05.2997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8eb5f05-4da9-4655-0703-08dedc4bb550
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5019
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38767-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gehealthcare.com:from_mime,gehealthcare.com:email,gehealthcare.com:dkim,vger.kernel.org:from_smtp,baylibre.com:email];
	FORGED_SENDER(0.00)[ian.ray@gehealthcare.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:david@ixit.cz,m:krzk@kernel.org,m:mgreer@animalcreek.com,m:carl.lee@amd.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:pengpeng@iscas.ac.cn,m:kees@kernel.org,m:horms@kernel.org,m:tomasz.unger@yahoo.pl,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[ixit.cz,kernel.org,animalcreek.com,amd.com,redhat.com,iscas.ac.cn,yahoo.pl,lists.linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EF3371E3F1

On Fri, Jul 03, 2026 at 05:46:22PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The most common style treewide is:
> 
>  - A single space in the list terminator and no trailing ,
>  - No comma after a named initializers iff the closing } is on the same
>    line
> 
> Adapt the of_device_id arrays accordingly.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  drivers/nfc/nfcmrvl/i2c.c  | 4 ++--
>  drivers/nfc/nfcmrvl/spi.c  | 4 ++--
>  drivers/nfc/nxp-nci/i2c.c  | 4 ++--
>  drivers/nfc/pn533/i2c.c    | 8 ++++----
>  drivers/nfc/pn533/uart.c   | 4 ++--
>  drivers/nfc/pn544/i2c.c    | 4 ++--
>  drivers/nfc/s3fwrn5/i2c.c  | 4 ++--
>  drivers/nfc/s3fwrn5/uart.c | 4 ++--
>  drivers/nfc/st-nci/i2c.c   | 8 ++++----
>  drivers/nfc/st-nci/spi.c   | 4 ++--
>  drivers/nfc/st21nfca/i2c.c | 6 +++---
>  drivers/nfc/st95hf/core.c  | 2 +-
>  drivers/nfc/trf7970a.c     | 5 ++---
>  13 files changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
> index 687d2979b881..068c5d278a35 100644
> --- a/drivers/nfc/nfcmrvl/i2c.c
> +++ b/drivers/nfc/nfcmrvl/i2c.c
> @@ -246,8 +246,8 @@ static void nfcmrvl_i2c_remove(struct i2c_client *client)
> 
> 
>  static const struct of_device_id of_nfcmrvl_i2c_match[] = {
> -       { .compatible = "marvell,nfc-i2c", },
> -       {},
> +       { .compatible = "marvell,nfc-i2c" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, of_nfcmrvl_i2c_match);
> 
> diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
> index 8dd71fed8493..34842ecc4a05 100644
> --- a/drivers/nfc/nfcmrvl/spi.c
> +++ b/drivers/nfc/nfcmrvl/spi.c
> @@ -182,8 +182,8 @@ static void nfcmrvl_spi_remove(struct spi_device *spi)
>  }
> 
>  static const struct of_device_id of_nfcmrvl_spi_match[] = {
> -       { .compatible = "marvell,nfc-spi", },
> -       {},
> +       { .compatible = "marvell,nfc-spi" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, of_nfcmrvl_spi_match);
> 
> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index 39b43f8f3bf0..d424452934ec 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -355,8 +355,8 @@ static const struct i2c_device_id nxp_nci_i2c_id_table[] = {
>  MODULE_DEVICE_TABLE(i2c, nxp_nci_i2c_id_table);
> 
>  static const struct of_device_id of_nxp_nci_i2c_match[] = {
> -       { .compatible = "nxp,nxp-nci-i2c", },
> -       {}
> +       { .compatible = "nxp,nxp-nci-i2c" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, of_nxp_nci_i2c_match);
> 
> diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
> index 2128083f0297..66d201c14a40 100644
> --- a/drivers/nfc/pn533/i2c.c
> +++ b/drivers/nfc/pn533/i2c.c
> @@ -237,14 +237,14 @@ static void pn533_i2c_remove(struct i2c_client *client)
>  }
> 
>  static const struct of_device_id of_pn533_i2c_match[] = {
> -       { .compatible = "nxp,pn532", },
> +       { .compatible = "nxp,pn532" },
>         /*
>          * NOTE: The use of the compatibles with the trailing "...-i2c" is
>          * deprecated and will be removed.
>          */
> -       { .compatible = "nxp,pn533-i2c", },
> -       { .compatible = "nxp,pn532-i2c", },
> -       {},
> +       { .compatible = "nxp,pn533-i2c" },
> +       { .compatible = "nxp,pn532-i2c" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, of_pn533_i2c_match);
> 
> diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
> index e0d67cd2ac9b..83c1ccda0af6 100644
> --- a/drivers/nfc/pn533/uart.c
> +++ b/drivers/nfc/pn533/uart.c
> @@ -238,8 +238,8 @@ static const struct serdev_device_ops pn532_serdev_ops = {
>  };
> 
>  static const struct of_device_id pn532_uart_of_match[] = {
> -       { .compatible = "nxp,pn532", },
> -       {},
> +       { .compatible = "nxp,pn532" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, pn532_uart_of_match);
> 
> diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
> index 50907a1974cd..7fde3aefae70 100644
> --- a/drivers/nfc/pn544/i2c.c
> +++ b/drivers/nfc/pn544/i2c.c
> @@ -938,8 +938,8 @@ static void pn544_hci_i2c_remove(struct i2c_client *client)
>  }
> 
>  static const struct of_device_id of_pn544_i2c_match[] = {
> -       { .compatible = "nxp,pn544-i2c", },
> -       {},
> +       { .compatible = "nxp,pn544-i2c" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, of_pn544_i2c_match);
> 
> diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
> index 499301a6fa3f..4ba762611711 100644
> --- a/drivers/nfc/s3fwrn5/i2c.c
> +++ b/drivers/nfc/s3fwrn5/i2c.c
> @@ -211,8 +211,8 @@ static const struct i2c_device_id s3fwrn5_i2c_id_table[] = {
>  MODULE_DEVICE_TABLE(i2c, s3fwrn5_i2c_id_table);
> 
>  static const struct of_device_id of_s3fwrn5_i2c_match[] = {
> -       { .compatible = "samsung,s3fwrn5-i2c", },
> -       {}
> +       { .compatible = "samsung,s3fwrn5-i2c" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, of_s3fwrn5_i2c_match);
> 
> diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
> index e17c599a2da5..8f142a255101 100644
> --- a/drivers/nfc/s3fwrn5/uart.c
> +++ b/drivers/nfc/s3fwrn5/uart.c
> @@ -85,8 +85,8 @@ static const struct serdev_device_ops s3fwrn82_serdev_ops = {
>  };
> 
>  static const struct of_device_id s3fwrn82_uart_of_match[] = {
> -       { .compatible = "samsung,s3fwrn82", },
> -       {},
> +       { .compatible = "samsung,s3fwrn82" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, s3fwrn82_uart_of_match);
> 
> diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
> index ceb7d7450e47..152c20b6bb01 100644
> --- a/drivers/nfc/st-nci/i2c.c
> +++ b/drivers/nfc/st-nci/i2c.c
> @@ -270,10 +270,10 @@ static const struct acpi_device_id st_nci_i2c_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, st_nci_i2c_acpi_match);
> 
>  static const struct of_device_id of_st_nci_i2c_match[] = {
> -       { .compatible = "st,st21nfcb-i2c", },
> -       { .compatible = "st,st21nfcb_i2c", },
> -       { .compatible = "st,st21nfcc-i2c", },
> -       {}
> +       { .compatible = "st,st21nfcb-i2c" },
> +       { .compatible = "st,st21nfcb_i2c" },
> +       { .compatible = "st,st21nfcc-i2c" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, of_st_nci_i2c_match);
> 
> diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
> index 8632cc0cb305..5e0b94050f90 100644
> --- a/drivers/nfc/st-nci/spi.c
> +++ b/drivers/nfc/st-nci/spi.c
> @@ -284,8 +284,8 @@ static const struct acpi_device_id st_nci_spi_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, st_nci_spi_acpi_match);
> 
>  static const struct of_device_id of_st_nci_spi_match[] = {
> -       { .compatible = "st,st21nfcb-spi", },
> -       {}
> +       { .compatible = "st,st21nfcb-spi" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, of_st_nci_spi_match);
> 
> diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
> index 4e70f591af55..a4c93ff7c5b0 100644
> --- a/drivers/nfc/st21nfca/i2c.c
> +++ b/drivers/nfc/st21nfca/i2c.c
> @@ -584,9 +584,9 @@ static const struct acpi_device_id st21nfca_hci_i2c_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, st21nfca_hci_i2c_acpi_match);
> 
>  static const struct of_device_id of_st21nfca_i2c_match[] = {
> -       { .compatible = "st,st21nfca-i2c", },
> -       { .compatible = "st,st21nfca_i2c", },
> -       {}
> +       { .compatible = "st,st21nfca-i2c" },
> +       { .compatible = "st,st21nfca_i2c" },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, of_st21nfca_i2c_match);
> 
> diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
> index 1ecd47c6518e..265ab10bbb61 100644
> --- a/drivers/nfc/st95hf/core.c
> +++ b/drivers/nfc/st95hf/core.c
> @@ -1056,7 +1056,7 @@ MODULE_DEVICE_TABLE(spi, st95hf_id);
> 
>  static const struct of_device_id st95hf_spi_of_match[] = {
>         { .compatible = "st,st95hf" },
> -       {},
> +       { }
>  };
>  MODULE_DEVICE_TABLE(of, st95hf_spi_of_match);
> 
> diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
> index bc01b46f461c..3802081fb8ee 100644
> --- a/drivers/nfc/trf7970a.c
> +++ b/drivers/nfc/trf7970a.c
> @@ -2304,10 +2304,9 @@ static const struct dev_pm_ops trf7970a_pm_ops = {
>  };
> 
>  static const struct of_device_id trf7970a_of_match[] = {
> -       {.compatible = "ti,trf7970a",},
> -       {},
> +       { .compatible = "ti,trf7970a" },
> +       { }
>  };
> -
>  MODULE_DEVICE_TABLE(of, trf7970a_of_match);
> 
>  static const struct spi_device_id trf7970a_id_table[] = {
> --
> 2.55.0.11.g153666a7d9bb
> 

