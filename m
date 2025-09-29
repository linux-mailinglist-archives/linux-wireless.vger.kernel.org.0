Return-Path: <linux-wireless+bounces-27711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A9BAA28D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 19:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6324E19231AE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC57830101A;
	Mon, 29 Sep 2025 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=countingcars.onmicrosoft.com header.i=@countingcars.onmicrosoft.com header.b="BrTUySjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023091.outbound.protection.outlook.com [40.93.196.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDEC2EC561
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166659; cv=fail; b=H2WhgiyNe/y4eAEAncHll4ZUzOknKWGHJhbaWzcIz3jAmPidsKLJ/NkjPpaalokg5re1HZ0xaurlpUJAOeOYIloKOz4ltne0SpVnD3rAfCf/94nnEXS3+YhpyzfFCo+OqWmu7M5XavwAtcM97EEGd3RqvvlmoaO2T0vyPI65cRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166659; c=relaxed/simple;
	bh=Tc+cawo7BR+W//wt6mVNSsuy+1Bfb2jkb9JAsqdvTuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lRwo1i9oAvdCuQlU5ftES6rPv8VUXpbiS8GodaSH6LOf/CDBaQuwfMOQwJSkvLDR5dmkMXkHws6uk98sA/Y9pN6z1m6w7Yz+coXOdZKKKHk4Hc9xIbbMTTqtKHVA1chGYeYVycS88VveNIhLDdHcrAFA7QIeg/jQE78JR/O8szo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streetlogic.pro; spf=pass smtp.mailfrom=streetlogic.pro; dkim=pass (1024-bit key) header.d=countingcars.onmicrosoft.com header.i=@countingcars.onmicrosoft.com header.b=BrTUySjy; arc=fail smtp.client-ip=40.93.196.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streetlogic.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streetlogic.pro
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUXGtnIoAo3LWzxX3aYPQ097bIZj9RjdeKwgOkKSjJZ/eQvdbQKliroNT6UEI8XeP27ILo+5vK0yP/YzcNrgZu0GKRMuMT1LdgnJi+Zj4Xg7eAEOtqU8yRI2Kja77V5Zsu5FM2cfMVO80AJbAq0CrRBH8nZolzAMu0BMtCpXohpC9f4BLmL4W5MJHloXEHHDAn0fRinJvpHBEHNaQ1M3aagceGWIKJRh6fWXq72wh9+J1O9lGngwJsFAxh8XIQ5GKAhwE729UE/WP3ak1taAleUitPLWR8l4cBH1FyebGA+6lgr0glfVziyOxP4D5hc99XFrW0dD/wgtVEMF7egH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDaCAqup9HbaMbxVO3SN1V0pihE4e5T6cZXV27OXsmo=;
 b=gLRi2CsyxhDpZ57M+STyUObMqDgvVZC63wmEGlt61+THhTgapIu3y5W8YolvRIC2VcLiVkw+yumcFaA56/nvhuxyv9qXqtKFmra5vTSQpIxjG7kbguS5ec9pWS/FWMYRcJ5plfG4M/33mM/KySBZf7J0cVdpha0KcNx5CuDO76EVRgUjg/gsaILiszkVS5us6x+qLvPd5G4Dpk/D+4ODi3Jhf5g4KFRiD5gi0ePKlH0rhF3qPJ50GSUQ6UJKMjAyDOMQQGem2adEpFv290LIIAbxIAMwCUI4gB+VpFBDnqrO+HaqBUdKrCyMCgCrmKr9tV2087F/E3bp604Yguri6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=streetlogic.pro; dmarc=pass action=none
 header.from=streetlogic.pro; dkim=pass header.d=streetlogic.pro; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=countingcars.onmicrosoft.com; s=selector2-countingcars-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDaCAqup9HbaMbxVO3SN1V0pihE4e5T6cZXV27OXsmo=;
 b=BrTUySjy2tIY0DIILvg2KolUCGzoUDbJDobMl/dAgi3jDm+icdoCgH8mbZG48OtdhX6iXDSEnEuGWuy9VHFAZSKwHt5614EGJQc3lY4kP3D6xg7ONIBMzpIHUBYSq3sl44DGynBBLXb0hvyAFB3sZzM+XKrrjvwsFGCavsGVf14=
Received: from MW2PR02MB3674.namprd02.prod.outlook.com (2603:10b6:907:e::30)
 by DS0PR02MB10917.namprd02.prod.outlook.com (2603:10b6:8:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 17:24:13 +0000
Received: from MW2PR02MB3674.namprd02.prod.outlook.com
 ([fe80::adc9:8462:2a75:d483]) by MW2PR02MB3674.namprd02.prod.outlook.com
 ([fe80::adc9:8462:2a75:d483%6]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 17:24:13 +0000
From: Chris Spargo <chris@streetlogic.pro>
To: Stefan Wahren <wahrenst@gmx.net>, Hsien Chou <s311332@gmail.com>, Arend
 van Spriel <arend.vanspriel@broadcom.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>
Subject: RE: brcmfmac: driver crash with iOS 18.6.1, potential DoS
Thread-Topic: brcmfmac: driver crash with iOS 18.6.1, potential DoS
Thread-Index: AQHcMKYY+EaaT/7OI0GjH7ZdX8EvxrSqZX0AgAAB0GA=
Date: Mon, 29 Sep 2025 17:24:13 +0000
Message-ID:
 <MW2PR02MB3674EDA6ED6DE4FC1D74AD75B51BA@MW2PR02MB3674.namprd02.prod.outlook.com>
References: <1a187bdb-abd6-4e2c-bc29-94f9ab944023@broadcom.com>
 <fd88175f-497b-4fec-9094-58709ddfd1bf@gmx.net>
In-Reply-To: <fd88175f-497b-4fec-9094-58709ddfd1bf@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=streetlogic.pro;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR02MB3674:EE_|DS0PR02MB10917:EE_
x-ms-office365-filtering-correlation-id: 3e049a4b-3865-4f0b-5db4-08ddff7d0287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XF0Zwu/+ltMV1ZPdLpZrVoVRcU0Z0QqtfzIJ6Tn7WPoWVDAOeDGxXEqhbiEp?=
 =?us-ascii?Q?2WmLIEFZXr9d9cOg2PpI8QJLK6E9oQF+GEfxqFTNTF6y+l5THxM58Pfdo9l2?=
 =?us-ascii?Q?ZDo6ib5nUYdSr+kH4sjJo/CGprpA5cGGlc2FT75aWr9u0YkzlAbguhpVKFrQ?=
 =?us-ascii?Q?cA3EEdCGL4TbG5DdpagkzYEMt9btNxsbZrdUnQZwlR0Qda+1LXrCGPUqMZtU?=
 =?us-ascii?Q?7Reqf07BovvWnQszJHoue3H9bJD4C7Unde6+qMWnm9TYRgBxQPOAw4T+/vF8?=
 =?us-ascii?Q?cT8GnHHSCT+z9shUetIFLYyd5TIloYf/Vnwb0VZGHZeiR8Rvm8SiNrPlYJ+H?=
 =?us-ascii?Q?z058sI6PL/uUCgF8ycsOD8CfQfZESPameTCshUCoyCb1jmDmxOFzTIIN72hP?=
 =?us-ascii?Q?v0rnnUrsoD/Nk6FUw/4Dl5TknBUlxbSO9ENp4NXlndJHQ/Iihm36UHpn+QSQ?=
 =?us-ascii?Q?5cn6DX1NM1JxSvihYTBxvkRh5lwKMiQ1EHZIe+LYnB5CDSlroFHrIdETxdt5?=
 =?us-ascii?Q?4NxaKK2WqK29hIiCukYWWHXdZtJxnrm60BooVgBE/CEVlttmAPJq7wuxA7F0?=
 =?us-ascii?Q?TWDzn8rdF/FbXF8cnuzyySMv9pfMIyt9DAc8hlJJ5froLdI2Pq5Op4IDlF3J?=
 =?us-ascii?Q?TCAWA3xgLR4W4sIf/3ZOefYMf6/YsWbZ89SHIdKD/l4+gxFW8RZhPIGvruN0?=
 =?us-ascii?Q?Ow79ISbheQgbRpzwr6v+xxWpNbmdk+bRqvn2Het1gdfRiigXzoi4RVkJ+rYQ?=
 =?us-ascii?Q?MqbQ/np7vz/QazpNrQQmEaAP8ml1k1LrDF1WnxoHbPx4uVyneU7n8sGlVDPA?=
 =?us-ascii?Q?9GUtuhflcu2+zuW1LVUGKtDdUjMhOJsy4HrEk0KL6unHYYEFFSwsL8ZBnLw6?=
 =?us-ascii?Q?WjJpiV0Q8952IV82MiTxV3UxQJAM2wxZb1y+gfVNK9nKdIZK6TvKy9PapBUK?=
 =?us-ascii?Q?PkBZYaxkIZEEw5/ElN1dDxHqHAfMGidWbVXhuh/61l697kTH6TRKQs7+wVzd?=
 =?us-ascii?Q?66U7K+DgL6MTglS73VulxdDl4m7wrSNg+KADJ8HwjPeIICKWDm+2dKMOKcRw?=
 =?us-ascii?Q?JVkDhqOBycQhGgXeqmWmtJvyaqQjqJSlxAF9Rhp1/bNsP7uC7o7102vxX5jc?=
 =?us-ascii?Q?H8y6jco7BXjTVGt3MN0Z4DHvmDmUxd6ZiORUs8m3rZeQNlEKadpscaacncxt?=
 =?us-ascii?Q?4jSoMRh+mnHtqrVLDVaPwva4QxeQXMTv65kP/zC01Bfhw9hgJxxM4VuPBsNL?=
 =?us-ascii?Q?HssQKkp1YxWxZyTvrVBBt+/NAt8a9In/Zmy8qIUYUtiK4gfELjJomeJ17sgm?=
 =?us-ascii?Q?wOLuRSg1u50HoJplGtrD22K7IHS/Z9P3a37k0PhsNNYPA+4Rih9Xk+SfvkQY?=
 =?us-ascii?Q?UCwwk13gGEkR4mMrmBh83zFK7ofngDgu2zpOJUYQDVk+4v9bSv5g1KYkMuPB?=
 =?us-ascii?Q?7bAfadSPMrntqpbGh1F5/Wuu0WVMWSHZaqhHIryDqkrSquSfJdyC2DX2Gb2E?=
 =?us-ascii?Q?ehdIEMjYtBuT5yDp8yOf2+cM3fHpiSzDFZri?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR02MB3674.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fVHo9FfjzSy6StyCZqi5JBcoF+bqWsZAJPjl72zwtqYtNVAnOG4vgmPXer+C?=
 =?us-ascii?Q?66GpGTN4oDKFWaR8sgIjddN3PQqMPW7H4tZrcFn8rVWamsLXDTkN3MQxbyBa?=
 =?us-ascii?Q?PIiEFN1hY7LTdj4ZHfKYNeZDLpxP8pgZ8AMGI1mHLHJ0xr81eJPxvwLhHR+f?=
 =?us-ascii?Q?J4ZrMMk9wPBv+mFi4+kMXOAVhLPYCT9D8gAO6KqXwmsO6G1W5tpmMc+ITFfs?=
 =?us-ascii?Q?clJbnbDg1amM4MibFHAUIjAyqJ6xsvt527xFD8dbh9WMhTCATZR4Q/BS/7Gk?=
 =?us-ascii?Q?kKz6OUvsDH/3a8uBvWGPvBvaSqjPUV6YLPeBCf6wPvyvfyCsoV4X8QYzLx3x?=
 =?us-ascii?Q?Iz40Gp6++MjSqU2CBr1mNImOFQ4uMbcA8i+VhIlG+w/zvs7bq0WDl9XLNYK8?=
 =?us-ascii?Q?hDRLUg+yYGLRF8m8aD5fX57xhBKAqP+2jjpoikaky7OsQ32jtqOkNvmG8a+z?=
 =?us-ascii?Q?b6Htf3C8T+wtYm+oCmu/V/BZCMYcBdAv9a1cffiJ09Zfd/pbzH001TxoNBrG?=
 =?us-ascii?Q?STs/+WqnfOmlSs8BUIthpiuwRcMdIDZnBicqg1Ds//4WS2MO6Bo4MgLgNXCw?=
 =?us-ascii?Q?Rkz5KKZy7aTmAoXzoMWf2VUEikk8+EkXRl+DJD3ZWV9VeKR54KGGrBRIJhgI?=
 =?us-ascii?Q?HMcPRjNM7KGX/VgsR881r+4oApOTlyvBGYrr63NtYjlaEka/ECq+9BUKwGgD?=
 =?us-ascii?Q?dGnTucz+55Vikw4RJPrVzdBJ5P7sk40VyArKhFjZ8aIdFIsyKZSvxyfOhMJZ?=
 =?us-ascii?Q?9mcL8aW0554b0GQPWj77qVjLedhdhZ+kjNAY/jaCgeaSWvlVSNj3Sywm/V2Y?=
 =?us-ascii?Q?EnYdoMYUEfZZiw/qh/uhxwfJzJWsONpegcJYDktdQJdgg2bNywDwQvxFQIsX?=
 =?us-ascii?Q?OGjRcXDHYIUoKw4LjySSdYJbyLTAOfBwAk0zm8IeXG1L/OF037qmQkLjr599?=
 =?us-ascii?Q?ddmGlThUwmSu657zkGev9TmKGB2QQRFxRXA6/5GYob3oKuhO0p1DYrWAHsJp?=
 =?us-ascii?Q?QGcKX+eSf6wkWj0msv+eulk4Rl7faCzr2p77BnpO3+dvhR5HR1uhb1Sw3npS?=
 =?us-ascii?Q?E3rCdIGH1F5z7dX/T+pjVAyAjNxorYXB1GsLHSKUzy20DS4sFuMR0bzTx5f4?=
 =?us-ascii?Q?jKRuuxOs7LaWvJVhr8JLI+jwyZUZ0SuR5IX34xVP1nskQfAocL9UYWRwPpfn?=
 =?us-ascii?Q?41FlRPmrjfSh0xEDz1OkTZIg0YYeUJEDHIMscymFzBnozSRQF0rNgB/IBrf7?=
 =?us-ascii?Q?uJKuvx+UUYmgzxTuXn3ucWU6PjZlXBiQ3F/JfVkPZdeiKd/BxuhMtgJvk04C?=
 =?us-ascii?Q?C5hNcIPsA30owQzU5UY2BVMu2s51RmjL2QTyDJK8cDA0cSJTfrZaiivL1fLe?=
 =?us-ascii?Q?d5WJRikMtxacPI9eELXouQhi/kYEa1wxO4zXodWsM7tOlWsM2vdNHMUm78Fu?=
 =?us-ascii?Q?q1pEFzZP0GBLspbfClBofQDMc+QFLSS41osNAt4T7xLmkMn7C5gR3udxtoTE?=
 =?us-ascii?Q?fh/UNWBTf5g5VEZ/K+2YLJLfCHfzLnVEYvXyKG42ttkWi1WeOpAJl5G5XZ2b?=
 =?us-ascii?Q?ZUICkM8OCPzGDeWvqGYj+sigj+xUup7mh+Fab74l70rS8HiUWBp4lktE9O6z?=
 =?us-ascii?Q?gyKePZSCRqQpatv1ElN533ANdFCe2DEGCPz6FZ7Wsg1+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: streetlogic.pro
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3674.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e049a4b-3865-4f0b-5db4-08ddff7d0287
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 17:24:13.4304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da4745ef-da8d-4b22-b0f4-eafca8feef17
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PN2k5vuqO5ykyGIy7kIXTkdRdz+vqFJTLGbqEEjGkkpeU3muu1+s/F3fqAzPeycHy+vWzCugVNfmRAwr8ACVqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10917


Our experience is with kernel version 5.4.83-v7+.    I've not rebuilt the k=
ernel or worked in that space for some time.  =20

I'm happy to follow directions and give specific examples and feedback if t=
here's something I can test, but I don't want to cloud the results by not k=
nowing what I'm doing.   Let me know how I can help.

Thanks-
Chris


-----Original Message-----
From: Stefan Wahren <wahrenst@gmx.net>=20
Sent: Monday, September 29, 2025 12:06 PM
To: Hsien Chou <s311332@gmail.com>; Arend van Spriel <arend.vanspriel@broad=
com.com>; Chris Spargo <chris@streetlogic.pro>
Cc: linux-wireless@vger.kernel.org; brcm80211-dev-list.pdl@broadcom.com; br=
cm80211@lists.linux.dev
Subject: Re: brcmfmac: driver crash with iOS 18.6.1, potential DoS

Hi,
regarding reproducibility, I would assume Arend is using the mainline kerne=
l and Hsien just tested the Raspberry Pi vendor kernel. The brcmfmac driver=
 has some modifications downstream.

@Hsien or @Chris,
are you able to reproduce it with a mainline/torvalds kernel?
You only need to replace Kernel, Modules and Device tree.

Best regards

