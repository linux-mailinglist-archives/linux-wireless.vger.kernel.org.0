Return-Path: <linux-wireless+bounces-25885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C22B0E615
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 00:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58021C27C87
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F2286412;
	Tue, 22 Jul 2025 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="kryUJTmv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013075.outbound.protection.outlook.com [52.103.51.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61145285C89
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221988; cv=fail; b=HGiSi+8cUzoWauyuAyJYgdizCMa/ucDiuGGK3I1urk3sZAuuxWAAuSTN2GMhcF5EgQatnhLMJVIJBM1QoDDf+HoYxxqJKJ3AWygJnFoCDVyFuWXVFlcKRLBG+HOk1wfM9w+U47XE0ESoq1OKYiPA+SY5DcN1wLnB0w0Dw7ECi0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221988; c=relaxed/simple;
	bh=5wUFlIHdxcy+LX8pDlGBQBc1mijmNThEmxOC5233zQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uGu9uDsy2PzGwhBxUDprWlgWzCb8Io5cxFwaDMnHhcyBJSaPqnmE8WUaVI4exXhl5CdAaLvzckfVw6A2NCHfJpFh+kah5/ECd4lBUw8IJS7LRnU8TPsn7nudoIDdmDflpCiPmUNcvVHocE55nkKh/x9n+mB+/RE630a4wgBNMRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=kryUJTmv; arc=fail smtp.client-ip=52.103.51.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUM+A4Z4vLecvbGC7C2Z1O5wNAKgRke1MUcTXAkZBfy72OCNmOOOLZu1mKgpu5MdE+8uDA9vkTMLZKDJrYyHAQBv09/mx+kg/i9RtynwOO61iGbAwm/N7q4XtPVR4xJcG2a6ahIDnfxpWccCOW588GmEKdTWZMUvzqJxSQqRf9KVrVOmoc+dr8SqsHAY1HemGv4jd5RmFPUynU8JnsxkW3JIwISm3Aoxwk68VlsbTqA/QBIxXZtbt8PVXuvJLSrNLKHIuSliPoXOlFfPr8CMNM1Q4EtFi4b2lqrMMujgiyGtLLtJXj9q7s+c+Le56oUzinyc8fTUNSk4exuZCqM7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72wXplFtB2znsl5m+NUxxxlPUr4BLFVKu6bG/BkTmKg=;
 b=p/TTIFCUbbslvhvxd/9MXxeBiaN7zus25bmXIpx/d9N+jV/Lr8JRnbSqI3CbdAbCSOJmDXGmOXLF0tUrfVemesSVq8p6zzi2dVw45pT9ov07KbGNxeIImTjJae//u/zdtc8jw1Ks6P/20myeKuZX9jl62KmOaqHxgLEEUsYrKjXKzRxumSty+mWJ4WRmw8arI66fMoJwgV6fCnRHUazsHMmGnlt3OMycxLz1PsZiqyN8ZZugYZLZ74PKfzN12SCIAKApLsGt1dhQkDzkFel0AoLYbfwLGxa0+EVXv+Y4ohPEJDQ3sOx0cUxkw8xzfbVlJt5L/o5Thl0LoQ+vy+JvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72wXplFtB2znsl5m+NUxxxlPUr4BLFVKu6bG/BkTmKg=;
 b=kryUJTmvoeWBR95HWw/Gu+GFQ0lfy97wr9iIevpE9Mhi7QAbcvTnbFyo9rgg3knzNmn4AEbFQflGOiSb1MsVa4UNbOCt1FCYc7i5HBeSnuIcra3VHtoLsJJ8rH/HZBi4R+Gp8iAfmWE/GfYMU4mEyXtOnJHpvaydD1SNIcLTjExVhOKnyFElgaNwDxS5X+R2eIF+2JEaZle6XtwGzLULAdT6fouqVGTgtdC6A6NSznePCtIoiRePa2K1ZgvKNF46SgQFC/DcVUe+myZZYU/R5qu4mQQWXXH0/AD9ESXGBdi7YslnxAp6zBhEwa0WEWL3dHEAx8HzA7tRTIdUhwtBjg==
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com (2603:10a6:5:3::15) by
 AM7PR02MB6050.eurprd02.prod.outlook.com (2603:10a6:20b:1a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 22:06:23 +0000
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963]) by DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 22:06:23 +0000
Date: Tue, 22 Jul 2025 23:06:21 +0100
From: Cameron Williams <cang1@live.co.uk>
To: johannes.berg@intel.com, linux-wireless@vger.kernel.org
Cc: regressions@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Subject: Re: [git bisect] rsi_usb oops
Message-ID:
 <DB7PR02MB3802D0C33789AD0A70874778C45CA@DB7PR02MB3802.eurprd02.prod.outlook.com>
References: <AM0PR02MB37936431F3602A64BAF8550DC46DA@AM0PR02MB3793.eurprd02.prod.outlook.com>
 <1dd41163c95eb818d13006ffc07b0815ce10b1ec.camel@sipsolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dd41163c95eb818d13006ffc07b0815ce10b1ec.camel@sipsolutions.net>
X-ClientProxiedBy: LO2P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::25) To DB7PR02MB3802.eurprd02.prod.outlook.com
 (2603:10a6:5:3::15)
X-Microsoft-Original-Message-ID: <aIALXQdetKB4vsyC@CHIHIRO>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR02MB3802:EE_|AM7PR02MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: db1ad1f9-80e3-42f2-c534-08ddc96bff0e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799014|15080799012|19110799012|6090799003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yW5X/7oE6QK2SUm+aP/vmYCR0reyNn+Q3/HiMBIxF62Q5lEC8Cn28aLr0oGU?=
 =?us-ascii?Q?5eIrpsLFRI/OwefI6EetxFPWYfCiHekCfaKQZXebbX1Wt/xsu9s5s2qpXMxm?=
 =?us-ascii?Q?EMFpC//b+EbKy8plKnvnIFw5lYwVi72UGbPsnDAsFGmy8Z2aoKlUI1I9+Tp/?=
 =?us-ascii?Q?c1hCWuxuLCV0BnWbNu2GKVmO5v28gfftclPao4xD8uA1etshlobpY3kGaUrY?=
 =?us-ascii?Q?Eq36toVTn1ylBGbIwO7/wKW4sDofWb9sakWJXPWsV7O9vd83LTh8N/xxhxbB?=
 =?us-ascii?Q?BvOIu0C/eVbjbCenN1SObzZvmBF0mEZL+4QnPFfTXDOhEjEyzMAAPNGdu3hK?=
 =?us-ascii?Q?jWPOoJ3GCwke0o20kGcq85+fo6/Gq/9oxix+JtzX+IesZ2g2ZhfhZHDL8nf8?=
 =?us-ascii?Q?EO2V8fhMiZXO4Wg9lHEzf2YyxZsPcephAp4uSLWMXb5Wait+gKGoPLDrEoan?=
 =?us-ascii?Q?oAXi1NGnVregy41mUage/CMqUWiCtwE1U+fV8RbMhhu4R7+SaLQ2Y7+OEx4M?=
 =?us-ascii?Q?/h8BgrW9kxSu9K3J9jQj0JRlheBG6atzKz+Hl63NtqTLxe4iTZZPgXad+X0c?=
 =?us-ascii?Q?gIQVoSBM/MiY5ME5caOMj6uGZQRXoE3HYynQzrDc5Jnzyg6xlJ+MTGrVUUjg?=
 =?us-ascii?Q?a4J9oDzLcDKz4Gfufon/74TlsQ6xgIoDn39VGbvQbeqRU0x5US8t4yFu43FS?=
 =?us-ascii?Q?xRIUGnvEuo8J/4ty7Tof/DU4g7U3uVFtZWDuWUg29jF1Tkq0333Jc+cEk4Mt?=
 =?us-ascii?Q?DG4Ucty+dtZoV3MQJ7F6mXGJRh/7Bz92LSiqe8jwKgeD9IPIcH/uoHPlB8b7?=
 =?us-ascii?Q?iH+izdGi0zLNTGIi7izYtXj0B4RdvX4Cz/Q/j09rr/r/xNaJG4d2O93TxgbN?=
 =?us-ascii?Q?l3wh6n7w5os0EEN26U7WUG89AsusrPiHpzBVkr1K6ZVGI6L1FbHXAATFOZOB?=
 =?us-ascii?Q?e2RSm62tpR2yeSq6tGXSmJ/QxyQSLYQ8MLiZ/x6grPLhw5E/joSy6M7TK06L?=
 =?us-ascii?Q?ucQE9OJRRaMvJRJXP8ovdaHstVlMxTzQ4ZOwawqO6oZSLORXeozkErqqlh9L?=
 =?us-ascii?Q?h83X+TFFKshGxY1n6+yUba0X/NYRL9te2Z+EK/ptevxaSvLJ+L0ZYu7BsNvl?=
 =?us-ascii?Q?GVZc1xJzje9TVGonCOiR3BQdQ5+PC1PZ6w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ncbWYZmefxYNK3cxEGVs3pA+ZdDxk4Ovp20uJ3FuIeDOV1Pg40+KjiKAEi1m?=
 =?us-ascii?Q?agy19OgmjU8OoRctW6ujl6iqhB3720MtW3pNCgGKsFj6VXiIUHNO4HQihSms?=
 =?us-ascii?Q?JITNjGctVMfvss8y8w2Xa9+Vf6EdfSa4vV27KAOtDASzqGa9ojNXcchorbPE?=
 =?us-ascii?Q?1UHpEfo5hwCKm4HsSpeMgXh1LKVHJyuEi+OfO76JDOI3DxfGgGXyXqa91RW+?=
 =?us-ascii?Q?GySVa21MfdBLqWqAXcWOIfuDf3lyBUPktd9YbU6uf0jMwux3/R5yzrnqi750?=
 =?us-ascii?Q?515ItLa1yJy3zEZuB7NPUEXGLdSn06JtwVynIJV0qIIMHKlYgT6Tkz95nXrO?=
 =?us-ascii?Q?JW+EwKcpekYOIyoulQdC2vcpLqhJKteLK/RfOVD0F+YsVy7hXCoDwgIBD8zJ?=
 =?us-ascii?Q?sjPeGJDe3/h+koWSMYPauNWVMxc4zRII7MdhpVIKYP4SpwjmV7hCWDMMEF/p?=
 =?us-ascii?Q?oyir7BNKN/UEu/gGwU2ifJceuXHQ0v+13o4Qn+HkN/swFpcmV5Y0+Dyw9KbH?=
 =?us-ascii?Q?xvXjkyfS14Wt1059yO6zGTgBubhHHAPN9rg8L1Vi+tACaD8RpVRem6AdLHW1?=
 =?us-ascii?Q?ynMRjKQ1m/guN3fn3JnOyPobrtd6s55JQ1kcXCZoVZ4XE2BkZE1p793WZta0?=
 =?us-ascii?Q?zppq9U7bAgmVai/QyG2BU7X/X8n8BYbKJcXHXCic+8WsteoFUuZoPbJaAgJI?=
 =?us-ascii?Q?Md5aeuDyyplwi2xUmTPfngzbd682VYHNdEM4q9oiD6FbX2g3ml/iOygpJfsV?=
 =?us-ascii?Q?Bl5XORssHilRnwySQW+pN+DsixSq8lNH73gMBrj9PIV4fipNOmI7NQ9YDSCg?=
 =?us-ascii?Q?eRm106lLPrHfzr9AySeHXUG+Z8rza/HjJ+25Kqw36hitmUqCnoiw7872X2Ha?=
 =?us-ascii?Q?mNbIxldheXOQd69cdNErykmHRqKp86cNif8EEhgxlQgqKer0m2mJU5RXdk6n?=
 =?us-ascii?Q?k7D8RtfoZ1AqmJvkE8yvPYRuTYDXEGX/tQdGwdOMb16RmnG3xHzDvNgbvzqd?=
 =?us-ascii?Q?5dZbnPgetYYgqqMH1xTRoyojJRLSts3TE1+B6XYaVcz++NMaBVkS2CN5nXXi?=
 =?us-ascii?Q?gcotKC1wKxQWK0oZY0EM/jE4K9eF/rABfhJf//wwFrSWrRFlY8fFMdCNKTuo?=
 =?us-ascii?Q?NslJ9boJOmYd5GW8D1WBnxnB6UftQ3WxQr217LASfvDyPhIb6LrnIQ1XaTCg?=
 =?us-ascii?Q?n8LKQRVHKUHWKYvnezYepRA7K74WKg9vU1xPbg=3D=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: db1ad1f9-80e3-42f2-c534-08ddc96bff0e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB3802.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:06:23.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6050

On Tue, Jul 22, 2025 at 05:52:28PM +0200, Johannes Berg wrote:
> Hi,
> 
> > Commit 378677eb8f44621ecc9ce659f7af61e5baa94d81 ("wifi:
> > mac80211: Purge vif txq in ieee80211_do_stop()") seems to
> > have made rsi_usb/rsi_91x cause a kernel panic when
> > removing the USB while the interface is up.
> 
> So it's been a while ... is this still happening?
I checked a few versions ago, I can't remember which one off the top
of my head, but yeah this seems to still be an issue.
> > [   81.148175] [     T11] RSP: 0018:ffffcb54c009b918 EFLAGS: 00010202
> > [   81.148466] [     T11] RAX: ffff89629dff2328 RBX: ffff89629dff2328 RCX= ffff89628cb49210
> > [   81.148757] [     T11] RDX: 000000009dff2328 RSI: 000000009dff2320 RDI= ffff89628cb489c0
> 
> This is just ... weird. RDX and RSI are pretty much holding truncated
> pointers of RAX and RBX respectively? How does that happen?
> (...)
> but that's about as far as I get ... I'm probably just chasing ghosts
> and completely wrong about all of this...
>
I went down the same rabbit hole as you and came to the same
conclusion, at this point in the code it was just going over my head.

This driver and chip is a really odd one. In the proprietary driver
for this chip, it brings up a virtual "rpine0" interface along with
wlan0/hci0, and although this tree driver doesn't do that it wouldn't
surprise me if there is some inspired logic in this driver for that.
> > I have kernel dumps, vmcore dumps, whatever you may need,
> > any help is appreciated!
> 
> If it still happens, I guess it might help to put some noinline
> annotations on some of the functions involved to get a better handle on
> what exactly is being passed. And run it in a VM ;-)
>
I will try this next week sometime when I am back from vacation and I
can access the chip. I will have to play about with inlining the code
since C isn't my strongest, but I will try and get you the details.
Thanks for looking into this!
> johannes
> 
Cameron

P.S. Thanks for the notice about Outlook bouncing your email to me,
I know exactly how annoying M$ can be about blocking whatever it
feels like. I should really switch at some point...

