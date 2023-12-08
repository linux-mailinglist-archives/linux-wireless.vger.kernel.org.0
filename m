Return-Path: <linux-wireless+bounces-585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C3A80ADED
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 21:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F202818A9
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 20:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536E57891;
	Fri,  8 Dec 2023 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Urff3LyP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2074.outbound.protection.outlook.com [40.92.41.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD31985
	for <linux-wireless@vger.kernel.org>; Fri,  8 Dec 2023 12:34:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch6DtKwIZBCwoGPwTwErbopnBbV6T6ZDLDU7EXMrGA/EoaNfO9PJ3TWara5w93Lok78FNmbG9H2cqjyqoqMUadjoTaXtfuboA0ikLPtrX844+RWiIO07vyuKPHA9bWp/XgTvIzVfChD65vg4xSdLH/AJCo6R3jVwW54Y0uCmuoIYvbw/BGLG2tyKz5G3/9FPCoP1sRAiLUS5jHmQF0y2Mfg+fP5PGE0kFXfHQTgr1l9YNq0QPxD6m3jOdciOFsUAnjrOsDNpaHkxPBlWOEAcCqgSkYtk+fwrzzNOllIKQkyMgJCIBDvkQSBZWzGkgrcDAGb5TbOq4Og0aiNxCSwLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKTFX3JFNh8IQZtE/eJcUnzCJtjR1gM/07VUJjPmbRU=;
 b=Mi4Re+niaMXRI7WB83yocZoNaThKUzDDzJ23mhKaSfwURuAEZukpZxL0a0gBDdElRSwRCJZpcCh4RD9fBCTU+FPx9h3YVsrVG3PVxhEO+E75llpdkmeAKHt/SBi5HC7IImZhoixBnezvhx8j0YaAC7auRuBnCp5zrKq2o4FMsoG6z9xIEGEfPq5XaQkqKJLCBYNGR1JFirHR4tNR1vsttjzmcid4EOnxgIrdW8pbGlVmSXY1QfVwE56c/d7mr4X7ouEblT6+5mN6/aBltCbHQsr57DLsgIdWwG3RChxatXqXh2HAbnvNJpibMnyVTBjf+H8p+0PV7RDtHv1Sb6w6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKTFX3JFNh8IQZtE/eJcUnzCJtjR1gM/07VUJjPmbRU=;
 b=Urff3LyPdG6Go2gu4aaPqPYNdgicHSYnFQqC7SDMNxKqyNlEFY+uV9fYtZnPuJXJS43Xcaj1LOlzyWJXG8g39dKOvimGmAvkl0fYOFtEEAPzwKSs+v4T0KKH4qxZ5vtIdz6aP+gCcSMb4zYTr4wpXRnDvGFFgICc0NZup8tHQ6dHHf12QD6y/teH00Ympd5Hpur15eBxarD+rmggvF9pG4mLBNeKwHeGivmlbFEuvofBmiZLSKyhrWviQUJ76gxGt2UhcJBqtsl8DBpC5ybJ0I6CBA0CIu1BUwBYjVbTGfECjkMiC60bbv55kgH4fQNGsVu2RsYtuH/c5dpVymyeQA==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by SJ2PR06MB9353.namprd06.prod.outlook.com (2603:10b6:a03:562::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 20:34:04 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::3fca:a39b:c9d2:c834]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::3fca:a39b:c9d2:c834%2]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 20:34:04 +0000
Date: Fri, 8 Dec 2023 14:34:00 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-wireless@vger.kernel.org,
	kvalo@kernel.org, pkshih@realtek.com
Subject: Re: [PATCH] wifi: rtw88: Use random MAC when efuse MAC invalid
Message-ID:
 <SN6PR06MB534274E463B81EE0331294C0A58AA@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20231208150739.129753-1-macroalpha82@gmail.com>
 <c06e862c-e5b7-4459-aaed-4f69c3881b84@lwfinger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06e862c-e5b7-4459-aaed-4f69c3881b84@lwfinger.net>
X-TMN: [A/S0zPVYzU6wmrxXGFXy6iJlpfiYj7Y/]
X-ClientProxiedBy: SA0PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:806:6f::32) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZXN9uJ/RijFbIY+l@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|SJ2PR06MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 40273901-5985-4739-3f71-08dbf82d0433
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4npbQQTmuaaNcatUDnXtiq4UPs4p8zBX4gnjb/pP0t//vlfuvTkl9/zLDMTfcxVate5HFFNUX8q7AQoHloPs8Qse2afx2XAYz1J1bZDjKPnqn3M9ca6Krw7qtd6dSUU9+Z2YlmtowU0W3QQFzE9De69OCFj0CDoCtNE1PA4fDEpDTDhwcPoPoB/Jy6m+N5qx5r2eoYGScMR1/hwhlaX4Hd5JdbEUdBzQIHMqotcHkBt5BY69cgGFFmM481RSntGq6x9pX1pbsFVaHwsAEIOVv03fifmPt0vxQ8x/AU4X8Kn+ocS7Y1As8U+os/a2EY6CEaJ7hFY1FE0zzBluUmURJqM0uFfh+oNcYdCSwabxi8dajY182get+VpmYPmJNRutmnM98vEB9z869vX1/BsbnMPSaR5+xLvCVWMkuMqm91Tqtzm9JB1adnCd7qUzKhEEdTlMnb58Ti4L3TwYKLOJekxp25b3TlZLDs3iBjFuXpUaLWNVLDP5JD/tIOOJN725NI/kax9OwaNXPFPlq1Lwbn4tw9eJNUFeDDXa4cs+nVrS4wX7HCAI0tMUnKbwgfG8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qzvjLo1LuEL5MN8gyXDpxaHXkxTglDWdkvxpb7JYwIF/jM6bMNipNzUE9jKa?=
 =?us-ascii?Q?5WelIIEbCa74gyrUo+EBcLlAjkG/+jNW5kZZvgC70kgO8iNAKQjgHOeE2tZm?=
 =?us-ascii?Q?TPzSP5PI2aa1scVpK+hf6CPEeszfoIGNE0tArUFrOLIsGACnlu4iA9/0o98e?=
 =?us-ascii?Q?jXs3NK9oOWLEdJlhTqXgoRMiHnknpvBZGUCBQo9Lkb/NQgre1K4KOeRNesaU?=
 =?us-ascii?Q?MIO+oQuldvDORij41KRrBIn+r3ghqvst3eails7dtdn5TV4P8twz6EyIJJuc?=
 =?us-ascii?Q?0MnXqJSAAc5phVTgMK10rgi/VehRA5LL+h5J44gbRsJoyc8WN+SxEjGmqnmT?=
 =?us-ascii?Q?7PXRLGWjbHQur7FEt447mrQgEdtx8w8Qncyy/CX9CIPvHpuG2/PCy+nXXvrG?=
 =?us-ascii?Q?jfDRiFk89E4p9x8pr0uZTfjbQRlEZxTFC0w7eMZrtQJeySI7Lfx6lUqz6y3n?=
 =?us-ascii?Q?lsawTvIdYRUwfj3hTKFIY8MlqwifJKGHRTIBDgSqLH45JNZrg/Mn3C/hUQBn?=
 =?us-ascii?Q?76ftyZtlkEDgzMOUMb8mA/RBN23h3mO5v+xllbZ+Kj801GmOivBd6/LXaAKH?=
 =?us-ascii?Q?G5Q3PIcnC9ObzTZNv/4NeIQJJbMGYu0AhipNxtTUkaTxfmCQkNi96deWjXQk?=
 =?us-ascii?Q?he4gZqbf+A9+2RLe1XRnwwlLsDycp2jSgzXRdiKpGWFK581+34d0EKYCj7ib?=
 =?us-ascii?Q?Go2LEmagVu0Xt+s801jEIpgBlFQLvOfXTxgbimG4cM54AX0uTC367D7hpQIX?=
 =?us-ascii?Q?z5Z/HckJ3A5RP0XmEP0RbFxU4cP9nVzkBAuUuEitYyFLT5WtmuoADy4kLlJ9?=
 =?us-ascii?Q?TL803mT+A08mXoLNni/T3XwXW/N0XC/wH5Ggrl3+0iSZfeTi4cF47TsPWUFx?=
 =?us-ascii?Q?/apzxv+Oxx9//uqbnMXDdIc4PpR6/8Sf21M653WHsI+XYERnJvXmmYZ7ouRR?=
 =?us-ascii?Q?tCsBPits/cMyT0HAYQdoO+jtwXQwYwRqq5yINt16OVc4so+FNBu5rOfPnd8K?=
 =?us-ascii?Q?b3qObM6l9/7B2vjjNxF3H4GnWAPVsk/3jQCPfS+bKgGFJXicPj9cSssvcAw0?=
 =?us-ascii?Q?vmcghqB5v9cTj9F83V1LEJi0gzcgflktSyMSLnWG5CUdv6LgiioDVupIyvJ8?=
 =?us-ascii?Q?8KLAwBQ72264RP0sl11titACoYkA4PqcrbSllNejatdaOCSM2UdG9Z4/xxb2?=
 =?us-ascii?Q?3k9H6Iis2Jm7u1LVwe29wAYTT6vGHaeteLAR5oQC6gN2u4bWx9/xJ/rPTYQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 40273901-5985-4739-3f71-08dbf82d0433
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 20:34:04.5245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR06MB9353

On Fri, Dec 08, 2023 at 10:17:00AM -0600, Larry Finger wrote:
> On 12/8/23 09:07, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > When the MAC address read from the efuse data is invalid, warn the
> > user and use a random MAC address instead.
> > 
> > On a device I am currently using (Anbernic RG-ARC) with a rtw8821cs
> > the efuse appears to be incompletely/improperly programmed. The MAC
> > address reads as ff:ff:ff:ff:ff:ff. When networkmanager attempts to
> > initiate a connection (and I haven't hard-coded a MAC address or
> > set it to random) it fails to establish a connection.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   drivers/net/wireless/realtek/rtw88/main.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> > index 4a33d2e47f33..6d22628129d0 100644
> > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > @@ -2008,6 +2008,11 @@ static int rtw_chip_efuse_info_setup(struct rtw_dev *rtwdev)
> >   	efuse->ext_pa_5g = efuse->pa_type_5g & BIT(0) ? 1 : 0;
> >   	efuse->ext_lna_2g = efuse->lna_type_5g & BIT(3) ? 1 : 0;
> > +	if (!is_valid_ether_addr(efuse->addr)) {
> > +		eth_random_addr(efuse->addr);
> > +		dev_warn(rtwdev->dev, "efuse MAC invalid, using random\n");
> > +	}
> > +
> >   out_disable:
> >   	rtw_chip_efuse_disable(rtwdev);
> 
> Reviewed by Larry Finger <Larry.Finger@lwfinger.net>
> 
> Thanks for this patch.
> 
> There are a number of SDIO devices known to me with improperly coded EFUSE
> values. It seems that RTW8723DS chips perform poorly even when given a valid
> MAC address. Is this also true for RTW8821CS chips?

The RTW8821CS I have in this specific case doesn't perform all that
well, but it also has sub-optimal antennas. I'm not noticing any major
performance difference between the devices with a valid MAC address
and the device I have without one. They're both pulling about 8MB/s
over scp on a 5GHz 802.11ac(ax wifi gateway) network.

Thank you,
Chris

> 
> Larry
> 

