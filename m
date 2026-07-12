Return-Path: <linux-wireless+bounces-38912-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7mS2CGNAU2opZQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38912-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 09:21:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D297440C8
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 09:21:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="RibjS0/a";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38912-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38912-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81D473011871
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC23370D55;
	Sun, 12 Jul 2026 07:20:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012B30EF77;
	Sun, 12 Jul 2026 07:20:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783840842; cv=fail; b=SyzlGomoNYxqQm+1OfXOYGIt2/j7D5ayaKNk7wOcQD9aeXDVj4PXxcJ4s6m5p4gnPGcyV3yznHOW+6CvTqe82rhMAfeKPs4l35Dwku9MAJKP63oN1nJx2W40BQ8xvYA23v21euv/Q+X/Or/K0G1vm35wmrWZ3gQoXSDJqaeFFKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783840842; c=relaxed/simple;
	bh=Jig94UUIbU2c8uDNuN8z8WbS9KoOtHZ6mquJ4fgjpss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ekvIfhuTzfB24NVuCT4RFwe0+XrzHig9Kp1qhu74ORXXERF8WC3WfLRZuB9qdCTV/2MOS6iqyqK3y3KcMq1sAKzSooOKMU5TrkHpQ5v9udHJDpgKJhK65f4QyALifGZ5WVILLSZIb2bHlVMfVxOCeCxC91DdKWUC+/MNTD6wOfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RibjS0/a; arc=fail smtp.client-ip=40.93.194.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEdfPRI77D0H61vAus85oWREzQx586gQccT9FvQYlw6LqWXJDlTiQpXWgwp4/6YeFjuL6k3J5jseVAwHFBBayiVgZjn0Vp7waM7VMDQQ9fFdwYk5cMuj1N1Dy2rsBAHMufp51z+Etz22NjnVJPS8jfKpilsRxcTdX2aW/F4m9krhbSeO5CoxrKsOptrW3UVFBQBB4JAP1Is3qEP0Cr2xDAZGG0SQ7i29lwXwQqZM9NhFRDIaJ9/vGdt4CvByTOVr2n2om3j6vAAZ0O6pkQcFQGq6QIcWn5OyJhI7A+cszW9a9DQlsKI1oYoZxmt7YZj74wFJSXEfsJzcthx29f4zcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epmglJ7bAnkCjl9MitqHhswibEtF3s/qH/WIYCFY+bs=;
 b=LZVS8Slxd8Wz4vOpVLqHJNldtYSZ6Umqilaa9nPShvj7G4QTNoO3GgVRT/qF2iyF2hOzIK3v7SM/AbPaYkreAifDy87QB9Z2xAWvKAkOg6P01kvDdTQ2j66qQ+Ra4/046EA6p/8LN1g+aq/dAA/aB/4BdQvnnHgesQ5tt8kFmDEi29nWb+VIIrE6VL/icfMYvOFYHOmQczldjxw0Tu3WCMYeeQTWlQopiPtb7fzEqRJxgE6lAiqftY8kxXylCqzU7TmgZFSZ4RRkjeoSWvI3EKk6J8IsBPRWMRc5efDERMpxhROGXrkhrJ9asSn/QU0oAIO6mznfPX2QOiZX4bWFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epmglJ7bAnkCjl9MitqHhswibEtF3s/qH/WIYCFY+bs=;
 b=RibjS0/afop6eWRaAjy8s/xCjmVomMH0L6to6nr4QxVEm3uo0Gr3qmZ1wKlJxcpAJfnsLl6PT8HHCiLqGQ5QtsJLtBBdQLkNshFZtvxW1VhJ5sftN5WONc0/J5yZD8RxoUu2LWOINsk4BvqPHU/aDvOp081Dkam/QfWGf+5xq+nWw5dX+mJ/dFxKmmCcIMVZtYy6jKIKmRzIcVEwLfUhsSAQ1IolA/Gc6t0aXVcNyj9VuTzTo5errCima1ccFRhd5jCdGmweiskd+Zx+K+2KGkl2w45CnGVosdn/rneA4oDiR/FuRz2yzqGBOP35gQ0fFGygC3qIN95eUfdP5jdylg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.22; Sun, 12 Jul 2026 07:20:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 07:20:34 +0000
Date: Sun, 12 Jul 2026 10:20:25 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Elad Nachman <enachman@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next v2 3/3] net: ipv4: clear dev->ip_ptr before
 destroying inetdev
Message-ID: <20260712072025.GA135396@shredder>
References: <20260711005405.2861680-1-yuyanghuang@google.com>
 <20260711005405.2861680-4-yuyanghuang@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711005405.2861680-4-yuyanghuang@google.com>
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 0851897e-21b8-48f3-075c-08dedfe61038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ou8i8LZzLT4D6z1687gBD4yu6Y8TTHAnpY68RXO/shyGuUDGAcP3KL0VRXdXT6bZwFrO/GpzEN+0Yopt4dfsSyalqUcFYvkEvkWiO+6Ru1UvMZQYP5lVunxaERUVEAFoSkwD1af8MWeQQWnJQaujsQa9aEQooWWdjz1a7SYGbnjUwgn8xpsohWFgWK+iD9powoAS0MY7zIz5ifNxpLGWws+avw8EHx5YzBWOOpLDddEx5IqHAywa82B0E6WngQblW7cNZEDzwkpni6okxZyUPiVgkDYesm26mvRstRRXSRwW9SOkp2ecFa9wBexu3FztC21jZqNzcKpPUqBOlSH4cDwEQ2bgrQVZNKyDoVVd/VIqEAiQPVGYodVmljlna0ZNHoT+CqXPkkaANZnT2Dai9zSjbkvPx4SP2NOacFN7IFGe1ongW4EWVPN4kkKBsH4BhCx2K9EFFqRDt7hB4ytE5ifJ2briPO72VBn/2CMOgpYcsyeuHGPE/DyI9m3Z8L0bmOlpMReJ1yHKU+NMM8MPakQYy2OuMBT76Hp9B8s5T09bb+Imlo44W1MtdoPal+ZK9/CGzkAQoQlFz6Bd3IMoCEq2w6Ay8V6q+fRblEYkH/dxec8z3XS/De8wxAO/GQ7x30vyJlHCM8zTeXV9ej+/lyYe767MuGCLw452xD258KM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nmr8LPdh6eO3OpwWN40VHEehZunjcKLhHXG8CXstardSneldDcHsapj+VQuQ?=
 =?us-ascii?Q?IUMUe3RUjmpRrefW5ytoeawfhyg8dRo9UfhDV4HkBlx9i5cybVblOp5TNz4Q?=
 =?us-ascii?Q?Dv679cS1P0Edl4kSXSlil888Lji3GBBiO5A2g5zPJ7PZKzkhpWvWEZidORdH?=
 =?us-ascii?Q?tSt2wOzaFqI5rvhorSnRWENitqNgCgufY0pBKgUawM1PJNcD6y/ZRbztpcMM?=
 =?us-ascii?Q?U0ya41iPyypG3hfWj8WdbGMiMBa1azDIOwpmuxQoOw9hxF7jbozkO85S6Jmh?=
 =?us-ascii?Q?+piYGD1RY84I3OQqiQSlE7KIr6bBmpZAYCe6hq66/NwZKee0rncQKLxSkt8Q?=
 =?us-ascii?Q?F0VtHQE2aI1bSj7iwXRTu6qUaYxe+cAg6Kmf3MJApyOTwtwKRj5GbFeFDyJE?=
 =?us-ascii?Q?+X0N1tKJuPjBxbd+SRvSdnkkjR+UhDq1d2OiHjhSQib1CDb8klrbFwo5i0vW?=
 =?us-ascii?Q?H8802wsZoGX/A3YlxL3iYcVq2srxbOgjvjKD0ReHy0S8Xi9Nam3kSA96lbJK?=
 =?us-ascii?Q?VGbSYKB7dPvw1FBjYmFF54n/3YNpH+ui2UALUv4uZhTXgNztNPUZeLK2A6fM?=
 =?us-ascii?Q?LrO3J2YlgKp0ZbweMUCEUmKyKGxSo6RzBjoYGXlKtcFOvJmRiYRxN+1DkJDJ?=
 =?us-ascii?Q?BeRvrSYBF3UpZZ4Bi7UNz2+hPm9rRh6WFlIQgqhLnL+s7hDI2mKjjP3zmQGA?=
 =?us-ascii?Q?eApMIr5mJu4u1V1HwUqgA23tD68TPsMILKIRsqZ7laRmQlXHMbn5z7w1PGIR?=
 =?us-ascii?Q?yp/1DJ7dK9Cn10fWlu+QQqlvebkL320CRA6rgZ9NqqBTkF02WqiD8LjH8/hm?=
 =?us-ascii?Q?3kruKnGjwBGFV06l4HH5SC9z05PsibC39ggslTthDQJZq+DIQvgGOEPGKKxd?=
 =?us-ascii?Q?BwmISV/fOwKCX7GlEd+6hSUTCM1H1BI17Uk26GPW1GwC1zRIbty2x32po8kb?=
 =?us-ascii?Q?SXKRTqjZLoqKXxVyy9P26ioRxeHhlRM84ev5paspp9mx4EOxRVWqWKuVnP/o?=
 =?us-ascii?Q?pmajsKwLw3pjg6sdr5bz81yJ+9xsLSbdXwIslKgTx38qRmgKsdgzO9/w2jAB?=
 =?us-ascii?Q?YMRLrZ4/yD9zEeX5iDeiHP4JoHmIak+blYkTFbDWiBs+7ove7rXSGl05r+bk?=
 =?us-ascii?Q?bDdHlZimQ9SmyitAH5or9bKZdxgdmU3ruOsn4DDizOs2tOr6V1WqB+cXm3Rz?=
 =?us-ascii?Q?o6eMZJBpor/rm1J9hR6/m46JaotSY7jjclGBdxCEENKcenO1cZXeF6HgFjvo?=
 =?us-ascii?Q?i72S6t7dnGNycsDJ2YaDQrZz6L8e2bArYVuKc3f/fudXbohIMMb/zwXKUjKw?=
 =?us-ascii?Q?mCo/9AnmLvjwKo6L61yCyLKi5fMNq4NM52TLU2IS7Vj6PPcimPjLJx0O0yaO?=
 =?us-ascii?Q?2bNLvo4UI44jGjsaE3bltmbkrWEVZXIZhUrkSW8+UWyXZ4ZpZI1EAEYVk3FK?=
 =?us-ascii?Q?VhSFg0kD+dg+mOLg9yVHECpLmZmajA+vYKxYfYLsRwEVtVdR83mjICCDbIJO?=
 =?us-ascii?Q?HxNmKR/cAbrGIxMoEFCYQcxo3FLNWmfvqJqScRqZp0DaI9ymt812l8zYPkwI?=
 =?us-ascii?Q?ElAPh+A0q7N7BgpovDEoTK4gQK9FgKnV380Ea0AhErw30dPgvxQqRG1/d0us?=
 =?us-ascii?Q?FalcnB+ooM0UMCJ7cB4HsA30vsQfdPKUPn2MLQ3Ni13KmPHYAj+BwegDs2Qg?=
 =?us-ascii?Q?OQJWwjSumlBfi5Njhr8L728Kjc/LgwouC43SG9tqlvdE0467?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0851897e-21b8-48f3-075c-08dedfe61038
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 07:20:34.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAyfocI+qI1rSc9vupWq+DpnxnFudlU9Ocego7gw3PwTFSRTnmTK0okUKbmnrMX4HBsqtyG7aaxgmkIlxkEW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38912-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:enachman@marvell.com,m:edumazet@google.com,m:kuba@kernel.org,m:johannes@sipsolutions.net,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:kuniyu@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[idosch@nvidia.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shredder:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78D297440C8

On Sat, Jul 11, 2026 at 09:54:04AM +0900, Yuyang Huang wrote:
> To prevent RCU readers from accessing a partially destroyed in_device,
> clear dev->ip_ptr early in inetdev_destroy() before freeing the
> multicast list and individual IP addresses. This aligns the IPv4 teardown
> sequence with the IPv6 implementation.
> 
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

