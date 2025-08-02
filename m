Return-Path: <linux-wireless+bounces-26107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A2EB18DF1
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Aug 2025 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC74189DABE
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Aug 2025 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF0B1A5BA0;
	Sat,  2 Aug 2025 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="pP3GQ+TJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010021.outbound.protection.outlook.com [52.103.32.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676962E36EB
	for <linux-wireless@vger.kernel.org>; Sat,  2 Aug 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754130180; cv=fail; b=UMUaAlqwnVqTlJzNxTRHUeGwAXMGrifkUqmAwRgsB1auCr4VgOwwySZmHNAPxvdEvZawikjC7gh+YS/pUXE+NlaNjRWy3vRfxHRAja4eXRTmIZCVT1wnXLwT85VGsvw7sxAwDf9grQN0GZSpbj1zlapgmNX6BV2lujXZDTVgcIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754130180; c=relaxed/simple;
	bh=kcE8W+BoUm9OMlgYzeIRxtxlSTj1sPG3uVAUQ8KS9Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gs1u1aIUroV3YXXpN4CZoT/2OgMi8lgd/T5LUHEya+9MHF01QwG7YJD9pY8ukJSJfIGYUiBiYWyKTGIkLeOaxL3OCj11WhXPmnL8x/7adV5+2hIfjCvdjSs1CeeZhqMMWKc/VPPr1XGCRgoNP5IXP+6ncNazZIATda2atyHNghY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=pP3GQ+TJ; arc=fail smtp.client-ip=52.103.32.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxHPSmSRR7FOT2hQUMw+/xGAQqu/3Be1r4mXkQfEAFDJdgtzX8mPCuRrU8cC4pG2vLJ+RO4bcZ70/gaBBL7Gqz9bKw6BzVFitNPwYLpyxU6iXy7iN4pTA+YQM1pode22xCrqEI48dxibgGR0VLp4VzIvFBYr7/Tmeu5nREL21x6M9UA2EF8JM4oXmXW4v5lhAS0oo0MwikbOoOG8WFGJ3S8YzYLrFs6lNAJTyMtLuF/Ro2iYMbPV9+XhmlSvnbUXp5wECMM+KwGnXnlXnvhOXxs6Lv4szgQ0C/Y0KTb/j6S/ts1Z7yNcX1Fhl7+3DTyVlYRSz7wTDTmmiwb8epKtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEt5eQOp6yEJG0FUkYiw/Q62lkXmR3H5HMTiWZ4/krQ=;
 b=bYy1ZgpUb//hUWAzbnPrq5CjiG+QlzR7D/C80aPJVMIuJDWVrHCbh7gA8TSsMmvVJ4vE8Gqz6lZM94WGyCcGaRJXMFdf0zQYs8dVuwB+DeeBj5Yj5+NruJQ2lt8fIqvX+bwrmwukNaGIz0JgenozCFkx7yBQZdV3cHhQxeZzLfYczT2WfPDHCRCtxouSgwr3CiH1S2BBdArAON2k3bjKMVxvSomVWOTR9b6Vini1n3NEeYBsjXNDy7hTMu1VaIvxJc24pQum6H3j1rk3/TS6M1WzT00R2Byvj2cL3yNSDmLF0PIqgNi8jccnmV6Nsz4zVX5b5quiCTLQL3wW+CbJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEt5eQOp6yEJG0FUkYiw/Q62lkXmR3H5HMTiWZ4/krQ=;
 b=pP3GQ+TJx/HesQqYn0XqimIfN3dYIYbb5PRnhcRY0Oa646UymnspgyI67A9nPJ99RvaROStVWYkA0z2Nv2ftwx3X3qUB58RD1MhzEHKsF9TsPKwwfT3NB5f6IzyYzRyWmpmvLtE3TyiCbSTPM1eZ4nonCFH6hVowVLyi2In9C6p0OlaXEU3iEa6XPtbGmgbif1ZhlFP7pgkEB3fYppD+5RvW0gqwjRuo1BsI7oIt/QRpyViTOHdQrUrkjVnXysfA8kx7TCw/fJt+nyEnLiPKcE0sL9O8Ha0FgYxVhLJT8yBnVVuubbDkUuCIMY0ZbGl5MvL10HpjYIFokHMVhKWjYA==
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com (2603:10a6:5:3::15) by
 VI1PR02MB5951.eurprd02.prod.outlook.com (2603:10a6:803:134::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Sat, 2 Aug
 2025 10:22:55 +0000
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963]) by DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963%6]) with mapi id 15.20.8989.015; Sat, 2 Aug 2025
 10:22:55 +0000
Date: Sat, 2 Aug 2025 11:22:52 +0100
From: Cameron Williams <cang1@live.co.uk>
To: johannes.berg@intel.com, linux-wireless@vger.kernel.org
Cc: regressions@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>,
	johannes@sipsolutions.net
Subject: Re: [git bisect] rsi_usb oops
Message-ID:
 <DB7PR02MB3802992BB2105FF117E71380C421A@DB7PR02MB3802.eurprd02.prod.outlook.com>
References: <AM0PR02MB37936431F3602A64BAF8550DC46DA@AM0PR02MB3793.eurprd02.prod.outlook.com>
 <1dd41163c95eb818d13006ffc07b0815ce10b1ec.camel@sipsolutions.net>
 <DB7PR02MB3802D0C33789AD0A70874778C45CA@DB7PR02MB3802.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR02MB3802D0C33789AD0A70874778C45CA@DB7PR02MB3802.eurprd02.prod.outlook.com>
X-ClientProxiedBy: LO4P123CA0301.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::18) To DB7PR02MB3802.eurprd02.prod.outlook.com
 (2603:10a6:5:3::15)
X-Microsoft-Original-Message-ID: <aI3m_CAXL8TvLVXw@CHIHIRO>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR02MB3802:EE_|VI1PR02MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e1d711-fe39-4d3f-c95a-08ddd1ae8ad5
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayFsFQqi+E94pZCfOSwV8erpdPgJBMvTuXzaJ+KQPyijYFN71sckdNsv4iESHieh/lfMLhTtRG2ONVG8jXjGR+PF+THu/HvamFMKCdOcpyKOCm3AiatF5n6DBxRUtPNkirYRTs+MHWO1/O2VetOibGtz5xipm9ztU4nWjA87ExEL4N9jVOcuJOQiBgiHo75wMEIc4iP85hZuK/vzs1PA4MZEBtyby+sG6/bQWYmfSis7UwPo8VtmRZSU79JAme6pjqOnPZEcBMLPqPWiYQ1y+iXREWF/hZejjUR5b4/dBtIbpyupUX1AeurZjzP3PQDuAxf0qC9YDIlz6KtTPdOEHcUaOTszXNU5X8KwYT1Y0kGBNMl24tzDLekY99JFa7J/1pbLqtVynZp84hyF3ibSSlB0ElVwnEmKjpoO6QmwU8LUtdIHhTFS64Mf67KIH+2dgsaAvLwVr1MVRHOSsyJGql2ezDLxV8M4Az6bEI02rt287gH5a+R9u2WBUD47t4dX9Ok3cIpOeiexcuO3eSxPvfoe29/29MDN+zkECr8I9uHodDwQG0R3XkDoybL4YmQYeOiPZ6d5uPaJSulqubGJaXbE28PKLDVLNywxg8Fv3QxERFxiaXHrdXEbb6YL4tfRSxiFSKWvqDlLuPq4ao4HOgI6lokajRfsYizF1VSdJSoJZZexs6CkUZUDMJcyuiSCGNT5dAKv3yzed1wLPboh3pow2C9gTH8XaMU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799012|41001999006|6090799003|8060799015|15080799012|440099028|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pUtamavXRP5y9hV4LbJiAwPoExGkX36VWGiF3jKhSulpy4iYsDCcoRhZsBhv?=
 =?us-ascii?Q?8m9QoQ0/lp3f3Xht56smyBfhg4t1BVRcsgAG3K136obplsqI91SWrJ0NZ9+0?=
 =?us-ascii?Q?X3iwO6CJpe1mCb6nDhePAfvlZtjNkY0eLgv23lBaPivxdlX89G6SJ1ENHLLt?=
 =?us-ascii?Q?gU/8rVTR+8aVipzjzk6M6zpLgdcMfbfKo4RPlStKocFQaQ6WnCk+OCvGWGyt?=
 =?us-ascii?Q?fyLJ6fP8jOJTd7YcC/VUKm38NQuKKTu2A1fQZcVnCJ4tKNhQGNbPufD0NMqo?=
 =?us-ascii?Q?pTCRAHfJQOQ6zcEAf+AQNISuHXlInycjQrEIWUT/kP8i/Tu7uyy/hLeERSoP?=
 =?us-ascii?Q?ZcHJvAFKCX48QDH2Tur2/TO1oHA8HRC6aqlTQLGEq5ILWHfGwS4mZHLIz+UW?=
 =?us-ascii?Q?VcDKRZVdAj+Nqun/C9utHUGsW6GQw3AeJpcMQJQAzc+XnVtO2sNd1xMtoejG?=
 =?us-ascii?Q?L61KMUxW8YmbC98Fp1cJiK/XC4Oo+Y0c9XI6aH7RWrjO1xErd43nvmipf0Q2?=
 =?us-ascii?Q?xSJh2K5wAfBsy9LD3+BsPqVxW9mdfgOYT08/JtatXixvbSiVFAShlWWXj6Wj?=
 =?us-ascii?Q?sFQjY/jiH9JWW4+mgh9B1/b+pAwpqDNUhsSFdU7+gUz526rJ7ZU/M7tB/XD9?=
 =?us-ascii?Q?+7TVP9nxwfuLzBn1dOdXoOd6XHhTSc7/GbL3I6ZdqD8zcEIFiWrXwryKbTrX?=
 =?us-ascii?Q?FUx3+nP+sKXGsh5zS6/MeW9UviLP+0OUTGlGGqfi7AsqyoH4LmqV6EeVCx6v?=
 =?us-ascii?Q?e59nxSacFyEcko4O9fi5+QBADa48jUiln/+XViDGs1yV1ai4EmZpVr3WklpZ?=
 =?us-ascii?Q?Q4SGFfU35npakNVTrdb2fDZnCFrUDoqtSZq0MmVm8AiNyKgMqBA5CPwBv4H1?=
 =?us-ascii?Q?rcgBTZJIxJhAZCb0HK3nUKnD86ghrCjHqsIiPZKkFdifgoj6XwsO351H5Waw?=
 =?us-ascii?Q?EFuF6qOzYC9DPUNTYTv3ugtxNcFNM7T5TP1Q6WU9vO6HjFJhdmnWzmdoVuFI?=
 =?us-ascii?Q?eGbNv1KPDRNMPi4HvBtGcqzO5h9FPzm1pBsH7ywO+ePY/QmcP2s2YR5yjMus?=
 =?us-ascii?Q?NvGVeLwVJUTJ95bHKTCpXnoeiTM4X82Cy7UAt50droNj8MTb3R88KgJC3Bts?=
 =?us-ascii?Q?t6S68om0CvA5z5DU3yvQYa+MBVtFYFOtE8qLvWbsp8PwrW5Hg2Q24so=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8LaaIFIC9kCAQADmPGh+OWTR3CI2hgh8oUoy1rE99mZYvZwMmfOL7QMyw9z3?=
 =?us-ascii?Q?0A72DW0OfslDqf3z433WksPpj2rFCGV/7sh23Wi8qMvxsmC+YAn7+tOb1X1V?=
 =?us-ascii?Q?eDDjj2SJn6kId6J8mCD0q1AmNV5mIEGJF4s30zwF99K1i4uWfUyHmzrxjXK1?=
 =?us-ascii?Q?peUbKDZOe0H2oNiKoseuVz/iJNXbgLpXPXiUJIJiFqo+NdAH868rDUEgfUdb?=
 =?us-ascii?Q?PUUf4JP1jrDZACo2PivDCFrzt41W3BE0e7B/tfwwBNbrr2x1OKTS30NIIZ31?=
 =?us-ascii?Q?CEnAyP+SXnnh6Q6XD9VlpQ9JlK1xRj+Q0H5+MoaBJHHsT6eOg+4Jo/YtmXns?=
 =?us-ascii?Q?JahqEv5MIoyu4aEjzYt1uAxdOtJdttqQqRoKwZhczIiDpRd6q3jSnMzG4hgs?=
 =?us-ascii?Q?f9WxQFJpYXdycYr9cXco8mpKgWtRJvC0Ms5FfWWDiZNn6jhGCoxIsry/Xerb?=
 =?us-ascii?Q?0G9jq4whgYZe5ABgYsUe11XG7Fm7bk2kTI8l+cT1gEZYoYqARoS8qJ2W932y?=
 =?us-ascii?Q?Ze5FVW+Ldbjyif3HCqe67nZRDIdhiFo/sesC9LjnN6FRdE0dzHCz9i3t8sZn?=
 =?us-ascii?Q?NHT/LCKzt/kZKqzVvVNtJyfPXUsdLbaI7YID/yHmkw5mwAc/Du9UoNuEQezo?=
 =?us-ascii?Q?fbBQqXB6WZXhDX0JMFC1lu/NwTo0irhcnanDLOpK12m8Ktww/XMdgTb0krUv?=
 =?us-ascii?Q?OjvP7eMhqeEnMixkkZm75N+ZtDd7bogjPVsC+he3b0M1sKysmtv6IiU82ZN/?=
 =?us-ascii?Q?8IcpPi7iZLRT2YryHvI+RCulG7fEnaZFVtDjpK1rzq4vYJLSFwNEcHV/QDa4?=
 =?us-ascii?Q?dKOExjsVS37ZloeQa7jqgXhhz5wS4wla0MGjqU4eiwDTtTA+13GjlRKQzKfp?=
 =?us-ascii?Q?0/5MHukePAG6zHSvmv7u5mG5EeDTiUWveN/1LLcBU2vrA+7hQEknnJTFLTgd?=
 =?us-ascii?Q?D2hnD+RckJBWn4SDNugAqhOZiV1BlaMeye7Zqy2XCrJ79OBCuDoAAPuaLCtr?=
 =?us-ascii?Q?FZzwzKwsol5Czd2UDTiw5rwIEnytP4Z+JJVViAtJZIFDU/H/WQzEVrqurK2P?=
 =?us-ascii?Q?NI1pN7VB9dOAR7zbuSocdB8MQXHaRqff9FIlCbn6BSZM4Lr/uERv8/ryeDtE?=
 =?us-ascii?Q?zsAAjiMftdRTqImXFWLu5RzUv/RU1U6RjEfAcupgk0pr7Wm7M6r87qlTEzLZ?=
 =?us-ascii?Q?inuTVD0Y04qvRp1SLtX18iGMVFyGyWTLHuksJzu+Lsc/AfbggRzjkQKLMXI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e1d711-fe39-4d3f-c95a-08ddd1ae8ad5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB3802.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2025 10:22:54.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5951

On Tue, Jul 22, 2025 at 11:06:21PM +0100, Cameron Williams wrote:
> On Tue, Jul 22, 2025 at 05:52:28PM +0200, Johannes Berg wrote:
> > Hi,
> > So it's been a while ... is this still happening?
> I checked a few versions ago, I can't remember which one off the top
> of my head, but yeah this seems to still be an issue.
This is still happening as of 6.16.0.
> > > I have kernel dumps, vmcore dumps, whatever you may need,
> > > any help is appreciated!
> > 
> > If it still happens, I guess it might help to put some noinline
> > annotations on some of the functions involved to get a better handle on
> > what exactly is being passed. And run it in a VM ;-)
> >
I have noinlined some functions (fq_flow_dequeue, fq_flow_reset, fq_tin_reset,
and ieee80211_txq_purge) and enabled CONFIG_MAC80211_NOINLINE to get a bit more output,
but nothing is making this any clearer :(. The call trace now finishes on fq_tin_reset
but thats about it, I still can't where the bad code is getting passed :(.

Here is the crash log with those inlines, config and debug on. I am not sure if those systemd
messages are relevant or not:
[   60.485914] [     T65] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[   60.490047] [    T224] systemd-journald[224]: sd-device: Failed to chase symlinks in "/sys/bus/usb/devices/1-2".
[   60.490538] [    T224] systemd-journald[224]: sd-device: Failed to chase symlinks in "/sys/class/usb/1-2".
[   60.490912] [    T224] systemd-journald[224]: sd-device: Failed to chase symlinks in "/sys/firmware/usb/1-2".
[   60.828405] [     T65] usb 1-2: New USB device found, idVendor=1618, idProduct=9113, bcdDevice= 0.02
[   60.828746] [     T65] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[   60.829067] [     T65] usb 1-2: Product: Wireless USB Network Module
[   60.829347] [     T65] usb 1-2: Manufacturer: Redpine Signals, Inc.
[   60.829639] [     T65] usb 1-2: SerialNumber: 000000000001
[   61.051519] [    T569] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   61.060694] [    T569] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   61.065710] [    T569] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   61.134422] [     T64] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   61.135140] [     T64] cfg80211: failed to load regulatory.db
[   61.135950] [    T224] systemd-journald[224]: sd-device: Failed to chase symlinks in "/sys/class/platform/regulatory.0".
[   61.136358] [    T224] systemd-journald[224]: sd-device: Failed to chase symlinks in "/sys/firmware/platform/regulatory.0".
[   61.508902] [    T569] rsi_91x: rsi_probe: Initialized os intf ops
[   61.550349] [    T569] rsi_91x: ================================================
[   61.550711] [    T569] rsi_91x: ================ RSI Version Info ==============
[   61.551045] [    T569] rsi_91x: ================================================
[   61.551403] [    T569] rsi_91x: FW Version	: 1.6.2
[   61.551695] [    T569] rsi_91x: Operating mode	: 1 [Wi-Fi alone]
[   61.551696] [    T569] rsi_91x: Firmware file	: rsi/rs9113_wlan_qspi.rps
[   61.551994] [    T569] rsi_91x: ================================================
[   61.649118] [    T569] rsi_91x: ***** Firmware Loading successful *****
[   61.653390] [    T569] usbcore: registered new interface driver RSI-USB WLAN
[   61.674664] [    T578] rsi_91x: Max Stations Allowed = 32
[   61.681325] [    T569] RSI-USB WLAN 1-2:1.0 wlp0s12u2: renamed from wlan0
[   61.686396] [    T224] systemd-journald[224]: sd-device: Failed to chase symlinks in "/sys/class/usb/1-2:1.0".
[   61.686924] [    T224] systemd-journald[224]: sd-device: Failed to chase symlinks in "/sys/firmware/usb/1-2:1.0".
[   61.715786] [    T224] systemd-journald[224]: Successfully sent stream file descriptor to service manager.
[   79.598357] [    T594] rsi_91x: ===> Interface UP <===
[   79.602483] [    T594] rsi_91x: rsi_disable_ps: Cannot accept disable PS in PS_NONE state
[   82.100497] [     T64] usb 1-2: USB disconnect, device number 3
[   82.128685] [     T64] BUG: unable to handle page fault for address: 00000000c12f6080
[   82.129133] [     T64] #PF: supervisor read access in kernel mode
[   82.129536] [     T64] #PF: error_code(0x0000) - not-present page
[   82.129891] [     T64] PGD 0 P4D 0 
[   82.130226] [     T64] Oops: Oops: 0000 [#1] SMP NOPTI
[   82.130569] [     T64] CPU: 0 UID: 0 PID: 64 Comm: kworker/0:2 Kdump: loaded Not tainted 6.16.0-dirty #1 PREEMPT(voluntary)  01ad4c2bf7751774a8dac4ffc0ff3686a61b6778
[   82.130923] [     T64] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[   82.131284] [     T64] Workqueue: usb_hub_wq hub_event
[   82.131662] [     T64] RIP: 0010:fq_flow_reset.constprop.0+0x18/0xe0 [mac80211]
[   82.132097] [     T64] Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 4c 8d a7 40 ff ff ff 55 48 89 fd 53 48 89 f3 <4c> 8b 2e eb 0b 48 89 c6 4c 89 e7 e8 a8 57 fc ff 48 89 de 48 89 ef
[   82.132513] [     T64] RSP: 0018:ffffcdc8002f7928 EFLAGS: 00010202
[   82.132878] [     T64] RAX: ffff8a97c12f6088 RBX: 00000000c12f6080 RCX: ffff8a97c12ed210
[   82.133239] [     T64] RDX: 00000000c12f6088 RSI: 00000000c12f6080 RDI: ffff8a97c12ec9c0
[   82.133617] [     T64] RBP: ffff8a97c12ec9c0 R08: 0000000000000000 R09: 0000000000000000
[   82.133974] [     T64] R10: ffff8a97c12ed210 R11: 0000000000000246 R12: ffff8a97c12ec900
[   82.134333] [     T64] R13: 0000000000000000 R14: ffffcdc8002f7ad8 R15: ffffcdc8002f79c0
[   82.134818] [     T64] FS:  0000000000000000(0000) GS:ffff8a994c085000(0000) knlGS:0000000000000000
[   82.135216] [     T64] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   82.135738] [     T64] CR2: 00000000c12f6080 CR3: 0000000102af4004 CR4: 00000000000726f0
[   82.136286] [     T64] Call Trace:
[   82.136730] [     T64]  <TASK>
[   82.137105] [     T64]  fq_tin_reset.constprop.0+0x24/0x80 [mac80211 929346fed04d387366a55c8dfe4baff0095fbbe6]
[   82.137586] [     T64]  ieee80211_txq_purge+0x35/0xc0 [mac80211 929346fed04d387366a55c8dfe4baff0095fbbe6]
[   82.138058] [     T64]  ieee80211_do_stop+0x47d/0x980 [mac80211 929346fed04d387366a55c8dfe4baff0095fbbe6]
[   82.138493] [     T64]  ? synchronize_rcu_expedited+0x1df/0x220
[   82.138892] [     T64]  ieee80211_stop+0x62/0xe0 [mac80211 929346fed04d387366a55c8dfe4baff0095fbbe6]
[   82.139340] [     T64]  __dev_close_many+0xd5/0x1c0
[   82.139721] [     T64]  dev_close_many+0xbc/0x1a0
[   82.140092] [     T64]  netif_close+0x68/0xa0
[   82.140481] [     T64]  dev_close+0x34/0x60
[   82.140853] [     T64]  cfg80211_shutdown_all_interfaces+0x46/0xf0 [cfg80211 dd16b5aa15c7e1bea6a27abe1c3536b4e8d54dde]
[   82.141360] [     T64]  ieee80211_remove_interfaces+0x4c/0x220 [mac80211 929346fed04d387366a55c8dfe4baff0095fbbe6]
[   82.141843] [     T64]  ieee80211_unregister_hw+0x4a/0x130 [mac80211 929346fed04d387366a55c8dfe4baff0095fbbe6]
[   82.142291] [     T64]  rsi_mac80211_detach+0x29/0x80 [rsi_91x a6efdcfea87ad896e34b827cf5122ed0585a3c7c]
[   82.142691] [     T64]  rsi_disconnect+0x22/0x220 [rsi_usb e6893aa53c0a54e986015b3fc93cd4ca1a5408f9]
[   82.143331] [     T64]  usb_unbind_interface+0x90/0x280
[   82.144726] [     T64]  device_release_driver_internal+0x19e/0x200
[   82.145300] [     T64]  bus_remove_device+0xc2/0x130
[   82.145674] [     T64]  device_del+0x160/0x3d0
[   82.146040] [     T64]  ? kobject_put+0xa2/0x200
[   82.146425] [     T64]  usb_disable_device+0xf4/0x220
[   82.146798] [     T64]  usb_disconnect+0xdf/0x2d0
[   82.147195] [     T64]  hub_event+0xe4e/0x1900
[   82.147573] [     T64]  ? insn_init+0x1/0x70
[   82.147928] [     T64]  process_one_work+0x190/0x350
[   82.148304] [     T64]  worker_thread+0x2d7/0x410
[   82.148656] [     T64]  ? __pfx_worker_thread+0x10/0x10
[   82.148998] [     T64]  kthread+0xf9/0x240
[   82.149347] [     T64]  ? __pfx_kthread+0x10/0x10
[   82.149687] [     T64]  ? __pfx_kthread+0x10/0x10
[   82.150024] [     T64]  ret_from_fork+0x197/0x1c0
[   82.150392] [     T64]  ? __pfx_kthread+0x10/0x10
[   82.150770] [     T64]  ret_from_fork_asm+0x1a/0x30
[   82.151120] [     T64]  </TASK>
[   82.151560] [     T64] Modules linked in: rsi_usb rsi_91x mac80211 libarc4 cfg80211 rfkill vboxsf intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel kvm snd_intel8x0 snd_ac97_codec ac97_bus irqbypass snd_pcm vfat fat polyval_clmulni snd_timer ghash_clmulni_intel psmouse snd sha512_ssse3 video sha1_ssse3 joydev e1000 mousedev aesni_intel soundcore vboxguest i2c_piix4 wmi pcspkr rapl i2c_smbus mac_hid dm_mod loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock bpf_preload ip_tables x_tables ext4 crc16 mbcache jbd2 vmwgfx serio_raw sr_mod atkbd libps2 cdrom vivaldi_fmap ata_generic drm_ttm_helper i8042 intel_agp pata_acpi ttm serio intel_gtt hid_generic ata_piix usbhid
[   82.153690] [     T64] CR2: 00000000c12f6080

Thanks again for the help.
Cameron.

